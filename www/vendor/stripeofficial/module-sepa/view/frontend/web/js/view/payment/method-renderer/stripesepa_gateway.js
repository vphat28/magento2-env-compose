define(
    [
        'Magento_Checkout/js/view/payment/default',
        'jquery',
        'Magento_Catalog/js/price-utils',
        'mage/url',
        'Magento_Checkout/js/model/full-screen-loader',
        'Magento_Checkout/js/model/quote'
    ],
    function (Component, $, priceUtils, urlBuilder, loader) {
        'use strict';

        return Component.extend({
            defaults: {
                template: 'Stripeofficial_SEPA/payment/form',
                code: 'stripesepa',
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
                    .observe(['active', , 'iban', 'sepaagreement']);

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
                    jQuery("#stripe_sepa").hide();
                } else {
                    jQuery("#stripe_sepa").show();
                }


                this.active(active);
                return active;
            },
            imagePath: function () {
                // Getting base url
                var baseUrl = require.s.contexts._.config.baseUrl;
                return baseUrl + 'Stripeofficial_Core/stripe/sepa.png';
            },

            getPublicKey: function () {
                return window.checkoutConfig.payment[this.getCode()].public_key;
            },

            isValidIBANNumber: function () {
                var CODE_LENGTHS = {
                    AD: 24, AE: 23, AT: 20, AZ: 28, BA: 20, BE: 16, BG: 22, BH: 22, BR: 29,
                    CH: 21, CR: 21, CY: 28, CZ: 24, DE: 22, DK: 18, DO: 28, EE: 20, ES: 24,
                    FI: 18, FO: 18, FR: 27, GB: 22, GI: 23, GL: 18, GR: 27, GT: 28, HR: 21,
                    HU: 28, IE: 22, IL: 23, IS: 26, IT: 27, JO: 30, KW: 30, KZ: 20, LB: 28,
                    LI: 21, LT: 20, LU: 20, LV: 21, MC: 27, MD: 24, ME: 22, MK: 19, MR: 27,
                    MT: 31, MU: 30, NL: 18, NO: 15, PK: 24, PL: 28, PS: 29, PT: 25, QA: 29,
                    RO: 24, RS: 22, SA: 24, SE: 24, SI: 19, SK: 24, SM: 27, TN: 24, TR: 26
                };
                var iban = String(this.iban()).toUpperCase().replace(/[^A-Z0-9]/g, ''), // keep only alphanumeric characters
                    code = iban.match(/^([A-Z]{2})(\d{2})([A-Z\d]+)$/), // match and capture (1) the country code, (2) the check digits, and (3) the rest
                    digits;
                // check syntax and length
                if (!code || iban.length !== CODE_LENGTHS[code[1]]) {
                    var invalid = "**Please Enter Valid IBAN number";
                    return invalid;
                }
                // rearrange country code and check digits, and convert chars to ints
                digits = (code[3] + code[1] + code[2]).replace(/[A-Z]/g, function (letter) {
                    return letter.charCodeAt(0) - 55;
                });
                // final check

                var checksum = digits.slice(0, 2), fragment;
                for (var offset = 2; offset < digits.length; offset += 7) {
                    fragment = String(checksum) + digits.substring(offset, offset + 7);
                    checksum = parseInt(fragment, 10) % 97;

                }
            },

            getData: function () {
                return {
                    'method': this.item.method,
                    'additional_data': {
                        "stripeToken": this.stripeToken
                    }
                };
            },

            getInstructions: function () {
                return window.checkoutConfig.payment[this.getCode()].displaytext;
            },

            placeordervalidation: function () {

                document.getElementById("sepaplace").disabled = true;

            },

            useSepa: function () {
                if (this.sepaagreement()) {
                    document.getElementById("sepaplace").disabled = false;
                }
                else {
                    document.getElementById("sepaplace").disabled = true;
                }
                return true;

            },
            isValidate: function () {
                var currentFormKey = window.checkoutConfig.formKey;
                var postFormKey = jQuery("input[name='form_key']").val();
                if (currentFormKey != "" && currentFormKey != postFormKey) {
                    return false;
                }
                return true;
            },

            placeStripeOrder: function () {
                loader.startLoader();
                var self = this;
                if (!this.isValidate()) {
                    self.messageContainer.addErrorMessage({message: "Form key not validate. Please refresh the page and try again"});
                    loader.stopLoader();
                } else {
                    var customerEmail = window.StripeCustomerData.customer_email;
                    var customerName = window.StripeCustomerData.fullname;
                    var isTest = window.checkoutConfig.payment[this.getCode()].is_test;
                    var requestObject = {
                        type: 'sepa_debit',
                        sepa_debit: {iban: self.iban(),},
                        mandate: {notification_method: 'email',},
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
                        }
                    };

                    if (isTest) {
                        requestObject.owner.name = 'succeeding_charge';
                    }

                    this.stripe.createSource(requestObject).then(function (result) {

                        loader.stopLoader();
                        if (typeof result.error !== 'undefined') {
                            self.messageContainer.addErrorMessage(result.error);
                        } else {
                            self.stripeToken = result.source.id;
                            self.placeOrder();
                        }
                    });
                }
            }
        });
    }
);