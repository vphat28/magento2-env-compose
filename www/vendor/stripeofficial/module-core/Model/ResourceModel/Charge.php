<?php

namespace Stripeofficial\Core\Model\ResourceModel;

use Magento\Framework\Model\ResourceModel\Db\AbstractDb;

class Charge extends AbstractDb
{
    protected function _construct()
    {
        $this->_init('stripe_charge', 'entity_id');
    }
}
