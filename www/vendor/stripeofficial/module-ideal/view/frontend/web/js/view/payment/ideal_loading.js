define([
    'jquery',
    'uiComponent',
    'mage/url'
], function ($, Component, urlBuilder) {
    'use strict';

    return Component.extend({
        defaults: {
            ajaxTriedTimes: 0,
            template: 'Stripeofficial_IDeal/payment/ideal_loading',
            loadingImgUrl: require.s.contexts._.config.baseUrl + 'Stripeofficial_IDeal/images/loading.gif'
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
                window.location.href = urlBuilder.build('');
            }

            var urlAjax = urlBuilder.build('stripe/ideal/returnurl');
            var status = this.status;
            $.post(urlAjax, {'sourceId': this.sourceId}, function (data) {
                if (status == 'failed') {
                    window.location.href = urlBuilder.build('/');
                } else {
                    window.location.href = urlBuilder.build('checkout/onepage/success');
                }
            }).fail(function () {
                self._checkSource();
            });
        }
    });
});
