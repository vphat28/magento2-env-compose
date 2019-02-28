<?php

namespace Stripeofficial\Core\Model\Cron;

use Magento\Customer\Api\CustomerRepositoryInterface;
use Magento\Framework\Event\ManagerInterface;
use Stripeofficial\Core\Api\PaymentInterface;
use Stripeofficial\Core\Model\Logger;
use Stripeofficial\Core\Model\ResourceModel\WebhookQueueItem\Collection as WebhookCollection;
use Stripeofficial\Core\Model\Source;
use Stripeofficial\Core\Model\WebhookQueueItem;
use Magento\Checkout\Model\Session;
use Magento\Framework\Exception\LocalizedException;
use Magento\Framework\View\Result\PageFactory;
use Magento\Sales\Api\CreditmemoManagementInterface;
use Magento\Sales\Api\CreditmemoRepositoryInterface;
use Magento\Sales\Api\InvoiceManagementInterface;
use Magento\Sales\Api\OrderRepositoryInterface;
use Magento\Sales\Model\Order;
use Stripeofficial\Core\Helper\Data;
use Stripeofficial\Core\Model\Charge;
use Stripeofficial\Core\Model\ResourceModel\Charge as ChargeResource;
use Stripeofficial\Core\Model\ChargeFactory;
use Stripeofficial\Core\Model\ResourceModel\Source as SourceRS;
use Stripeofficial\Core\Model\SourceFactory;
use Stripeofficial\Core\Model\WebhookQueueItemFactory;
use Stripeofficial\Core\Model\ResourceModel\WebhookQueueItem as WebhookResource;
use Stripe\Stripe;

class Webhook
{
    const AUTHORIZE = "authorize";
    const ACTION_AUTHORIZE_CAPTURE = "authorize_capture";
    
    /**
     * @var WebhookCollection
     */
    protected $webhookCollection;
    
    /**
     * @var Session
     */
    protected $checkoutSession;
    
    /**
     * @var PageFactory
     */
    protected $resultPageFactory;
    
    /**
     * @var Logger
     */
    protected $logger;
    
    /**
     * @var ChargeResource
     */
    protected $chargeResource;
    
    /**
     * @var ChargeFactory|AbstractFactory
     */
    protected $chargeFactory;
    
    /**
     * @var OrderRepositoryInterface
     */
    protected $orderRepository;
    
    /**
     * @var InvoiceManagementInterface
     */
    protected $invoiceManagement;
    
    /**
     * @var CreditmemoRepositoryInterface
     */
    protected $creditmemoRepository;
    
    /**
     * @var CreditmemoManagementInterface
     */
    protected $creditmemoManagementInterface;
    
    /**
     * @var SourceFactory
     */
    protected $sourceRs;
    
    /**
     * @var SourceFactory
     */
    protected $sourceFactory;
    
    /**
     * @var PaymentInterface
     */
    protected $creditCardPayment;
    
    /**
     * @var Data
     */
    protected $data;
    
    /**
     * @var WebhookQueueItemFactory
     */
    protected $webhookQueueItemFactory;
    
    /**
     * @var WebhookResource
     */
    protected $webhookResource;
    
    /**
     * @var ManagerInterface
     */
    protected $eventManager;
    
    /**
     * @var CustomerRepositoryInterface
     */
    protected $customerRepository;
    
