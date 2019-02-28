<?php

namespace Stripeofficial\Core\Setup;

use Magento\Customer\Model\Customer;
use Magento\Eav\Setup\EavSetup;
use Magento\Eav\Setup\EavSetupFactory;
use Magento\Framework\Setup\ModuleContextInterface;
use Magento\Framework\Setup\ModuleDataSetupInterface;
use Magento\Framework\Setup\UpgradeDataInterface;

class UpgradeData implements UpgradeDataInterface
{
    /**
     * @var EavSetupFactory
     */
    protected $eavSetupFactory;

    /**
     * UpgradeSchema constructor.
     * @param EavSetupFactory $eavSetupFactory
     */
    public function __construct(EavSetupFactory $eavSetupFactory)
    {
        $this->eavSetupFactory = $eavSetupFactory;
    }

    /**
     * @param ModuleDataSetupInterface $setup
     * @param ModuleContextInterface $context
     */
    public function upgrade(ModuleDataSetupInterface $setup, ModuleContextInterface $context)
    {
        if (version_compare('1.0.5', $context->getVersion()) === 1) {
            /** @var EavSetup $eavSetup */
            $eavSetup = $this->eavSetupFactory->create(['setup' => $setup]);
            $eavSetup->addAttribute(
                Customer::ENTITY,
                'stripe_customer_id',
                [
                    'type'         => 'varchar',
                    'label'        => 'Stripe Customer ID',
                    'input'        => 'text',
                    'required'     => false,
                    'visible'      => false,
                    'user_defined' => false,
                    'position'     => 999,
                    'system'       => 0,
                    'is_system'       => 1,
                    'global'        => true
                ]
            );
        }
    }
}
