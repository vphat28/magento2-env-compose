<?php

namespace Stripeofficial\Core\Model\ResourceModel;

use Magento\Framework\Model\ResourceModel\Db\AbstractDb;

class WebhookQueueItem extends AbstractDb
{
    protected function _construct()
    {
        $this->_init('stripe_webhook_queue', 'entity_id');
    }
}
