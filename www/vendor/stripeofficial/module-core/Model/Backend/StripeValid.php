<?php

namespace Stripeofficial\Core\Model\Backend;

use Magento\Framework\App\Config\Value;
use Magento\Framework\Exception\LocalizedException;
use Stripe\Stripe;

class StripeValid extends Value
{
    /**
     * @return Value
     * @throws LocalizedException
     */
    public function beforeSave()
    {
        if (!class_exists(Stripe::class, true)) {
            throw new LocalizedException(__('Stripe SDK need to be installed.'));
        }

        return parent::beforeSave();
    }
}
