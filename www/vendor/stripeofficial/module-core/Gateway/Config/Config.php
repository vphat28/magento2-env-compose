<?php

namespace Stripeofficial\Core\Gateway\Config;

use Magento\Framework\Exception\InputException;

class Config extends \Magento\Payment\Gateway\Config\Config
{

    public function getallowedCurrency()
    {
        return ['aud', 'cad', 'eur', 'gbp', 'hkd', 'jpy', 'nzd', 'sgd', 'usd'];
    }

    public function getBaseCurreny()
    {
        $objectManager = \Magento\Framework\App\ObjectManager::getInstance();
        $currencysymbol = $objectManager->get('Magento\Store\Model\StoreManagerInterface');
        return $currency = $currencysymbol->getStore(null)->getBaseCurrencyCode();
    }

    public function getCurrentCurrency()
    {
        $objectManager = \Magento\Framework\App\ObjectManager::getInstance();
        $currencysymbol = $objectManager->get('Magento\Store\Model\StoreManagerInterface');
        return $currency = $currencysymbol->getStore()->getCurrentCurrencyCode();
    }
    public function currencyConvert($amount, $fromCurrency = null, $toCurrency = null)
    {

        $objectManager = \Magento\Framework\App\ObjectManager::getInstance();
        $this->_currencyFactory = $objectManager->get('Magento\Directory\Model\CurrencyFactory');

        if (!$fromCurrency) {
            $fromCurrency = $this->_storeManager->getStore()->getBaseCurrency();
        }

        if (!$toCurrency) {
            $toCurrency = $this->_storeManager->getStore()->getCurrentCurrency();
        }

        $rateToBase = $this->_currencyFactory->create()->load($fromCurrency)->getAnyRate($this->_storeManager->getStore()->getBaseCurrency()->getCode());

        $rateFromBase = $this->_storeManager->getStore()->getBaseCurrency()->getRate($toCurrency);
        if ($rateToBase && $rateFromBase) {
            $amount = $amount * $rateToBase * $rateFromBase;
        } else {
            throw new InputException(__('Please correct the target currency.'));
        }

        return (int)$amount;
    }
}
