<?php

namespace Stripeofficial\CreditCards\Controller\Cc;

use Magento\Checkout\Model\Session;
use Magento\Checkout\Model\Cart;
use Magento\Framework\App\Action\Action;
use Magento\Framework\App\Action\Context;
use Magento\Framework\App\Request\Http;
use Magento\Framework\Controller\ResultFactory;
use Magento\Framework\Message\ManagerInterface;
use Magento\Sales\Api\OrderRepositoryInterface;
use Magento\Sales\Model\Order;
use Stripeofficial\Core\Api\PaymentInterface;
use Stripeofficial\Core\Helper\Data;
use Stripeofficial\Core\Model\Cron\Webhook;

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
    protected $checkoutSession;

    /**
     * @var OrderRepositoryInterface
     */
    protected $orderRepository;

    /**
     * @var Cart
     */
    protected $cart;

    /**
     * ReturnUrl constructor.
     * @param Context $context
     * @param Http $http
     * @param Data $data
     * @param PaymentInterface $payment
     * @param Webhook $webhook
     * @param Session $checkoutSession
     * @param OrderRepositoryInterface $orderRepository
     * @param Cart $cart
     */
    public function __construct(
        Context $context,
        Http $http,
        Data $data,
        PaymentInterface $payment,
        Webhook $webhook,
        Session $checkoutSession,
        OrderRepositoryInterface $orderRepository,
        Cart $cart
    ) {
        parent::__construct($context);
        $this->http = $http;
        $this->data = $data;
        $this->payment = $payment;
        $this->webhook = $webhook;
        $this->checkoutSession = $checkoutSession;
        $this->orderRepository = $orderRepository;
        $this->cart = $cart;
    }

    /**
     * @return \Magento\Framework\App\ResponseInterface|\Magento\Framework\Controller\ResultInterface
     * @throws \Exception
     */
    public function execute()
    {
        $request = $this->http->getMethod();

        if ($request == 'POST') {
            $source = $this->http->getPostValue('sourceId');
            $sourceObjectParent = $this->payment->getSource($source)->jsonSerialize();
            $resultPage = $this->resultFactory->create(ResultFactory::TYPE_RAW);

            if ($sourceObjectParent['three_d_secure']['authenticated'] === false) {
                $resultPage->setContents('3dsbad');
                $resultPage->setHttpResponseCode(200);
                if ($this->checkoutSession->getLastRealOrderId()) {
                    $order   = $this->checkoutSession->getLastRealOrder();
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
                $this->messageManager->addWarningMessage(__('We could not authenticate your payment. Please try again'));
                return $resultPage;
            }

            $sourceCard = @$sourceObjectParent['three_d_secure']['card'];
            $sourceObject = $this->payment->getSource($sourceCard)->jsonSerialize();

            $eventData = [
                    'object' => [
                        'id' => $sourceObjectParent['id']
                    ]
                ];

            if (@$sourceObject['status'] == 'chargeable') {
                if ($this->webhook->handleSourceChargeable($eventData)) {
                    $resultPage->setContents('3dsgood');
                }
            }

            $resultPage->setHttpResponseCode(200);

            return $resultPage;
        }

        if (empty($this->http->getParam('source'))) {
            $resultPage = $this->resultFactory->create(ResultFactory::TYPE_REDIRECT);
            $resultPage->setPath('');
            return $resultPage;
        }

        $resultPage = $this->resultFactory->create(ResultFactory::TYPE_PAGE);

        return $resultPage;
    }
}
