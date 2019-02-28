<?php

namespace Stripeofficial\Core\Helper;

use Magento\Framework\Encryption\EncryptorInterface;
use Magento\Framework\App\Config\ScopeConfigInterface;
use Magento\Store\Model\ScopeInterface;
use Stripeofficial\Core\Model\Logger;

class Data
{
    /**
     * @var ScopeConfigInterface
     */
    protected $scopeConfig;

    /**
     * @var EncryptorInterface
     */
    protected $encryptor;

    /**
     * @var Logger
     */
    protected $logger;

    /**
     * @var bool|null
     */
    protected $isDebug = null;

    /**
     * Data constructor.
     * @param ScopeConfigInterface $scopeConfig
     * @param EncryptorInterface $encryptor
     * @param Logger $logger
     */
    public function __construct(
        ScopeConfigInterface $scopeConfig,
        EncryptorInterface $encryptor,
        Logger $logger
    ) {
        $this->scopeConfig = $scopeConfig;
        $this->encryptor = $encryptor;
        $this->logger = $logger;
    }

    /**
     * Get default statement descriptor;
     *
     * @return string
     */
    public function getStatementDescriptor()
    {
        $result = (string)$this->scopeConfig->getValue('payment/stripecore/statement_descriptor', ScopeInterface::SCOPE_STORE);

        if (empty($result)) {
            return '';
        }

        return $result;
    }

    /**
     * Get the publishable api key
     *
     * @return string
     */
    public function getAPIKey()
    {
        if ($this->getTestMode()) {
            return $this->encryptor->decrypt((string)$this->scopeConfig->getValue('payment/stripecore/test_api_key', \Magento\Store\Model\ScopeInterface::SCOPE_STORE));
        } else {
            return $this->encryptor->decrypt((string)$this->scopeConfig->getValue('payment/stripecore/api_key', \Magento\Store\Model\ScopeInterface::SCOPE_STORE));
        }
    }

    /**
     * Get the secret api key
     *
     * @return string
     */
    public function getAPISecretKey()
    {
        if ($this->getTestMode()) {
            return $this->encryptor->decrypt((string)$this->scopeConfig->getValue('payment/stripecore/test_api_secret_key', \Magento\Store\Model\ScopeInterface::SCOPE_STORE));
        } else {
            return $this->encryptor->decrypt((string)$this->scopeConfig->getValue('payment/stripecore/api_secret_key', \Magento\Store\Model\ScopeInterface::SCOPE_STORE));
        }
    }

    /**
     * @return bool
     */
    public function getTestMode()
    {
        return $this->scopeConfig->isSetFlag('payment/stripecore/test_mode', \Magento\Store\Model\ScopeInterface::SCOPE_STORE);
    }

    /**
     * @return bool
     */
    public function getDebugMode()
    {
        if ($this->isDebug === null) {
            $this->isDebug = $this->scopeConfig->isSetFlag('payment/stripecore/debug', \Magento\Store\Model\ScopeInterface::SCOPE_STORE);
        }

        return $this->isDebug;
    }

    /**
     * @return Logger
     */
    public function getLogger()
    {
        return $this->logger;
    }

    /**
     * @return ScopeConfigInterface
     */
    public function getScopeConfig()
    {
        return $this->scopeConfig;
    }
}
