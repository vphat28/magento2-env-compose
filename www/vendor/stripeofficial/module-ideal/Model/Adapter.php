<?php

namespace Stripeofficial\IDeal\Model;

class Adapter extends \Magento\Payment\Model\Method\Adapter
{
    public function getConfigPaymentAction()
    {
        return 'authorize_capture';
    }
}