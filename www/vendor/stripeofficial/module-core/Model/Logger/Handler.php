<?php

namespace Stripeofficial\Core\Model\Logger;

use Magento\Framework\Logger\Handler\Base;
use Monolog\Logger;

class Handler extends Base
{
    protected $fileName = '/var/log/stripe.log';
    protected $loggerType = Logger::DEBUG;
}
