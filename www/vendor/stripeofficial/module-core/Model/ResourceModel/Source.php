<?php

namespace Stripeofficial\Core\Model\ResourceModel;

use Magento\Framework\Model\ResourceModel\Db\AbstractDb;

class Source extends AbstractDb
{
    protected function _construct()
    {
        $this->_init('stripe_source', 'entity_id');
    }
}
