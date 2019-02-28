<?php

namespace Stripeofficial\Alipay\Controller\Alipay;

use Magento\Framework\App\Action\Action;
use Magento\Framework\App\Action\Context;
use Magento\Framework\App\Request\Http;
use Magento\Framework\Controller\ResultFactory;
use Stripeofficial\Core\Api\PaymentInterface;
use Magento\Checkout\Model\Session;
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
     * @var PaymentInterface
     */
    protected $payment;
    /**
     * @var checkoutSession
     */
    protected $checkoutSession;
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
     * @param PaymentInterface $payment
     */
    public function __construct(
        Context $context,
        Http $http,
        PaymentInterface $payment,
        Session $checkoutSession,
        OrderFactory $orderFactory,
        Cart $cart
    ) {
        parent::__construct($context);
        $this->http             = $http;
        $this->payment          = $payment;
        $this->_checkoutSession = $checkoutSession;
        $this->_orderFactory    = $orderFactory;
        $this->cart             = $cart;
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
            return $resultPage;
        } else {
            $source     = $this->http->getParam('source');
            $sourceData = $this->payment->getSource($source)->jsonSerialize();
            if ($sourceData['status'] == 'failed') {
                $resultPage = $this->resultFactory->create(ResultFactory::TYPE_REDIRECT);
                $resultPage->setPath('checkout/cart');
                if ($this->_checkoutSession->getLastRealOrderId()) {
                    $order   = $this->_orderFactory->create()->loadByIncrementId($this->_checkoutSession->getLastRealOrderId());
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
            } else {
                $resultPage = $this->resultFactory->create(ResultFactory::TYPE_REDIRECT);
                $resultPage->setPath('checkout/onepage/success');
            }
        }
        
        return $resultPage;
    }
}
