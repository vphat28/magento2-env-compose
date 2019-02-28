<?php

namespace Stripeofficial\CreditCards\Gateway\Request;

use Magento\Sales\Model\Order\Payment;
use Magento\Payment\Gateway\Data\PaymentDataObjectInterface;
use Magento\Payment\Gateway\Request\BuilderInterface;

class RefundRequest implements BuilderInterface
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
        $transactionId = $payment->getAdditionalInformation('base_charge_id');
        $refundId = $payment->getAdditionalInformation('stripe_refunded_id');
        $amount = $buildSubject['amount'];
        $order = $paymentDO->getOrder();
        $paymentAdditionalInformation = $payment->getAdditionalInformation();

        if (!empty($refundId)) {
            $type = 'invoice_refund_only';
            $transactionId = $refundId;
        } else {
            $type = 'refund';
        }

        return [
            'TXN_TYPE' => $type,
            'TXN_ID' => $transactionId,
            'CURRENCY_CODE' => isset($paymentAdditionalInformation['currencyCode']) ? $paymentAdditionalInformation['currencyCode'] : $order->getBaseCurrencyCode(),
            'REFUND_AMOUNT' => $amount,
        ];
    }
}
