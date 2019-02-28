<?php

namespace Stripeofficial\GiroPay\Controller\GiroPay;

use Magento\Checkout\Model\Session;
use Magento\Framework\App\Action\Action;
use Magento\Framework\App\Action\Context;
use Magento\Framework\App\Request\Http;
use Magento\Framework\Controller\ResultFactory;
use Magento\Framework\Message\ManagerInterface;
use Stripeofficial\Core\Api\PaymentInterface;
use Stripeofficial\Core\Helper\Data;
use Stripeofficial\Core\Model\Cron\Webhook;
use Magento\Sales\Model\OrderFactory;
use Magento\Sales\Model\Order;
use Magento\Checkout\Model\Cart;

class ReturnUrl extends Action
{
    /**
     * @var Http
     */
    protected $http;

    /**
     * @var Data
     */
    protected $data;

    /**
     * @var PaymentInterface
     */
    protected $payment;

    /**
     * @var Webhook
     */
    protected $webhook;

    /**
     * @var ManagerInterface
     */
    protected $messageManager;

    /**
     * @var Session
     */
    protected $session;
     /**
      * @var orderFactory
      */
    protected $orderFactory;
    /**
     * @var cart
     */
    protected $cart;

    /**
     * ReturnUrl constructor.
     * @param Context $context
     * @param Http $http
     * @param Data $data
     * @param PaymentInterface $payment
     * @param Session $session
     * @param Webhook $webhook
     */
    public function __construct(
        Context $context,
        Http $http,
        Data $data,
        PaymentInterface $payment,
        Session $session,
        Webhook $webhook,
        OrderFactory $orderFactory,
        Cart $cart
    ) {
        parent::__construct($context);
        $this->http = $http;
        $this->data = $data;
        $this->payment = $payment;
        $this->webhook = $webhook;
        $this->session = $session;
        $this->_orderFactory = $orderFactory;
        $this->cart = $cart;
    }

    /**
     * @return \Magento\Framework\App\ResponseInterface|\Magento\Framework\Controller\ResultInterface
     * @throws \Exception
     */
    public function execute()
    {
        if (empty($this->http->getParam('source'))) {
            $resultPage = $this->resultFactory->create(ResultFactory::TYPE_REDIRECT);
            $resultPage->setPath('');
        } else {
            $source = $this->http->getParam('source');
             $this->session->setCheckingSourceId($this->http->getParam('source'));

            $sourceObject = $this->payment->getSource($source)->jsonSerialize();
            $resultPage = $this->resultFactory->create(ResultFactory::TYPE_RAW);

            $eventData = [
                'object' => [
                    'id' => $sourceObject['id']
                ]
            ];

            if (isset($sourceObject['status']) && $sourceObject['status'] == 'failed') {
                $resultPage = $this->resultFactory->create(ResultFactory::TYPE_REDIRECT);
                $resultPage->setPath('checkout/cart');
                if ($this->session->getLastRealOrderId()) {
                    $order = $this->_orderFactory->create()->loadByIncrementId($this->session->getLastRealOrderId());
                    $payment = $order->getPayment();
                    $message = 'cancelled';
                    $order->setState(Order::STATE_CANCELED);
                    $order->setStatus(Order::STATE_CANCELED);
                    $transaction = $source;
                    $payment->addTransactionCommentsToOrder($transaction, $message);
                    $order->save();
                }
                $items = $order->getItemsCollection();
                foreach ($items as $item) {
                    $this->cart->addOrderItem($item);
                }
                $this->cart->save();
                $this->messageManager->addErrorMessage(__('We were unable to authorize a payment on your account. Please try again!'));

                return $resultPage;
            }

            if (isset($sourceObject['status']) && $sourceObject['status'] == 'chargeable') {
                if ($this->webhook->handleSourceChargeable($eventData)) {
                    $resultPage->setContents('good');
                    $resultPage->setHttpResponseCode(200);
                    $resultPage = $this->resultFactory->create(ResultFactory::TYPE_REDIRECT);
                    $resultPage->setPath('checkout/onepage/success');
                    $this->messageManager->addSuccessMessage(__('Thank you for your payment.'));

                    return $resultPage;
                }
            }

            $resultPage->setHttpResponseCode(400);

            return $resultPage;
        }

        $resultPage = $this->resultFactory->create(ResultFactory::TYPE_REDIRECT);
        $resultPage->setPath('stripe/giropay/finalize');

        return $resultPage;
    }
}
