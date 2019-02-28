<?php

namespace Stripeofficial\Core\Model;

use Magento\Framework\App\ObjectManager;
use Magento\Framework\Logger\Monolog;
use Stripeofficial\Core\Helper\Data;
use Stripeofficial\Core\Model\Logger\Handler;

class Logger extends Monolog
{
    /**
     * Logger constructor.
     * @param $name
     * @param Handler $handler
     * @param array $handlers
     * @param array $processors
     */
    public function __construct(
        $name,
        Handler $handler,
        array $handlers = [],
        array $processors = []
    )
    {
        $handlers[] = $handler;
        parent::__construct($name, $handlers, $processors);
    }

    /**
     * @param string $message
     * @param array $context
     * @return bool
     */
    public function info($message, array $context = array())
    {
        /** @var Data $helper */
        $helper = ObjectManager::getInstance()->get(Data::class);

        if (!$helper->getDebugMode()) {
            return true;
        }

        return parent::info($message, $context);
    }
}
