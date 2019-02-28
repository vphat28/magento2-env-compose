<?php

namespace Stripeofficial\Core\Model\ResourceModel\Charge;

use Magento\Framework\Model\ResourceModel\Db\Collection\AbstractCollection;
use Stripeofficial\Core\Model\Charge;
use Stripeofficial\Core\Model\ResourceModel\Charge as Resource;

class Collection extends AbstractCollection
{
    /**
     * Specify model and resource model for collection
     */
    protected function _construct()
    {
        $this->_init(
            Charge::class,
            Resource::class
        );
    }
}
