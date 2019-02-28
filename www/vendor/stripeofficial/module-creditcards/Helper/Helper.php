<?php

namespace Stripeofficial\CreditCards\Helper;

use Magento\Customer\Model\Session;
use Magento\Sales\Api\Data\OrderPaymentInterface;
use Magento\Vault\Api\Data\PaymentTokenInterface;
use Magento\Vault\Api\Data\PaymentTokenInterfaceFactory;
use Magento\Vault\Api\PaymentTokenManagementInterface;

class Helper
{
    const VAULT_CODE = 'stripecreditcards_vault';

    /**
     * @var PaymentTokenInterfaceFactory
     */
    protected $paymentTokenInterfaceFactory;

    /**
     * @var PaymentTokenManagementInterface
     */
    protected $paymentTokenManagement;

    /**
     * @var Session
     */
    protected $customerSession;

    /**
     * Helper constructor.
     * @param PaymentTokenInterfaceFactory $paymentTokenInterfaceFactory
     * @param PaymentTokenManagementInterface $paymentTokenManagement
     * @param Session $customerSession
     */
    public function __construct(
        PaymentTokenInterfaceFactory $paymentTokenInterfaceFactory,
        PaymentTokenManagementInterface $paymentTokenManagement,
        Session $customerSession
    ) {
        $this->paymentTokenInterfaceFactory = $paymentTokenInterfaceFactory;
        $this->paymentTokenManagement = $paymentTokenManagement;
        $this->customerSession = $customerSession;
    }

    /**
     * @param string $sourceId
     * @param OrderPaymentInterface $payment
     */
    public function saveTokenToLoggedCustomer($sourceId, $payment)
    {
        $customerId = $this->customerSession->getId();
        $customerToken = $this->paymentTokenManagement->getByGatewayToken($sourceId);

        if ($customerToken !== null) {
            $paymentToken = $this->paymentTokenInterfaceFactory->create();
            $paymentToken->setCustomerId($customerId);
            $paymentToken->setGatewayToken($sourceId);
            $paymentToken->setPaymentMethodCode(self::VAULT_CODE);
            $this->paymentTokenManagement->saveTokenWithPaymentLink($paymentToken, $payment);
            $customerToken = $paymentToken;
        }
    }
}
