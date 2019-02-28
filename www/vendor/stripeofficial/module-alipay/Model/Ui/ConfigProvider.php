<?php

namespace Stripeofficial\Alipay\Model\Ui;

use Magento\Checkout\Model\ConfigProviderInterface;
use Stripeofficial\Core\Helper\Data;

/**
 * Class ConfigProvider
 */
final class ConfigProvider implements ConfigProviderInterface
{
    const CODE = 'stripealipay';

    /**
     * @var Data
     */
    protected $data;

    /**
     * ConfigProvider constructor.
     * @param Data $data
     */
    public function __construct(
        Data $data
    ) {
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
                    'active' => $scopeConfig->isSetFlag('payment/stripealipay/active'),
                    'title' => $scopeConfig->getValue('payment/stripealipay/title'),
                    'country_code' => $scopeConfig->getValue('general/country/default'),
                    'allowspecific' => $scopeConfig->getValue('payment/stripealipay/allowspecific'),
                    'specificcountry' => $scopeConfig->getValue('payment/stripealipay/specificcountry'),
                    'public_key' => $this->data->getAPIKey(),
                    'is_test' => $this->data->getTestMode(),
                ]
            ]
        ];
    }
}
