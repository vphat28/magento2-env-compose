<?php

namespace Stripeofficial\Core\Test\Unit;

use Magento\Framework\TestFramework\Unit\Helper\ObjectManager;
use Stripe\Charge;
use Stripeofficial\Core\Model\Payment;
use Stripe\Customer;
use Stripe\Stripe;
use PHPUnit\Framework\TestCase;

class CreditCardTest extends TestCase
{
    /**
     * @var Payment
     */
    protected $creditCard;

    public function setUp()
    {
        $objectManager = new ObjectManager($this);
        $this->creditCard = $objectManager->getObject(Payment::class);
        Stripe::setApiKey('sk_test_nKwrZbzCmnFwSDsG0IlGx24G');
    }

    /**
     * Test charge command with valid source data
     */
    public function testChargeWithSource()
    {
        $result = $this->creditCard->charge("src_1BiJ0TL36OMdUBmUepd2x9M7", 1000, 'usd', 'cus_C6W2EHPouc3SYt');
        $this->assertInstanceOf(Charge::class, $result);
    }

    /**
     * Test charge command with customer id and token data
     */
    public function testChargeWithNormalToken()
    {
        $result = $this->creditCard->charge("src_1BiJ0TL36OMdUBmUepd2x9M7", 1000, 'usd', 'cus_C6W2EHPouc3SYt');
        $this->assertInstanceOf(Charge::class, $result);
    }

    /**
     * Test create customer id
     */
    public function testCreateCustomerToken()
    {
        $result = $this->creditCard->createCustomerToken('example@stripe.com');
        $this->assertInstanceOf(Customer::class, $result);
    }
}
