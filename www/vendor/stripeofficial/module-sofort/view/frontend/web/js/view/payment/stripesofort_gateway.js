
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
                type: 'stripesofort',
                component: 'Stripeofficial_SOFORT/js/view/payment/method-renderer/stripesofort_gateway'
            }
        );
        /** Add view logic here if needed */
        return Component.extend({});
    }
);
