<?php

namespace Stripeofficial\CreditCards\Block;

use Magento\Framework\App\Config\ScopeConfigInterface;
use Magento\Framework\App\RequestInterface;
use Magento\Framework\View\Element\Template;

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

    /**
     * ViewModel constructor.
     * @param Template\Context $context
     * @param array $data
     */
    public function __construct(
        Template\Context $context,
        array $data = []
    ) {
        parent::__construct($context, $data);
        $this->http = $context->getRequest();
        $this->scopeConfig = $context->getScopeConfig();
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
