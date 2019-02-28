<?php

namespace Stripeofficial\CreditCards\Plugin;

use Magento\Customer\Api\CustomerRepositoryInterface;
use Magento\Vault\Model\PaymentToken;
use Stripeofficial\Core\Model\Payment;

class VaultTokenRepositoryPlugin
{
    /**
     * @var CustomerRepositoryInterface
     */
    protected $customerRepository;

    /**
     * @var Payment
     */
    protected $payment;

    /**
     * VaultTokenRepositoryPlugin constructor.
     * @param CustomerRepositoryInterface $customerRepository
     * @param Payment $payment
     */
    public function __construct(CustomerRepositoryInterface $customerRepository, Payment $payment)
    {
        $this->customerRepository = $customerRepository;
        $this->payment = $payment;
    }

    public function aroundDelete($subject, callable $proceed, ...$args)
    {
        /** @var PaymentToken $paymentToken */
        $paymentToken = null;

        foreach ($args as $arg) {
            if ($arg instanceof PaymentToken) {
                $paymentToken = $arg;
                break;
            }
        }

        $result = $proceed(...$args);

        if ($result === true) {
            // Vault token delete successfully so we will detach source from customer
            $gatewayToken = $paymentToken->getGatewayToken();
            $customerId = $paymentToken->getCustomerId();
            $customer = $this->customerRepository->getById($customerId);
            $stripeCustomerId = $customer->getCustomAttribute('stripe_customer_id')->getValue();
            $this->payment->init();
            $customer = \Stripe\Customer::retrieve($stripeCustomerId);
            $customer->sources->retrieve($gatewayToken)->detach();
        }

        return $result;
    }
}
