<?php

namespace Stripeofficial\CreditCards\Model\Adminhtml\Source;

/**
 * Class Cctype
 * @package CyberSource\Core\Model\Source
 * @codeCoverageIgnore
 */
class Cctype extends \Magento\Payment\Model\Source\Cctype
{
    /**
     * List of specific credit card types
     * @var array
     */
    private $specificCardTypesList = [];

    /**
     * @return array
     */
    public function getAllowedTypes()
    {
        return ['VI', 'MC', 'AE', 'DI', 'JCB', 'DN'];
    }

    /**
     * Returns credit cards types
     *
     * @return array
     */
    public function getCcTypeLabelMap()
    {
        return array_merge($this->specificCardTypesList, $this->_paymentConfig->getCcTypes());
    }

    /**
     * @inheritdoc
     */
    public function toOptionArray()
    {
        $allowed = $this->getAllowedTypes();
        $options = [];

        foreach ($this->getCcTypeLabelMap() as $code => $name) {
            if (in_array($code, $allowed)) {
                $options[] = ['value' => $code, 'label' => $name];
            }
        }

        return $options;
    }
}
