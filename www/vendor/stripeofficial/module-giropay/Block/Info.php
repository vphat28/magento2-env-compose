<?php

namespace Stripeofficial\GiroPay\Block;

use Magento\Framework\Exception\LocalizedException;
use Magento\Sales\Model\Order\Payment;
use Stripeofficial\Core\Block\Info as CoreInfo;

class Info extends CoreInfo
{
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

            $additional = [];

            if (!empty($charge['id'])) {
                $additional['Charge ID'] = $charge['id'];
                $additional['Source ID'] = $charge['source']['id'];
                $additional['Bank Code'] = $charge['source']['giropay']['bank_code'];
                $additional['Bank Name'] = $charge['source']['giropay']['bank_name'];
            }

            $info = array_merge($info, $additional);
        }

        return $info;
    }
}
