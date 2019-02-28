<?php

namespace Stripeofficial\CreditCards\Gateway\Response;

use Magento\Payment\Gateway\Data\PaymentDataObjectInterface;
use Magento\Payment\Gateway\Response\HandlerInterface;
use Magento\Payment\Model\InfoInterface;
use Magento\Sales\Api\Data\OrderPaymentExtensionInterfaceFactory;
use Magento\Vault\Api\Data\PaymentTokenInterface;
use Magento\Vault\Model\CreditCardTokenFactory;
use Stripeofficial\Core\Api\PaymentInterface;

class VaultDetailsHandler implements HandlerInterface
{
    /**
     * @var CreditCardTokenFactory
     */
    protected $paymentTokenFactory;

    /**
     * @var OrderPaymentExtensionInterfaceFactory
     */
    protected $paymentExtensionFactory;

    /**
     * @var PaymentInterface
     */
    protected $payment;

    /**
     * VaultDetailsHandler constructor.
     * @param CreditCardTokenFactory $cardTokenFactory
     * @param OrderPaymentExtensionInterfaceFactory $extensionInterfaceFactory
     * @param PaymentInterface $payment
     */
    public function __construct(
        CreditCardTokenFactory $cardTokenFactory,
        OrderPaymentExtensionInterfaceFactory $extensionInterfaceFactory,
        PaymentInterface $payment
    ) {
        $this->paymentTokenFactory = $cardTokenFactory;
        $this->paymentExtensionFactory = $extensionInterfaceFactory;
        $this->payment = $payment;
    }

    /**
     * @inheritdoc
     */
    public function handle(array $handlingSubject, array $response)
    {
        /** @var PaymentDataObjectInterface $paymentDO */
        $paymentDO = $handlingSubject['payment'];

        $payment = $paymentDO->getPayment();

        // add vault payment token entity to extension attributes
        $paymentToken = $this->getVaultPaymentToken($response);
        if (null !== $paymentToken) {
            $extensionAttributes = $this->getExtensionAttributes($payment);
            $extensionAttributes->setVaultPaymentToken($paymentToken);
        }
    }

    /**
     * Get payment extension attributes
     * @param InfoInterface $payment
     * @return OrderPaymentExtensionInterface
     */
    private function getExtensionAttributes(InfoInterface $payment)
    {
        $extensionAttributes = $payment->getExtensionAttributes();
        if (null === $extensionAttributes) {
            $extensionAttributes = $this->paymentExtensionFactory->create();
            $payment->setExtensionAttributes($extensionAttributes);
        }
        return $extensionAttributes;
    }

    /**
     * @param $response
     * @return null|PaymentTokenInterface
     */
    private function getVaultPaymentToken($response)
    {
        $json = [];
        if ($response['object'] === 'charge') {
            $charge = $this->payment->getCharge($response['id'])->jsonSerialize();
            $source = null;

            if ($charge['status'] == 'succeeded') {
                $source = $charge['source'];
            } else {
                return null;
            }
        } elseif (isset($response['3ds_source'])) {
            $source = $response['three_d_secure']['card'];
            $source = $this->payment->getSource($source)->jsonSerialize();
            $source['id'] = $response['3ds_source'];
            $json['3ds_enable'] = true;
        }

        if (empty($source)) {
            return null;
        }

        /** @var PaymentTokenInterface $paymentToken */
        $paymentToken = $this->paymentTokenFactory->create();
        $paymentToken->setGatewayToken($source['id']);
        $paymentToken->setExpiresAt(\time() + (365 * 3600 * 24));

        $brand = '';
        $last4 = '';

        if (isset($source['card']['brand'])) {
            $brand = $source['card']['brand'];
            $last4 = $source['card']['last4'];
        }
        if (isset($source['brand'])) {
            $brand = $source['brand'];
            $last4 = $source['last4'];
        }
        $json = array_merge($json, [
            'type' => $this->convertCardBrandtoCode($brand),
            'maskedCC' => $last4,
            'expirationDate' => $source['card']['exp_month'] . '/' . $source['card']['exp_year']
        ]);

        $paymentToken->setTokenDetails($this->convertDetailsToJSON($json));

        return $paymentToken;
    }

    /**
     * Map card brand from stripe to magento card names
     * @param string $code
     * @return string
     */
    private function convertCardBrandtoCode($code)
    {
        $arr = [
            'MasterCard' => 'MC',
            'Visa' => 'VI',
            'American Express' => 'AE',
        ];

        return isset($arr[$code]) ? $arr[$code] : $code;
    }

    /**
     * Convert payment token details to JSON
     * @param array $details
     * @return string
     */
    private function convertDetailsToJSON($details)
    {
        $json = \Zend_Json::encode($details);
        return $json ? $json : '{}';
    }
}
