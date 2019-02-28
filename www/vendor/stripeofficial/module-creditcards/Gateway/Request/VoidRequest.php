<?php

namespace Stripeofficial\CreditCards\Gateway\Request;

use Magento\Sales\Model\Order\Payment;
use Magento\Payment\Gateway\Data\PaymentDataObjectInterface;
use Magento\Payment\Gateway\Request\BuilderInterface;

class VoidRequest implements BuilderInterface
{
    /**
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

        /** @var Payment $payment */
        $payment = $paymentDO->getPayment();
        $transactionId = $payment->getLastTransId();

        $amount = $payment->getBaseAmountAuthorized();
        $order = $paymentDO->getOrder();
        $paymentAdditionalInformation = $payment->getAdditionalInformation();

        return [
            'TXN_TYPE' => 'refund',
            'TXN_ID' => $transactionId,
            'CURRENCY_CODE' => isset($paymentAdditionalInformation['currencyCode']) ? $paymentAdditionalInformation['currencyCode'] : $order->getBaseCurrencyCode(),
            'REFUND_AMOUNT' => $amount,
        ];
    }
}
