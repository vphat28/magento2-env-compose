<?php

namespace Stripeofficial\Core\Gateway\Http\Client;

use Magento\Customer\Api\CustomerRepositoryInterface;
use Magento\Framework\Exception\LocalizedException;
use Magento\Framework\UrlInterface;
use Magento\Payment\Gateway\Http\ClientInterface;
use Magento\Payment\Gateway\Http\TransferInterface;
use Magento\Sales\Api\OrderRepositoryInterface;
use Magento\Sales\Model\Order;
use Stripeofficial\Core\Helper\Data;
use Stripeofficial\Core\Api\PaymentInterface;
use Stripeofficial\Core\Gateway\Config\Config;
use Stripeofficial\Core\Model\Cron\Webhook;
use Stripe\Refund;
use Stripe\Stripe;

class ClientMock implements ClientInterface
{
    /**
     * @var PaymentInterface
     */
    protected $creditCardPayment;

    /**
     * @var CustomerRepositoryInterface
     */
    protected $customerRepository;

    /**
     * @var UrlInterface
     */
    protected $urlBuilder;

    /**
     * @var Data
     */
    protected $data;

    /**
     * @var Config
     */
    protected $config;

    /**
     * @var Webhook
     */
    protected $webhook;

    /**
     * @var OrderRepositoryInterface
     */
    protected $orderRepository;

    /**
     * ClientMock constructor.
     * @param PaymentInterface $creditCardPayment
     * @param Config $config
     * @param CustomerRepositoryInterface $customerRepository
     * @param UrlInterface $urlBuilder
     * @param Data $data
     * @param Webhook $webhook
     * @param OrderRepositoryInterface $orderRepository
     */
    public function __construct(
        PaymentInterface $creditCardPayment,
        Config $config,
        CustomerRepositoryInterface $customerRepository,
        UrlInterface $urlBuilder,
        Data $data,
        Webhook $webhook,
        OrderRepositoryInterface $orderRepository
    ) {
        $this->creditCardPayment = $creditCardPayment;
        $this->config = $config;
        $this->customerRepository = $customerRepository;
        $this->urlBuilder = $urlBuilder;
        $this->data = $data;
        $this->webhook = $webhook;
        $this->orderRepository = $orderRepository;
    }

    /**
     * Places request to gateway. Returns result as ENV array
     *
     * @param TransferInterface $transferObject
     * @return array
     * @throws LocalizedException
     */
    public function placeRequest(TransferInterface $transferObject)
    {
        $body = $transferObject->getBody();

        if ($body['TXN_TYPE'] == 'refund') {
            return $this->placeRefundRequest($body);
        }

        if ($body['TXN_TYPE'] == 'invoice_refund_only') {
            return $this->getRefund($body['TXN_ID']);
        }

        if ($body['TXN_TYPE'] == 'capture') {
            return $this->placeCaptureOnlyRequest($body);
        }

        if ($body['TXN_TYPE'] == 'authorize') {
            $capture = false;
        } elseif ($body['TXN_TYPE'] == 'authorize_capture') {
            $capture = true;
        }

        $customerStripe = null;

        // Try to get customer id from database
        if (!empty($body['CUSTOMER_ID'])) {
            $customer = $this->customerRepository->getById($body['CUSTOMER_ID']);
            $customerStripe = $customer->getCustomAttribute('stripe_customer_id')->getValue();
        }

        if (empty($customerStripe)) {
            $customerStripe = $this->creditCardPayment->createCustomerToken($body['CUSTOMER_EMAIL']);
            $customerStripe = $customerStripe->id;
        }

        // Try to save id to customer object
        if (!empty($body['CUSTOMER_ID'])) {
            $customer->setCustomAttribute('stripe_customer_id', $customerStripe);
            $this->customerRepository->save($customer);
        }

        try {
            $response = $this->creditCardPayment->charge($capture, $body['STRIPE_TOKEN'], $body['AMOUNT'] * 100, $body['CURRENCY_CODE'], $customerStripe->id);
        } catch (\Exception $e) {
            throw new LocalizedException(__($e->getMessage()));
        }


        if ($this->data->getDebugMode()) {
            $this->data->getLogger()->debug(
                'API call',
                [
                    'request' => $transferObject->getBody(),
                    'response' => $response
                ]
            );
        }

        return $response->jsonSerialize();
    }

    /**
     * @param array $body
     * @return array
     * @throws LocalizedException
     */
    protected function placeRefundRequest($body)
    {
        if (stripos($body['TXN_ID'], 'src_') === 0) {
            return ['object' => 'refund', 'id' => $body['TXN_ID']];
        }

        try {
            $response = $this->creditCardPayment->refund($body['TXN_ID'], $body['REFUND_AMOUNT'] * 100);
        } catch (\Exception $e) {
            throw new LocalizedException(__($e->getMessage()));
        }

        return $response->jsonSerialize();
    }

    /**
     * @param array $body
     * @return array
     * @throws LocalizedException
     */
    protected function placeCaptureOnlyRequest($body)
    {
        try {
            $transId = $body['TXN_ID'];

            if (stripos($transId, 'src_') === 0) {
                /** @var Order $order */
                $order = $this->orderRepository->get($body['ORDER']->getId());
                $source = $this->creditCardPayment->getSource($transId);

                if ($source->status == 'chargeable') {
                    $this->webhook->handleSourceChargeable([
                        'object' => [
                            'id' => $source->id
                        ]
                    ]);
                } else {
                    throw new LocalizedException(__('Transaction is being processed. Please check again later. Invoice will be create automatically when we confirm the payment'));
                }

                $chargeId = $order->getPayment()->getAdditionalInformation('base_charge_id');

                return [
                    'status' => 'succeeded',
                    'object' => 'charge',
                    'id' => $chargeId,
                ];
            }

            $response = $this->creditCardPayment->capture($body['TXN_ID'], $body['AMOUNT'] * 100);
        } catch (\Exception $e) {
            if ($e->getStripeCode() === 'charge_already_captured') {
                return ['id' => $transId, 'status' => 'succeeded', 'object' => 'charge'];
            } else {
                throw new LocalizedException(__($e->getMessage()));
            }
        }

        return $response->jsonSerialize();
    }

    protected function getRefund($id)
    {
        Stripe::setApiKey($this->data->getAPISecretKey());
        return Refund::retrieve($id)->jsonSerialize();
    }
}
