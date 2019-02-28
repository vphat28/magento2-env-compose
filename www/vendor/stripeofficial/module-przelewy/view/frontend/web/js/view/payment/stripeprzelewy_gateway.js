
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
                type: 'stripeprzelewy',
                component: 'Stripeofficial_Przelewy/js/view/payment/method-renderer/stripeprzelewy_gateway'
            }
        );
        /** Add view logic here if needed */
        return Component.extend({});
    }
);
