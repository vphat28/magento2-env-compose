
define([
    'jquery',
    'uiComponent',
    'mage/url'
], function ($, Component, urlBuilder) {
    'use strict';

    return Component.extend({
        defaults: {
            ajaxTriedTimes: 0,
            template: 'Stripeofficial_GiroPay/payment/loading',
            loadingImgUrl: require.s.contexts._.config.baseUrl + 'Stripeofficial_GiroPay/images/loading.gif'
        },

        /**
         * @inheritdoc
         */
        initialize: function () {
            this._super();
            this._checkSource();
            return this;
        },
        
        _checkSource: function () {
            var self = this;
            self.ajaxTriedTimes++;

            if (self.ajaxTriedTimes > self.ajaxTimeoutTries) {
                window.location.href = urlBuilder.build('/');
                return;
            }

            var urlAjax = urlBuilder.build('/stripe/giropay/returnUrl');
            $.post(urlAjax, {}, function( data ) {
                if (data == 'good') {
                    window.location.href = urlBuilder.build('checkout/onepage/success');
                } else if (data == 'failed') {
                    window.location.href = urlBuilder.build('/');
                } else {
                    window.location.href = urlBuilder.build('/');
                }
            }).fail(function () {
                self._checkSource();
            });
        }
    });
});
