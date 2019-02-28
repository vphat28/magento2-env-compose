<?php

namespace Stripeofficial\BANCONTACT\Model;

use Magento\Payment\Model\Method\Adapter as PaymentAdapter;

class Adapter extends PaymentAdapter
{
    /**
     * @param $capture
     * @param $sourceToken
     * @param $amount
     * @param $currencyCode
     * @param $customerId
     * @param null $metaData
     */
    public function charge($capture, $sourceToken, $amount, $currencyCode, $customerId, $metaData = null)
    {
    }
}
