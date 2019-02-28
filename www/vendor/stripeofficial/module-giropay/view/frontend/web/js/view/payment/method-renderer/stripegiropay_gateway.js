define(
    [
        'Magento_Checkout/js/view/payment/default',
        'jquery',
        'Magento_Catalog/js/price-utils',
        'mage/url',
        'Magento_Checkout/js/model/full-screen-loader',
        'Magento_Checkout/js/model/quote'
    ],
    function (Component, $, priceUtils, urlBuilder, loader, quote) {
        'use strict';

        return Component.extend({
            defaults: {
                template: 'Stripeofficial_GiroPay/payment/form',
                code: 'stripegiropay',
                active: false
            },

            stripeToken: false,
            stripeRedirectUrl: false,
            stripe: false,

            /**
             * Set list of observable attributes
             *
             * @returns {exports.initObservable}
             */
            initObservable: function () {
                this._super()
                    .observe(['active']);

                return this;
            },

            initialize: function () {
                this._super();
                this.stripe = Stripe(this.getPublicKey());
            },

            getCode: function () {
                return this.code;
            },

            getTitle: function () {
                return window.checkoutConfig.payment[this.getCode()].title;
            },

            isActive: function () {
                var active = window.checkoutConfig.payment[this.getCode()].active;
                var quoteData = window.checkoutConfig.quoteData;

                if (quoteData.quote_currency_code !== 'EUR') {
                    active = false;
                }

                var checkAllowSpecificCountry = window.checkoutConfig.payment[this.getCode()].allowspecific;
                if (checkAllowSpecificCountry == 1) {
                    var checkSpecificCountry = window.checkoutConfig.payment[this.getCode()].specificcountry;
                    var shipcountry = quote.billingAddress._latestValue.countryId;
                    var countryArray = checkSpecificCountry.split(",");
                    var validcountry = countryArray.indexOf(shipcountry);
                    if (validcountry == -1) {
                        active = false;
                    }
                }

                if (active == false) {
                    jQuery("#stripe_giropay").hide();
                } else {
                    jQuery("#stripe_giropay").show();
                }

                this.active(active);
                return active;
            },

            getPublicKey: function () {
                return window.checkoutConfig.payment[this.getCode()].public_key;
            },

            getData: function () {
                return {
                    'method': this.item.method,
                    'additional_data': {
                        "stripeToken": this.stripeToken
                    }
                };
            },
            imagePath: function () {
                // Getting base url
                var baseUrl = require.s.contexts._.config.baseUrl;
                return baseUrl + 'Stripeofficial_Core/stripe/giropay.png';
            },

            afterPlaceOrder: function () {
                window.location.href = this.stripeRedirectUrl;
            },
            isValidate: function () {
                var currentFormKey = window.checkoutConfig.formKey;
                var postFormKey = jQuery("input[name='form_key']").val();
                if (currentFormKey != "" && currentFormKey != postFormKey) {
                    return false;
                }
                return true;
            },

            stripePlaceOrder: function () {
                loader.startLoader();
                var self = this;
                if (!this.isValidate()) {
                    self.messageContainer.addErrorMessage({message: "Form key not validate. Please refresh the page and try again"});
                    loader.stopLoader();
                } else {
                    var customerEmail = window.StripeCustomerData.customer_email;
                    var customerName = window.StripeCustomerData.fullname;
                    var amount = quote.getTotals()()['base_grand_total'];
                    amount = Math.round(parseFloat(amount).toFixed(2) * 100);

                    var requestObject = {
                        type: 'giropay',
                        amount: amount,
                        currency: 'eur',
                        owner: {
                            name: customerName,
                            email: customerEmail,
                            address: {
                                line1: window.StripeCustomerData.street,
                                city: window.StripeCustomerData.city,
                                state: window.StripeCustomerData.state,
                                country: window.StripeCustomerData.country
                            }
                        },
                        redirect: {
                            return_url: urlBuilder.build('stripe/giropay/returnurl')
                        }
                    };

                    requestObject.statement_descriptor = window.checkoutConfig.payment['stripecore'].merchant_name;

                    this.stripe.createSource(requestObject).then(function (result) {
                        if (typeof result.error !== 'undefined') {
                            loader.stopLoader();
                            self.messageContainer.addErrorMessage(result.error);
                        } else {
                            self.stripeToken = result.source.id;
                            self.redirectAfterPlaceOrder = false;
                            self.stripeRedirectUrl = result.source.redirect.url;
                            self.placeOrder();
                        }
                    });
                }
            }
        });
    }
);