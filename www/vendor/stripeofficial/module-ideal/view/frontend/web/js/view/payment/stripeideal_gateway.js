/*browser:true*/
/*global define*/
define(
    [
        'uiComponent',
        'Magento_Checkout/js/model/payment/renderer-list'
    ],
    function (Component,
              rendererList) {
        'use strict';
        rendererList.push(
            {
                type: 'stripeideal',
                component: 'Stripeofficial_IDeal/js/view/payment/method-renderer/stripeideal_gateway'
            }
        );
        /** Add view logic here if needed */
        return Component.extend({});
    }
);
