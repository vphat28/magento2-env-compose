
/*browser:true*/
/*global define*/
define(
    [
        'uiComponent',
        'Magento_Checkout/js/model/payment/renderer-list'
    ],
    function (
        Component,
        rendererList
    ) {
        'use strict';
        rendererList.push(
            {
                type: 'stripealipay',
                component: 'Stripeofficial_Alipay/js/view/payment/method-renderer/stripealipay_gateway'
            }
        );
        /** Add view logic here if needed */
        return Component.extend({});
    }
);
