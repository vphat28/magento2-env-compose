<?php

namespace Stripeofficial\SEPA\Gateway\Config;

use Magento\Cms\Api\BlockRepositoryInterface;
use Magento\Cms\Block\Block;
use Magento\Framework\UrlInterface;
use Magento\Framework\App\Config\ScopeConfigInterface;

/**
 * Class Config
 * @codeCoverageIgnore
 */
class Config extends \Magento\Payment\Gateway\Config\Config
{
    
        /**
         * @var UrlInterface
         */
    protected $urlBuilder;

    const CODE = 'stripesepa';
    const KEY_ACTIVE = "active";
    const KEY_TITLE = "title";
    const KEY_TEST = "test";
    const KEY_DIPLAYTEXT="displaytext";
    const KEY_PAYMENT_ACTION = "payment_action";
    const KEY_ALLOWSPECIFIC = "allowspecific";
    const KEY_SPECIFICCOUNTRY = "specificcountry";

    public function __construct(
        ScopeConfigInterface $scopeConfig,
        $methodCode = null,
        $pathPattern = \Magento\Payment\Gateway\Config\Config::DEFAULT_PATH_PATTERN,
        UrlInterface $urlBuilder,
        BlockRepositoryInterface $blockRepository
    ) {
        parent::__construct($scopeConfig, $methodCode, $pathPattern);
        
        $this->urlBuilder = $urlBuilder;
        $this->blockRepository = $blockRepository;
    }

    public function isActive()
    {
        return $this->getValue(self::KEY_ACTIVE);
    }

    public function getTitle()
    {
        return $this->getValue(self::KEY_TITLE);
    }
    public function getDisplaytext()
    {
        return $this->getValue(self::KEY_DIPLAYTEXT);
    }

    public function isTest()
    {
        return $this->getValue(self::KEY_TEST);
    }

    public function getPaymentAction()
    {
        return $this->getValue(self::KEY_PAYMENT_ACTION);
    }

    public function getSpecificCountry()
    {
        return $this->getValue(self::KEY_SPECIFICCOUNTRY);
    }
}