    /**
     * Webhook constructor.
     * @param Session $checkoutSession
     * @param Logger $logger
     * @param Data $data
     * @param ChargeResource $chargeResource
     * @param ChargeFactory $chargeFactory
     * @param OrderRepositoryInterface $orderRepository
     * @param InvoiceManagementInterface $invoiceManagement
     * @param CreditmemoRepositoryInterface $creditmemoRepository
     * @param CreditmemoManagementInterface $creditmemoManagementInterface
     * @param WebhookQueueItemFactory $webhookQueueItemFactory
     * @param WebhookResource $webhookResource
     * @param WebhookCollection $webhookCollection
     * @param SourceRS $sourceRs
     * @param SourceFactory $sourceFactory
     * @param PaymentInterface $creditCardPayment
     * @param ManagerInterface $eventManager
     * @param CustomerRepositoryInterface $customerRepository
     */
    public function __construct(Session $checkoutSession, Logger $logger, Data $data, ChargeResource $chargeResource, ChargeFactory $chargeFactory, OrderRepositoryInterface $orderRepository, InvoiceManagementInterface $invoiceManagement, CreditmemoRepositoryInterface $creditmemoRepository, CreditmemoManagementInterface $creditmemoManagementInterface, WebhookQueueItemFactory $webhookQueueItemFactory, WebhookResource $webhookResource, WebhookCollection $webhookCollection, SourceRS $sourceRs, SourceFactory $sourceFactory, PaymentInterface $creditCardPayment, ManagerInterface $eventManager, CustomerRepositoryInterface $customerRepository)
    {
        $this->checkoutSession               = $checkoutSession;
        $this->logger                        = $logger;
        $this->data                          = $data;
        $this->chargeResource                = $chargeResource;
        $this->chargeFactory                 = $chargeFactory;
        $this->orderRepository               = $orderRepository;
        $this->invoiceManagement             = $invoiceManagement;
        $this->creditmemoRepository          = $creditmemoRepository;
        $this->creditmemoManagementInterface = $creditmemoManagementInterface;
        $this->webhookQueueItemFactory       = $webhookQueueItemFactory;
        $this->webhookResource               = $webhookResource;
        $this->webhookCollection             = $webhookCollection;
        $this->sourceRs                      = $sourceRs;
        $this->sourceFactory                 = $sourceFactory;
        $this->creditCardPayment             = $creditCardPayment;
        $this->eventManager                  = $eventManager;
        $this->customerRepository            = $customerRepository;
    }
    
    
    public function execute()
    {
        Stripe::setApiKey($this->data->getAPISecretKey());
        $this->logger->info('Cron Works');
        
        $this->webhookCollection->clear()->setOrder('entity_id', WebhookCollection::SORT_ORDER_ASC);
        
        /** @var WebhookQueueItem $webhook */
        foreach ($this->webhookCollection as $webhook) {
            try {
                $this->proceedItem(json_decode($webhook->getData('event_data'), true));
                $this->webhookResource->delete($webhook);
            } catch (\Exception $e) {
                $this->logger->info($webhook->getData('event_data'));
                $this->logger->info($e->getMessage() . ' ' . $e->getFile());
            }
        }
    }
    
    /**
     * @param $eventJson
     * @throws LocalizedException
     * @throws \Exception
     */
    public function proceedItem($eventJson)
    {
        switch ($eventJson['type']) {
            case 'charge.captured':
                $this->handleChargeCaptureEvent($eventJson['data']);
                break;
            case 'charge.refunded':
                $this->handleChargeRefundEvent($eventJson['data']);
                break;
            case 'source.chargeable':
                $this->handleSourceChargeable($eventJson['data']);
                break;
            case 'charge.succeeded':
                $this->handleChargeSuccessEvent($eventJson['data']);
                break;
            case 'source.failed':
                $this->handleSourceFailedEvent($eventJson['data']);
                break;
            case 'source.canceled':
                $this->handleSourceCanceledEvent($eventJson['data']);
                break;
            case 'charge.failed':
                $this->handleChargeFailedEvent($eventJson['data']);
                break;
        }
    }
    
