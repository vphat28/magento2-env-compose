<?php

namespace Stripeofficial\Core\Model;

use Magento\Framework\Model\AbstractModel;
use Stripeofficial\Core\Model\ResourceModel\Charge as ResourceModel;

class Charge extends AbstractModel
{
    protected function _construct()
    {
        $this->_init(ResourceModel::class);
    }
}
