<?php

namespace Stripeofficial\CreditCards\Gateway\Request;

use Magento\Payment\Gateway\Request\BuilderInterface;
use Magento\Sales\Model\Order\Payment;

class VaultDataBuilder implements BuilderInterface
{
    /**
     * Additional options in request to gateway
     */
    const OPTIONS = 'options';

    /**
     * The option that determines whether the payment method associated with
     * the successful transaction should be stored in the Vault.
     */
    const STORE_IN_VAULT_ON_SUCCESS = 'storeInVaultOnSuccess';

    /**
     * @inheritdoc
     */
    public function build(array $buildSubject)
    {
        $paymentDO = $buildSubject['payment'];
        $order = $paymentDO->getOrder();

        /** @var Payment $payment */
        $payment = $paymentDO->getPayment();
        $vaultToken = $payment->getExtensionAttributes()->getVaultPaymentToken();

        $source = $vaultToken->getGatewayToken();

        $order = $paymentDO->getOrder();
        $paymentAdditionalInformation = $payment->getAdditionalInformation();

        return [
            self::OPTIONS => [
                self::STORE_IN_VAULT_ON_SUCCESS => true
            ],
            'STRIPE_TOKEN' => $source,
            'TXN_ID' => $payment->getLastTransId(),
            'CUSTOMER_ID' => $order->getCustomerId(),
            'AMOUNT' => $payment->getAmountOrdered(),
            'ADDITIONAL_INFO' => $paymentAdditionalInformation,
            'CURRENCY_CODE' => isset($paymentAdditionalInformation['currencyCode']) ? $paymentAdditionalInformation['currencyCode'] : $order->getBaseCurrencyCode(),
        ];
    }
}
