<?php

namespace Stripeofficial\Core\Model\Ui;

use Magento\Checkout\Model\ConfigProviderInterface;
use Magento\Directory\Model\ResourceModel\Country\Collection;
use Magento\Directory\Api\CountryInformationAcquirerInterface as Country;
use Magento\Store\Api\StoreResolverInterface;
use Magento\Store\Model\StoreManagerInterface;

/**
 * Class ConfigProvider
 */
final class ConfigProvider implements ConfigProviderInterface
{
    const CODE = 'stripecore';

    /**
     * @var StoreManagerInterface
     */
    protected $storeManager;

    /**
     * @var \Magento\Directory\Model\ResourceModel\Region\CollectionFactory
     */
    private $countryCollectionFactory;

    /**
     * @var StoreResolverInterface
     */
    private $storeResolver;

    /**
     * ConfigProvider constructor.
     * @param StoreManagerInterface $storeManager
     * @param Country $countryDirectory
     * @param Collection $countryCollection
     * @param StoreResolverInterface $storeResolver
     * @param \Magento\Directory\Model\ResourceModel\Country\CollectionFactory $countryCollectionFactory
     */
    public function __construct(
        StoreManagerInterface $storeManager,
        Country $countryDirectory,
        Collection $countryCollection,
        StoreResolverInterface $storeResolver,
        \Magento\Directory\Model\ResourceModel\Country\CollectionFactory $countryCollectionFactory
    ) {
        $this->storeManager = $storeManager;
        $this->countryDirectory = $countryDirectory;
        $this->countryCollection = $countryCollection;
        $this->storeResolver = $storeResolver;
        $this->countryCollectionFactory = $countryCollectionFactory;
    }

    public function getConfig()
    {
        $countriesArray = [];
        $countryOptions = $this->countryCollectionFactory->create()->loadByStore(
            $this->storeResolver->getCurrentStoreId()
        )->toOptionArray();

        foreach ($countryOptions as $country) {
            $countriesArray[$country['label']] = $country['value'];
        }

        return [
            'payment' => [
                self::CODE => [
                    'merchant_name' => $this->storeManager->getStore()->getName(),
                    'countries' => $countriesArray
                ]
            ]
        ];
    }
}
