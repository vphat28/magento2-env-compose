<?php

namespace Stripeofficial\Core\Controller\Webhook;

use Magento\Framework\App\Action\Action;
use Magento\Framework\App\Action\Context;
use Magento\Framework\Controller\ResultFactory;
use Magento\Framework\Controller\ResultInterface;
use Magento\Framework\View\Result\PageFactory;
use Stripeofficial\Core\Model\Cron\Webhook;
use Stripeofficial\Core\Model\Logger;
use Stripeofficial\Core\Model\ChargeFactory;
use Stripeofficial\Core\Model\WebhookQueueItemFactory;
use Stripeofficial\Core\Model\ResourceModel\WebhookQueueItem as WebhookResource;
use Stripe\Stripe;

class Run extends Action
{
    /**
     * @var WebhookQueueItemFactory
     */
    protected $webhookQueueItemFactory;

    /**
     * @var WebhookResource
     */
    protected $webhookResource;

    /**
     * @var Logger
     */
    protected $logger;

    /**
     * Run constructor.
     * @param Context $context
     * @param Logger $logger
     * @param WebhookQueueItemFactory $webhookQueueItemFactory
     * @param WebhookResource $webhookResource
     * @param Webhook $webhook
     */
    public function __construct(
        Context $context,
        Logger $logger,
        WebhookQueueItemFactory $webhookQueueItemFactory,
        WebhookResource $webhookResource,
        Webhook $webhook
    ) {
        parent::__construct($context);
        $this->logger = $logger;
        $this->webhookQueueItemFactory = $webhookQueueItemFactory;
        $this->webhookResource = $webhookResource;
        $this->webhook = $webhook;
    }

    /**
     * @return ResultInterface
     * @throws \Exception
     */
    public function execute()
    {
        $this->webhook->execute();
        $resultPage = $this->resultFactory->create(ResultFactory::TYPE_RAW);
        $resultPage->setHttpResponseCode(200);
        return $resultPage;
    }
}
