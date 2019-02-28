<?php

namespace Stripeofficial\GiroPay\Gateway\Http\Client;

use Magento\Customer\Api\CustomerRepositoryInterface;
use Magento\Framework\Exception\LocalizedException;
use Magento\Framework\UrlInterface;
use Magento\Payment\Gateway\Http\ClientInterface;
use Magento\Payment\Gateway\Http\TransferInterface;
use Stripeofficial\Core\Helper\Data;
use Stripeofficial\Core\Api\PaymentInterface;
use Stripeofficial\CreditCards\Gateway\Config\Config;
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
     * ClientMock constructor.
     * @param PaymentInterface $creditCardPayment
     * @param Config $config
     * @param CustomerRepositoryInterface $customerRepository
     * @param UrlInterface $urlBuilder
     * @param Data $data
     */
    public function __construct(
        PaymentInterface $creditCardPayment,
        Config $config,
        CustomerRepositoryInterface $customerRepository,
        UrlInterface $urlBuilder,
        Data $data
    ) {
        $this->creditCardPayment = $creditCardPayment;
        $this->config = $config;
        $this->customerRepository = $customerRepository;
        $this->urlBuilder = $urlBuilder;
        $this->data = $data;
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

        return [
            'object' => 'source',
            'id' => $body['STRIPE_TOKEN'],
        ];
    }

    /**
     * @param array $body
     * @return array
     * @throws LocalizedException
     */
    private function placeRefundRequest($body)
    {
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
    private function placeCaptureOnlyRequest($body)
    {
        try {
            $response = $this->creditCardPayment->capture($body['TXN_ID'], $body['AMOUNT'] * 100);
        } catch (\Exception $e) {
            throw new LocalizedException(__($e->getMessage()));
        }

        return $response->jsonSerialize();
    }

    private function getRefund($id)
    {
        Stripe::setApiKey($this->data->getAPISecretKey());
        return Refund::retrieve($id)->jsonSerialize();
    }
}
