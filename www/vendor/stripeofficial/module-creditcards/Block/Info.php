<?php

namespace Stripeofficial\CreditCards\Block;

use Magento\Framework\Exception\LocalizedException;
use Magento\Framework\Phrase;
use Magento\Framework\View\Element\Template\Context;
use Magento\Payment\Block\ConfigurableInfo;
use Magento\Payment\Gateway\ConfigInterface;
use Magento\Sales\Model\Order\Payment;
use Stripeofficial\Core\Api\PaymentInterface;

class Info extends ConfigurableInfo
{
    /**
     * @var PaymentInterface
     */
    protected $creditCardPayment;

    /**
     * Info constructor.
     * @param Context $context
     * @param ConfigInterface $config
     * @param PaymentInterface $creditCardPayment
     * @param array $data
     */
    public function __construct(
        Context $context,
        ConfigInterface $config,
        PaymentInterface $creditCardPayment,
        array $data = []
    ) {
        parent::__construct($context, $config, $data);
        $this->creditCardPayment = $creditCardPayment;
    }

    /**
     * Returns label
     *
     * @param string $field
     * @return Phrase
     */
    protected function getLabel($field)
    {
        return __($field);
    }

    /**
     * Get some specific information in format of array($label => $value)
     *
     * @return array
     * @throws LocalizedException
     */
    public function getSpecificInformation()
    {
        $info = parent::getSpecificInformation();

        if ($this->getIsSecureMode()) {
            /** @var Payment $payment */
            $payment = $this->getInfo();

            try {
                $chargeId = $payment->getAdditionalInformation('base_charge_id');
                $charge = $this->creditCardPayment->getCharge($chargeId)->jsonSerialize();
            } catch (\Exception $e) {
            }

            if (empty($charge)) {
                return $info;
            }

            $additional = [];

            // Check if 3ds is authenticated or not a
            if ($charge['source']['type'] == 'three_d_secure') {
                if ($charge['source']['three_d_secure']['authenticated'] == true) {
                    $additional['3DS Authenticated'] = __('Yes');
                } else {
                    $additional['3DS Authenticated'] = __('No');
                }

                $card = $charge['source']['three_d_secure']['card'];
                $source = $this->creditCardPayment->getSource($card)->jsonSerialize();
                $additional['Last 4 digits'] = $source['card']['last4'];
            }

            if ($charge['source']['type'] == 'card') {
                $additional['Last 4 digits'] = $charge['source']['card']['last4'];
            }

            if (!empty($charge['id'])) {
                $additional['Charge ID'] = $charge['id'];
                $additional['Source ID'] = $charge['source']['id'];
            }
            
            $info = array_merge($info, $additional);
        }

        return $info;
    }
}
