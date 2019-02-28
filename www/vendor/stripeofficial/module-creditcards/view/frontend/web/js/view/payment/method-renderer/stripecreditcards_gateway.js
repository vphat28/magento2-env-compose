define(
    [
        'Magento_Payment/js/view/payment/cc-form',
        'jquery',
        'mage/translate',
        'Magento_Checkout/js/action/redirect-on-success',
        'Magento_Checkout/js/model/full-screen-loader',
        'Magento_Checkout/js/model/quote',
        'Magento_Vault/js/view/payment/vault-enabler',
        'Magento_Ui/js/modal/modal'
    ],
    function (Component, $, $t, redirectOnSuccessAction, fullscreenLoader, quote, VaultEnabler) {
        'use strict';

        return Component.extend({
            defaults: {
                template: 'Stripeofficial_CreditCards/payment/form',
                code: 'stripecreditcards',
                active: false
            },

            stripe: false,
            stripeCard: false,
            stripeToken: false,
            stripeErrors: false,
            stripeCard3ds: false,
            redirec3dstAfterOrder: false,
            // Message to display when card doesn't support 3ds but 3ds mode enabled
            message3dsRequire: $('<div>' + $t('Your transaction could not be completed at this time.  For your protection, Credit Cards processed on this site must be verified with 3D secure, Verified by Visa or other Payer Authentication services supported by your card.  Please try again with an alternate Credit Card') + '</div>').modal({
                autoOpen: false,
                buttons: [],
                responsive: true
            }),
            redirectingTo3ds: $('<div>' + $t('You will be redirected to 3ds verification page of your card\'s issuer...') + '</div>').modal({
                autoOpen: false,
                buttons: [],
                responsive: true
            }),

            visaModal: false,
            masterCardModal: false,

            /**
             * @returns this
             */
            initialize: function () {
                this._super();
                this.vaultEnabler = new VaultEnabler();
                this.vaultEnabler.setPaymentCode(this.getVaultCode());

                return this;
            },

            /**
             * @returns {Bool}
             */
            isVaultEnabled: function () {
                return this.vaultEnabler.isVaultEnabled();
            },

            /**
             * @returns {String}
             */
            getVaultCode: function () {
                return window.checkoutConfig.payment[this.getCode()].vaultCode;
            },

            openVisaModal: function () {
                if (this.visaModal == false) {
                    var content = window.checkoutConfig.payment[this.getCode()].cms_blocks.visa;
                    this.visaModal = $('<div/>').html(content).modal({autoOpen: false, buttons: [], responsive: true});
                }

                this.visaModal.modal('openModal');
            },

            openMasterCardModal: function () {
                if (this.masterCardModal == false) {
                    var content = window.checkoutConfig.payment[this.getCode()].cms_blocks.master;
                    this.masterCardModal = $('<div/>').html(content).modal({
                        autoOpen: false,
                        buttons: [],
                        responsive: true,
                        type: 'popup'
                    });
                }

                this.masterCardModal.modal('openModal');
            },

            imageMasterCardPath: function () {
                // Getting base url
                var baseUrl = require.s.contexts._.config.baseUrl;
                return baseUrl + 'Stripeofficial_CreditCards/images/verified-mastercard.png';
            },

            imageVisaPath: function () {
                // Getting base url
                var baseUrl = require.s.contexts._.config.baseUrl;
                return baseUrl + 'Stripeofficial_CreditCards/images/verified-visa.png';
            },

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

            stripeTokenHandler: function (token) {
                this.stripeToken = token.id;
                this.stripeCard3ds = token.card.three_d_secure;
            },

            stripeInit: function () {
                this.stripe = Stripe(this.getPublicKey());
                var self = this;
                var elements = this.stripe.elements();
                var configStyle = window.checkoutConfig.payment[this.getCode()].form_styles;

                // Custom styling can be passed to options when creating an Element.
                var styles = {
                    base: {
                        // Add your base input styles here. For example:
                        fontSize: configStyle.font_size,
                        color: configStyle.font_color
                    }
                };

                // Create an instance of the card Element
                this.stripeCard = elements.create('card', {
                    style: styles,
                    hidePostalCode: true
                });

                // Add an instance of the card Element into the `card-element` <div>
                this.stripeCard.mount('#stripe-card-element');
                this.stripeCard.addEventListener('change', function (event) {
                    if (typeof event.brand !== "undefined") {

                        var stripeCtypes = self.getStripeCCAvailableTypes();
                        if (event.brand in stripeCtypes) {
                            var cType = stripeCtypes[event.brand];

                            if (!(cType in self.getCcAvailableTypes())) {
                                event.error = {
                                    message: $t("This card brand is not supported"),
                                    code: "card_not_supported",
                                    type: "validation_error"
                                };
                            }
                        }
                    }

                    var displayError = document.getElementById('stripe-card-errors');
                    if (event.error) {
                        displayError.textContent = event.error.message;
                        self.stripeErrors = event.error;
                    } else {
                        self.stripeErrors = false;
                        displayError.textContent = '';
                    }
                });
            },

            getCode: function () {
                return this.code;
            },

            getTitle: function () {
                return window.checkoutConfig.payment[this.getCode()].title;
            },

            isActive: function () {
                var active = window.checkoutConfig.payment[this.getCode()].active;

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
                    jQuery("#stripe_cc").hide();
                } else {
                    jQuery("#stripe_cc").show();
                }

                this.active(active);
                return active;
            },

            getPublicKey: function () {
                return window.checkoutConfig.payment[this.getCode()].public_key;
            },

            validate: function () {
                var $form = $('#stripecreditcards-payment-form');
                return $form.validation() && $form.validation('isValid');
            },

            /**
             * Get list of available credit card types
             * @returns {Object}
             */
            getCcAvailableTypes: function () {
                return window.checkoutConfig.payment[this.getCode()].availableCardTypes;
            },

            /**
             * Get stripe cc type codes
             *
             * @returns {Object}
             */
            getStripeCCAvailableTypes: function () {
                return window.checkoutConfig.payment[this.getCode()].stripeCCTypes;
            },

            /**
             * Get list of available credit card types values
             * @returns {Object}
             */
            getCcAvailableTypesValues: function () {
                return _.map(this.getCcAvailableTypes(), function (value, key) {
                    return {
                        'value': key,
                        'type': value
                    };
                });
            },

            getData: function () {
                var data = {
                    'method': this.getCode(),
                    'additional_data': {
                        "stripeToken": this.stripeToken,
                        "currencyCode": window.checkoutConfig.quoteData.quote_currency_code.toLowerCase(),
                        "customerEmail": window.StripeCustomerData.customer_email,
                        "stripeCard3ds": this.stripeCard3ds
                    }
                };

                this.vaultEnabler.visitAdditionalData(data);

                return data;
            },
            imagePath: function () {
                // Getting base url
                var baseUrl = require.s.contexts._.config.baseUrl;
                return baseUrl + 'Stripeofficial_Core/stripe/stripe.png';
            },

            afterPlaceOrder: function () {
                // Override value in parent class
                if (this.redirec3dstAfterOrder) {
                    // Override this so it won't redirect to success page
                    this.redirectAfterPlaceOrder = false;
                    this.redirectingTo3ds.modal('openModal');
                    var ajaxUrl = window.checkoutConfig.payment[this.getCode()].ajax_3ds;
                    $.post(ajaxUrl, {})
                        .done(function (data) {
                            // Redirect to 3ds verification page
                            window.location.replace(data.toString());
                        });
                }
            },

            getconfigEnable3ds: function () {
                return window.checkoutConfig.payment[this.getCode()].enable_3ds == "1" ? true : false;
            },

            /**
             * Check source if we need to use 3ds
             * @param source
             * @returns {boolean}
             */
            check3dsNeeded: function (source) {
                var configEnable3ds = this.getconfigEnable3ds();
                var shouldGo3DS = false;

                if (source.card.three_d_secure == 'required') {
                    shouldGo3DS = true;
                } else if (configEnable3ds == 1) {
                    if (source.card.three_d_secure != 'not_supported') {
                        shouldGo3DS = true;
                    }
                }

                return shouldGo3DS;
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
                var self = this;

                if (self.stripeErrors !== false) {
                    return;
                }
                fullscreenLoader.startLoader();
                if (!this.isValidate()) {
                    self.messageContainer.addErrorMessage({message: "Form key not validate. Please refresh the page and try again"});
                    loader.stopLoader();
                } else {
                    var requestObject = {
                        owner: {
                            name: window.StripeCustomerData.fullname,
                            address: {
                                line1: window.StripeCustomerData.street,
                                city: window.StripeCustomerData.city,
                                state: window.StripeCustomerData.state,
                                country: window.StripeCustomerData.country
                            }
                        }
                    };


                    this.stripe.createSource(this.stripeCard, requestObject).then(function (result) {
                        if (result.error) {
                            // Inform the customer that there was an error
                            var errorElement = document.getElementById('stripe-card-errors');
                            errorElement.textContent = result.error.message;
                        } else {
                            if (self.check3dsNeeded(result.source)) {
                                self.redirec3dstAfterOrder = true;
                            }

                            var configEnable3ds = self.getconfigEnable3ds();

                            // If 3ds secure enable and card not support
                            // then display a message to user
                            if (configEnable3ds && result.source.card.three_d_secure == 'not_supported') {
                                self.message3dsRequire.modal('openModal');
                            } else {
                                self.stripeTokenHandler(result.source);
                                self.placeOrder();
                            }
                        }

                        fullscreenLoader.stopLoader();
                    });
                }
            }
        });
    }
);