<?php

namespace Stripeofficial\Core\Block;

use Magento\Customer\Api\CustomerRepositoryInterface;
use Magento\Framework\View\Element\Template;
use Magento\Checkout\Model\Session;
use Magento\Customer\Model\Session as CustomerSession;
use Magento\Quote\Model\QuoteRepository;

class CustomerData extends Template
{
    /**
     * @var Session
     */
    protected $checkoutSession;

    /**
     * @var CustomerSession
     */
    protected $customerSession;

    /**
     * @var CustomerRepositoryInterface
     */
    protected $customerRepository;

    /**
     * @var QuoteRepository
     */
    protected $quoteRepository;

    /**
     * CustomerData constructor.
     * @param Template\Context $context
     * @param Session $checkoutSession
     * @param CustomerSession $customerSession
     * @param CustomerRepositoryInterface $customerRepository
     * @param QuoteRepository $quoteRepository
     * @param array $data
     */
    public function __construct(
        Template\Context $context,
        Session $checkoutSession,
        CustomerSession $customerSession,
        CustomerRepositoryInterface $customerRepository,
        QuoteRepository $quoteRepository,
        array $data = []
    ) {
        parent::__construct($context, $data);
        $this->checkoutSession = $checkoutSession;
        $this->customerSession = $customerSession;
        $this->customerRepository = $customerRepository;
        $this->quoteRepository = $quoteRepository;
    }

    public function getCheckoutData()
    {
        $data = [];
        $customerData = $this->customerSession->getData();

        if (!empty(@$customerData['customer_id'])) {
            $customer = $this->customerRepository->getById($customerData['customer_id']);
            $data['customer_email'] = $customer->getEmail();
        } else {
            if (isset($_COOKIE['StripeCustomerDataEmail'])) {
                $data['customer_email'] = $_COOKIE['StripeCustomerDataEmail'];
            }
        }

        if (!empty($this->checkoutSession->getQuote())) {
            $quote = $this->checkoutSession->getQuote();
            $shippingAddress = $quote->getShippingAddress();
            $data['fullname'] = $shippingAddress->getName();

            if (!empty($quote->getCustomerEmail())) {
                $data['customer_email'] = $quote->getCustomerEmail();
            }
        }

        return $data;
    }
}