    /**
     * @param $event
     * @throws LocalizedException
     * @throws \Exception
     */
    private function handleChargeRefundEvent($event)
    {
        
        /** @var Charge $charge */
        $charge = $this->chargeFactory->create();
        
        if (@$event['object']['object'] == 'charge') {
            $object = $event['object'];
            $this->chargeResource->load($charge, $event['object']['id'], 'charge_id');
            $chargeId = $event['object']['id'];
            
            /** @var Order $order */
            $order = $this->orderRepository->get($charge->getData('reference_order_id'));
            
            /** @var Order\Payment $payment */
            $payment = $order->getPayment();
            
            if ($payment->getAdditionalInformation('stripe_refunded') == true) {
                return;
            }
            
            $amountRefunded    = (string) $object['amount_refunded'];
            $amountRefunded    = substr_replace($amountRefunded, '.', -2, 0);
            $refundId          = $object['refunds']['data'][0]['id'];
            $invoiceCollection = $order->getInvoiceCollection();
            $validInvoice      = null;
            
            /** @var Order\Invoice $invoice */
            if (!empty($invoiceCollection)) {
                foreach ($invoiceCollection as $invoice) {
                    $validInvoice = $invoice;
                }
            }
            
            if ($validInvoice != null) {
                /** @var Order\Creditmemo $creditMemo */
                $creditMemo = $this->creditmemoRepository->create();
                $creditMemo->setInvoice($validInvoice);
                $creditMemo->setBaseGrandTotal($amountRefunded);
                $creditMemo->setInvoiceId($validInvoice->getId());
                $creditMemo->setOrder($order);
                $creditMemo->setBillingAddressId($order->getBillingAddressId());
                $payment->setAdditionalInformation('stripe_refunded_id', $refundId);
                $this->creditmemoManagementInterface->refund($creditMemo);
                $order->setBaseTotalRefunded($amountRefunded);
                $order->setTotalRefunded($amountRefunded);
                $order->setState(Order::STATE_CLOSED);
                $order->setStatus(Order::STATE_CLOSED);
            } else {
                // Change order status and state for non-captured payment refunds.
                $order->setState(Order::STATE_CANCELED);
                $order->setStatus(Order::STATE_CANCELED);
            }
            
            $this->orderRepository->save($order);
            if (!empty($invoiceCollection)) {
                $invoiceCollection->save();
            }
        }
    }
    
    /**
     * @param $event
     * @throws LocalizedException
     */
    private function handleChargeCaptureEvent($event)
    {
        /** @var Charge $charge */
        $charge = $this->chargeFactory->create();
        
        if (@$event['object']['object'] == 'charge') {
            $this->chargeResource->load($charge, $event['object']['id'], 'charge_id');
            $chargeId = $event['object']['id'];
            
            /** @var Order $order */
            $order = $this->orderRepository->get($charge->getData('reference_order_id'));
            
            /** @var Order\Payment $payment */
            $payment = $order->getPayment();
            
            if ($payment->getAdditionalInformation('stripe_captured') == true) {
                return;
            }
            
            $amount  = $payment->getBaseAmountAuthorized();
            /** @var Order\Invoice $invoice */
            $invoice = $this->invoiceManagement->prepareInvoice($order);
            $invoice->pay();
            $invoice->register();
            $invoice->setCanVoidFlag(false);
            $invoice->setTransactionId($chargeId);
            
            $message = 'Captured amount of %1.';
            $message = __($message, $amount);
            $order->setState(Order::STATE_PROCESSING);
            $order->setStatus(Order::STATE_PROCESSING);
            $transaction = $chargeId;
            $payment->addTransactionCommentsToOrder($transaction, $message);
            $payment->setIsTransactionClosed(true);
            $payment->setAdditionalInformation('stripe_captured', true);
            $order->setTotalPaid($amount);
            $order->addRelatedObject($invoice);
            $this->orderRepository->save($order);
        }
    }
    
