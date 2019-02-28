<?php

namespace Stripeofficial\CreditCards\Gateway\Config;

use Magento\Cms\Api\BlockRepositoryInterface;
use Magento\Cms\Block\Block;
use Magento\Framework\UrlInterface;
use Magento\Framework\App\Config\ScopeConfigInterface;
use Stripeofficial\CreditCards\Model\Adminhtml\Source\Cctype;

/**
 * Class Config
 * @codeCoverageIgnore
 */
class Config extends \Magento\Payment\Gateway\Config\Config
{
    /**
     * @var Cctype
     */
    public $ccType;

    /**
     * @var UrlInterface
     */
    public $urlBuilder;

    const CODE = 'stripecreditcards';
    const KEY_ACTIVE = "active";
    const KEY_TITLE = "title";
    const KEY_TEST = "test";
    const KEY_CC_TYPES = 'cctypes';
    const ENABLE_3DS = 'enable_3ds';
    const KEY_PAYMENT_ACTION = "payment_action";
    const KEY_ALLOWSPECIFIC = "allowspecific";
    const KEY_SPECIFICCOUNTRY = "specificcountry";

    public function __construct(
        ScopeConfigInterface $scopeConfig,
        $methodCode = null,
        $pathPattern = self::DEFAULT_PATH_PATTERN,
        Cctype $cctype,
        UrlInterface $urlBuilder,
        BlockRepositoryInterface $blockRepository
    ) {
        parent::__construct($scopeConfig, $methodCode, $pathPattern);
        $this->ccType = $cctype;
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

    public function getEnable3DS()
    {
        return $this->getValue(self::ENABLE_3DS);
    }

    public function getAvailableCardTypes()
    {
        $ccTypes = $this->getValue(self::KEY_CC_TYPES);
        $ccTypes = !empty($ccTypes) ? explode(',', $ccTypes) : [];

        $types = $this->ccType->getCcTypeLabelMap();
        $configCardTypes = array_fill_keys($ccTypes, '');

        return array_intersect_key($types, $configCardTypes);
    }

    /**
     * Get Url to redirect after placed order, in case 3ds applied
     *
     * @return string
     */
    public function getAjaxUrlGenerate3dsRedirect()
    {
        return $this->urlBuilder->getUrl('stripe/cc/redirect/');
    }

    public function getCCFormStyles()
    {
        return [
            'font_size' => empty($this->getValue('form_font_size')) ? '16px' : $this->getValue('form_font_size'),
            'font_color' => empty($this->getValue('form_font_color')) ? '#333333' : $this->getValue('form_font_color'),
        ];
    }

    public function getNeededCmsBlocks()
    {
        $noBlock = false;

        try {
            /** @var Block $masterCard */
            $masterCard = $this->blockRepository->getById('stripe_mastercard_learn_more');
            /** @var Block $visaCard */
            $visaCard = $this->blockRepository->getById('stripe_visa_learn_more');
        } catch (\Exception $e) {
            $noBlock = true;
        }

        if ($noBlock) {
            return [];
        } else {
            return [
                'master' => $masterCard->getData('content'),
                'visa' => $visaCard->getData('content'),
            ];
        }
    }
}
