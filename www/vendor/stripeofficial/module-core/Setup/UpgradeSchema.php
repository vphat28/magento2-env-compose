<?php

namespace Stripeofficial\Core\Setup;

use Magento\Framework\DB\Ddl\Table;
use Magento\Framework\Setup\ModuleContextInterface;
use Magento\Framework\Setup\SchemaSetupInterface;
use Magento\Framework\Setup\UpgradeSchemaInterface;

class UpgradeSchema implements UpgradeSchemaInterface
{
    /**
     * @param SchemaSetupInterface $setup
     * @param ModuleContextInterface $context
     * @throws \Zend_Db_Exception
     */
    public function upgrade(SchemaSetupInterface $setup, ModuleContextInterface $context)
    {
        $installer = $setup;
        $installer->startSetup();
        $this->installTable($setup);
        $eavTable = $installer->getTable('customer_entity');

        $columns = [
            'stripe_customer_id' => [
                'type' => Table::TYPE_TEXT,
                'nullable' => true,
                'comment' => "Stripe Customer ID",
            ]
        ];

        $connection = $installer->getConnection();

        foreach ($columns as $name => $definition) {
            $connection->addColumn($eavTable, $name, $definition);
        }

        $installer->endSetup();
    }

    /**
     * Create table in database
     * @param SchemaSetupInterface $setup
     * @throws \Zend_Db_Exception
     */
    private function installTable($setup)
    {
        $table = $setup->getConnection()
            ->newTable($setup->getTable('stripe_source'))
            ->addColumn(
                'entity_id',
                Table::TYPE_INTEGER,
                null,
                ['identity' => true, 'unsigned' => true, 'nullable' => false,
                    'primary' => true],
                'Entity	ID'
            )
            ->addColumn(
                'source_id',
                Table::TYPE_TEXT,
                64,
                [],
                'Source ID'
            )
            ->addColumn(
                'reference_order_id',
                Table::TYPE_TEXT,
                64,
                [],
                'Reference Order ID'
            );
        $setup->getConnection()->createTable($table);
        $table = $setup->getConnection()
            ->newTable($setup->getTable('stripe_charge'))
            ->addColumn(
                'entity_id',
                Table::TYPE_INTEGER,
                null,
                ['identity' => true, 'unsigned' => true, 'nullable' => false,
                    'primary' => true],
                'Entity	ID'
            )
            ->addColumn(
                'charge_id',
                Table::TYPE_TEXT,
                64,
                [],
                'Charge ID'
            )
            ->addColumn(
                'reference_order_id',
                Table::TYPE_TEXT,
                64,
                [],
                'Reference Order ID'
            );
        $setup->getConnection()->createTable($table);

        $table = $setup->getConnection()
            ->newTable($setup->getTable('stripe_webhook_queue'))
            ->addColumn(
                'entity_id',
                Table::TYPE_INTEGER,
                null,
                ['identity' => true, 'unsigned' => true, 'nullable' => false,
                    'primary' => true],
                'Entity	ID'
            )
            ->addColumn(
                'event_data',
                Table::TYPE_TEXT,
                Table::MAX_TEXT_SIZE,
                [],
                'Event data'
            )
            ->addColumn(
                'created_at',
                Table::TYPE_TIMESTAMP,
                null,
                ['nullable' => false, 'default' => Table::TIMESTAMP_INIT_UPDATE],
                'Created At'
            );
        $setup->getConnection()->createTable($table);
    }
}