    /**
     * @param $event
     * @throws LocalizedException
     * @return bool
     */
    public function handleSourceChargeable($event)
    {
        /** @var Source $source */
        $source   = $this->sourceFactory->create();
        $sourceId = $event['object']['id'];
        $this->sourceRs->load($source, $sourceId, 'source_id');
        
        if (empty($source->toArray())) {
            return;
        }
        
        /** @var Order $order */
        $order = $this->orderRepository->get($source->getData('reference_order_id'));
        
        /** @var Order\Payment $payment */
        $payment = $order->getPayment();
        
        if (!empty($payment->getAdditionalInformation('base_charge_id'))) {
            return;
        }
        
        // Charge from source
        $methodInstance = $payment->getMethodInstance();
        $methodInstance->setStore($order->getStoreId());
        
        $action = $methodInstance->getConfigPaymentAction();
        
        $sourceObject = $this->creditCardPayment->getSource($sourceId)->jsonSerialize();
        $amount       = $payment->getBaseAmountOrdered();
        
        // If order is cancelled then we won't charge the source
        if ($order->isCanceled()) {
            return true;
        }

        if ($order->getBaseCurrencyCode() == 'JPY') {
            $amount = $amount / 100;
        }

        if (@$sourceObject['three_d_secure']['authenticated'] == true || @$sourceObject['status'] == 'chargeable') {
            if ($action == self::ACTION_AUTHORIZE_CAPTURE) {
                $capture = true;
            } else {
                $capture = false;
            }
            
            $customerId     = $order->getCustomerId();
            $customerStripe = null;
            
            // Try to get customer id from database
            if (!empty($customerId)) {
                $customer       = $this->customerRepository->getById($customerId);
                $customerStripe = $customer->getCustomAttribute('stripe_customer_id') === null ? null : $customer->getCustomAttribute('stripe_customer_id')->getValue();
            }
            
            // If logged user then create customer stripe
            if (empty($customerStripe) and !empty($customerId)) {
                $customerStripe = $this->creditCardPayment->createCustomerToken($order->getCustomerEmail());
                $customerStripe = $customerStripe->id;
            }
            
            // Try to save id to customer object
            if (!empty($customerId)) {
                $customer->setCustomAttribute('stripe_customer_id', $customerStripe);
                $this->customerRepository->save($customer);
            }
            
            $charge = $this->creditCardPayment->charge($capture, $sourceObject['id'], $amount * 100, $order->getOrderCurrencyCode(), $customerStripe, @$sourceObject['type']);
            
            if ($action == self::ACTION_AUTHORIZE_CAPTURE) {
                $this->createInvoice($payment, $charge->id, $order);
            } else {
                $message = 'Authorized amount of %1.';
                $message = __($message, $amount);
                $payment->addTransactionCommentsToOrder($charge->id, $message);
            }
            
            $this->creditCardPayment->updateChargeMetadata($charge->id, [
                'Magento Order ID' => $order->getIncrementId(),
                'customer_name' => $order->getCustomerName(),
                'customer_email' => $order->getCustomerEmail(),
                'order_id' => $order->getId(),
            ], $order);
            $payment->setLastTransId($charge->id);
            
            try {
                $payment->setAdditionalInformation('base_charge_id', $charge->id);
                $this->orderRepository->save($order);
            } catch (LocalizedException $e) {
                $this->logger->info($e->getMessage());
            }

            $this->eventManager->dispatch('stripe_charge_completed', ['order' => $order, 'charge_id' => (string)$charge->id]);
            $this->sourceRs->delete($source);
            
            return true;
        }
    }
    
