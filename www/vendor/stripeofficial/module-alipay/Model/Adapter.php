<?php

namespace Stripeofficial\Alipay\Model;

use Magento\Payment\Model\Method\Adapter as PaymentAdapter;

class Adapter extends PaymentAdapter
{
    public function getConfigPaymentAction()
    {
        return 'authorize';
    }
}
