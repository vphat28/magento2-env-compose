<?php

namespace Stripeofficial\Alipay\Observer;

use Magento\Framework\Event\ManagerInterface;
use Magento\Framework\Event\Observer;
use Magento\Framework\Event\ObserverInterface;
use Magento\Framework\Pricing\PriceCurrencyInterface;
use Magento\Sales\Api\OrderRepositoryInterface;
use Magento\Sales\Api\OrderStatusHistoryRepositoryInterface;
use Magento\Sales\Model\Order;
use Stripeofficial\Core\Api\PaymentInterface;
use Stripeofficial\Core\Model\ResourceModel\Source as SourceRS;
use Stripeofficial\Core\Model\SourceFactory;
use Stripeofficial\Alipay\Model\Ui\ConfigProvider;

class DataAssignAfterSuccessObserver implements ObserverInterface
{
    /**
     * @var PaymentInterface
     */
    protected $creditCardPayment;

    /**
     * @var OrderRepositoryInterface
     */
    protected $orderRepository;

    /**
     * @var SourceRS
     */
    protected $sourceRs;

    /**
     * @var SourceFactory
     */
    protected $sourceFactory;

    /**
     * @var OrderStatusHistoryRepositoryInterface
     */
    protected $historyRepository;

    /**
     * @var ManagerInterface
     */
    protected $eventManager;

    /**
     * @var PriceCurrencyInterface
     */
    protected $priceCurrency;

    /**
     * DataAssignAfterSuccessObserver constructor.
     * @param PaymentInterface $creditCardPayment
     * @param OrderRepositoryInterface $orderRepository
     * @param SourceRS $sourceRs
     * @param SourceFactory $sourceFactory
     * @param OrderStatusHistoryRepositoryInterface $historyRepository
     * @param ManagerInterface $eventManager
     * @param PriceCurrencyInterface $priceCurrency
     */
    public function __construct(
        PaymentInterface $creditCardPayment,
        OrderRepositoryInterface $orderRepository,
        SourceRS $sourceRs,
        SourceFactory $sourceFactory,
        OrderStatusHistoryRepositoryInterface $historyRepository,
        ManagerInterface $eventManager,
        PriceCurrencyInterface $priceCurrency
    ) {
        $this->creditCardPayment = $creditCardPayment;
        $this->orderRepository = $orderRepository;
        $this->sourceFactory = $sourceFactory;
        $this->sourceRs = $sourceRs;
        $this->historyRepository = $historyRepository;
        $this->eventManager = $eventManager;
        $this->priceCurrency = $priceCurrency;
    }

    /**
     * @param Observer $observer
     * @throws
     * @return void
     */
    public function execute(Observer $observer)
    {
        /** @var Order $order */
        $order = $observer->getOrder();
        $orders = $observer->getOrders();

        if (!empty($orders)) {
            // Multishipping checkout
            return;
        }

        $payment = $order->getPayment();

        if ($payment->getMethod() != ConfigProvider::CODE) {
            return;
        }

        // If found stripe source id store it in database
        if ($order->getData('stripe_source_id')) {
            $source = $this->sourceFactory->create();
            $source->setData('source_id', $order->getData('stripe_source_id'));
            $source->setData('reference_order_id', $order->getId());
            $payment->setAmountAuthorized(0);
            $comments = $order->getAllStatusHistory();

            foreach ($comments as $comment) {
                /** @var Order\Status\History $comment */
                $this->historyRepository->delete($comment);
            }

            $this->sourceRs->save($source);

            $amount = $payment->getBaseAmountAuthorized();
            $amount = strip_tags($this->priceCurrency->convertAndFormat($amount));
            $message = 'Authorized amount of %1.';
            $message = __($message, $amount);
            $transaction = $order->getData('stripe_source_id');
            $payment->addTransactionCommentsToOrder($transaction, $message);
        }

        $this->orderRepository->save($order);

        $metadata = [
            'Magento Order ID' => $order->getIncrementId(),
            'customer_name' => $order->getCustomerName(),
            'customer_email' => $order->getCustomerEmail(),
            'order_id' => $order->getId(),
        ];
        $chargeId = $order->getData('stripe_charge_id');

        if (!empty($chargeId)) {
            $this->eventManager->dispatch('stripe_charge_completed', ['order' => $order, 'charge_id' => $chargeId]);
            $this->creditCardPayment->updateChargeMetadata($chargeId, $metadata, $order);
        }
    }
}
