<?php

namespace Stripeofficial\IDeal\Model\Adminhtml\Source;

use Magento\Framework\Option\ArrayInterface;

/**
 * Class PaymentAction
 */
class PaymentAction implements ArrayInterface
{
    const AUTHORIZE = "authorize";
    const ACTION_AUTHORIZE_CAPTURE = "authorize_capture";

    /**
     * {@inheritdoc}
     */
    public function toOptionArray()
    {
         return [
            [
                'value' => self::AUTHORIZE,
                'label' => __('Authorize')
            ]
         ];
    }
}
