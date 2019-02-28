<?php

namespace Stripeofficial\IDeal\Model\Ui;

use Magento\Checkout\Model\ConfigProviderInterface;
use Stripeofficial\Core\Helper\Data;
use Stripeofficial\IDeal\Gateway\Config\Config;
use Magento\Checkout\Model\Session;
use Magento\Store\Model\StoreManagerInterface;

/**
 * Class ConfigProvider
 */
final class ConfigProvider implements ConfigProviderInterface
{
    const CODE = 'stripeideal';

    /**
     * @var Config
     */
    private $config;

    /**
     * @var Data
     */
    protected $data;

    /**
     * @var StoreManagerInterface
     */
    protected $StoreManagerInterface;

    /**
     * Constructor
     *
     * @param Config $config
     * @param Data $data
     */
    public function __construct(
        Config $config,
        Data $data,
        Session $checkoutSession,
        StoreManagerInterface $StoreManagerInterface
    ) {
        $this->config = $config;
        $this->data = $data;
        $this->_storeManager = $StoreManagerInterface;
        $this->_checkoutSession = $checkoutSession;
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
                    'active' => $scopeConfig->isSetFlag('payment/stripeideal/active'),
                    'title' => $scopeConfig->getValue('payment/stripeideal/title'),
                    'public_key' => $this->data->getAPIKey(),
                    'is_test' => $this->data->getTestMode(),
                    'ajax_3ds' => $this->config->getRedirectUrl(),
                    'return_url' => $this->config->getReturnurl(),
                    'currency' => "eur",
                    'allowspecific' => $scopeConfig->getValue('payment/stripeideal/allowspecific'),
                    'specificcountry' => $scopeConfig->getValue('payment/stripeideal/specificcountry'),
                ]
            ]
        ];
    }
}
