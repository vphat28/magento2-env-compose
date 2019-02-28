<?php

namespace Stripeofficial\Core\Model\ResourceModel\WebhookQueueItem;

use Magento\Framework\Model\ResourceModel\Db\Collection\AbstractCollection;
use Stripeofficial\Core\Model\WebhookQueueItem;
use Stripeofficial\Core\Model\ResourceModel\WebhookQueueItem as Resource;

class Collection extends AbstractCollection
{
    /**
     * Specify model and resource model for collection
     */
    protected function _construct()
    {
        $this->_init(
            WebhookQueueItem::class,
            Resource::class
        );
    }
}
