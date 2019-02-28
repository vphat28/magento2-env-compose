<?php

namespace Stripeofficial\GiroPay\Controller\GiroPay;

use Magento\Checkout\Model\Session;
use Magento\Framework\App\Action\Action;
use Magento\Framework\App\Action\Context;
use Magento\Framework\Controller\ResultFactory;

class Finalize extends Action
{
    /**
     * @var Session
     */
    protected $session;

    /**
     * Finalize constructor.
     * @param Context $context
     * @param Session $session
     */
    public function __construct(Context $context, Session $session)
    {
        parent::__construct($context);
        $this->session = $session;
    }

    /**
     * @return \Magento\Framework\App\ResponseInterface|\Magento\Framework\Controller\ResultInterface
     * @throws \Exception
     */
    public function execute()
    {
        if (!$this->session->getCheckingSourceId()) {
            $resultPage = $this->resultFactory->create(ResultFactory::TYPE_REDIRECT);
            $resultPage->setPath('');
        } else {
            $resultPage = $this->resultFactory->create(ResultFactory::TYPE_PAGE);
        }

        return $resultPage;
    }
}
