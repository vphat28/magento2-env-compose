<?php
namespace Stripeofficial\Core\Api;

use Magento\Sales\Model\Order;
use Stripe\Charge;
use Stripe\Customer;
use Stripe\Refund;
use Stripe\Source;

/**
 * Interface for interact with payment api
 * @api
 */
interface PaymentInterface
{
    /**
     * @param $capture
     * @param $sourceToken
     * @param $amount
     * @param $currencyCode
     * @param $customerId
     * @param string $method
     * @param array $metaData
     * @return mixed
     */
    public function charge($capture, $sourceToken, $amount, $currencyCode, $customerId, $method = null, $metaData = null);

    /**
     * Create customer object
     *
     * @param $email
     * @return Customer
     */
    public function createCustomerToken($email);

    /**
     * @param $chargeId
     * @param $metadata
     * @param null|Order $order
     * @return Charge
     */
    public function updateChargeMetadata($chargeId, $metadata, $order = null);

    /**
     * @param string $chargeId
     * @param string $amount
     * @param array $metadata
     * @return Refund
     */
    public function refund($chargeId, $amount, $metadata = null);

    /**
     * @param string $chargeId
     * @param string $amount
     * @return Charge
     */
    public function capture($chargeId, $amount);

    /**
     * @param string $sourceId
     * @param string $amount
     * @param string $currency
     * @param string$returnUrl
     * @return Source
     */
    public function create3DSSource($sourceId, $amount, $currency, $returnUrl);

    /**
     * @param string $sourceId
     * @return Source
     */
    public function getSource($sourceId);

    /**
     * @param string $chargeId
     * @return Charge
     */
    public function getCharge($chargeId);
}
