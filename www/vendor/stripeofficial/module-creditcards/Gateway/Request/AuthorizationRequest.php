<?php

namespace Stripeofficial\CreditCards\Gateway\Request;

use Magento\Customer\Api\CustomerRepositoryInterface;
use Magento\Payment\Gateway\ConfigInterface;
use Magento\Payment\Gateway\Data\PaymentDataObjectInterface;
use Magento\Payment\Gateway\Request\BuilderInterface;
use Magento\Sales\Api\Data\OrderPaymentInterface;
use Magento\Sales\Model\Order;

class AuthorizationRequest implements BuilderInterface
{
    /**
     * @var ConfigInterface
     */
    private $config;

    /**
     * @var CustomerRepositoryInterface
     */
    protected $customerRepository;

    /**
     * AuthorizationRequest constructor.
     * @param ConfigInterface $config
     * @param CustomerRepositoryInterface $customerRepository
     */
    public function __construct(
        ConfigInterface $config,
        CustomerRepositoryInterface $customerRepository
    ) {
        $this->config = $config;
        $this->customerRepository = $customerRepository;
    }

    /**
     * Builds ENV request
     *
     * @param array $buildSubject
     * @return array
     */
    public function build(array $buildSubject)
    {
        if (!isset($buildSubject['payment'])
            || !$buildSubject['payment'] instanceof PaymentDataObjectInterface
        ) {
            throw new \InvalidArgumentException('Payment data object should be provided');
        }

        /** @var PaymentDataObjectInterface $paymentDO */
        $paymentDO = $buildSubject['payment'];
        /** @var Order $order */
        $order = $paymentDO->getOrder();
        /** @var Order\Payment $payment */
        $payment = $paymentDO->getPayment();
        $orderModel = $payment->getOrder();
        $paymentAdditionalInformation = $payment->getAdditionalInformation();
        $quote = $orderModel->getQuote();

        if ($quote) {
            if (!empty($quote->getData('quote_currency_code'))) {
                $paymentAdditionalInformation['currencyCode'] = $quote->getData('quote_currency_code');
            }
        }

        $address = $order->getShippingAddress();

        if (!$payment instanceof OrderPaymentInterface) {
            throw new \LogicException('Order payment should be provided.');
        }

        return [
            'TXN_TYPE' => 'authorize',
            'STRIPE_TOKEN' => isset($paymentAdditionalInformation['stripeToken']) ? $paymentAdditionalInformation['stripeToken'] : '',
            'TXN_ID' => $payment->getLastTransId(),
            'CURRENCY_CODE' => isset($paymentAdditionalInformation['currencyCode']) ? $paymentAdditionalInformation['currencyCode'] : $order->getCurrencyCode(),
            'CUSTOMER_ID' => $order->getCustomerId(),
            'CUSTOMER_EMAIL' => isset($paymentAdditionalInformation['customerEmail']) ? $paymentAdditionalInformation['customerEmail'] : $orderModel->getCustomerEmail(),
            'AMOUNT' => $payment->getAmountOrdered(),
            'ADDITIONAL_INFO' => $paymentAdditionalInformation,
            'ORDER' => $order
        ];
    }
}
