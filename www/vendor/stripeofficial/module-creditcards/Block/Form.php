<?php

namespace Stripeofficial\CreditCards\Block;

use Magento\Framework\App\ObjectManager;
use Magento\Framework\View\Element\Template;

class Form extends Template
{
    protected $_template = 'Stripeofficial_CreditCards::multishipping-payment-form.phtml';

    /**
     * @return \Magento\Multishipping\Block\Checkout\Billing
     */
    public function getBillingBlock()
    {
        return ObjectManager::getInstance()->get(\Magento\Multishipping\Block\Checkout\Billing::class);
    }
}