<?php

namespace Stripeofficial\Core\Model\ResourceModel\Source;

use Magento\Framework\Model\ResourceModel\Db\Collection\AbstractCollection;
use Stripeofficial\Core\Model\Source;
use Stripeofficial\Core\Model\ResourceModel\Source as SourceResource;

class Collection extends AbstractCollection
{
    /**
     * Specify model and resource model for collection
     */
    protected function _construct()
    {
        $this->_init(
            Source::class,
            SourceResource::class
        );
    }
}
