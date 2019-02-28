<?php

namespace Stripeofficial\GiroPay\Model\Ui;

use Magento\Checkout\Model\ConfigProviderInterface;
use Stripeofficial\Core\Helper\Data;

/**
 * Class ConfigProvider
 */
final class ConfigProvider implements ConfigProviderInterface
{
    const CODE = 'stripegiropay';

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
                    'active' => $scopeConfig->isSetFlag('payment/stripegiropay/active'),
                    'title' => $scopeConfig->getValue('payment/stripegiropay/title'),
                    'allowspecific' => $scopeConfig->getValue('payment/stripegiropay/allowspecific'),
                    'specificcountry' => $scopeConfig->getValue('payment/stripegiropay/specificcountry'),
                    'public_key' => $this->data->getAPIKey(),
                ]
            ]
        ];
    }
}
