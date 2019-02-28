<?php

namespace Stripeofficial\SEPA\Model\Ui;

use Magento\Checkout\Model\ConfigProviderInterface;
use Stripeofficial\Core\Helper\Data;
use Stripeofficial\SEPA\Gateway\Config\Config;

/**
 * Class ConfigProvider
 */
final class ConfigProvider implements ConfigProviderInterface
{
    const CODE = 'stripesepa';

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
                    'displaytext' => $this->config->getDisplaytext(),
                    'public_key' => $this->data->getAPIKey(),
                    'is_test' => $this->data->getTestMode(),
                    'allowspecific' => $scopeConfig->getValue('payment/stripesepa/allowspecific'),
                    'specificcountry' => $scopeConfig->getValue('payment/stripesepa/specificcountry'),
                ]
            ]
        ];
    }
}
