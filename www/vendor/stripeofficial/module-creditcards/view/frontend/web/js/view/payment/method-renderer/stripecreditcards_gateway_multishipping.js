define(
    [
        'Stripeofficial_CreditCards/js/view/payment/method-renderer/stripecreditcards_gateway',
        'Magento_Checkout/js/model/full-screen-loader',
        'jquery'
    ],
    function (Component, fullscreenLoader, $) {
        'use strict';

        return Component.extend({
            defaults: {
                template: 'Stripeofficial_CreditCards/payment/form-multishipping',
                code: 'stripecreditcards',
                active: false
            },

            stripeTokenHandler: function (token) {
                this.stripeToken = token.id;
                this.stripeCard3ds = token.card.three_d_secure;
                $('#stripecards-input-hidden-stripeToken').val(token.id);
                $('#stripecards-input-hidden-customerEmail').val(window.StripeCustomerData.customer_email);
                $('#stripecards-input-hidden-stripeCard3ds').val(token.card.three_d_secure);
            },
            
            stripeInit: function () {
                var self = this;
                this._super();
                $('#multishipping-billing-form').submit(function (e) {
                    if ($('#p_method_stripecreditcards').attr('checked') !== 'checked') {
                        return true;
                    }
                    console.log(self.stripeToken);
                    console.log(self.stripeCard3ds);
                    if (self.stripeToken === false && self.stripeCard3ds === false) {
                        e.preventDefault();
                        return false;
                    } else {
                        return true;
                    }
                });

                $('#payment-continue').click(
                    function (e) {
                        e.preventDefault();
                        self.stripePlaceOrder();
                    }
                );
            },

            stripePlaceOrder: function () {
                var self = this;

                if (self.stripeErrors !== false) {
                    return;
                }

                fullscreenLoader.startLoader();
                {
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
                                $('#multishipping-billing-form').trigger('submit');
                            }
                        }

                        fullscreenLoader.stopLoader();
                    });
                }
            }
        });
    }
);