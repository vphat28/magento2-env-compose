<?php

namespace Stripeofficial\Core\Model;

use Magento\Framework\Model\AbstractModel;
use Stripeofficial\Core\Model\ResourceModel\Source as SourceResourceModel;

class Source extends AbstractModel
{
    protected function _construct()
    {
        $this->_init(SourceResourceModel::class);
    }
}
