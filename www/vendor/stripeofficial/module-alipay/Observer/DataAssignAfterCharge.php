<?php

namespace Stripeofficial\Alipay\Observer;

use Magento\Framework\Event\Observer;
use Magento\Framework\Event\ObserverInterface;
use Magento\Sales\Model\Order;
use Stripeofficial\Core\Model\ResourceModel\Charge as ChargeResource;
use Stripeofficial\Core\Model\ChargeFactory;
use Stripeofficial\Alipay\Model\Ui\ConfigProvider;

class DataAssignAfterCharge implements ObserverInterface
{
    /**
     * @var ChargeResource
     */
    protected $chargeResource;

    /**
     * @var ChargeFactory
     */
    protected $chargeFactory;

    /**
     * DataAssignAfterCharge constructor.
     * @param ChargeResource $chargeResource
     * @param ChargeFactory $chargeFactory
     */
    public function __construct(ChargeResource $chargeResource, ChargeFactory $chargeFactory)
    {
        $this->chargeResource = $chargeResource;
        $this->chargeFactory = $chargeFactory;
    }

    /**
     * @param Observer $observer
     * @throws \Exception
     */
    public function execute(Observer $observer)
    {
        /** @var Order $order */
        $order = $observer->getData('order');
        $chargeId = $observer->getData('charge_id');
        $payment = $order->getPayment();

        if ($payment->getMethod() != ConfigProvider::CODE) {
            return;
        }

        $payment->setAdditionalData('base_charge_id', $chargeId);

        // Saving charge to database
        $charge = $this->chargeFactory->create();
        $charge->setData('charge_id', $chargeId);
        $charge->setData('reference_order_id', $order->getId());
        $this->chargeResource->save($charge);
    }
}
