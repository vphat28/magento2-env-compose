<?php

namespace Stripeofficial\CreditCards\Model\Ui;

use Magento\Checkout\Model\ConfigProviderInterface;
use Stripeofficial\Core\Helper\Data;
use Stripeofficial\CreditCards\Gateway\Config\Config;
use Stripeofficial\CreditCards\Helper\Helper;

/**
 * Class ConfigProvider
 */
final class ConfigProvider implements ConfigProviderInterface
{
    const CODE = 'stripecreditcards';

    /**
     * @var Config
     */
    private $config;

    /**
     * @var Data
     */
    protected $data;

    /**
     * Constructor
     *
     * @param Config $config
     * @param Data $data
     */
    public function __construct(
        Config $config,
        Data $data
    ) {
        $this->config = $config;
        $this->data = $data;
    }

    /**
     * Retrieve assoc array of checkout configuration
     *
     * @return array
     */
    public function getConfig()
    {
        $scopeConfig = $this->data->getScopeConfig();

        return [
            'payment' => [
                self::CODE => [
                    'active' => $this->config->isActive(),
                    'title' => $this->config->getTitle(),
                    'public_key' => $this->data->getAPIKey(),
                    'availableCardTypes' => $this->config->getAvailableCardTypes(),
                    'stripeCCTypes' => $this->getStripeCCTypes(),
                    'enable_3ds' => $this->config->getEnable3DS(),
                    'ajax_3ds' => $this->config->getAjaxUrlGenerate3dsRedirect(),
                    'cms_blocks' => $this->config->getNeededCmsBlocks(),
                    'form_styles' => $this->config->getCCFormStyles(),
                    'vaultCode' => Helper::VAULT_CODE,
                    'allowspecific' => $scopeConfig->getValue('payment/stripecreditcards/allowspecific'),
                    'specificcountry' => $scopeConfig->getValue('payment/stripecreditcards/specificcountry'),
                ]
            ]
        ];
    }

    /**
     * @return array
     */
    private function getStripeCCTypes()
    {
        return [
            "diners" => "DIN",
            "mastercard" => "MC",
            "visa" => "VI",
            "amex" => "AE",
            "discover" => "DI",
            "jcb" => "JCB",
        ];
    }
}
