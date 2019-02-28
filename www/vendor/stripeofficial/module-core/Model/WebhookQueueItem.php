<?php

namespace Stripeofficial\Core\Model;

use Magento\Framework\Model\AbstractModel;
use Stripeofficial\Core\Model\ResourceModel\WebhookQueueItem as ResourceModel;

class WebhookQueueItem extends AbstractModel
{
    protected function _construct()
    {
        $this->_init(ResourceModel::class);
    }
}
