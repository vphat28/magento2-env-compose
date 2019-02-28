<?php

namespace Stripeofficial\Core\Model;

use Magento\Framework\App\Config\ScopeConfigInterface;
use Magento\Sales\Model\Order;
use Magento\Store\Model\StoreManagerInterface;
use Stripe\Charge as StripeCharge;
use Stripe\Collection;
use Stripeofficial\Core\Api\PaymentInterface;
use Stripeofficial\Core\Helper\Data;
use Stripe\Customer;
use Stripe\Error\InvalidRequest;
use Stripe\Refund;
use Stripe\Source as StripeSource;
use Stripe\Stripe;

class Payment implements PaymentInterface
{
    const PLUGIN_VERSION = '1.0.0';

    const DEFAULT_STATEMENT = 'Default';

    const API_VERSION = '2017-06-05';

    /**
     * @var ScopeConfigInterface
     */
    protected $scopeConfig;

    /**
     * @var Data
     */
    protected $data;

    /**
     * @var StoreManagerInterface
     */
    protected $storeManager;

    /**
     * @var Logger
     */
    protected $logger;

    /**
     * Payment constructor.
     * @param ScopeConfigInterface $scopeConfig
     * @param Data $data
     * @param StoreManagerInterface $storeManager
     * @param Logger $logger
     */
    public function __construct(
        ScopeConfigInterface $scopeConfig,
        Data $data,
        StoreManagerInterface $storeManager,
        Logger $logger
    )
    {
        $this->scopeConfig = $scopeConfig;
        $this->data = $data;
        $this->storeManager = $storeManager;
        $this->logger = $logger;
    }

    /**
     * Set api key
     */
    public function init()
    {
        Stripe::setAppInfo(
            'Magento2 Stripe Module',
            self::PLUGIN_VERSION,
            'PLACEHOLDER_LINK_TO_MARKETPLACE'
        );

        Stripe::setApiKey($this->data->getAPISecretKey());
        Stripe::setApiVersion(self::API_VERSION);
    }

    /**
     * @inheritdoc
     */
    public function charge($capture, $token, $amount, $currencyCode, $customerId, $method = null, $metaData = null, $saveSource = null)
    {
        $statement = $this->data->getStatementDescriptor();
        $this->init();
        $request = [
            "amount" => $amount,
            "currency" => $currencyCode,
            "source" => $token,
            "metadata" => $metaData,
        ];

        if (!empty($customerId)) {
            $request['customer'] = $customerId;
        }

        if (!in_array($method, ['giropay', 'sofort','bancontact','sepa', 'sepa_debit', 'p24','ideal', 'alipay'])) {
            // Add statement_descriptior when payment is not redirect methods
            $request['capture'] = $capture;

            if ($currencyCode == 'jpy') {
                $statement = self::DEFAULT_STATEMENT;
            }

            if (!empty($statement)) {
                $request['statement_descriptor'] = $statement;
            }
        }

        if ($customerId !== null && $saveSource === true) {
            $source = $this->getSource($token);

            if ($source->usage == 'reusable') {
                $request["customer"] = $customerId;
                $customer = Customer::retrieve($customerId);
                /** @var Collection $collection */
                $collection = $customer->sources;

                if ($collection->total_count > 5) {
                    $data = $collection->all();
                    $i = 0;
                    foreach ($data->data as $c) {
                        $i++;
                        if ($i < 5) { continue; }
                        /** @var StripeSource $c */
                        $c->detach();
                    }
                }

                $customer->sources->create(["source" => $token]);
            }
        }

        if ($this->data->getDebugMode()) {
            $this->logger->info('Make charge request', $request);
        }

        return StripeCharge::create($request, [
            "idempotency_key" => md5(json_encode($request)),
        ]);
    }

    /**
     * @inheritdoc
     */
    public function createCustomerToken($email)
    {
        $this->init();
        return Customer::create([
            'email' => $email,
        ]);
    }

    /**
     * @inheritdoc
     */
    public function updateChargeMetadata($chargeId, $metadata, $order = null)
    {
        $this->init();
        $charge = StripeCharge::retrieve($chargeId);
        $charge->metadata = $metadata;
        $source = $charge->source;
        $charge->description = __('Magento Order ') . $metadata['Magento Order ID'].' - '.$metadata['customer_email'];

        /** @var Order $order */
        if ($order !== null) {
            $shipAddress = $order->getShippingAddress();

            if (!empty($shipAddress)) {
                $ship = $order->getShippingAddress()->convertToArray();
                $shipMethod = $order->getShippingMethod(true);

                // Shipping only applicable with source type card
                if ($source->type == 'card') {
                    $charge->shipping = [
                        'address' => [
                            'line1' => $ship['street'],
                            'city' => $ship['city'],
                            'country' => $ship['country_id'],
                            'postal_code' => $ship['postcode'],
                            'state' => $ship['region'],
                        ],
                        'name' => $order->getCustomerName(),
                        'carrier' => (string)$shipMethod->getData('carrier_code'),
                        'phone' => (string)$order->getShippingAddress()->getTelephone(),
                    ];
                }
            }
        }

        return $charge->save();
    }

    /**
     * @inheritdoc
     */
    public function refund($chargeId, $amount, $metadata = null)
    {
        $this->init();
        return Refund::create([
            'charge' => $chargeId,
            'amount' => $amount,
            'metadata' => $metadata,
        ]);
    }

    /**
     * @inheritdoc
     */
    public function capture($chargeId, $amount)
    {
        $this->init();
        $ch = StripeCharge::retrieve($chargeId);

        return $ch->capture([
            'amount' => $amount
        ]);
    }

    /**
     * @inheritdoc
     */
    public function create3DSSource($sourceId, $amount, $currency, $returnUrl)
    {
        $this->init();
        $source = StripeSource::create([
            "amount" => $amount,
            "currency" => $currency,
            "type" => "three_d_secure",
            "three_d_secure" => [
                "card" => $sourceId,
            ],
            "redirect" => [
                "return_url" => $returnUrl
            ]
        ]);

        return $source;
    }

    /**
     * @inheritdoc
     */
    public function getSource($sourceId)
    {
        $this->init();
        return StripeSource::retrieve($sourceId);
    }

    /**
     * @inheritdoc
     */
    public function getCharge($chargeId)
    {
        $this->init();
        return StripeCharge::retrieve($chargeId);
    }
}
