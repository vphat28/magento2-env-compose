<?php

namespace Stripeofficial\CreditCards\Gateway\Request;

use Magento\Customer\Api\CustomerRepositoryInterface;
use Magento\Payment\Gateway\ConfigInterface;
use Magento\Payment\Gateway\Data\PaymentDataObjectInterface;
use Magento\Payment\Gateway\Request\BuilderInterface;
use Magento\Sales\Api\Data\OrderPaymentInterface;

class CaptureRequest implements BuilderInterface
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
        $order = $paymentDO->getOrder();
        $payment = $paymentDO->getPayment();
        $orderModel = $payment->getOrder();
        $paymentAdditionalInformation = $payment->getAdditionalInformation();

        if (!empty($order->getId())) {
            $txnType = 'capture';
        } else {
            $txnType = 'authorize_capture';
        }

        if (!$payment instanceof OrderPaymentInterface) {
            throw new \LogicException('Order payment should be provided.');
        }

        return [
            'TXN_TYPE' => $txnType,
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
