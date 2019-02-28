<?php

namespace Stripeofficial\IDeal\Block;

use Magento\Framework\App\Config\ScopeConfigInterface;
use Magento\Framework\App\RequestInterface;
use Magento\Framework\View\Element\Template;
use Stripeofficial\Core\Api\PaymentInterface;

class ViewModel extends Template
{
    /**
     * @var RequestInterface
     */
    protected $http;

    /**
     * @var ScopeConfigInterface
     */
    protected $scopeConfig;

    protected $payment;

    /**
     * ViewModel constructor.
     * @param Template\Context $context
     * @param PaymentInterface $payment
     * @param array $data
     */
    public function __construct(
        Template\Context $context,
        PaymentInterface $payment,
        array $data = []
    ) {
        $this->http = $context->getRequest();
        $this->scopeConfig = $context->getScopeConfig();
        $this->payment = $payment;
        parent::__construct($context, $data);
    }

    public function getSource($source)
    {
        return $this->payment->getSource($source)->jsonSerialize();
    }

    /**
     * @return RequestInterface
     */
    public function getHttp()
    {
        return $this->http;
    }

    /**
     * @return ScopeConfigInterface
     */
    public function getScopeConfig()
    {
        return $this->scopeConfig;
    }
}
