
define([
    'jquery',
    'uiComponent',
    'mage/url'
], function ($, Component, urlBuilder) {
    'use strict';

    return Component.extend({
        defaults: {
            ajaxTriedTimes: 0,
            template: 'Stripeofficial_CreditCards/payment/3ds_loading',
            loadingImgUrl: require.s.contexts._.config.baseUrl + 'Stripeofficial_CreditCards/images/loading.gif'
        },

        /**
         * @inheritdoc
         */
        initialize: function () {
            this._super();
            this._checkSource();
            console.log(this);
            return this;
        },
        
        _checkSource: function () {
            var self = this;
            self.ajaxTriedTimes++;

            if (self.ajaxTriedTimes > self.ajaxTimeoutTries) {
                window.location.href = urlBuilder.build('');
            }

            var urlAjax = urlBuilder.build('stripe/cc/returnUrl');
            $.post(urlAjax, {'sourceId': this.sourceId}, function( data ) {
                if (data == '3dsgood') {
                    window.location.href = urlBuilder.build('checkout/onepage/success');
                } else if (data == '3dsbad') {
                    window.location.href = urlBuilder.build('checkout/cart');
                } else {
                    window.location.href = urlBuilder.build('/');
                }
            }).fail(function () {
                self._checkSource();
            });
        }
    });
});
