<?php

namespace Stripeofficial\Core\Block;

use Magento\Framework\Pricing\PriceCurrencyInterface;
use Magento\Framework\View\Element\Template;
use Magento\Checkout\Model\Session;

class Success extends Template
{
    /**
     * @var PriceCurrencyInterface
     */
    protected $priceCurrency;

    /**
     * @var Session
     */
    protected $checkoutSession;

    /**
     * Success constructor.
     * @param Template\Context $context
     * @param Session $checkoutSession
     * @param PriceCurrencyInterface $priceCurrency
     * @param array $data
     */
    public function __construct(
        Template\Context $context,
        Session $checkoutSession,
        PriceCurrencyInterface $priceCurrency,
        array $data = []
    ) {
        parent::__construct($context, $data);
        $this->priceCurrency = $priceCurrency;
        $this->checkoutSession = $checkoutSession;
    }

    /**
     * @return \Magento\Sales\Model\Order
     */
    public function getOrderData()
    {
        $order = $this->checkoutSession->getLastRealOrder();

        return $order;
    }

    public function formatPrice($amount, $store, $currency)
    {
        return $this->priceCurrency->convertAndFormat($amount, false, PriceCurrencyInterface::DEFAULT_PRECISION, $store, $currency);
    }
}
