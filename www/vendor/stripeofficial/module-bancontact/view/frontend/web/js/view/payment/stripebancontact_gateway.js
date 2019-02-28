
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
                type: 'stripebancontact',
                component: 'Stripeofficial_BANCONTACT/js/view/payment/method-renderer/stripebancontact_gateway'
            }
        );
        /** Add view logic here if needed */
        return Component.extend({});
    }
);
