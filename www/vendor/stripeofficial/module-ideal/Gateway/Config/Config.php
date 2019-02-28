<?php

namespace Stripeofficial\IDeal\Gateway\Config;

use Magento\Cms\Api\BlockRepositoryInterface;
use Magento\Cms\Block\Block;
use Magento\Framework\UrlInterface;
use Magento\Framework\App\Config\ScopeConfigInterface;
use Magento\Store\Model\StoreManagerInterface;

/**
 * Class Config
 * @codeCoverageIgnore
 */
class Config extends \Stripeofficial\Core\Gateway\Config\Config
{

    /**
     * @var UrlInterface
     */
    protected $urlBuilder;

    protected $StoreManagerInterface;

    const CODE = 'stripeideal';
     
    public function __construct(
        ScopeConfigInterface $scopeConfig,
        $methodCode = null,
        $pathPattern = \Magento\Payment\Gateway\Config\Config::DEFAULT_PATH_PATTERN,
        UrlInterface $urlBuilder,
        StoreManagerInterface $StoreManagerInterface,
        BlockRepositoryInterface $blockRepository
    ) {
        parent::__construct($scopeConfig, $methodCode, $pathPattern);
        $this->urlBuilder = $urlBuilder;
        $this->blockRepository = $blockRepository;
        $this->_storeManager = $StoreManagerInterface;
    }

    /**
     * Get Url to redirect after placed order, in case 3ds applied
     *
     * @return string
     */
    public function getRedirectUrl()
    {
        return $this->urlBuilder->getUrl('stripe/ideal/redirect/');
    }
    
    /**
     * Get Url to redirect after placed order, in case 3ds applied
     *
     * @return string
     */
    public function getReturnurl()
    {
        return $this->urlBuilder->getUrl('stripe/ideal/returnurl/');
    }
}
