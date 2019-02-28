<?php

namespace Stripeofficial\Core\Block;

use Magento\Framework\App\State;
use Magento\Framework\Exception\LocalizedException;
use Magento\Framework\View\Element\Template\Context;
use Magento\Payment\Block\ConfigurableInfo;
use Magento\Payment\Gateway\ConfigInterface;
use Stripeofficial\Core\Api\PaymentInterface;

class Info extends ConfigurableInfo
{
    /**
     * @var PaymentInterface
     */
    protected $creditCardPayment;

    /**
     * @var State
     */
    protected $state;

    /**
     * Info constructor.
     * @param Context $context
     * @param ConfigInterface $config
     * @param PaymentInterface $creditCardPayment
     * @param array $data
     */
    public function __construct(
        Context $context,
        ConfigInterface $config,
        PaymentInterface $creditCardPayment,
        array $data = []
    ) {
        parent::__construct($context, $config, $data);
        $this->creditCardPayment = $creditCardPayment;
        $this->state = $context->getAppState();
    }

    /**
     * @return bool
     * @throws LocalizedException
     */
    public function getIsSecureMode()
    {
        $method = $this->getMethod();

        if (!$method) {
            return true;
        }

        return $this->state->getAreaCode() === 'adminhtml';
    }
}