    /**
     * @param Order\Payment $payment
     * @param $chargeId
     * @param Order $order
     * @throws LocalizedException
     */
    private function createInvoice($payment, $chargeId, $order)
    {
        $amount  = $payment->getBaseAmountAuthorized();
        /** @var Order\Invoice $invoice */
        $invoice = $this->invoiceManagement->prepareInvoice($order);
        $invoice->pay();
        $invoice->register();
        $invoice->setCanVoidFlag(false);
        $invoice->setTransactionId($chargeId);
        
        $message = 'Captured amount of %1.';
        $message = __($message, $amount);
        $order->setState(Order::STATE_PROCESSING);
        $order->setStatus(Order::STATE_PROCESSING);
        $transaction = $chargeId;
        $payment->addTransactionCommentsToOrder($transaction, $message);
        $payment->setIsTransactionClosed(true);
        $payment->setAdditionalInformation('stripe_captured', true);
        $order->setTotalPaid($amount);
        $order->addRelatedObject($invoice);
        $this->orderRepository->save($order);
    }
    
    
    /**
     * @param $event
     * @throws LocalizedException
     * @throws \Exception
     */
    public function handleChargeSuccessEvent($event)
    {
        /** @var Charge $charge */
        $charge = $this->chargeFactory->create();
        
        if (@$event['object']['object'] == 'charge' && @$event['object']['captured'] == true) {
            $this->chargeResource->load($charge, $event['object']['id'], 'charge_id');
            $chargeId = $event['object']['id'];
            
            /** @var Order $order */
            $order = $this->orderRepository->get($charge->getData('reference_order_id'));
            
            /** @var Order\Payment $payment */
            $payment = $order->getPayment();
            
            if ($payment->getAdditionalInformation('stripe_captured') == true) {
                return;
            }
            
            $amount  = $payment->getBaseAmountAuthorized();
            /** @var Order\Invoice $invoice */
            $invoice = $this->invoiceManagement->prepareInvoice($order);
            $invoice->pay();
            $invoice->register();
            $invoice->setCanVoidFlag(false);
            $invoice->setTransactionId($chargeId);
            
            $message = 'Captured amount of %1.';
            $message = __($message, $amount);
            $order->setState(Order::STATE_PROCESSING);
            $order->setStatus(Order::STATE_PROCESSING);
            $transaction = $chargeId;
            $payment->addTransactionCommentsToOrder($transaction, $message);
            $payment->setIsTransactionClosed(false);
            $payment->setAdditionalInformation('stripe_captured', true);
            $order->setTotalPaid($amount);
            $order->addRelatedObject($invoice);
            $this->orderRepository->save($order);
        }
    }
    
    /**
     * Handle source.failed event from stripe webhook
     * @param $event
     */
    public function handleSourceFailedEvent($event)
    {
        /** @var Source $source */
        $source   = $this->sourceFactory->create();
        $sourceId = $event['object']['id'];
        $this->sourceRs->load($source, $sourceId, 'source_id');
        
        if (empty($source->toArray())) {
            return;
        }
        
        /** @var Order $order */
        $order = $this->orderRepository->get($source->getData('reference_order_id'));
        
        /** @var Order\Payment $payment */
        $payment = $order->getPayment();
        
        $message = 'Transaction failed By Customer';
        $order->setState(Order::STATE_CANCELED);
        $order->setStatus(Order::STATE_CANCELED);
        $transaction = $sourceId;
        $payment->addTransactionCommentsToOrder($transaction, $message);
        $this->orderRepository->save($order);
    }
    
    /**
     * Handle source.canceled event from stripe webhook
     * @param $event
     */
    public function handleSourceCanceledEvent($event)
    {
        /** @var Source $source */
        $source   = $this->sourceFactory->create();
        $sourceId = $event['object']['id'];
        $this->sourceRs->load($source, $sourceId, 'source_id');
        
        if (empty($source->toArray())) {
            return;
        }
        
        /** @var Order $order */
        $order = $this->orderRepository->get($source->getData('reference_order_id'));
        
        /** @var Order\Payment $payment */
        $payment = $order->getPayment();
        
        $message = 'Operation timed out. Please check out again.';
        $order->setState(Order::STATE_CANCELED);
        $order->setStatus(Order::STATE_CANCELED);
        $transaction = $sourceId;
        $payment->addTransactionCommentsToOrder($transaction, $message);
        $this->orderRepository->save($order);
    }
    
    /**
     * Handle charge.failed event from stripe webhook
     * @param $event
     */
    public function handleChargeFailedEvent($event)
    {
        /** @var Charge $charge */
        $charge = $this->chargeFactory->create();
        if (@$event['object']['object'] == 'charge') {
            $this->chargeResource->load($charge, $event['object']['id'], 'charge_id');
            $chargeId = $event['object']['id'];
            
            /** @var Order $order */
            $order = $this->orderRepository->get($charge->getData('reference_order_id'));
            
            /** @var Order\Payment $payment */
            $payment = $order->getPayment();
            
            $message = 'Transaction failed. Please contact your bank or use another payment method.';
            $order->setState(Order::STATE_CANCELED);
            $order->setStatus(Order::STATE_CANCELED);
            $transaction = $chargeId;
            $payment->addTransactionCommentsToOrder($transaction, $message);
            $this->orderRepository->save($order);
        }
    }
}
