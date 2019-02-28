define([
    'jquery',
    'Magento_Vault/js/view/payment/method-renderer/vault',
    'mage/url'
], function ($, VaultComponent, urlBuilder) {
    'use strict';

    return VaultComponent.extend({
        defaults: {
            template: 'Magento_Vault/payment/form'
        },

        /**
         * Get last 4 digits of card
         * @returns {String}
         */
        getMaskedCard: function () {
            return this.details.maskedCC;
        },

        /**
         * Get expiration date
         * @returns {String}
         */
        getExpirationDate: function () {
            return this.details.expirationDate;
        },

        /**
         * Get card type
         * @returns {String}
         */
        getCardType: function () {
            return this.details.type;
        },

        /**
         * Get payment method data
         * @returns {Object}
         */
        getData: function () {
            var data = {
                'method': this.code,
                'additional_data': {
                    'currencyCode': window.checkoutConfig.quoteData.quote_currency_code.toLowerCase(),
                    'public_hash': this.publicHash
                }
            };

            if (this.details['3ds_enable'] === true) {
                this.redirec3dstAfterOrder = true;
                data.additional_data.stripeCard3ds = 'required';
            }

            data['additional_data'] = _.extend(data['additional_data'], this.additionalData);

            return data;
        },

        afterPlaceOrder: function () {
            // Override value in parent class
            if (this.redirec3dstAfterOrder) {
                // Override this so it won't redirect to success page
                this.redirectAfterPlaceOrder = false;
                var ajaxUrl = urlBuilder.build('stripe/cc/redirect');
                $.post(ajaxUrl, {})
                    .done(function (data) {
                        // Redirect to 3ds verification page
                        window.location.replace(data.toString());
                    });
            }
        },
    });
});