-- Adminer 4.6.3 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP TABLE IF EXISTS `adminnotification_inbox`;
CREATE TABLE `adminnotification_inbox` (
  `notification_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Notification id',
  `severity` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Problem type',
  `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Create date',
  `title` varchar(255) NOT NULL COMMENT 'Title',
  `description` text COMMENT 'Description',
  `url` varchar(255) DEFAULT NULL COMMENT 'Url',
  `is_read` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Flag if notification read',
  `is_remove` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Flag if notification might be removed',
  PRIMARY KEY (`notification_id`),
  KEY `ADMINNOTIFICATION_INBOX_SEVERITY` (`severity`),
  KEY `ADMINNOTIFICATION_INBOX_IS_READ` (`is_read`),
  KEY `ADMINNOTIFICATION_INBOX_IS_REMOVE` (`is_remove`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Adminnotification Inbox';

INSERT INTO `adminnotification_inbox` (`notification_id`, `severity`, `date_added`, `title`, `description`, `url`, `is_read`, `is_remove`) VALUES
(1,	4,	'2019-02-18 15:05:38',	'Deprecation Notice',	'Catalog Search is currently configured to use the MySQL engine, which has been deprecated. Consider migrating to one of\nthe Elasticsearch engines now to ensure there are no service interruptions during your next upgrade.',	'',	0,	0);

DROP TABLE IF EXISTS `admin_passwords`;
CREATE TABLE `admin_passwords` (
  `password_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Password Id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'User Id',
  `password_hash` varchar(100) DEFAULT NULL COMMENT 'Password Hash',
  `expires` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Deprecated',
  `last_updated` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Last Updated',
  PRIMARY KEY (`password_id`),
  KEY `ADMIN_PASSWORDS_USER_ID` (`user_id`),
  CONSTRAINT `ADMIN_PASSWORDS_USER_ID_ADMIN_USER_USER_ID` FOREIGN KEY (`user_id`) REFERENCES `admin_user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Admin Passwords';

INSERT INTO `admin_passwords` (`password_id`, `user_id`, `password_hash`, `expires`, `last_updated`) VALUES
(1,	1,	'4de40a04308bae00f2ac17ff53528f60c3aa16b3470ba9a9b323f90286b86554:OhME3fer71IvhyNBfLKwExbwK46iOh5p:1',	0,	1550502341);

DROP TABLE IF EXISTS `admin_system_messages`;
CREATE TABLE `admin_system_messages` (
  `identity` varchar(100) NOT NULL COMMENT 'Message id',
  `severity` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Problem type',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Create date',
  PRIMARY KEY (`identity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Admin System Messages';

INSERT INTO `admin_system_messages` (`identity`, `severity`, `created_at`) VALUES
('da332d712f3215b9b94bfa268c398323',	2,	'2019-02-18 15:07:11');

DROP TABLE IF EXISTS `admin_user`;
CREATE TABLE `admin_user` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'User ID',
  `firstname` varchar(32) DEFAULT NULL COMMENT 'User First Name',
  `lastname` varchar(32) DEFAULT NULL COMMENT 'User Last Name',
  `email` varchar(128) DEFAULT NULL COMMENT 'User Email',
  `username` varchar(40) DEFAULT NULL COMMENT 'User Login',
  `password` varchar(255) NOT NULL COMMENT 'User Password',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'User Created Time',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'User Modified Time',
  `logdate` timestamp NULL DEFAULT NULL COMMENT 'User Last Login Time',
  `lognum` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'User Login Number',
  `reload_acl_flag` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Reload ACL',
  `is_active` smallint(6) NOT NULL DEFAULT '1' COMMENT 'User Is Active',
  `extra` text COMMENT 'User Extra Data',
  `rp_token` text COMMENT 'Reset Password Link Token',
  `rp_token_created_at` timestamp NULL DEFAULT NULL COMMENT 'Reset Password Link Token Creation Date',
  `interface_locale` varchar(16) NOT NULL DEFAULT 'en_US' COMMENT 'Backend interface locale',
  `failures_num` smallint(6) DEFAULT '0' COMMENT 'Failure Number',
  `first_failure` timestamp NULL DEFAULT NULL COMMENT 'First Failure',
  `lock_expires` timestamp NULL DEFAULT NULL COMMENT 'Expiration Lock Dates',
  `refresh_token` text COMMENT 'Email connector refresh token',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `ADMIN_USER_USERNAME` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Admin User Table';

INSERT INTO `admin_user` (`user_id`, `firstname`, `lastname`, `email`, `username`, `password`, `created`, `modified`, `logdate`, `lognum`, `reload_acl_flag`, `is_active`, `extra`, `rp_token`, `rp_token_created_at`, `interface_locale`, `failures_num`, `first_failure`, `lock_expires`, `refresh_token`) VALUES
(1,	'xavi',	'xavi',	'vphat28@gmail.com',	'xavi',	'4de40a04308bae00f2ac17ff53528f60c3aa16b3470ba9a9b323f90286b86554:OhME3fer71IvhyNBfLKwExbwK46iOh5p:1',	'2019-02-18 15:05:41',	'2019-02-18 15:15:35',	'2019-02-18 15:14:27',	2,	0,	1,	'{\"configState\":{\"payment_us_checkmo\":\"0\",\"payment_us_moneris\":\"1\",\"payment_us_account\":\"1\",\"payment_us_recommended_solutions\":\"1\",\"payment_us_other_paypal_payment_solutions\":\"0\",\"payment_us_paypal_group_all_in_one\":\"1\",\"payment_us_paypal_payment_gateways\":\"1\",\"payment_us_other_payment_methods\":\"1\",\"payment_us_klarna_section\":\"0\",\"payment_us_amazon_payment\":\"0\",\"payment_us_banktransfer\":\"0\",\"payment_us_cashondelivery\":\"0\",\"payment_us_free\":\"0\",\"payment_us_purchaseorder\":\"0\",\"payment_us_authorizenet_directpost\":\"0\"}}',	NULL,	NULL,	'en_US',	0,	NULL,	NULL,	NULL);

DROP TABLE IF EXISTS `admin_user_session`;
CREATE TABLE `admin_user_session` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `session_id` varchar(128) NOT NULL COMMENT 'Session id value',
  `user_id` int(10) unsigned DEFAULT NULL COMMENT 'Admin User ID',
  `status` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Current Session status',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created Time',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Update Time',
  `ip` varchar(15) NOT NULL COMMENT 'Remote user IP',
  PRIMARY KEY (`id`),
  KEY `ADMIN_USER_SESSION_SESSION_ID` (`session_id`),
  KEY `ADMIN_USER_SESSION_USER_ID` (`user_id`),
  CONSTRAINT `ADMIN_USER_SESSION_USER_ID_ADMIN_USER_USER_ID` FOREIGN KEY (`user_id`) REFERENCES `admin_user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Admin User sessions table';

INSERT INTO `admin_user_session` (`id`, `session_id`, `user_id`, `status`, `created_at`, `updated_at`, `ip`) VALUES
(1,	'32e15aee0100cfac6e6e91b54916617a',	1,	2,	'2019-02-18 15:07:07',	'2019-02-18 15:14:27',	'172.22.0.1'),
(2,	'81333f5dca1eef9f8e7cc18ffaab17aa',	1,	1,	'2019-02-18 15:14:27',	'2019-02-18 15:18:48',	'172.22.0.1');

DROP TABLE IF EXISTS `amazon_customer`;
CREATE TABLE `amazon_customer` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity_id',
  `customer_id` int(10) unsigned NOT NULL COMMENT 'Customer_id',
  `amazon_id` varchar(255) NOT NULL COMMENT 'Amazon_id',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `AMAZON_CUSTOMER_CUSTOMER_ID_AMAZON_ID` (`customer_id`,`amazon_id`),
  UNIQUE KEY `AMAZON_CUSTOMER_CUSTOMER_ID` (`customer_id`),
  CONSTRAINT `AMAZON_CUSTOMER_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='amazon_customer';


DROP TABLE IF EXISTS `amazon_pending_authorization`;
CREATE TABLE `amazon_pending_authorization` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity_id',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order_id',
  `payment_id` int(10) unsigned NOT NULL COMMENT 'Payment_id',
  `authorization_id` varchar(255) DEFAULT NULL COMMENT 'Authorization_id',
  `created_at` datetime NOT NULL COMMENT 'Created_at',
  `updated_at` datetime DEFAULT NULL COMMENT 'Updated_at',
  `processed` smallint(5) unsigned DEFAULT '0' COMMENT 'Initial authorization processed',
  `capture` smallint(5) unsigned DEFAULT '0' COMMENT 'Initial authorization has capture',
  `capture_id` varchar(255) DEFAULT NULL COMMENT 'Initial authorization capture id',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_E6CCA08713FB32BB136A56837009C371` (`order_id`,`payment_id`,`authorization_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='amazon_pending_authorization';


DROP TABLE IF EXISTS `amazon_pending_capture`;
CREATE TABLE `amazon_pending_capture` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity_id',
  `capture_id` varchar(255) NOT NULL COMMENT 'Capture_id',
  `created_at` datetime NOT NULL COMMENT 'Created_at',
  `order_id` int(10) unsigned NOT NULL COMMENT 'order id',
  `payment_id` int(10) unsigned NOT NULL COMMENT 'payment id',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `AMAZON_PENDING_CAPTURE_ORDER_ID_PAYMENT_ID_CAPTURE_ID` (`order_id`,`payment_id`,`capture_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='amazon_pending_capture';


DROP TABLE IF EXISTS `amazon_pending_refund`;
CREATE TABLE `amazon_pending_refund` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity_id',
  `refund_id` varchar(255) NOT NULL COMMENT 'Refund_id',
  `created_at` datetime NOT NULL COMMENT 'Created_at',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order_id',
  `payment_id` int(10) unsigned NOT NULL COMMENT 'Payment_id',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `AMAZON_PENDING_REFUND_ORDER_ID_PAYMENT_ID_REFUND_ID` (`order_id`,`payment_id`,`refund_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='amazon_pending_refund';


DROP TABLE IF EXISTS `amazon_quote`;
CREATE TABLE `amazon_quote` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `quote_id` int(10) unsigned NOT NULL COMMENT 'Quote ID',
  `amazon_order_reference_id` varchar(255) NOT NULL COMMENT 'Amazon Order Reference ID',
  `sandbox_simulation_reference` varchar(255) DEFAULT NULL COMMENT 'Sandbox simulation reference',
  `confirmed` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Quote confirmed with Amazon',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `AMAZON_QUOTE_QUOTE_ID` (`quote_id`),
  CONSTRAINT `AMAZON_QUOTE_QUOTE_ID_QUOTE_ENTITY_ID` FOREIGN KEY (`quote_id`) REFERENCES `quote` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='amazon_quote';


DROP TABLE IF EXISTS `amazon_sales_order`;
CREATE TABLE `amazon_sales_order` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order ID',
  `amazon_order_reference_id` varchar(255) NOT NULL COMMENT 'Amazon Order Reference ID',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `AMAZON_SALES_ORDER_ORDER_ID` (`order_id`),
  CONSTRAINT `AMAZON_SALES_ORDER_ORDER_ID_SALES_ORDER_ENTITY_ID` FOREIGN KEY (`order_id`) REFERENCES `sales_order` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='amazon_sales_order';


DROP TABLE IF EXISTS `authorization_role`;
CREATE TABLE `authorization_role` (
  `role_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Role ID',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Parent Role ID',
  `tree_level` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Role Tree Level',
  `sort_order` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Role Sort Order',
  `role_type` varchar(1) NOT NULL DEFAULT '0' COMMENT 'Role Type',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'User ID',
  `user_type` varchar(16) DEFAULT NULL COMMENT 'User Type',
  `role_name` varchar(50) DEFAULT NULL COMMENT 'Role Name',
  PRIMARY KEY (`role_id`),
  KEY `AUTHORIZATION_ROLE_PARENT_ID_SORT_ORDER` (`parent_id`,`sort_order`),
  KEY `AUTHORIZATION_ROLE_TREE_LEVEL` (`tree_level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Admin Role Table';

INSERT INTO `authorization_role` (`role_id`, `parent_id`, `tree_level`, `sort_order`, `role_type`, `user_id`, `user_type`, `role_name`) VALUES
(1,	0,	1,	1,	'G',	0,	'2',	'Administrators'),
(2,	1,	2,	0,	'U',	1,	'2',	'xavi');

DROP TABLE IF EXISTS `authorization_rule`;
CREATE TABLE `authorization_rule` (
  `rule_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rule ID',
  `role_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Role ID',
  `resource_id` varchar(255) DEFAULT NULL COMMENT 'Resource ID',
  `privileges` varchar(20) DEFAULT NULL COMMENT 'Privileges',
  `permission` varchar(10) DEFAULT NULL COMMENT 'Permission',
  PRIMARY KEY (`rule_id`),
  KEY `AUTHORIZATION_RULE_RESOURCE_ID_ROLE_ID` (`resource_id`,`role_id`),
  KEY `AUTHORIZATION_RULE_ROLE_ID_RESOURCE_ID` (`role_id`,`resource_id`),
  CONSTRAINT `AUTHORIZATION_RULE_ROLE_ID_AUTHORIZATION_ROLE_ROLE_ID` FOREIGN KEY (`role_id`) REFERENCES `authorization_role` (`role_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Admin Rule Table';

INSERT INTO `authorization_rule` (`rule_id`, `role_id`, `resource_id`, `privileges`, `permission`) VALUES
(1,	1,	'Magento_Backend::all',	NULL,	'allow');

DROP TABLE IF EXISTS `cache`;
CREATE TABLE `cache` (
  `id` varchar(200) NOT NULL COMMENT 'Cache Id',
  `data` mediumblob COMMENT 'Cache Data',
  `create_time` int(11) DEFAULT NULL COMMENT 'Cache Creation Time',
  `update_time` int(11) DEFAULT NULL COMMENT 'Time of Cache Updating',
  `expire_time` int(11) DEFAULT NULL COMMENT 'Cache Expiration Time',
  PRIMARY KEY (`id`),
  KEY `CACHE_EXPIRE_TIME` (`expire_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Caches';


DROP TABLE IF EXISTS `cache_tag`;
CREATE TABLE `cache_tag` (
  `tag` varchar(100) NOT NULL COMMENT 'Tag',
  `cache_id` varchar(200) NOT NULL COMMENT 'Cache Id',
  PRIMARY KEY (`tag`,`cache_id`),
  KEY `CACHE_TAG_CACHE_ID` (`cache_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tag Caches';


DROP TABLE IF EXISTS `captcha_log`;
CREATE TABLE `captcha_log` (
  `type` varchar(32) NOT NULL COMMENT 'Type',
  `value` varchar(32) NOT NULL COMMENT 'Value',
  `count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Count',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Update Time',
  PRIMARY KEY (`type`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Count Login Attempts';


DROP TABLE IF EXISTS `cataloginventory_stock`;
CREATE TABLE `cataloginventory_stock` (
  `stock_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Stock Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `stock_name` varchar(255) DEFAULT NULL COMMENT 'Stock Name',
  PRIMARY KEY (`stock_id`),
  KEY `CATALOGINVENTORY_STOCK_WEBSITE_ID` (`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cataloginventory Stock';

INSERT INTO `cataloginventory_stock` (`stock_id`, `website_id`, `stock_name`) VALUES
(1,	0,	'Default');

DROP TABLE IF EXISTS `cataloginventory_stock_item`;
CREATE TABLE `cataloginventory_stock_item` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Item Id',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Id',
  `stock_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Stock Id',
  `qty` decimal(12,4) DEFAULT NULL COMMENT 'Qty',
  `min_qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Min Qty',
  `use_config_min_qty` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Min Qty',
  `is_qty_decimal` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Qty Decimal',
  `backorders` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Backorders',
  `use_config_backorders` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Backorders',
  `min_sale_qty` decimal(12,4) NOT NULL DEFAULT '1.0000' COMMENT 'Min Sale Qty',
  `use_config_min_sale_qty` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Min Sale Qty',
  `max_sale_qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Max Sale Qty',
  `use_config_max_sale_qty` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Max Sale Qty',
  `is_in_stock` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is In Stock',
  `low_stock_date` timestamp NULL DEFAULT NULL COMMENT 'Low Stock Date',
  `notify_stock_qty` decimal(12,4) DEFAULT NULL COMMENT 'Notify Stock Qty',
  `use_config_notify_stock_qty` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Notify Stock Qty',
  `manage_stock` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Manage Stock',
  `use_config_manage_stock` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Manage Stock',
  `stock_status_changed_auto` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Stock Status Changed Automatically',
  `use_config_qty_increments` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Qty Increments',
  `qty_increments` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty Increments',
  `use_config_enable_qty_inc` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Enable Qty Increments',
  `enable_qty_increments` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Enable Qty Increments',
  `is_decimal_divided` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Divided into Multiple Boxes for Shipping',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website ID',
  PRIMARY KEY (`item_id`),
  UNIQUE KEY `CATALOGINVENTORY_STOCK_ITEM_PRODUCT_ID_STOCK_ID` (`product_id`,`stock_id`),
  KEY `CATALOGINVENTORY_STOCK_ITEM_WEBSITE_ID` (`website_id`),
  KEY `CATALOGINVENTORY_STOCK_ITEM_STOCK_ID` (`stock_id`),
  CONSTRAINT `CATINV_STOCK_ITEM_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `CATINV_STOCK_ITEM_STOCK_ID_CATINV_STOCK_STOCK_ID` FOREIGN KEY (`stock_id`) REFERENCES `cataloginventory_stock` (`stock_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cataloginventory Stock Item';

INSERT INTO `cataloginventory_stock_item` (`item_id`, `product_id`, `stock_id`, `qty`, `min_qty`, `use_config_min_qty`, `is_qty_decimal`, `backorders`, `use_config_backorders`, `min_sale_qty`, `use_config_min_sale_qty`, `max_sale_qty`, `use_config_max_sale_qty`, `is_in_stock`, `low_stock_date`, `notify_stock_qty`, `use_config_notify_stock_qty`, `manage_stock`, `use_config_manage_stock`, `stock_status_changed_auto`, `use_config_qty_increments`, `qty_increments`, `use_config_enable_qty_inc`, `enable_qty_increments`, `is_decimal_divided`, `website_id`) VALUES
(1,	1,	1,	99999.0000,	0.0000,	1,	0,	0,	1,	1.0000,	1,	10000.0000,	1,	1,	NULL,	1.0000,	1,	1,	1,	0,	1,	1.0000,	1,	0,	0,	0);

DROP TABLE IF EXISTS `cataloginventory_stock_status`;
CREATE TABLE `cataloginventory_stock_status` (
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `stock_id` smallint(5) unsigned NOT NULL COMMENT 'Stock Id',
  `qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty',
  `stock_status` smallint(5) unsigned NOT NULL COMMENT 'Stock Status',
  PRIMARY KEY (`product_id`,`website_id`,`stock_id`),
  KEY `CATALOGINVENTORY_STOCK_STATUS_STOCK_ID` (`stock_id`),
  KEY `CATALOGINVENTORY_STOCK_STATUS_WEBSITE_ID` (`website_id`),
  KEY `CATALOGINVENTORY_STOCK_STATUS_STOCK_STATUS` (`stock_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cataloginventory Stock Status';

INSERT INTO `cataloginventory_stock_status` (`product_id`, `website_id`, `stock_id`, `qty`, `stock_status`) VALUES
(1,	0,	1,	99999.0000,	1);

DROP TABLE IF EXISTS `cataloginventory_stock_status_idx`;
CREATE TABLE `cataloginventory_stock_status_idx` (
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `stock_id` smallint(5) unsigned NOT NULL COMMENT 'Stock Id',
  `qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty',
  `stock_status` smallint(5) unsigned NOT NULL COMMENT 'Stock Status',
  PRIMARY KEY (`product_id`,`website_id`,`stock_id`),
  KEY `CATALOGINVENTORY_STOCK_STATUS_IDX_STOCK_ID` (`stock_id`),
  KEY `CATALOGINVENTORY_STOCK_STATUS_IDX_WEBSITE_ID` (`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cataloginventory Stock Status Indexer Idx';


DROP TABLE IF EXISTS `cataloginventory_stock_status_replica`;
CREATE TABLE `cataloginventory_stock_status_replica` (
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `stock_id` smallint(5) unsigned NOT NULL COMMENT 'Stock Id',
  `qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty',
  `stock_status` smallint(5) unsigned NOT NULL COMMENT 'Stock Status',
  PRIMARY KEY (`product_id`,`website_id`,`stock_id`),
  KEY `CATALOGINVENTORY_STOCK_STATUS_STOCK_ID` (`stock_id`),
  KEY `CATALOGINVENTORY_STOCK_STATUS_WEBSITE_ID` (`website_id`),
  KEY `CATALOGINVENTORY_STOCK_STATUS_STOCK_STATUS` (`stock_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cataloginventory Stock Status';


DROP TABLE IF EXISTS `cataloginventory_stock_status_tmp`;
CREATE TABLE `cataloginventory_stock_status_tmp` (
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `stock_id` smallint(5) unsigned NOT NULL COMMENT 'Stock Id',
  `qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty',
  `stock_status` smallint(5) unsigned NOT NULL COMMENT 'Stock Status',
  PRIMARY KEY (`product_id`,`website_id`,`stock_id`),
  KEY `CATALOGINVENTORY_STOCK_STATUS_TMP_STOCK_ID` (`stock_id`),
  KEY `CATALOGINVENTORY_STOCK_STATUS_TMP_WEBSITE_ID` (`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Cataloginventory Stock Status Indexer Tmp';


DROP TABLE IF EXISTS `catalogrule`;
CREATE TABLE `catalogrule` (
  `rule_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `description` text COMMENT 'Description',
  `from_date` date DEFAULT NULL COMMENT 'From',
  `to_date` date DEFAULT NULL COMMENT 'To',
  `is_active` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is Active',
  `conditions_serialized` mediumtext COMMENT 'Conditions Serialized',
  `actions_serialized` mediumtext COMMENT 'Actions Serialized',
  `stop_rules_processing` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Stop Rules Processing',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `simple_action` varchar(32) DEFAULT NULL COMMENT 'Simple Action',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount',
  PRIMARY KEY (`rule_id`),
  KEY `CATALOGRULE_IS_ACTIVE_SORT_ORDER_TO_DATE_FROM_DATE` (`is_active`,`sort_order`,`to_date`,`from_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CatalogRule';


DROP TABLE IF EXISTS `catalogrule_customer_group`;
CREATE TABLE `catalogrule_customer_group` (
  `rule_id` int(10) unsigned NOT NULL,
  `customer_group_id` int(10) unsigned NOT NULL COMMENT 'Customer Group Id',
  PRIMARY KEY (`rule_id`,`customer_group_id`),
  KEY `CATALOGRULE_CUSTOMER_GROUP_CUSTOMER_GROUP_ID` (`customer_group_id`),
  CONSTRAINT `CATALOGRULE_CUSTOMER_GROUP_RULE_ID_CATALOGRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `catalogrule` (`rule_id`) ON DELETE CASCADE,
  CONSTRAINT `CATRULE_CSTR_GROUP_CSTR_GROUP_ID_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Rules To Customer Groups Relations';


DROP TABLE IF EXISTS `catalogrule_group_website`;
CREATE TABLE `catalogrule_group_website` (
  `rule_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Rule Id',
  `customer_group_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  PRIMARY KEY (`rule_id`,`customer_group_id`,`website_id`),
  KEY `CATALOGRULE_GROUP_WEBSITE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `CATALOGRULE_GROUP_WEBSITE_WEBSITE_ID` (`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CatalogRule Group Website';


DROP TABLE IF EXISTS `catalogrule_group_website_replica`;
CREATE TABLE `catalogrule_group_website_replica` (
  `rule_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Rule Id',
  `customer_group_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  PRIMARY KEY (`rule_id`,`customer_group_id`,`website_id`),
  KEY `CATALOGRULE_GROUP_WEBSITE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `CATALOGRULE_GROUP_WEBSITE_WEBSITE_ID` (`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CatalogRule Group Website';


DROP TABLE IF EXISTS `catalogrule_product`;
CREATE TABLE `catalogrule_product` (
  `rule_product_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rule Product Id',
  `rule_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Rule Id',
  `from_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'From Time',
  `to_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'To time',
  `customer_group_id` int(11) DEFAULT NULL,
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Id',
  `action_operator` varchar(10) DEFAULT 'to_fixed' COMMENT 'Action Operator',
  `action_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Action Amount',
  `action_stop` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Action Stop',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  PRIMARY KEY (`rule_product_id`),
  UNIQUE KEY `UNQ_EAA51B56FF092A0DCB795D1CEF812B7B` (`rule_id`,`from_time`,`to_time`,`website_id`,`customer_group_id`,`product_id`,`sort_order`),
  KEY `CATALOGRULE_PRODUCT_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `CATALOGRULE_PRODUCT_WEBSITE_ID` (`website_id`),
  KEY `CATALOGRULE_PRODUCT_FROM_TIME` (`from_time`),
  KEY `CATALOGRULE_PRODUCT_TO_TIME` (`to_time`),
  KEY `CATALOGRULE_PRODUCT_PRODUCT_ID` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CatalogRule Product';


DROP TABLE IF EXISTS `catalogrule_product_price`;
CREATE TABLE `catalogrule_product_price` (
  `rule_product_price_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rule Product PriceId',
  `rule_date` date NOT NULL COMMENT 'Rule Date',
  `customer_group_id` int(11) DEFAULT NULL,
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Id',
  `rule_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Rule Price',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `latest_start_date` date DEFAULT NULL COMMENT 'Latest StartDate',
  `earliest_end_date` date DEFAULT NULL COMMENT 'Earliest EndDate',
  PRIMARY KEY (`rule_product_price_id`),
  UNIQUE KEY `CATRULE_PRD_PRICE_RULE_DATE_WS_ID_CSTR_GROUP_ID_PRD_ID` (`rule_date`,`website_id`,`customer_group_id`,`product_id`),
  KEY `CATALOGRULE_PRODUCT_PRICE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `CATALOGRULE_PRODUCT_PRICE_WEBSITE_ID` (`website_id`),
  KEY `CATALOGRULE_PRODUCT_PRICE_PRODUCT_ID` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CatalogRule Product Price';


DROP TABLE IF EXISTS `catalogrule_product_price_replica`;
CREATE TABLE `catalogrule_product_price_replica` (
  `rule_product_price_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rule Product PriceId',
  `rule_date` date NOT NULL COMMENT 'Rule Date',
  `customer_group_id` int(11) DEFAULT NULL,
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Id',
  `rule_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Rule Price',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `latest_start_date` date DEFAULT NULL COMMENT 'Latest StartDate',
  `earliest_end_date` date DEFAULT NULL COMMENT 'Earliest EndDate',
  PRIMARY KEY (`rule_product_price_id`),
  UNIQUE KEY `CATRULE_PRD_PRICE_RULE_DATE_WS_ID_CSTR_GROUP_ID_PRD_ID` (`rule_date`,`website_id`,`customer_group_id`,`product_id`),
  KEY `CATALOGRULE_PRODUCT_PRICE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `CATALOGRULE_PRODUCT_PRICE_WEBSITE_ID` (`website_id`),
  KEY `CATALOGRULE_PRODUCT_PRICE_PRODUCT_ID` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CatalogRule Product Price';


DROP TABLE IF EXISTS `catalogrule_product_replica`;
CREATE TABLE `catalogrule_product_replica` (
  `rule_product_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rule Product Id',
  `rule_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Rule Id',
  `from_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'From Time',
  `to_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'To time',
  `customer_group_id` int(11) DEFAULT NULL,
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Id',
  `action_operator` varchar(10) DEFAULT 'to_fixed' COMMENT 'Action Operator',
  `action_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Action Amount',
  `action_stop` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Action Stop',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  PRIMARY KEY (`rule_product_id`),
  UNIQUE KEY `UNQ_EAA51B56FF092A0DCB795D1CEF812B7B` (`rule_id`,`from_time`,`to_time`,`website_id`,`customer_group_id`,`product_id`,`sort_order`),
  KEY `CATALOGRULE_PRODUCT_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `CATALOGRULE_PRODUCT_WEBSITE_ID` (`website_id`),
  KEY `CATALOGRULE_PRODUCT_FROM_TIME` (`from_time`),
  KEY `CATALOGRULE_PRODUCT_TO_TIME` (`to_time`),
  KEY `CATALOGRULE_PRODUCT_PRODUCT_ID` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CatalogRule Product';


DROP TABLE IF EXISTS `catalogrule_website`;
CREATE TABLE `catalogrule_website` (
  `rule_id` int(10) unsigned NOT NULL,
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  PRIMARY KEY (`rule_id`,`website_id`),
  KEY `CATALOGRULE_WEBSITE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `CATALOGRULE_WEBSITE_RULE_ID_CATALOGRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `catalogrule` (`rule_id`) ON DELETE CASCADE,
  CONSTRAINT `CATALOGRULE_WEBSITE_WEBSITE_ID_STORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Rules To Websites Relations';


DROP TABLE IF EXISTS `catalogsearch_fulltext_scope1`;
CREATE TABLE `catalogsearch_fulltext_scope1` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` int(10) unsigned NOT NULL COMMENT 'Attribute_id',
  `data_index` longtext COMMENT 'Data index',
  PRIMARY KEY (`entity_id`,`attribute_id`),
  FULLTEXT KEY `FTI_FULLTEXT_DATA_INDEX` (`data_index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='catalogsearch_fulltext_scope1';

INSERT INTO `catalogsearch_fulltext_scope1` (`entity_id`, `attribute_id`, `data_index`) VALUES
(1,	73,	'Simple Product 1'),
(1,	74,	'Simple Product 1');

DROP TABLE IF EXISTS `catalogsearch_recommendations`;
CREATE TABLE `catalogsearch_recommendations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `query_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Query Id',
  `relation_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Relation Id',
  PRIMARY KEY (`id`),
  KEY `CATALOGSEARCH_RECOMMENDATIONS_QUERY_ID_SEARCH_QUERY_QUERY_ID` (`query_id`),
  KEY `CATALOGSEARCH_RECOMMENDATIONS_RELATION_ID_SEARCH_QUERY_QUERY_ID` (`relation_id`),
  CONSTRAINT `CATALOGSEARCH_RECOMMENDATIONS_QUERY_ID_SEARCH_QUERY_QUERY_ID` FOREIGN KEY (`query_id`) REFERENCES `search_query` (`query_id`) ON DELETE CASCADE,
  CONSTRAINT `CATALOGSEARCH_RECOMMENDATIONS_RELATION_ID_SEARCH_QUERY_QUERY_ID` FOREIGN KEY (`relation_id`) REFERENCES `search_query` (`query_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Advanced Search Recommendations';


DROP TABLE IF EXISTS `catalog_category_entity`;
CREATE TABLE `catalog_category_entity` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set ID',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Parent Category ID',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation Time',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Update Time',
  `path` varchar(255) NOT NULL COMMENT 'Tree Path',
  `position` int(11) NOT NULL COMMENT 'Position',
  `level` int(11) NOT NULL DEFAULT '0' COMMENT 'Tree Level',
  `children_count` int(11) NOT NULL COMMENT 'Child Count',
  PRIMARY KEY (`entity_id`),
  KEY `CATALOG_CATEGORY_ENTITY_LEVEL` (`level`),
  KEY `CATALOG_CATEGORY_ENTITY_PATH` (`path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Table';

INSERT INTO `catalog_category_entity` (`entity_id`, `attribute_set_id`, `parent_id`, `created_at`, `updated_at`, `path`, `position`, `level`, `children_count`) VALUES
(1,	3,	0,	'2019-02-18 15:05:35',	'2019-02-18 15:05:35',	'1',	0,	0,	1),
(2,	3,	1,	'2019-02-18 15:05:35',	'2019-02-18 15:05:35',	'1/2',	1,	1,	0);

DROP TABLE IF EXISTS `catalog_category_entity_datetime`;
CREATE TABLE `catalog_category_entity_datetime` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0',
  `value` datetime DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `CATALOG_CATEGORY_ENTITY_DATETIME_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `CATALOG_CATEGORY_ENTITY_DATETIME_ENTITY_ID` (`entity_id`),
  KEY `CATALOG_CATEGORY_ENTITY_DATETIME_ATTRIBUTE_ID` (`attribute_id`),
  KEY `CATALOG_CATEGORY_ENTITY_DATETIME_STORE_ID` (`store_id`),
  CONSTRAINT `CATALOG_CATEGORY_ENTITY_DATETIME_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `CAT_CTGR_ENTT_DTIME_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `CAT_CTGR_ENTT_DTIME_ENTT_ID_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Datetime Attribute Backend Table';


DROP TABLE IF EXISTS `catalog_category_entity_decimal`;
CREATE TABLE `catalog_category_entity_decimal` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0',
  `value` decimal(12,4) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `CATALOG_CATEGORY_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `CATALOG_CATEGORY_ENTITY_DECIMAL_ENTITY_ID` (`entity_id`),
  KEY `CATALOG_CATEGORY_ENTITY_DECIMAL_ATTRIBUTE_ID` (`attribute_id`),
  KEY `CATALOG_CATEGORY_ENTITY_DECIMAL_STORE_ID` (`store_id`),
  CONSTRAINT `CATALOG_CATEGORY_ENTITY_DECIMAL_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `CAT_CTGR_ENTT_DEC_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `CAT_CTGR_ENTT_DEC_ENTT_ID_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Decimal Attribute Backend Table';


DROP TABLE IF EXISTS `catalog_category_entity_int`;
CREATE TABLE `catalog_category_entity_int` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0',
  `value` int(11) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `CATALOG_CATEGORY_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `CATALOG_CATEGORY_ENTITY_INT_ENTITY_ID` (`entity_id`),
  KEY `CATALOG_CATEGORY_ENTITY_INT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `CATALOG_CATEGORY_ENTITY_INT_STORE_ID` (`store_id`),
  CONSTRAINT `CATALOG_CATEGORY_ENTITY_INT_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `CAT_CTGR_ENTT_INT_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `CAT_CTGR_ENTT_INT_ENTT_ID_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Integer Attribute Backend Table';

INSERT INTO `catalog_category_entity_int` (`value_id`, `attribute_id`, `store_id`, `entity_id`, `value`) VALUES
(1,	69,	0,	1,	1),
(2,	46,	0,	2,	1),
(3,	69,	0,	2,	1);

DROP TABLE IF EXISTS `catalog_category_entity_text`;
CREATE TABLE `catalog_category_entity_text` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0',
  `value` text COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `CATALOG_CATEGORY_ENTITY_TEXT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `CATALOG_CATEGORY_ENTITY_TEXT_ENTITY_ID` (`entity_id`),
  KEY `CATALOG_CATEGORY_ENTITY_TEXT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `CATALOG_CATEGORY_ENTITY_TEXT_STORE_ID` (`store_id`),
  CONSTRAINT `CATALOG_CATEGORY_ENTITY_TEXT_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `CAT_CTGR_ENTT_TEXT_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `CAT_CTGR_ENTT_TEXT_ENTT_ID_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Text Attribute Backend Table';


DROP TABLE IF EXISTS `catalog_category_entity_varchar`;
CREATE TABLE `catalog_category_entity_varchar` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `CATALOG_CATEGORY_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `CATALOG_CATEGORY_ENTITY_VARCHAR_ENTITY_ID` (`entity_id`),
  KEY `CATALOG_CATEGORY_ENTITY_VARCHAR_ATTRIBUTE_ID` (`attribute_id`),
  KEY `CATALOG_CATEGORY_ENTITY_VARCHAR_STORE_ID` (`store_id`),
  CONSTRAINT `CATALOG_CATEGORY_ENTITY_VARCHAR_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `CAT_CTGR_ENTT_VCHR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `CAT_CTGR_ENTT_VCHR_ENTT_ID_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Varchar Attribute Backend Table';

INSERT INTO `catalog_category_entity_varchar` (`value_id`, `attribute_id`, `store_id`, `entity_id`, `value`) VALUES
(1,	45,	0,	1,	'Root Catalog'),
(2,	45,	0,	2,	'Default Category'),
(3,	52,	0,	2,	'PRODUCTS');

DROP TABLE IF EXISTS `catalog_category_product`;
CREATE TABLE `catalog_category_product` (
  `entity_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `position` int(11) NOT NULL DEFAULT '0' COMMENT 'Position',
  PRIMARY KEY (`entity_id`,`category_id`,`product_id`),
  UNIQUE KEY `CATALOG_CATEGORY_PRODUCT_CATEGORY_ID_PRODUCT_ID` (`category_id`,`product_id`),
  KEY `CATALOG_CATEGORY_PRODUCT_PRODUCT_ID` (`product_id`),
  CONSTRAINT `CAT_CTGR_PRD_CTGR_ID_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`category_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `CAT_CTGR_PRD_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product To Category Linkage Table';

INSERT INTO `catalog_category_product` (`entity_id`, `category_id`, `product_id`, `position`) VALUES
(1,	2,	1,	0);

DROP TABLE IF EXISTS `catalog_category_product_index`;
CREATE TABLE `catalog_category_product_index` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `position` int(11) DEFAULT NULL COMMENT 'Position',
  `is_parent` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Parent',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `visibility` smallint(5) unsigned NOT NULL COMMENT 'Visibility',
  PRIMARY KEY (`category_id`,`product_id`,`store_id`),
  KEY `CAT_CTGR_PRD_IDX_PRD_ID_STORE_ID_CTGR_ID_VISIBILITY` (`product_id`,`store_id`,`category_id`,`visibility`),
  KEY `CAT_CTGR_PRD_IDX_STORE_ID_CTGR_ID_VISIBILITY_IS_PARENT_POSITION` (`store_id`,`category_id`,`visibility`,`is_parent`,`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Product Index';


DROP TABLE IF EXISTS `catalog_category_product_index_replica`;
CREATE TABLE `catalog_category_product_index_replica` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `position` int(11) DEFAULT NULL COMMENT 'Position',
  `is_parent` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Parent',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `visibility` smallint(5) unsigned NOT NULL COMMENT 'Visibility',
  PRIMARY KEY (`category_id`,`product_id`,`store_id`),
  KEY `CAT_CTGR_PRD_IDX_PRD_ID_STORE_ID_CTGR_ID_VISIBILITY` (`product_id`,`store_id`,`category_id`,`visibility`),
  KEY `CAT_CTGR_PRD_IDX_STORE_ID_CTGR_ID_VISIBILITY_IS_PARENT_POSITION` (`store_id`,`category_id`,`visibility`,`is_parent`,`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Product Index';


DROP TABLE IF EXISTS `catalog_category_product_index_store1`;
CREATE TABLE `catalog_category_product_index_store1` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category Id',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Id',
  `position` int(11) DEFAULT NULL COMMENT 'Position',
  `is_parent` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Parent',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `visibility` smallint(5) unsigned NOT NULL COMMENT 'Visibility',
  PRIMARY KEY (`category_id`,`product_id`,`store_id`),
  KEY `CAT_CTGR_PRD_IDX_STORE1_PRD_ID_STORE_ID_CTGR_ID_VISIBILITY` (`product_id`,`store_id`,`category_id`,`visibility`),
  KEY `IDX_216E521C8AD125E066D2B0BAB4A08412` (`store_id`,`category_id`,`visibility`,`is_parent`,`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Product Index Store1';

INSERT INTO `catalog_category_product_index_store1` (`category_id`, `product_id`, `position`, `is_parent`, `store_id`, `visibility`) VALUES
(2,	1,	0,	1,	1,	4);

DROP TABLE IF EXISTS `catalog_category_product_index_store1_replica`;
CREATE TABLE `catalog_category_product_index_store1_replica` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category Id',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Id',
  `position` int(11) DEFAULT NULL COMMENT 'Position',
  `is_parent` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Parent',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `visibility` smallint(5) unsigned NOT NULL COMMENT 'Visibility',
  PRIMARY KEY (`category_id`,`product_id`,`store_id`),
  KEY `IDX_4B965DC45C352D6E4C9DC0FF50B1FCF5` (`product_id`,`store_id`,`category_id`,`visibility`),
  KEY `IDX_47AB760CD6A893ACEA69A9C2E0112C60` (`store_id`,`category_id`,`visibility`,`is_parent`,`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Product Index Store1 Replica';


DROP TABLE IF EXISTS `catalog_category_product_index_tmp`;
CREATE TABLE `catalog_category_product_index_tmp` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `position` int(11) NOT NULL DEFAULT '0' COMMENT 'Position',
  `is_parent` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Parent',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `visibility` smallint(5) unsigned NOT NULL COMMENT 'Visibility',
  PRIMARY KEY (`category_id`,`product_id`,`store_id`),
  KEY `CAT_CTGR_PRD_IDX_TMP_PRD_ID_CTGR_ID_STORE_ID` (`product_id`,`category_id`,`store_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Category Product Indexer temporary table';


DROP TABLE IF EXISTS `catalog_compare_item`;
CREATE TABLE `catalog_compare_item` (
  `catalog_compare_item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Compare Item ID',
  `visitor_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Visitor ID',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store ID',
  PRIMARY KEY (`catalog_compare_item_id`),
  KEY `CATALOG_COMPARE_ITEM_PRODUCT_ID` (`product_id`),
  KEY `CATALOG_COMPARE_ITEM_VISITOR_ID_PRODUCT_ID` (`visitor_id`,`product_id`),
  KEY `CATALOG_COMPARE_ITEM_CUSTOMER_ID_PRODUCT_ID` (`customer_id`,`product_id`),
  KEY `CATALOG_COMPARE_ITEM_STORE_ID` (`store_id`),
  CONSTRAINT `CATALOG_COMPARE_ITEM_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `CATALOG_COMPARE_ITEM_PRODUCT_ID_CATALOG_PRODUCT_ENTITY_ENTITY_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `CATALOG_COMPARE_ITEM_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Compare Table';


DROP TABLE IF EXISTS `catalog_eav_attribute`;
CREATE TABLE `catalog_eav_attribute` (
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `frontend_input_renderer` varchar(255) DEFAULT NULL COMMENT 'Frontend Input Renderer',
  `is_global` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Global',
  `is_visible` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Visible',
  `is_searchable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Searchable',
  `is_filterable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Filterable',
  `is_comparable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Comparable',
  `is_visible_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible On Front',
  `is_html_allowed_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is HTML Allowed On Front',
  `is_used_for_price_rules` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Used For Price Rules',
  `is_filterable_in_search` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Filterable In Search',
  `used_in_product_listing` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Used In Product Listing',
  `used_for_sort_by` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Used For Sorting',
  `apply_to` varchar(255) DEFAULT NULL COMMENT 'Apply To',
  `is_visible_in_advanced_search` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible In Advanced Search',
  `position` int(11) NOT NULL DEFAULT '0' COMMENT 'Position',
  `is_wysiwyg_enabled` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is WYSIWYG Enabled',
  `is_used_for_promo_rules` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Used For Promo Rules',
  `is_required_in_admin_store` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Required In Admin Store',
  `is_used_in_grid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Used in Grid',
  `is_visible_in_grid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible in Grid',
  `is_filterable_in_grid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Filterable in Grid',
  `search_weight` float NOT NULL DEFAULT '1' COMMENT 'Search Weight',
  `additional_data` text COMMENT 'Additional swatch attributes data',
  PRIMARY KEY (`attribute_id`),
  KEY `CATALOG_EAV_ATTRIBUTE_USED_FOR_SORT_BY` (`used_for_sort_by`),
  KEY `CATALOG_EAV_ATTRIBUTE_USED_IN_PRODUCT_LISTING` (`used_in_product_listing`),
  CONSTRAINT `CATALOG_EAV_ATTRIBUTE_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog EAV Attribute Table';

INSERT INTO `catalog_eav_attribute` (`attribute_id`, `frontend_input_renderer`, `is_global`, `is_visible`, `is_searchable`, `is_filterable`, `is_comparable`, `is_visible_on_front`, `is_html_allowed_on_front`, `is_used_for_price_rules`, `is_filterable_in_search`, `used_in_product_listing`, `used_for_sort_by`, `apply_to`, `is_visible_in_advanced_search`, `position`, `is_wysiwyg_enabled`, `is_used_for_promo_rules`, `is_required_in_admin_store`, `is_used_in_grid`, `is_visible_in_grid`, `is_filterable_in_grid`, `search_weight`, `additional_data`) VALUES
(45,	NULL,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(46,	NULL,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(47,	NULL,	0,	1,	0,	0,	0,	0,	1,	0,	0,	0,	0,	NULL,	0,	0,	1,	0,	0,	0,	0,	0,	1,	NULL),
(48,	NULL,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(49,	NULL,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(50,	NULL,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(51,	NULL,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(52,	NULL,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(53,	NULL,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(54,	NULL,	1,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(55,	NULL,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(56,	NULL,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(57,	NULL,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(58,	NULL,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(59,	NULL,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(60,	NULL,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(61,	NULL,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(62,	NULL,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(63,	NULL,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(64,	NULL,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(65,	NULL,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(66,	NULL,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(67,	'Magento\\Catalog\\Block\\Adminhtml\\Category\\Helper\\Sortby\\Available',	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(68,	'Magento\\Catalog\\Block\\Adminhtml\\Category\\Helper\\Sortby\\DefaultSortby',	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(69,	NULL,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(70,	NULL,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(71,	NULL,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(72,	'Magento\\Catalog\\Block\\Adminhtml\\Category\\Helper\\Pricestep',	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(73,	NULL,	0,	1,	1,	0,	0,	0,	0,	0,	0,	1,	1,	NULL,	1,	0,	0,	0,	0,	0,	0,	0,	5,	NULL),
(74,	NULL,	1,	1,	1,	0,	1,	0,	0,	0,	0,	0,	0,	NULL,	1,	0,	0,	0,	0,	0,	0,	0,	6,	NULL),
(75,	NULL,	0,	1,	1,	0,	1,	0,	1,	0,	0,	0,	0,	NULL,	1,	0,	1,	0,	0,	0,	0,	0,	1,	NULL),
(76,	NULL,	0,	1,	1,	0,	1,	0,	1,	0,	0,	1,	0,	NULL,	1,	0,	1,	0,	0,	1,	0,	0,	1,	NULL),
(77,	NULL,	1,	1,	1,	1,	0,	0,	0,	0,	0,	1,	1,	'simple,virtual,configurable,downloadable,bundle',	1,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(78,	NULL,	1,	1,	0,	0,	0,	0,	0,	0,	0,	1,	0,	'simple,virtual,configurable,downloadable,bundle',	0,	0,	0,	0,	0,	1,	0,	1,	1,	NULL),
(79,	NULL,	2,	1,	0,	0,	0,	0,	0,	0,	0,	1,	0,	'simple,virtual,configurable,downloadable,bundle',	0,	0,	0,	0,	0,	1,	0,	0,	1,	NULL),
(80,	NULL,	2,	1,	0,	0,	0,	0,	0,	0,	0,	1,	0,	'simple,virtual,configurable,downloadable,bundle',	0,	0,	0,	0,	0,	1,	0,	0,	1,	NULL),
(81,	NULL,	1,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	'simple,virtual,downloadable',	0,	0,	0,	0,	0,	1,	0,	1,	1,	NULL),
(82,	'Magento\\Catalog\\Block\\Adminhtml\\Product\\Helper\\Form\\Weight',	1,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	'simple,virtual,configurable,downloadable,bundle',	0,	0,	0,	0,	0,	1,	0,	1,	1,	NULL),
(83,	NULL,	1,	1,	1,	1,	1,	0,	0,	0,	0,	0,	0,	'simple,configurable',	1,	0,	0,	0,	0,	1,	0,	1,	1,	NULL),
(84,	NULL,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	1,	0,	1,	1,	NULL),
(85,	NULL,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	1,	0,	1,	1,	NULL),
(86,	NULL,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	1,	0,	1,	1,	NULL),
(87,	NULL,	0,	1,	0,	0,	0,	0,	0,	0,	0,	1,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(88,	NULL,	0,	1,	0,	0,	0,	0,	0,	0,	0,	1,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(89,	NULL,	0,	1,	0,	0,	0,	0,	0,	0,	0,	1,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(90,	NULL,	1,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(91,	NULL,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(92,	NULL,	2,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	'simple,virtual,downloadable,bundle',	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(93,	NULL,	1,	1,	1,	1,	1,	0,	0,	0,	0,	0,	0,	'simple,virtual,configurable',	1,	0,	0,	0,	0,	1,	0,	1,	1,	NULL),
(94,	NULL,	2,	1,	0,	0,	0,	0,	0,	0,	0,	1,	0,	NULL,	0,	0,	0,	0,	0,	1,	0,	0,	1,	NULL),
(95,	NULL,	2,	1,	0,	0,	0,	0,	0,	0,	0,	1,	0,	NULL,	0,	0,	0,	0,	0,	1,	0,	0,	1,	NULL),
(96,	NULL,	1,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(97,	'Magento\\Framework\\Data\\Form\\Element\\Hidden',	2,	1,	1,	0,	0,	0,	0,	0,	0,	1,	0,	NULL,	0,	0,	0,	0,	1,	0,	0,	0,	1,	NULL),
(98,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	'simple,virtual,configurable,downloadable,bundle',	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(99,	NULL,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	1,	0,	0,	0,	1,	NULL),
(100,	NULL,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	1,	0,	1,	1,	NULL),
(101,	NULL,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	1,	0,	0,	1,	NULL),
(102,	NULL,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	1,	0,	0,	1,	NULL),
(103,	NULL,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(104,	NULL,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	1,	0,	0,	1,	NULL),
(105,	'Magento\\Catalog\\Block\\Adminhtml\\Product\\Helper\\Form\\Category',	1,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(106,	NULL,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(107,	NULL,	1,	0,	0,	0,	0,	0,	0,	0,	0,	1,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(108,	NULL,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(109,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	0,	1,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(110,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	0,	1,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(111,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	0,	1,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(112,	NULL,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(113,	NULL,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(114,	NULL,	2,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	'simple,bundle,configurable,grouped',	0,	0,	0,	0,	0,	1,	0,	1,	1,	NULL),
(115,	'Magento\\CatalogInventory\\Block\\Adminhtml\\Form\\Field\\Stock',	1,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(116,	NULL,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	1,	0,	0,	1,	NULL),
(117,	'Magento\\Msrp\\Block\\Adminhtml\\Product\\Helper\\Form\\Type',	1,	1,	0,	0,	0,	0,	0,	0,	0,	1,	0,	'simple,virtual,downloadable,bundle,configurable',	0,	0,	0,	0,	0,	1,	0,	1,	1,	NULL),
(118,	'Magento\\Msrp\\Block\\Adminhtml\\Product\\Helper\\Form\\Type\\Price',	2,	1,	0,	0,	0,	0,	0,	0,	0,	1,	0,	'simple,virtual,downloadable,bundle,configurable',	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(119,	NULL,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(120,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(121,	NULL,	0,	1,	0,	0,	0,	0,	0,	0,	0,	1,	0,	NULL,	0,	0,	0,	0,	0,	1,	0,	1,	1,	NULL),
(122,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(123,	NULL,	1,	0,	0,	0,	0,	0,	0,	0,	0,	1,	0,	'downloadable',	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(124,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	'downloadable',	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(125,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	'downloadable',	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(126,	NULL,	1,	0,	0,	0,	0,	0,	0,	0,	0,	1,	0,	'downloadable',	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(127,	'Magento\\GiftMessage\\Block\\Adminhtml\\Product\\Helper\\Form\\Config',	1,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0,	0,	0,	0,	1,	0,	0,	1,	NULL),
(128,	NULL,	0,	1,	0,	0,	0,	0,	0,	0,	0,	1,	0,	NULL,	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(129,	NULL,	2,	1,	1,	0,	0,	0,	0,	0,	0,	1,	0,	'simple,virtual,configurable,downloadable,bundle',	0,	0,	0,	0,	0,	1,	0,	1,	1,	NULL),
(130,	NULL,	1,	1,	0,	0,	0,	0,	0,	0,	0,	1,	0,	'bundle',	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(131,	NULL,	1,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	'bundle',	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(132,	NULL,	1,	1,	0,	0,	0,	0,	0,	0,	0,	1,	0,	'bundle',	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(133,	NULL,	1,	1,	0,	0,	0,	0,	0,	0,	0,	1,	0,	'bundle',	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(134,	NULL,	1,	1,	0,	0,	0,	0,	0,	0,	0,	1,	0,	'bundle',	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(135,	NULL,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	'simple',	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(136,	NULL,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	'simple',	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(137,	NULL,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	'simple',	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(138,	NULL,	1,	1,	0,	0,	0,	0,	0,	0,	0,	1,	0,	'simple,bundle,grouped,configurable',	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(139,	NULL,	1,	1,	0,	0,	0,	0,	0,	0,	0,	1,	0,	'simple,bundle,grouped,configurable',	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(140,	NULL,	1,	1,	0,	0,	0,	0,	0,	0,	0,	1,	0,	'simple,bundle,grouped,configurable',	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL),
(141,	NULL,	1,	1,	0,	0,	0,	0,	0,	0,	0,	1,	0,	'simple,bundle,grouped,configurable',	0,	0,	0,	0,	0,	0,	0,	0,	1,	NULL);

DROP TABLE IF EXISTS `catalog_product_bundle_option`;
CREATE TABLE `catalog_product_bundle_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `required` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Required',
  `position` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Position',
  `type` varchar(255) DEFAULT NULL COMMENT 'Type',
  PRIMARY KEY (`option_id`),
  KEY `CATALOG_PRODUCT_BUNDLE_OPTION_PARENT_ID` (`parent_id`),
  CONSTRAINT `CAT_PRD_BNDL_OPT_PARENT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`parent_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Option';


DROP TABLE IF EXISTS `catalog_product_bundle_option_value`;
CREATE TABLE `catalog_product_bundle_option_value` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `option_id` int(10) unsigned NOT NULL COMMENT 'Option Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  `parent_product_id` int(10) unsigned NOT NULL COMMENT 'Parent Product Id',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `CAT_PRD_BNDL_OPT_VAL_OPT_ID_PARENT_PRD_ID_STORE_ID` (`option_id`,`parent_product_id`,`store_id`),
  CONSTRAINT `CAT_PRD_BNDL_OPT_VAL_OPT_ID_CAT_PRD_BNDL_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `catalog_product_bundle_option` (`option_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Option Value';


DROP TABLE IF EXISTS `catalog_product_bundle_price_index`;
CREATE TABLE `catalog_product_bundle_price_index` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `customer_group_id` int(10) unsigned NOT NULL COMMENT 'Customer Group Id',
  `min_price` decimal(12,4) NOT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) NOT NULL COMMENT 'Max Price',
  PRIMARY KEY (`entity_id`,`website_id`,`customer_group_id`),
  KEY `CATALOG_PRODUCT_BUNDLE_PRICE_INDEX_WEBSITE_ID` (`website_id`),
  KEY `CATALOG_PRODUCT_BUNDLE_PRICE_INDEX_CUSTOMER_GROUP_ID` (`customer_group_id`),
  CONSTRAINT `CAT_PRD_BNDL_PRICE_IDX_CSTR_GROUP_ID_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE,
  CONSTRAINT `CAT_PRD_BNDL_PRICE_IDX_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `CAT_PRD_BNDL_PRICE_IDX_WS_ID_STORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Price Index';


DROP TABLE IF EXISTS `catalog_product_bundle_selection`;
CREATE TABLE `catalog_product_bundle_selection` (
  `selection_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Selection Id',
  `option_id` int(10) unsigned NOT NULL COMMENT 'Option Id',
  `parent_product_id` int(10) unsigned NOT NULL COMMENT 'Parent Product Id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `position` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Position',
  `is_default` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Default',
  `selection_price_type` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Selection Price Type',
  `selection_price_value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Selection Price Value',
  `selection_qty` decimal(12,4) DEFAULT NULL COMMENT 'Selection Qty',
  `selection_can_change_qty` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Selection Can Change Qty',
  PRIMARY KEY (`selection_id`),
  KEY `CATALOG_PRODUCT_BUNDLE_SELECTION_OPTION_ID` (`option_id`),
  KEY `CATALOG_PRODUCT_BUNDLE_SELECTION_PRODUCT_ID` (`product_id`),
  CONSTRAINT `CAT_PRD_BNDL_SELECTION_OPT_ID_CAT_PRD_BNDL_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `catalog_product_bundle_option` (`option_id`) ON DELETE CASCADE,
  CONSTRAINT `CAT_PRD_BNDL_SELECTION_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Selection';


DROP TABLE IF EXISTS `catalog_product_bundle_selection_price`;
CREATE TABLE `catalog_product_bundle_selection_price` (
  `selection_id` int(10) unsigned NOT NULL COMMENT 'Selection Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `selection_price_type` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Selection Price Type',
  `selection_price_value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Selection Price Value',
  `parent_product_id` int(10) unsigned NOT NULL COMMENT 'Parent Product Id',
  PRIMARY KEY (`selection_id`,`parent_product_id`,`website_id`),
  KEY `CATALOG_PRODUCT_BUNDLE_SELECTION_PRICE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `CAT_PRD_BNDL_SELECTION_PRICE_WS_ID_STORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `store_website` (`website_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_DCF37523AA05D770A70AA4ED7C2616E4` FOREIGN KEY (`selection_id`) REFERENCES `catalog_product_bundle_selection` (`selection_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Selection Price';


DROP TABLE IF EXISTS `catalog_product_bundle_stock_index`;
CREATE TABLE `catalog_product_bundle_stock_index` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `stock_id` smallint(5) unsigned NOT NULL COMMENT 'Stock Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `stock_status` smallint(6) DEFAULT '0' COMMENT 'Stock Status',
  PRIMARY KEY (`entity_id`,`website_id`,`stock_id`,`option_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Stock Index';


DROP TABLE IF EXISTS `catalog_product_entity`;
CREATE TABLE `catalog_product_entity` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set ID',
  `type_id` varchar(32) NOT NULL DEFAULT 'simple' COMMENT 'Type ID',
  `sku` varchar(64) DEFAULT NULL COMMENT 'SKU',
  `has_options` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Has Options',
  `required_options` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Required Options',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation Time',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Update Time',
  PRIMARY KEY (`entity_id`),
  KEY `CATALOG_PRODUCT_ENTITY_ATTRIBUTE_SET_ID` (`attribute_set_id`),
  KEY `CATALOG_PRODUCT_ENTITY_SKU` (`sku`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Table';

INSERT INTO `catalog_product_entity` (`entity_id`, `attribute_set_id`, `type_id`, `sku`, `has_options`, `required_options`, `created_at`, `updated_at`) VALUES
(1,	4,	'simple',	'Simple Product 1',	0,	0,	'2019-02-18 15:08:30',	'2019-02-18 15:08:30');

DROP TABLE IF EXISTS `catalog_product_entity_datetime`;
CREATE TABLE `catalog_product_entity_datetime` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0',
  `value` datetime DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `CATALOG_PRODUCT_ENTITY_DATETIME_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `CATALOG_PRODUCT_ENTITY_DATETIME_ATTRIBUTE_ID` (`attribute_id`),
  KEY `CATALOG_PRODUCT_ENTITY_DATETIME_STORE_ID` (`store_id`),
  CONSTRAINT `CATALOG_PRODUCT_ENTITY_DATETIME_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `CAT_PRD_ENTT_DTIME_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `CAT_PRD_ENTT_DTIME_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Datetime Attribute Backend Table';


DROP TABLE IF EXISTS `catalog_product_entity_decimal`;
CREATE TABLE `catalog_product_entity_decimal` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0',
  `value` decimal(12,4) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `CATALOG_PRODUCT_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `CATALOG_PRODUCT_ENTITY_DECIMAL_STORE_ID` (`store_id`),
  KEY `CATALOG_PRODUCT_ENTITY_DECIMAL_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `CATALOG_PRODUCT_ENTITY_DECIMAL_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `CAT_PRD_ENTT_DEC_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `CAT_PRD_ENTT_DEC_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Decimal Attribute Backend Table';

INSERT INTO `catalog_product_entity_decimal` (`value_id`, `attribute_id`, `store_id`, `entity_id`, `value`) VALUES
(1,	77,	0,	1,	10.0000),
(2,	82,	0,	1,	0.2000);

DROP TABLE IF EXISTS `catalog_product_entity_gallery`;
CREATE TABLE `catalog_product_entity_gallery` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0',
  `position` int(11) NOT NULL DEFAULT '0' COMMENT 'Position',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `CATALOG_PRODUCT_ENTITY_GALLERY_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `CATALOG_PRODUCT_ENTITY_GALLERY_ENTITY_ID` (`entity_id`),
  KEY `CATALOG_PRODUCT_ENTITY_GALLERY_ATTRIBUTE_ID` (`attribute_id`),
  KEY `CATALOG_PRODUCT_ENTITY_GALLERY_STORE_ID` (`store_id`),
  CONSTRAINT `CATALOG_PRODUCT_ENTITY_GALLERY_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `CAT_PRD_ENTT_GLR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `CAT_PRD_ENTT_GLR_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Gallery Attribute Backend Table';


DROP TABLE IF EXISTS `catalog_product_entity_int`;
CREATE TABLE `catalog_product_entity_int` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0',
  `value` int(11) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `CATALOG_PRODUCT_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `CATALOG_PRODUCT_ENTITY_INT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `CATALOG_PRODUCT_ENTITY_INT_STORE_ID` (`store_id`),
  CONSTRAINT `CATALOG_PRODUCT_ENTITY_INT_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `CAT_PRD_ENTT_INT_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `CAT_PRD_ENTT_INT_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Integer Attribute Backend Table';

INSERT INTO `catalog_product_entity_int` (`value_id`, `attribute_id`, `store_id`, `entity_id`, `value`) VALUES
(1,	97,	0,	1,	1),
(2,	99,	0,	1,	4),
(3,	129,	0,	1,	2);

DROP TABLE IF EXISTS `catalog_product_entity_media_gallery`;
CREATE TABLE `catalog_product_entity_media_gallery` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  `media_type` varchar(32) NOT NULL DEFAULT 'image' COMMENT 'Media entry type',
  `disabled` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Visibility status',
  PRIMARY KEY (`value_id`),
  KEY `CATALOG_PRODUCT_ENTITY_MEDIA_GALLERY_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `CAT_PRD_ENTT_MDA_GLR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Media Gallery Attribute Backend Table';

INSERT INTO `catalog_product_entity_media_gallery` (`value_id`, `attribute_id`, `value`, `media_type`, `disabled`) VALUES
(1,	90,	'/a/c/accessories-768x768.jpg',	'image',	0);

DROP TABLE IF EXISTS `catalog_product_entity_media_gallery_value`;
CREATE TABLE `catalog_product_entity_media_gallery_value` (
  `value_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Value ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0',
  `label` varchar(255) DEFAULT NULL COMMENT 'Label',
  `position` int(10) unsigned DEFAULT NULL COMMENT 'Position',
  `disabled` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Disabled',
  `record_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Record Id',
  PRIMARY KEY (`record_id`),
  KEY `CATALOG_PRODUCT_ENTITY_MEDIA_GALLERY_VALUE_STORE_ID` (`store_id`),
  KEY `CATALOG_PRODUCT_ENTITY_MEDIA_GALLERY_VALUE_ENTITY_ID` (`entity_id`),
  KEY `CATALOG_PRODUCT_ENTITY_MEDIA_GALLERY_VALUE_VALUE_ID` (`value_id`),
  CONSTRAINT `CAT_PRD_ENTT_MDA_GLR_VAL_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `CAT_PRD_ENTT_MDA_GLR_VAL_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `CAT_PRD_ENTT_MDA_GLR_VAL_VAL_ID_CAT_PRD_ENTT_MDA_GLR_VAL_ID` FOREIGN KEY (`value_id`) REFERENCES `catalog_product_entity_media_gallery` (`value_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Media Gallery Attribute Value Table';

INSERT INTO `catalog_product_entity_media_gallery_value` (`value_id`, `store_id`, `entity_id`, `label`, `position`, `disabled`, `record_id`) VALUES
(1,	0,	1,	NULL,	1,	0,	1);

DROP TABLE IF EXISTS `catalog_product_entity_media_gallery_value_to_entity`;
CREATE TABLE `catalog_product_entity_media_gallery_value_to_entity` (
  `value_id` int(10) unsigned NOT NULL COMMENT 'Value media Entry ID',
  `entity_id` int(10) unsigned NOT NULL,
  UNIQUE KEY `CAT_PRD_ENTT_MDA_GLR_VAL_TO_ENTT_VAL_ID_ENTT_ID` (`value_id`,`entity_id`),
  KEY `CAT_PRD_ENTT_MDA_GLR_VAL_TO_ENTT_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` (`entity_id`),
  CONSTRAINT `CAT_PRD_ENTT_MDA_GLR_VAL_TO_ENTT_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_A6C6C8FAA386736921D3A7C4B50B1185` FOREIGN KEY (`value_id`) REFERENCES `catalog_product_entity_media_gallery` (`value_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Link Media value to Product entity table';

INSERT INTO `catalog_product_entity_media_gallery_value_to_entity` (`value_id`, `entity_id`) VALUES
(1,	1);

DROP TABLE IF EXISTS `catalog_product_entity_media_gallery_value_video`;
CREATE TABLE `catalog_product_entity_media_gallery_value_video` (
  `value_id` int(10) unsigned NOT NULL COMMENT 'Media Entity ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `provider` varchar(32) DEFAULT NULL COMMENT 'Video provider ID',
  `url` text COMMENT 'Video URL',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  `description` text COMMENT 'Page Meta Description',
  `metadata` text COMMENT 'Video meta data',
  UNIQUE KEY `CAT_PRD_ENTT_MDA_GLR_VAL_VIDEO_VAL_ID_STORE_ID` (`value_id`,`store_id`),
  KEY `CAT_PRD_ENTT_MDA_GLR_VAL_VIDEO_STORE_ID_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `CAT_PRD_ENTT_MDA_GLR_VAL_VIDEO_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_6FDF205946906B0E653E60AA769899F8` FOREIGN KEY (`value_id`) REFERENCES `catalog_product_entity_media_gallery` (`value_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Video Table';


DROP TABLE IF EXISTS `catalog_product_entity_text`;
CREATE TABLE `catalog_product_entity_text` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0',
  `value` text COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `CATALOG_PRODUCT_ENTITY_TEXT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `CATALOG_PRODUCT_ENTITY_TEXT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `CATALOG_PRODUCT_ENTITY_TEXT_STORE_ID` (`store_id`),
  CONSTRAINT `CATALOG_PRODUCT_ENTITY_TEXT_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `CAT_PRD_ENTT_TEXT_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `CAT_PRD_ENTT_TEXT_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Text Attribute Backend Table';

INSERT INTO `catalog_product_entity_text` (`value_id`, `attribute_id`, `store_id`, `entity_id`, `value`) VALUES
(1,	85,	0,	1,	'Simple Product 1');

DROP TABLE IF EXISTS `catalog_product_entity_tier_price`;
CREATE TABLE `catalog_product_entity_tier_price` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0',
  `all_groups` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Applicable To All Customer Groups',
  `customer_group_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Group ID',
  `qty` decimal(12,4) NOT NULL DEFAULT '1.0000' COMMENT 'QTY',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `percentage_value` decimal(5,2) DEFAULT NULL COMMENT 'Percentage value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_E8AB433B9ACB00343ABB312AD2FAB087` (`entity_id`,`all_groups`,`customer_group_id`,`qty`,`website_id`),
  KEY `CATALOG_PRODUCT_ENTITY_TIER_PRICE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `CATALOG_PRODUCT_ENTITY_TIER_PRICE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `CAT_PRD_ENTT_TIER_PRICE_CSTR_GROUP_ID_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE,
  CONSTRAINT `CAT_PRD_ENTT_TIER_PRICE_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `CAT_PRD_ENTT_TIER_PRICE_WS_ID_STORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Tier Price Attribute Backend Table';


DROP TABLE IF EXISTS `catalog_product_entity_varchar`;
CREATE TABLE `catalog_product_entity_varchar` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `CATALOG_PRODUCT_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `CATALOG_PRODUCT_ENTITY_VARCHAR_ATTRIBUTE_ID` (`attribute_id`),
  KEY `CATALOG_PRODUCT_ENTITY_VARCHAR_STORE_ID` (`store_id`),
  CONSTRAINT `CATALOG_PRODUCT_ENTITY_VARCHAR_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `CAT_PRD_ENTT_VCHR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `CAT_PRD_ENTT_VCHR_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Varchar Attribute Backend Table';

INSERT INTO `catalog_product_entity_varchar` (`value_id`, `attribute_id`, `store_id`, `entity_id`, `value`) VALUES
(1,	73,	0,	1,	'Simple Product 1'),
(2,	84,	0,	1,	'Simple Product 1'),
(3,	86,	0,	1,	'Simple Product 1 '),
(4,	87,	0,	1,	'/a/c/accessories-768x768.jpg'),
(5,	88,	0,	1,	'/a/c/accessories-768x768.jpg'),
(6,	89,	0,	1,	'/a/c/accessories-768x768.jpg'),
(7,	106,	0,	1,	'container2'),
(8,	121,	0,	1,	'simple-product-1'),
(9,	127,	0,	1,	'2'),
(10,	128,	0,	1,	'/a/c/accessories-768x768.jpg');

DROP TABLE IF EXISTS `catalog_product_frontend_action`;
CREATE TABLE `catalog_product_frontend_action` (
  `action_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Product Action Id',
  `type_id` varchar(64) NOT NULL COMMENT 'Type of product action',
  `visitor_id` int(10) unsigned DEFAULT NULL COMMENT 'Visitor Id',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `added_at` bigint(20) NOT NULL COMMENT 'Added At',
  PRIMARY KEY (`action_id`),
  UNIQUE KEY `CATALOG_PRODUCT_FRONTEND_ACTION_VISITOR_ID_PRODUCT_ID_TYPE_ID` (`visitor_id`,`product_id`,`type_id`),
  UNIQUE KEY `CATALOG_PRODUCT_FRONTEND_ACTION_CUSTOMER_ID_PRODUCT_ID_TYPE_ID` (`customer_id`,`product_id`,`type_id`),
  KEY `CAT_PRD_FRONTEND_ACTION_PRD_ID_CAT_PRD_ENTT_ENTT_ID` (`product_id`),
  CONSTRAINT `CAT_PRD_FRONTEND_ACTION_CSTR_ID_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `CAT_PRD_FRONTEND_ACTION_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Frontend Action Table';


DROP TABLE IF EXISTS `catalog_product_index_eav`;
CREATE TABLE `catalog_product_index_eav` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` int(10) unsigned NOT NULL COMMENT 'Value',
  `source_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Original entity Id for attribute value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`,`value`,`source_id`),
  KEY `CATALOG_PRODUCT_INDEX_EAV_ATTRIBUTE_ID` (`attribute_id`),
  KEY `CATALOG_PRODUCT_INDEX_EAV_STORE_ID` (`store_id`),
  KEY `CATALOG_PRODUCT_INDEX_EAV_VALUE` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Index Table';

INSERT INTO `catalog_product_index_eav` (`entity_id`, `attribute_id`, `store_id`, `value`, `source_id`) VALUES
(1,	99,	1,	4,	1);

DROP TABLE IF EXISTS `catalog_product_index_eav_decimal`;
CREATE TABLE `catalog_product_index_eav_decimal` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` decimal(12,4) NOT NULL COMMENT 'Value',
  `source_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Original entity Id for attribute value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`,`value`,`source_id`),
  KEY `CATALOG_PRODUCT_INDEX_EAV_DECIMAL_ATTRIBUTE_ID` (`attribute_id`),
  KEY `CATALOG_PRODUCT_INDEX_EAV_DECIMAL_STORE_ID` (`store_id`),
  KEY `CATALOG_PRODUCT_INDEX_EAV_DECIMAL_VALUE` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Decimal Index Table';


DROP TABLE IF EXISTS `catalog_product_index_eav_decimal_idx`;
CREATE TABLE `catalog_product_index_eav_decimal_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` decimal(12,4) NOT NULL COMMENT 'Value',
  `source_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Original entity Id for attribute value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`,`value`,`source_id`),
  KEY `CATALOG_PRODUCT_INDEX_EAV_DECIMAL_IDX_ATTRIBUTE_ID` (`attribute_id`),
  KEY `CATALOG_PRODUCT_INDEX_EAV_DECIMAL_IDX_STORE_ID` (`store_id`),
  KEY `CATALOG_PRODUCT_INDEX_EAV_DECIMAL_IDX_VALUE` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Decimal Indexer Index Table';


DROP TABLE IF EXISTS `catalog_product_index_eav_decimal_replica`;
CREATE TABLE `catalog_product_index_eav_decimal_replica` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` decimal(12,4) NOT NULL COMMENT 'Value',
  `source_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Original entity Id for attribute value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`,`value`,`source_id`),
  KEY `CATALOG_PRODUCT_INDEX_EAV_DECIMAL_ATTRIBUTE_ID` (`attribute_id`),
  KEY `CATALOG_PRODUCT_INDEX_EAV_DECIMAL_STORE_ID` (`store_id`),
  KEY `CATALOG_PRODUCT_INDEX_EAV_DECIMAL_VALUE` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Decimal Index Table';


DROP TABLE IF EXISTS `catalog_product_index_eav_decimal_tmp`;
CREATE TABLE `catalog_product_index_eav_decimal_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` decimal(12,4) NOT NULL COMMENT 'Value',
  `source_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Original entity Id for attribute value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`,`value`,`source_id`),
  KEY `CATALOG_PRODUCT_INDEX_EAV_DECIMAL_TMP_ATTRIBUTE_ID` (`attribute_id`),
  KEY `CATALOG_PRODUCT_INDEX_EAV_DECIMAL_TMP_STORE_ID` (`store_id`),
  KEY `CATALOG_PRODUCT_INDEX_EAV_DECIMAL_TMP_VALUE` (`value`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Decimal Indexer Temp Table';


DROP TABLE IF EXISTS `catalog_product_index_eav_idx`;
CREATE TABLE `catalog_product_index_eav_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` int(10) unsigned NOT NULL COMMENT 'Value',
  `source_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Original entity Id for attribute value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`,`value`,`source_id`),
  KEY `CATALOG_PRODUCT_INDEX_EAV_IDX_ATTRIBUTE_ID` (`attribute_id`),
  KEY `CATALOG_PRODUCT_INDEX_EAV_IDX_STORE_ID` (`store_id`),
  KEY `CATALOG_PRODUCT_INDEX_EAV_IDX_VALUE` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Indexer Index Table';


DROP TABLE IF EXISTS `catalog_product_index_eav_replica`;
CREATE TABLE `catalog_product_index_eav_replica` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` int(10) unsigned NOT NULL COMMENT 'Value',
  `source_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Original entity Id for attribute value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`,`value`,`source_id`),
  KEY `CATALOG_PRODUCT_INDEX_EAV_ATTRIBUTE_ID` (`attribute_id`),
  KEY `CATALOG_PRODUCT_INDEX_EAV_STORE_ID` (`store_id`),
  KEY `CATALOG_PRODUCT_INDEX_EAV_VALUE` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Index Table';


DROP TABLE IF EXISTS `catalog_product_index_eav_tmp`;
CREATE TABLE `catalog_product_index_eav_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` int(10) unsigned NOT NULL COMMENT 'Value',
  `source_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Original entity Id for attribute value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`,`value`,`source_id`),
  KEY `CATALOG_PRODUCT_INDEX_EAV_TMP_ATTRIBUTE_ID` (`attribute_id`),
  KEY `CATALOG_PRODUCT_INDEX_EAV_TMP_STORE_ID` (`store_id`),
  KEY `CATALOG_PRODUCT_INDEX_EAV_TMP_VALUE` (`value`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Indexer Temp Table';


DROP TABLE IF EXISTS `catalog_product_index_price`;
CREATE TABLE `catalog_product_index_price` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` int(10) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class ID',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `final_price` decimal(12,4) DEFAULT NULL COMMENT 'Final Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`),
  KEY `CATALOG_PRODUCT_INDEX_PRICE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `CATALOG_PRODUCT_INDEX_PRICE_MIN_PRICE` (`min_price`),
  KEY `CAT_PRD_IDX_PRICE_WS_ID_CSTR_GROUP_ID_MIN_PRICE` (`website_id`,`customer_group_id`,`min_price`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Index Table';

INSERT INTO `catalog_product_index_price` (`entity_id`, `customer_group_id`, `website_id`, `tax_class_id`, `price`, `final_price`, `min_price`, `max_price`, `tier_price`) VALUES
(1,	0,	1,	2,	10.0000,	10.0000,	10.0000,	10.0000,	NULL),
(1,	1,	1,	2,	10.0000,	10.0000,	10.0000,	10.0000,	NULL),
(1,	2,	1,	2,	10.0000,	10.0000,	10.0000,	10.0000,	NULL),
(1,	3,	1,	2,	10.0000,	10.0000,	10.0000,	10.0000,	NULL);

DROP TABLE IF EXISTS `catalog_product_index_price_bundle_idx`;
CREATE TABLE `catalog_product_index_price_bundle_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` int(11) NOT NULL,
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class Id',
  `price_type` smallint(5) unsigned NOT NULL COMMENT 'Price Type',
  `special_price` decimal(12,4) DEFAULT NULL COMMENT 'Special Price',
  `tier_percent` decimal(12,4) DEFAULT NULL COMMENT 'Tier Percent',
  `orig_price` decimal(12,4) DEFAULT NULL COMMENT 'Orig Price',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `base_tier` decimal(12,4) DEFAULT NULL COMMENT 'Base Tier',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Idx';


DROP TABLE IF EXISTS `catalog_product_index_price_bundle_opt_idx`;
CREATE TABLE `catalog_product_index_price_bundle_opt_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` int(11) NOT NULL,
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `alt_price` decimal(12,4) DEFAULT NULL COMMENT 'Alt Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `alt_tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Alt Tier Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Opt Idx';


DROP TABLE IF EXISTS `catalog_product_index_price_bundle_opt_tmp`;
CREATE TABLE `catalog_product_index_price_bundle_opt_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` int(11) NOT NULL,
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `alt_price` decimal(12,4) DEFAULT NULL COMMENT 'Alt Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `alt_tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Alt Tier Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Opt Tmp';


DROP TABLE IF EXISTS `catalog_product_index_price_bundle_sel_idx`;
CREATE TABLE `catalog_product_index_price_bundle_sel_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` int(11) NOT NULL,
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `selection_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Selection Id',
  `group_type` smallint(5) unsigned DEFAULT '0' COMMENT 'Group Type',
  `is_required` smallint(5) unsigned DEFAULT '0' COMMENT 'Is Required',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`,`selection_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Sel Idx';


DROP TABLE IF EXISTS `catalog_product_index_price_bundle_sel_tmp`;
CREATE TABLE `catalog_product_index_price_bundle_sel_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` int(11) NOT NULL,
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `selection_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Selection Id',
  `group_type` smallint(5) unsigned DEFAULT '0' COMMENT 'Group Type',
  `is_required` smallint(5) unsigned DEFAULT '0' COMMENT 'Is Required',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`,`selection_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Sel Tmp';


DROP TABLE IF EXISTS `catalog_product_index_price_bundle_tmp`;
CREATE TABLE `catalog_product_index_price_bundle_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` int(11) NOT NULL,
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class Id',
  `price_type` smallint(5) unsigned NOT NULL COMMENT 'Price Type',
  `special_price` decimal(12,4) DEFAULT NULL COMMENT 'Special Price',
  `tier_percent` decimal(12,4) DEFAULT NULL COMMENT 'Tier Percent',
  `orig_price` decimal(12,4) DEFAULT NULL COMMENT 'Orig Price',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `base_tier` decimal(12,4) DEFAULT NULL COMMENT 'Base Tier',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Tmp';


DROP TABLE IF EXISTS `catalog_product_index_price_cfg_opt_agr_idx`;
CREATE TABLE `catalog_product_index_price_cfg_opt_agr_idx` (
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent ID',
  `child_id` int(10) unsigned NOT NULL COMMENT 'Child ID',
  `customer_group_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  PRIMARY KEY (`parent_id`,`child_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Config Option Aggregate Index Table';


DROP TABLE IF EXISTS `catalog_product_index_price_cfg_opt_agr_tmp`;
CREATE TABLE `catalog_product_index_price_cfg_opt_agr_tmp` (
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent ID',
  `child_id` int(10) unsigned NOT NULL COMMENT 'Child ID',
  `customer_group_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  PRIMARY KEY (`parent_id`,`child_id`,`customer_group_id`,`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Config Option Aggregate Temp Table';


DROP TABLE IF EXISTS `catalog_product_index_price_cfg_opt_idx`;
CREATE TABLE `catalog_product_index_price_cfg_opt_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Config Option Index Table';


DROP TABLE IF EXISTS `catalog_product_index_price_cfg_opt_tmp`;
CREATE TABLE `catalog_product_index_price_cfg_opt_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Config Option Temp Table';


DROP TABLE IF EXISTS `catalog_product_index_price_downlod_idx`;
CREATE TABLE `catalog_product_index_price_downlod_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` int(11) NOT NULL,
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Minimum price',
  `max_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Maximum price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Indexer Table for price of downloadable products';


DROP TABLE IF EXISTS `catalog_product_index_price_downlod_tmp`;
CREATE TABLE `catalog_product_index_price_downlod_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` int(11) NOT NULL,
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Minimum price',
  `max_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Maximum price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Temporary Indexer Table for price of downloadable products';


DROP TABLE IF EXISTS `catalog_product_index_price_final_idx`;
CREATE TABLE `catalog_product_index_price_final_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class ID',
  `orig_price` decimal(12,4) DEFAULT NULL COMMENT 'Original Price',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `base_tier` decimal(12,4) DEFAULT NULL COMMENT 'Base Tier',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Final Index Table';


DROP TABLE IF EXISTS `catalog_product_index_price_final_tmp`;
CREATE TABLE `catalog_product_index_price_final_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class ID',
  `orig_price` decimal(12,4) DEFAULT NULL COMMENT 'Original Price',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `base_tier` decimal(12,4) DEFAULT NULL COMMENT 'Base Tier',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Final Temp Table';


DROP TABLE IF EXISTS `catalog_product_index_price_idx`;
CREATE TABLE `catalog_product_index_price_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class ID',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `final_price` decimal(12,4) DEFAULT NULL COMMENT 'Final Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`),
  KEY `CATALOG_PRODUCT_INDEX_PRICE_IDX_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `CATALOG_PRODUCT_INDEX_PRICE_IDX_WEBSITE_ID` (`website_id`),
  KEY `CATALOG_PRODUCT_INDEX_PRICE_IDX_MIN_PRICE` (`min_price`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Index Table';


DROP TABLE IF EXISTS `catalog_product_index_price_opt_agr_idx`;
CREATE TABLE `catalog_product_index_price_opt_agr_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Option Aggregate Index Table';


DROP TABLE IF EXISTS `catalog_product_index_price_opt_agr_tmp`;
CREATE TABLE `catalog_product_index_price_opt_agr_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Option Aggregate Temp Table';


DROP TABLE IF EXISTS `catalog_product_index_price_opt_idx`;
CREATE TABLE `catalog_product_index_price_opt_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Option Index Table';


DROP TABLE IF EXISTS `catalog_product_index_price_opt_tmp`;
CREATE TABLE `catalog_product_index_price_opt_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Option Temp Table';


DROP TABLE IF EXISTS `catalog_product_index_price_replica`;
CREATE TABLE `catalog_product_index_price_replica` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` int(10) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class ID',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `final_price` decimal(12,4) DEFAULT NULL COMMENT 'Final Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`),
  KEY `CATALOG_PRODUCT_INDEX_PRICE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `CATALOG_PRODUCT_INDEX_PRICE_MIN_PRICE` (`min_price`),
  KEY `CAT_PRD_IDX_PRICE_WS_ID_CSTR_GROUP_ID_MIN_PRICE` (`website_id`,`customer_group_id`,`min_price`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Index Table';


DROP TABLE IF EXISTS `catalog_product_index_price_tmp`;
CREATE TABLE `catalog_product_index_price_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class ID',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `final_price` decimal(12,4) DEFAULT NULL COMMENT 'Final Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`),
  KEY `CATALOG_PRODUCT_INDEX_PRICE_TMP_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `CATALOG_PRODUCT_INDEX_PRICE_TMP_WEBSITE_ID` (`website_id`),
  KEY `CATALOG_PRODUCT_INDEX_PRICE_TMP_MIN_PRICE` (`min_price`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Temp Table';


DROP TABLE IF EXISTS `catalog_product_index_tier_price`;
CREATE TABLE `catalog_product_index_tier_price` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` int(10) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`),
  KEY `CATALOG_PRODUCT_INDEX_TIER_PRICE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `CATALOG_PRODUCT_INDEX_TIER_PRICE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `CAT_PRD_IDX_TIER_PRICE_CSTR_GROUP_ID_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE,
  CONSTRAINT `CAT_PRD_IDX_TIER_PRICE_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `CAT_PRD_IDX_TIER_PRICE_WS_ID_STORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Tier Price Index Table';


DROP TABLE IF EXISTS `catalog_product_index_website`;
CREATE TABLE `catalog_product_index_website` (
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `default_store_id` smallint(5) unsigned NOT NULL COMMENT 'Default store id for website',
  `website_date` date DEFAULT NULL COMMENT 'Website Date',
  `rate` float DEFAULT '1' COMMENT 'Rate',
  PRIMARY KEY (`website_id`),
  KEY `CATALOG_PRODUCT_INDEX_WEBSITE_WEBSITE_DATE` (`website_date`),
  CONSTRAINT `CAT_PRD_IDX_WS_WS_ID_STORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Website Index Table';

INSERT INTO `catalog_product_index_website` (`website_id`, `default_store_id`, `website_date`, `rate`) VALUES
(1,	1,	'2019-02-18',	1);

DROP TABLE IF EXISTS `catalog_product_link`;
CREATE TABLE `catalog_product_link` (
  `link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Link ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `linked_product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Linked Product ID',
  `link_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Link Type ID',
  PRIMARY KEY (`link_id`),
  UNIQUE KEY `CATALOG_PRODUCT_LINK_LINK_TYPE_ID_PRODUCT_ID_LINKED_PRODUCT_ID` (`link_type_id`,`product_id`,`linked_product_id`),
  KEY `CATALOG_PRODUCT_LINK_PRODUCT_ID` (`product_id`),
  KEY `CATALOG_PRODUCT_LINK_LINKED_PRODUCT_ID` (`linked_product_id`),
  CONSTRAINT `CATALOG_PRODUCT_LINK_PRODUCT_ID_CATALOG_PRODUCT_ENTITY_ENTITY_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `CAT_PRD_LNK_LNKED_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`linked_product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `CAT_PRD_LNK_LNK_TYPE_ID_CAT_PRD_LNK_TYPE_LNK_TYPE_ID` FOREIGN KEY (`link_type_id`) REFERENCES `catalog_product_link_type` (`link_type_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product To Product Linkage Table';


DROP TABLE IF EXISTS `catalog_product_link_attribute`;
CREATE TABLE `catalog_product_link_attribute` (
  `product_link_attribute_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Product Link Attribute ID',
  `link_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Link Type ID',
  `product_link_attribute_code` varchar(32) DEFAULT NULL COMMENT 'Product Link Attribute Code',
  `data_type` varchar(32) DEFAULT NULL COMMENT 'Data Type',
  PRIMARY KEY (`product_link_attribute_id`),
  KEY `CATALOG_PRODUCT_LINK_ATTRIBUTE_LINK_TYPE_ID` (`link_type_id`),
  CONSTRAINT `CAT_PRD_LNK_ATTR_LNK_TYPE_ID_CAT_PRD_LNK_TYPE_LNK_TYPE_ID` FOREIGN KEY (`link_type_id`) REFERENCES `catalog_product_link_type` (`link_type_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Link Attribute Table';

INSERT INTO `catalog_product_link_attribute` (`product_link_attribute_id`, `link_type_id`, `product_link_attribute_code`, `data_type`) VALUES
(1,	1,	'position',	'int'),
(2,	4,	'position',	'int'),
(3,	5,	'position',	'int'),
(4,	3,	'position',	'int'),
(5,	3,	'qty',	'decimal');

DROP TABLE IF EXISTS `catalog_product_link_attribute_decimal`;
CREATE TABLE `catalog_product_link_attribute_decimal` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `product_link_attribute_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Product Link Attribute ID',
  `link_id` int(10) unsigned NOT NULL COMMENT 'Link ID',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `CAT_PRD_LNK_ATTR_DEC_PRD_LNK_ATTR_ID_LNK_ID` (`product_link_attribute_id`,`link_id`),
  KEY `CATALOG_PRODUCT_LINK_ATTRIBUTE_DECIMAL_LINK_ID` (`link_id`),
  CONSTRAINT `CAT_PRD_LNK_ATTR_DEC_LNK_ID_CAT_PRD_LNK_LNK_ID` FOREIGN KEY (`link_id`) REFERENCES `catalog_product_link` (`link_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_AB2EFA9A14F7BCF1D5400056203D14B6` FOREIGN KEY (`product_link_attribute_id`) REFERENCES `catalog_product_link_attribute` (`product_link_attribute_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Link Decimal Attribute Table';


DROP TABLE IF EXISTS `catalog_product_link_attribute_int`;
CREATE TABLE `catalog_product_link_attribute_int` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `product_link_attribute_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Product Link Attribute ID',
  `link_id` int(10) unsigned NOT NULL COMMENT 'Link ID',
  `value` int(11) NOT NULL DEFAULT '0' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `CAT_PRD_LNK_ATTR_INT_PRD_LNK_ATTR_ID_LNK_ID` (`product_link_attribute_id`,`link_id`),
  KEY `CATALOG_PRODUCT_LINK_ATTRIBUTE_INT_LINK_ID` (`link_id`),
  CONSTRAINT `CAT_PRD_LNK_ATTR_INT_LNK_ID_CAT_PRD_LNK_LNK_ID` FOREIGN KEY (`link_id`) REFERENCES `catalog_product_link` (`link_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_D6D878F8BA2A4282F8DDED7E6E3DE35C` FOREIGN KEY (`product_link_attribute_id`) REFERENCES `catalog_product_link_attribute` (`product_link_attribute_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Link Integer Attribute Table';


DROP TABLE IF EXISTS `catalog_product_link_attribute_varchar`;
CREATE TABLE `catalog_product_link_attribute_varchar` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `product_link_attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Link Attribute ID',
  `link_id` int(10) unsigned NOT NULL COMMENT 'Link ID',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `CAT_PRD_LNK_ATTR_VCHR_PRD_LNK_ATTR_ID_LNK_ID` (`product_link_attribute_id`,`link_id`),
  KEY `CATALOG_PRODUCT_LINK_ATTRIBUTE_VARCHAR_LINK_ID` (`link_id`),
  CONSTRAINT `CAT_PRD_LNK_ATTR_VCHR_LNK_ID_CAT_PRD_LNK_LNK_ID` FOREIGN KEY (`link_id`) REFERENCES `catalog_product_link` (`link_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_DEE9C4DA61CFCC01DFCF50F0D79CEA51` FOREIGN KEY (`product_link_attribute_id`) REFERENCES `catalog_product_link_attribute` (`product_link_attribute_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Link Varchar Attribute Table';


DROP TABLE IF EXISTS `catalog_product_link_type`;
CREATE TABLE `catalog_product_link_type` (
  `link_type_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Link Type ID',
  `code` varchar(32) DEFAULT NULL COMMENT 'Code',
  PRIMARY KEY (`link_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Link Type Table';

INSERT INTO `catalog_product_link_type` (`link_type_id`, `code`) VALUES
(1,	'relation'),
(3,	'super'),
(4,	'up_sell'),
(5,	'cross_sell');

DROP TABLE IF EXISTS `catalog_product_option`;
CREATE TABLE `catalog_product_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `type` varchar(50) DEFAULT NULL COMMENT 'Type',
  `is_require` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Is Required',
  `sku` varchar(64) DEFAULT NULL COMMENT 'SKU',
  `max_characters` int(10) unsigned DEFAULT NULL COMMENT 'Max Characters',
  `file_extension` varchar(50) DEFAULT NULL COMMENT 'File Extension',
  `image_size_x` smallint(5) unsigned DEFAULT NULL COMMENT 'Image Size X',
  `image_size_y` smallint(5) unsigned DEFAULT NULL COMMENT 'Image Size Y',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`option_id`),
  KEY `CATALOG_PRODUCT_OPTION_PRODUCT_ID` (`product_id`),
  CONSTRAINT `CAT_PRD_OPT_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Table';


DROP TABLE IF EXISTS `catalog_product_option_price`;
CREATE TABLE `catalog_product_option_price` (
  `option_price_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Price ID',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `price_type` varchar(7) NOT NULL DEFAULT 'fixed' COMMENT 'Price Type',
  PRIMARY KEY (`option_price_id`),
  UNIQUE KEY `CATALOG_PRODUCT_OPTION_PRICE_OPTION_ID_STORE_ID` (`option_id`,`store_id`),
  KEY `CATALOG_PRODUCT_OPTION_PRICE_STORE_ID` (`store_id`),
  CONSTRAINT `CATALOG_PRODUCT_OPTION_PRICE_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `CAT_PRD_OPT_PRICE_OPT_ID_CAT_PRD_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `catalog_product_option` (`option_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Price Table';


DROP TABLE IF EXISTS `catalog_product_option_title`;
CREATE TABLE `catalog_product_option_title` (
  `option_title_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Title ID',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  PRIMARY KEY (`option_title_id`),
  UNIQUE KEY `CATALOG_PRODUCT_OPTION_TITLE_OPTION_ID_STORE_ID` (`option_id`,`store_id`),
  KEY `CATALOG_PRODUCT_OPTION_TITLE_STORE_ID` (`store_id`),
  CONSTRAINT `CATALOG_PRODUCT_OPTION_TITLE_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `CAT_PRD_OPT_TTL_OPT_ID_CAT_PRD_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `catalog_product_option` (`option_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Title Table';


DROP TABLE IF EXISTS `catalog_product_option_type_price`;
CREATE TABLE `catalog_product_option_type_price` (
  `option_type_price_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Type Price ID',
  `option_type_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Type ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `price_type` varchar(7) NOT NULL DEFAULT 'fixed' COMMENT 'Price Type',
  PRIMARY KEY (`option_type_price_id`),
  UNIQUE KEY `CATALOG_PRODUCT_OPTION_TYPE_PRICE_OPTION_TYPE_ID_STORE_ID` (`option_type_id`,`store_id`),
  KEY `CATALOG_PRODUCT_OPTION_TYPE_PRICE_STORE_ID` (`store_id`),
  CONSTRAINT `CATALOG_PRODUCT_OPTION_TYPE_PRICE_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_B523E3378E8602F376CC415825576B7F` FOREIGN KEY (`option_type_id`) REFERENCES `catalog_product_option_type_value` (`option_type_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Type Price Table';


DROP TABLE IF EXISTS `catalog_product_option_type_title`;
CREATE TABLE `catalog_product_option_type_title` (
  `option_type_title_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Type Title ID',
  `option_type_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Type ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  PRIMARY KEY (`option_type_title_id`),
  UNIQUE KEY `CATALOG_PRODUCT_OPTION_TYPE_TITLE_OPTION_TYPE_ID_STORE_ID` (`option_type_id`,`store_id`),
  KEY `CATALOG_PRODUCT_OPTION_TYPE_TITLE_STORE_ID` (`store_id`),
  CONSTRAINT `CATALOG_PRODUCT_OPTION_TYPE_TITLE_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_C085B9CF2C2A302E8043FDEA1937D6A2` FOREIGN KEY (`option_type_id`) REFERENCES `catalog_product_option_type_value` (`option_type_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Type Title Table';


DROP TABLE IF EXISTS `catalog_product_option_type_value`;
CREATE TABLE `catalog_product_option_type_value` (
  `option_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Type ID',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option ID',
  `sku` varchar(64) DEFAULT NULL COMMENT 'SKU',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`option_type_id`),
  KEY `CATALOG_PRODUCT_OPTION_TYPE_VALUE_OPTION_ID` (`option_id`),
  CONSTRAINT `CAT_PRD_OPT_TYPE_VAL_OPT_ID_CAT_PRD_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `catalog_product_option` (`option_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Type Value Table';


DROP TABLE IF EXISTS `catalog_product_relation`;
CREATE TABLE `catalog_product_relation` (
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent ID',
  `child_id` int(10) unsigned NOT NULL COMMENT 'Child ID',
  PRIMARY KEY (`parent_id`,`child_id`),
  KEY `CATALOG_PRODUCT_RELATION_CHILD_ID` (`child_id`),
  CONSTRAINT `CAT_PRD_RELATION_CHILD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`child_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `CAT_PRD_RELATION_PARENT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`parent_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Relation Table';


DROP TABLE IF EXISTS `catalog_product_super_attribute`;
CREATE TABLE `catalog_product_super_attribute` (
  `product_super_attribute_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Product Super Attribute ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `position` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Position',
  PRIMARY KEY (`product_super_attribute_id`),
  UNIQUE KEY `CATALOG_PRODUCT_SUPER_ATTRIBUTE_PRODUCT_ID_ATTRIBUTE_ID` (`product_id`,`attribute_id`),
  CONSTRAINT `CAT_PRD_SPR_ATTR_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Super Attribute Table';


DROP TABLE IF EXISTS `catalog_product_super_attribute_label`;
CREATE TABLE `catalog_product_super_attribute_label` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `product_super_attribute_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Super Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `use_default` smallint(5) unsigned DEFAULT '0' COMMENT 'Use Default Value',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `CAT_PRD_SPR_ATTR_LBL_PRD_SPR_ATTR_ID_STORE_ID` (`product_super_attribute_id`,`store_id`),
  KEY `CATALOG_PRODUCT_SUPER_ATTRIBUTE_LABEL_STORE_ID` (`store_id`),
  CONSTRAINT `CATALOG_PRODUCT_SUPER_ATTRIBUTE_LABEL_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_309442281DF7784210ED82B2CC51E5D5` FOREIGN KEY (`product_super_attribute_id`) REFERENCES `catalog_product_super_attribute` (`product_super_attribute_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Super Attribute Label Table';


DROP TABLE IF EXISTS `catalog_product_super_link`;
CREATE TABLE `catalog_product_super_link` (
  `link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Link ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Parent ID',
  PRIMARY KEY (`link_id`),
  UNIQUE KEY `CATALOG_PRODUCT_SUPER_LINK_PRODUCT_ID_PARENT_ID` (`product_id`,`parent_id`),
  KEY `CATALOG_PRODUCT_SUPER_LINK_PARENT_ID` (`parent_id`),
  CONSTRAINT `CAT_PRD_SPR_LNK_PARENT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`parent_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `CAT_PRD_SPR_LNK_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Super Link Table';


DROP TABLE IF EXISTS `catalog_product_website`;
CREATE TABLE `catalog_product_website` (
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  PRIMARY KEY (`product_id`,`website_id`),
  KEY `CATALOG_PRODUCT_WEBSITE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `CATALOG_PRODUCT_WEBSITE_WEBSITE_ID_STORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `store_website` (`website_id`) ON DELETE CASCADE,
  CONSTRAINT `CAT_PRD_WS_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product To Website Linkage Table';

INSERT INTO `catalog_product_website` (`product_id`, `website_id`) VALUES
(1,	1);

DROP TABLE IF EXISTS `catalog_url_rewrite_product_category`;
CREATE TABLE `catalog_url_rewrite_product_category` (
  `url_rewrite_id` int(10) unsigned NOT NULL COMMENT 'url_rewrite_id',
  `category_id` int(10) unsigned NOT NULL COMMENT 'category_id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'product_id',
  KEY `CAT_URL_REWRITE_PRD_CTGR_PRD_ID_CAT_PRD_ENTT_ENTT_ID` (`product_id`),
  KEY `FK_BB79E64705D7F17FE181F23144528FC8` (`url_rewrite_id`),
  KEY `CATALOG_URL_REWRITE_PRODUCT_CATEGORY_CATEGORY_ID_PRODUCT_ID` (`category_id`,`product_id`),
  CONSTRAINT `CAT_URL_REWRITE_PRD_CTGR_CTGR_ID_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`category_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `CAT_URL_REWRITE_PRD_CTGR_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_BB79E64705D7F17FE181F23144528FC8` FOREIGN KEY (`url_rewrite_id`) REFERENCES `url_rewrite` (`url_rewrite_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='url_rewrite_relation';


DROP TABLE IF EXISTS `checkout_agreement`;
CREATE TABLE `checkout_agreement` (
  `agreement_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Agreement Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `content` text COMMENT 'Content',
  `content_height` varchar(25) DEFAULT NULL COMMENT 'Content Height',
  `checkbox_text` text COMMENT 'Checkbox Text',
  `is_active` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is Active',
  `is_html` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is Html',
  `mode` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Applied mode',
  PRIMARY KEY (`agreement_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Checkout Agreement';


DROP TABLE IF EXISTS `checkout_agreement_store`;
CREATE TABLE `checkout_agreement_store` (
  `agreement_id` int(10) unsigned NOT NULL COMMENT 'Agreement Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  PRIMARY KEY (`agreement_id`,`store_id`),
  KEY `CHECKOUT_AGREEMENT_STORE_STORE_ID_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `CHECKOUT_AGREEMENT_STORE_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `CHKT_AGRT_STORE_AGRT_ID_CHKT_AGRT_AGRT_ID` FOREIGN KEY (`agreement_id`) REFERENCES `checkout_agreement` (`agreement_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Checkout Agreement Store';


DROP TABLE IF EXISTS `cms_block`;
CREATE TABLE `cms_block` (
  `block_id` smallint(6) NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `title` varchar(255) NOT NULL COMMENT 'Block Title',
  `identifier` varchar(255) NOT NULL COMMENT 'Block String Identifier',
  `content` mediumtext COMMENT 'Block Content',
  `creation_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Block Creation Time',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Block Modification Time',
  `is_active` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Is Block Active',
  PRIMARY KEY (`block_id`),
  FULLTEXT KEY `CMS_BLOCK_TITLE_IDENTIFIER_CONTENT` (`title`,`identifier`,`content`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS Block Table';


DROP TABLE IF EXISTS `cms_block_store`;
CREATE TABLE `cms_block_store` (
  `block_id` smallint(6) NOT NULL,
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  PRIMARY KEY (`block_id`,`store_id`),
  KEY `CMS_BLOCK_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `CMS_BLOCK_STORE_BLOCK_ID_CMS_BLOCK_BLOCK_ID` FOREIGN KEY (`block_id`) REFERENCES `cms_block` (`block_id`) ON DELETE CASCADE,
  CONSTRAINT `CMS_BLOCK_STORE_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS Block To Store Linkage Table';


DROP TABLE IF EXISTS `cms_page`;
CREATE TABLE `cms_page` (
  `page_id` smallint(6) NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `title` varchar(255) DEFAULT NULL COMMENT 'Page Title',
  `page_layout` varchar(255) DEFAULT NULL COMMENT 'Page Layout',
  `meta_keywords` text COMMENT 'Page Meta Keywords',
  `meta_description` text COMMENT 'Page Meta Description',
  `identifier` varchar(100) DEFAULT NULL COMMENT 'Page String Identifier',
  `content_heading` varchar(255) DEFAULT NULL COMMENT 'Page Content Heading',
  `content` mediumtext COMMENT 'Page Content',
  `creation_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Page Creation Time',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Page Modification Time',
  `is_active` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Is Page Active',
  `sort_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Page Sort Order',
  `layout_update_xml` text COMMENT 'Page Layout Update Content',
  `custom_theme` varchar(100) DEFAULT NULL COMMENT 'Page Custom Theme',
  `custom_root_template` varchar(255) DEFAULT NULL COMMENT 'Page Custom Template',
  `custom_layout_update_xml` text COMMENT 'Page Custom Layout Update Content',
  `custom_theme_from` date DEFAULT NULL COMMENT 'Page Custom Theme Active From Date',
  `custom_theme_to` date DEFAULT NULL COMMENT 'Page Custom Theme Active To Date',
  `meta_title` varchar(255) DEFAULT NULL COMMENT 'Page Meta Title',
  PRIMARY KEY (`page_id`),
  KEY `CMS_PAGE_IDENTIFIER` (`identifier`),
  FULLTEXT KEY `CMS_PAGE_TITLE_META_KEYWORDS_META_DESCRIPTION_IDENTIFIER_CONTENT` (`title`,`meta_keywords`,`meta_description`,`identifier`,`content`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS Page Table';

INSERT INTO `cms_page` (`page_id`, `title`, `page_layout`, `meta_keywords`, `meta_description`, `identifier`, `content_heading`, `content`, `creation_time`, `update_time`, `is_active`, `sort_order`, `layout_update_xml`, `custom_theme`, `custom_root_template`, `custom_layout_update_xml`, `custom_theme_from`, `custom_theme_to`, `meta_title`) VALUES
(1,	'404 Not Found',	'2columns-right',	'Page keywords',	'Page description',	'no-route',	'Whoops, our bad...',	'<dl>\r\n<dt>The page you requested was not found, and we have a fine guess why.</dt>\r\n<dd>\r\n<ul class=\"disc\">\r\n<li>If you typed the URL directly, please make sure the spelling is correct.</li>\r\n<li>If you clicked on a link to get here, the link is outdated.</li>\r\n</ul></dd>\r\n</dl>\r\n<dl>\r\n<dt>What can you do?</dt>\r\n<dd>Have no fear, help is near! There are many ways you can get back on track with Magento Store.</dd>\r\n<dd>\r\n<ul class=\"disc\">\r\n<li><a href=\"#\" onclick=\"history.go(-1); return false;\">Go back</a> to the previous page.</li>\r\n<li>Use the search bar at the top of the page to search for your products.</li>\r\n<li>Follow these links to get you back on track!<br /><a href=\"{{store url=\"\"}}\">Store Home</a> <span class=\"separator\">|</span> <a href=\"{{store url=\"customer/account\"}}\">My Account</a></li></ul></dd></dl>\r\n',	'2019-02-18 15:05:34',	'2019-02-18 15:05:34',	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(2,	'Home page',	'1column',	'',	'',	'home',	'Home Page',	'<p>{{widget type=\"Magento\\CatalogWidget\\Block\\Product\\ProductsList\" show_pager=\"0\" products_count=\"10\" template=\"Magento_CatalogWidget::product/widget/content/grid.phtml\" conditions_encoded=\"^[`1`:^[`type`:`Magento||CatalogWidget||Model||Rule||Condition||Combine`,`aggregator`:`all`,`value`:`1`,`new_child`:``^]^]\" type_name=\"Catalog Products List\"}}</p>',	'2019-02-18 15:05:34',	'2019-02-18 15:09:06',	1,	0,	'<!--\r\n    <referenceContainer name=\"right\">\r\n        <referenceBlock name=\"catalog.compare.sidebar\" remove=\"true\" />\r\n    </referenceContainer>-->',	'',	'',	NULL,	NULL,	NULL,	''),
(3,	'Enable Cookies',	'1column',	NULL,	NULL,	'enable-cookies',	'What are Cookies?',	'<div class=\"enable-cookies cms-content\">\r\n<p>\"Cookies\" are little pieces of data we send when you visit our store. Cookies help us get to know you better and personalize your experience. Plus they help protect you and other shoppers from fraud.</p>\r\n<p style=\"margin-bottom: 20px;\">Set your browser to accept cookies so you can buy items, save items, and receive customized recommendations. Here’s how:</p>\r\n<ul>\r\n<li><a href=\"https://support.google.com/accounts/answer/61416?hl=en\" target=\"_blank\">Google Chrome</a></li>\r\n<li><a href=\"http://windows.microsoft.com/en-us/internet-explorer/delete-manage-cookies\" target=\"_blank\">Internet Explorer</a></li>\r\n<li><a href=\"http://support.apple.com/kb/PH19214\" target=\"_blank\">Safari</a></li>\r\n<li><a href=\"https://support.mozilla.org/en-US/kb/enable-and-disable-cookies-website-preferences\" target=\"_blank\">Mozilla/Firefox</a></li>\r\n</ul>\r\n</div>',	'2019-02-18 15:05:34',	'2019-02-18 15:05:34',	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(4,	'Privacy and Cookie Policy',	'1column',	NULL,	NULL,	'privacy-policy-cookie-restriction-mode',	'Privacy and Cookie Policy',	'<div class=\"privacy-policy cms-content\">\n    <div class=\"message info\">\n        <span>\n            Please replace this text with you Privacy Policy.\n            Please add any additional cookies your website uses below (e.g. Google Analytics).\n        </span>\n    </div>\n    <p>\n        This privacy policy sets out how this website (hereafter \"the Store\") uses and protects any information that\n        you give the Store while using this website. The Store is committed to ensuring that your privacy is protected.\n        Should we ask you to provide certain information by which you can be identified when using this website, then\n        you can be assured that it will only be used in accordance with this privacy statement. The Store may change\n        this policy from time to time by updating this page. You should check this page from time to time to ensure\n        that you are happy with any changes.\n    </p>\n    <h2>What we collect</h2>\n    <p>We may collect the following information:</p>\n    <ul>\n        <li>name</li>\n        <li>contact information including email address</li>\n        <li>demographic information such as postcode, preferences and interests</li>\n        <li>other information relevant to customer surveys and/or offers</li>\n    </ul>\n    <p>\n        For the exhaustive list of cookies we collect see the <a href=\"#list\">List of cookies we collect</a> section.\n    </p>\n    <h2>What we do with the information we gather</h2>\n    <p>\n        We require this information to understand your needs and provide you with a better service,\n        and in particular for the following reasons:\n    </p>\n    <ul>\n        <li>Internal record keeping.</li>\n        <li>We may use the information to improve our products and services.</li>\n        <li>\n            We may periodically send promotional emails about new products, special offers or other information which we\n            think you may find interesting using the email address which you have provided.\n        </li>\n        <li>\n            From time to time, we may also use your information to contact you for market research purposes.\n            We may contact you by email, phone, fax or mail. We may use the information to customise the website\n            according to your interests.\n        </li>\n    </ul>\n    <h2>Security</h2>\n    <p>\n        We are committed to ensuring that your information is secure. In order to prevent unauthorised access or\n        disclosure, we have put in place suitable physical, electronic and managerial procedures to safeguard and\n        secure the information we collect online.\n    </p>\n    <h2>How we use cookies</h2>\n    <p>\n        A cookie is a small file which asks permission to be placed on your computer\'s hard drive.\n        Once you agree, the file is added and the cookie helps analyse web traffic or lets you know when you visit\n        a particular site. Cookies allow web applications to respond to you as an individual. The web application\n        can tailor its operations to your needs, likes and dislikes by gathering and remembering information about\n        your preferences.\n    </p>\n    <p>\n        We use traffic log cookies to identify which pages are being used. This helps us analyse data about web page\n        traffic and improve our website in order to tailor it to customer needs. We only use this information for\n        statistical analysis purposes and then the data is removed from the system.\n    </p>\n    <p>\n        Overall, cookies help us provide you with a better website, by enabling us to monitor which pages you find\n        useful and which you do not. A cookie in no way gives us access to your computer or any information about you,\n        other than the data you choose to share with us. You can choose to accept or decline cookies.\n        Most web browsers automatically accept cookies, but you can usually modify your browser setting\n        to decline cookies if you prefer. This may prevent you from taking full advantage of the website.\n    </p>\n    <h2>Links to other websites</h2>\n    <p>\n        Our website may contain links to other websites of interest. However, once you have used these links\n        to leave our site, you should note that we do not have any control over that other website.\n        Therefore, we cannot be responsible for the protection and privacy of any information which you provide whilst\n        visiting such sites and such sites are not governed by this privacy statement.\n        You should exercise caution and look at the privacy statement applicable to the website in question.\n    </p>\n    <h2>Controlling your personal information</h2>\n    <p>You may choose to restrict the collection or use of your personal information in the following ways:</p>\n    <ul>\n        <li>\n            whenever you are asked to fill in a form on the website, look for the box that you can click to indicate\n            that you do not want the information to be used by anybody for direct marketing purposes\n        </li>\n        <li>\n            if you have previously agreed to us using your personal information for direct marketing purposes,\n            you may change your mind at any time by letting us know using our Contact Us information\n        </li>\n    </ul>\n    <p>\n        We will not sell, distribute or lease your personal information to third parties unless we have your permission\n        or are required by law to do so. We may use your personal information to send you promotional information\n        about third parties which we think you may find interesting if you tell us that you wish this to happen.\n    </p>\n    <p>\n        You may request details of personal information which we hold about you under the Data Protection Act 1998.\n        A small fee will be payable. If you would like a copy of the information held on you please email us this\n        request using our Contact Us information.\n    </p>\n    <p>\n        If you believe that any information we are holding on you is incorrect or incomplete,\n        please write to or email us as soon as possible, at the above address.\n        We will promptly correct any information found to be incorrect.\n    </p>\n    <h2><a name=\"list\"></a>List of cookies we collect</h2>\n    <p>The table below lists the cookies we collect and what information they store.</p>\n    <table class=\"data-table data-table-definition-list\">\n        <thead>\n        <tr>\n            <th>Cookie Name</th>\n            <th>Cookie Description</th>\n        </tr>\n        </thead>\n        <tbody>\n            <tr>\n                <th>FORM_KEY</th>\n                <td>Stores randomly generated key used to prevent forged requests.</td>\n            </tr>\n            <tr>\n                <th>PHPSESSID</th>\n                <td>Your session ID on the server.</td>\n            </tr>\n            <tr>\n                <th>GUEST-VIEW</th>\n                <td>Allows guests to view and edit their orders.</td>\n            </tr>\n            <tr>\n                <th>PERSISTENT_SHOPPING_CART</th>\n                <td>A link to information about your cart and viewing history, if you have asked for this.</td>\n            </tr>\n            <tr>\n                <th>STF</th>\n                <td>Information on products you have emailed to friends.</td>\n            </tr>\n            <tr>\n                <th>STORE</th>\n                <td>The store view or language you have selected.</td>\n            </tr>\n            <tr>\n                <th>USER_ALLOWED_SAVE_COOKIE</th>\n                <td>Indicates whether a customer allowed to use cookies.</td>\n            </tr>\n            <tr>\n                <th>MAGE-CACHE-SESSID</th>\n                <td>Facilitates caching of content on the browser to make pages load faster.</td>\n            </tr>\n            <tr>\n                <th>MAGE-CACHE-STORAGE</th>\n                <td>Facilitates caching of content on the browser to make pages load faster.</td>\n            </tr>\n            <tr>\n                <th>MAGE-CACHE-STORAGE-SECTION-INVALIDATION</th>\n                <td>Facilitates caching of content on the browser to make pages load faster.</td>\n            </tr>\n            <tr>\n                <th>MAGE-CACHE-TIMEOUT</th>\n                <td>Facilitates caching of content on the browser to make pages load faster.</td>\n            </tr>\n            <tr>\n                <th>SECTION-DATA-IDS</th>\n                <td>Facilitates caching of content on the browser to make pages load faster.</td>\n            </tr>\n            <tr>\n                <th>PRIVATE_CONTENT_VERSION</th>\n                <td>Facilitates caching of content on the browser to make pages load faster.</td>\n            </tr>\n            <tr>\n                <th>X-MAGENTO-VARY</th>\n                <td>Facilitates caching of content on the server to make pages load faster.</td>\n            </tr>\n            <tr>\n                <th>MAGE-TRANSLATION-FILE-VERSION</th>\n                <td>Facilitates translation of content to other languages.</td>\n            </tr>\n            <tr>\n                <th>MAGE-TRANSLATION-STORAGE</th>\n                <td>Facilitates translation of content to other languages.</td>\n            </tr>\n        </tbody>\n    </table>\n</div>',	'2019-02-18 15:05:34',	'2019-02-18 15:05:34',	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);

DROP TABLE IF EXISTS `cms_page_store`;
CREATE TABLE `cms_page_store` (
  `page_id` smallint(6) NOT NULL,
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  PRIMARY KEY (`page_id`,`store_id`),
  KEY `CMS_PAGE_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `CMS_PAGE_STORE_PAGE_ID_CMS_PAGE_PAGE_ID` FOREIGN KEY (`page_id`) REFERENCES `cms_page` (`page_id`) ON DELETE CASCADE,
  CONSTRAINT `CMS_PAGE_STORE_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS Page To Store Linkage Table';

INSERT INTO `cms_page_store` (`page_id`, `store_id`) VALUES
(1,	0),
(2,	0),
(3,	0),
(4,	0);

DROP TABLE IF EXISTS `collinsharper_moneris_payment_queue`;
CREATE TABLE `collinsharper_moneris_payment_queue` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `moneris_order_id` text COMMENT 'Moneris Order ID',
  `order_id` text COMMENT 'Magento Order ID',
  `data_key` text NOT NULL COMMENT 'Data Key',
  PRIMARY KEY (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Recurring payment queue Table';


DROP TABLE IF EXISTS `collinsharper_moneris_payment_vault`;
CREATE TABLE `collinsharper_moneris_payment_vault` (
  `vault_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Vault Id',
  `created_date` datetime DEFAULT NULL COMMENT 'Created Date',
  `customer_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Customer Id',
  `data_key` text NOT NULL COMMENT 'Data Key',
  `customer_email` text,
  `store_id` int(11) DEFAULT NULL,
  `card_default` int(11) DEFAULT NULL,
  `card_expire` text,
  `cc_exp_month` text,
  `cc_exp_year` text,
  `cardholder` text,
  `card_type` text,
  `cc_last` text,
  `updated_date` datetime DEFAULT NULL,
  `issuer_id` text,
  PRIMARY KEY (`vault_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Vault Table';


DROP TABLE IF EXISTS `collinsharper_moneris_recurring_payment`;
CREATE TABLE `collinsharper_moneris_recurring_payment` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Payment Id',
  `created_date` datetime DEFAULT NULL COMMENT 'Created Date',
  `last_payment_date` datetime DEFAULT NULL COMMENT 'Last Payment Occurrence Date',
  `next_payment_date` datetime DEFAULT NULL COMMENT 'Next Payment Date',
  `customer_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Customer Id',
  `amount` float(10,0) NOT NULL DEFAULT '0' COMMENT 'Total Amount',
  `order_id` text COMMENT 'Order ID',
  `data_key` text NOT NULL COMMENT 'Data Key',
  `recurring_term` varchar(255) NOT NULL COMMENT 'Recurring term',
  PRIMARY KEY (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Recurring payments Table';


DROP TABLE IF EXISTS `core_config_data`;
CREATE TABLE `core_config_data` (
  `config_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Config Id',
  `scope` varchar(8) NOT NULL DEFAULT 'default' COMMENT 'Config Scope',
  `scope_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Config Scope Id',
  `path` varchar(255) NOT NULL DEFAULT 'general' COMMENT 'Config Path',
  `value` text COMMENT 'Config Value',
  PRIMARY KEY (`config_id`),
  UNIQUE KEY `CORE_CONFIG_DATA_SCOPE_SCOPE_ID_PATH` (`scope`,`scope_id`,`path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Config Data';

INSERT INTO `core_config_data` (`config_id`, `scope`, `scope_id`, `path`, `value`) VALUES
(1,	'default',	0,	'web/seo/use_rewrites',	'1'),
(2,	'default',	0,	'web/unsecure/base_url',	'http://magento23.local/'),
(3,	'default',	0,	'web/secure/base_url',	'https://magento23.local/'),
(4,	'default',	0,	'general/locale/code',	'en_US'),
(5,	'default',	0,	'web/secure/use_in_frontend',	NULL),
(6,	'default',	0,	'web/secure/use_in_adminhtml',	NULL),
(7,	'default',	0,	'general/locale/timezone',	'UTC'),
(8,	'default',	0,	'currency/options/base',	'USD'),
(9,	'default',	0,	'currency/options/default',	'USD'),
(10,	'default',	0,	'currency/options/allow',	'USD'),
(11,	'default',	0,	'general/region/display_all',	'1'),
(12,	'default',	0,	'general/region/state_required',	'BR,CA,CH,EE,ES,HR,IN,LT,LV,RO,US'),
(13,	'default',	0,	'catalog/category/root_id',	'2'),
(14,	'default',	0,	'msp_securitysuite_twofactorauth/duo/application_key',	'59AHh0AuojbOMdrYpfiPk5kj6JKVRWPD8nQerkC9j6T1yiISHEbl1SuxN2TvDgHv'),
(15,	'default',	0,	'analytics/subscription/enabled',	'1'),
(16,	'default',	0,	'crontab/default/jobs/analytics_subscribe/schedule/cron_expr',	'0 * * * *'),
(17,	'website',	0,	'connector_configuration/transactional_data/order_statuses',	'canceled,closed,complete,fraud,holded,payment_review,paypal_canceled_reversal,paypal_reversed,pending,pending_payment,pending_paypal,processing'),
(18,	'website',	0,	'connector_configuration/catalog_sync/catalog_type',	'simple,virtual,configurable,downloadable,grouped,bundle'),
(19,	'website',	0,	'connector_configuration/catalog_sync/catalog_visibility',	'1,2,3,4'),
(20,	'default',	0,	'connector_dynamic_content/external_dynamic_content_urls/passcode',	'S9c6G4jijmH0dvMwjfVQNA11c4dRJ618'),
(21,	'default',	0,	'connector_automation/review_settings/allow_non_subscribers',	'1'),
(22,	'default',	0,	'connector_configuration/abandoned_carts/allow_non_subscribers',	'1'),
(23,	'default',	0,	'sync_settings/addressbook/allow_non_subscribers',	'1'),
(24,	'default',	0,	'payment/amazon_payments/simplepath/publickey',	'-----BEGIN PUBLIC KEY-----\r\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxmcwhmrAD/5h7lmJYSu8\r\nbp48ewxi2RxH1MRzrgUTWcw64A7tBj9an+7DOEeofUkV+vU3Ea8p/Sx5zb7f5EQd\r\nGVi9YVrGyVXygG8Mp9beGwFOlUFeiFVv134Dta6RHlvjl5tscdiOolSQp32E1k5u\r\n1TZpdoxx1liKCMUmkq7XJ3lphd4doworTGwkZD57PERGPpBJemGBPNAFyQY+EIa0\r\nOs2JY2ejCwPMz+C8Q3e2H4K8kMRunardbycGHKheDSzm8jx+r9spW9uYVAmx9Kid\r\nnacaFGBt5Y+N3pAVrsf177qEXp7qQi6kNZnwM7mPr1WF16jWaqPmNyXytRl8UMn/\r\n+wIDAQAB\r\n-----END PUBLIC KEY-----'),
(25,	'default',	0,	'payment/amazon_payments/simplepath/privatekey',	'0:3:NfJ0GBL8vRpO19nedH5hStQBTu6sMsEGNytBdghpE6ftjf16bMMorzslimoMRVzN+a3iS7BqhfmU4lRqJBPrBKpDJnqGkZX/RbB9p1vsJAo9fZvAXhFUEfe7LJdUjCPo6lzoBjcp7HkGs2tgLTmQyBCrU6whoC3UXh4BMLuHiHKRMRzO5kRh81GLNMgxYsBvDzp0SB0G9mYvomeLe2DWOGiTv/xF5XEPFTqju8fdVoKHMi59ovZVV08F9VCCJs4Wt8z644/HWPrsXbHUmy0jKOjqohMVgHFCJzQiQ6ohlmel6MYN6LE67EFWiCCZNn/KeuNzO5j5wIIiZmhUTXOhUpaqiUZmTgyQzfqCsLhu+PMRdJJcS8tiJYyAdgqKWJe5c4wm/YSrGpeiX8QR0dTRgfgjHqnlq/DJs/dU8cw/tRNqBPW4zgQSoPm2RXgTV0Frp5lGl4VNWFH1OaF8d4tkS73HJczUfSCmSVAT/qXAzJQVCvPpXO3ZnRrL2GZORSr+y9zBG+Wa6pDLrdqxnjUs2Wgic7fE0x2MATygPvDjjzfkRW/3gYHOnY1BQE5eotNRPY55PgCfXh4OtY2i/EK3eZ2NRYJO7V+CoehZNHTczltgt/DDXQydWtL5jfCVnGnDF3T26sD/xjcBOviCwSiHaJ9Em0MlNiuhGqxNVM7hnGSbD4VcKAss5DIjHW9vcY3TPE9554D2ak8Ujcb0dX2ZPKKHPn8BC1516JF9aj7InlVcvtwoTyED0wlE3hbecXKiVghQr+wMwi4PHXNw/G0Z/m6U2x06o4+CXvzw4YrLVrBIgQss3Lie9roLmD7m4mht6nJ3hnZ8cU7pTF0SQ4q7W8xOGBdHhMKfCy140PGFKgaPVbrnY5FSzTLuqtA/0OKUnXyYXGnjY4qlBFO1DHAQYWf7Um/i6d21Dn3j4KP8g5IYsxLU46lm+O9S7xJ6Rn+Ae0XX8wf1gGrPqNmN59ZpGJrq5Vu8UKaBYMOIJRmqGnqxLwyJjZRaPDNMTbcKcQEvoo5HnpjOhv9TpksEuKMHEbtRFAIagqNWx0ahGhRij2NmMp/fY3Cgw0teWgfl+Lr/QIsktZY+cQO/DSBl1soHBmBsU3TOv/3jj2YVAZt8cWmKQ67yoSoma3Nj879JHQwP5JCzlgAnoY+Rp9vjo06q+1wkoeffo5P+69Z0hNXw9E+kGeY5vrJMM6KlpWBCv1FmjSxvo1lpIDj0Mfb3a+3uFw4fvVoMsUwMTXNE/1Ln3tp74lRzS0yI2T9KhvPDu0WDKrmXhcIdraOryHf/qJk13/RSGJI0oywleIZQSfFpqe0PQN7svFOeBK7Do2wwgpFUKUG9m5XiVeiQaqRVQmlY5sGWDOkTD1wYE9aKX93bICSewRS6OLpH3MmDNsT6pnIVnX/0pzCgB5SlXXJ8bHAq2yd3pN0cyIosEyLXA+vrd+CDXORsxeBJeJXso3pKCqcMejienpiQayTV9L6Xqc5XZA54CFKlei3bxro+yv/biuwVJ9MqxCIXuC8tuKrrESsz7ER15S7kYyTv1wqrPMBjOByfsgRzyS252JjinuZRJBLUbwBVDwvdnECytDCehpmXobGm7Cju91Pc08E2jH+ckWWZRjn2bfkEsgiNuHO2NbxAU6LbM+7I4W1La2AtKxYPoYAu6ZZaKOM59PNECwRt36OJx+9ER+7EtLRhd5swIg4Z6ZJOZCpWXMWrhAGlaTAwl5swPy7Aa38dQ1RNATaVQCQ12NcQiEm7jzQzaUrsFMqr6qXLFUWP5+rXrDDUYe2gxNvkQYKTB/peBmYMKM3UJmm/qusuQt8pxjWIdyMPk8n3nmwF99+NZUZmfJiLAtH1pmyR696n2JWrVFuh/20lM8DIqv/PvS1xsgopaLItN0nmI371A/+wFoO5a++Nu46gfrHXr7qbWGx7rHcQokIOVvoTkkkx1sQMgZeAnFxPxd8dnnwg4sPIzfTA4QVDU4qk4BIBbtqAvUVZSKASzYoXGExJlTn8Qr2XS6gnaf8H+rsSuW9wtXnZnQH/NJJbQpAk9V1S35pMP7P6hXL8Bxq0/uIzM6Oq4tjAIIfMmcUxxM3Ss+k7irZp0n73e4GWFOsZIlnxDrKZWNqp38CjlHBft6OCu6s0pN6krxFSyXnMM3Ia5GhjXdcWO1uSBYVPgUzwnlh/vBP3WaBRBhEU8kilPqvtTQlCk/smage1EWg6mJSUODBEot/8o3ZmpMAwqoBisRL6/s4N5SHXDAwkVK2HSQiTXmsoQhgniHmFpzPJuBjCK1euJ8AjCLiIfX043p/x'),
(26,	'default',	0,	'paypal/general/merchant_country',	NULL),
(27,	'default',	0,	'payment/paypal_express/active',	'0'),
(28,	'default',	0,	'payment/paypal_express/in_context',	'0'),
(29,	'default',	0,	'payment/paypal_express_bml/active',	'0'),
(30,	'default',	0,	'paypal/general/business_account',	NULL),
(31,	'default',	0,	'paypal/wpp/api_authentication',	'0'),
(32,	'default',	0,	'paypal/wpp/api_username',	NULL),
(33,	'default',	0,	'paypal/wpp/api_password',	NULL),
(34,	'default',	0,	'paypal/wpp/api_signature',	NULL),
(35,	'default',	0,	'paypal/wpp/sandbox_flag',	'0'),
(36,	'default',	0,	'paypal/wpp/use_proxy',	'0'),
(37,	'default',	0,	'payment/paypal_express_bml/publisher_id',	NULL),
(38,	'default',	0,	'payment/paypal_express_bml/homepage_display',	'0'),
(39,	'default',	0,	'payment/paypal_express_bml/homepage_position',	'0'),
(40,	'default',	0,	'payment/paypal_express_bml/homepage_size',	'190x100'),
(41,	'default',	0,	'payment/paypal_express_bml/categorypage_display',	'0'),
(42,	'default',	0,	'payment/paypal_express_bml/categorypage_position',	'0'),
(43,	'default',	0,	'payment/paypal_express_bml/categorypage_size',	'190x100'),
(44,	'default',	0,	'payment/paypal_express_bml/productpage_display',	'0'),
(45,	'default',	0,	'payment/paypal_express_bml/productpage_position',	'0'),
(46,	'default',	0,	'payment/paypal_express_bml/productpage_size',	'190x100'),
(47,	'default',	0,	'payment/paypal_express_bml/checkout_display',	'0'),
(48,	'default',	0,	'payment/paypal_express_bml/checkout_position',	'0'),
(49,	'default',	0,	'payment/paypal_express_bml/checkout_size',	'234x60'),
(50,	'default',	0,	'payment/paypal_express/title',	'PayPal Express Checkout'),
(51,	'default',	0,	'payment/paypal_express/sort_order',	NULL),
(52,	'default',	0,	'payment/paypal_express/payment_action',	'Authorization'),
(53,	'default',	0,	'payment/paypal_express/visible_on_product',	'1'),
(54,	'default',	0,	'payment/paypal_express/visible_on_cart',	'1'),
(55,	'default',	0,	'payment/paypal_express/allowspecific',	'0'),
(56,	'default',	0,	'payment/paypal_express/debug',	'0'),
(57,	'default',	0,	'payment/paypal_express/verify_peer',	'1'),
(58,	'default',	0,	'payment/paypal_express/line_items_enabled',	'1'),
(59,	'default',	0,	'payment/paypal_express/transfer_shipping_options',	'0'),
(60,	'default',	0,	'paypal/wpp/button_flavor',	'dynamic'),
(61,	'default',	0,	'payment/paypal_express/solution_type',	'Mark'),
(62,	'default',	0,	'payment/paypal_express/require_billing_address',	'0'),
(63,	'default',	0,	'payment/paypal_express/allow_ba_signup',	'never'),
(64,	'default',	0,	'payment/paypal_express/skip_order_review_step',	'1'),
(65,	'default',	0,	'payment/paypal_billing_agreement/active',	'1'),
(66,	'default',	0,	'payment/paypal_billing_agreement/title',	'PayPal Billing Agreement'),
(67,	'default',	0,	'payment/paypal_billing_agreement/sort_order',	NULL),
(68,	'default',	0,	'payment/paypal_billing_agreement/payment_action',	'Authorization'),
(69,	'default',	0,	'payment/paypal_billing_agreement/allowspecific',	'0'),
(70,	'default',	0,	'payment/paypal_billing_agreement/debug',	'0'),
(71,	'default',	0,	'payment/paypal_billing_agreement/verify_peer',	'1'),
(72,	'default',	0,	'payment/paypal_billing_agreement/line_items_enabled',	'0'),
(73,	'default',	0,	'payment/paypal_billing_agreement/allow_billing_agreement_wizard',	'1'),
(74,	'default',	0,	'paypal/fetch_reports/ftp_login',	NULL),
(75,	'default',	0,	'paypal/fetch_reports/ftp_password',	NULL),
(76,	'default',	0,	'paypal/fetch_reports/ftp_sandbox',	'0'),
(77,	'default',	0,	'paypal/fetch_reports/ftp_ip',	NULL),
(78,	'default',	0,	'paypal/fetch_reports/ftp_path',	NULL),
(79,	'default',	0,	'paypal/fetch_reports/active',	'0'),
(80,	'default',	0,	'paypal/fetch_reports/schedule',	'1'),
(81,	'default',	0,	'paypal/fetch_reports/time',	'00,00,00'),
(82,	'default',	0,	'paypal/style/logo',	NULL),
(83,	'default',	0,	'paypal/style/page_style',	NULL),
(84,	'default',	0,	'paypal/style/paypal_hdrimg',	NULL),
(85,	'default',	0,	'paypal/style/paypal_hdrbackcolor',	NULL),
(86,	'default',	0,	'paypal/style/paypal_hdrbordercolor',	NULL),
(87,	'default',	0,	'paypal/style/paypal_payflowcolor',	NULL),
(88,	'default',	0,	'payment/braintree/active',	'0'),
(89,	'default',	0,	'payment/braintree_paypal/active',	'0'),
(90,	'default',	0,	'payment/braintree_cc_vault/active',	'0'),
(91,	'default',	0,	'payment/braintree/title',	'Credit Card (Braintree)'),
(92,	'default',	0,	'payment/braintree/environment',	'sandbox'),
(93,	'default',	0,	'payment/braintree/payment_action',	'authorize'),
(94,	'default',	0,	'payment/braintree/merchant_id',	NULL),
(95,	'default',	0,	'payment/braintree/public_key',	NULL),
(96,	'default',	0,	'payment/braintree/private_key',	NULL),
(97,	'default',	0,	'payment/braintree_cc_vault/title',	'Stored Cards (Braintree)'),
(98,	'default',	0,	'payment/braintree/merchant_account_id',	NULL),
(99,	'default',	0,	'payment/braintree/fraudprotection',	'0'),
(100,	'default',	0,	'payment/braintree/debug',	'0'),
(101,	'default',	0,	'payment/braintree/useccv',	'1'),
(102,	'default',	0,	'payment/braintree/cctypes',	'CUP,AE,VI,MC,DI,JCB,DN,MI'),
(103,	'default',	0,	'payment/braintree/sort_order',	NULL),
(104,	'default',	0,	'payment/braintree/allowspecific',	'0'),
(105,	'default',	0,	'payment/braintree/specificcountry',	NULL),
(106,	'default',	0,	'payment/braintree/countrycreditcard',	'[]'),
(107,	'default',	0,	'payment/braintree_paypal/title',	'PayPal (Braintree)'),
(108,	'default',	0,	'payment/braintree_paypal_vault/active',	'0'),
(109,	'default',	0,	'payment/braintree_paypal/sort_order',	NULL),
(110,	'default',	0,	'payment/braintree_paypal/merchant_name_override',	NULL),
(111,	'default',	0,	'payment/braintree_paypal/payment_action',	'authorize'),
(112,	'default',	0,	'payment/braintree_paypal/allowspecific',	'0'),
(113,	'default',	0,	'payment/braintree_paypal/specificcountry',	NULL),
(114,	'default',	0,	'payment/braintree_paypal/require_billing_address',	'0'),
(115,	'default',	0,	'payment/braintree_paypal/allow_shipping_address_override',	'1'),
(116,	'default',	0,	'payment/braintree_paypal/debug',	'0'),
(117,	'default',	0,	'payment/braintree_paypal/display_on_shopping_cart',	'1'),
(118,	'default',	0,	'payment/braintree_paypal/skip_order_review',	'0'),
(119,	'default',	0,	'payment/braintree/verify_3dsecure',	'0'),
(120,	'default',	0,	'payment/braintree/threshold_amount',	NULL),
(121,	'default',	0,	'payment/braintree/verify_all_countries',	'0'),
(122,	'default',	0,	'payment/braintree/verify_specific_countries',	NULL),
(123,	'default',	0,	'payment/braintree/descriptor_name',	NULL),
(124,	'default',	0,	'payment/braintree/descriptor_phone',	NULL),
(125,	'default',	0,	'payment/braintree/descriptor_url',	NULL),
(126,	'default',	0,	'payment/payflow_express/active',	'0'),
(127,	'default',	0,	'payment/payflow_advanced/active',	'0'),
(128,	'default',	0,	'payment/payflow_express_bml/active',	'0'),
(129,	'default',	0,	'payment/payflow_advanced/partner',	'PayPal'),
(130,	'default',	0,	'payment/payflow_advanced/vendor',	'PayPal'),
(131,	'default',	0,	'payment/payflow_advanced/user',	NULL),
(132,	'default',	0,	'payment/payflow_advanced/pwd',	NULL),
(133,	'default',	0,	'payment/payflow_advanced/sandbox_flag',	'0'),
(134,	'default',	0,	'payment/payflow_advanced/use_proxy',	'0'),
(135,	'default',	0,	'payment/payflow_advanced/title',	'Credit Card'),
(136,	'default',	0,	'payment/payflow_advanced/sort_order',	NULL),
(137,	'default',	0,	'payment/payflow_advanced/payment_action',	'Authorization'),
(138,	'default',	0,	'payment/payflow_advanced/allowspecific',	'0'),
(139,	'default',	0,	'payment/payflow_advanced/debug',	'0'),
(140,	'default',	0,	'payment/payflow_advanced/verify_peer',	'1'),
(141,	'default',	0,	'payment/payflow_advanced/csc_editable',	'1'),
(142,	'default',	0,	'payment/payflow_advanced/csc_required',	'1'),
(143,	'default',	0,	'payment/payflow_advanced/email_confirmation',	'0'),
(144,	'default',	0,	'payment/payflow_advanced/url_method',	'GET'),
(145,	'default',	0,	'payment/payflow_express/title',	'PayPal Express Checkout Payflow Edition'),
(146,	'default',	0,	'payment/payflow_express/sort_order',	NULL),
(147,	'default',	0,	'payment/payflow_express/payment_action',	'Authorization'),
(148,	'default',	0,	'payment/payflow_express/visible_on_product',	'1'),
(149,	'default',	0,	'payment/payflow_express/visible_on_cart',	'1'),
(150,	'default',	0,	'payment/payflow_express/allowspecific',	'0'),
(151,	'default',	0,	'payment/payflow_express/debug',	'0'),
(152,	'default',	0,	'payment/payflow_express/verify_peer',	'1'),
(153,	'default',	0,	'payment/payflow_express/line_items_enabled',	'1'),
(154,	'default',	0,	'payment/paypal_payment_pro/active',	'0'),
(155,	'default',	0,	'payment/payflowpro_cc_vault/active',	'0'),
(156,	'default',	0,	'payment/payflowpro/partner',	NULL),
(157,	'default',	0,	'payment/payflowpro/user',	NULL),
(158,	'default',	0,	'payment/payflowpro/vendor',	NULL),
(159,	'default',	0,	'payment/payflowpro/pwd',	NULL),
(160,	'default',	0,	'payment/payflowpro/sandbox_flag',	'0'),
(161,	'default',	0,	'payment/payflowpro/use_proxy',	'0'),
(162,	'default',	0,	'payment/payflowpro/title',	'Credit Card'),
(163,	'default',	0,	'payment/payflowpro_cc_vault/title',	'Stored Cards (Payflow Pro)'),
(164,	'default',	0,	'payment/payflowpro/sort_order',	NULL),
(165,	'default',	0,	'payment/payflowpro/payment_action',	'Authorization'),
(166,	'default',	0,	'payment/payflowpro/cctypes',	'AE,VI'),
(167,	'default',	0,	'payment/payflowpro/allowspecific',	'0'),
(168,	'default',	0,	'payment/payflowpro/debug',	'0'),
(169,	'default',	0,	'payment/payflowpro/verify_peer',	'1'),
(170,	'default',	0,	'payment/payflowpro/useccv',	'1'),
(171,	'default',	0,	'payment/payflowpro/avs_street',	'0'),
(172,	'default',	0,	'payment/payflowpro/avs_zip',	'0'),
(173,	'default',	0,	'payment/payflowpro/avs_international',	'0'),
(174,	'default',	0,	'payment/payflowpro/avs_security_code',	'1'),
(175,	'default',	0,	'payment/wps_express/active',	'0'),
(176,	'default',	0,	'payment/wps_express_bml/active',	'0'),
(177,	'default',	0,	'payment/payflowpro/active',	'0'),
(178,	'default',	0,	'payment/payflow_link/active',	'0'),
(179,	'default',	0,	'payment/payflow_link/partner',	'PayPal'),
(180,	'default',	0,	'payment/payflow_link/vendor',	NULL),
(181,	'default',	0,	'payment/payflow_link/user',	NULL),
(182,	'default',	0,	'payment/payflow_link/pwd',	NULL),
(183,	'default',	0,	'payment/payflow_link/sandbox_flag',	'0'),
(184,	'default',	0,	'payment/payflow_link/use_proxy',	'0'),
(185,	'default',	0,	'payment/payflow_link/title',	'Credit Card'),
(186,	'default',	0,	'payment/payflow_link/sort_order',	NULL),
(187,	'default',	0,	'payment/payflow_link/payment_action',	'Authorization'),
(188,	'default',	0,	'payment/payflow_link/allowspecific',	'0'),
(189,	'default',	0,	'payment/payflow_link/debug',	'0'),
(190,	'default',	0,	'payment/payflow_link/verify_peer',	'1'),
(191,	'default',	0,	'payment/payflow_link/csc_editable',	'1'),
(192,	'default',	0,	'payment/payflow_link/csc_required',	'1'),
(193,	'default',	0,	'payment/payflow_link/email_confirmation',	'0'),
(194,	'default',	0,	'payment/payflow_link/url_method',	'GET'),
(195,	'default',	0,	'klarna/api/api_version',	'kp_eu'),
(196,	'default',	0,	'klarna/api/merchant_id',	NULL),
(197,	'default',	0,	'klarna/api/shared_secret',	NULL),
(198,	'default',	0,	'klarna/api/test_mode',	'1'),
(199,	'default',	0,	'klarna/api/debug',	'1'),
(200,	'default',	0,	'payment/klarna_kp/active',	'0'),
(201,	'default',	0,	'payment/klarna_kp/allowspecific',	'0'),
(202,	'default',	0,	'payment/klarna_kp/data_sharing',	'1'),
(203,	'default',	0,	'payment/klarna_kp/sort_order',	NULL),
(204,	'default',	0,	'checkout/klarna_kp_design/color_details',	NULL),
(205,	'default',	0,	'checkout/klarna_kp_design/color_border',	NULL),
(206,	'default',	0,	'checkout/klarna_kp_design/color_border_selected',	NULL),
(207,	'default',	0,	'checkout/klarna_kp_design/color_text',	NULL),
(208,	'default',	0,	'checkout/klarna_kp_design/color_radius_border',	NULL),
(209,	'default',	0,	'payment/amazon_payment/merchant_id',	NULL),
(210,	'default',	0,	'payment/amazon_payment/access_key',	NULL),
(211,	'default',	0,	'payment/amazon_payment/secret_key',	NULL),
(212,	'default',	0,	'payment/amazon_payment/client_id',	NULL),
(213,	'default',	0,	'payment/amazon_payment/client_secret',	NULL),
(214,	'default',	0,	'payment/amazon_payment/credentials_json',	NULL),
(215,	'default',	0,	'payment/amazon_payment/payment_region',	NULL),
(216,	'default',	0,	'payment/amazon_payment/sandbox',	'0'),
(217,	'default',	0,	'payment/amazon_payment/active',	'0'),
(218,	'default',	0,	'payment/amazon_payment/lwa_enabled',	'0'),
(219,	'default',	0,	'payment/amazon_payment/payment_action',	'authorize'),
(220,	'default',	0,	'payment/amazon_payment/authorization_mode',	'synchronous'),
(221,	'default',	0,	'payment/amazon_payment/update_mechanism',	'polling'),
(222,	'default',	0,	'payment/amazon_payment/button_display_language',	NULL),
(223,	'default',	0,	'payment/amazon_payment/button_color',	'Gold'),
(224,	'default',	0,	'payment/amazon_payment/button_size',	'medium'),
(225,	'default',	0,	'payment/amazon_payment/amazon_login_in_popup',	'1'),
(226,	'default',	0,	'payment/amazon_payment/pwa_pp_button_is_visible',	'1'),
(227,	'default',	0,	'payment/amazon_payment/minicart_button_is_visible',	'1'),
(228,	'default',	0,	'payment/amazonlogin/active',	'0'),
(229,	'default',	0,	'payment/amazon_payment/storename',	NULL),
(230,	'default',	0,	'payment/amazon_payment/logging',	'1'),
(231,	'default',	0,	'payment/amazon_payment/allowed_ips',	NULL),
(232,	'default',	0,	'payment/banktransfer/specificcountry',	NULL),
(233,	'default',	0,	'payment/banktransfer/instructions',	NULL),
(234,	'default',	0,	'payment/banktransfer/min_order_total',	NULL),
(235,	'default',	0,	'payment/banktransfer/max_order_total',	NULL),
(236,	'default',	0,	'payment/banktransfer/sort_order',	NULL),
(237,	'default',	0,	'payment/cashondelivery/specificcountry',	NULL),
(238,	'default',	0,	'payment/cashondelivery/instructions',	NULL),
(239,	'default',	0,	'payment/cashondelivery/min_order_total',	NULL),
(240,	'default',	0,	'payment/cashondelivery/max_order_total',	NULL),
(241,	'default',	0,	'payment/cashondelivery/sort_order',	NULL),
(242,	'default',	0,	'payment/free/specificcountry',	NULL),
(243,	'default',	0,	'payment/checkmo/specificcountry',	NULL),
(244,	'default',	0,	'payment/checkmo/payable_to',	NULL),
(245,	'default',	0,	'payment/checkmo/mailing_address',	NULL),
(246,	'default',	0,	'payment/checkmo/min_order_total',	NULL),
(247,	'default',	0,	'payment/checkmo/max_order_total',	NULL),
(248,	'default',	0,	'payment/checkmo/sort_order',	NULL),
(249,	'default',	0,	'payment/chmasterpass/active',	'0'),
(250,	'default',	0,	'payment/chmasterpass/title',	'Masterpass by CollionsHarper'),
(251,	'default',	0,	'payment/chmasterpass/store_id',	NULL),
(252,	'default',	0,	'payment/chmasterpass/api_token',	NULL),
(253,	'default',	0,	'payment/chmasterpass/proc_country',	'CA'),
(254,	'default',	0,	'payment/chmasterpass/test_mode',	'0'),
(255,	'default',	0,	'payment/moneris/chmasterpass/payment_action',	'authorize'),
(256,	'default',	0,	'payment/chmasterpass/sort_order',	NULL),
(257,	'default',	0,	'payment/chvisa/active',	'0'),
(258,	'default',	0,	'payment/chvisa/title',	'CollinsHarper Visa Checkout'),
(259,	'default',	0,	'payment/chvisa/test',	'1'),
(260,	'default',	0,	'payment/chvisa/api_key',	'0:3:BR5o594uVy8m1tOkzzcHkDJKW+H3AfTIXWOYpWyeMLRfoQ=='),
(261,	'default',	0,	'payment/moneris/chmoneris/enable_vault',	'0'),
(262,	'default',	0,	'payment/moneris/chmoneriscc/active',	'1'),
(263,	'default',	0,	'payment/moneris/chmoneriscc/title',	'Moneris Credit Card'),
(264,	'default',	0,	'payment/moneris/chmoneriscc/usapi',	'0'),
(265,	'default',	0,	'payment/moneris/chmoneriscc/is_recurring',	'0'),
(266,	'default',	0,	'payment/chmoneriscc/cctypes',	'AE,VI,MC,DI,JCB,DN,UN'),
(267,	'default',	0,	'payment/moneris/chmoneriscc/login',	'0:3:hi76tHwnpTvwHPN/slxtMO6U5gMrKmuxOtVKeNvLSNPD2w=='),
(268,	'default',	0,	'payment/moneris/chmoneriscc/password',	'0:3:XnY/Zbg38PyhVSsVAOTkYKWARhc1AJx1UMZgSrm/QMeXZg=='),
(269,	'default',	0,	'payment/moneris/chmoneriscc/min_order_total',	'0'),
(270,	'default',	0,	'payment/moneris/chmoneriscc/max_order_total',	'999999'),
(271,	'default',	0,	'payment/moneris/chmoneriscc/test',	'1'),
(272,	'default',	0,	'payment/moneris/chmoneriscc/debug',	'0'),
(273,	'default',	0,	'payment/moneris/chmoneriscc/vbv_enabled',	'0'),
(274,	'default',	0,	'payment/moneris/chmoneriscc/require_vbv',	'0'),
(275,	'default',	0,	'payment/moneris/chmoneriscc/useccv',	'0'),
(276,	'default',	0,	'payment/moneris/chmoneriscc/cvdsuccess',	NULL),
(277,	'default',	0,	'payment/moneris/chmoneriscc/avszip',	'0'),
(278,	'default',	0,	'payment/moneris/chmoneriscc/avssuccess',	NULL),
(279,	'default',	0,	'payment/moneris/chmoneriscc/allowspecific',	'0'),
(280,	'default',	0,	'payment/moneris/chmoneriscc/specificcountry',	NULL),
(281,	'default',	0,	'payment/moneris/chmoneriscc/responses',	NULL),
(282,	'default',	0,	'payment/moneris/chmoneriscc/use_customer_name',	'0'),
(283,	'default',	0,	'payment/moneris/chmoneriscc/payment_action',	'authorize'),
(284,	'default',	0,	'payment/moneris/chmoneriscc/order_status',	'processing'),
(285,	'default',	0,	'payment/moneris/chmoneriscc/sort_order',	NULL),
(286,	'default',	0,	'payment/moneris/chmonerismonerischeckout/active',	'0'),
(287,	'default',	0,	'payment/moneris/chmonerismonerischeckout/title',	NULL),
(288,	'default',	0,	'payment/moneris/chmonerisredirect/active',	'0'),
(289,	'default',	0,	'payment/moneris/chmonerisredirect/title',	NULL),
(290,	'default',	0,	'payment/moneris/chmonerisredirect/vbv_enabled',	'0'),
(291,	'default',	0,	'payment/moneris/chmonerisredirect/require_vbv',	'0'),
(292,	'default',	0,	'payment/moneris/chmonerisredirect/test',	'0'),
(293,	'default',	0,	'payment/moneris/chmonerisredirect/debug',	'0'),
(294,	'default',	0,	'payment/moneris/chmonerisredirect/order_status',	NULL),
(295,	'default',	0,	'payment/moneris/chmonerisredirect/payment_action',	'authorize_capture'),
(296,	'default',	0,	'payment/moneris/chmonerisinterac/active',	'0'),
(297,	'default',	0,	'payment/moneris/chmonerisinterac/title',	NULL),
(298,	'default',	0,	'payment/moneris/chmonerisinterac/environment',	'P'),
(299,	'default',	0,	'payment/moneris/chmonerisinterac/order_status',	NULL),
(300,	'default',	0,	'payment/moneris/chmonerisinterac/allowspecific',	'0'),
(301,	'default',	0,	'payment/moneris/chmonerisinterac/specificcountry',	NULL),
(302,	'default',	0,	'payment/moneris/chmonerisinterac/payment_action',	'authorize'),
(303,	'default',	0,	'payment/purchaseorder/specificcountry',	NULL),
(304,	'default',	0,	'payment/purchaseorder/min_order_total',	NULL),
(305,	'default',	0,	'payment/purchaseorder/max_order_total',	NULL),
(306,	'default',	0,	'payment/purchaseorder/sort_order',	NULL),
(307,	'default',	0,	'payment/authorizenet_directpost/login',	NULL),
(308,	'default',	0,	'payment/authorizenet_directpost/trans_key',	NULL),
(309,	'default',	0,	'payment/authorizenet_directpost/trans_md5',	NULL),
(310,	'default',	0,	'payment/authorizenet_directpost/merchant_email',	NULL),
(311,	'default',	0,	'payment/authorizenet_directpost/useccv',	'0'),
(312,	'default',	0,	'payment/authorizenet_directpost/specificcountry',	NULL),
(313,	'default',	0,	'payment/authorizenet_directpost/min_order_total',	NULL),
(314,	'default',	0,	'payment/authorizenet_directpost/max_order_total',	NULL),
(315,	'default',	0,	'payment/authorizenet_directpost/sort_order',	NULL),
(316,	'default',	0,	'customer/address/street_lines',	'3');

DROP TABLE IF EXISTS `cron_schedule`;
CREATE TABLE `cron_schedule` (
  `schedule_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Schedule Id',
  `job_code` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Job Code',
  `status` varchar(7) NOT NULL DEFAULT 'pending' COMMENT 'Status',
  `messages` text COMMENT 'Messages',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `scheduled_at` timestamp NULL DEFAULT NULL COMMENT 'Scheduled At',
  `executed_at` timestamp NULL DEFAULT NULL COMMENT 'Executed At',
  `finished_at` timestamp NULL DEFAULT NULL COMMENT 'Finished At',
  PRIMARY KEY (`schedule_id`),
  KEY `CRON_SCHEDULE_JOB_CODE` (`job_code`),
  KEY `CRON_SCHEDULE_SCHEDULED_AT_STATUS` (`scheduled_at`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cron Schedule';


DROP TABLE IF EXISTS `customer_address_entity`;
CREATE TABLE `customer_address_entity` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `parent_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Updated At',
  `is_active` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Active',
  `city` varchar(255) NOT NULL COMMENT 'City',
  `company` varchar(255) DEFAULT NULL COMMENT 'Company',
  `country_id` varchar(255) NOT NULL COMMENT 'Country',
  `fax` varchar(255) DEFAULT NULL COMMENT 'Fax',
  `firstname` varchar(255) NOT NULL COMMENT 'First Name',
  `lastname` varchar(255) NOT NULL COMMENT 'Last Name',
  `middlename` varchar(255) DEFAULT NULL COMMENT 'Middle Name',
  `postcode` varchar(255) DEFAULT NULL COMMENT 'Zip/Postal Code',
  `prefix` varchar(40) DEFAULT NULL COMMENT 'Name Prefix',
  `region` varchar(255) DEFAULT NULL COMMENT 'State/Province',
  `region_id` int(10) unsigned DEFAULT NULL COMMENT 'State/Province',
  `street` text NOT NULL COMMENT 'Street Address',
  `suffix` varchar(40) DEFAULT NULL COMMENT 'Name Suffix',
  `telephone` varchar(255) NOT NULL COMMENT 'Phone Number',
  `vat_id` varchar(255) DEFAULT NULL COMMENT 'VAT number',
  `vat_is_valid` int(10) unsigned DEFAULT NULL COMMENT 'VAT number validity',
  `vat_request_date` varchar(255) DEFAULT NULL COMMENT 'VAT number validation request date',
  `vat_request_id` varchar(255) DEFAULT NULL COMMENT 'VAT number validation request ID',
  `vat_request_success` int(10) unsigned DEFAULT NULL COMMENT 'VAT number validation request success',
  PRIMARY KEY (`entity_id`),
  KEY `CUSTOMER_ADDRESS_ENTITY_PARENT_ID` (`parent_id`),
  CONSTRAINT `CUSTOMER_ADDRESS_ENTITY_PARENT_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`parent_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity';

INSERT INTO `customer_address_entity` (`entity_id`, `increment_id`, `parent_id`, `created_at`, `updated_at`, `is_active`, `city`, `company`, `country_id`, `fax`, `firstname`, `lastname`, `middlename`, `postcode`, `prefix`, `region`, `region_id`, `street`, `suffix`, `telephone`, `vat_id`, `vat_is_valid`, `vat_request_date`, `vat_request_id`, `vat_request_success`) VALUES
(1,	NULL,	1,	'2019-02-18 15:10:15',	'2019-02-18 15:10:15',	1,	'ho chi minh',	NULL,	'VN',	NULL,	'phat',	'nguyen',	NULL,	'700000',	NULL,	NULL,	0,	'ho chi minh',	NULL,	'123213213',	NULL,	NULL,	NULL,	NULL,	NULL);

DROP TABLE IF EXISTS `customer_address_entity_datetime`;
CREATE TABLE `customer_address_entity_datetime` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` datetime DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `CUSTOMER_ADDRESS_ENTITY_DATETIME_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `CUSTOMER_ADDRESS_ENTITY_DATETIME_ATTRIBUTE_ID` (`attribute_id`),
  KEY `CUSTOMER_ADDRESS_ENTITY_DATETIME_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `CSTR_ADDR_ENTT_DTIME_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `CSTR_ADDR_ENTT_DTIME_ENTT_ID_CSTR_ADDR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_address_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity Datetime';


DROP TABLE IF EXISTS `customer_address_entity_decimal`;
CREATE TABLE `customer_address_entity_decimal` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `CUSTOMER_ADDRESS_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `CUSTOMER_ADDRESS_ENTITY_DECIMAL_ATTRIBUTE_ID` (`attribute_id`),
  KEY `CUSTOMER_ADDRESS_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `CSTR_ADDR_ENTT_DEC_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `CSTR_ADDR_ENTT_DEC_ENTT_ID_CSTR_ADDR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_address_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity Decimal';


DROP TABLE IF EXISTS `customer_address_entity_int`;
CREATE TABLE `customer_address_entity_int` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` int(11) NOT NULL DEFAULT '0' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `CUSTOMER_ADDRESS_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `CUSTOMER_ADDRESS_ENTITY_INT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `CUSTOMER_ADDRESS_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `CSTR_ADDR_ENTT_INT_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `CSTR_ADDR_ENTT_INT_ENTT_ID_CSTR_ADDR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_address_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity Int';


DROP TABLE IF EXISTS `customer_address_entity_text`;
CREATE TABLE `customer_address_entity_text` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` text NOT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `CUSTOMER_ADDRESS_ENTITY_TEXT_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `CUSTOMER_ADDRESS_ENTITY_TEXT_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `CSTR_ADDR_ENTT_TEXT_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `CSTR_ADDR_ENTT_TEXT_ENTT_ID_CSTR_ADDR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_address_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity Text';


DROP TABLE IF EXISTS `customer_address_entity_varchar`;
CREATE TABLE `customer_address_entity_varchar` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `CUSTOMER_ADDRESS_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `CUSTOMER_ADDRESS_ENTITY_VARCHAR_ATTRIBUTE_ID` (`attribute_id`),
  KEY `CUSTOMER_ADDRESS_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `CSTR_ADDR_ENTT_VCHR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `CSTR_ADDR_ENTT_VCHR_ENTT_ID_CSTR_ADDR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_address_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity Varchar';


DROP TABLE IF EXISTS `customer_eav_attribute`;
CREATE TABLE `customer_eav_attribute` (
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  `is_visible` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Visible',
  `input_filter` varchar(255) DEFAULT NULL COMMENT 'Input Filter',
  `multiline_count` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Multiline Count',
  `validate_rules` text COMMENT 'Validate Rules',
  `is_system` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is System',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `data_model` varchar(255) DEFAULT NULL COMMENT 'Data Model',
  `is_used_in_grid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Used in Grid',
  `is_visible_in_grid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible in Grid',
  `is_filterable_in_grid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Filterable in Grid',
  `is_searchable_in_grid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Searchable in Grid',
  PRIMARY KEY (`attribute_id`),
  CONSTRAINT `CUSTOMER_EAV_ATTRIBUTE_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Eav Attribute';

INSERT INTO `customer_eav_attribute` (`attribute_id`, `is_visible`, `input_filter`, `multiline_count`, `validate_rules`, `is_system`, `sort_order`, `data_model`, `is_used_in_grid`, `is_visible_in_grid`, `is_filterable_in_grid`, `is_searchable_in_grid`) VALUES
(1,	1,	NULL,	0,	NULL,	1,	10,	NULL,	1,	1,	1,	0),
(2,	0,	NULL,	0,	NULL,	1,	0,	NULL,	0,	0,	0,	0),
(3,	1,	NULL,	0,	NULL,	1,	20,	NULL,	1,	1,	0,	1),
(4,	0,	NULL,	0,	NULL,	0,	30,	NULL,	0,	0,	0,	0),
(5,	1,	'trim',	0,	'{\"max_text_length\":255,\"min_text_length\":1}',	1,	40,	NULL,	0,	0,	0,	0),
(6,	0,	'trim',	0,	NULL,	0,	50,	NULL,	0,	0,	0,	0),
(7,	1,	'trim',	0,	'{\"max_text_length\":255,\"min_text_length\":1}',	1,	60,	NULL,	0,	0,	0,	0),
(8,	0,	NULL,	0,	NULL,	0,	70,	NULL,	0,	0,	0,	0),
(9,	1,	NULL,	0,	'{\"input_validation\":\"email\"}',	1,	80,	NULL,	1,	1,	1,	1),
(10,	1,	NULL,	0,	NULL,	1,	25,	NULL,	1,	1,	1,	0),
(11,	0,	'date',	0,	'{\"input_validation\":\"date\"}',	0,	90,	NULL,	1,	1,	1,	0),
(12,	0,	NULL,	0,	NULL,	1,	0,	NULL,	0,	0,	0,	0),
(13,	0,	NULL,	0,	NULL,	1,	0,	NULL,	0,	0,	0,	0),
(14,	0,	NULL,	0,	'{\"input_validation\":\"date\"}',	1,	0,	NULL,	0,	0,	0,	0),
(15,	0,	NULL,	0,	NULL,	1,	0,	NULL,	0,	0,	0,	0),
(16,	0,	NULL,	0,	NULL,	1,	0,	NULL,	0,	0,	0,	0),
(17,	0,	NULL,	0,	'{\"max_text_length\":255}',	0,	100,	NULL,	1,	1,	0,	1),
(18,	0,	NULL,	0,	NULL,	1,	0,	NULL,	1,	1,	1,	0),
(19,	0,	NULL,	0,	NULL,	0,	0,	NULL,	1,	1,	1,	0),
(20,	0,	NULL,	0,	'[]',	0,	110,	NULL,	1,	1,	1,	0),
(21,	1,	NULL,	0,	NULL,	1,	28,	NULL,	0,	0,	0,	0),
(22,	0,	NULL,	0,	NULL,	0,	10,	NULL,	0,	0,	0,	0),
(23,	1,	'trim',	0,	'{\"max_text_length\":255,\"min_text_length\":1}',	1,	20,	NULL,	1,	0,	0,	1),
(24,	0,	'trim',	0,	NULL,	0,	30,	NULL,	0,	0,	0,	0),
(25,	1,	'trim',	0,	'{\"max_text_length\":255,\"min_text_length\":1}',	1,	40,	NULL,	1,	0,	0,	1),
(26,	0,	NULL,	0,	NULL,	0,	50,	NULL,	0,	0,	0,	0),
(27,	1,	NULL,	0,	'{\"max_text_length\":255,\"min_text_length\":1}',	1,	60,	NULL,	1,	0,	0,	1),
(28,	1,	NULL,	3,	'{\"max_text_length\":255,\"min_text_length\":1}',	1,	70,	NULL,	1,	0,	0,	1),
(29,	1,	NULL,	0,	'{\"max_text_length\":255,\"min_text_length\":1}',	1,	80,	NULL,	1,	0,	0,	1),
(30,	1,	NULL,	0,	NULL,	1,	90,	NULL,	1,	1,	1,	0),
(31,	1,	NULL,	0,	NULL,	1,	100,	NULL,	1,	1,	0,	1),
(32,	1,	NULL,	0,	NULL,	1,	100,	NULL,	0,	0,	0,	0),
(33,	1,	NULL,	0,	'[]',	1,	110,	'Magento\\Customer\\Model\\Attribute\\Data\\Postcode',	1,	1,	1,	1),
(34,	1,	NULL,	0,	'{\"max_text_length\":255,\"min_text_length\":1}',	1,	120,	NULL,	1,	1,	1,	1),
(35,	0,	NULL,	0,	'{\"max_text_length\":255,\"min_text_length\":1}',	0,	130,	NULL,	1,	0,	0,	1),
(36,	1,	NULL,	0,	NULL,	1,	140,	NULL,	0,	0,	0,	0),
(37,	0,	NULL,	0,	NULL,	1,	0,	NULL,	0,	0,	0,	0),
(38,	0,	NULL,	0,	NULL,	1,	0,	NULL,	0,	0,	0,	0),
(39,	0,	NULL,	0,	NULL,	1,	0,	NULL,	0,	0,	0,	0),
(40,	0,	NULL,	0,	NULL,	1,	0,	NULL,	0,	0,	0,	0),
(41,	0,	NULL,	0,	NULL,	0,	0,	NULL,	0,	0,	0,	0),
(42,	0,	NULL,	0,	NULL,	1,	0,	NULL,	0,	0,	0,	0),
(43,	0,	NULL,	0,	NULL,	1,	0,	NULL,	0,	0,	0,	0),
(44,	0,	NULL,	0,	NULL,	1,	0,	NULL,	0,	0,	0,	0);

DROP TABLE IF EXISTS `customer_eav_attribute_website`;
CREATE TABLE `customer_eav_attribute_website` (
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `is_visible` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Visible',
  `is_required` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Required',
  `default_value` text COMMENT 'Default Value',
  `multiline_count` smallint(5) unsigned DEFAULT NULL COMMENT 'Multiline Count',
  PRIMARY KEY (`attribute_id`,`website_id`),
  KEY `CUSTOMER_EAV_ATTRIBUTE_WEBSITE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `CSTR_EAV_ATTR_WS_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `CSTR_EAV_ATTR_WS_WS_ID_STORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Eav Attribute Website';

INSERT INTO `customer_eav_attribute_website` (`attribute_id`, `website_id`, `is_visible`, `is_required`, `default_value`, `multiline_count`) VALUES
(1,	1,	NULL,	NULL,	NULL,	NULL),
(3,	1,	NULL,	NULL,	NULL,	NULL),
(5,	1,	NULL,	NULL,	NULL,	NULL),
(6,	1,	NULL,	NULL,	NULL,	NULL),
(7,	1,	NULL,	NULL,	NULL,	NULL),
(9,	1,	NULL,	NULL,	NULL,	NULL),
(10,	1,	NULL,	NULL,	NULL,	NULL),
(11,	1,	NULL,	NULL,	NULL,	NULL),
(17,	1,	NULL,	NULL,	NULL,	NULL),
(18,	1,	NULL,	NULL,	NULL,	NULL),
(19,	1,	NULL,	NULL,	NULL,	NULL),
(20,	1,	NULL,	NULL,	NULL,	NULL),
(21,	1,	NULL,	NULL,	NULL,	NULL),
(23,	1,	NULL,	NULL,	NULL,	NULL),
(24,	1,	NULL,	NULL,	NULL,	NULL),
(25,	1,	NULL,	NULL,	NULL,	NULL),
(27,	1,	NULL,	NULL,	NULL,	NULL),
(28,	1,	NULL,	NULL,	NULL,	NULL),
(29,	1,	NULL,	NULL,	NULL,	NULL),
(30,	1,	NULL,	NULL,	NULL,	NULL),
(31,	1,	NULL,	NULL,	NULL,	NULL),
(32,	1,	NULL,	NULL,	NULL,	NULL),
(33,	1,	NULL,	NULL,	NULL,	NULL),
(34,	1,	NULL,	NULL,	NULL,	NULL),
(35,	1,	NULL,	NULL,	NULL,	NULL),
(36,	1,	NULL,	NULL,	NULL,	NULL);

DROP TABLE IF EXISTS `customer_entity`;
CREATE TABLE `customer_entity` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `website_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Website Id',
  `email` varchar(255) DEFAULT NULL COMMENT 'Email',
  `group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Group Id',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `store_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Store Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Updated At',
  `is_active` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Active',
  `disable_auto_group_change` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Disable automatic group change based on VAT ID',
  `created_in` varchar(255) DEFAULT NULL COMMENT 'Created From',
  `prefix` varchar(40) DEFAULT NULL COMMENT 'Name Prefix',
  `firstname` varchar(255) DEFAULT NULL COMMENT 'First Name',
  `middlename` varchar(255) DEFAULT NULL COMMENT 'Middle Name/Initial',
  `lastname` varchar(255) DEFAULT NULL COMMENT 'Last Name',
  `suffix` varchar(40) DEFAULT NULL COMMENT 'Name Suffix',
  `dob` date DEFAULT NULL COMMENT 'Date of Birth',
  `password_hash` varchar(128) DEFAULT NULL COMMENT 'Password_hash',
  `rp_token` varchar(128) DEFAULT NULL COMMENT 'Reset password token',
  `rp_token_created_at` datetime DEFAULT NULL COMMENT 'Reset password token creation time',
  `default_billing` int(10) unsigned DEFAULT NULL COMMENT 'Default Billing Address',
  `default_shipping` int(10) unsigned DEFAULT NULL COMMENT 'Default Shipping Address',
  `taxvat` varchar(50) DEFAULT NULL COMMENT 'Tax/VAT Number',
  `confirmation` varchar(64) DEFAULT NULL COMMENT 'Is Confirmed',
  `gender` smallint(5) unsigned DEFAULT NULL COMMENT 'Gender',
  `failures_num` smallint(6) DEFAULT '0' COMMENT 'Failure Number',
  `first_failure` timestamp NULL DEFAULT NULL COMMENT 'First Failure',
  `lock_expires` timestamp NULL DEFAULT NULL COMMENT 'Lock Expiration Date',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `CUSTOMER_ENTITY_EMAIL_WEBSITE_ID` (`email`,`website_id`),
  KEY `CUSTOMER_ENTITY_STORE_ID` (`store_id`),
  KEY `CUSTOMER_ENTITY_WEBSITE_ID` (`website_id`),
  KEY `CUSTOMER_ENTITY_FIRSTNAME` (`firstname`),
  KEY `CUSTOMER_ENTITY_LASTNAME` (`lastname`),
  CONSTRAINT `CUSTOMER_ENTITY_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE SET NULL,
  CONSTRAINT `CUSTOMER_ENTITY_WEBSITE_ID_STORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `store_website` (`website_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Entity';

INSERT INTO `customer_entity` (`entity_id`, `website_id`, `email`, `group_id`, `increment_id`, `store_id`, `created_at`, `updated_at`, `is_active`, `disable_auto_group_change`, `created_in`, `prefix`, `firstname`, `middlename`, `lastname`, `suffix`, `dob`, `password_hash`, `rp_token`, `rp_token_created_at`, `default_billing`, `default_shipping`, `taxvat`, `confirmation`, `gender`, `failures_num`, `first_failure`, `lock_expires`) VALUES
(1,	1,	'xnguyen@collinsharper.com',	1,	NULL,	1,	'2019-02-18 15:06:43',	'2019-02-18 15:10:15',	1,	0,	'Default Store View',	NULL,	'xavi',	NULL,	'nguyen',	NULL,	NULL,	'd1aaf3f6e8fc718ab0b12f5054376bfd301d25c5f95ef708624ae1832e8e529b:lewFCyFclHWb2EPl33kvtpg29UQWC0Aq:1',	'n2zAX05vTAkPa9Ib0TUThh1RwxptHkxD',	'2019-02-18 15:06:43',	1,	1,	NULL,	NULL,	NULL,	0,	NULL,	NULL);

DROP TABLE IF EXISTS `customer_entity_datetime`;
CREATE TABLE `customer_entity_datetime` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` datetime DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `CUSTOMER_ENTITY_DATETIME_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `CUSTOMER_ENTITY_DATETIME_ATTRIBUTE_ID` (`attribute_id`),
  KEY `CUSTOMER_ENTITY_DATETIME_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `CUSTOMER_ENTITY_DATETIME_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `CUSTOMER_ENTITY_DATETIME_ENTITY_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Entity Datetime';


DROP TABLE IF EXISTS `customer_entity_decimal`;
CREATE TABLE `customer_entity_decimal` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `CUSTOMER_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `CUSTOMER_ENTITY_DECIMAL_ATTRIBUTE_ID` (`attribute_id`),
  KEY `CUSTOMER_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `CUSTOMER_ENTITY_DECIMAL_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `CUSTOMER_ENTITY_DECIMAL_ENTITY_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Entity Decimal';


DROP TABLE IF EXISTS `customer_entity_int`;
CREATE TABLE `customer_entity_int` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` int(11) NOT NULL DEFAULT '0' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `CUSTOMER_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `CUSTOMER_ENTITY_INT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `CUSTOMER_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `CUSTOMER_ENTITY_INT_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `CUSTOMER_ENTITY_INT_ENTITY_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Entity Int';


DROP TABLE IF EXISTS `customer_entity_text`;
CREATE TABLE `customer_entity_text` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` text NOT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `CUSTOMER_ENTITY_TEXT_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `CUSTOMER_ENTITY_TEXT_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `CUSTOMER_ENTITY_TEXT_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `CUSTOMER_ENTITY_TEXT_ENTITY_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Entity Text';


DROP TABLE IF EXISTS `customer_entity_varchar`;
CREATE TABLE `customer_entity_varchar` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `CUSTOMER_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `CUSTOMER_ENTITY_VARCHAR_ATTRIBUTE_ID` (`attribute_id`),
  KEY `CUSTOMER_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `CUSTOMER_ENTITY_VARCHAR_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `CUSTOMER_ENTITY_VARCHAR_ENTITY_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Entity Varchar';


DROP TABLE IF EXISTS `customer_form_attribute`;
CREATE TABLE `customer_form_attribute` (
  `form_code` varchar(32) NOT NULL COMMENT 'Form Code',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  PRIMARY KEY (`form_code`,`attribute_id`),
  KEY `CUSTOMER_FORM_ATTRIBUTE_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `CUSTOMER_FORM_ATTRIBUTE_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Form Attribute';

INSERT INTO `customer_form_attribute` (`form_code`, `attribute_id`) VALUES
('adminhtml_customer',	1),
('adminhtml_customer',	3),
('adminhtml_customer',	4),
('customer_account_create',	4),
('customer_account_edit',	4),
('adminhtml_customer',	5),
('customer_account_create',	5),
('customer_account_edit',	5),
('adminhtml_customer',	6),
('customer_account_create',	6),
('customer_account_edit',	6),
('adminhtml_customer',	7),
('customer_account_create',	7),
('customer_account_edit',	7),
('adminhtml_customer',	8),
('customer_account_create',	8),
('customer_account_edit',	8),
('adminhtml_checkout',	9),
('adminhtml_customer',	9),
('customer_account_create',	9),
('customer_account_edit',	9),
('adminhtml_checkout',	10),
('adminhtml_customer',	10),
('adminhtml_checkout',	11),
('adminhtml_customer',	11),
('customer_account_create',	11),
('customer_account_edit',	11),
('adminhtml_checkout',	17),
('adminhtml_customer',	17),
('customer_account_create',	17),
('customer_account_edit',	17),
('adminhtml_customer',	19),
('customer_account_create',	19),
('customer_account_edit',	19),
('adminhtml_checkout',	20),
('adminhtml_customer',	20),
('customer_account_create',	20),
('customer_account_edit',	20),
('adminhtml_customer',	21),
('adminhtml_customer_address',	22),
('customer_address_edit',	22),
('customer_register_address',	22),
('adminhtml_customer_address',	23),
('customer_address_edit',	23),
('customer_register_address',	23),
('adminhtml_customer_address',	24),
('customer_address_edit',	24),
('customer_register_address',	24),
('adminhtml_customer_address',	25),
('customer_address_edit',	25),
('customer_register_address',	25),
('adminhtml_customer_address',	26),
('customer_address_edit',	26),
('customer_register_address',	26),
('adminhtml_customer_address',	27),
('customer_address_edit',	27),
('customer_register_address',	27),
('adminhtml_customer_address',	28),
('customer_address_edit',	28),
('customer_register_address',	28),
('adminhtml_customer_address',	29),
('customer_address_edit',	29),
('customer_register_address',	29),
('adminhtml_customer_address',	30),
('customer_address_edit',	30),
('customer_register_address',	30),
('adminhtml_customer_address',	31),
('customer_address_edit',	31),
('customer_register_address',	31),
('adminhtml_customer_address',	32),
('customer_address_edit',	32),
('customer_register_address',	32),
('adminhtml_customer_address',	33),
('customer_address_edit',	33),
('customer_register_address',	33),
('adminhtml_customer_address',	34),
('customer_address_edit',	34),
('customer_register_address',	34),
('adminhtml_customer_address',	35),
('customer_address_edit',	35),
('customer_register_address',	35),
('adminhtml_customer_address',	36),
('customer_address_edit',	36),
('customer_register_address',	36);

DROP TABLE IF EXISTS `customer_grid_flat`;
CREATE TABLE `customer_grid_flat` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `name` text COMMENT 'Name',
  `email` varchar(255) DEFAULT NULL COMMENT 'Email',
  `group_id` int(11) DEFAULT NULL COMMENT 'Group_id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created_at',
  `website_id` int(11) DEFAULT NULL COMMENT 'Website_id',
  `confirmation` varchar(255) DEFAULT NULL COMMENT 'Confirmation',
  `created_in` text COMMENT 'Created_in',
  `dob` date DEFAULT NULL COMMENT 'Dob',
  `gender` int(11) DEFAULT NULL COMMENT 'Gender',
  `taxvat` varchar(255) DEFAULT NULL COMMENT 'Taxvat',
  `lock_expires` timestamp NULL DEFAULT NULL COMMENT 'Lock_expires',
  `shipping_full` text COMMENT 'Shipping_full',
  `billing_full` text COMMENT 'Billing_full',
  `billing_firstname` varchar(255) DEFAULT NULL COMMENT 'Billing_firstname',
  `billing_lastname` varchar(255) DEFAULT NULL COMMENT 'Billing_lastname',
  `billing_telephone` varchar(255) DEFAULT NULL COMMENT 'Billing_telephone',
  `billing_postcode` varchar(255) DEFAULT NULL COMMENT 'Billing_postcode',
  `billing_country_id` varchar(255) DEFAULT NULL COMMENT 'Billing_country_id',
  `billing_region` varchar(255) DEFAULT NULL COMMENT 'Billing_region',
  `billing_street` varchar(255) DEFAULT NULL COMMENT 'Billing_street',
  `billing_city` varchar(255) DEFAULT NULL COMMENT 'Billing_city',
  `billing_fax` varchar(255) DEFAULT NULL COMMENT 'Billing_fax',
  `billing_vat_id` varchar(255) DEFAULT NULL COMMENT 'Billing_vat_id',
  `billing_company` varchar(255) DEFAULT NULL COMMENT 'Billing_company',
  PRIMARY KEY (`entity_id`),
  KEY `CUSTOMER_GRID_FLAT_GROUP_ID` (`group_id`),
  KEY `CUSTOMER_GRID_FLAT_CREATED_AT` (`created_at`),
  KEY `CUSTOMER_GRID_FLAT_WEBSITE_ID` (`website_id`),
  KEY `CUSTOMER_GRID_FLAT_CONFIRMATION` (`confirmation`),
  KEY `CUSTOMER_GRID_FLAT_DOB` (`dob`),
  KEY `CUSTOMER_GRID_FLAT_GENDER` (`gender`),
  KEY `CUSTOMER_GRID_FLAT_BILLING_COUNTRY_ID` (`billing_country_id`),
  FULLTEXT KEY `FTI_8746F705702DD5F6D45B8C7CE7FE9F2F` (`name`,`email`,`created_in`,`taxvat`,`shipping_full`,`billing_full`,`billing_firstname`,`billing_lastname`,`billing_telephone`,`billing_postcode`,`billing_region`,`billing_city`,`billing_fax`,`billing_company`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='customer_grid_flat';

INSERT INTO `customer_grid_flat` (`entity_id`, `name`, `email`, `group_id`, `created_at`, `website_id`, `confirmation`, `created_in`, `dob`, `gender`, `taxvat`, `lock_expires`, `shipping_full`, `billing_full`, `billing_firstname`, `billing_lastname`, `billing_telephone`, `billing_postcode`, `billing_country_id`, `billing_region`, `billing_street`, `billing_city`, `billing_fax`, `billing_vat_id`, `billing_company`) VALUES
(1,	'xavi nguyen',	'xnguyen@collinsharper.com',	1,	'2019-02-18 15:06:43',	1,	NULL,	'Default Store View',	NULL,	NULL,	NULL,	NULL,	'ho chi minh ho chi minh 700000',	'ho chi minh ho chi minh 700000',	'phat',	'nguyen',	'123213213',	'700000',	'VN',	NULL,	'ho chi minh',	'ho chi minh',	NULL,	NULL,	NULL);

DROP TABLE IF EXISTS `customer_group`;
CREATE TABLE `customer_group` (
  `customer_group_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `customer_group_code` varchar(32) NOT NULL COMMENT 'Customer Group Code',
  `tax_class_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Tax Class Id',
  PRIMARY KEY (`customer_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Group';

INSERT INTO `customer_group` (`customer_group_id`, `customer_group_code`, `tax_class_id`) VALUES
(0,	'NOT LOGGED IN',	3),
(1,	'General',	3),
(2,	'Wholesale',	3),
(3,	'Retailer',	3);

DROP TABLE IF EXISTS `customer_log`;
CREATE TABLE `customer_log` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Log ID',
  `customer_id` int(11) NOT NULL COMMENT 'Customer ID',
  `last_login_at` timestamp NULL DEFAULT NULL COMMENT 'Last Login Time',
  `last_logout_at` timestamp NULL DEFAULT NULL COMMENT 'Last Logout Time',
  PRIMARY KEY (`log_id`),
  UNIQUE KEY `CUSTOMER_LOG_CUSTOMER_ID` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Log Table';

INSERT INTO `customer_log` (`log_id`, `customer_id`, `last_login_at`, `last_logout_at`) VALUES
(1,	1,	'2019-02-18 15:06:45',	NULL);

DROP TABLE IF EXISTS `customer_visitor`;
CREATE TABLE `customer_visitor` (
  `visitor_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Visitor ID',
  `customer_id` int(11) DEFAULT NULL COMMENT 'Customer Id',
  `session_id` varchar(64) DEFAULT NULL COMMENT 'Session ID',
  `last_visit_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last Visit Time',
  PRIMARY KEY (`visitor_id`),
  KEY `CUSTOMER_VISITOR_CUSTOMER_ID` (`customer_id`),
  KEY `CUSTOMER_VISITOR_LAST_VISIT_AT` (`last_visit_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Visitor Table';

INSERT INTO `customer_visitor` (`visitor_id`, `customer_id`, `session_id`, `last_visit_at`) VALUES
(1,	1,	'e079973c7c37909197aa2da6ac0002a8',	'2019-02-18 15:47:04');

DROP TABLE IF EXISTS `design_change`;
CREATE TABLE `design_change` (
  `design_change_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Design Change Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `design` varchar(255) DEFAULT NULL COMMENT 'Design',
  `date_from` date DEFAULT NULL COMMENT 'First Date of Design Activity',
  `date_to` date DEFAULT NULL COMMENT 'Last Date of Design Activity',
  PRIMARY KEY (`design_change_id`),
  KEY `DESIGN_CHANGE_STORE_ID` (`store_id`),
  CONSTRAINT `DESIGN_CHANGE_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Design Changes';


DROP TABLE IF EXISTS `design_config_grid_flat`;
CREATE TABLE `design_config_grid_flat` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `store_website_id` int(11) DEFAULT NULL COMMENT 'Store_website_id',
  `store_group_id` int(11) DEFAULT NULL COMMENT 'Store_group_id',
  `store_id` int(11) DEFAULT NULL COMMENT 'Store_id',
  `theme_theme_id` varchar(255) DEFAULT NULL COMMENT 'Theme_theme_id',
  PRIMARY KEY (`entity_id`),
  KEY `DESIGN_CONFIG_GRID_FLAT_STORE_WEBSITE_ID` (`store_website_id`),
  KEY `DESIGN_CONFIG_GRID_FLAT_STORE_GROUP_ID` (`store_group_id`),
  KEY `DESIGN_CONFIG_GRID_FLAT_STORE_ID` (`store_id`),
  FULLTEXT KEY `DESIGN_CONFIG_GRID_FLAT_THEME_THEME_ID` (`theme_theme_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='design_config_grid_flat';

INSERT INTO `design_config_grid_flat` (`entity_id`, `store_website_id`, `store_group_id`, `store_id`, `theme_theme_id`) VALUES
(0,	NULL,	NULL,	NULL,	''),
(1,	1,	NULL,	NULL,	''),
(2,	1,	1,	1,	'');

DROP TABLE IF EXISTS `directory_country`;
CREATE TABLE `directory_country` (
  `country_id` varchar(2) NOT NULL COMMENT 'Country Id in ISO-2',
  `iso2_code` varchar(2) DEFAULT NULL COMMENT 'Country ISO-2 format',
  `iso3_code` varchar(3) DEFAULT NULL COMMENT 'Country ISO-3',
  PRIMARY KEY (`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Directory Country';

INSERT INTO `directory_country` (`country_id`, `iso2_code`, `iso3_code`) VALUES
('AD',	'AD',	'AND'),
('AE',	'AE',	'ARE'),
('AF',	'AF',	'AFG'),
('AG',	'AG',	'ATG'),
('AI',	'AI',	'AIA'),
('AL',	'AL',	'ALB'),
('AM',	'AM',	'ARM'),
('AN',	'AN',	'ANT'),
('AO',	'AO',	'AGO'),
('AQ',	'AQ',	'ATA'),
('AR',	'AR',	'ARG'),
('AS',	'AS',	'ASM'),
('AT',	'AT',	'AUT'),
('AU',	'AU',	'AUS'),
('AW',	'AW',	'ABW'),
('AX',	'AX',	'ALA'),
('AZ',	'AZ',	'AZE'),
('BA',	'BA',	'BIH'),
('BB',	'BB',	'BRB'),
('BD',	'BD',	'BGD'),
('BE',	'BE',	'BEL'),
('BF',	'BF',	'BFA'),
('BG',	'BG',	'BGR'),
('BH',	'BH',	'BHR'),
('BI',	'BI',	'BDI'),
('BJ',	'BJ',	'BEN'),
('BL',	'BL',	'BLM'),
('BM',	'BM',	'BMU'),
('BN',	'BN',	'BRN'),
('BO',	'BO',	'BOL'),
('BR',	'BR',	'BRA'),
('BS',	'BS',	'BHS'),
('BT',	'BT',	'BTN'),
('BV',	'BV',	'BVT'),
('BW',	'BW',	'BWA'),
('BY',	'BY',	'BLR'),
('BZ',	'BZ',	'BLZ'),
('CA',	'CA',	'CAN'),
('CC',	'CC',	'CCK'),
('CD',	'CD',	'COD'),
('CF',	'CF',	'CAF'),
('CG',	'CG',	'COG'),
('CH',	'CH',	'CHE'),
('CI',	'CI',	'CIV'),
('CK',	'CK',	'COK'),
('CL',	'CL',	'CHL'),
('CM',	'CM',	'CMR'),
('CN',	'CN',	'CHN'),
('CO',	'CO',	'COL'),
('CR',	'CR',	'CRI'),
('CU',	'CU',	'CUB'),
('CV',	'CV',	'CPV'),
('CX',	'CX',	'CXR'),
('CY',	'CY',	'CYP'),
('CZ',	'CZ',	'CZE'),
('DE',	'DE',	'DEU'),
('DJ',	'DJ',	'DJI'),
('DK',	'DK',	'DNK'),
('DM',	'DM',	'DMA'),
('DO',	'DO',	'DOM'),
('DZ',	'DZ',	'DZA'),
('EC',	'EC',	'ECU'),
('EE',	'EE',	'EST'),
('EG',	'EG',	'EGY'),
('EH',	'EH',	'ESH'),
('ER',	'ER',	'ERI'),
('ES',	'ES',	'ESP'),
('ET',	'ET',	'ETH'),
('FI',	'FI',	'FIN'),
('FJ',	'FJ',	'FJI'),
('FK',	'FK',	'FLK'),
('FM',	'FM',	'FSM'),
('FO',	'FO',	'FRO'),
('FR',	'FR',	'FRA'),
('GA',	'GA',	'GAB'),
('GB',	'GB',	'GBR'),
('GD',	'GD',	'GRD'),
('GE',	'GE',	'GEO'),
('GF',	'GF',	'GUF'),
('GG',	'GG',	'GGY'),
('GH',	'GH',	'GHA'),
('GI',	'GI',	'GIB'),
('GL',	'GL',	'GRL'),
('GM',	'GM',	'GMB'),
('GN',	'GN',	'GIN'),
('GP',	'GP',	'GLP'),
('GQ',	'GQ',	'GNQ'),
('GR',	'GR',	'GRC'),
('GS',	'GS',	'SGS'),
('GT',	'GT',	'GTM'),
('GU',	'GU',	'GUM'),
('GW',	'GW',	'GNB'),
('GY',	'GY',	'GUY'),
('HK',	'HK',	'HKG'),
('HM',	'HM',	'HMD'),
('HN',	'HN',	'HND'),
('HR',	'HR',	'HRV'),
('HT',	'HT',	'HTI'),
('HU',	'HU',	'HUN'),
('ID',	'ID',	'IDN'),
('IE',	'IE',	'IRL'),
('IL',	'IL',	'ISR'),
('IM',	'IM',	'IMN'),
('IN',	'IN',	'IND'),
('IO',	'IO',	'IOT'),
('IQ',	'IQ',	'IRQ'),
('IR',	'IR',	'IRN'),
('IS',	'IS',	'ISL'),
('IT',	'IT',	'ITA'),
('JE',	'JE',	'JEY'),
('JM',	'JM',	'JAM'),
('JO',	'JO',	'JOR'),
('JP',	'JP',	'JPN'),
('KE',	'KE',	'KEN'),
('KG',	'KG',	'KGZ'),
('KH',	'KH',	'KHM'),
('KI',	'KI',	'KIR'),
('KM',	'KM',	'COM'),
('KN',	'KN',	'KNA'),
('KP',	'KP',	'PRK'),
('KR',	'KR',	'KOR'),
('KW',	'KW',	'KWT'),
('KY',	'KY',	'CYM'),
('KZ',	'KZ',	'KAZ'),
('LA',	'LA',	'LAO'),
('LB',	'LB',	'LBN'),
('LC',	'LC',	'LCA'),
('LI',	'LI',	'LIE'),
('LK',	'LK',	'LKA'),
('LR',	'LR',	'LBR'),
('LS',	'LS',	'LSO'),
('LT',	'LT',	'LTU'),
('LU',	'LU',	'LUX'),
('LV',	'LV',	'LVA'),
('LY',	'LY',	'LBY'),
('MA',	'MA',	'MAR'),
('MC',	'MC',	'MCO'),
('MD',	'MD',	'MDA'),
('ME',	'ME',	'MNE'),
('MF',	'MF',	'MAF'),
('MG',	'MG',	'MDG'),
('MH',	'MH',	'MHL'),
('MK',	'MK',	'MKD'),
('ML',	'ML',	'MLI'),
('MM',	'MM',	'MMR'),
('MN',	'MN',	'MNG'),
('MO',	'MO',	'MAC'),
('MP',	'MP',	'MNP'),
('MQ',	'MQ',	'MTQ'),
('MR',	'MR',	'MRT'),
('MS',	'MS',	'MSR'),
('MT',	'MT',	'MLT'),
('MU',	'MU',	'MUS'),
('MV',	'MV',	'MDV'),
('MW',	'MW',	'MWI'),
('MX',	'MX',	'MEX'),
('MY',	'MY',	'MYS'),
('MZ',	'MZ',	'MOZ'),
('NA',	'NA',	'NAM'),
('NC',	'NC',	'NCL'),
('NE',	'NE',	'NER'),
('NF',	'NF',	'NFK'),
('NG',	'NG',	'NGA'),
('NI',	'NI',	'NIC'),
('NL',	'NL',	'NLD'),
('NO',	'NO',	'NOR'),
('NP',	'NP',	'NPL'),
('NR',	'NR',	'NRU'),
('NU',	'NU',	'NIU'),
('NZ',	'NZ',	'NZL'),
('OM',	'OM',	'OMN'),
('PA',	'PA',	'PAN'),
('PE',	'PE',	'PER'),
('PF',	'PF',	'PYF'),
('PG',	'PG',	'PNG'),
('PH',	'PH',	'PHL'),
('PK',	'PK',	'PAK'),
('PL',	'PL',	'POL'),
('PM',	'PM',	'SPM'),
('PN',	'PN',	'PCN'),
('PS',	'PS',	'PSE'),
('PT',	'PT',	'PRT'),
('PW',	'PW',	'PLW'),
('PY',	'PY',	'PRY'),
('QA',	'QA',	'QAT'),
('RE',	'RE',	'REU'),
('RO',	'RO',	'ROU'),
('RS',	'RS',	'SRB'),
('RU',	'RU',	'RUS'),
('RW',	'RW',	'RWA'),
('SA',	'SA',	'SAU'),
('SB',	'SB',	'SLB'),
('SC',	'SC',	'SYC'),
('SD',	'SD',	'SDN'),
('SE',	'SE',	'SWE'),
('SG',	'SG',	'SGP'),
('SH',	'SH',	'SHN'),
('SI',	'SI',	'SVN'),
('SJ',	'SJ',	'SJM'),
('SK',	'SK',	'SVK'),
('SL',	'SL',	'SLE'),
('SM',	'SM',	'SMR'),
('SN',	'SN',	'SEN'),
('SO',	'SO',	'SOM'),
('SR',	'SR',	'SUR'),
('ST',	'ST',	'STP'),
('SV',	'SV',	'SLV'),
('SY',	'SY',	'SYR'),
('SZ',	'SZ',	'SWZ'),
('TC',	'TC',	'TCA'),
('TD',	'TD',	'TCD'),
('TF',	'TF',	'ATF'),
('TG',	'TG',	'TGO'),
('TH',	'TH',	'THA'),
('TJ',	'TJ',	'TJK'),
('TK',	'TK',	'TKL'),
('TL',	'TL',	'TLS'),
('TM',	'TM',	'TKM'),
('TN',	'TN',	'TUN'),
('TO',	'TO',	'TON'),
('TR',	'TR',	'TUR'),
('TT',	'TT',	'TTO'),
('TV',	'TV',	'TUV'),
('TW',	'TW',	'TWN'),
('TZ',	'TZ',	'TZA'),
('UA',	'UA',	'UKR'),
('UG',	'UG',	'UGA'),
('UM',	'UM',	'UMI'),
('US',	'US',	'USA'),
('UY',	'UY',	'URY'),
('UZ',	'UZ',	'UZB'),
('VA',	'VA',	'VAT'),
('VC',	'VC',	'VCT'),
('VE',	'VE',	'VEN'),
('VG',	'VG',	'VGB'),
('VI',	'VI',	'VIR'),
('VN',	'VN',	'VNM'),
('VU',	'VU',	'VUT'),
('WF',	'WF',	'WLF'),
('WS',	'WS',	'WSM'),
('YE',	'YE',	'YEM'),
('YT',	'YT',	'MYT'),
('ZA',	'ZA',	'ZAF'),
('ZM',	'ZM',	'ZMB'),
('ZW',	'ZW',	'ZWE');

DROP TABLE IF EXISTS `directory_country_format`;
CREATE TABLE `directory_country_format` (
  `country_format_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Country Format Id',
  `country_id` varchar(2) DEFAULT NULL COMMENT 'Country Id in ISO-2',
  `type` varchar(30) DEFAULT NULL COMMENT 'Country Format Type',
  `format` text NOT NULL COMMENT 'Country Format',
  PRIMARY KEY (`country_format_id`),
  UNIQUE KEY `DIRECTORY_COUNTRY_FORMAT_COUNTRY_ID_TYPE` (`country_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Directory Country Format';


DROP TABLE IF EXISTS `directory_country_region`;
CREATE TABLE `directory_country_region` (
  `region_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Region Id',
  `country_id` varchar(4) NOT NULL DEFAULT '0' COMMENT 'Country Id in ISO-2',
  `code` varchar(32) DEFAULT NULL COMMENT 'Region code',
  `default_name` varchar(255) DEFAULT NULL COMMENT 'Region Name',
  PRIMARY KEY (`region_id`),
  KEY `DIRECTORY_COUNTRY_REGION_COUNTRY_ID` (`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Directory Country Region';

INSERT INTO `directory_country_region` (`region_id`, `country_id`, `code`, `default_name`) VALUES
(1,	'US',	'AL',	'Alabama'),
(2,	'US',	'AK',	'Alaska'),
(3,	'US',	'AS',	'American Samoa'),
(4,	'US',	'AZ',	'Arizona'),
(5,	'US',	'AR',	'Arkansas'),
(6,	'US',	'AE',	'Armed Forces Africa'),
(7,	'US',	'AA',	'Armed Forces Americas'),
(8,	'US',	'AE',	'Armed Forces Canada'),
(9,	'US',	'AE',	'Armed Forces Europe'),
(10,	'US',	'AE',	'Armed Forces Middle East'),
(11,	'US',	'AP',	'Armed Forces Pacific'),
(12,	'US',	'CA',	'California'),
(13,	'US',	'CO',	'Colorado'),
(14,	'US',	'CT',	'Connecticut'),
(15,	'US',	'DE',	'Delaware'),
(16,	'US',	'DC',	'District of Columbia'),
(17,	'US',	'FM',	'Federated States Of Micronesia'),
(18,	'US',	'FL',	'Florida'),
(19,	'US',	'GA',	'Georgia'),
(20,	'US',	'GU',	'Guam'),
(21,	'US',	'HI',	'Hawaii'),
(22,	'US',	'ID',	'Idaho'),
(23,	'US',	'IL',	'Illinois'),
(24,	'US',	'IN',	'Indiana'),
(25,	'US',	'IA',	'Iowa'),
(26,	'US',	'KS',	'Kansas'),
(27,	'US',	'KY',	'Kentucky'),
(28,	'US',	'LA',	'Louisiana'),
(29,	'US',	'ME',	'Maine'),
(30,	'US',	'MH',	'Marshall Islands'),
(31,	'US',	'MD',	'Maryland'),
(32,	'US',	'MA',	'Massachusetts'),
(33,	'US',	'MI',	'Michigan'),
(34,	'US',	'MN',	'Minnesota'),
(35,	'US',	'MS',	'Mississippi'),
(36,	'US',	'MO',	'Missouri'),
(37,	'US',	'MT',	'Montana'),
(38,	'US',	'NE',	'Nebraska'),
(39,	'US',	'NV',	'Nevada'),
(40,	'US',	'NH',	'New Hampshire'),
(41,	'US',	'NJ',	'New Jersey'),
(42,	'US',	'NM',	'New Mexico'),
(43,	'US',	'NY',	'New York'),
(44,	'US',	'NC',	'North Carolina'),
(45,	'US',	'ND',	'North Dakota'),
(46,	'US',	'MP',	'Northern Mariana Islands'),
(47,	'US',	'OH',	'Ohio'),
(48,	'US',	'OK',	'Oklahoma'),
(49,	'US',	'OR',	'Oregon'),
(50,	'US',	'PW',	'Palau'),
(51,	'US',	'PA',	'Pennsylvania'),
(52,	'US',	'PR',	'Puerto Rico'),
(53,	'US',	'RI',	'Rhode Island'),
(54,	'US',	'SC',	'South Carolina'),
(55,	'US',	'SD',	'South Dakota'),
(56,	'US',	'TN',	'Tennessee'),
(57,	'US',	'TX',	'Texas'),
(58,	'US',	'UT',	'Utah'),
(59,	'US',	'VT',	'Vermont'),
(60,	'US',	'VI',	'Virgin Islands'),
(61,	'US',	'VA',	'Virginia'),
(62,	'US',	'WA',	'Washington'),
(63,	'US',	'WV',	'West Virginia'),
(64,	'US',	'WI',	'Wisconsin'),
(65,	'US',	'WY',	'Wyoming'),
(66,	'CA',	'AB',	'Alberta'),
(67,	'CA',	'BC',	'British Columbia'),
(68,	'CA',	'MB',	'Manitoba'),
(69,	'CA',	'NL',	'Newfoundland and Labrador'),
(70,	'CA',	'NB',	'New Brunswick'),
(71,	'CA',	'NS',	'Nova Scotia'),
(72,	'CA',	'NT',	'Northwest Territories'),
(73,	'CA',	'NU',	'Nunavut'),
(74,	'CA',	'ON',	'Ontario'),
(75,	'CA',	'PE',	'Prince Edward Island'),
(76,	'CA',	'QC',	'Quebec'),
(77,	'CA',	'SK',	'Saskatchewan'),
(78,	'CA',	'YT',	'Yukon Territory'),
(79,	'DE',	'NDS',	'Niedersachsen'),
(80,	'DE',	'BAW',	'Baden-Württemberg'),
(81,	'DE',	'BAY',	'Bayern'),
(82,	'DE',	'BER',	'Berlin'),
(83,	'DE',	'BRG',	'Brandenburg'),
(84,	'DE',	'BRE',	'Bremen'),
(85,	'DE',	'HAM',	'Hamburg'),
(86,	'DE',	'HES',	'Hessen'),
(87,	'DE',	'MEC',	'Mecklenburg-Vorpommern'),
(88,	'DE',	'NRW',	'Nordrhein-Westfalen'),
(89,	'DE',	'RHE',	'Rheinland-Pfalz'),
(90,	'DE',	'SAR',	'Saarland'),
(91,	'DE',	'SAS',	'Sachsen'),
(92,	'DE',	'SAC',	'Sachsen-Anhalt'),
(93,	'DE',	'SCN',	'Schleswig-Holstein'),
(94,	'DE',	'THE',	'Thüringen'),
(95,	'AT',	'WI',	'Wien'),
(96,	'AT',	'NO',	'Niederösterreich'),
(97,	'AT',	'OO',	'Oberösterreich'),
(98,	'AT',	'SB',	'Salzburg'),
(99,	'AT',	'KN',	'Kärnten'),
(100,	'AT',	'ST',	'Steiermark'),
(101,	'AT',	'TI',	'Tirol'),
(102,	'AT',	'BL',	'Burgenland'),
(103,	'AT',	'VB',	'Vorarlberg'),
(104,	'CH',	'AG',	'Aargau'),
(105,	'CH',	'AI',	'Appenzell Innerrhoden'),
(106,	'CH',	'AR',	'Appenzell Ausserrhoden'),
(107,	'CH',	'BE',	'Bern'),
(108,	'CH',	'BL',	'Basel-Landschaft'),
(109,	'CH',	'BS',	'Basel-Stadt'),
(110,	'CH',	'FR',	'Freiburg'),
(111,	'CH',	'GE',	'Genf'),
(112,	'CH',	'GL',	'Glarus'),
(113,	'CH',	'GR',	'Graubünden'),
(114,	'CH',	'JU',	'Jura'),
(115,	'CH',	'LU',	'Luzern'),
(116,	'CH',	'NE',	'Neuenburg'),
(117,	'CH',	'NW',	'Nidwalden'),
(118,	'CH',	'OW',	'Obwalden'),
(119,	'CH',	'SG',	'St. Gallen'),
(120,	'CH',	'SH',	'Schaffhausen'),
(121,	'CH',	'SO',	'Solothurn'),
(122,	'CH',	'SZ',	'Schwyz'),
(123,	'CH',	'TG',	'Thurgau'),
(124,	'CH',	'TI',	'Tessin'),
(125,	'CH',	'UR',	'Uri'),
(126,	'CH',	'VD',	'Waadt'),
(127,	'CH',	'VS',	'Wallis'),
(128,	'CH',	'ZG',	'Zug'),
(129,	'CH',	'ZH',	'Zürich'),
(130,	'ES',	'A Coruсa',	'A Coruña'),
(131,	'ES',	'Alava',	'Alava'),
(132,	'ES',	'Albacete',	'Albacete'),
(133,	'ES',	'Alicante',	'Alicante'),
(134,	'ES',	'Almeria',	'Almeria'),
(135,	'ES',	'Asturias',	'Asturias'),
(136,	'ES',	'Avila',	'Avila'),
(137,	'ES',	'Badajoz',	'Badajoz'),
(138,	'ES',	'Baleares',	'Baleares'),
(139,	'ES',	'Barcelona',	'Barcelona'),
(140,	'ES',	'Burgos',	'Burgos'),
(141,	'ES',	'Caceres',	'Caceres'),
(142,	'ES',	'Cadiz',	'Cadiz'),
(143,	'ES',	'Cantabria',	'Cantabria'),
(144,	'ES',	'Castellon',	'Castellon'),
(145,	'ES',	'Ceuta',	'Ceuta'),
(146,	'ES',	'Ciudad Real',	'Ciudad Real'),
(147,	'ES',	'Cordoba',	'Cordoba'),
(148,	'ES',	'Cuenca',	'Cuenca'),
(149,	'ES',	'Girona',	'Girona'),
(150,	'ES',	'Granada',	'Granada'),
(151,	'ES',	'Guadalajara',	'Guadalajara'),
(152,	'ES',	'Guipuzcoa',	'Guipuzcoa'),
(153,	'ES',	'Huelva',	'Huelva'),
(154,	'ES',	'Huesca',	'Huesca'),
(155,	'ES',	'Jaen',	'Jaen'),
(156,	'ES',	'La Rioja',	'La Rioja'),
(157,	'ES',	'Las Palmas',	'Las Palmas'),
(158,	'ES',	'Leon',	'Leon'),
(159,	'ES',	'Lleida',	'Lleida'),
(160,	'ES',	'Lugo',	'Lugo'),
(161,	'ES',	'Madrid',	'Madrid'),
(162,	'ES',	'Malaga',	'Malaga'),
(163,	'ES',	'Melilla',	'Melilla'),
(164,	'ES',	'Murcia',	'Murcia'),
(165,	'ES',	'Navarra',	'Navarra'),
(166,	'ES',	'Ourense',	'Ourense'),
(167,	'ES',	'Palencia',	'Palencia'),
(168,	'ES',	'Pontevedra',	'Pontevedra'),
(169,	'ES',	'Salamanca',	'Salamanca'),
(170,	'ES',	'Santa Cruz de Tenerife',	'Santa Cruz de Tenerife'),
(171,	'ES',	'Segovia',	'Segovia'),
(172,	'ES',	'Sevilla',	'Sevilla'),
(173,	'ES',	'Soria',	'Soria'),
(174,	'ES',	'Tarragona',	'Tarragona'),
(175,	'ES',	'Teruel',	'Teruel'),
(176,	'ES',	'Toledo',	'Toledo'),
(177,	'ES',	'Valencia',	'Valencia'),
(178,	'ES',	'Valladolid',	'Valladolid'),
(179,	'ES',	'Vizcaya',	'Vizcaya'),
(180,	'ES',	'Zamora',	'Zamora'),
(181,	'ES',	'Zaragoza',	'Zaragoza'),
(182,	'FR',	'1',	'Ain'),
(183,	'FR',	'2',	'Aisne'),
(184,	'FR',	'3',	'Allier'),
(185,	'FR',	'4',	'Alpes-de-Haute-Provence'),
(186,	'FR',	'5',	'Hautes-Alpes'),
(187,	'FR',	'6',	'Alpes-Maritimes'),
(188,	'FR',	'7',	'Ardèche'),
(189,	'FR',	'8',	'Ardennes'),
(190,	'FR',	'9',	'Ariège'),
(191,	'FR',	'10',	'Aube'),
(192,	'FR',	'11',	'Aude'),
(193,	'FR',	'12',	'Aveyron'),
(194,	'FR',	'13',	'Bouches-du-Rhône'),
(195,	'FR',	'14',	'Calvados'),
(196,	'FR',	'15',	'Cantal'),
(197,	'FR',	'16',	'Charente'),
(198,	'FR',	'17',	'Charente-Maritime'),
(199,	'FR',	'18',	'Cher'),
(200,	'FR',	'19',	'Corrèze'),
(201,	'FR',	'2A',	'Corse-du-Sud'),
(202,	'FR',	'2B',	'Haute-Corse'),
(203,	'FR',	'21',	'Côte-d\'Or'),
(204,	'FR',	'22',	'Côtes-d\'Armor'),
(205,	'FR',	'23',	'Creuse'),
(206,	'FR',	'24',	'Dordogne'),
(207,	'FR',	'25',	'Doubs'),
(208,	'FR',	'26',	'Drôme'),
(209,	'FR',	'27',	'Eure'),
(210,	'FR',	'28',	'Eure-et-Loir'),
(211,	'FR',	'29',	'Finistère'),
(212,	'FR',	'30',	'Gard'),
(213,	'FR',	'31',	'Haute-Garonne'),
(214,	'FR',	'32',	'Gers'),
(215,	'FR',	'33',	'Gironde'),
(216,	'FR',	'34',	'Hérault'),
(217,	'FR',	'35',	'Ille-et-Vilaine'),
(218,	'FR',	'36',	'Indre'),
(219,	'FR',	'37',	'Indre-et-Loire'),
(220,	'FR',	'38',	'Isère'),
(221,	'FR',	'39',	'Jura'),
(222,	'FR',	'40',	'Landes'),
(223,	'FR',	'41',	'Loir-et-Cher'),
(224,	'FR',	'42',	'Loire'),
(225,	'FR',	'43',	'Haute-Loire'),
(226,	'FR',	'44',	'Loire-Atlantique'),
(227,	'FR',	'45',	'Loiret'),
(228,	'FR',	'46',	'Lot'),
(229,	'FR',	'47',	'Lot-et-Garonne'),
(230,	'FR',	'48',	'Lozère'),
(231,	'FR',	'49',	'Maine-et-Loire'),
(232,	'FR',	'50',	'Manche'),
(233,	'FR',	'51',	'Marne'),
(234,	'FR',	'52',	'Haute-Marne'),
(235,	'FR',	'53',	'Mayenne'),
(236,	'FR',	'54',	'Meurthe-et-Moselle'),
(237,	'FR',	'55',	'Meuse'),
(238,	'FR',	'56',	'Morbihan'),
(239,	'FR',	'57',	'Moselle'),
(240,	'FR',	'58',	'Nièvre'),
(241,	'FR',	'59',	'Nord'),
(242,	'FR',	'60',	'Oise'),
(243,	'FR',	'61',	'Orne'),
(244,	'FR',	'62',	'Pas-de-Calais'),
(245,	'FR',	'63',	'Puy-de-Dôme'),
(246,	'FR',	'64',	'Pyrénées-Atlantiques'),
(247,	'FR',	'65',	'Hautes-Pyrénées'),
(248,	'FR',	'66',	'Pyrénées-Orientales'),
(249,	'FR',	'67',	'Bas-Rhin'),
(250,	'FR',	'68',	'Haut-Rhin'),
(251,	'FR',	'69',	'Rhône'),
(252,	'FR',	'70',	'Haute-Saône'),
(253,	'FR',	'71',	'Saône-et-Loire'),
(254,	'FR',	'72',	'Sarthe'),
(255,	'FR',	'73',	'Savoie'),
(256,	'FR',	'74',	'Haute-Savoie'),
(257,	'FR',	'75',	'Paris'),
(258,	'FR',	'76',	'Seine-Maritime'),
(259,	'FR',	'77',	'Seine-et-Marne'),
(260,	'FR',	'78',	'Yvelines'),
(261,	'FR',	'79',	'Deux-Sèvres'),
(262,	'FR',	'80',	'Somme'),
(263,	'FR',	'81',	'Tarn'),
(264,	'FR',	'82',	'Tarn-et-Garonne'),
(265,	'FR',	'83',	'Var'),
(266,	'FR',	'84',	'Vaucluse'),
(267,	'FR',	'85',	'Vendée'),
(268,	'FR',	'86',	'Vienne'),
(269,	'FR',	'87',	'Haute-Vienne'),
(270,	'FR',	'88',	'Vosges'),
(271,	'FR',	'89',	'Yonne'),
(272,	'FR',	'90',	'Territoire-de-Belfort'),
(273,	'FR',	'91',	'Essonne'),
(274,	'FR',	'92',	'Hauts-de-Seine'),
(275,	'FR',	'93',	'Seine-Saint-Denis'),
(276,	'FR',	'94',	'Val-de-Marne'),
(277,	'FR',	'95',	'Val-d\'Oise'),
(278,	'RO',	'AB',	'Alba'),
(279,	'RO',	'AR',	'Arad'),
(280,	'RO',	'AG',	'Argeş'),
(281,	'RO',	'BC',	'Bacău'),
(282,	'RO',	'BH',	'Bihor'),
(283,	'RO',	'BN',	'Bistriţa-Năsăud'),
(284,	'RO',	'BT',	'Botoşani'),
(285,	'RO',	'BV',	'Braşov'),
(286,	'RO',	'BR',	'Brăila'),
(287,	'RO',	'B',	'Bucureşti'),
(288,	'RO',	'BZ',	'Buzău'),
(289,	'RO',	'CS',	'Caraş-Severin'),
(290,	'RO',	'CL',	'Călăraşi'),
(291,	'RO',	'CJ',	'Cluj'),
(292,	'RO',	'CT',	'Constanţa'),
(293,	'RO',	'CV',	'Covasna'),
(294,	'RO',	'DB',	'Dâmboviţa'),
(295,	'RO',	'DJ',	'Dolj'),
(296,	'RO',	'GL',	'Galaţi'),
(297,	'RO',	'GR',	'Giurgiu'),
(298,	'RO',	'GJ',	'Gorj'),
(299,	'RO',	'HR',	'Harghita'),
(300,	'RO',	'HD',	'Hunedoara'),
(301,	'RO',	'IL',	'Ialomiţa'),
(302,	'RO',	'IS',	'Iaşi'),
(303,	'RO',	'IF',	'Ilfov'),
(304,	'RO',	'MM',	'Maramureş'),
(305,	'RO',	'MH',	'Mehedinţi'),
(306,	'RO',	'MS',	'Mureş'),
(307,	'RO',	'NT',	'Neamţ'),
(308,	'RO',	'OT',	'Olt'),
(309,	'RO',	'PH',	'Prahova'),
(310,	'RO',	'SM',	'Satu-Mare'),
(311,	'RO',	'SJ',	'Sălaj'),
(312,	'RO',	'SB',	'Sibiu'),
(313,	'RO',	'SV',	'Suceava'),
(314,	'RO',	'TR',	'Teleorman'),
(315,	'RO',	'TM',	'Timiş'),
(316,	'RO',	'TL',	'Tulcea'),
(317,	'RO',	'VS',	'Vaslui'),
(318,	'RO',	'VL',	'Vâlcea'),
(319,	'RO',	'VN',	'Vrancea'),
(320,	'FI',	'Lappi',	'Lappi'),
(321,	'FI',	'Pohjois-Pohjanmaa',	'Pohjois-Pohjanmaa'),
(322,	'FI',	'Kainuu',	'Kainuu'),
(323,	'FI',	'Pohjois-Karjala',	'Pohjois-Karjala'),
(324,	'FI',	'Pohjois-Savo',	'Pohjois-Savo'),
(325,	'FI',	'Etelä-Savo',	'Etelä-Savo'),
(326,	'FI',	'Etelä-Pohjanmaa',	'Etelä-Pohjanmaa'),
(327,	'FI',	'Pohjanmaa',	'Pohjanmaa'),
(328,	'FI',	'Pirkanmaa',	'Pirkanmaa'),
(329,	'FI',	'Satakunta',	'Satakunta'),
(330,	'FI',	'Keski-Pohjanmaa',	'Keski-Pohjanmaa'),
(331,	'FI',	'Keski-Suomi',	'Keski-Suomi'),
(332,	'FI',	'Varsinais-Suomi',	'Varsinais-Suomi'),
(333,	'FI',	'Etelä-Karjala',	'Etelä-Karjala'),
(334,	'FI',	'Päijät-Häme',	'Päijät-Häme'),
(335,	'FI',	'Kanta-Häme',	'Kanta-Häme'),
(336,	'FI',	'Uusimaa',	'Uusimaa'),
(337,	'FI',	'Itä-Uusimaa',	'Itä-Uusimaa'),
(338,	'FI',	'Kymenlaakso',	'Kymenlaakso'),
(339,	'FI',	'Ahvenanmaa',	'Ahvenanmaa'),
(340,	'EE',	'EE-37',	'Harjumaa'),
(341,	'EE',	'EE-39',	'Hiiumaa'),
(342,	'EE',	'EE-44',	'Ida-Virumaa'),
(343,	'EE',	'EE-49',	'Jõgevamaa'),
(344,	'EE',	'EE-51',	'Järvamaa'),
(345,	'EE',	'EE-57',	'Läänemaa'),
(346,	'EE',	'EE-59',	'Lääne-Virumaa'),
(347,	'EE',	'EE-65',	'Põlvamaa'),
(348,	'EE',	'EE-67',	'Pärnumaa'),
(349,	'EE',	'EE-70',	'Raplamaa'),
(350,	'EE',	'EE-74',	'Saaremaa'),
(351,	'EE',	'EE-78',	'Tartumaa'),
(352,	'EE',	'EE-82',	'Valgamaa'),
(353,	'EE',	'EE-84',	'Viljandimaa'),
(354,	'EE',	'EE-86',	'Võrumaa'),
(355,	'LV',	'LV-DGV',	'Daugavpils'),
(356,	'LV',	'LV-JEL',	'Jelgava'),
(357,	'LV',	'Jēkabpils',	'Jēkabpils'),
(358,	'LV',	'LV-JUR',	'Jūrmala'),
(359,	'LV',	'LV-LPX',	'Liepāja'),
(360,	'LV',	'LV-LE',	'Liepājas novads'),
(361,	'LV',	'LV-REZ',	'Rēzekne'),
(362,	'LV',	'LV-RIX',	'Rīga'),
(363,	'LV',	'LV-RI',	'Rīgas novads'),
(364,	'LV',	'Valmiera',	'Valmiera'),
(365,	'LV',	'LV-VEN',	'Ventspils'),
(366,	'LV',	'Aglonas novads',	'Aglonas novads'),
(367,	'LV',	'LV-AI',	'Aizkraukles novads'),
(368,	'LV',	'Aizputes novads',	'Aizputes novads'),
(369,	'LV',	'Aknīstes novads',	'Aknīstes novads'),
(370,	'LV',	'Alojas novads',	'Alojas novads'),
(371,	'LV',	'Alsungas novads',	'Alsungas novads'),
(372,	'LV',	'LV-AL',	'Alūksnes novads'),
(373,	'LV',	'Amatas novads',	'Amatas novads'),
(374,	'LV',	'Apes novads',	'Apes novads'),
(375,	'LV',	'Auces novads',	'Auces novads'),
(376,	'LV',	'Babītes novads',	'Babītes novads'),
(377,	'LV',	'Baldones novads',	'Baldones novads'),
(378,	'LV',	'Baltinavas novads',	'Baltinavas novads'),
(379,	'LV',	'LV-BL',	'Balvu novads'),
(380,	'LV',	'LV-BU',	'Bauskas novads'),
(381,	'LV',	'Beverīnas novads',	'Beverīnas novads'),
(382,	'LV',	'Brocēnu novads',	'Brocēnu novads'),
(383,	'LV',	'Burtnieku novads',	'Burtnieku novads'),
(384,	'LV',	'Carnikavas novads',	'Carnikavas novads'),
(385,	'LV',	'Cesvaines novads',	'Cesvaines novads'),
(386,	'LV',	'Ciblas novads',	'Ciblas novads'),
(387,	'LV',	'LV-CE',	'Cēsu novads'),
(388,	'LV',	'Dagdas novads',	'Dagdas novads'),
(389,	'LV',	'LV-DA',	'Daugavpils novads'),
(390,	'LV',	'LV-DO',	'Dobeles novads'),
(391,	'LV',	'Dundagas novads',	'Dundagas novads'),
(392,	'LV',	'Durbes novads',	'Durbes novads'),
(393,	'LV',	'Engures novads',	'Engures novads'),
(394,	'LV',	'Garkalnes novads',	'Garkalnes novads'),
(395,	'LV',	'Grobiņas novads',	'Grobiņas novads'),
(396,	'LV',	'LV-GU',	'Gulbenes novads'),
(397,	'LV',	'Iecavas novads',	'Iecavas novads'),
(398,	'LV',	'Ikšķiles novads',	'Ikšķiles novads'),
(399,	'LV',	'Ilūkstes novads',	'Ilūkstes novads'),
(400,	'LV',	'Inčukalna novads',	'Inčukalna novads'),
(401,	'LV',	'Jaunjelgavas novads',	'Jaunjelgavas novads'),
(402,	'LV',	'Jaunpiebalgas novads',	'Jaunpiebalgas novads'),
(403,	'LV',	'Jaunpils novads',	'Jaunpils novads'),
(404,	'LV',	'LV-JL',	'Jelgavas novads'),
(405,	'LV',	'LV-JK',	'Jēkabpils novads'),
(406,	'LV',	'Kandavas novads',	'Kandavas novads'),
(407,	'LV',	'Kokneses novads',	'Kokneses novads'),
(408,	'LV',	'Krimuldas novads',	'Krimuldas novads'),
(409,	'LV',	'Krustpils novads',	'Krustpils novads'),
(410,	'LV',	'LV-KR',	'Krāslavas novads'),
(411,	'LV',	'LV-KU',	'Kuldīgas novads'),
(412,	'LV',	'Kārsavas novads',	'Kārsavas novads'),
(413,	'LV',	'Lielvārdes novads',	'Lielvārdes novads'),
(414,	'LV',	'LV-LM',	'Limbažu novads'),
(415,	'LV',	'Lubānas novads',	'Lubānas novads'),
(416,	'LV',	'LV-LU',	'Ludzas novads'),
(417,	'LV',	'Līgatnes novads',	'Līgatnes novads'),
(418,	'LV',	'Līvānu novads',	'Līvānu novads'),
(419,	'LV',	'LV-MA',	'Madonas novads'),
(420,	'LV',	'Mazsalacas novads',	'Mazsalacas novads'),
(421,	'LV',	'Mālpils novads',	'Mālpils novads'),
(422,	'LV',	'Mārupes novads',	'Mārupes novads'),
(423,	'LV',	'Naukšēnu novads',	'Naukšēnu novads'),
(424,	'LV',	'Neretas novads',	'Neretas novads'),
(425,	'LV',	'Nīcas novads',	'Nīcas novads'),
(426,	'LV',	'LV-OG',	'Ogres novads'),
(427,	'LV',	'Olaines novads',	'Olaines novads'),
(428,	'LV',	'Ozolnieku novads',	'Ozolnieku novads'),
(429,	'LV',	'LV-PR',	'Preiļu novads'),
(430,	'LV',	'Priekules novads',	'Priekules novads'),
(431,	'LV',	'Priekuļu novads',	'Priekuļu novads'),
(432,	'LV',	'Pārgaujas novads',	'Pārgaujas novads'),
(433,	'LV',	'Pāvilostas novads',	'Pāvilostas novads'),
(434,	'LV',	'Pļaviņu novads',	'Pļaviņu novads'),
(435,	'LV',	'Raunas novads',	'Raunas novads'),
(436,	'LV',	'Riebiņu novads',	'Riebiņu novads'),
(437,	'LV',	'Rojas novads',	'Rojas novads'),
(438,	'LV',	'Ropažu novads',	'Ropažu novads'),
(439,	'LV',	'Rucavas novads',	'Rucavas novads'),
(440,	'LV',	'Rugāju novads',	'Rugāju novads'),
(441,	'LV',	'Rundāles novads',	'Rundāles novads'),
(442,	'LV',	'LV-RE',	'Rēzeknes novads'),
(443,	'LV',	'Rūjienas novads',	'Rūjienas novads'),
(444,	'LV',	'Salacgrīvas novads',	'Salacgrīvas novads'),
(445,	'LV',	'Salas novads',	'Salas novads'),
(446,	'LV',	'Salaspils novads',	'Salaspils novads'),
(447,	'LV',	'LV-SA',	'Saldus novads'),
(448,	'LV',	'Saulkrastu novads',	'Saulkrastu novads'),
(449,	'LV',	'Siguldas novads',	'Siguldas novads'),
(450,	'LV',	'Skrundas novads',	'Skrundas novads'),
(451,	'LV',	'Skrīveru novads',	'Skrīveru novads'),
(452,	'LV',	'Smiltenes novads',	'Smiltenes novads'),
(453,	'LV',	'Stopiņu novads',	'Stopiņu novads'),
(454,	'LV',	'Strenču novads',	'Strenču novads'),
(455,	'LV',	'Sējas novads',	'Sējas novads'),
(456,	'LV',	'LV-TA',	'Talsu novads'),
(457,	'LV',	'LV-TU',	'Tukuma novads'),
(458,	'LV',	'Tērvetes novads',	'Tērvetes novads'),
(459,	'LV',	'Vaiņodes novads',	'Vaiņodes novads'),
(460,	'LV',	'LV-VK',	'Valkas novads'),
(461,	'LV',	'LV-VM',	'Valmieras novads'),
(462,	'LV',	'Varakļānu novads',	'Varakļānu novads'),
(463,	'LV',	'Vecpiebalgas novads',	'Vecpiebalgas novads'),
(464,	'LV',	'Vecumnieku novads',	'Vecumnieku novads'),
(465,	'LV',	'LV-VE',	'Ventspils novads'),
(466,	'LV',	'Viesītes novads',	'Viesītes novads'),
(467,	'LV',	'Viļakas novads',	'Viļakas novads'),
(468,	'LV',	'Viļānu novads',	'Viļānu novads'),
(469,	'LV',	'Vārkavas novads',	'Vārkavas novads'),
(470,	'LV',	'Zilupes novads',	'Zilupes novads'),
(471,	'LV',	'Ādažu novads',	'Ādažu novads'),
(472,	'LV',	'Ērgļu novads',	'Ērgļu novads'),
(473,	'LV',	'Ķeguma novads',	'Ķeguma novads'),
(474,	'LV',	'Ķekavas novads',	'Ķekavas novads'),
(475,	'LT',	'LT-AL',	'Alytaus Apskritis'),
(476,	'LT',	'LT-KU',	'Kauno Apskritis'),
(477,	'LT',	'LT-KL',	'Klaipėdos Apskritis'),
(478,	'LT',	'LT-MR',	'Marijampolės Apskritis'),
(479,	'LT',	'LT-PN',	'Panevėžio Apskritis'),
(480,	'LT',	'LT-SA',	'Šiaulių Apskritis'),
(481,	'LT',	'LT-TA',	'Tauragės Apskritis'),
(482,	'LT',	'LT-TE',	'Telšių Apskritis'),
(483,	'LT',	'LT-UT',	'Utenos Apskritis'),
(484,	'LT',	'LT-VL',	'Vilniaus Apskritis'),
(485,	'BR',	'AC',	'Acre'),
(486,	'BR',	'AL',	'Alagoas'),
(487,	'BR',	'AP',	'Amapá'),
(488,	'BR',	'AM',	'Amazonas'),
(489,	'BR',	'BA',	'Bahia'),
(490,	'BR',	'CE',	'Ceará'),
(491,	'BR',	'ES',	'Espírito Santo'),
(492,	'BR',	'GO',	'Goiás'),
(493,	'BR',	'MA',	'Maranhão'),
(494,	'BR',	'MT',	'Mato Grosso'),
(495,	'BR',	'MS',	'Mato Grosso do Sul'),
(496,	'BR',	'MG',	'Minas Gerais'),
(497,	'BR',	'PA',	'Pará'),
(498,	'BR',	'PB',	'Paraíba'),
(499,	'BR',	'PR',	'Paraná'),
(500,	'BR',	'PE',	'Pernambuco'),
(501,	'BR',	'PI',	'Piauí'),
(502,	'BR',	'RJ',	'Rio de Janeiro'),
(503,	'BR',	'RN',	'Rio Grande do Norte'),
(504,	'BR',	'RS',	'Rio Grande do Sul'),
(505,	'BR',	'RO',	'Rondônia'),
(506,	'BR',	'RR',	'Roraima'),
(507,	'BR',	'SC',	'Santa Catarina'),
(508,	'BR',	'SP',	'São Paulo'),
(509,	'BR',	'SE',	'Sergipe'),
(510,	'BR',	'TO',	'Tocantins'),
(511,	'BR',	'DF',	'Distrito Federal'),
(512,	'HR',	'HR-01',	'Zagrebačka županija'),
(513,	'HR',	'HR-02',	'Krapinsko-zagorska županija'),
(514,	'HR',	'HR-03',	'Sisačko-moslavačka županija'),
(515,	'HR',	'HR-04',	'Karlovačka županija'),
(516,	'HR',	'HR-05',	'Varaždinska županija'),
(517,	'HR',	'HR-06',	'Koprivničko-križevačka županija'),
(518,	'HR',	'HR-07',	'Bjelovarsko-bilogorska županija'),
(519,	'HR',	'HR-08',	'Primorsko-goranska županija'),
(520,	'HR',	'HR-09',	'Ličko-senjska županija'),
(521,	'HR',	'HR-10',	'Virovitičko-podravska županija'),
(522,	'HR',	'HR-11',	'Požeško-slavonska županija'),
(523,	'HR',	'HR-12',	'Brodsko-posavska županija'),
(524,	'HR',	'HR-13',	'Zadarska županija'),
(525,	'HR',	'HR-14',	'Osječko-baranjska županija'),
(526,	'HR',	'HR-15',	'Šibensko-kninska županija'),
(527,	'HR',	'HR-16',	'Vukovarsko-srijemska županija'),
(528,	'HR',	'HR-17',	'Splitsko-dalmatinska županija'),
(529,	'HR',	'HR-18',	'Istarska županija'),
(530,	'HR',	'HR-19',	'Dubrovačko-neretvanska županija'),
(531,	'HR',	'HR-20',	'Međimurska županija'),
(532,	'HR',	'HR-21',	'Grad Zagreb'),
(533,	'IN',	'AN',	'Andaman and Nicobar Islands'),
(534,	'IN',	'AP',	'Andhra Pradesh'),
(535,	'IN',	'AR',	'Arunachal Pradesh'),
(536,	'IN',	'AS',	'Assam'),
(537,	'IN',	'BR',	'Bihar'),
(538,	'IN',	'CH',	'Chandigarh'),
(539,	'IN',	'CT',	'Chhattisgarh'),
(540,	'IN',	'DN',	'Dadra and Nagar Haveli'),
(541,	'IN',	'DD',	'Daman and Diu'),
(542,	'IN',	'DL',	'Delhi'),
(543,	'IN',	'GA',	'Goa'),
(544,	'IN',	'GJ',	'Gujarat'),
(545,	'IN',	'HR',	'Haryana'),
(546,	'IN',	'HP',	'Himachal Pradesh'),
(547,	'IN',	'JK',	'Jammu and Kashmir'),
(548,	'IN',	'JH',	'Jharkhand'),
(549,	'IN',	'KA',	'Karnataka'),
(550,	'IN',	'KL',	'Kerala'),
(551,	'IN',	'LD',	'Lakshadweep'),
(552,	'IN',	'MP',	'Madhya Pradesh'),
(553,	'IN',	'MH',	'Maharashtra'),
(554,	'IN',	'MN',	'Manipur'),
(555,	'IN',	'ML',	'Meghalaya'),
(556,	'IN',	'MZ',	'Mizoram'),
(557,	'IN',	'NL',	'Nagaland'),
(558,	'IN',	'OR',	'Odisha'),
(559,	'IN',	'PY',	'Puducherry'),
(560,	'IN',	'PB',	'Punjab'),
(561,	'IN',	'RJ',	'Rajasthan'),
(562,	'IN',	'SK',	'Sikkim'),
(563,	'IN',	'TN',	'Tamil Nadu'),
(564,	'IN',	'TG',	'Telangana'),
(565,	'IN',	'TR',	'Tripura'),
(566,	'IN',	'UP',	'Uttar Pradesh'),
(567,	'IN',	'UT',	'Uttarakhand'),
(568,	'IN',	'WB',	'West Bengal');

DROP TABLE IF EXISTS `directory_country_region_name`;
CREATE TABLE `directory_country_region_name` (
  `locale` varchar(8) NOT NULL COMMENT 'Locale',
  `region_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Region Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Region Name',
  PRIMARY KEY (`locale`,`region_id`),
  KEY `DIRECTORY_COUNTRY_REGION_NAME_REGION_ID` (`region_id`),
  CONSTRAINT `DIR_COUNTRY_REGION_NAME_REGION_ID_DIR_COUNTRY_REGION_REGION_ID` FOREIGN KEY (`region_id`) REFERENCES `directory_country_region` (`region_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Directory Country Region Name';

INSERT INTO `directory_country_region_name` (`locale`, `region_id`, `name`) VALUES
('en_US',	1,	'Alabama'),
('en_US',	2,	'Alaska'),
('en_US',	3,	'American Samoa'),
('en_US',	4,	'Arizona'),
('en_US',	5,	'Arkansas'),
('en_US',	6,	'Armed Forces Africa'),
('en_US',	7,	'Armed Forces Americas'),
('en_US',	8,	'Armed Forces Canada'),
('en_US',	9,	'Armed Forces Europe'),
('en_US',	10,	'Armed Forces Middle East'),
('en_US',	11,	'Armed Forces Pacific'),
('en_US',	12,	'California'),
('en_US',	13,	'Colorado'),
('en_US',	14,	'Connecticut'),
('en_US',	15,	'Delaware'),
('en_US',	16,	'District of Columbia'),
('en_US',	17,	'Federated States Of Micronesia'),
('en_US',	18,	'Florida'),
('en_US',	19,	'Georgia'),
('en_US',	20,	'Guam'),
('en_US',	21,	'Hawaii'),
('en_US',	22,	'Idaho'),
('en_US',	23,	'Illinois'),
('en_US',	24,	'Indiana'),
('en_US',	25,	'Iowa'),
('en_US',	26,	'Kansas'),
('en_US',	27,	'Kentucky'),
('en_US',	28,	'Louisiana'),
('en_US',	29,	'Maine'),
('en_US',	30,	'Marshall Islands'),
('en_US',	31,	'Maryland'),
('en_US',	32,	'Massachusetts'),
('en_US',	33,	'Michigan'),
('en_US',	34,	'Minnesota'),
('en_US',	35,	'Mississippi'),
('en_US',	36,	'Missouri'),
('en_US',	37,	'Montana'),
('en_US',	38,	'Nebraska'),
('en_US',	39,	'Nevada'),
('en_US',	40,	'New Hampshire'),
('en_US',	41,	'New Jersey'),
('en_US',	42,	'New Mexico'),
('en_US',	43,	'New York'),
('en_US',	44,	'North Carolina'),
('en_US',	45,	'North Dakota'),
('en_US',	46,	'Northern Mariana Islands'),
('en_US',	47,	'Ohio'),
('en_US',	48,	'Oklahoma'),
('en_US',	49,	'Oregon'),
('en_US',	50,	'Palau'),
('en_US',	51,	'Pennsylvania'),
('en_US',	52,	'Puerto Rico'),
('en_US',	53,	'Rhode Island'),
('en_US',	54,	'South Carolina'),
('en_US',	55,	'South Dakota'),
('en_US',	56,	'Tennessee'),
('en_US',	57,	'Texas'),
('en_US',	58,	'Utah'),
('en_US',	59,	'Vermont'),
('en_US',	60,	'Virgin Islands'),
('en_US',	61,	'Virginia'),
('en_US',	62,	'Washington'),
('en_US',	63,	'West Virginia'),
('en_US',	64,	'Wisconsin'),
('en_US',	65,	'Wyoming'),
('en_US',	66,	'Alberta'),
('en_US',	67,	'British Columbia'),
('en_US',	68,	'Manitoba'),
('en_US',	69,	'Newfoundland and Labrador'),
('en_US',	70,	'New Brunswick'),
('en_US',	71,	'Nova Scotia'),
('en_US',	72,	'Northwest Territories'),
('en_US',	73,	'Nunavut'),
('en_US',	74,	'Ontario'),
('en_US',	75,	'Prince Edward Island'),
('en_US',	76,	'Quebec'),
('en_US',	77,	'Saskatchewan'),
('en_US',	78,	'Yukon Territory'),
('en_US',	79,	'Niedersachsen'),
('en_US',	80,	'Baden-Württemberg'),
('en_US',	81,	'Bayern'),
('en_US',	82,	'Berlin'),
('en_US',	83,	'Brandenburg'),
('en_US',	84,	'Bremen'),
('en_US',	85,	'Hamburg'),
('en_US',	86,	'Hessen'),
('en_US',	87,	'Mecklenburg-Vorpommern'),
('en_US',	88,	'Nordrhein-Westfalen'),
('en_US',	89,	'Rheinland-Pfalz'),
('en_US',	90,	'Saarland'),
('en_US',	91,	'Sachsen'),
('en_US',	92,	'Sachsen-Anhalt'),
('en_US',	93,	'Schleswig-Holstein'),
('en_US',	94,	'Thüringen'),
('en_US',	95,	'Wien'),
('en_US',	96,	'Niederösterreich'),
('en_US',	97,	'Oberösterreich'),
('en_US',	98,	'Salzburg'),
('en_US',	99,	'Kärnten'),
('en_US',	100,	'Steiermark'),
('en_US',	101,	'Tirol'),
('en_US',	102,	'Burgenland'),
('en_US',	103,	'Vorarlberg'),
('en_US',	104,	'Aargau'),
('en_US',	105,	'Appenzell Innerrhoden'),
('en_US',	106,	'Appenzell Ausserrhoden'),
('en_US',	107,	'Bern'),
('en_US',	108,	'Basel-Landschaft'),
('en_US',	109,	'Basel-Stadt'),
('en_US',	110,	'Freiburg'),
('en_US',	111,	'Genf'),
('en_US',	112,	'Glarus'),
('en_US',	113,	'Graubünden'),
('en_US',	114,	'Jura'),
('en_US',	115,	'Luzern'),
('en_US',	116,	'Neuenburg'),
('en_US',	117,	'Nidwalden'),
('en_US',	118,	'Obwalden'),
('en_US',	119,	'St. Gallen'),
('en_US',	120,	'Schaffhausen'),
('en_US',	121,	'Solothurn'),
('en_US',	122,	'Schwyz'),
('en_US',	123,	'Thurgau'),
('en_US',	124,	'Tessin'),
('en_US',	125,	'Uri'),
('en_US',	126,	'Waadt'),
('en_US',	127,	'Wallis'),
('en_US',	128,	'Zug'),
('en_US',	129,	'Zürich'),
('en_US',	130,	'A Coruña'),
('en_US',	131,	'Alava'),
('en_US',	132,	'Albacete'),
('en_US',	133,	'Alicante'),
('en_US',	134,	'Almeria'),
('en_US',	135,	'Asturias'),
('en_US',	136,	'Avila'),
('en_US',	137,	'Badajoz'),
('en_US',	138,	'Baleares'),
('en_US',	139,	'Barcelona'),
('en_US',	140,	'Burgos'),
('en_US',	141,	'Caceres'),
('en_US',	142,	'Cadiz'),
('en_US',	143,	'Cantabria'),
('en_US',	144,	'Castellon'),
('en_US',	145,	'Ceuta'),
('en_US',	146,	'Ciudad Real'),
('en_US',	147,	'Cordoba'),
('en_US',	148,	'Cuenca'),
('en_US',	149,	'Girona'),
('en_US',	150,	'Granada'),
('en_US',	151,	'Guadalajara'),
('en_US',	152,	'Guipuzcoa'),
('en_US',	153,	'Huelva'),
('en_US',	154,	'Huesca'),
('en_US',	155,	'Jaen'),
('en_US',	156,	'La Rioja'),
('en_US',	157,	'Las Palmas'),
('en_US',	158,	'Leon'),
('en_US',	159,	'Lleida'),
('en_US',	160,	'Lugo'),
('en_US',	161,	'Madrid'),
('en_US',	162,	'Malaga'),
('en_US',	163,	'Melilla'),
('en_US',	164,	'Murcia'),
('en_US',	165,	'Navarra'),
('en_US',	166,	'Ourense'),
('en_US',	167,	'Palencia'),
('en_US',	168,	'Pontevedra'),
('en_US',	169,	'Salamanca'),
('en_US',	170,	'Santa Cruz de Tenerife'),
('en_US',	171,	'Segovia'),
('en_US',	172,	'Sevilla'),
('en_US',	173,	'Soria'),
('en_US',	174,	'Tarragona'),
('en_US',	175,	'Teruel'),
('en_US',	176,	'Toledo'),
('en_US',	177,	'Valencia'),
('en_US',	178,	'Valladolid'),
('en_US',	179,	'Vizcaya'),
('en_US',	180,	'Zamora'),
('en_US',	181,	'Zaragoza'),
('en_US',	182,	'Ain'),
('en_US',	183,	'Aisne'),
('en_US',	184,	'Allier'),
('en_US',	185,	'Alpes-de-Haute-Provence'),
('en_US',	186,	'Hautes-Alpes'),
('en_US',	187,	'Alpes-Maritimes'),
('en_US',	188,	'Ardèche'),
('en_US',	189,	'Ardennes'),
('en_US',	190,	'Ariège'),
('en_US',	191,	'Aube'),
('en_US',	192,	'Aude'),
('en_US',	193,	'Aveyron'),
('en_US',	194,	'Bouches-du-Rhône'),
('en_US',	195,	'Calvados'),
('en_US',	196,	'Cantal'),
('en_US',	197,	'Charente'),
('en_US',	198,	'Charente-Maritime'),
('en_US',	199,	'Cher'),
('en_US',	200,	'Corrèze'),
('en_US',	201,	'Corse-du-Sud'),
('en_US',	202,	'Haute-Corse'),
('en_US',	203,	'Côte-d\'Or'),
('en_US',	204,	'Côtes-d\'Armor'),
('en_US',	205,	'Creuse'),
('en_US',	206,	'Dordogne'),
('en_US',	207,	'Doubs'),
('en_US',	208,	'Drôme'),
('en_US',	209,	'Eure'),
('en_US',	210,	'Eure-et-Loir'),
('en_US',	211,	'Finistère'),
('en_US',	212,	'Gard'),
('en_US',	213,	'Haute-Garonne'),
('en_US',	214,	'Gers'),
('en_US',	215,	'Gironde'),
('en_US',	216,	'Hérault'),
('en_US',	217,	'Ille-et-Vilaine'),
('en_US',	218,	'Indre'),
('en_US',	219,	'Indre-et-Loire'),
('en_US',	220,	'Isère'),
('en_US',	221,	'Jura'),
('en_US',	222,	'Landes'),
('en_US',	223,	'Loir-et-Cher'),
('en_US',	224,	'Loire'),
('en_US',	225,	'Haute-Loire'),
('en_US',	226,	'Loire-Atlantique'),
('en_US',	227,	'Loiret'),
('en_US',	228,	'Lot'),
('en_US',	229,	'Lot-et-Garonne'),
('en_US',	230,	'Lozère'),
('en_US',	231,	'Maine-et-Loire'),
('en_US',	232,	'Manche'),
('en_US',	233,	'Marne'),
('en_US',	234,	'Haute-Marne'),
('en_US',	235,	'Mayenne'),
('en_US',	236,	'Meurthe-et-Moselle'),
('en_US',	237,	'Meuse'),
('en_US',	238,	'Morbihan'),
('en_US',	239,	'Moselle'),
('en_US',	240,	'Nièvre'),
('en_US',	241,	'Nord'),
('en_US',	242,	'Oise'),
('en_US',	243,	'Orne'),
('en_US',	244,	'Pas-de-Calais'),
('en_US',	245,	'Puy-de-Dôme'),
('en_US',	246,	'Pyrénées-Atlantiques'),
('en_US',	247,	'Hautes-Pyrénées'),
('en_US',	248,	'Pyrénées-Orientales'),
('en_US',	249,	'Bas-Rhin'),
('en_US',	250,	'Haut-Rhin'),
('en_US',	251,	'Rhône'),
('en_US',	252,	'Haute-Saône'),
('en_US',	253,	'Saône-et-Loire'),
('en_US',	254,	'Sarthe'),
('en_US',	255,	'Savoie'),
('en_US',	256,	'Haute-Savoie'),
('en_US',	257,	'Paris'),
('en_US',	258,	'Seine-Maritime'),
('en_US',	259,	'Seine-et-Marne'),
('en_US',	260,	'Yvelines'),
('en_US',	261,	'Deux-Sèvres'),
('en_US',	262,	'Somme'),
('en_US',	263,	'Tarn'),
('en_US',	264,	'Tarn-et-Garonne'),
('en_US',	265,	'Var'),
('en_US',	266,	'Vaucluse'),
('en_US',	267,	'Vendée'),
('en_US',	268,	'Vienne'),
('en_US',	269,	'Haute-Vienne'),
('en_US',	270,	'Vosges'),
('en_US',	271,	'Yonne'),
('en_US',	272,	'Territoire-de-Belfort'),
('en_US',	273,	'Essonne'),
('en_US',	274,	'Hauts-de-Seine'),
('en_US',	275,	'Seine-Saint-Denis'),
('en_US',	276,	'Val-de-Marne'),
('en_US',	277,	'Val-d\'Oise'),
('en_US',	278,	'Alba'),
('en_US',	279,	'Arad'),
('en_US',	280,	'Argeş'),
('en_US',	281,	'Bacău'),
('en_US',	282,	'Bihor'),
('en_US',	283,	'Bistriţa-Năsăud'),
('en_US',	284,	'Botoşani'),
('en_US',	285,	'Braşov'),
('en_US',	286,	'Brăila'),
('en_US',	287,	'Bucureşti'),
('en_US',	288,	'Buzău'),
('en_US',	289,	'Caraş-Severin'),
('en_US',	290,	'Călăraşi'),
('en_US',	291,	'Cluj'),
('en_US',	292,	'Constanţa'),
('en_US',	293,	'Covasna'),
('en_US',	294,	'Dâmboviţa'),
('en_US',	295,	'Dolj'),
('en_US',	296,	'Galaţi'),
('en_US',	297,	'Giurgiu'),
('en_US',	298,	'Gorj'),
('en_US',	299,	'Harghita'),
('en_US',	300,	'Hunedoara'),
('en_US',	301,	'Ialomiţa'),
('en_US',	302,	'Iaşi'),
('en_US',	303,	'Ilfov'),
('en_US',	304,	'Maramureş'),
('en_US',	305,	'Mehedinţi'),
('en_US',	306,	'Mureş'),
('en_US',	307,	'Neamţ'),
('en_US',	308,	'Olt'),
('en_US',	309,	'Prahova'),
('en_US',	310,	'Satu-Mare'),
('en_US',	311,	'Sălaj'),
('en_US',	312,	'Sibiu'),
('en_US',	313,	'Suceava'),
('en_US',	314,	'Teleorman'),
('en_US',	315,	'Timiş'),
('en_US',	316,	'Tulcea'),
('en_US',	317,	'Vaslui'),
('en_US',	318,	'Vâlcea'),
('en_US',	319,	'Vrancea'),
('en_US',	320,	'Lappi'),
('en_US',	321,	'Pohjois-Pohjanmaa'),
('en_US',	322,	'Kainuu'),
('en_US',	323,	'Pohjois-Karjala'),
('en_US',	324,	'Pohjois-Savo'),
('en_US',	325,	'Etelä-Savo'),
('en_US',	326,	'Etelä-Pohjanmaa'),
('en_US',	327,	'Pohjanmaa'),
('en_US',	328,	'Pirkanmaa'),
('en_US',	329,	'Satakunta'),
('en_US',	330,	'Keski-Pohjanmaa'),
('en_US',	331,	'Keski-Suomi'),
('en_US',	332,	'Varsinais-Suomi'),
('en_US',	333,	'Etelä-Karjala'),
('en_US',	334,	'Päijät-Häme'),
('en_US',	335,	'Kanta-Häme'),
('en_US',	336,	'Uusimaa'),
('en_US',	337,	'Itä-Uusimaa'),
('en_US',	338,	'Kymenlaakso'),
('en_US',	339,	'Ahvenanmaa'),
('en_US',	340,	'Harjumaa'),
('en_US',	341,	'Hiiumaa'),
('en_US',	342,	'Ida-Virumaa'),
('en_US',	343,	'Jõgevamaa'),
('en_US',	344,	'Järvamaa'),
('en_US',	345,	'Läänemaa'),
('en_US',	346,	'Lääne-Virumaa'),
('en_US',	347,	'Põlvamaa'),
('en_US',	348,	'Pärnumaa'),
('en_US',	349,	'Raplamaa'),
('en_US',	350,	'Saaremaa'),
('en_US',	351,	'Tartumaa'),
('en_US',	352,	'Valgamaa'),
('en_US',	353,	'Viljandimaa'),
('en_US',	354,	'Võrumaa'),
('en_US',	355,	'Daugavpils'),
('en_US',	356,	'Jelgava'),
('en_US',	357,	'Jēkabpils'),
('en_US',	358,	'Jūrmala'),
('en_US',	359,	'Liepāja'),
('en_US',	360,	'Liepājas novads'),
('en_US',	361,	'Rēzekne'),
('en_US',	362,	'Rīga'),
('en_US',	363,	'Rīgas novads'),
('en_US',	364,	'Valmiera'),
('en_US',	365,	'Ventspils'),
('en_US',	366,	'Aglonas novads'),
('en_US',	367,	'Aizkraukles novads'),
('en_US',	368,	'Aizputes novads'),
('en_US',	369,	'Aknīstes novads'),
('en_US',	370,	'Alojas novads'),
('en_US',	371,	'Alsungas novads'),
('en_US',	372,	'Alūksnes novads'),
('en_US',	373,	'Amatas novads'),
('en_US',	374,	'Apes novads'),
('en_US',	375,	'Auces novads'),
('en_US',	376,	'Babītes novads'),
('en_US',	377,	'Baldones novads'),
('en_US',	378,	'Baltinavas novads'),
('en_US',	379,	'Balvu novads'),
('en_US',	380,	'Bauskas novads'),
('en_US',	381,	'Beverīnas novads'),
('en_US',	382,	'Brocēnu novads'),
('en_US',	383,	'Burtnieku novads'),
('en_US',	384,	'Carnikavas novads'),
('en_US',	385,	'Cesvaines novads'),
('en_US',	386,	'Ciblas novads'),
('en_US',	387,	'Cēsu novads'),
('en_US',	388,	'Dagdas novads'),
('en_US',	389,	'Daugavpils novads'),
('en_US',	390,	'Dobeles novads'),
('en_US',	391,	'Dundagas novads'),
('en_US',	392,	'Durbes novads'),
('en_US',	393,	'Engures novads'),
('en_US',	394,	'Garkalnes novads'),
('en_US',	395,	'Grobiņas novads'),
('en_US',	396,	'Gulbenes novads'),
('en_US',	397,	'Iecavas novads'),
('en_US',	398,	'Ikšķiles novads'),
('en_US',	399,	'Ilūkstes novads'),
('en_US',	400,	'Inčukalna novads'),
('en_US',	401,	'Jaunjelgavas novads'),
('en_US',	402,	'Jaunpiebalgas novads'),
('en_US',	403,	'Jaunpils novads'),
('en_US',	404,	'Jelgavas novads'),
('en_US',	405,	'Jēkabpils novads'),
('en_US',	406,	'Kandavas novads'),
('en_US',	407,	'Kokneses novads'),
('en_US',	408,	'Krimuldas novads'),
('en_US',	409,	'Krustpils novads'),
('en_US',	410,	'Krāslavas novads'),
('en_US',	411,	'Kuldīgas novads'),
('en_US',	412,	'Kārsavas novads'),
('en_US',	413,	'Lielvārdes novads'),
('en_US',	414,	'Limbažu novads'),
('en_US',	415,	'Lubānas novads'),
('en_US',	416,	'Ludzas novads'),
('en_US',	417,	'Līgatnes novads'),
('en_US',	418,	'Līvānu novads'),
('en_US',	419,	'Madonas novads'),
('en_US',	420,	'Mazsalacas novads'),
('en_US',	421,	'Mālpils novads'),
('en_US',	422,	'Mārupes novads'),
('en_US',	423,	'Naukšēnu novads'),
('en_US',	424,	'Neretas novads'),
('en_US',	425,	'Nīcas novads'),
('en_US',	426,	'Ogres novads'),
('en_US',	427,	'Olaines novads'),
('en_US',	428,	'Ozolnieku novads'),
('en_US',	429,	'Preiļu novads'),
('en_US',	430,	'Priekules novads'),
('en_US',	431,	'Priekuļu novads'),
('en_US',	432,	'Pārgaujas novads'),
('en_US',	433,	'Pāvilostas novads'),
('en_US',	434,	'Pļaviņu novads'),
('en_US',	435,	'Raunas novads'),
('en_US',	436,	'Riebiņu novads'),
('en_US',	437,	'Rojas novads'),
('en_US',	438,	'Ropažu novads'),
('en_US',	439,	'Rucavas novads'),
('en_US',	440,	'Rugāju novads'),
('en_US',	441,	'Rundāles novads'),
('en_US',	442,	'Rēzeknes novads'),
('en_US',	443,	'Rūjienas novads'),
('en_US',	444,	'Salacgrīvas novads'),
('en_US',	445,	'Salas novads'),
('en_US',	446,	'Salaspils novads'),
('en_US',	447,	'Saldus novads'),
('en_US',	448,	'Saulkrastu novads'),
('en_US',	449,	'Siguldas novads'),
('en_US',	450,	'Skrundas novads'),
('en_US',	451,	'Skrīveru novads'),
('en_US',	452,	'Smiltenes novads'),
('en_US',	453,	'Stopiņu novads'),
('en_US',	454,	'Strenču novads'),
('en_US',	455,	'Sējas novads'),
('en_US',	456,	'Talsu novads'),
('en_US',	457,	'Tukuma novads'),
('en_US',	458,	'Tērvetes novads'),
('en_US',	459,	'Vaiņodes novads'),
('en_US',	460,	'Valkas novads'),
('en_US',	461,	'Valmieras novads'),
('en_US',	462,	'Varakļānu novads'),
('en_US',	463,	'Vecpiebalgas novads'),
('en_US',	464,	'Vecumnieku novads'),
('en_US',	465,	'Ventspils novads'),
('en_US',	466,	'Viesītes novads'),
('en_US',	467,	'Viļakas novads'),
('en_US',	468,	'Viļānu novads'),
('en_US',	469,	'Vārkavas novads'),
('en_US',	470,	'Zilupes novads'),
('en_US',	471,	'Ādažu novads'),
('en_US',	472,	'Ērgļu novads'),
('en_US',	473,	'Ķeguma novads'),
('en_US',	474,	'Ķekavas novads'),
('en_US',	475,	'Alytaus Apskritis'),
('en_US',	476,	'Kauno Apskritis'),
('en_US',	477,	'Klaipėdos Apskritis'),
('en_US',	478,	'Marijampolės Apskritis'),
('en_US',	479,	'Panevėžio Apskritis'),
('en_US',	480,	'Šiaulių Apskritis'),
('en_US',	481,	'Tauragės Apskritis'),
('en_US',	482,	'Telšių Apskritis'),
('en_US',	483,	'Utenos Apskritis'),
('en_US',	484,	'Vilniaus Apskritis'),
('en_US',	485,	'Acre'),
('en_US',	486,	'Alagoas'),
('en_US',	487,	'Amapá'),
('en_US',	488,	'Amazonas'),
('en_US',	489,	'Bahia'),
('en_US',	490,	'Ceará'),
('en_US',	491,	'Espírito Santo'),
('en_US',	492,	'Goiás'),
('en_US',	493,	'Maranhão'),
('en_US',	494,	'Mato Grosso'),
('en_US',	495,	'Mato Grosso do Sul'),
('en_US',	496,	'Minas Gerais'),
('en_US',	497,	'Pará'),
('en_US',	498,	'Paraíba'),
('en_US',	499,	'Paraná'),
('en_US',	500,	'Pernambuco'),
('en_US',	501,	'Piauí'),
('en_US',	502,	'Rio de Janeiro'),
('en_US',	503,	'Rio Grande do Norte'),
('en_US',	504,	'Rio Grande do Sul'),
('en_US',	505,	'Rondônia'),
('en_US',	506,	'Roraima'),
('en_US',	507,	'Santa Catarina'),
('en_US',	508,	'São Paulo'),
('en_US',	509,	'Sergipe'),
('en_US',	510,	'Tocantins'),
('en_US',	511,	'Distrito Federal'),
('en_US',	512,	'Zagrebačka županija'),
('en_US',	513,	'Krapinsko-zagorska županija'),
('en_US',	514,	'Sisačko-moslavačka županija'),
('en_US',	515,	'Karlovačka županija'),
('en_US',	516,	'Varaždinska županija'),
('en_US',	517,	'Koprivničko-križevačka županija'),
('en_US',	518,	'Bjelovarsko-bilogorska županija'),
('en_US',	519,	'Primorsko-goranska županija'),
('en_US',	520,	'Ličko-senjska županija'),
('en_US',	521,	'Virovitičko-podravska županija'),
('en_US',	522,	'Požeško-slavonska županija'),
('en_US',	523,	'Brodsko-posavska županija'),
('en_US',	524,	'Zadarska županija'),
('en_US',	525,	'Osječko-baranjska županija'),
('en_US',	526,	'Šibensko-kninska županija'),
('en_US',	527,	'Vukovarsko-srijemska županija'),
('en_US',	528,	'Splitsko-dalmatinska županija'),
('en_US',	529,	'Istarska županija'),
('en_US',	530,	'Dubrovačko-neretvanska županija'),
('en_US',	531,	'Međimurska županija'),
('en_US',	532,	'Grad Zagreb'),
('en_US',	533,	'Andaman and Nicobar Islands'),
('en_US',	534,	'Andhra Pradesh'),
('en_US',	535,	'Arunachal Pradesh'),
('en_US',	536,	'Assam'),
('en_US',	537,	'Bihar'),
('en_US',	538,	'Chandigarh'),
('en_US',	539,	'Chhattisgarh'),
('en_US',	540,	'Dadra and Nagar Haveli'),
('en_US',	541,	'Daman and Diu'),
('en_US',	542,	'Delhi'),
('en_US',	543,	'Goa'),
('en_US',	544,	'Gujarat'),
('en_US',	545,	'Haryana'),
('en_US',	546,	'Himachal Pradesh'),
('en_US',	547,	'Jammu and Kashmir'),
('en_US',	548,	'Jharkhand'),
('en_US',	549,	'Karnataka'),
('en_US',	550,	'Kerala'),
('en_US',	551,	'Lakshadweep'),
('en_US',	552,	'Madhya Pradesh'),
('en_US',	553,	'Maharashtra'),
('en_US',	554,	'Manipur'),
('en_US',	555,	'Meghalaya'),
('en_US',	556,	'Mizoram'),
('en_US',	557,	'Nagaland'),
('en_US',	558,	'Odisha'),
('en_US',	559,	'Puducherry'),
('en_US',	560,	'Punjab'),
('en_US',	561,	'Rajasthan'),
('en_US',	562,	'Sikkim'),
('en_US',	563,	'Tamil Nadu'),
('en_US',	564,	'Telangana'),
('en_US',	565,	'Tripura'),
('en_US',	566,	'Uttar Pradesh'),
('en_US',	567,	'Uttarakhand'),
('en_US',	568,	'West Bengal');

DROP TABLE IF EXISTS `directory_currency_rate`;
CREATE TABLE `directory_currency_rate` (
  `currency_from` varchar(3) NOT NULL COMMENT 'Currency Code Convert From',
  `currency_to` varchar(3) NOT NULL COMMENT 'Currency Code Convert To',
  `rate` decimal(24,12) NOT NULL DEFAULT '0.000000000000' COMMENT 'Currency Conversion Rate',
  PRIMARY KEY (`currency_from`,`currency_to`),
  KEY `DIRECTORY_CURRENCY_RATE_CURRENCY_TO` (`currency_to`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Directory Currency Rate';

INSERT INTO `directory_currency_rate` (`currency_from`, `currency_to`, `rate`) VALUES
('EUR',	'EUR',	1.000000000000),
('EUR',	'USD',	1.415000000000),
('USD',	'EUR',	0.706700000000),
('USD',	'USD',	1.000000000000);

DROP TABLE IF EXISTS `downloadable_link`;
CREATE TABLE `downloadable_link` (
  `link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Link ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort order',
  `number_of_downloads` int(11) DEFAULT NULL COMMENT 'Number of downloads',
  `is_shareable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Shareable flag',
  `link_url` varchar(255) DEFAULT NULL COMMENT 'Link Url',
  `link_file` varchar(255) DEFAULT NULL COMMENT 'Link File',
  `link_type` varchar(20) DEFAULT NULL COMMENT 'Link Type',
  `sample_url` varchar(255) DEFAULT NULL COMMENT 'Sample Url',
  `sample_file` varchar(255) DEFAULT NULL COMMENT 'Sample File',
  `sample_type` varchar(20) DEFAULT NULL COMMENT 'Sample Type',
  PRIMARY KEY (`link_id`),
  KEY `DOWNLOADABLE_LINK_PRODUCT_ID_SORT_ORDER` (`product_id`,`sort_order`),
  CONSTRAINT `DOWNLOADABLE_LINK_PRODUCT_ID_CATALOG_PRODUCT_ENTITY_ENTITY_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Downloadable Link Table';


DROP TABLE IF EXISTS `downloadable_link_price`;
CREATE TABLE `downloadable_link_price` (
  `price_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Price ID',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Link ID',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website ID',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  PRIMARY KEY (`price_id`),
  KEY `DOWNLOADABLE_LINK_PRICE_LINK_ID` (`link_id`),
  KEY `DOWNLOADABLE_LINK_PRICE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `DOWNLOADABLE_LINK_PRICE_LINK_ID_DOWNLOADABLE_LINK_LINK_ID` FOREIGN KEY (`link_id`) REFERENCES `downloadable_link` (`link_id`) ON DELETE CASCADE,
  CONSTRAINT `DOWNLOADABLE_LINK_PRICE_WEBSITE_ID_STORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Downloadable Link Price Table';


DROP TABLE IF EXISTS `downloadable_link_purchased`;
CREATE TABLE `downloadable_link_purchased` (
  `purchased_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Purchased ID',
  `order_id` int(10) unsigned DEFAULT '0' COMMENT 'Order ID',
  `order_increment_id` varchar(50) DEFAULT NULL COMMENT 'Order Increment ID',
  `order_item_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Order Item ID',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Date of creation',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Date of modification',
  `customer_id` int(10) unsigned DEFAULT '0' COMMENT 'Customer ID',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product name',
  `product_sku` varchar(255) DEFAULT NULL COMMENT 'Product sku',
  `link_section_title` varchar(255) DEFAULT NULL COMMENT 'Link_section_title',
  PRIMARY KEY (`purchased_id`),
  KEY `DOWNLOADABLE_LINK_PURCHASED_ORDER_ID` (`order_id`),
  KEY `DOWNLOADABLE_LINK_PURCHASED_ORDER_ITEM_ID` (`order_item_id`),
  KEY `DOWNLOADABLE_LINK_PURCHASED_CUSTOMER_ID` (`customer_id`),
  CONSTRAINT `DL_LNK_PURCHASED_CSTR_ID_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE SET NULL,
  CONSTRAINT `DOWNLOADABLE_LINK_PURCHASED_ORDER_ID_SALES_ORDER_ENTITY_ID` FOREIGN KEY (`order_id`) REFERENCES `sales_order` (`entity_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Downloadable Link Purchased Table';


DROP TABLE IF EXISTS `downloadable_link_purchased_item`;
CREATE TABLE `downloadable_link_purchased_item` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Item ID',
  `purchased_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Purchased ID',
  `order_item_id` int(10) unsigned DEFAULT '0' COMMENT 'Order Item ID',
  `product_id` int(10) unsigned DEFAULT '0' COMMENT 'Product ID',
  `link_hash` varchar(255) DEFAULT NULL COMMENT 'Link hash',
  `number_of_downloads_bought` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Number of downloads bought',
  `number_of_downloads_used` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Number of downloads used',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Link ID',
  `link_title` varchar(255) DEFAULT NULL COMMENT 'Link Title',
  `is_shareable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Shareable Flag',
  `link_url` varchar(255) DEFAULT NULL COMMENT 'Link Url',
  `link_file` varchar(255) DEFAULT NULL COMMENT 'Link File',
  `link_type` varchar(255) DEFAULT NULL COMMENT 'Link Type',
  `status` varchar(50) DEFAULT NULL COMMENT 'Status',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation Time',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Update Time',
  PRIMARY KEY (`item_id`),
  KEY `DOWNLOADABLE_LINK_PURCHASED_ITEM_LINK_HASH` (`link_hash`),
  KEY `DOWNLOADABLE_LINK_PURCHASED_ITEM_ORDER_ITEM_ID` (`order_item_id`),
  KEY `DOWNLOADABLE_LINK_PURCHASED_ITEM_PURCHASED_ID` (`purchased_id`),
  CONSTRAINT `DL_LNK_PURCHASED_ITEM_ORDER_ITEM_ID_SALES_ORDER_ITEM_ITEM_ID` FOREIGN KEY (`order_item_id`) REFERENCES `sales_order_item` (`item_id`) ON DELETE SET NULL,
  CONSTRAINT `DL_LNK_PURCHASED_ITEM_PURCHASED_ID_DL_LNK_PURCHASED_PURCHASED_ID` FOREIGN KEY (`purchased_id`) REFERENCES `downloadable_link_purchased` (`purchased_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Downloadable Link Purchased Item Table';


DROP TABLE IF EXISTS `downloadable_link_title`;
CREATE TABLE `downloadable_link_title` (
  `title_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Title ID',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Link ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  PRIMARY KEY (`title_id`),
  UNIQUE KEY `DOWNLOADABLE_LINK_TITLE_LINK_ID_STORE_ID` (`link_id`,`store_id`),
  KEY `DOWNLOADABLE_LINK_TITLE_STORE_ID` (`store_id`),
  CONSTRAINT `DOWNLOADABLE_LINK_TITLE_LINK_ID_DOWNLOADABLE_LINK_LINK_ID` FOREIGN KEY (`link_id`) REFERENCES `downloadable_link` (`link_id`) ON DELETE CASCADE,
  CONSTRAINT `DOWNLOADABLE_LINK_TITLE_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Link Title Table';


DROP TABLE IF EXISTS `downloadable_sample`;
CREATE TABLE `downloadable_sample` (
  `sample_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Sample ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `sample_url` varchar(255) DEFAULT NULL COMMENT 'Sample URL',
  `sample_file` varchar(255) DEFAULT NULL COMMENT 'Sample file',
  `sample_type` varchar(20) DEFAULT NULL COMMENT 'Sample Type',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`sample_id`),
  KEY `DOWNLOADABLE_SAMPLE_PRODUCT_ID` (`product_id`),
  CONSTRAINT `DOWNLOADABLE_SAMPLE_PRODUCT_ID_CATALOG_PRODUCT_ENTITY_ENTITY_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Downloadable Sample Table';


DROP TABLE IF EXISTS `downloadable_sample_title`;
CREATE TABLE `downloadable_sample_title` (
  `title_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Title ID',
  `sample_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sample ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  PRIMARY KEY (`title_id`),
  UNIQUE KEY `DOWNLOADABLE_SAMPLE_TITLE_SAMPLE_ID_STORE_ID` (`sample_id`,`store_id`),
  KEY `DOWNLOADABLE_SAMPLE_TITLE_STORE_ID` (`store_id`),
  CONSTRAINT `DL_SAMPLE_TTL_SAMPLE_ID_DL_SAMPLE_SAMPLE_ID` FOREIGN KEY (`sample_id`) REFERENCES `downloadable_sample` (`sample_id`) ON DELETE CASCADE,
  CONSTRAINT `DOWNLOADABLE_SAMPLE_TITLE_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Downloadable Sample Title Table';


DROP TABLE IF EXISTS `eav_attribute`;
CREATE TABLE `eav_attribute` (
  `attribute_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Attribute Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_code` varchar(255) NOT NULL COMMENT 'Attribute Code',
  `attribute_model` varchar(255) DEFAULT NULL COMMENT 'Attribute Model',
  `backend_model` varchar(255) DEFAULT NULL COMMENT 'Backend Model',
  `backend_type` varchar(8) NOT NULL DEFAULT 'static' COMMENT 'Backend Type',
  `backend_table` varchar(255) DEFAULT NULL COMMENT 'Backend Table',
  `frontend_model` varchar(255) DEFAULT NULL COMMENT 'Frontend Model',
  `frontend_input` varchar(50) DEFAULT NULL COMMENT 'Frontend Input',
  `frontend_label` varchar(255) DEFAULT NULL COMMENT 'Frontend Label',
  `frontend_class` varchar(255) DEFAULT NULL COMMENT 'Frontend Class',
  `source_model` varchar(255) DEFAULT NULL COMMENT 'Source Model',
  `is_required` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Defines Is Required',
  `is_user_defined` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Defines Is User Defined',
  `default_value` text COMMENT 'Default Value',
  `is_unique` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Defines Is Unique',
  `note` varchar(255) DEFAULT NULL COMMENT 'Note',
  PRIMARY KEY (`attribute_id`),
  UNIQUE KEY `EAV_ATTRIBUTE_ENTITY_TYPE_ID_ATTRIBUTE_CODE` (`entity_type_id`,`attribute_code`),
  CONSTRAINT `EAV_ATTRIBUTE_ENTITY_TYPE_ID_EAV_ENTITY_TYPE_ENTITY_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Attribute';

INSERT INTO `eav_attribute` (`attribute_id`, `entity_type_id`, `attribute_code`, `attribute_model`, `backend_model`, `backend_type`, `backend_table`, `frontend_model`, `frontend_input`, `frontend_label`, `frontend_class`, `source_model`, `is_required`, `is_user_defined`, `default_value`, `is_unique`, `note`) VALUES
(1,	1,	'website_id',	NULL,	'Magento\\Customer\\Model\\Customer\\Attribute\\Backend\\Website',	'static',	NULL,	NULL,	'select',	'Associate to Website',	NULL,	'Magento\\Customer\\Model\\Customer\\Attribute\\Source\\Website',	1,	0,	NULL,	0,	NULL),
(2,	1,	'store_id',	NULL,	'Magento\\Customer\\Model\\Customer\\Attribute\\Backend\\Store',	'static',	NULL,	NULL,	'select',	'Create In',	NULL,	'Magento\\Customer\\Model\\Customer\\Attribute\\Source\\Store',	1,	0,	NULL,	0,	NULL),
(3,	1,	'created_in',	NULL,	NULL,	'static',	NULL,	NULL,	'text',	'Created From',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(4,	1,	'prefix',	NULL,	NULL,	'static',	NULL,	NULL,	'text',	'Name Prefix',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(5,	1,	'firstname',	NULL,	NULL,	'static',	NULL,	NULL,	'text',	'First Name',	NULL,	NULL,	1,	0,	NULL,	0,	NULL),
(6,	1,	'middlename',	NULL,	NULL,	'static',	NULL,	NULL,	'text',	'Middle Name/Initial',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(7,	1,	'lastname',	NULL,	NULL,	'static',	NULL,	NULL,	'text',	'Last Name',	NULL,	NULL,	1,	0,	NULL,	0,	NULL),
(8,	1,	'suffix',	NULL,	NULL,	'static',	NULL,	NULL,	'text',	'Name Suffix',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(9,	1,	'email',	NULL,	NULL,	'static',	NULL,	NULL,	'text',	'Email',	NULL,	NULL,	1,	0,	NULL,	0,	NULL),
(10,	1,	'group_id',	NULL,	NULL,	'static',	NULL,	NULL,	'select',	'Group',	NULL,	'Magento\\Customer\\Model\\Customer\\Attribute\\Source\\Group',	1,	0,	NULL,	0,	NULL),
(11,	1,	'dob',	NULL,	'Magento\\Eav\\Model\\Entity\\Attribute\\Backend\\Datetime',	'static',	NULL,	'Magento\\Eav\\Model\\Entity\\Attribute\\Frontend\\Datetime',	'date',	'Date of Birth',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(12,	1,	'password_hash',	NULL,	'Magento\\Customer\\Model\\Customer\\Attribute\\Backend\\Password',	'static',	NULL,	NULL,	'hidden',	NULL,	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(13,	1,	'rp_token',	NULL,	NULL,	'static',	NULL,	NULL,	'hidden',	NULL,	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(14,	1,	'rp_token_created_at',	NULL,	NULL,	'static',	NULL,	NULL,	'date',	NULL,	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(15,	1,	'default_billing',	NULL,	'Magento\\Customer\\Model\\Customer\\Attribute\\Backend\\Billing',	'static',	NULL,	NULL,	'text',	'Default Billing Address',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(16,	1,	'default_shipping',	NULL,	'Magento\\Customer\\Model\\Customer\\Attribute\\Backend\\Shipping',	'static',	NULL,	NULL,	'text',	'Default Shipping Address',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(17,	1,	'taxvat',	NULL,	NULL,	'static',	NULL,	NULL,	'text',	'Tax/VAT Number',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(18,	1,	'confirmation',	NULL,	NULL,	'static',	NULL,	NULL,	'text',	'Is Confirmed',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(19,	1,	'created_at',	NULL,	NULL,	'static',	NULL,	NULL,	'date',	'Created At',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(20,	1,	'gender',	NULL,	NULL,	'static',	NULL,	NULL,	'select',	'Gender',	NULL,	'Magento\\Eav\\Model\\Entity\\Attribute\\Source\\Table',	0,	0,	NULL,	0,	NULL),
(21,	1,	'disable_auto_group_change',	NULL,	'Magento\\Customer\\Model\\Attribute\\Backend\\Data\\Boolean',	'static',	NULL,	NULL,	'boolean',	'Disable Automatic Group Change Based on VAT ID',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(22,	2,	'prefix',	NULL,	NULL,	'static',	NULL,	NULL,	'text',	'Name Prefix',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(23,	2,	'firstname',	NULL,	NULL,	'static',	NULL,	NULL,	'text',	'First Name',	NULL,	NULL,	1,	0,	NULL,	0,	NULL),
(24,	2,	'middlename',	NULL,	NULL,	'static',	NULL,	NULL,	'text',	'Middle Name/Initial',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(25,	2,	'lastname',	NULL,	NULL,	'static',	NULL,	NULL,	'text',	'Last Name',	NULL,	NULL,	1,	0,	NULL,	0,	NULL),
(26,	2,	'suffix',	NULL,	NULL,	'static',	NULL,	NULL,	'text',	'Name Suffix',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(27,	2,	'company',	NULL,	NULL,	'static',	NULL,	NULL,	'text',	'Company',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(28,	2,	'street',	NULL,	'Magento\\Eav\\Model\\Entity\\Attribute\\Backend\\DefaultBackend',	'static',	NULL,	NULL,	'multiline',	'Street Address',	NULL,	NULL,	1,	0,	NULL,	0,	NULL),
(29,	2,	'city',	NULL,	NULL,	'static',	NULL,	NULL,	'text',	'City',	NULL,	NULL,	1,	0,	NULL,	0,	NULL),
(30,	2,	'country_id',	NULL,	NULL,	'static',	NULL,	NULL,	'select',	'Country',	NULL,	'Magento\\Customer\\Model\\ResourceModel\\Address\\Attribute\\Source\\Country',	1,	0,	NULL,	0,	NULL),
(31,	2,	'region',	NULL,	'Magento\\Customer\\Model\\ResourceModel\\Address\\Attribute\\Backend\\Region',	'static',	NULL,	NULL,	'text',	'State/Province',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(32,	2,	'region_id',	NULL,	NULL,	'static',	NULL,	NULL,	'hidden',	'State/Province',	NULL,	'Magento\\Customer\\Model\\ResourceModel\\Address\\Attribute\\Source\\Region',	0,	0,	NULL,	0,	NULL),
(33,	2,	'postcode',	NULL,	NULL,	'static',	NULL,	NULL,	'text',	'Zip/Postal Code',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(34,	2,	'telephone',	NULL,	NULL,	'static',	NULL,	NULL,	'text',	'Phone Number',	NULL,	NULL,	1,	0,	NULL,	0,	NULL),
(35,	2,	'fax',	NULL,	NULL,	'static',	NULL,	NULL,	'text',	'Fax',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(36,	2,	'vat_id',	NULL,	NULL,	'static',	NULL,	NULL,	'text',	'VAT Number',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(37,	2,	'vat_is_valid',	NULL,	NULL,	'static',	NULL,	NULL,	'text',	'VAT number validity',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(38,	2,	'vat_request_id',	NULL,	NULL,	'static',	NULL,	NULL,	'text',	'VAT number validation request ID',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(39,	2,	'vat_request_date',	NULL,	NULL,	'static',	NULL,	NULL,	'text',	'VAT number validation request date',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(40,	2,	'vat_request_success',	NULL,	NULL,	'static',	NULL,	NULL,	'text',	'VAT number validation request success',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(41,	1,	'updated_at',	NULL,	NULL,	'static',	NULL,	NULL,	'date',	'Updated At',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(42,	1,	'failures_num',	NULL,	NULL,	'static',	NULL,	NULL,	'hidden',	'Failures Number',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(43,	1,	'first_failure',	NULL,	NULL,	'static',	NULL,	NULL,	'date',	'First Failure Date',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(44,	1,	'lock_expires',	NULL,	NULL,	'static',	NULL,	NULL,	'date',	'Failures Number',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(45,	3,	'name',	NULL,	NULL,	'varchar',	NULL,	NULL,	'text',	'Name',	NULL,	NULL,	1,	0,	NULL,	0,	NULL),
(46,	3,	'is_active',	NULL,	NULL,	'int',	NULL,	NULL,	'select',	'Is Active',	NULL,	'Magento\\Eav\\Model\\Entity\\Attribute\\Source\\Boolean',	1,	0,	NULL,	0,	NULL),
(47,	3,	'description',	NULL,	NULL,	'text',	NULL,	NULL,	'textarea',	'Description',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(48,	3,	'image',	NULL,	'Magento\\Catalog\\Model\\Category\\Attribute\\Backend\\Image',	'varchar',	NULL,	NULL,	'image',	'Image',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(49,	3,	'meta_title',	NULL,	NULL,	'varchar',	NULL,	NULL,	'text',	'Page Title',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(50,	3,	'meta_keywords',	NULL,	NULL,	'text',	NULL,	NULL,	'textarea',	'Meta Keywords',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(51,	3,	'meta_description',	NULL,	NULL,	'text',	NULL,	NULL,	'textarea',	'Meta Description',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(52,	3,	'display_mode',	NULL,	NULL,	'varchar',	NULL,	NULL,	'select',	'Display Mode',	NULL,	'Magento\\Catalog\\Model\\Category\\Attribute\\Source\\Mode',	0,	0,	NULL,	0,	NULL),
(53,	3,	'landing_page',	NULL,	NULL,	'int',	NULL,	NULL,	'select',	'CMS Block',	NULL,	'Magento\\Catalog\\Model\\Category\\Attribute\\Source\\Page',	0,	0,	NULL,	0,	NULL),
(54,	3,	'is_anchor',	NULL,	NULL,	'int',	NULL,	NULL,	'select',	'Is Anchor',	NULL,	'Magento\\Eav\\Model\\Entity\\Attribute\\Source\\Boolean',	0,	0,	'1',	0,	NULL),
(55,	3,	'path',	NULL,	NULL,	'static',	NULL,	NULL,	'text',	'Path',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(56,	3,	'position',	NULL,	NULL,	'static',	NULL,	NULL,	'text',	'Position',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(57,	3,	'all_children',	NULL,	NULL,	'text',	NULL,	NULL,	'text',	NULL,	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(58,	3,	'path_in_store',	NULL,	NULL,	'text',	NULL,	NULL,	'text',	NULL,	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(59,	3,	'children',	NULL,	NULL,	'text',	NULL,	NULL,	'text',	NULL,	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(60,	3,	'custom_design',	NULL,	NULL,	'varchar',	NULL,	NULL,	'select',	'Custom Design',	NULL,	'Magento\\Theme\\Model\\Theme\\Source\\Theme',	0,	0,	NULL,	0,	NULL),
(61,	3,	'custom_design_from',	'Magento\\Catalog\\Model\\ResourceModel\\Eav\\Attribute',	'Magento\\Catalog\\Model\\Attribute\\Backend\\Startdate',	'datetime',	NULL,	'Magento\\Eav\\Model\\Entity\\Attribute\\Frontend\\Datetime',	'date',	'Active From',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(62,	3,	'custom_design_to',	NULL,	'Magento\\Eav\\Model\\Entity\\Attribute\\Backend\\Datetime',	'datetime',	NULL,	NULL,	'date',	'Active To',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(63,	3,	'page_layout',	NULL,	NULL,	'varchar',	NULL,	NULL,	'select',	'Page Layout',	NULL,	'Magento\\Catalog\\Model\\Category\\Attribute\\Source\\Layout',	0,	0,	NULL,	0,	NULL),
(64,	3,	'custom_layout_update',	NULL,	'Magento\\Catalog\\Model\\Attribute\\Backend\\Customlayoutupdate',	'text',	NULL,	NULL,	'textarea',	'Custom Layout Update',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(65,	3,	'level',	NULL,	NULL,	'static',	NULL,	NULL,	'text',	'Level',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(66,	3,	'children_count',	NULL,	NULL,	'static',	NULL,	NULL,	'text',	'Children Count',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(67,	3,	'available_sort_by',	NULL,	'Magento\\Catalog\\Model\\Category\\Attribute\\Backend\\Sortby',	'text',	NULL,	NULL,	'multiselect',	'Available Product Listing Sort By',	NULL,	'Magento\\Catalog\\Model\\Category\\Attribute\\Source\\Sortby',	1,	0,	NULL,	0,	NULL),
(68,	3,	'default_sort_by',	NULL,	'Magento\\Catalog\\Model\\Category\\Attribute\\Backend\\Sortby',	'varchar',	NULL,	NULL,	'select',	'Default Product Listing Sort By',	NULL,	'Magento\\Catalog\\Model\\Category\\Attribute\\Source\\Sortby',	1,	0,	NULL,	0,	NULL),
(69,	3,	'include_in_menu',	NULL,	NULL,	'int',	NULL,	NULL,	'select',	'Include in Navigation Menu',	NULL,	'Magento\\Eav\\Model\\Entity\\Attribute\\Source\\Boolean',	1,	0,	'1',	0,	NULL),
(70,	3,	'custom_use_parent_settings',	NULL,	NULL,	'int',	NULL,	NULL,	'select',	'Use Parent Category Settings',	NULL,	'Magento\\Eav\\Model\\Entity\\Attribute\\Source\\Boolean',	0,	0,	NULL,	0,	NULL),
(71,	3,	'custom_apply_to_products',	NULL,	NULL,	'int',	NULL,	NULL,	'select',	'Apply To Products',	NULL,	'Magento\\Eav\\Model\\Entity\\Attribute\\Source\\Boolean',	0,	0,	NULL,	0,	NULL),
(72,	3,	'filter_price_range',	NULL,	NULL,	'decimal',	NULL,	NULL,	'text',	'Layered Navigation Price Step',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(73,	4,	'name',	NULL,	NULL,	'varchar',	NULL,	NULL,	'text',	'Product Name',	'validate-length maximum-length-255',	NULL,	1,	0,	NULL,	0,	NULL),
(74,	4,	'sku',	NULL,	'Magento\\Catalog\\Model\\Product\\Attribute\\Backend\\Sku',	'static',	NULL,	NULL,	'text',	'SKU',	'validate-length maximum-length-64',	NULL,	1,	0,	NULL,	1,	NULL),
(75,	4,	'description',	NULL,	NULL,	'text',	NULL,	NULL,	'textarea',	'Description',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(76,	4,	'short_description',	NULL,	NULL,	'text',	NULL,	NULL,	'textarea',	'Short Description',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(77,	4,	'price',	NULL,	'Magento\\Catalog\\Model\\Product\\Attribute\\Backend\\Price',	'decimal',	NULL,	NULL,	'price',	'Price',	NULL,	NULL,	1,	0,	NULL,	0,	NULL),
(78,	4,	'special_price',	NULL,	'Magento\\Catalog\\Model\\Product\\Attribute\\Backend\\Price',	'decimal',	NULL,	NULL,	'price',	'Special Price',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(79,	4,	'special_from_date',	NULL,	'Magento\\Catalog\\Model\\Attribute\\Backend\\Startdate',	'datetime',	NULL,	NULL,	'date',	'Special Price From Date',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(80,	4,	'special_to_date',	NULL,	'Magento\\Eav\\Model\\Entity\\Attribute\\Backend\\Datetime',	'datetime',	NULL,	NULL,	'date',	'Special Price To Date',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(81,	4,	'cost',	NULL,	'Magento\\Catalog\\Model\\Product\\Attribute\\Backend\\Price',	'decimal',	NULL,	NULL,	'price',	'Cost',	NULL,	NULL,	0,	1,	NULL,	0,	NULL),
(82,	4,	'weight',	NULL,	'Magento\\Catalog\\Model\\Product\\Attribute\\Backend\\Weight',	'decimal',	NULL,	NULL,	'weight',	'Weight',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(83,	4,	'manufacturer',	NULL,	NULL,	'int',	NULL,	NULL,	'select',	'Manufacturer',	NULL,	NULL,	0,	1,	NULL,	0,	NULL),
(84,	4,	'meta_title',	NULL,	NULL,	'varchar',	NULL,	NULL,	'text',	'Meta Title',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(85,	4,	'meta_keyword',	NULL,	NULL,	'text',	NULL,	NULL,	'textarea',	'Meta Keywords',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(86,	4,	'meta_description',	NULL,	NULL,	'varchar',	NULL,	NULL,	'textarea',	'Meta Description',	NULL,	NULL,	0,	0,	NULL,	0,	'Maximum 255 chars. Meta Description should optimally be between 150-160 characters'),
(87,	4,	'image',	NULL,	NULL,	'varchar',	NULL,	'Magento\\Catalog\\Model\\Product\\Attribute\\Frontend\\Image',	'media_image',	'Base',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(88,	4,	'small_image',	NULL,	NULL,	'varchar',	NULL,	'Magento\\Catalog\\Model\\Product\\Attribute\\Frontend\\Image',	'media_image',	'Small',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(89,	4,	'thumbnail',	NULL,	NULL,	'varchar',	NULL,	'Magento\\Catalog\\Model\\Product\\Attribute\\Frontend\\Image',	'media_image',	'Thumbnail',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(90,	4,	'media_gallery',	NULL,	NULL,	'static',	NULL,	NULL,	'gallery',	'Media Gallery',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(91,	4,	'old_id',	NULL,	NULL,	'int',	NULL,	NULL,	'text',	NULL,	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(92,	4,	'tier_price',	NULL,	'Magento\\Catalog\\Model\\Product\\Attribute\\Backend\\Tierprice',	'decimal',	NULL,	NULL,	'text',	'Tier Price',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(93,	4,	'color',	NULL,	NULL,	'int',	NULL,	NULL,	'select',	'Color',	NULL,	NULL,	0,	1,	NULL,	0,	NULL),
(94,	4,	'news_from_date',	NULL,	'Magento\\Catalog\\Model\\Attribute\\Backend\\Startdate',	'datetime',	NULL,	NULL,	'date',	'Set Product as New from Date',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(95,	4,	'news_to_date',	NULL,	'Magento\\Eav\\Model\\Entity\\Attribute\\Backend\\Datetime',	'datetime',	NULL,	NULL,	'date',	'Set Product as New to Date',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(96,	4,	'gallery',	NULL,	NULL,	'varchar',	NULL,	NULL,	'gallery',	'Image Gallery',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(97,	4,	'status',	NULL,	NULL,	'int',	NULL,	NULL,	'select',	'Enable Product',	NULL,	'Magento\\Catalog\\Model\\Product\\Attribute\\Source\\Status',	0,	0,	'1',	0,	NULL),
(98,	4,	'minimal_price',	NULL,	NULL,	'decimal',	NULL,	NULL,	'price',	'Minimal Price',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(99,	4,	'visibility',	NULL,	NULL,	'int',	NULL,	NULL,	'select',	'Visibility',	NULL,	'Magento\\Catalog\\Model\\Product\\Visibility',	0,	0,	'4',	0,	NULL),
(100,	4,	'custom_design',	NULL,	NULL,	'varchar',	NULL,	NULL,	'select',	'New Theme',	NULL,	'Magento\\Theme\\Model\\Theme\\Source\\Theme',	0,	0,	NULL,	0,	NULL),
(101,	4,	'custom_design_from',	NULL,	'Magento\\Catalog\\Model\\Attribute\\Backend\\Startdate',	'datetime',	NULL,	NULL,	'date',	'Active From',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(102,	4,	'custom_design_to',	NULL,	'Magento\\Eav\\Model\\Entity\\Attribute\\Backend\\Datetime',	'datetime',	NULL,	NULL,	'date',	'Active To',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(103,	4,	'custom_layout_update',	NULL,	'Magento\\Catalog\\Model\\Attribute\\Backend\\Customlayoutupdate',	'text',	NULL,	NULL,	'textarea',	'Layout Update XML',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(104,	4,	'page_layout',	NULL,	NULL,	'varchar',	NULL,	NULL,	'select',	'Layout',	NULL,	'Magento\\Catalog\\Model\\Product\\Attribute\\Source\\Layout',	0,	0,	NULL,	0,	NULL),
(105,	4,	'category_ids',	NULL,	'Magento\\Catalog\\Model\\Product\\Attribute\\Backend\\Category',	'static',	NULL,	NULL,	'text',	'Categories',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(106,	4,	'options_container',	NULL,	NULL,	'varchar',	NULL,	NULL,	'select',	'Display Product Options In',	NULL,	'Magento\\Catalog\\Model\\Entity\\Product\\Attribute\\Design\\Options\\Container',	0,	0,	'container2',	0,	NULL),
(107,	4,	'required_options',	NULL,	NULL,	'static',	NULL,	NULL,	'text',	NULL,	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(108,	4,	'has_options',	NULL,	NULL,	'static',	NULL,	NULL,	'text',	NULL,	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(109,	4,	'image_label',	NULL,	NULL,	'varchar',	NULL,	NULL,	'text',	'Image Label',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(110,	4,	'small_image_label',	NULL,	NULL,	'varchar',	NULL,	NULL,	'text',	'Small Image Label',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(111,	4,	'thumbnail_label',	NULL,	NULL,	'varchar',	NULL,	NULL,	'text',	'Thumbnail Label',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(112,	4,	'created_at',	NULL,	NULL,	'static',	NULL,	NULL,	'date',	NULL,	NULL,	NULL,	1,	0,	NULL,	0,	NULL),
(113,	4,	'updated_at',	NULL,	NULL,	'static',	NULL,	NULL,	'date',	NULL,	NULL,	NULL,	1,	0,	NULL,	0,	NULL),
(114,	4,	'country_of_manufacture',	NULL,	NULL,	'varchar',	NULL,	NULL,	'select',	'Country of Manufacture',	NULL,	'Magento\\Catalog\\Model\\Product\\Attribute\\Source\\Countryofmanufacture',	0,	0,	NULL,	0,	NULL),
(115,	4,	'quantity_and_stock_status',	NULL,	'Magento\\Catalog\\Model\\Product\\Attribute\\Backend\\Stock',	'int',	NULL,	NULL,	'select',	'Quantity',	NULL,	'Magento\\CatalogInventory\\Model\\Source\\Stock',	0,	0,	'1',	0,	NULL),
(116,	4,	'custom_layout',	NULL,	NULL,	'varchar',	NULL,	NULL,	'select',	'New Layout',	NULL,	'Magento\\Catalog\\Model\\Product\\Attribute\\Source\\Layout',	0,	0,	NULL,	0,	NULL),
(117,	4,	'msrp',	NULL,	'Magento\\Catalog\\Model\\Product\\Attribute\\Backend\\Price',	'decimal',	NULL,	NULL,	'price',	'Manufacturer\'s Suggested Retail Price',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(118,	4,	'msrp_display_actual_price_type',	NULL,	'Magento\\Catalog\\Model\\Product\\Attribute\\Backend\\Boolean',	'varchar',	NULL,	NULL,	'select',	'Display Actual Price',	NULL,	'Magento\\Msrp\\Model\\Product\\Attribute\\Source\\Type\\Price',	0,	0,	'0',	0,	NULL),
(119,	3,	'url_key',	NULL,	NULL,	'varchar',	NULL,	NULL,	'text',	'URL Key',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(120,	3,	'url_path',	NULL,	NULL,	'varchar',	NULL,	NULL,	'text',	NULL,	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(121,	4,	'url_key',	NULL,	NULL,	'varchar',	NULL,	NULL,	'text',	'URL Key',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(122,	4,	'url_path',	NULL,	NULL,	'varchar',	NULL,	NULL,	'text',	NULL,	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(123,	4,	'links_purchased_separately',	NULL,	NULL,	'int',	NULL,	NULL,	NULL,	'Links can be purchased separately',	NULL,	NULL,	1,	0,	NULL,	0,	NULL),
(124,	4,	'samples_title',	NULL,	NULL,	'varchar',	NULL,	NULL,	NULL,	'Samples title',	NULL,	NULL,	1,	0,	NULL,	0,	NULL),
(125,	4,	'links_title',	NULL,	NULL,	'varchar',	NULL,	NULL,	NULL,	'Links title',	NULL,	NULL,	1,	0,	NULL,	0,	NULL),
(126,	4,	'links_exist',	NULL,	NULL,	'int',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0,	0,	'0',	0,	NULL),
(127,	4,	'gift_message_available',	NULL,	'Magento\\Catalog\\Model\\Product\\Attribute\\Backend\\Boolean',	'varchar',	NULL,	NULL,	'select',	'Allow Gift Message',	NULL,	'Magento\\Catalog\\Model\\Product\\Attribute\\Source\\Boolean',	0,	0,	NULL,	0,	NULL),
(128,	4,	'swatch_image',	NULL,	NULL,	'varchar',	NULL,	'Magento\\Catalog\\Model\\Product\\Attribute\\Frontend\\Image',	'media_image',	'Swatch',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(129,	4,	'tax_class_id',	NULL,	NULL,	'int',	NULL,	NULL,	'select',	'Tax Class',	NULL,	'Magento\\Tax\\Model\\TaxClass\\Source\\Product',	0,	0,	'2',	0,	NULL),
(130,	4,	'price_type',	NULL,	NULL,	'int',	NULL,	NULL,	'boolean',	'Dynamic Price',	NULL,	NULL,	1,	0,	'0',	0,	NULL),
(131,	4,	'sku_type',	NULL,	NULL,	'int',	NULL,	NULL,	'boolean',	'Dynamic SKU',	NULL,	NULL,	1,	0,	'0',	0,	NULL),
(132,	4,	'weight_type',	NULL,	NULL,	'int',	NULL,	NULL,	'boolean',	'Dynamic Weight',	NULL,	NULL,	1,	0,	'0',	0,	NULL),
(133,	4,	'price_view',	NULL,	NULL,	'int',	NULL,	NULL,	'select',	'Price View',	NULL,	'Magento\\Bundle\\Model\\Product\\Attribute\\Source\\Price\\View',	1,	0,	NULL,	0,	NULL),
(134,	4,	'shipment_type',	NULL,	NULL,	'int',	NULL,	NULL,	'select',	'Ship Bundle Items',	NULL,	'Magento\\Bundle\\Model\\Product\\Attribute\\Source\\Shipment\\Type',	1,	0,	'0',	0,	NULL),
(135,	4,	'ts_dimensions_length',	NULL,	NULL,	'decimal',	NULL,	NULL,	'text',	'Length',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(136,	4,	'ts_dimensions_width',	NULL,	NULL,	'decimal',	NULL,	NULL,	'text',	'Width',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(137,	4,	'ts_dimensions_height',	NULL,	NULL,	'decimal',	NULL,	NULL,	'text',	'Height',	NULL,	NULL,	0,	0,	NULL,	0,	NULL),
(138,	4,	'ready_to_ship',	NULL,	NULL,	'int',	NULL,	NULL,	'boolean',	'Is the Item Ready to Ship?',	NULL,	'\\Magento\\Eav\\Model\\Entity\\Attribute\\Source\\Boolean',	0,	0,	NULL,	0,	'Rate request will be performed as if this item is pre-boxes, it will not be boxed with other items.'),
(139,	4,	'shipping_length',	NULL,	NULL,	'decimal',	NULL,	NULL,	'text',	'Shipping Length',	NULL,	NULL,	0,	0,	NULL,	0,	'Dimension used for Shipping Estimates.'),
(140,	4,	'shipping_width',	NULL,	NULL,	'decimal',	NULL,	NULL,	'text',	'Shipping Width',	NULL,	NULL,	0,	0,	NULL,	0,	'Dimension used for Shipping Estimates.'),
(141,	4,	'shipping_height',	NULL,	NULL,	'decimal',	NULL,	NULL,	'text',	'Shipping Height',	NULL,	NULL,	0,	0,	NULL,	0,	'Dimension used for Shipping Estimates.');

DROP TABLE IF EXISTS `eav_attribute_group`;
CREATE TABLE `eav_attribute_group` (
  `attribute_group_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Attribute Group Id',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set Id',
  `attribute_group_name` varchar(255) DEFAULT NULL COMMENT 'Attribute Group Name',
  `sort_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `default_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Default Id',
  `attribute_group_code` varchar(255) NOT NULL COMMENT 'Attribute Group Code',
  `tab_group_code` varchar(255) DEFAULT NULL COMMENT 'Tab Group Code',
  PRIMARY KEY (`attribute_group_id`),
  UNIQUE KEY `EAV_ATTRIBUTE_GROUP_ATTRIBUTE_SET_ID_ATTRIBUTE_GROUP_CODE` (`attribute_set_id`,`attribute_group_code`),
  UNIQUE KEY `EAV_ATTRIBUTE_GROUP_ATTRIBUTE_SET_ID_ATTRIBUTE_GROUP_NAME` (`attribute_set_id`,`attribute_group_name`),
  KEY `EAV_ATTRIBUTE_GROUP_ATTRIBUTE_SET_ID_SORT_ORDER` (`attribute_set_id`,`sort_order`),
  CONSTRAINT `EAV_ATTR_GROUP_ATTR_SET_ID_EAV_ATTR_SET_ATTR_SET_ID` FOREIGN KEY (`attribute_set_id`) REFERENCES `eav_attribute_set` (`attribute_set_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Attribute Group';

INSERT INTO `eav_attribute_group` (`attribute_group_id`, `attribute_set_id`, `attribute_group_name`, `sort_order`, `default_id`, `attribute_group_code`, `tab_group_code`) VALUES
(1,	1,	'General',	1,	1,	'general',	NULL),
(2,	2,	'General',	1,	1,	'general',	NULL),
(3,	3,	'General',	10,	1,	'general',	NULL),
(4,	3,	'General Information',	2,	0,	'general-information',	NULL),
(5,	3,	'Display Settings',	20,	0,	'display-settings',	NULL),
(6,	3,	'Custom Design',	30,	0,	'custom-design',	NULL),
(7,	4,	'Product Details',	10,	1,	'product-details',	'basic'),
(8,	4,	'Advanced Pricing',	40,	0,	'advanced-pricing',	'advanced'),
(9,	4,	'Search Engine Optimization',	30,	0,	'search-engine-optimization',	'basic'),
(10,	4,	'Images',	20,	0,	'image-management',	'basic'),
(11,	4,	'Design',	50,	0,	'design',	'advanced'),
(12,	4,	'Autosettings',	60,	0,	'autosettings',	'advanced'),
(13,	4,	'Content',	15,	0,	'content',	'basic'),
(14,	4,	'Schedule Design Update',	55,	0,	'schedule-design-update',	'advanced'),
(15,	5,	'General',	1,	1,	'general',	NULL),
(16,	6,	'General',	1,	1,	'general',	NULL),
(17,	7,	'General',	1,	1,	'general',	NULL),
(18,	8,	'General',	1,	1,	'general',	NULL),
(19,	4,	'Gift Options',	61,	0,	'gift-options',	NULL),
(20,	4,	'Bundle Items',	16,	0,	'bundle-items',	NULL);

DROP TABLE IF EXISTS `eav_attribute_label`;
CREATE TABLE `eav_attribute_label` (
  `attribute_label_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Attribute Label Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`attribute_label_id`),
  KEY `EAV_ATTRIBUTE_LABEL_STORE_ID` (`store_id`),
  KEY `EAV_ATTRIBUTE_LABEL_ATTRIBUTE_ID_STORE_ID` (`attribute_id`,`store_id`),
  CONSTRAINT `EAV_ATTRIBUTE_LABEL_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `EAV_ATTRIBUTE_LABEL_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Attribute Label';


DROP TABLE IF EXISTS `eav_attribute_option`;
CREATE TABLE `eav_attribute_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `sort_order` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`option_id`),
  KEY `EAV_ATTRIBUTE_OPTION_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `EAV_ATTRIBUTE_OPTION_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Attribute Option';

INSERT INTO `eav_attribute_option` (`option_id`, `attribute_id`, `sort_order`) VALUES
(1,	20,	0),
(2,	20,	1),
(3,	20,	3);

DROP TABLE IF EXISTS `eav_attribute_option_swatch`;
CREATE TABLE `eav_attribute_option_swatch` (
  `swatch_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Swatch ID',
  `option_id` int(10) unsigned NOT NULL COMMENT 'Option ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `type` smallint(5) unsigned NOT NULL COMMENT 'Swatch type: 0 - text, 1 - visual color, 2 - visual image',
  `value` varchar(255) DEFAULT NULL COMMENT 'Swatch Value',
  PRIMARY KEY (`swatch_id`),
  UNIQUE KEY `EAV_ATTRIBUTE_OPTION_SWATCH_STORE_ID_OPTION_ID` (`store_id`,`option_id`),
  KEY `EAV_ATTR_OPT_SWATCH_OPT_ID_EAV_ATTR_OPT_OPT_ID` (`option_id`),
  KEY `EAV_ATTRIBUTE_OPTION_SWATCH_SWATCH_ID` (`swatch_id`),
  CONSTRAINT `EAV_ATTRIBUTE_OPTION_SWATCH_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `EAV_ATTR_OPT_SWATCH_OPT_ID_EAV_ATTR_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `eav_attribute_option` (`option_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Magento Swatches table';


DROP TABLE IF EXISTS `eav_attribute_option_value`;
CREATE TABLE `eav_attribute_option_value` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  KEY `EAV_ATTRIBUTE_OPTION_VALUE_OPTION_ID` (`option_id`),
  KEY `EAV_ATTRIBUTE_OPTION_VALUE_STORE_ID` (`store_id`),
  CONSTRAINT `EAV_ATTRIBUTE_OPTION_VALUE_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `EAV_ATTR_OPT_VAL_OPT_ID_EAV_ATTR_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `eav_attribute_option` (`option_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Attribute Option Value';

INSERT INTO `eav_attribute_option_value` (`value_id`, `option_id`, `store_id`, `value`) VALUES
(1,	1,	0,	'Male'),
(2,	2,	0,	'Female'),
(3,	3,	0,	'Not Specified');

DROP TABLE IF EXISTS `eav_attribute_set`;
CREATE TABLE `eav_attribute_set` (
  `attribute_set_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Attribute Set Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_set_name` varchar(255) DEFAULT NULL COMMENT 'Attribute Set Name',
  `sort_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`attribute_set_id`),
  UNIQUE KEY `EAV_ATTRIBUTE_SET_ENTITY_TYPE_ID_ATTRIBUTE_SET_NAME` (`entity_type_id`,`attribute_set_name`),
  KEY `EAV_ATTRIBUTE_SET_ENTITY_TYPE_ID_SORT_ORDER` (`entity_type_id`,`sort_order`),
  CONSTRAINT `EAV_ATTRIBUTE_SET_ENTITY_TYPE_ID_EAV_ENTITY_TYPE_ENTITY_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Attribute Set';

INSERT INTO `eav_attribute_set` (`attribute_set_id`, `entity_type_id`, `attribute_set_name`, `sort_order`) VALUES
(1,	1,	'Default',	2),
(2,	2,	'Default',	2),
(3,	3,	'Default',	1),
(4,	4,	'Default',	1),
(5,	5,	'Default',	1),
(6,	6,	'Default',	1),
(7,	7,	'Default',	1),
(8,	8,	'Default',	1);

DROP TABLE IF EXISTS `eav_entity`;
CREATE TABLE `eav_entity` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set Id',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Parent Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Updated At',
  `is_active` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Defines Is Entity Active',
  PRIMARY KEY (`entity_id`),
  KEY `EAV_ENTITY_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `EAV_ENTITY_STORE_ID` (`store_id`),
  CONSTRAINT `EAV_ENTITY_ENTITY_TYPE_ID_EAV_ENTITY_TYPE_ENTITY_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE,
  CONSTRAINT `EAV_ENTITY_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity';


DROP TABLE IF EXISTS `eav_entity_attribute`;
CREATE TABLE `eav_entity_attribute` (
  `entity_attribute_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Attribute Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set Id',
  `attribute_group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Group Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `sort_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`entity_attribute_id`),
  UNIQUE KEY `EAV_ENTITY_ATTRIBUTE_ATTRIBUTE_SET_ID_ATTRIBUTE_ID` (`attribute_set_id`,`attribute_id`),
  UNIQUE KEY `EAV_ENTITY_ATTRIBUTE_ATTRIBUTE_GROUP_ID_ATTRIBUTE_ID` (`attribute_group_id`,`attribute_id`),
  KEY `EAV_ENTITY_ATTRIBUTE_ATTRIBUTE_SET_ID_SORT_ORDER` (`attribute_set_id`,`sort_order`),
  KEY `EAV_ENTITY_ATTRIBUTE_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `EAV_ENTITY_ATTRIBUTE_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `EAV_ENTT_ATTR_ATTR_GROUP_ID_EAV_ATTR_GROUP_ATTR_GROUP_ID` FOREIGN KEY (`attribute_group_id`) REFERENCES `eav_attribute_group` (`attribute_group_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Attributes';

INSERT INTO `eav_entity_attribute` (`entity_attribute_id`, `entity_type_id`, `attribute_set_id`, `attribute_group_id`, `attribute_id`, `sort_order`) VALUES
(1,	1,	1,	1,	1,	10),
(2,	1,	1,	1,	2,	20),
(3,	1,	1,	1,	3,	20),
(4,	1,	1,	1,	4,	30),
(5,	1,	1,	1,	5,	40),
(6,	1,	1,	1,	6,	50),
(7,	1,	1,	1,	7,	60),
(8,	1,	1,	1,	8,	70),
(9,	1,	1,	1,	9,	80),
(10,	1,	1,	1,	10,	25),
(11,	1,	1,	1,	11,	90),
(12,	1,	1,	1,	12,	81),
(13,	1,	1,	1,	13,	115),
(14,	1,	1,	1,	14,	120),
(15,	1,	1,	1,	15,	82),
(16,	1,	1,	1,	16,	83),
(17,	1,	1,	1,	17,	100),
(18,	1,	1,	1,	18,	0),
(19,	1,	1,	1,	19,	0),
(20,	1,	1,	1,	20,	110),
(21,	1,	1,	1,	21,	28),
(22,	2,	2,	2,	22,	10),
(23,	2,	2,	2,	23,	20),
(24,	2,	2,	2,	24,	30),
(25,	2,	2,	2,	25,	40),
(26,	2,	2,	2,	26,	50),
(27,	2,	2,	2,	27,	60),
(28,	2,	2,	2,	28,	70),
(29,	2,	2,	2,	29,	80),
(30,	2,	2,	2,	30,	90),
(31,	2,	2,	2,	31,	100),
(32,	2,	2,	2,	32,	100),
(33,	2,	2,	2,	33,	110),
(34,	2,	2,	2,	34,	120),
(35,	2,	2,	2,	35,	130),
(36,	2,	2,	2,	36,	140),
(37,	2,	2,	2,	37,	132),
(38,	2,	2,	2,	38,	133),
(39,	2,	2,	2,	39,	134),
(40,	2,	2,	2,	40,	135),
(41,	1,	1,	1,	41,	87),
(42,	1,	1,	1,	42,	100),
(43,	1,	1,	1,	43,	110),
(44,	1,	1,	1,	44,	120),
(45,	3,	3,	4,	45,	1),
(46,	3,	3,	4,	46,	2),
(47,	3,	3,	4,	47,	4),
(48,	3,	3,	4,	48,	5),
(49,	3,	3,	4,	49,	6),
(50,	3,	3,	4,	50,	7),
(51,	3,	3,	4,	51,	8),
(52,	3,	3,	5,	52,	10),
(53,	3,	3,	5,	53,	20),
(54,	3,	3,	5,	54,	30),
(55,	3,	3,	4,	55,	12),
(56,	3,	3,	4,	56,	13),
(57,	3,	3,	4,	57,	14),
(58,	3,	3,	4,	58,	15),
(59,	3,	3,	4,	59,	16),
(60,	3,	3,	6,	60,	10),
(61,	3,	3,	6,	61,	30),
(62,	3,	3,	6,	62,	40),
(63,	3,	3,	6,	63,	50),
(64,	3,	3,	6,	64,	60),
(65,	3,	3,	4,	65,	24),
(66,	3,	3,	4,	66,	25),
(67,	3,	3,	5,	67,	40),
(68,	3,	3,	5,	68,	50),
(69,	3,	3,	4,	69,	10),
(70,	3,	3,	6,	70,	5),
(71,	3,	3,	6,	71,	6),
(72,	3,	3,	5,	72,	51),
(73,	4,	4,	7,	73,	10),
(74,	4,	4,	7,	74,	20),
(75,	4,	4,	13,	75,	90),
(76,	4,	4,	13,	76,	100),
(77,	4,	4,	7,	77,	30),
(78,	4,	4,	8,	78,	3),
(79,	4,	4,	8,	79,	4),
(80,	4,	4,	8,	80,	5),
(81,	4,	4,	8,	81,	6),
(82,	4,	4,	7,	82,	70),
(83,	4,	4,	9,	84,	20),
(84,	4,	4,	9,	85,	30),
(85,	4,	4,	9,	86,	40),
(86,	4,	4,	10,	87,	1),
(87,	4,	4,	10,	88,	2),
(88,	4,	4,	10,	89,	3),
(89,	4,	4,	10,	90,	4),
(90,	4,	4,	7,	91,	6),
(91,	4,	4,	8,	92,	7),
(92,	4,	4,	7,	94,	90),
(93,	4,	4,	7,	95,	100),
(94,	4,	4,	10,	96,	5),
(95,	4,	4,	7,	97,	5),
(96,	4,	4,	8,	98,	8),
(97,	4,	4,	7,	99,	80),
(98,	4,	4,	14,	100,	40),
(99,	4,	4,	14,	101,	20),
(100,	4,	4,	14,	102,	30),
(101,	4,	4,	11,	103,	10),
(102,	4,	4,	11,	104,	5),
(103,	4,	4,	7,	105,	80),
(104,	4,	4,	11,	106,	6),
(105,	4,	4,	7,	107,	14),
(106,	4,	4,	7,	108,	15),
(107,	4,	4,	7,	109,	16),
(108,	4,	4,	7,	110,	17),
(109,	4,	4,	7,	111,	18),
(110,	4,	4,	7,	112,	19),
(111,	4,	4,	7,	113,	20),
(112,	4,	4,	7,	114,	110),
(113,	4,	4,	7,	115,	60),
(114,	4,	4,	14,	116,	50),
(115,	4,	4,	8,	117,	9),
(116,	4,	4,	8,	118,	10),
(117,	3,	3,	4,	119,	3),
(118,	3,	3,	4,	120,	17),
(119,	4,	4,	9,	121,	10),
(120,	4,	4,	7,	122,	11),
(121,	4,	4,	7,	123,	111),
(122,	4,	4,	7,	124,	112),
(123,	4,	4,	7,	125,	113),
(124,	4,	4,	7,	126,	114),
(125,	4,	4,	19,	127,	10),
(126,	4,	4,	10,	128,	3),
(127,	4,	4,	7,	129,	40),
(128,	4,	4,	7,	130,	31),
(129,	4,	4,	7,	131,	21),
(130,	4,	4,	7,	132,	71),
(131,	4,	4,	8,	133,	11),
(132,	4,	4,	20,	134,	1),
(133,	4,	4,	7,	135,	65),
(134,	4,	4,	7,	136,	66),
(135,	4,	4,	7,	137,	67),
(136,	4,	4,	7,	138,	115),
(137,	4,	4,	7,	139,	116),
(138,	4,	4,	7,	140,	117),
(139,	4,	4,	7,	141,	118);

DROP TABLE IF EXISTS `eav_entity_datetime`;
CREATE TABLE `eav_entity_datetime` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` datetime DEFAULT NULL COMMENT 'Attribute Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `EAV_ENTITY_DATETIME_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `EAV_ENTITY_DATETIME_STORE_ID` (`store_id`),
  KEY `EAV_ENTITY_DATETIME_ATTRIBUTE_ID_VALUE` (`attribute_id`,`value`),
  KEY `EAV_ENTITY_DATETIME_ENTITY_TYPE_ID_VALUE` (`entity_type_id`,`value`),
  CONSTRAINT `EAV_ENTITY_DATETIME_ENTITY_ID_EAV_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `eav_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `EAV_ENTITY_DATETIME_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `EAV_ENTT_DTIME_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Value Prefix';


DROP TABLE IF EXISTS `eav_entity_decimal`;
CREATE TABLE `eav_entity_decimal` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Attribute Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `EAV_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `EAV_ENTITY_DECIMAL_STORE_ID` (`store_id`),
  KEY `EAV_ENTITY_DECIMAL_ATTRIBUTE_ID_VALUE` (`attribute_id`,`value`),
  KEY `EAV_ENTITY_DECIMAL_ENTITY_TYPE_ID_VALUE` (`entity_type_id`,`value`),
  CONSTRAINT `EAV_ENTITY_DECIMAL_ENTITY_ID_EAV_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `eav_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `EAV_ENTITY_DECIMAL_ENTITY_TYPE_ID_EAV_ENTITY_TYPE_ENTITY_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE,
  CONSTRAINT `EAV_ENTITY_DECIMAL_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Value Prefix';


DROP TABLE IF EXISTS `eav_entity_int`;
CREATE TABLE `eav_entity_int` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` int(11) NOT NULL DEFAULT '0' COMMENT 'Attribute Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `EAV_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `EAV_ENTITY_INT_STORE_ID` (`store_id`),
  KEY `EAV_ENTITY_INT_ATTRIBUTE_ID_VALUE` (`attribute_id`,`value`),
  KEY `EAV_ENTITY_INT_ENTITY_TYPE_ID_VALUE` (`entity_type_id`,`value`),
  CONSTRAINT `EAV_ENTITY_INT_ENTITY_ID_EAV_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `eav_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `EAV_ENTITY_INT_ENTITY_TYPE_ID_EAV_ENTITY_TYPE_ENTITY_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE,
  CONSTRAINT `EAV_ENTITY_INT_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Value Prefix';


DROP TABLE IF EXISTS `eav_entity_store`;
CREATE TABLE `eav_entity_store` (
  `entity_store_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Store Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `increment_prefix` varchar(20) DEFAULT NULL COMMENT 'Increment Prefix',
  `increment_last_id` varchar(50) DEFAULT NULL COMMENT 'Last Incremented Id',
  PRIMARY KEY (`entity_store_id`),
  KEY `EAV_ENTITY_STORE_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `EAV_ENTITY_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `EAV_ENTITY_STORE_ENTITY_TYPE_ID_EAV_ENTITY_TYPE_ENTITY_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE,
  CONSTRAINT `EAV_ENTITY_STORE_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Store';


DROP TABLE IF EXISTS `eav_entity_text`;
CREATE TABLE `eav_entity_text` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` text NOT NULL COMMENT 'Attribute Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `EAV_ENTITY_TEXT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `EAV_ENTITY_TEXT_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `EAV_ENTITY_TEXT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `EAV_ENTITY_TEXT_STORE_ID` (`store_id`),
  CONSTRAINT `EAV_ENTITY_TEXT_ENTITY_ID_EAV_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `eav_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `EAV_ENTITY_TEXT_ENTITY_TYPE_ID_EAV_ENTITY_TYPE_ENTITY_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE,
  CONSTRAINT `EAV_ENTITY_TEXT_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Value Prefix';


DROP TABLE IF EXISTS `eav_entity_type`;
CREATE TABLE `eav_entity_type` (
  `entity_type_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Type Id',
  `entity_type_code` varchar(50) NOT NULL COMMENT 'Entity Type Code',
  `entity_model` varchar(255) NOT NULL COMMENT 'Entity Model',
  `attribute_model` varchar(255) DEFAULT NULL COMMENT 'Attribute Model',
  `entity_table` varchar(255) DEFAULT NULL COMMENT 'Entity Table',
  `value_table_prefix` varchar(255) DEFAULT NULL COMMENT 'Value Table Prefix',
  `entity_id_field` varchar(255) DEFAULT NULL COMMENT 'Entity Id Field',
  `is_data_sharing` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Defines Is Data Sharing',
  `data_sharing_key` varchar(100) DEFAULT 'default' COMMENT 'Data Sharing Key',
  `default_attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Default Attribute Set Id',
  `increment_model` varchar(255) DEFAULT NULL COMMENT 'Increment Model',
  `increment_per_store` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Increment Per Store',
  `increment_pad_length` smallint(5) unsigned NOT NULL DEFAULT '8' COMMENT 'Increment Pad Length',
  `increment_pad_char` varchar(1) NOT NULL DEFAULT '0' COMMENT 'Increment Pad Char',
  `additional_attribute_table` varchar(255) DEFAULT NULL COMMENT 'Additional Attribute Table',
  `entity_attribute_collection` varchar(255) DEFAULT NULL COMMENT 'Entity Attribute Collection',
  PRIMARY KEY (`entity_type_id`),
  KEY `EAV_ENTITY_TYPE_ENTITY_TYPE_CODE` (`entity_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Type';

INSERT INTO `eav_entity_type` (`entity_type_id`, `entity_type_code`, `entity_model`, `attribute_model`, `entity_table`, `value_table_prefix`, `entity_id_field`, `is_data_sharing`, `data_sharing_key`, `default_attribute_set_id`, `increment_model`, `increment_per_store`, `increment_pad_length`, `increment_pad_char`, `additional_attribute_table`, `entity_attribute_collection`) VALUES
(1,	'customer',	'Magento\\Customer\\Model\\ResourceModel\\Customer',	'Magento\\Customer\\Model\\Attribute',	'customer_entity',	NULL,	NULL,	1,	'default',	1,	'Magento\\Eav\\Model\\Entity\\Increment\\NumericValue',	0,	8,	'0',	'customer_eav_attribute',	'Magento\\Customer\\Model\\ResourceModel\\Attribute\\Collection'),
(2,	'customer_address',	'Magento\\Customer\\Model\\ResourceModel\\Address',	'Magento\\Customer\\Model\\Attribute',	'customer_address_entity',	NULL,	NULL,	1,	'default',	2,	NULL,	0,	8,	'0',	'customer_eav_attribute',	'Magento\\Customer\\Model\\ResourceModel\\Address\\Attribute\\Collection'),
(3,	'catalog_category',	'Magento\\Catalog\\Model\\ResourceModel\\Category',	'Magento\\Catalog\\Model\\ResourceModel\\Eav\\Attribute',	'catalog_category_entity',	NULL,	NULL,	1,	'default',	3,	NULL,	0,	8,	'0',	'catalog_eav_attribute',	'Magento\\Catalog\\Model\\ResourceModel\\Category\\Attribute\\Collection'),
(4,	'catalog_product',	'Magento\\Catalog\\Model\\ResourceModel\\Product',	'Magento\\Catalog\\Model\\ResourceModel\\Eav\\Attribute',	'catalog_product_entity',	NULL,	NULL,	1,	'default',	4,	NULL,	0,	8,	'0',	'catalog_eav_attribute',	'Magento\\Catalog\\Model\\ResourceModel\\Product\\Attribute\\Collection'),
(5,	'order',	'Magento\\Sales\\Model\\ResourceModel\\Order',	NULL,	'sales_order',	NULL,	NULL,	1,	'default',	5,	'Magento\\Eav\\Model\\Entity\\Increment\\NumericValue',	1,	8,	'0',	NULL,	NULL),
(6,	'invoice',	'Magento\\Sales\\Model\\ResourceModel\\Order\\Invoice',	NULL,	'sales_invoice',	NULL,	NULL,	1,	'default',	6,	'Magento\\Eav\\Model\\Entity\\Increment\\NumericValue',	1,	8,	'0',	NULL,	NULL),
(7,	'creditmemo',	'Magento\\Sales\\Model\\ResourceModel\\Order\\Creditmemo',	NULL,	'sales_creditmemo',	NULL,	NULL,	1,	'default',	7,	'Magento\\Eav\\Model\\Entity\\Increment\\NumericValue',	1,	8,	'0',	NULL,	NULL),
(8,	'shipment',	'Magento\\Sales\\Model\\ResourceModel\\Order\\Shipment',	NULL,	'sales_shipment',	NULL,	NULL,	1,	'default',	8,	'Magento\\Eav\\Model\\Entity\\Increment\\NumericValue',	1,	8,	'0',	NULL,	NULL);

DROP TABLE IF EXISTS `eav_entity_varchar`;
CREATE TABLE `eav_entity_varchar` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` varchar(255) DEFAULT NULL COMMENT 'Attribute Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `EAV_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `EAV_ENTITY_VARCHAR_STORE_ID` (`store_id`),
  KEY `EAV_ENTITY_VARCHAR_ATTRIBUTE_ID_VALUE` (`attribute_id`,`value`),
  KEY `EAV_ENTITY_VARCHAR_ENTITY_TYPE_ID_VALUE` (`entity_type_id`,`value`),
  CONSTRAINT `EAV_ENTITY_VARCHAR_ENTITY_ID_EAV_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `eav_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `EAV_ENTITY_VARCHAR_ENTITY_TYPE_ID_EAV_ENTITY_TYPE_ENTITY_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE,
  CONSTRAINT `EAV_ENTITY_VARCHAR_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Value Prefix';


DROP TABLE IF EXISTS `eav_form_element`;
CREATE TABLE `eav_form_element` (
  `element_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Element Id',
  `type_id` smallint(5) unsigned NOT NULL COMMENT 'Type Id',
  `fieldset_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Fieldset Id',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  `sort_order` int(11) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`element_id`),
  UNIQUE KEY `EAV_FORM_ELEMENT_TYPE_ID_ATTRIBUTE_ID` (`type_id`,`attribute_id`),
  KEY `EAV_FORM_ELEMENT_FIELDSET_ID` (`fieldset_id`),
  KEY `EAV_FORM_ELEMENT_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `EAV_FORM_ELEMENT_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `EAV_FORM_ELEMENT_FIELDSET_ID_EAV_FORM_FIELDSET_FIELDSET_ID` FOREIGN KEY (`fieldset_id`) REFERENCES `eav_form_fieldset` (`fieldset_id`) ON DELETE SET NULL,
  CONSTRAINT `EAV_FORM_ELEMENT_TYPE_ID_EAV_FORM_TYPE_TYPE_ID` FOREIGN KEY (`type_id`) REFERENCES `eav_form_type` (`type_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Form Element';

INSERT INTO `eav_form_element` (`element_id`, `type_id`, `fieldset_id`, `attribute_id`, `sort_order`) VALUES
(1,	1,	NULL,	23,	0),
(2,	1,	NULL,	25,	1),
(3,	1,	NULL,	27,	2),
(4,	1,	NULL,	9,	3),
(5,	1,	NULL,	28,	4),
(6,	1,	NULL,	29,	5),
(7,	1,	NULL,	31,	6),
(8,	1,	NULL,	33,	7),
(9,	1,	NULL,	30,	8),
(10,	1,	NULL,	34,	9),
(11,	1,	NULL,	35,	10),
(12,	2,	NULL,	23,	0),
(13,	2,	NULL,	25,	1),
(14,	2,	NULL,	27,	2),
(15,	2,	NULL,	9,	3),
(16,	2,	NULL,	28,	4),
(17,	2,	NULL,	29,	5),
(18,	2,	NULL,	31,	6),
(19,	2,	NULL,	33,	7),
(20,	2,	NULL,	30,	8),
(21,	2,	NULL,	34,	9),
(22,	2,	NULL,	35,	10),
(23,	3,	NULL,	23,	0),
(24,	3,	NULL,	25,	1),
(25,	3,	NULL,	27,	2),
(26,	3,	NULL,	28,	3),
(27,	3,	NULL,	29,	4),
(28,	3,	NULL,	31,	5),
(29,	3,	NULL,	33,	6),
(30,	3,	NULL,	30,	7),
(31,	3,	NULL,	34,	8),
(32,	3,	NULL,	35,	9),
(33,	4,	NULL,	23,	0),
(34,	4,	NULL,	25,	1),
(35,	4,	NULL,	27,	2),
(36,	4,	NULL,	28,	3),
(37,	4,	NULL,	29,	4),
(38,	4,	NULL,	31,	5),
(39,	4,	NULL,	33,	6),
(40,	4,	NULL,	30,	7),
(41,	4,	NULL,	34,	8),
(42,	4,	NULL,	35,	9);

DROP TABLE IF EXISTS `eav_form_fieldset`;
CREATE TABLE `eav_form_fieldset` (
  `fieldset_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Fieldset Id',
  `type_id` smallint(5) unsigned NOT NULL COMMENT 'Type Id',
  `code` varchar(64) NOT NULL COMMENT 'Code',
  `sort_order` int(11) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`fieldset_id`),
  UNIQUE KEY `EAV_FORM_FIELDSET_TYPE_ID_CODE` (`type_id`,`code`),
  CONSTRAINT `EAV_FORM_FIELDSET_TYPE_ID_EAV_FORM_TYPE_TYPE_ID` FOREIGN KEY (`type_id`) REFERENCES `eav_form_type` (`type_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Form Fieldset';


DROP TABLE IF EXISTS `eav_form_fieldset_label`;
CREATE TABLE `eav_form_fieldset_label` (
  `fieldset_id` smallint(5) unsigned NOT NULL COMMENT 'Fieldset Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `label` varchar(255) NOT NULL COMMENT 'Label',
  PRIMARY KEY (`fieldset_id`,`store_id`),
  KEY `EAV_FORM_FIELDSET_LABEL_STORE_ID` (`store_id`),
  CONSTRAINT `EAV_FORM_FIELDSET_LABEL_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `EAV_FORM_FSET_LBL_FSET_ID_EAV_FORM_FSET_FSET_ID` FOREIGN KEY (`fieldset_id`) REFERENCES `eav_form_fieldset` (`fieldset_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Form Fieldset Label';


DROP TABLE IF EXISTS `eav_form_type`;
CREATE TABLE `eav_form_type` (
  `type_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Type Id',
  `code` varchar(64) NOT NULL COMMENT 'Code',
  `label` varchar(255) NOT NULL COMMENT 'Label',
  `is_system` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is System',
  `theme` varchar(64) DEFAULT NULL COMMENT 'Theme',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  PRIMARY KEY (`type_id`),
  UNIQUE KEY `EAV_FORM_TYPE_CODE_THEME_STORE_ID` (`code`,`theme`,`store_id`),
  KEY `EAV_FORM_TYPE_STORE_ID` (`store_id`),
  CONSTRAINT `EAV_FORM_TYPE_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Form Type';

INSERT INTO `eav_form_type` (`type_id`, `code`, `label`, `is_system`, `theme`, `store_id`) VALUES
(1,	'checkout_onepage_register',	'checkout_onepage_register',	1,	'',	0),
(2,	'checkout_onepage_register_guest',	'checkout_onepage_register_guest',	1,	'',	0),
(3,	'checkout_onepage_billing_address',	'checkout_onepage_billing_address',	1,	'',	0),
(4,	'checkout_onepage_shipping_address',	'checkout_onepage_shipping_address',	1,	'',	0);

DROP TABLE IF EXISTS `eav_form_type_entity`;
CREATE TABLE `eav_form_type_entity` (
  `type_id` smallint(5) unsigned NOT NULL COMMENT 'Type Id',
  `entity_type_id` smallint(5) unsigned NOT NULL COMMENT 'Entity Type Id',
  PRIMARY KEY (`type_id`,`entity_type_id`),
  KEY `EAV_FORM_TYPE_ENTITY_ENTITY_TYPE_ID` (`entity_type_id`),
  CONSTRAINT `EAV_FORM_TYPE_ENTITY_TYPE_ID_EAV_FORM_TYPE_TYPE_ID` FOREIGN KEY (`type_id`) REFERENCES `eav_form_type` (`type_id`) ON DELETE CASCADE,
  CONSTRAINT `EAV_FORM_TYPE_ENTT_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Form Type Entity';

INSERT INTO `eav_form_type_entity` (`type_id`, `entity_type_id`) VALUES
(1,	1),
(2,	1),
(1,	2),
(2,	2),
(3,	2),
(4,	2);

DROP TABLE IF EXISTS `email_abandoned_cart`;
CREATE TABLE `email_abandoned_cart` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `quote_id` int(10) unsigned DEFAULT NULL COMMENT 'Quote Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer ID',
  `email` varchar(255) NOT NULL DEFAULT '' COMMENT 'Email',
  `is_active` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Quote Active',
  `quote_updated_at` timestamp NULL DEFAULT NULL COMMENT 'Quote updated at',
  `abandoned_cart_number` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Abandoned Cart number',
  `items_count` smallint(5) unsigned DEFAULT '0' COMMENT 'Quote items count',
  `items_ids` varchar(255) DEFAULT NULL COMMENT 'Quote item ids',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated at',
  PRIMARY KEY (`id`),
  KEY `EMAIL_ABANDONED_CART_QUOTE_ID` (`quote_id`),
  KEY `EMAIL_ABANDONED_CART_STORE_ID` (`store_id`),
  KEY `EMAIL_ABANDONED_CART_CUSTOMER_ID` (`customer_id`),
  KEY `EMAIL_ABANDONED_CART_EMAIL` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Abandoned Carts Table';


DROP TABLE IF EXISTS `email_automation`;
CREATE TABLE `email_automation` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `automation_type` varchar(255) DEFAULT NULL COMMENT 'Automation Type',
  `store_name` varchar(255) DEFAULT NULL COMMENT 'Automation Type',
  `enrolment_status` varchar(255) NOT NULL COMMENT 'Entrolment Status',
  `email` varchar(255) DEFAULT NULL COMMENT 'Email',
  `type_id` varchar(255) DEFAULT NULL COMMENT 'Type ID',
  `program_id` varchar(255) DEFAULT NULL COMMENT 'Program ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `message` varchar(255) NOT NULL COMMENT 'Message',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Creation Time',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Update Time',
  PRIMARY KEY (`id`),
  KEY `EMAIL_AUTOMATION_AUTOMATION_TYPE` (`automation_type`),
  KEY `EMAIL_AUTOMATION_ENROLMENT_STATUS` (`enrolment_status`),
  KEY `EMAIL_AUTOMATION_TYPE_ID` (`type_id`),
  KEY `EMAIL_AUTOMATION_EMAIL` (`email`),
  KEY `EMAIL_AUTOMATION_PROGRAM_ID` (`program_id`),
  KEY `EMAIL_AUTOMATION_CREATED_AT` (`created_at`),
  KEY `EMAIL_AUTOMATION_UPDATED_AT` (`updated_at`),
  KEY `EMAIL_AUTOMATION_WEBSITE_ID` (`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Automation Status';


DROP TABLE IF EXISTS `email_campaign`;
CREATE TABLE `email_campaign` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `campaign_id` int(10) unsigned NOT NULL COMMENT 'Campaign ID',
  `email` varchar(255) NOT NULL DEFAULT '' COMMENT 'Contact Email',
  `customer_id` int(10) unsigned NOT NULL COMMENT 'Customer ID',
  `sent_at` timestamp NULL DEFAULT NULL COMMENT 'Send Date',
  `order_increment_id` varchar(50) NOT NULL COMMENT 'Order Increment ID',
  `quote_id` int(10) unsigned NOT NULL COMMENT 'Sales Quote ID',
  `message` varchar(255) NOT NULL DEFAULT '' COMMENT 'Error Message',
  `checkout_method` varchar(255) NOT NULL DEFAULT '' COMMENT 'Checkout Method Used',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `event_name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Event Name',
  `send_id` varchar(255) NOT NULL DEFAULT '' COMMENT 'Send Id',
  `send_status` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Campaign send status',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Creation Time',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Update Time',
  PRIMARY KEY (`id`),
  KEY `EMAIL_CAMPAIGN_STORE_ID` (`store_id`),
  KEY `EMAIL_CAMPAIGN_CAMPAIGN_ID` (`campaign_id`),
  KEY `EMAIL_CAMPAIGN_EMAIL` (`email`),
  KEY `EMAIL_CAMPAIGN_SEND_ID` (`send_id`),
  KEY `EMAIL_CAMPAIGN_SEND_STATUS` (`send_status`),
  KEY `EMAIL_CAMPAIGN_CREATED_AT` (`created_at`),
  KEY `EMAIL_CAMPAIGN_UPDATED_AT` (`updated_at`),
  KEY `EMAIL_CAMPAIGN_SENT_AT` (`sent_at`),
  KEY `EMAIL_CAMPAIGN_EVENT_NAME` (`event_name`),
  KEY `EMAIL_CAMPAIGN_MESSAGE` (`message`),
  KEY `EMAIL_CAMPAIGN_QUOTE_ID` (`quote_id`),
  KEY `EMAIL_CAMPAIGN_CUSTOMER_ID` (`customer_id`),
  CONSTRAINT `EMAIL_CAMPAIGN_STORE_ID_CORE/STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Connector Campaigns';


DROP TABLE IF EXISTS `email_catalog`;
CREATE TABLE `email_catalog` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `imported` smallint(5) unsigned DEFAULT NULL COMMENT 'Product Imported',
  `modified` smallint(5) unsigned DEFAULT NULL COMMENT 'Product Modified',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Creation Time',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Update Time',
  PRIMARY KEY (`id`),
  KEY `EMAIL_CATALOG_PRODUCT_ID` (`product_id`),
  KEY `EMAIL_CATALOG_IMPORTED` (`imported`),
  KEY `EMAIL_CATALOG_MODIFIED` (`modified`),
  KEY `EMAIL_CATALOG_CREATED_AT` (`created_at`),
  KEY `EMAIL_CATALOG_UPDATED_AT` (`updated_at`),
  CONSTRAINT `EMAIL_CATALOG_PRODUCT_ID_CATALOG_PRODUCT_ENTITY_ENTITY_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Connector Catalog';

INSERT INTO `email_catalog` (`id`, `product_id`, `imported`, `modified`, `created_at`, `updated_at`) VALUES
(1,	1,	NULL,	NULL,	'2019-02-18 15:08:31',	'2019-02-18 15:08:31');

DROP TABLE IF EXISTS `email_contact`;
CREATE TABLE `email_contact` (
  `email_contact_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `is_guest` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Guest',
  `contact_id` varchar(15) DEFAULT NULL COMMENT 'Connector Contact ID',
  `customer_id` int(10) unsigned NOT NULL COMMENT 'Customer ID',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `email` varchar(255) NOT NULL DEFAULT '' COMMENT 'Customer Email',
  `is_subscriber` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Subscriber',
  `subscriber_status` smallint(5) unsigned DEFAULT NULL COMMENT 'Subscriber status',
  `email_imported` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Imported',
  `subscriber_imported` smallint(5) unsigned DEFAULT NULL COMMENT 'Subscriber Imported',
  `suppressed` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Suppressed',
  PRIMARY KEY (`email_contact_id`),
  KEY `EMAIL_CONTACT_EMAIL_CONTACT_ID` (`email_contact_id`),
  KEY `EMAIL_CONTACT_IS_GUEST` (`is_guest`),
  KEY `EMAIL_CONTACT_CUSTOMER_ID` (`customer_id`),
  KEY `EMAIL_CONTACT_WEBSITE_ID` (`website_id`),
  KEY `EMAIL_CONTACT_IS_SUBSCRIBER` (`is_subscriber`),
  KEY `EMAIL_CONTACT_SUBSCRIBER_STATUS` (`subscriber_status`),
  KEY `EMAIL_CONTACT_EMAIL_IMPORTED` (`email_imported`),
  KEY `EMAIL_CONTACT_SUBSCRIBER_IMPORTED` (`subscriber_imported`),
  KEY `EMAIL_CONTACT_SUPPRESSED` (`suppressed`),
  KEY `EMAIL_CONTACT_EMAIL` (`email`),
  KEY `EMAIL_CONTACT_CONTACT_ID` (`contact_id`),
  CONSTRAINT `EMAIL_CONTACT_WEBSITE_ID_STORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Connector Contacts';


DROP TABLE IF EXISTS `email_contact_consent`;
CREATE TABLE `email_contact_consent` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `email_contact_id` int(10) unsigned DEFAULT NULL COMMENT 'Email Contact Id',
  `consent_url` varchar(255) DEFAULT NULL COMMENT 'Contact consent url',
  `consent_datetime` datetime DEFAULT NULL COMMENT 'Contact consent datetime',
  `consent_ip` varchar(255) DEFAULT NULL COMMENT 'Contact consent ip',
  `consent_user_agent` varchar(255) DEFAULT NULL COMMENT 'Contact consent user agent',
  PRIMARY KEY (`id`),
  KEY `EMAIL_CONTACT_CONSENT_EMAIL_CONTACT_ID` (`email_contact_id`),
  CONSTRAINT `FK_17E9EA0C469163E550BC6B732AC49FDB` FOREIGN KEY (`email_contact_id`) REFERENCES `email_contact` (`email_contact_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Email contact consent table.';


DROP TABLE IF EXISTS `email_failed_auth`;
CREATE TABLE `email_failed_auth` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `failures_num` int(10) unsigned DEFAULT NULL COMMENT 'Number of fails',
  `first_attempt_date` datetime DEFAULT NULL COMMENT 'First attempt date',
  `last_attempt_date` datetime DEFAULT NULL COMMENT 'Last attempt date',
  `url` varchar(255) DEFAULT NULL COMMENT 'URL',
  `store_id` int(10) unsigned DEFAULT NULL COMMENT 'Store Id',
  PRIMARY KEY (`id`),
  KEY `EMAIL_AUTH_EDC_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Email Failed Auth Table.';


DROP TABLE IF EXISTS `email_importer`;
CREATE TABLE `email_importer` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `import_type` varchar(255) NOT NULL DEFAULT '' COMMENT 'Import Type',
  `website_id` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `import_status` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Import Status',
  `import_id` varchar(255) NOT NULL DEFAULT '' COMMENT 'Import Id',
  `import_data` mediumblob NOT NULL COMMENT 'Import Data',
  `import_mode` varchar(255) NOT NULL DEFAULT '' COMMENT 'Import Mode',
  `import_file` text NOT NULL COMMENT 'Import File',
  `message` varchar(255) NOT NULL DEFAULT '' COMMENT 'Error Message',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Creation Time',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Update Time',
  `import_started` timestamp NULL DEFAULT NULL COMMENT 'Import Started',
  `import_finished` timestamp NULL DEFAULT NULL COMMENT 'Import Finished',
  PRIMARY KEY (`id`),
  KEY `EMAIL_IMPORTER_IMPORT_TYPE` (`import_type`),
  KEY `EMAIL_IMPORTER_WEBSITE_ID` (`website_id`),
  KEY `EMAIL_IMPORTER_IMPORT_STATUS` (`import_status`),
  KEY `EMAIL_IMPORTER_IMPORT_MODE` (`import_mode`),
  KEY `EMAIL_IMPORTER_CREATED_AT` (`created_at`),
  KEY `EMAIL_IMPORTER_UPDATED_AT` (`updated_at`),
  KEY `EMAIL_IMPORTER_IMPORT_ID` (`import_id`),
  KEY `EMAIL_IMPORTER_IMPORT_STARTED` (`import_started`),
  KEY `EMAIL_IMPORTER_IMPORT_FINISHED` (`import_finished`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Email Importer';


DROP TABLE IF EXISTS `email_order`;
CREATE TABLE `email_order` (
  `email_order_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order ID',
  `order_status` varchar(255) NOT NULL COMMENT 'Order Status',
  `quote_id` int(10) unsigned NOT NULL COMMENT 'Sales Quote ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `email_imported` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Order Imported',
  `modified` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Order Modified',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Creation Time',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Update Time',
  PRIMARY KEY (`email_order_id`),
  KEY `EMAIL_ORDER_STORE_ID` (`store_id`),
  KEY `EMAIL_ORDER_QUOTE_ID` (`quote_id`),
  KEY `EMAIL_ORDER_EMAIL_IMPORTED` (`email_imported`),
  KEY `EMAIL_ORDER_ORDER_STATUS` (`order_status`),
  KEY `EMAIL_ORDER_MODIFIED` (`modified`),
  KEY `EMAIL_ORDER_UPDATED_AT` (`updated_at`),
  KEY `EMAIL_ORDER_CREATED_AT` (`created_at`),
  KEY `EMAIL_ORDER_ORDER_ID_SALES_ORDER_ENTITY_ID` (`order_id`),
  CONSTRAINT `EMAIL_ORDER_ORDER_ID_SALES_ORDER_ENTITY_ID` FOREIGN KEY (`order_id`) REFERENCES `sales_order` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `EMAIL_ORDER_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Transactional Order Data';


DROP TABLE IF EXISTS `email_review`;
CREATE TABLE `email_review` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `review_id` int(10) unsigned NOT NULL COMMENT 'Review Id',
  `customer_id` int(10) unsigned NOT NULL COMMENT 'Customer ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `review_imported` smallint(5) unsigned DEFAULT NULL COMMENT 'Review Imported',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Creation Time',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Update Time',
  PRIMARY KEY (`id`),
  KEY `EMAIL_REVIEW_REVIEW_ID` (`review_id`),
  KEY `EMAIL_REVIEW_CUSTOMER_ID` (`customer_id`),
  KEY `EMAIL_REVIEW_STORE_ID` (`store_id`),
  KEY `EMAIL_REVIEW_REVIEW_IMPORTED` (`review_imported`),
  KEY `EMAIL_REVIEW_CREATED_AT` (`created_at`),
  KEY `EMAIL_REVIEW_UPDATED_AT` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Connector Reviews';


DROP TABLE IF EXISTS `email_rules`;
CREATE TABLE `email_rules` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Rule Name',
  `website_ids` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `type` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Rule Type',
  `status` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Status',
  `combination` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Rule Condition',
  `conditions` blob NOT NULL COMMENT 'Rule Conditions',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Creation Time',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Update Time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Connector Rules';


DROP TABLE IF EXISTS `email_template`;
CREATE TABLE `email_template` (
  `template_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Template ID',
  `template_code` varchar(150) NOT NULL COMMENT 'Template Name',
  `template_text` text NOT NULL COMMENT 'Template Content',
  `template_styles` text COMMENT 'Templste Styles',
  `template_type` int(10) unsigned DEFAULT NULL COMMENT 'Template Type',
  `template_subject` varchar(200) NOT NULL COMMENT 'Template Subject',
  `template_sender_name` varchar(200) DEFAULT NULL COMMENT 'Template Sender Name',
  `template_sender_email` varchar(200) DEFAULT NULL COMMENT 'Template Sender Email',
  `added_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Date of Template Creation',
  `modified_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Date of Template Modification',
  `orig_template_code` varchar(200) DEFAULT NULL COMMENT 'Original Template Code',
  `orig_template_variables` text COMMENT 'Original Template Variables',
  PRIMARY KEY (`template_id`),
  UNIQUE KEY `EMAIL_TEMPLATE_TEMPLATE_CODE` (`template_code`),
  KEY `EMAIL_TEMPLATE_ADDED_AT` (`added_at`),
  KEY `EMAIL_TEMPLATE_MODIFIED_AT` (`modified_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Email Templates';

INSERT INTO `email_template` (`template_id`, `template_code`, `template_text`, `template_styles`, `template_type`, `template_subject`, `template_sender_name`, `template_sender_email`, `added_at`, `modified_at`, `orig_template_code`, `orig_template_variables`) VALUES
(1,	'New Pickup Order',	'<!--@subject {{trans \"Your %store_name order confirmation\" store_name=$store.getFrontendName()}} @-->\n<!--@vars {\n\"var order.getCustomerName()\":\"Customer Name\",\n\"var store.getFrontendName()\":\"Customer Name\",\n\"var is_pickup_order\":\"Check if order is a pickup order\",\n\"var $this.getUrl($store,\'customer/account/\',[_nosid:1]) |raw\":\"Gets the link to the Customer Account\",\n\"var store_email |raw\":\"Defined Email Address for this type of mails\",\n\"var store_phone |raw\":\"Defined Phone Number in the Store Information\",\n\"var store_hours |raw\":\"Defined Opening Hours Phone Number in the Store Information\",\n\"var order.increment_id |raw\":\"Order Id\",\n\"var order.getCreatedAtFormatted(2) |raw\":\"Get the date of order creation\",\n\"var order.getEmailCustomerNote()\":\"Email Order Note\",\n\"var formattedBillingAddress|raw\":\"Billing Address\",\n\"var order.getIsNotVirtual()\":\"Check if shipment exists\",\n\"var pickupAddress|raw\":\"Pickup Location Address\",\n\"var formattedShippingAddress|raw\":\"Customer Shipping Address\",\n\"var payment_html|raw\":\"Payment Details\",\n\"var order.getShippingDescription()\":\"Shipping Description\",\n\"var shipping_msg\":\"Shipping message\",\n\"layout handle=\\\"sales_email_order_items\\\" order=$order area=\\\"frontend\\\"\":\"Order Items Grid\"\n} @-->\n\n{{template config_path=\"design/email/header_template\"}}\n\n<table>\n    <tr class=\"email-intro\">\n        <td>\n            <p class=\"greeting\">{{trans \"%customer_name,\" customer_name=$order.getCustomerName()}}</p>\n            <p>\n                {{trans \"Thank you for your order from %store_name.\" store_name=$store.getFrontendName()}}\n                {{if is_pickup_order}}\n                    {{trans \"We will send you a notification once your items are ready for pickup.\"}}\n                {{else}}\n                    {{trans \"Once your package ships we will send you a tracking number.\"}}\n                {{/if}}\n                {{trans \'You can check the status of your order by <a href=\"%account_url\">logging into your account</a>.\' account_url=$this.getUrl($store,\'customer/account/\',[_nosid:1]) |raw}}\n            </p>\n            <p>\n                {{trans \'If you have questions about your order, you can email us at <a href=\"mailto:%store_email\">%store_email</a>\' store_email=$store_email |raw}}{{depend store_phone}} {{trans \' or call us at <a href=\"tel:%store_phone\">%store_phone</a>\' store_phone=$store_phone |raw}}{{/depend}}.\n                {{depend store_hours}}\n                {{trans \'Our hours are <span class=\"no-link\">%store_hours</span>.\' store_hours=$store_hours |raw}}\n                {{/depend}}\n            </p>\n        </td>\n    </tr>\n    <tr class=\"email-summary\">\n        <td>\n            <h1>{{trans \'Your Order <span class=\"no-link\">#%increment_id</span>\' increment_id=$order.increment_id |raw}}</h1>\n            <p>{{trans \'Placed on <span class=\"no-link\">%created_at</span>\' created_at=$order.getCreatedAtFormatted(2) |raw}}</p>\n        </td>\n    </tr>\n    <tr class=\"email-information\">\n        <td>\n            {{depend order.getEmailCustomerNote()}}\n            <table class=\"message-info\">\n                <tr>\n                    <td>\n                        {{var order.getEmailCustomerNote()|escape|nl2br}}\n                    </td>\n                </tr>\n            </table>\n            {{/depend}}\n            <table class=\"order-details\">\n                <tr>\n                    <td class=\"address-details\">\n                        <h3>{{trans \"Billing Info\"}}</h3>\n                        <p>{{var formattedBillingAddress|raw}}</p>\n                    </td>\n                    {{depend order.getIsNotVirtual()}}\n                    <td class=\"address-details\">\n                        <h3>{{trans \"Shipping Info\"}}</h3>\n                        {{if is_pickup_order}}\n                            <h4>{{trans \"Pickup Location\"}}</h4>\n                            <p>{{var pickupAddress|raw}}</p>\n                            <h4>{{trans \"Recipient Address\"}}</h4>\n                        {{/if}}\n                        <p>{{var formattedShippingAddress|raw}}</p>\n                    </td>\n                    {{/depend}}\n                </tr>\n                <tr>\n                    <td class=\"method-info\">\n                        <h3>{{trans \"Payment Method\"}}</h3>\n                        {{var payment_html|raw}}\n                    </td>\n                    {{depend order.getIsNotVirtual()}}\n                    <td class=\"method-info\">\n                        <h3>{{trans \"Shipping Method\"}}</h3>\n                        <p>{{var order.getShippingDescription()}}</p>\n                        {{if shipping_msg}}\n                        <p>{{var shipping_msg}}</p>\n                        {{/if}}\n                    </td>\n                    {{/depend}}\n                </tr>\n            </table>\n            {{layout handle=\"sales_email_order_items\" order=$order area=\"frontend\"}}\n        </td>\n    </tr>\n</table>\n\n{{template config_path=\"design/email/footer_template\"}}\n',	NULL,	2,	'{{trans \"Your %store_name order confirmation\" store_name=$store.getFrontendName()}}',	NULL,	NULL,	'2019-02-18 15:05:39',	'2019-02-18 15:05:39',	'sales_email_order_template',	'{\"var formattedBillingAddress|raw\":\"Billing Address\",\"var order.getEmailCustomerNote()\":\"Email Order Note\",\"var order.increment_id\":\"Order Id\",\"layout handle=\\\"sales_email_order_items\\\" order=$order area=\\\"frontend\\\"\":\"Order Items Grid\",\"var payment_html|raw\":\"Payment Details\",\"var formattedShippingAddress|raw\":\"Shipping Address\",\"var order.getShippingDescription()\":\"Shipping Description\",\"var shipping_msg\":\"Shipping message\"}'),
(2,	'New Pickup Order For Guest',	'<!--@subject {{trans \"Your %store_name order confirmation\" store_name=$store.getFrontendName()}} @-->\n<!--@vars {\n\"var order.getBillingAddress().getName()\":\"Guest Customer Name\",\n\"var store.getFrontendName()\":\"Customer Name\",\n\"var is_pickup_order\":\"Check if order is a pickup order\",\n\"var store_email |raw\":\"Defined Email Address for this type of mails\",\n\"var store_phone |raw\":\"Defined Phone Number in the Store Information\",\n\"var store_hours |raw\":\"Defined Opening Hours Phone Number in the Store Information\",\n\"var order.increment_id |raw\":\"Order Id\",\n\"var order.getCreatedAtFormatted(2) |raw\":\"Get the date of order creation\",\n\"var order.getEmailCustomerNote()\":\"Email Order Note\",\n\"var formattedBillingAddress|raw\":\"Billing Address\",\n\"var order.getIsNotVirtual()\":\"Check if shipment exists\",\n\"var pickupAddress|raw\":\"Pickup Location Address\",\n\"var formattedShippingAddress|raw\":\"Customer Shipping Address\",\n\"var payment_html|raw\":\"Payment Details\",\n\"var order.getShippingDescription()\":\"Shipping Description\",\n\"var shipping_msg\":\"Shipping message\",\n\"layout handle=\\\"sales_email_order_items\\\" order=$order area=\\\"frontend\\\"\":\"Order Items Grid\"\n} @-->\n\n{{template config_path=\"design/email/header_template\"}}\n\n<table>\n    <tr class=\"email-intro\">\n        <td>\n            <p class=\"greeting\">{{trans \"%name,\" name=$order.getBillingAddress().getName()}}</p>\n            <p>\n                {{trans \"Thank you for your order from %store_name.\" store_name=$store.getFrontendName()}}\n                {{if is_pickup_order}}\n                    {{trans \"We will send you a notification once your items are ready for pickup.\"}}\n                {{else}}\n                    {{trans \"Once your package ships we will send an email with a link to track your order.\"}}\n                {{/if}}\n                {{trans \'If you have questions about your order, you can email us at <a href=\"mailto:%store_email\">%store_email</a>\' store_email=$store_email |raw}}{{depend store_phone}} {{trans \' or call us at <a href=\"tel:%store_phone\">%store_phone</a>\' store_phone=$store_phone |raw}}{{/depend}}.\n                {{depend store_hours}}\n                    {{trans \'Our hours are <span class=\"no-link\">%store_hours</span>.\' store_hours=$store_hours |raw}}\n                {{/depend}}\n            </p>\n        </td>\n    </tr>\n    <tr class=\"email-summary\">\n        <td>\n            <h1>{{trans \'Your Order <span class=\"no-link\">#%increment_id</span>\' increment_id=$order.increment_id |raw}}</h1>\n            <p>{{trans \'Placed on <span class=\"no-link\">%created_at</span>\' created_at=$order.getCreatedAtFormatted(2) |raw}}</p>\n        </td>\n    </tr>\n    <tr class=\"email-information\">\n        <td>\n            {{depend order.getEmailCustomerNote()}}\n            <table class=\"message-info\">\n                <tr>\n                    <td>\n                        {{var order.getEmailCustomerNote()|escape|nl2br}}\n                    </td>\n                </tr>\n            </table>\n            {{/depend}}\n            <table class=\"order-details\">\n                <tr>\n                    <td class=\"address-details\">\n                        <h3>{{trans \"Billing Info\"}}</h3>\n                        <p>{{var formattedBillingAddress|raw}}</p>\n                    </td>\n                    {{depend order.getIsNotVirtual()}}\n                    <td class=\"address-details\">\n                        <h3>{{trans \"Shipping Info\"}}</h3>\n                        {{if is_pickup_order}}\n                            <h4>{{trans \"Pickup Location\"}}</h4>\n                            <p>{{var pickupAddress|raw}}</p>\n                            <h4>{{trans \"Recipient Address\"}}</h4>\n                        {{/if}}\n                        <p>{{var formattedShippingAddress|raw}}</p>\n                    </td>\n                    {{/depend}}\n                </tr>\n                <tr>\n                    <td class=\"method-info\">\n                        <h3>{{trans \"Payment Method\"}}</h3>\n                        {{var payment_html|raw}}\n                    </td>\n                    {{depend order.getIsNotVirtual()}}\n                    <td class=\"method-info\">\n                        <h3>{{trans \"Shipping Method\"}}</h3>\n                        <p>{{var order.getShippingDescription()}}</p>\n                        {{if shipping_msg}}\n                        <p>{{var shipping_msg}}</p>\n                        {{/if}}\n                    </td>\n                    {{/depend}}\n                </tr>\n            </table>\n            {{layout handle=\"sales_email_order_items\" order=$order}}\n        </td>\n    </tr>\n</table>\n\n{{template config_path=\"design/email/footer_template\"}}\n',	NULL,	2,	'{{trans \"Your %store_name order confirmation\" store_name=$store.getFrontendName()}}',	NULL,	NULL,	'2019-02-18 15:05:40',	'2019-02-18 15:05:40',	'sales_email_order_guest_template',	'{\"var formattedBillingAddress|raw\":\"Billing Address\",\"var order.getEmailCustomerNote()\":\"Email Order Note\",\"var order.getBillingAddress().getName()\":\"Guest Customer Name\",\"var order.getCreatedAtFormatted(2)\":\"Order Created At (datetime)\",\"var order.increment_id\":\"Order Id\",\"layout handle=\\\"sales_email_order_items\\\" order=$order\":\"Order Items Grid\",\"var payment_html|raw\":\"Payment Details\",\"var formattedShippingAddress|raw\":\"Shipping Address\",\"var order.getShippingDescription()\":\"Shipping Description\",\"var shipping_msg\":\"Shipping message\"}');

DROP TABLE IF EXISTS `email_wishlist`;
CREATE TABLE `email_wishlist` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `wishlist_id` int(10) unsigned NOT NULL COMMENT 'Wishlist Id',
  `item_count` int(10) unsigned NOT NULL COMMENT 'Item Count',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `wishlist_imported` smallint(5) unsigned DEFAULT NULL COMMENT 'Wishlist Imported',
  `wishlist_modified` smallint(5) unsigned DEFAULT NULL COMMENT 'Wishlist Modified',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Creation Time',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Update Time',
  PRIMARY KEY (`id`),
  KEY `EMAIL_WISHLIST_WISHLIST_ID` (`wishlist_id`),
  KEY `EMAIL_WISHLIST_ITEM_COUNT` (`item_count`),
  KEY `EMAIL_WISHLIST_CUSTOMER_ID` (`customer_id`),
  KEY `EMAIL_WISHLIST_WISHLIST_MODIFIED` (`wishlist_modified`),
  KEY `EMAIL_WISHLIST_WISHLIST_IMPORTED` (`wishlist_imported`),
  KEY `EMAIL_WISHLIST_CREATED_AT` (`created_at`),
  KEY `EMAIL_WISHLIST_UPDATED_AT` (`updated_at`),
  KEY `EMAIL_WISHLIST_STORE_ID` (`store_id`),
  CONSTRAINT `EMAIL_WISHLIST_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `EMAIL_WISHLIST_WISHLIST_ID_WISHLIST_WISHLIST_ID` FOREIGN KEY (`wishlist_id`) REFERENCES `wishlist` (`wishlist_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Connector Wishlist';


DROP TABLE IF EXISTS `flag`;
CREATE TABLE `flag` (
  `flag_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Flag Id',
  `flag_code` varchar(255) NOT NULL COMMENT 'Flag Code',
  `state` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Flag State',
  `flag_data` text COMMENT 'Flag Data',
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Date of Last Flag Update',
  PRIMARY KEY (`flag_id`),
  KEY `FLAG_LAST_UPDATE` (`last_update`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Flag';

INSERT INTO `flag` (`flag_id`, `flag_code`, `state`, `flag_data`, `last_update`) VALUES
(1,	'analytics_link_attempts_reverse_counter',	0,	'24',	'2019-02-18 15:05:38');

DROP TABLE IF EXISTS `gift_message`;
CREATE TABLE `gift_message` (
  `gift_message_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'GiftMessage Id',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer id',
  `sender` varchar(255) DEFAULT NULL COMMENT 'Sender',
  `recipient` varchar(255) DEFAULT NULL COMMENT 'Registrant',
  `message` text COMMENT 'Message',
  PRIMARY KEY (`gift_message_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Gift Message';


DROP TABLE IF EXISTS `googleoptimizer_code`;
CREATE TABLE `googleoptimizer_code` (
  `code_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Google experiment code id',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Optimized entity id product id or catalog id',
  `entity_type` varchar(50) DEFAULT NULL COMMENT 'Optimized entity type',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store id',
  `experiment_script` text COMMENT 'Google experiment script',
  PRIMARY KEY (`code_id`),
  UNIQUE KEY `GOOGLEOPTIMIZER_CODE_STORE_ID_ENTITY_ID_ENTITY_TYPE` (`store_id`,`entity_id`,`entity_type`),
  CONSTRAINT `GOOGLEOPTIMIZER_CODE_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Google Experiment code';


DROP TABLE IF EXISTS `importexport_importdata`;
CREATE TABLE `importexport_importdata` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `entity` varchar(50) NOT NULL COMMENT 'Entity',
  `behavior` varchar(10) NOT NULL DEFAULT 'append' COMMENT 'Behavior',
  `data` longtext COMMENT 'Data',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Import Data Table';


DROP TABLE IF EXISTS `import_history`;
CREATE TABLE `import_history` (
  `history_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'History record Id',
  `started_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Started at',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'User ID',
  `imported_file` varchar(255) DEFAULT NULL COMMENT 'Imported file',
  `execution_time` varchar(255) DEFAULT NULL COMMENT 'Execution time',
  `summary` varchar(255) DEFAULT NULL COMMENT 'Summary',
  `error_file` varchar(255) NOT NULL COMMENT 'Imported file with errors',
  PRIMARY KEY (`history_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Import history table';


DROP TABLE IF EXISTS `indexer_state`;
CREATE TABLE `indexer_state` (
  `state_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Indexer State Id',
  `indexer_id` varchar(255) DEFAULT NULL COMMENT 'Indexer Id',
  `status` varchar(16) DEFAULT 'invalid' COMMENT 'Indexer Status',
  `updated` datetime DEFAULT NULL COMMENT 'Indexer Status',
  `hash_config` varchar(32) NOT NULL COMMENT 'Hash of indexer config',
  PRIMARY KEY (`state_id`),
  KEY `INDEXER_STATE_INDEXER_ID` (`indexer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Indexer State';

INSERT INTO `indexer_state` (`state_id`, `indexer_id`, `status`, `updated`, `hash_config`) VALUES
(1,	'design_config_grid',	'valid',	'2019-02-18 15:13:05',	'34ec592bfa6c952bed4d0a1d58c98770'),
(2,	'customer_grid',	'valid',	'2019-02-18 15:13:06',	'b9632e06cf957d6e8103eb236ca38cc1'),
(3,	'catalog_category_product',	'invalid',	'2019-02-18 15:05:33',	'2124d5bfcd83b609c67eee94a0e4708c'),
(4,	'catalog_product_category',	'invalid',	'2019-02-18 15:05:33',	'77b6356629f3259568a68ea64c773238'),
(5,	'catalogrule_rule',	'invalid',	'2019-02-18 15:05:33',	'c4f8344a2e6a7d8ebc065631454a4724'),
(6,	'catalog_product_attribute',	'invalid',	'2019-02-18 15:05:33',	'f73cae77ec4dee3b587a60a2f38dd26a'),
(7,	'cataloginventory_stock',	'invalid',	'2019-02-18 15:05:33',	'1bf66e64558a5171e523b32f25cb99ca'),
(8,	'inventory',	'invalid',	'2019-02-18 15:05:33',	'ff158179c0d7dcaeb1be1da0011eae73'),
(9,	'catalogrule_product',	'invalid',	'2019-02-18 15:05:33',	'667205576ee3764b1ee81c4a076d10ae'),
(10,	'catalog_product_price',	'invalid',	'2019-02-18 15:05:33',	'0e6c8cd322db03524968ab671629718f'),
(11,	'catalogsearch_fulltext',	'valid',	'2019-02-18 15:05:38',	'f7969233b1a7e0a88687f63b60edb602');

DROP TABLE IF EXISTS `integration`;
CREATE TABLE `integration` (
  `integration_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Integration ID',
  `name` varchar(255) NOT NULL COMMENT 'Integration name is displayed in the admin interface',
  `email` varchar(255) NOT NULL COMMENT 'Email address of the contact person',
  `endpoint` varchar(255) DEFAULT NULL COMMENT 'Endpoint for posting consumer credentials',
  `status` smallint(5) unsigned NOT NULL COMMENT 'Integration status',
  `consumer_id` int(10) unsigned DEFAULT NULL COMMENT 'Oauth consumer',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation Time',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT 'Update Time',
  `setup_type` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Integration type - manual or config file',
  `identity_link_url` varchar(255) DEFAULT NULL COMMENT 'Identity linking Url',
  PRIMARY KEY (`integration_id`),
  UNIQUE KEY `INTEGRATION_NAME` (`name`),
  UNIQUE KEY `INTEGRATION_CONSUMER_ID` (`consumer_id`),
  CONSTRAINT `INTEGRATION_CONSUMER_ID_OAUTH_CONSUMER_ENTITY_ID` FOREIGN KEY (`consumer_id`) REFERENCES `oauth_consumer` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='integration';


DROP TABLE IF EXISTS `inventory_low_stock_notification_configuration`;
CREATE TABLE `inventory_low_stock_notification_configuration` (
  `source_code` varchar(255) NOT NULL,
  `sku` varchar(64) NOT NULL,
  `notify_stock_qty` decimal(12,4) DEFAULT NULL,
  PRIMARY KEY (`source_code`,`sku`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `inventory_low_stock_notification_configuration` (`source_code`, `sku`, `notify_stock_qty`) VALUES
('default',	'Simple Product 1',	NULL);

DROP TABLE IF EXISTS `inventory_reservation`;
CREATE TABLE `inventory_reservation` (
  `reservation_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `stock_id` int(10) unsigned NOT NULL,
  `sku` varchar(64) NOT NULL,
  `quantity` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `metadata` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`reservation_id`),
  KEY `INVENTORY_RESERVATION_STOCK_ID_SKU_QUANTITY` (`stock_id`,`sku`,`quantity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `inventory_reservation` (`reservation_id`, `stock_id`, `sku`, `quantity`, `metadata`) VALUES
(1,	1,	'Simple Product 1',	-1.0000,	'{\"event_type\":\"order_placed\",\"object_type\":\"order\",\"object_id\":\"1\"}'),
(2,	1,	'Simple Product 1',	-1.0000,	'{\"event_type\":\"order_placed\",\"object_type\":\"order\",\"object_id\":\"2\"}'),
(3,	1,	'Simple Product 1',	-1.0000,	'{\"event_type\":\"order_placed\",\"object_type\":\"order\",\"object_id\":\"3\"}');

DROP TABLE IF EXISTS `inventory_shipment_source`;
CREATE TABLE `inventory_shipment_source` (
  `shipment_id` int(10) unsigned NOT NULL,
  `source_code` varchar(255) NOT NULL,
  PRIMARY KEY (`shipment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `inventory_source`;
CREATE TABLE `inventory_source` (
  `source_code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `enabled` smallint(5) unsigned NOT NULL DEFAULT '1',
  `description` text,
  `latitude` decimal(8,6) DEFAULT NULL,
  `longitude` decimal(9,6) DEFAULT NULL,
  `country_id` varchar(2) NOT NULL,
  `region_id` int(10) unsigned DEFAULT NULL,
  `region` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `postcode` varchar(255) NOT NULL,
  `contact_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `fax` varchar(255) DEFAULT NULL,
  `use_default_carrier_config` smallint(5) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`source_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `inventory_source` (`source_code`, `name`, `enabled`, `description`, `latitude`, `longitude`, `country_id`, `region_id`, `region`, `city`, `street`, `postcode`, `contact_name`, `email`, `phone`, `fax`, `use_default_carrier_config`) VALUES
('default',	'Default Source',	1,	'Default Source',	0.000000,	0.000000,	'US',	NULL,	NULL,	NULL,	NULL,	'00000',	NULL,	NULL,	NULL,	NULL,	1);

DROP TABLE IF EXISTS `inventory_source_carrier_link`;
CREATE TABLE `inventory_source_carrier_link` (
  `link_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `source_code` varchar(255) NOT NULL,
  `carrier_code` varchar(255) NOT NULL,
  `position` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`link_id`),
  KEY `INV_SOURCE_CARRIER_LNK_SOURCE_CODE_INV_SOURCE_SOURCE_CODE` (`source_code`),
  CONSTRAINT `INV_SOURCE_CARRIER_LNK_SOURCE_CODE_INV_SOURCE_SOURCE_CODE` FOREIGN KEY (`source_code`) REFERENCES `inventory_source` (`source_code`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `inventory_source_item`;
CREATE TABLE `inventory_source_item` (
  `source_item_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `source_code` varchar(255) NOT NULL,
  `sku` varchar(64) NOT NULL,
  `quantity` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `status` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`source_item_id`),
  UNIQUE KEY `INVENTORY_SOURCE_ITEM_SOURCE_CODE_SKU` (`source_code`,`sku`),
  CONSTRAINT `INVENTORY_SOURCE_ITEM_SOURCE_CODE_INVENTORY_SOURCE_SOURCE_CODE` FOREIGN KEY (`source_code`) REFERENCES `inventory_source` (`source_code`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `inventory_source_item` (`source_item_id`, `source_code`, `sku`, `quantity`, `status`) VALUES
(1,	'default',	'Simple Product 1',	99999.0000,	1);

DROP TABLE IF EXISTS `inventory_source_stock_link`;
CREATE TABLE `inventory_source_stock_link` (
  `link_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `stock_id` int(10) unsigned NOT NULL,
  `source_code` varchar(255) NOT NULL,
  `priority` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`link_id`),
  UNIQUE KEY `INVENTORY_SOURCE_STOCK_LINK_STOCK_ID_SOURCE_CODE` (`stock_id`,`source_code`),
  KEY `INV_SOURCE_STOCK_LNK_SOURCE_CODE_INV_SOURCE_SOURCE_CODE` (`source_code`),
  KEY `INVENTORY_SOURCE_STOCK_LINK_STOCK_ID_PRIORITY` (`stock_id`,`priority`),
  CONSTRAINT `INVENTORY_SOURCE_STOCK_LINK_STOCK_ID_INVENTORY_STOCK_STOCK_ID` FOREIGN KEY (`stock_id`) REFERENCES `inventory_stock` (`stock_id`) ON DELETE CASCADE,
  CONSTRAINT `INV_SOURCE_STOCK_LNK_SOURCE_CODE_INV_SOURCE_SOURCE_CODE` FOREIGN KEY (`source_code`) REFERENCES `inventory_source` (`source_code`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `inventory_source_stock_link` (`link_id`, `stock_id`, `source_code`, `priority`) VALUES
(1,	1,	'default',	1);

DROP TABLE IF EXISTS `inventory_stock`;
CREATE TABLE `inventory_stock` (
  `stock_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`stock_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `inventory_stock` (`stock_id`, `name`) VALUES
(1,	'Default Stock');

DROP VIEW IF EXISTS `inventory_stock_1`;
CREATE TABLE `inventory_stock_1` (`product_id` int(10) unsigned, `website_id` smallint(5) unsigned, `stock_id` smallint(5) unsigned, `quantity` decimal(12,4), `is_salable` smallint(5) unsigned, `sku` varchar(64));


DROP TABLE IF EXISTS `inventory_stock_sales_channel`;
CREATE TABLE `inventory_stock_sales_channel` (
  `type` varchar(64) NOT NULL,
  `code` varchar(64) NOT NULL,
  `stock_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`type`,`code`),
  KEY `INVENTORY_STOCK_SALES_CHANNEL_STOCK_ID_INVENTORY_STOCK_STOCK_ID` (`stock_id`),
  CONSTRAINT `INVENTORY_STOCK_SALES_CHANNEL_STOCK_ID_INVENTORY_STOCK_STOCK_ID` FOREIGN KEY (`stock_id`) REFERENCES `inventory_stock` (`stock_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `inventory_stock_sales_channel` (`type`, `code`, `stock_id`) VALUES
('website',	'base',	1);

DROP TABLE IF EXISTS `klarna_core_order`;
CREATE TABLE `klarna_core_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `klarna_order_id` varchar(255) DEFAULT NULL COMMENT 'Klarna Order Id',
  `session_id` varchar(255) DEFAULT NULL COMMENT 'Session Id',
  `reservation_id` varchar(255) DEFAULT NULL COMMENT 'Reservation Id',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `is_acknowledged` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is Acknowledged',
  PRIMARY KEY (`id`),
  KEY `KLARNA_CORE_ORDER_ORDER_ID_SALES_ORDER_ENTITY_ID` (`order_id`),
  KEY `KLARNA_CORE_ORDER_IS_ACKNOWLEDGED` (`is_acknowledged`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Klarna Order';


DROP TABLE IF EXISTS `klarna_payments_quote`;
CREATE TABLE `klarna_payments_quote` (
  `payments_quote_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Payments Id',
  `session_id` varchar(255) DEFAULT NULL COMMENT 'Klarna Session Id',
  `client_token` text COMMENT 'Klarna Client Token',
  `authorization_token` varchar(255) DEFAULT NULL COMMENT 'Authorization Token',
  `is_active` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is Active',
  `quote_id` int(10) unsigned NOT NULL COMMENT 'Quote Id',
  `payment_methods` varchar(255) DEFAULT NULL COMMENT 'Payment Method Categories',
  `payment_method_info` text COMMENT 'Payment Method Category Info',
  PRIMARY KEY (`payments_quote_id`),
  KEY `KLARNA_PAYMENTS_QUOTE_QUOTE_ID_QUOTE_ENTITY_ID` (`quote_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Klarna Payments Quote';


DROP TABLE IF EXISTS `layout_link`;
CREATE TABLE `layout_link` (
  `layout_link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Link Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `theme_id` int(10) unsigned NOT NULL COMMENT 'Theme id',
  `layout_update_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Layout Update Id',
  `is_temporary` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Defines whether Layout Update is Temporary',
  PRIMARY KEY (`layout_link_id`),
  KEY `LAYOUT_LINK_THEME_ID_THEME_THEME_ID` (`theme_id`),
  KEY `LAYOUT_LINK_LAYOUT_UPDATE_ID` (`layout_update_id`),
  KEY `LAYOUT_LINK_STORE_ID_THEME_ID_LAYOUT_UPDATE_ID_IS_TEMPORARY` (`store_id`,`theme_id`,`layout_update_id`,`is_temporary`),
  CONSTRAINT `LAYOUT_LINK_LAYOUT_UPDATE_ID_LAYOUT_UPDATE_LAYOUT_UPDATE_ID` FOREIGN KEY (`layout_update_id`) REFERENCES `layout_update` (`layout_update_id`) ON DELETE CASCADE,
  CONSTRAINT `LAYOUT_LINK_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `LAYOUT_LINK_THEME_ID_THEME_THEME_ID` FOREIGN KEY (`theme_id`) REFERENCES `theme` (`theme_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Layout Link';


DROP TABLE IF EXISTS `layout_update`;
CREATE TABLE `layout_update` (
  `layout_update_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Layout Update Id',
  `handle` varchar(255) DEFAULT NULL COMMENT 'Handle',
  `xml` text COMMENT 'Xml',
  `sort_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `updated_at` timestamp NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last Update Timestamp',
  PRIMARY KEY (`layout_update_id`),
  KEY `LAYOUT_UPDATE_HANDLE` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Layout Updates';


DROP TABLE IF EXISTS `magento_acknowledged_bulk`;
CREATE TABLE `magento_acknowledged_bulk` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Internal ID',
  `bulk_uuid` varbinary(39) DEFAULT NULL COMMENT 'Related Bulk UUID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `MAGENTO_ACKNOWLEDGED_BULK_BULK_UUID` (`bulk_uuid`),
  CONSTRAINT `MAGENTO_ACKNOWLEDGED_BULK_BULK_UUID_MAGENTO_BULK_UUID` FOREIGN KEY (`bulk_uuid`) REFERENCES `magento_bulk` (`uuid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Bulk that was viewed by user from notification area';


DROP TABLE IF EXISTS `magento_bulk`;
CREATE TABLE `magento_bulk` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Bulk Internal ID (must not be exposed)',
  `uuid` varbinary(39) DEFAULT NULL COMMENT 'Bulk UUID (can be exposed to reference bulk entity)',
  `user_id` int(10) unsigned DEFAULT NULL COMMENT 'ID of the WebAPI user that performed an action',
  `user_type` int(11) DEFAULT NULL COMMENT 'Which type of user',
  `description` varchar(255) DEFAULT NULL COMMENT 'Bulk Description',
  `operation_count` int(10) unsigned NOT NULL COMMENT 'Total number of operations scheduled within this bulk',
  `start_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Bulk start time',
  PRIMARY KEY (`id`),
  UNIQUE KEY `MAGENTO_BULK_UUID` (`uuid`),
  KEY `MAGENTO_BULK_USER_ID` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Bulk entity that represents set of related asynchronous operations';


DROP TABLE IF EXISTS `magento_operation`;
CREATE TABLE `magento_operation` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Operation ID',
  `bulk_uuid` varbinary(39) DEFAULT NULL COMMENT 'Related Bulk UUID',
  `topic_name` varchar(255) DEFAULT NULL COMMENT 'Name of the related message queue topic',
  `serialized_data` blob COMMENT 'Data (serialized) required to perform an operation',
  `result_serialized_data` blob COMMENT 'Result data (serialized) after perform an operation',
  `status` smallint(6) DEFAULT '0' COMMENT 'Operation status (OPEN | COMPLETE | RETRIABLY_FAILED | NOT_RETRIABLY_FAILED)',
  `error_code` smallint(6) DEFAULT NULL COMMENT 'Code of the error that appeared during operation execution (used to aggregate related failed operations)',
  `result_message` varchar(255) DEFAULT NULL COMMENT 'Operation result message',
  PRIMARY KEY (`id`),
  KEY `MAGENTO_OPERATION_BULK_UUID_ERROR_CODE` (`bulk_uuid`,`error_code`),
  CONSTRAINT `MAGENTO_OPERATION_BULK_UUID_MAGENTO_BULK_UUID` FOREIGN KEY (`bulk_uuid`) REFERENCES `magento_bulk` (`uuid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Operation entity';


DROP TABLE IF EXISTS `msp_tfa_country_codes`;
CREATE TABLE `msp_tfa_country_codes` (
  `msp_tfa_country_codes_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'TFA admin user ID',
  `code` text NOT NULL COMMENT 'Country code',
  `name` text NOT NULL COMMENT 'Country name',
  `dial_code` text NOT NULL COMMENT 'Prefix',
  PRIMARY KEY (`msp_tfa_country_codes_id`),
  KEY `MSP_TFA_COUNTRY_CODES_CODE` (`code`(128))
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='msp_tfa_country_codes';

INSERT INTO `msp_tfa_country_codes` (`msp_tfa_country_codes_id`, `code`, `name`, `dial_code`) VALUES
(1,	'IL',	'Israel',	'+972'),
(2,	'AF',	'Afghanistan',	'+93'),
(3,	'AL',	'Albania',	'+355'),
(4,	'DZ',	'Algeria',	'+213'),
(5,	'AS',	'AmericanSamoa',	'+1 684'),
(6,	'AD',	'Andorra',	'+376'),
(7,	'AO',	'Angola',	'+244'),
(8,	'AI',	'Anguilla',	'+1 264'),
(9,	'AG',	'Antigua and Barbuda',	'+1268'),
(10,	'AR',	'Argentina',	'+54'),
(11,	'AM',	'Armenia',	'+374'),
(12,	'AW',	'Aruba',	'+297'),
(13,	'AU',	'Australia',	'+61'),
(14,	'AT',	'Austria',	'+43'),
(15,	'AZ',	'Azerbaijan',	'+994'),
(16,	'BS',	'Bahamas',	'+1 242'),
(17,	'BH',	'Bahrain',	'+973'),
(18,	'BD',	'Bangladesh',	'+880'),
(19,	'BB',	'Barbados',	'+1 246'),
(20,	'BY',	'Belarus',	'+375'),
(21,	'BE',	'Belgium',	'+32'),
(22,	'BZ',	'Belize',	'+501'),
(23,	'BJ',	'Benin',	'+229'),
(24,	'BM',	'Bermuda',	'+1 441'),
(25,	'BT',	'Bhutan',	'+975'),
(26,	'BA',	'Bosnia and Herzegovina',	'+387'),
(27,	'BW',	'Botswana',	'+267'),
(28,	'BR',	'Brazil',	'+55'),
(29,	'IO',	'British Indian Ocean Territory',	'+246'),
(30,	'BG',	'Bulgaria',	'+359'),
(31,	'BF',	'Burkina Faso',	'+226'),
(32,	'BI',	'Burundi',	'+257'),
(33,	'KH',	'Cambodia',	'+855'),
(34,	'CM',	'Cameroon',	'+237'),
(35,	'CA',	'Canada',	'+1'),
(36,	'CV',	'Cape Verde',	'+238'),
(37,	'KY',	'Cayman Islands',	'+ 345'),
(38,	'CF',	'Central African Republic',	'+236'),
(39,	'TD',	'Chad',	'+235'),
(40,	'CL',	'Chile',	'+56'),
(41,	'CN',	'China',	'+86'),
(42,	'CX',	'Christmas Island',	'+61'),
(43,	'CO',	'Colombia',	'+57'),
(44,	'KM',	'Comoros',	'+269'),
(45,	'CG',	'Congo',	'+242'),
(46,	'CK',	'Cook Islands',	'+682'),
(47,	'CR',	'Costa Rica',	'+506'),
(48,	'HR',	'Croatia',	'+385'),
(49,	'CU',	'Cuba',	'+53'),
(50,	'CY',	'Cyprus',	'+537'),
(51,	'CZ',	'Czech Republic',	'+420'),
(52,	'DK',	'Denmark',	'+45'),
(53,	'DJ',	'Djibouti',	'+253'),
(54,	'DM',	'Dominica',	'+1 767'),
(55,	'DO',	'Dominican Republic',	'+1 849'),
(56,	'EC',	'Ecuador',	'+593'),
(57,	'EG',	'Egypt',	'+20'),
(58,	'SV',	'El Salvador',	'+503'),
(59,	'GQ',	'Equatorial Guinea',	'+240'),
(60,	'ER',	'Eritrea',	'+291'),
(61,	'EE',	'Estonia',	'+372'),
(62,	'ET',	'Ethiopia',	'+251'),
(63,	'FO',	'Faroe Islands',	'+298'),
(64,	'FJ',	'Fiji',	'+679'),
(65,	'FI',	'Finland',	'+358'),
(66,	'FR',	'France',	'+33'),
(67,	'GF',	'French Guiana',	'+594'),
(68,	'PF',	'French Polynesia',	'+689'),
(69,	'GA',	'Gabon',	'+241'),
(70,	'GM',	'Gambia',	'+220'),
(71,	'GE',	'Georgia',	'+995'),
(72,	'DE',	'Germany',	'+49'),
(73,	'GH',	'Ghana',	'+233'),
(74,	'GI',	'Gibraltar',	'+350'),
(75,	'GR',	'Greece',	'+30'),
(76,	'GL',	'Greenland',	'+299'),
(77,	'GD',	'Grenada',	'+1 473'),
(78,	'GP',	'Guadeloupe',	'+590'),
(79,	'GU',	'Guam',	'+1 671'),
(80,	'GT',	'Guatemala',	'+502'),
(81,	'GN',	'Guinea',	'+224'),
(82,	'GW',	'Guinea-Bissau',	'+245'),
(83,	'GY',	'Guyana',	'+595'),
(84,	'HT',	'Haiti',	'+509'),
(85,	'HN',	'Honduras',	'+504'),
(86,	'HU',	'Hungary',	'+36'),
(87,	'IS',	'Iceland',	'+354'),
(88,	'IN',	'India',	'+91'),
(89,	'ID',	'Indonesia',	'+62'),
(90,	'IQ',	'Iraq',	'+964'),
(91,	'IE',	'Ireland',	'+353'),
(92,	'IL',	'Israel',	'+972'),
(93,	'IT',	'Italy',	'+39'),
(94,	'JM',	'Jamaica',	'+1 876'),
(95,	'JP',	'Japan',	'+81'),
(96,	'JO',	'Jordan',	'+962'),
(97,	'KZ',	'Kazakhstan',	'+7 7'),
(98,	'KE',	'Kenya',	'+254'),
(99,	'KI',	'Kiribati',	'+686'),
(100,	'KW',	'Kuwait',	'+965'),
(101,	'KG',	'Kyrgyzstan',	'+996'),
(102,	'LV',	'Latvia',	'+371'),
(103,	'LB',	'Lebanon',	'+961'),
(104,	'LS',	'Lesotho',	'+266'),
(105,	'LR',	'Liberia',	'+231'),
(106,	'LI',	'Liechtenstein',	'+423'),
(107,	'LT',	'Lithuania',	'+370'),
(108,	'LU',	'Luxembourg',	'+352'),
(109,	'MG',	'Madagascar',	'+261'),
(110,	'MW',	'Malawi',	'+265'),
(111,	'MY',	'Malaysia',	'+60'),
(112,	'MV',	'Maldives',	'+960'),
(113,	'ML',	'Mali',	'+223'),
(114,	'MT',	'Malta',	'+356'),
(115,	'MH',	'Marshall Islands',	'+692'),
(116,	'MQ',	'Martinique',	'+596'),
(117,	'MR',	'Mauritania',	'+222'),
(118,	'MU',	'Mauritius',	'+230'),
(119,	'YT',	'Mayotte',	'+262'),
(120,	'MX',	'Mexico',	'+52'),
(121,	'MC',	'Monaco',	'+377'),
(122,	'MN',	'Mongolia',	'+976'),
(123,	'ME',	'Montenegro',	'+382'),
(124,	'MS',	'Montserrat',	'+1664'),
(125,	'MA',	'Morocco',	'+212'),
(126,	'MM',	'Myanmar',	'+95'),
(127,	'NA',	'Namibia',	'+264'),
(128,	'NR',	'Nauru',	'+674'),
(129,	'NP',	'Nepal',	'+977'),
(130,	'NL',	'Netherlands',	'+31'),
(131,	'AN',	'Netherlands Antilles',	'+599'),
(132,	'NC',	'New Caledonia',	'+687'),
(133,	'NZ',	'New Zealand',	'+64'),
(134,	'NI',	'Nicaragua',	'+505'),
(135,	'NE',	'Niger',	'+227'),
(136,	'NG',	'Nigeria',	'+234'),
(137,	'NU',	'Niue',	'+683'),
(138,	'NF',	'Norfolk Island',	'+672'),
(139,	'MP',	'Northern Mariana Islands',	'+1 670'),
(140,	'NO',	'Norway',	'+47'),
(141,	'OM',	'Oman',	'+968'),
(142,	'PK',	'Pakistan',	'+92'),
(143,	'PW',	'Palau',	'+680'),
(144,	'PA',	'Panama',	'+507'),
(145,	'PG',	'Papua New Guinea',	'+675'),
(146,	'PY',	'Paraguay',	'+595'),
(147,	'PE',	'Peru',	'+51'),
(148,	'PH',	'Philippines',	'+63'),
(149,	'PL',	'Poland',	'+48'),
(150,	'PT',	'Portugal',	'+351'),
(151,	'PR',	'Puerto Rico',	'+1 939'),
(152,	'QA',	'Qatar',	'+974'),
(153,	'RO',	'Romania',	'+40'),
(154,	'RW',	'Rwanda',	'+250'),
(155,	'WS',	'Samoa',	'+685'),
(156,	'SM',	'San Marino',	'+378'),
(157,	'SA',	'Saudi Arabia',	'+966'),
(158,	'SN',	'Senegal',	'+221'),
(159,	'RS',	'Serbia',	'+381'),
(160,	'SC',	'Seychelles',	'+248'),
(161,	'SL',	'Sierra Leone',	'+232'),
(162,	'SG',	'Singapore',	'+65'),
(163,	'SK',	'Slovakia',	'+421'),
(164,	'SI',	'Slovenia',	'+386'),
(165,	'SB',	'Solomon Islands',	'+677'),
(166,	'ZA',	'South Africa',	'+27'),
(167,	'GS',	'South Georgia and the South Sandwich Islands',	'+500'),
(168,	'ES',	'Spain',	'+34'),
(169,	'LK',	'Sri Lanka',	'+94'),
(170,	'SD',	'Sudan',	'+249'),
(171,	'SR',	'Suriname',	'+597'),
(172,	'SZ',	'Swaziland',	'+268'),
(173,	'SE',	'Sweden',	'+46'),
(174,	'CH',	'Switzerland',	'+41'),
(175,	'TJ',	'Tajikistan',	'+992'),
(176,	'TH',	'Thailand',	'+66'),
(177,	'TG',	'Togo',	'+228'),
(178,	'TK',	'Tokelau',	'+690'),
(179,	'TO',	'Tonga',	'+676'),
(180,	'TT',	'Trinidad and Tobago',	'+1 868'),
(181,	'TN',	'Tunisia',	'+216'),
(182,	'TR',	'Turkey',	'+90'),
(183,	'TM',	'Turkmenistan',	'+993'),
(184,	'TC',	'Turks and Caicos Islands',	'+1 649'),
(185,	'TV',	'Tuvalu',	'+688'),
(186,	'UG',	'Uganda',	'+256'),
(187,	'UA',	'Ukraine',	'+380'),
(188,	'AE',	'United Arab Emirates',	'+971'),
(189,	'GB',	'United Kingdom',	'+44'),
(190,	'US',	'United States',	'+1'),
(191,	'UY',	'Uruguay',	'+598'),
(192,	'UZ',	'Uzbekistan',	'+998'),
(193,	'VU',	'Vanuatu',	'+678'),
(194,	'WF',	'Wallis and Futuna',	'+681'),
(195,	'YE',	'Yemen',	'+967'),
(196,	'ZM',	'Zambia',	'+260'),
(197,	'ZW',	'Zimbabwe',	'+263'),
(198,	'AX',	'land Islands',	''),
(199,	'BO',	'Bolivia, Plurinational State of',	'+591'),
(200,	'BN',	'Brunei Darussalam',	'+673'),
(201,	'CC',	'Cocos (Keeling) Islands',	'+61'),
(202,	'CD',	'Congo, The Democratic Republic of the',	'+243'),
(203,	'CI',	'Cote d\'Ivoire',	'+225'),
(204,	'FK',	'Falkland Islands (Malvinas)',	'+500'),
(205,	'GG',	'Guernsey',	'+44'),
(206,	'VA',	'Holy See (Vatican City State)',	'+379'),
(207,	'HK',	'Hong Kong',	'+852'),
(208,	'IR',	'Iran, Islamic Republic of',	'+98'),
(209,	'IM',	'Isle of Man',	'+44'),
(210,	'JE',	'Jersey',	'+44'),
(211,	'KP',	'Korea, Democratic People\'s Republic of',	'+850'),
(212,	'KR',	'Korea, Republic of',	'+82'),
(213,	'LA',	'Lao People\'s Democratic Republic',	'+856'),
(214,	'LY',	'Libyan Arab Jamahiriya',	'+218'),
(215,	'MO',	'Macao',	'+853'),
(216,	'MK',	'Macedonia, The Former Yugoslav Republic of',	'+389'),
(217,	'FM',	'Micronesia, Federated States of',	'+691'),
(218,	'MD',	'Moldova, Republic of',	'+373'),
(219,	'MZ',	'Mozambique',	'+258'),
(220,	'PS',	'Palestinian Territory, Occupied',	'+970'),
(221,	'PN',	'Pitcairn',	'+872'),
(222,	'RE',	'Réunion',	'+262'),
(223,	'RU',	'Russia',	'+7'),
(224,	'BL',	'Saint Barthélemy',	'+590'),
(225,	'SH',	'Saint Helena, Ascension and Tristan Da Cunha',	'+290'),
(226,	'KN',	'Saint Kitts and Nevis',	'+1 869'),
(227,	'LC',	'Saint Lucia',	'+1 758'),
(228,	'MF',	'Saint Martin',	'+590'),
(229,	'PM',	'Saint Pierre and Miquelon',	'+508'),
(230,	'VC',	'Saint Vincent and the Grenadines',	'+1 784'),
(231,	'ST',	'Sao Tome and Principe',	'+239'),
(232,	'SO',	'Somalia',	'+252'),
(233,	'SJ',	'Svalbard and Jan Mayen',	'+47'),
(234,	'SY',	'Syrian Arab Republic',	'+963'),
(235,	'TW',	'Taiwan, Province of China',	'+886'),
(236,	'TZ',	'Tanzania, United Republic of',	'+255'),
(237,	'TL',	'Timor-Leste',	'+670'),
(238,	'VE',	'Venezuela, Bolivarian Republic of',	'+58'),
(239,	'VN',	'Viet Nam',	'+84'),
(240,	'VG',	'Virgin Islands, British',	'+1 284'),
(241,	'VI',	'Virgin Islands, U.S.',	'+1 340');

DROP TABLE IF EXISTS `msp_tfa_trusted`;
CREATE TABLE `msp_tfa_trusted` (
  `msp_tfa_trusted_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Trusted device ID',
  `date_time` datetime NOT NULL COMMENT 'Date and time',
  `user_id` int(10) unsigned NOT NULL COMMENT 'User ID',
  `device_name` text NOT NULL COMMENT 'Device name',
  `token` text NOT NULL COMMENT 'Token',
  `last_ip` text NOT NULL COMMENT 'Last IP',
  PRIMARY KEY (`msp_tfa_trusted_id`),
  KEY `MSP_TFA_TRUSTED_USER_ID_ADMIN_USER_USER_ID` (`user_id`),
  CONSTRAINT `MSP_TFA_TRUSTED_USER_ID_ADMIN_USER_USER_ID` FOREIGN KEY (`user_id`) REFERENCES `admin_user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='msp_tfa_trusted';


DROP TABLE IF EXISTS `msp_tfa_user_config`;
CREATE TABLE `msp_tfa_user_config` (
  `msp_tfa_user_config_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'TFA admin user ID',
  `user_id` int(10) unsigned NOT NULL COMMENT 'User ID',
  `encoded_providers` text COMMENT 'Encoded providers list',
  `encoded_config` text COMMENT 'Encoded providers configuration',
  `default_provider` text COMMENT 'Default provider',
  PRIMARY KEY (`msp_tfa_user_config_id`),
  KEY `MSP_TFA_USER_CONFIG_USER_ID_ADMIN_USER_USER_ID` (`user_id`),
  CONSTRAINT `MSP_TFA_USER_CONFIG_USER_ID_ADMIN_USER_USER_ID` FOREIGN KEY (`user_id`) REFERENCES `admin_user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='msp_tfa_user_config';


DROP TABLE IF EXISTS `mview_state`;
CREATE TABLE `mview_state` (
  `state_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'View State Id',
  `view_id` varchar(255) DEFAULT NULL COMMENT 'View Id',
  `mode` varchar(16) DEFAULT 'disabled' COMMENT 'View Mode',
  `status` varchar(16) DEFAULT 'idle' COMMENT 'View Status',
  `updated` datetime DEFAULT NULL COMMENT 'View updated time',
  `version_id` int(10) unsigned DEFAULT NULL COMMENT 'View Version Id',
  PRIMARY KEY (`state_id`),
  KEY `MVIEW_STATE_VIEW_ID` (`view_id`),
  KEY `MVIEW_STATE_MODE` (`mode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='View State';


DROP TABLE IF EXISTS `newsletter_problem`;
CREATE TABLE `newsletter_problem` (
  `problem_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Problem Id',
  `subscriber_id` int(10) unsigned DEFAULT NULL COMMENT 'Subscriber Id',
  `queue_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Queue Id',
  `problem_error_code` int(10) unsigned DEFAULT '0' COMMENT 'Problem Error Code',
  `problem_error_text` varchar(200) DEFAULT NULL COMMENT 'Problem Error Text',
  PRIMARY KEY (`problem_id`),
  KEY `NEWSLETTER_PROBLEM_SUBSCRIBER_ID` (`subscriber_id`),
  KEY `NEWSLETTER_PROBLEM_QUEUE_ID` (`queue_id`),
  CONSTRAINT `NEWSLETTER_PROBLEM_QUEUE_ID_NEWSLETTER_QUEUE_QUEUE_ID` FOREIGN KEY (`queue_id`) REFERENCES `newsletter_queue` (`queue_id`) ON DELETE CASCADE,
  CONSTRAINT `NLTTR_PROBLEM_SUBSCRIBER_ID_NLTTR_SUBSCRIBER_SUBSCRIBER_ID` FOREIGN KEY (`subscriber_id`) REFERENCES `newsletter_subscriber` (`subscriber_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Newsletter Problems';


DROP TABLE IF EXISTS `newsletter_queue`;
CREATE TABLE `newsletter_queue` (
  `queue_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Queue Id',
  `template_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Template ID',
  `newsletter_type` int(11) DEFAULT NULL COMMENT 'Newsletter Type',
  `newsletter_text` text COMMENT 'Newsletter Text',
  `newsletter_styles` text COMMENT 'Newsletter Styles',
  `newsletter_subject` varchar(200) DEFAULT NULL COMMENT 'Newsletter Subject',
  `newsletter_sender_name` varchar(200) DEFAULT NULL COMMENT 'Newsletter Sender Name',
  `newsletter_sender_email` varchar(200) DEFAULT NULL COMMENT 'Newsletter Sender Email',
  `queue_status` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Queue Status',
  `queue_start_at` timestamp NULL DEFAULT NULL COMMENT 'Queue Start At',
  `queue_finish_at` timestamp NULL DEFAULT NULL COMMENT 'Queue Finish At',
  PRIMARY KEY (`queue_id`),
  KEY `NEWSLETTER_QUEUE_TEMPLATE_ID` (`template_id`),
  CONSTRAINT `NEWSLETTER_QUEUE_TEMPLATE_ID_NEWSLETTER_TEMPLATE_TEMPLATE_ID` FOREIGN KEY (`template_id`) REFERENCES `newsletter_template` (`template_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Newsletter Queue';


DROP TABLE IF EXISTS `newsletter_queue_link`;
CREATE TABLE `newsletter_queue_link` (
  `queue_link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Queue Link Id',
  `queue_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Queue Id',
  `subscriber_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Subscriber Id',
  `letter_sent_at` timestamp NULL DEFAULT NULL COMMENT 'Letter Sent At',
  PRIMARY KEY (`queue_link_id`),
  KEY `NEWSLETTER_QUEUE_LINK_SUBSCRIBER_ID` (`subscriber_id`),
  KEY `NEWSLETTER_QUEUE_LINK_QUEUE_ID_LETTER_SENT_AT` (`queue_id`,`letter_sent_at`),
  CONSTRAINT `NEWSLETTER_QUEUE_LINK_QUEUE_ID_NEWSLETTER_QUEUE_QUEUE_ID` FOREIGN KEY (`queue_id`) REFERENCES `newsletter_queue` (`queue_id`) ON DELETE CASCADE,
  CONSTRAINT `NLTTR_QUEUE_LNK_SUBSCRIBER_ID_NLTTR_SUBSCRIBER_SUBSCRIBER_ID` FOREIGN KEY (`subscriber_id`) REFERENCES `newsletter_subscriber` (`subscriber_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Newsletter Queue Link';


DROP TABLE IF EXISTS `newsletter_queue_store_link`;
CREATE TABLE `newsletter_queue_store_link` (
  `queue_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Queue Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  PRIMARY KEY (`queue_id`,`store_id`),
  KEY `NEWSLETTER_QUEUE_STORE_LINK_STORE_ID` (`store_id`),
  CONSTRAINT `NEWSLETTER_QUEUE_STORE_LINK_QUEUE_ID_NEWSLETTER_QUEUE_QUEUE_ID` FOREIGN KEY (`queue_id`) REFERENCES `newsletter_queue` (`queue_id`) ON DELETE CASCADE,
  CONSTRAINT `NEWSLETTER_QUEUE_STORE_LINK_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Newsletter Queue Store Link';


DROP TABLE IF EXISTS `newsletter_subscriber`;
CREATE TABLE `newsletter_subscriber` (
  `subscriber_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Subscriber Id',
  `store_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Store Id',
  `change_status_at` timestamp NULL DEFAULT NULL COMMENT 'Change Status At',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Id',
  `subscriber_email` varchar(150) DEFAULT NULL COMMENT 'Subscriber Email',
  `subscriber_status` int(11) NOT NULL DEFAULT '0' COMMENT 'Subscriber Status',
  `subscriber_confirm_code` varchar(32) DEFAULT 'NULL' COMMENT 'Subscriber Confirm Code',
  PRIMARY KEY (`subscriber_id`),
  KEY `NEWSLETTER_SUBSCRIBER_CUSTOMER_ID` (`customer_id`),
  KEY `NEWSLETTER_SUBSCRIBER_STORE_ID` (`store_id`),
  KEY `NEWSLETTER_SUBSCRIBER_SUBSCRIBER_EMAIL` (`subscriber_email`),
  CONSTRAINT `NEWSLETTER_SUBSCRIBER_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Newsletter Subscriber';


DROP TABLE IF EXISTS `newsletter_template`;
CREATE TABLE `newsletter_template` (
  `template_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Template ID',
  `template_code` varchar(150) DEFAULT NULL COMMENT 'Template Code',
  `template_text` text COMMENT 'Template Text',
  `template_styles` text COMMENT 'Template Styles',
  `template_type` int(10) unsigned DEFAULT NULL COMMENT 'Template Type',
  `template_subject` varchar(200) DEFAULT NULL COMMENT 'Template Subject',
  `template_sender_name` varchar(200) DEFAULT NULL COMMENT 'Template Sender Name',
  `template_sender_email` varchar(200) DEFAULT NULL COMMENT 'Template Sender Email',
  `template_actual` smallint(5) unsigned DEFAULT '1' COMMENT 'Template Actual',
  `added_at` timestamp NULL DEFAULT NULL COMMENT 'Added At',
  `modified_at` timestamp NULL DEFAULT NULL COMMENT 'Modified At',
  PRIMARY KEY (`template_id`),
  KEY `NEWSLETTER_TEMPLATE_TEMPLATE_ACTUAL` (`template_actual`),
  KEY `NEWSLETTER_TEMPLATE_ADDED_AT` (`added_at`),
  KEY `NEWSLETTER_TEMPLATE_MODIFIED_AT` (`modified_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Newsletter Template';


DROP TABLE IF EXISTS `oauth_consumer`;
CREATE TABLE `oauth_consumer` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT 'Updated At',
  `name` varchar(255) NOT NULL COMMENT 'Name of consumer',
  `key` varchar(32) NOT NULL COMMENT 'Key code',
  `secret` varchar(32) NOT NULL COMMENT 'Secret code',
  `callback_url` text COMMENT 'Callback URL',
  `rejected_callback_url` text NOT NULL COMMENT 'Rejected callback URL',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `OAUTH_CONSUMER_KEY` (`key`),
  UNIQUE KEY `OAUTH_CONSUMER_SECRET` (`secret`),
  KEY `OAUTH_CONSUMER_CREATED_AT` (`created_at`),
  KEY `OAUTH_CONSUMER_UPDATED_AT` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='OAuth Consumers';


DROP TABLE IF EXISTS `oauth_nonce`;
CREATE TABLE `oauth_nonce` (
  `nonce` varchar(32) NOT NULL COMMENT 'Nonce String',
  `timestamp` int(10) unsigned NOT NULL COMMENT 'Nonce Timestamp',
  `consumer_id` int(10) unsigned NOT NULL COMMENT 'Consumer ID',
  UNIQUE KEY `OAUTH_NONCE_NONCE_CONSUMER_ID` (`nonce`,`consumer_id`),
  KEY `OAUTH_NONCE_CONSUMER_ID_OAUTH_CONSUMER_ENTITY_ID` (`consumer_id`),
  KEY `OAUTH_NONCE_TIMESTAMP` (`timestamp`),
  CONSTRAINT `OAUTH_NONCE_CONSUMER_ID_OAUTH_CONSUMER_ENTITY_ID` FOREIGN KEY (`consumer_id`) REFERENCES `oauth_consumer` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='OAuth Nonce';


DROP TABLE IF EXISTS `oauth_token`;
CREATE TABLE `oauth_token` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `consumer_id` int(10) unsigned DEFAULT NULL COMMENT 'Oauth Consumer ID',
  `admin_id` int(10) unsigned DEFAULT NULL COMMENT 'Admin user ID',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer user ID',
  `type` varchar(16) NOT NULL COMMENT 'Token Type',
  `token` varchar(32) NOT NULL COMMENT 'Token',
  `secret` varchar(32) NOT NULL COMMENT 'Token Secret',
  `verifier` varchar(32) DEFAULT NULL COMMENT 'Token Verifier',
  `callback_url` text NOT NULL COMMENT 'Token Callback URL',
  `revoked` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Token revoked',
  `authorized` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Token authorized',
  `user_type` int(11) DEFAULT NULL COMMENT 'User type',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Token creation timestamp',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `OAUTH_TOKEN_TOKEN` (`token`),
  KEY `OAUTH_TOKEN_ADMIN_ID_ADMIN_USER_USER_ID` (`admin_id`),
  KEY `OAUTH_TOKEN_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` (`customer_id`),
  KEY `OAUTH_TOKEN_CONSUMER_ID` (`consumer_id`),
  CONSTRAINT `OAUTH_TOKEN_ADMIN_ID_ADMIN_USER_USER_ID` FOREIGN KEY (`admin_id`) REFERENCES `admin_user` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `OAUTH_TOKEN_CONSUMER_ID_OAUTH_CONSUMER_ENTITY_ID` FOREIGN KEY (`consumer_id`) REFERENCES `oauth_consumer` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `OAUTH_TOKEN_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='OAuth Tokens';


DROP TABLE IF EXISTS `oauth_token_request_log`;
CREATE TABLE `oauth_token_request_log` (
  `log_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Log Id',
  `user_name` varchar(255) NOT NULL COMMENT 'Customer email or admin login',
  `user_type` smallint(5) unsigned NOT NULL COMMENT 'User type (admin or customer)',
  `failures_count` smallint(5) unsigned DEFAULT '0' COMMENT 'Number of failed authentication attempts in a row',
  `lock_expires_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Lock expiration time',
  PRIMARY KEY (`log_id`),
  UNIQUE KEY `OAUTH_TOKEN_REQUEST_LOG_USER_NAME_USER_TYPE` (`user_name`,`user_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Log of token request authentication failures.';


DROP TABLE IF EXISTS `password_reset_request_event`;
CREATE TABLE `password_reset_request_event` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `request_type` smallint(5) unsigned NOT NULL COMMENT 'Type of the event under a security control',
  `account_reference` varchar(255) DEFAULT NULL COMMENT 'An identifier for existing account or another target',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Timestamp when the event occurs',
  `ip` varchar(15) NOT NULL COMMENT 'Remote user IP',
  PRIMARY KEY (`id`),
  KEY `PASSWORD_RESET_REQUEST_EVENT_ACCOUNT_REFERENCE` (`account_reference`),
  KEY `PASSWORD_RESET_REQUEST_EVENT_CREATED_AT` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Password Reset Request Event under a security control';


DROP TABLE IF EXISTS `patch_list`;
CREATE TABLE `patch_list` (
  `patch_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Patch Auto Increment',
  `patch_name` varchar(1024) NOT NULL COMMENT 'Patch Class Name',
  PRIMARY KEY (`patch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='List of data/schema patches';

INSERT INTO `patch_list` (`patch_id`, `patch_name`) VALUES
(1,	'Magento\\Store\\Setup\\Patch\\Schema\\InitializeStoresAndWebsites'),
(2,	'Magento\\Catalog\\Setup\\Patch\\Schema\\EnableSegmentation'),
(3,	'Magento\\InventoryCatalog\\Setup\\Patch\\Schema\\CreateLegacyStockStatusView'),
(4,	'Magento\\InventoryCatalog\\Setup\\Patch\\Schema\\InitializeDefaultStock'),
(5,	'Magento\\InventoryCatalog\\Setup\\Patch\\Schema\\UpdateInventorySourceItem'),
(6,	'Magento\\InventoryCatalog\\Setup\\Patch\\Schema\\ReindexDefaultSource'),
(7,	'Magento\\Store\\Setup\\Patch\\Schema\\InitializeStoresAndWebsites'),
(8,	'Magento\\InventorySales\\Setup\\Patch\\Schema\\InitializeWebsiteDefaultSock'),
(9,	'Magento\\Bundle\\Setup\\Patch\\Schema\\UpdateBundleRelatedSchema'),
(10,	'Magento\\Store\\Setup\\Patch\\Data\\UpdateStoreGroupCodes'),
(11,	'Magento\\Directory\\Setup\\Patch\\Data\\InitializeDirectoryData'),
(12,	'Magento\\Directory\\Setup\\Patch\\Data\\AddDataForCroatia'),
(13,	'Magento\\Directory\\Setup\\Patch\\Data\\AddDataForIndia'),
(14,	'Magento\\Theme\\Setup\\Patch\\Data\\RegisterThemes'),
(15,	'Magento\\Theme\\Setup\\Patch\\Data\\ConvertSerializedData'),
(16,	'Magento\\Eav\\Setup\\Patch\\Data\\InitializeAttributeModels'),
(17,	'Magento\\Config\\Setup\\Patch\\Data\\UpdateClassAliases'),
(18,	'Magento\\Indexer\\Setup\\Patch\\Data\\InitializeIndexerState'),
(19,	'Magento\\User\\Setup\\Patch\\Data\\UpgradePasswordHashes'),
(20,	'Magento\\User\\Setup\\Patch\\Data\\UpgradeSerializedFields'),
(21,	'Magento\\Authorization\\Setup\\Patch\\Data\\InitializeAuthRoles'),
(22,	'Magento\\Customer\\Setup\\Patch\\Data\\DefaultCustomerGroupsAndAttributes'),
(23,	'Magento\\Customer\\Setup\\Patch\\Data\\UpdateCustomerAttributesMetadata'),
(24,	'Magento\\Customer\\Setup\\Patch\\Data\\AddNonSpecifiedGenderAttributeOption'),
(25,	'Magento\\Customer\\Setup\\Patch\\Data\\UpdateIdentifierCustomerAttributesVisibility'),
(26,	'Magento\\Customer\\Setup\\Patch\\Data\\AddCustomerUpdatedAtAttribute'),
(27,	'Magento\\Customer\\Setup\\Patch\\Data\\UpgradePasswordHashAndAddress'),
(28,	'Magento\\Customer\\Setup\\Patch\\Data\\RemoveCheckoutRegisterAndUpdateAttributes'),
(29,	'Magento\\Customer\\Setup\\Patch\\Data\\AddSecurityTrackingAttributes'),
(30,	'Magento\\Customer\\Setup\\Patch\\Data\\UpdateAutocompleteOnStorefrontConfigPath'),
(31,	'Magento\\Customer\\Setup\\Patch\\Data\\MigrateStoresAllowedCountriesToWebsite'),
(32,	'Magento\\Customer\\Setup\\Patch\\Data\\ConvertValidationRulesFromSerializedToJson'),
(33,	'Magento\\Customer\\Setup\\Patch\\Data\\UpdateVATNumber'),
(34,	'Magento\\Customer\\Setup\\Patch\\Data\\UpdateCustomerAttributeInputFilters'),
(35,	'Magento\\Cms\\Setup\\Patch\\Data\\CreateDefaultPages'),
(36,	'Magento\\Cms\\Setup\\Patch\\Data\\UpdatePrivacyPolicyPage'),
(37,	'Magento\\Cms\\Setup\\Patch\\Data\\ConvertWidgetConditionsToJson'),
(38,	'Magento\\Catalog\\Setup\\Patch\\Data\\InstallDefaultCategories'),
(39,	'Magento\\Catalog\\Setup\\Patch\\Data\\SetNewResourceModelsPaths'),
(40,	'Magento\\Catalog\\Setup\\Patch\\Data\\UpdateDefaultAttributeValue'),
(41,	'Magento\\Catalog\\Setup\\Patch\\Data\\UpdateMediaAttributesBackendTypes'),
(42,	'Magento\\Catalog\\Setup\\Patch\\Data\\UpdateProductAttributes'),
(43,	'Magento\\Catalog\\Setup\\Patch\\Data\\UpdateProductMetaDescription'),
(44,	'Magento\\Catalog\\Setup\\Patch\\Data\\ChangePriceAttributeDefaultScope'),
(45,	'Magento\\Catalog\\Setup\\Patch\\Data\\DisallowUsingHtmlForProductName'),
(46,	'Magento\\Catalog\\Setup\\Patch\\Data\\EnableDirectiveParsing'),
(47,	'Magento\\Catalog\\Setup\\Patch\\Data\\EnableSegmentation'),
(48,	'Magento\\Catalog\\Setup\\Patch\\Data\\UpgradeWidgetData'),
(49,	'Magento\\Catalog\\Setup\\Patch\\Data\\UpgradeWebsiteAttributes'),
(50,	'Magento\\Quote\\Setup\\Patch\\Data\\InstallEntityTypes'),
(51,	'Magento\\Quote\\Setup\\Patch\\Data\\ConvertSerializedDataToJson'),
(52,	'Magento\\Integration\\Setup\\Patch\\Data\\RemoveInactiveTokens'),
(53,	'Magento\\CatalogInventory\\Setup\\Patch\\Data\\CreateDefaultStock'),
(54,	'Magento\\CatalogInventory\\Setup\\Patch\\Data\\UpdateStockItemsWebsite'),
(55,	'Magento\\CatalogInventory\\Setup\\Patch\\Data\\ConvertSerializedDataToJson'),
(56,	'Magento\\Msrp\\Setup\\Patch\\Data\\InitializeMsrpAttributes'),
(57,	'Magento\\Msrp\\Setup\\Patch\\Data\\ChangePriceAttributeDefaultScope'),
(58,	'Magento\\CatalogRule\\Setup\\Patch\\Data\\UpdateClassAliasesForCatalogRules'),
(59,	'Magento\\CatalogRule\\Setup\\Patch\\Data\\ConvertSerializedDataToJson'),
(60,	'Magento\\CatalogUrlRewrite\\Setup\\Patch\\Data\\CreateUrlAttributes'),
(61,	'Magento\\Widget\\Setup\\Patch\\Data\\UpgradeModelInstanceClassAliases'),
(62,	'Magento\\Widget\\Setup\\Patch\\Data\\ConvertSerializedData'),
(63,	'Magento\\Sales\\Setup\\Patch\\Data\\InstallOrderStatusesAndInitialSalesConfig'),
(64,	'Magento\\Sales\\Setup\\Patch\\Data\\UpdateEntityTypes'),
(65,	'Magento\\Sales\\Setup\\Patch\\Data\\ConvertSerializedDataToJson'),
(66,	'Magento\\Sales\\Setup\\Patch\\Data\\FillQuoteAddressIdInSalesOrderAddress'),
(67,	'Magento\\Sales\\Setup\\Patch\\Data\\UpdateEntityTypeModelForInvoice'),
(68,	'Magento\\Checkout\\Setup\\Patch\\Data\\PrepareInitialCheckoutConfiguration'),
(69,	'Magento\\Vault\\Setup\\Patch\\Data\\SetCreditCardAsDefaultTokenType'),
(70,	'Magento\\ConfigurableProduct\\Setup\\Patch\\Data\\InstallInitialConfigurableAttributes'),
(71,	'Magento\\ConfigurableProduct\\Setup\\Patch\\Data\\UpdateManufacturerAttribute'),
(72,	'Magento\\ConfigurableProduct\\Setup\\Patch\\Data\\UpdateTierPriceAttribute'),
(73,	'Magento\\CurrencySymbol\\Setup\\Patch\\Data\\ConvertSerializedCustomCurrencySymbolToJson'),
(74,	'Magento\\Paypal\\Setup\\Patch\\Data\\AddPaypalOrderStatuses'),
(75,	'Magento\\Analytics\\Setup\\Patch\\Data\\PrepareInitialConfig'),
(76,	'Magento\\Dhl\\Setup\\Patch\\Data\\PrepareShipmentDays'),
(77,	'Magento\\Downloadable\\Setup\\Patch\\Data\\InstallDownloadableAttributes'),
(78,	'Magento\\CatalogSearch\\Setup\\Patch\\Data\\MySQLSearchDeprecationNotification'),
(79,	'Magento\\CatalogSearch\\Setup\\Patch\\Data\\SetInitialSearchWeightForAttributes'),
(80,	'Magento\\EncryptionKey\\Setup\\Patch\\Data\\SodiumChachaPatch'),
(81,	'Magento\\Fedex\\Setup\\Patch\\Data\\ConfigureFedexDefaults'),
(82,	'Magento\\GiftMessage\\Setup\\Patch\\Data\\AddGiftMessageAttributes'),
(83,	'Magento\\GiftMessage\\Setup\\Patch\\Data\\MoveGiftMessageToGiftOptionsGroup'),
(84,	'Magento\\GiftMessage\\Setup\\Patch\\Data\\UpdateGiftMessageAttribute'),
(85,	'Magento\\GroupedProduct\\Setup\\Patch\\Data\\InitializeGroupedProductLinks'),
(86,	'Magento\\GroupedProduct\\Setup\\Patch\\Data\\UpdateProductRelations'),
(87,	'Magento\\Braintree\\Setup\\Patch\\Data\\ConvertSerializedDataToJson'),
(88,	'Magento\\InventoryLowQuantityNotification\\Setup\\Patch\\Data\\MigrateCatalogInventoryNotifyStockQuantityData'),
(89,	'Magento\\SalesRule\\Setup\\Patch\\Data\\PrepareRuleModelSerializedData'),
(90,	'Magento\\SalesRule\\Setup\\Patch\\Data\\ConvertSerializedDataToJson'),
(91,	'Magento\\SalesRule\\Setup\\Patch\\Data\\FillSalesRuleProductAttributeTable'),
(92,	'Magento\\Reports\\Setup\\Patch\\Data\\InitializeReportEntityTypesAndPages'),
(93,	'Magento\\Review\\Setup\\Patch\\Data\\InitReviewStatusesAndData'),
(94,	'Magento\\OfflineShipping\\Setup\\Patch\\Data\\UpdateQuoteShippingAddresses'),
(95,	'Magento\\UrlRewrite\\Setup\\Patch\\Data\\ConvertSerializedDataToJson'),
(96,	'Magento\\Wishlist\\Setup\\Patch\\Data\\ConvertSerializedData'),
(97,	'Magento\\Swatches\\Setup\\Patch\\Data\\AddSwatchImageAttribute'),
(98,	'Magento\\Swatches\\Setup\\Patch\\Data\\AddSwatchImageToDefaultAttribtueSet'),
(99,	'Magento\\Swatches\\Setup\\Patch\\Data\\UpdateAdminTextSwatchValues'),
(100,	'Magento\\Swatches\\Setup\\Patch\\Data\\ConvertAdditionalDataToJson'),
(101,	'Magento\\Tax\\Setup\\Patch\\Data\\AddTaxAttributeAndTaxClasses'),
(102,	'Magento\\Tax\\Setup\\Patch\\Data\\UpdateTaxClassAttributeVisibility'),
(103,	'Magento\\Tax\\Setup\\Patch\\Data\\UpdateTaxRegionId'),
(104,	'Magento\\SampleData\\Setup\\Patch\\Data\\ClearSampleDataState'),
(105,	'Magento\\Usps\\Setup\\Patch\\Data\\UpdateAllowedMethods'),
(106,	'Magento\\Bundle\\Setup\\Patch\\Data\\ApplyAttributesUpdate'),
(107,	'Magento\\Bundle\\Setup\\Patch\\Data\\UpdateBundleRelatedEntityTytpes'),
(108,	'Magento\\Weee\\Setup\\Patch\\Data\\InitQuoteAndOrderAttributes');

DROP TABLE IF EXISTS `paypal_billing_agreement`;
CREATE TABLE `paypal_billing_agreement` (
  `agreement_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Agreement Id',
  `customer_id` int(10) unsigned NOT NULL COMMENT 'Customer Id',
  `method_code` varchar(32) NOT NULL COMMENT 'Method Code',
  `reference_id` varchar(32) NOT NULL COMMENT 'Reference Id',
  `status` varchar(20) NOT NULL COMMENT 'Status',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `agreement_label` varchar(255) DEFAULT NULL COMMENT 'Agreement Label',
  PRIMARY KEY (`agreement_id`),
  KEY `PAYPAL_BILLING_AGREEMENT_CUSTOMER_ID` (`customer_id`),
  KEY `PAYPAL_BILLING_AGREEMENT_STORE_ID` (`store_id`),
  CONSTRAINT `PAYPAL_BILLING_AGREEMENT_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `PAYPAL_BILLING_AGREEMENT_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Billing Agreement';


DROP TABLE IF EXISTS `paypal_billing_agreement_order`;
CREATE TABLE `paypal_billing_agreement_order` (
  `agreement_id` int(10) unsigned NOT NULL COMMENT 'Agreement Id',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  PRIMARY KEY (`agreement_id`,`order_id`),
  KEY `PAYPAL_BILLING_AGREEMENT_ORDER_ORDER_ID` (`order_id`),
  CONSTRAINT `PAYPAL_BILLING_AGREEMENT_ORDER_ORDER_ID_SALES_ORDER_ENTITY_ID` FOREIGN KEY (`order_id`) REFERENCES `sales_order` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `PAYPAL_BILLING_AGRT_ORDER_AGRT_ID_PAYPAL_BILLING_AGRT_AGRT_ID` FOREIGN KEY (`agreement_id`) REFERENCES `paypal_billing_agreement` (`agreement_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Billing Agreement Order';


DROP TABLE IF EXISTS `paypal_cert`;
CREATE TABLE `paypal_cert` (
  `cert_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Cert Id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `content` text COMMENT 'Content',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  PRIMARY KEY (`cert_id`),
  KEY `PAYPAL_CERT_WEBSITE_ID` (`website_id`),
  CONSTRAINT `PAYPAL_CERT_WEBSITE_ID_STORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Paypal Certificate Table';


DROP TABLE IF EXISTS `paypal_payment_transaction`;
CREATE TABLE `paypal_payment_transaction` (
  `transaction_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `txn_id` varchar(100) DEFAULT NULL COMMENT 'Txn Id',
  `additional_information` blob COMMENT 'Additional Information',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  PRIMARY KEY (`transaction_id`),
  UNIQUE KEY `PAYPAL_PAYMENT_TRANSACTION_TXN_ID` (`txn_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='PayPal Payflow Link Payment Transaction';


DROP TABLE IF EXISTS `paypal_settlement_report`;
CREATE TABLE `paypal_settlement_report` (
  `report_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Report Id',
  `report_date` date DEFAULT NULL COMMENT 'Report Date',
  `account_id` varchar(64) DEFAULT NULL COMMENT 'Account Id',
  `filename` varchar(24) DEFAULT NULL COMMENT 'Filename',
  `last_modified` timestamp NULL DEFAULT NULL COMMENT 'Last Modified',
  PRIMARY KEY (`report_id`),
  UNIQUE KEY `PAYPAL_SETTLEMENT_REPORT_REPORT_DATE_ACCOUNT_ID` (`report_date`,`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Paypal Settlement Report Table';


DROP TABLE IF EXISTS `paypal_settlement_report_row`;
CREATE TABLE `paypal_settlement_report_row` (
  `row_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Row Id',
  `report_id` int(10) unsigned NOT NULL COMMENT 'Report Id',
  `transaction_id` varchar(19) DEFAULT NULL COMMENT 'Transaction Id',
  `invoice_id` varchar(127) DEFAULT NULL COMMENT 'Invoice Id',
  `paypal_reference_id` varchar(19) DEFAULT NULL COMMENT 'Paypal Reference Id',
  `paypal_reference_id_type` varchar(3) DEFAULT NULL COMMENT 'Paypal Reference Id Type',
  `transaction_event_code` varchar(5) DEFAULT NULL COMMENT 'Transaction Event Code',
  `transaction_initiation_date` timestamp NULL DEFAULT NULL COMMENT 'Transaction Initiation Date',
  `transaction_completion_date` timestamp NULL DEFAULT NULL COMMENT 'Transaction Completion Date',
  `transaction_debit_or_credit` varchar(2) NOT NULL DEFAULT 'CR' COMMENT 'Transaction Debit Or Credit',
  `gross_transaction_amount` decimal(20,6) NOT NULL DEFAULT '0.000000' COMMENT 'Gross Transaction Amount',
  `gross_transaction_currency` varchar(3) DEFAULT NULL COMMENT 'Gross Transaction Currency',
  `fee_debit_or_credit` varchar(2) DEFAULT NULL COMMENT 'Fee Debit Or Credit',
  `fee_amount` decimal(20,6) NOT NULL DEFAULT '0.000000' COMMENT 'Fee Amount',
  `fee_currency` varchar(3) DEFAULT NULL COMMENT 'Fee Currency',
  `custom_field` varchar(255) DEFAULT NULL COMMENT 'Custom Field',
  `consumer_id` varchar(127) DEFAULT NULL COMMENT 'Consumer Id',
  `payment_tracking_id` varchar(255) DEFAULT NULL COMMENT 'Payment Tracking ID',
  `store_id` varchar(50) DEFAULT NULL COMMENT 'Store ID',
  PRIMARY KEY (`row_id`),
  KEY `PAYPAL_SETTLEMENT_REPORT_ROW_REPORT_ID` (`report_id`),
  CONSTRAINT `FK_E183E488F593E0DE10C6EBFFEBAC9B55` FOREIGN KEY (`report_id`) REFERENCES `paypal_settlement_report` (`report_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Paypal Settlement Report Row Table';


DROP TABLE IF EXISTS `persistent_session`;
CREATE TABLE `persistent_session` (
  `persistent_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Session id',
  `key` varchar(50) NOT NULL COMMENT 'Unique cookie key',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website ID',
  `info` text COMMENT 'Session Data',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Updated At',
  PRIMARY KEY (`persistent_id`),
  UNIQUE KEY `PERSISTENT_SESSION_KEY` (`key`),
  UNIQUE KEY `PERSISTENT_SESSION_CUSTOMER_ID` (`customer_id`),
  KEY `PERSISTENT_SESSION_WEBSITE_ID_STORE_WEBSITE_WEBSITE_ID` (`website_id`),
  KEY `PERSISTENT_SESSION_UPDATED_AT` (`updated_at`),
  CONSTRAINT `PERSISTENT_SESSION_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `PERSISTENT_SESSION_WEBSITE_ID_STORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Persistent Session';


DROP TABLE IF EXISTS `product_alert_price`;
CREATE TABLE `product_alert_price` (
  `alert_price_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Product alert price id',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer id',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product id',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price amount',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website id',
  `add_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Product alert add date',
  `last_send_date` timestamp NULL DEFAULT NULL COMMENT 'Product alert last send date',
  `send_count` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Product alert send count',
  `status` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Product alert status',
  PRIMARY KEY (`alert_price_id`),
  KEY `PRODUCT_ALERT_PRICE_CUSTOMER_ID` (`customer_id`),
  KEY `PRODUCT_ALERT_PRICE_PRODUCT_ID` (`product_id`),
  KEY `PRODUCT_ALERT_PRICE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `PRODUCT_ALERT_PRICE_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `PRODUCT_ALERT_PRICE_PRODUCT_ID_CATALOG_PRODUCT_ENTITY_ENTITY_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `PRODUCT_ALERT_PRICE_WEBSITE_ID_STORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Product Alert Price';


DROP TABLE IF EXISTS `product_alert_stock`;
CREATE TABLE `product_alert_stock` (
  `alert_stock_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Product alert stock id',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer id',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website id',
  `add_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Product alert add date',
  `send_date` timestamp NULL DEFAULT NULL COMMENT 'Product alert send date',
  `send_count` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Send Count',
  `status` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Product alert status',
  PRIMARY KEY (`alert_stock_id`),
  KEY `PRODUCT_ALERT_STOCK_CUSTOMER_ID` (`customer_id`),
  KEY `PRODUCT_ALERT_STOCK_PRODUCT_ID` (`product_id`),
  KEY `PRODUCT_ALERT_STOCK_WEBSITE_ID` (`website_id`),
  CONSTRAINT `PRODUCT_ALERT_STOCK_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `PRODUCT_ALERT_STOCK_PRODUCT_ID_CATALOG_PRODUCT_ENTITY_ENTITY_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `PRODUCT_ALERT_STOCK_WEBSITE_ID_STORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Product Alert Stock';


DROP TABLE IF EXISTS `queue`;
CREATE TABLE `queue` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Queue ID',
  `name` varchar(255) DEFAULT NULL COMMENT 'Queue name',
  PRIMARY KEY (`id`),
  UNIQUE KEY `QUEUE_NAME` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table storing unique queues';


DROP TABLE IF EXISTS `queue_lock`;
CREATE TABLE `queue_lock` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Message ID',
  `message_code` varchar(255) NOT NULL DEFAULT '' COMMENT 'Message Code',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Created At',
  PRIMARY KEY (`id`),
  UNIQUE KEY `QUEUE_LOCK_MESSAGE_CODE` (`message_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Messages that were processed are inserted here to be locked.';


DROP TABLE IF EXISTS `queue_message`;
CREATE TABLE `queue_message` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Message ID',
  `topic_name` varchar(255) DEFAULT NULL COMMENT 'Message topic',
  `body` longtext COMMENT 'Message body',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Queue messages';


DROP TABLE IF EXISTS `queue_message_status`;
CREATE TABLE `queue_message_status` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Relation ID',
  `queue_id` int(10) unsigned NOT NULL COMMENT 'Queue ID',
  `message_id` bigint(20) unsigned NOT NULL COMMENT 'Message ID',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Updated At',
  `status` smallint(5) unsigned NOT NULL COMMENT 'Message status in particular queue',
  `number_of_trials` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Number of trials to processed failed message processing',
  PRIMARY KEY (`id`),
  UNIQUE KEY `QUEUE_MESSAGE_STATUS_QUEUE_ID_MESSAGE_ID` (`queue_id`,`message_id`),
  KEY `QUEUE_MESSAGE_STATUS_MESSAGE_ID_QUEUE_MESSAGE_ID` (`message_id`),
  KEY `QUEUE_MESSAGE_STATUS_STATUS_UPDATED_AT` (`status`,`updated_at`),
  CONSTRAINT `QUEUE_MESSAGE_STATUS_MESSAGE_ID_QUEUE_MESSAGE_ID` FOREIGN KEY (`message_id`) REFERENCES `queue_message` (`id`) ON DELETE CASCADE,
  CONSTRAINT `QUEUE_MESSAGE_STATUS_QUEUE_ID_QUEUE_ID` FOREIGN KEY (`queue_id`) REFERENCES `queue` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Relation table to keep associations between queues and messages';


DROP TABLE IF EXISTS `quote`;
CREATE TABLE `quote` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `converted_at` timestamp NULL DEFAULT NULL COMMENT 'Converted At',
  `is_active` smallint(5) unsigned DEFAULT '1' COMMENT 'Is Active',
  `is_virtual` smallint(5) unsigned DEFAULT '0' COMMENT 'Is Virtual',
  `is_multi_shipping` smallint(5) unsigned DEFAULT '0' COMMENT 'Is Multi Shipping',
  `items_count` int(10) unsigned DEFAULT '0' COMMENT 'Items Count',
  `items_qty` decimal(12,4) DEFAULT '0.0000' COMMENT 'Items Qty',
  `orig_order_id` int(10) unsigned DEFAULT '0' COMMENT 'Orig Order Id',
  `store_to_base_rate` decimal(12,4) DEFAULT '0.0000' COMMENT 'Store To Base Rate',
  `store_to_quote_rate` decimal(12,4) DEFAULT '0.0000' COMMENT 'Store To Quote Rate',
  `base_currency_code` varchar(255) DEFAULT NULL COMMENT 'Base Currency Code',
  `store_currency_code` varchar(255) DEFAULT NULL COMMENT 'Store Currency Code',
  `quote_currency_code` varchar(255) DEFAULT NULL COMMENT 'Quote Currency Code',
  `grand_total` decimal(12,4) DEFAULT '0.0000' COMMENT 'Grand Total',
  `base_grand_total` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Grand Total',
  `checkout_method` varchar(255) DEFAULT NULL COMMENT 'Checkout Method',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `customer_tax_class_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Tax Class Id',
  `customer_group_id` int(10) unsigned DEFAULT '0' COMMENT 'Customer Group Id',
  `customer_email` varchar(255) DEFAULT NULL COMMENT 'Customer Email',
  `customer_prefix` varchar(40) DEFAULT NULL COMMENT 'Customer Prefix',
  `customer_firstname` varchar(255) DEFAULT NULL COMMENT 'Customer Firstname',
  `customer_middlename` varchar(40) DEFAULT NULL COMMENT 'Customer Middlename',
  `customer_lastname` varchar(255) DEFAULT NULL COMMENT 'Customer Lastname',
  `customer_suffix` varchar(40) DEFAULT NULL COMMENT 'Customer Suffix',
  `customer_dob` datetime DEFAULT NULL COMMENT 'Customer Dob',
  `customer_note` varchar(255) DEFAULT NULL COMMENT 'Customer Note',
  `customer_note_notify` smallint(5) unsigned DEFAULT '1' COMMENT 'Customer Note Notify',
  `customer_is_guest` smallint(5) unsigned DEFAULT '0' COMMENT 'Customer Is Guest',
  `remote_ip` varchar(45) DEFAULT NULL COMMENT 'Remote Ip',
  `applied_rule_ids` varchar(255) DEFAULT NULL COMMENT 'Applied Rule Ids',
  `reserved_order_id` varchar(64) DEFAULT NULL COMMENT 'Reserved Order Id',
  `password_hash` varchar(255) DEFAULT NULL COMMENT 'Password Hash',
  `coupon_code` varchar(255) DEFAULT NULL COMMENT 'Coupon Code',
  `global_currency_code` varchar(255) DEFAULT NULL COMMENT 'Global Currency Code',
  `base_to_global_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Global Rate',
  `base_to_quote_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Quote Rate',
  `customer_taxvat` varchar(255) DEFAULT NULL COMMENT 'Customer Taxvat',
  `customer_gender` varchar(255) DEFAULT NULL COMMENT 'Customer Gender',
  `subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal',
  `base_subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal',
  `subtotal_with_discount` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal With Discount',
  `base_subtotal_with_discount` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal With Discount',
  `is_changed` int(10) unsigned DEFAULT NULL COMMENT 'Is Changed',
  `trigger_recollect` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Trigger Recollect',
  `ext_shipping_info` text COMMENT 'Ext Shipping Info',
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  `is_persistent` smallint(5) unsigned DEFAULT '0' COMMENT 'Is Quote Persistent',
  `bank_transaction_id` varchar(255) DEFAULT NULL COMMENT 'Bank Transaction Id',
  PRIMARY KEY (`entity_id`),
  KEY `QUOTE_CUSTOMER_ID_STORE_ID_IS_ACTIVE` (`customer_id`,`store_id`,`is_active`),
  KEY `QUOTE_STORE_ID` (`store_id`),
  CONSTRAINT `QUOTE_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote';

INSERT INTO `quote` (`entity_id`, `store_id`, `created_at`, `updated_at`, `converted_at`, `is_active`, `is_virtual`, `is_multi_shipping`, `items_count`, `items_qty`, `orig_order_id`, `store_to_base_rate`, `store_to_quote_rate`, `base_currency_code`, `store_currency_code`, `quote_currency_code`, `grand_total`, `base_grand_total`, `checkout_method`, `customer_id`, `customer_tax_class_id`, `customer_group_id`, `customer_email`, `customer_prefix`, `customer_firstname`, `customer_middlename`, `customer_lastname`, `customer_suffix`, `customer_dob`, `customer_note`, `customer_note_notify`, `customer_is_guest`, `remote_ip`, `applied_rule_ids`, `reserved_order_id`, `password_hash`, `coupon_code`, `global_currency_code`, `base_to_global_rate`, `base_to_quote_rate`, `customer_taxvat`, `customer_gender`, `subtotal`, `base_subtotal`, `subtotal_with_discount`, `base_subtotal_with_discount`, `is_changed`, `trigger_recollect`, `ext_shipping_info`, `gift_message_id`, `is_persistent`, `bank_transaction_id`) VALUES
(1,	1,	'2019-02-18 15:06:45',	'2019-02-18 15:10:17',	NULL,	0,	0,	0,	1,	1.0000,	0,	0.0000,	0.0000,	'USD',	'USD',	'USD',	15.0000,	15.0000,	NULL,	1,	3,	1,	'xnguyen@collinsharper.com',	NULL,	'xavi',	NULL,	'nguyen',	NULL,	NULL,	NULL,	1,	0,	'172.22.0.1',	NULL,	'000000001',	NULL,	NULL,	'USD',	1.0000,	1.0000,	NULL,	NULL,	10.0000,	10.0000,	10.0000,	10.0000,	1,	0,	NULL,	NULL,	0,	NULL),
(2,	1,	'2019-02-18 15:16:03',	'2019-02-18 15:16:53',	NULL,	0,	0,	0,	1,	1.0000,	0,	0.0000,	0.0000,	'USD',	'USD',	'USD',	15.0000,	15.0000,	NULL,	1,	3,	1,	'xnguyen@collinsharper.com',	NULL,	'xavi',	NULL,	'nguyen',	NULL,	NULL,	NULL,	1,	0,	'172.22.0.1',	NULL,	'000000002',	NULL,	NULL,	'USD',	1.0000,	1.0000,	NULL,	NULL,	10.0000,	10.0000,	10.0000,	10.0000,	1,	0,	NULL,	NULL,	0,	NULL),
(3,	1,	'2019-02-18 15:17:15',	'2019-02-18 15:18:11',	NULL,	0,	0,	0,	1,	1.0000,	0,	0.0000,	0.0000,	'USD',	'USD',	'USD',	15.0000,	15.0000,	NULL,	1,	3,	1,	'xnguyen@collinsharper.com',	NULL,	'xavi',	NULL,	'nguyen',	NULL,	NULL,	NULL,	1,	0,	'172.22.0.1',	NULL,	'000000003',	NULL,	NULL,	'USD',	1.0000,	1.0000,	NULL,	NULL,	10.0000,	10.0000,	10.0000,	10.0000,	1,	0,	NULL,	NULL,	0,	NULL),
(4,	1,	'2019-02-18 15:47:04',	'2019-02-18 15:47:18',	NULL,	1,	0,	0,	1,	1.0000,	0,	0.0000,	0.0000,	'USD',	'USD',	'USD',	15.0000,	15.0000,	NULL,	1,	3,	1,	'xnguyen@collinsharper.com',	NULL,	'xavi',	NULL,	'nguyen',	NULL,	NULL,	NULL,	1,	0,	'172.22.0.1',	NULL,	NULL,	NULL,	NULL,	'USD',	1.0000,	1.0000,	NULL,	NULL,	10.0000,	10.0000,	10.0000,	10.0000,	1,	0,	NULL,	NULL,	0,	NULL);

DROP TABLE IF EXISTS `quote_address`;
CREATE TABLE `quote_address` (
  `address_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Address Id',
  `quote_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quote Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT 'Updated At',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `save_in_address_book` smallint(6) DEFAULT '0' COMMENT 'Save In Address Book',
  `customer_address_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Address Id',
  `address_type` varchar(10) DEFAULT NULL COMMENT 'Address Type',
  `email` varchar(255) DEFAULT NULL COMMENT 'Email',
  `prefix` varchar(40) DEFAULT NULL COMMENT 'Prefix',
  `firstname` varchar(255) DEFAULT NULL,
  `middlename` varchar(40) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `suffix` varchar(40) DEFAULT NULL COMMENT 'Suffix',
  `company` varchar(255) DEFAULT NULL COMMENT 'Company',
  `street` varchar(255) DEFAULT NULL COMMENT 'Street',
  `city` varchar(255) DEFAULT NULL,
  `region` varchar(255) DEFAULT NULL,
  `region_id` int(10) unsigned DEFAULT NULL COMMENT 'Region Id',
  `postcode` varchar(20) DEFAULT NULL COMMENT 'Postcode',
  `country_id` varchar(30) DEFAULT NULL COMMENT 'Country Id',
  `telephone` varchar(255) DEFAULT NULL,
  `fax` varchar(255) DEFAULT NULL,
  `same_as_billing` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Same As Billing',
  `collect_shipping_rates` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Collect Shipping Rates',
  `shipping_method` varchar(120) DEFAULT NULL,
  `shipping_description` varchar(255) DEFAULT NULL COMMENT 'Shipping Description',
  `weight` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Weight',
  `subtotal` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal',
  `base_subtotal` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Subtotal',
  `subtotal_with_discount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal With Discount',
  `base_subtotal_with_discount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Subtotal With Discount',
  `tax_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Tax Amount',
  `base_tax_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Tax Amount',
  `shipping_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Shipping Amount',
  `base_shipping_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Shipping Amount',
  `shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Tax Amount',
  `base_shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Tax Amount',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount',
  `base_discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Discount Amount',
  `grand_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Grand Total',
  `base_grand_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Grand Total',
  `customer_notes` text COMMENT 'Customer Notes',
  `applied_taxes` text COMMENT 'Applied Taxes',
  `discount_description` varchar(255) DEFAULT NULL COMMENT 'Discount Description',
  `shipping_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Discount Amount',
  `base_shipping_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Discount Amount',
  `subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Incl Tax',
  `base_subtotal_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Total Incl Tax',
  `discount_tax_compensation_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Tax Compensation Amount',
  `base_discount_tax_compensation_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Tax Compensation Amount',
  `shipping_discount_tax_compensation_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Discount Tax Compensation Amount',
  `base_shipping_discount_tax_compensation_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Discount Tax Compensation Amount',
  `shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Incl Tax',
  `base_shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Incl Tax',
  `vat_id` text COMMENT 'Vat Id',
  `vat_is_valid` smallint(6) DEFAULT NULL COMMENT 'Vat Is Valid',
  `vat_request_id` text COMMENT 'Vat Request Id',
  `vat_request_date` text COMMENT 'Vat Request Date',
  `vat_request_success` smallint(6) DEFAULT NULL COMMENT 'Vat Request Success',
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  `free_shipping` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Free Shipping',
  PRIMARY KEY (`address_id`),
  KEY `QUOTE_ADDRESS_QUOTE_ID` (`quote_id`),
  CONSTRAINT `QUOTE_ADDRESS_QUOTE_ID_QUOTE_ENTITY_ID` FOREIGN KEY (`quote_id`) REFERENCES `quote` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Address';

INSERT INTO `quote_address` (`address_id`, `quote_id`, `created_at`, `updated_at`, `customer_id`, `save_in_address_book`, `customer_address_id`, `address_type`, `email`, `prefix`, `firstname`, `middlename`, `lastname`, `suffix`, `company`, `street`, `city`, `region`, `region_id`, `postcode`, `country_id`, `telephone`, `fax`, `same_as_billing`, `collect_shipping_rates`, `shipping_method`, `shipping_description`, `weight`, `subtotal`, `base_subtotal`, `subtotal_with_discount`, `base_subtotal_with_discount`, `tax_amount`, `base_tax_amount`, `shipping_amount`, `base_shipping_amount`, `shipping_tax_amount`, `base_shipping_tax_amount`, `discount_amount`, `base_discount_amount`, `grand_total`, `base_grand_total`, `customer_notes`, `applied_taxes`, `discount_description`, `shipping_discount_amount`, `base_shipping_discount_amount`, `subtotal_incl_tax`, `base_subtotal_total_incl_tax`, `discount_tax_compensation_amount`, `base_discount_tax_compensation_amount`, `shipping_discount_tax_compensation_amount`, `base_shipping_discount_tax_compensation_amnt`, `shipping_incl_tax`, `base_shipping_incl_tax`, `vat_id`, `vat_is_valid`, `vat_request_id`, `vat_request_date`, `vat_request_success`, `gift_message_id`, `free_shipping`) VALUES
(2,	1,	'2019-02-18 15:06:45',	'2019-02-18 15:10:11',	1,	1,	1,	'shipping',	'xnguyen@collinsharper.com',	NULL,	'phat',	NULL,	'nguyen',	NULL,	NULL,	'ho chi minh',	'ho chi minh',	NULL,	NULL,	'700000',	'VN',	'123213213',	NULL,	0,	0,	'flatrate_flatrate',	'Flat Rate - Fixed',	0.2000,	10.0000,	10.0000,	10.0000,	10.0000,	0.0000,	0.0000,	5.0000,	5.0000,	0.0000,	0.0000,	0.0000,	0.0000,	15.0000,	15.0000,	NULL,	'[]',	NULL,	0.0000,	0.0000,	10.0000,	10.0000,	0.0000,	0.0000,	0.0000,	NULL,	5.0000,	5.0000,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3,	1,	'2019-02-18 15:10:15',	'0000-00-00 00:00:00',	1,	NULL,	NULL,	'billing',	'xnguyen@collinsharper.com',	NULL,	'phat',	NULL,	'nguyen',	NULL,	NULL,	'ho chi minh',	'ho chi minh',	NULL,	NULL,	'700000',	'VN',	'123213213',	NULL,	0,	0,	NULL,	NULL,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	NULL,	'null',	NULL,	NULL,	NULL,	0.0000,	NULL,	0.0000,	0.0000,	0.0000,	NULL,	0.0000,	0.0000,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(5,	2,	'2019-02-18 15:16:03',	'2019-02-18 15:16:26',	1,	0,	1,	'shipping',	'xnguyen@collinsharper.com',	NULL,	'phat',	NULL,	'nguyen',	NULL,	NULL,	'ho chi minh',	'ho chi minh',	NULL,	NULL,	'700000',	'VN',	'123213213',	NULL,	0,	0,	'flatrate_flatrate',	'Flat Rate - Fixed',	0.2000,	10.0000,	10.0000,	10.0000,	10.0000,	0.0000,	0.0000,	5.0000,	5.0000,	0.0000,	0.0000,	0.0000,	0.0000,	15.0000,	15.0000,	NULL,	'[]',	NULL,	0.0000,	0.0000,	10.0000,	10.0000,	0.0000,	0.0000,	0.0000,	NULL,	5.0000,	5.0000,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(6,	2,	'2019-02-18 15:16:45',	'0000-00-00 00:00:00',	1,	NULL,	1,	'billing',	'xnguyen@collinsharper.com',	NULL,	'phat',	NULL,	'nguyen',	NULL,	NULL,	'ho chi minh',	'ho chi minh',	NULL,	NULL,	'700000',	'VN',	'123213213',	NULL,	0,	0,	NULL,	NULL,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	NULL,	'null',	NULL,	NULL,	NULL,	0.0000,	NULL,	0.0000,	0.0000,	0.0000,	NULL,	0.0000,	0.0000,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(8,	3,	'2019-02-18 15:17:15',	'2019-02-18 15:17:27',	1,	0,	1,	'shipping',	'xnguyen@collinsharper.com',	NULL,	'phat',	NULL,	'nguyen',	NULL,	NULL,	'ho chi minh',	'ho chi minh',	NULL,	NULL,	'700000',	'VN',	'123213213',	NULL,	0,	0,	'flatrate_flatrate',	'Flat Rate - Fixed',	0.2000,	10.0000,	10.0000,	10.0000,	10.0000,	0.0000,	0.0000,	5.0000,	5.0000,	0.0000,	0.0000,	0.0000,	0.0000,	15.0000,	15.0000,	NULL,	'[]',	NULL,	0.0000,	0.0000,	10.0000,	10.0000,	0.0000,	0.0000,	0.0000,	NULL,	5.0000,	5.0000,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(9,	3,	'2019-02-18 15:18:04',	'0000-00-00 00:00:00',	1,	NULL,	1,	'billing',	'xnguyen@collinsharper.com',	NULL,	'phat',	NULL,	'nguyen',	NULL,	NULL,	'ho chi minh',	'ho chi minh',	NULL,	NULL,	'700000',	'VN',	'123213213',	NULL,	0,	0,	NULL,	NULL,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	NULL,	'null',	NULL,	NULL,	NULL,	0.0000,	NULL,	0.0000,	0.0000,	0.0000,	NULL,	0.0000,	0.0000,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(10,	4,	'2019-02-18 15:47:04',	'0000-00-00 00:00:00',	1,	0,	1,	'billing',	'xnguyen@collinsharper.com',	NULL,	'phat',	NULL,	'nguyen',	NULL,	NULL,	'ho chi minh',	'ho chi minh',	NULL,	NULL,	'700000',	'VN',	'123213213',	NULL,	0,	0,	NULL,	NULL,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	NULL,	'null',	NULL,	NULL,	NULL,	0.0000,	NULL,	0.0000,	0.0000,	0.0000,	NULL,	0.0000,	0.0000,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(11,	4,	'2019-02-18 15:47:04',	'2019-02-18 15:47:18',	1,	0,	1,	'shipping',	'xnguyen@collinsharper.com',	NULL,	'phat',	NULL,	'nguyen',	NULL,	NULL,	'ho chi minh',	'ho chi minh',	NULL,	NULL,	'700000',	'VN',	'123213213',	NULL,	0,	0,	'flatrate_flatrate',	'Flat Rate - Fixed',	0.2000,	10.0000,	10.0000,	10.0000,	10.0000,	0.0000,	0.0000,	5.0000,	5.0000,	0.0000,	0.0000,	0.0000,	0.0000,	15.0000,	15.0000,	NULL,	'[]',	NULL,	0.0000,	0.0000,	10.0000,	10.0000,	0.0000,	0.0000,	0.0000,	NULL,	5.0000,	5.0000,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0);

DROP TABLE IF EXISTS `quote_address_item`;
CREATE TABLE `quote_address_item` (
  `address_item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Address Item Id',
  `parent_item_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Item Id',
  `quote_address_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quote Address Id',
  `quote_item_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quote Item Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT 'Updated At',
  `applied_rule_ids` text COMMENT 'Applied Rule Ids',
  `additional_data` text COMMENT 'Additional Data',
  `weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Weight',
  `qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty',
  `discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Amount',
  `tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Amount',
  `row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Row Total',
  `base_row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Row Total',
  `row_total_with_discount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Row Total With Discount',
  `base_discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Discount Amount',
  `base_tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Tax Amount',
  `row_weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Row Weight',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `super_product_id` int(10) unsigned DEFAULT NULL COMMENT 'Super Product Id',
  `parent_product_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Product Id',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  `image` varchar(255) DEFAULT NULL COMMENT 'Image',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `description` text COMMENT 'Description',
  `is_qty_decimal` int(10) unsigned DEFAULT NULL COMMENT 'Is Qty Decimal',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `discount_percent` decimal(12,4) DEFAULT NULL COMMENT 'Discount Percent',
  `no_discount` int(10) unsigned DEFAULT NULL COMMENT 'No Discount',
  `tax_percent` decimal(12,4) DEFAULT NULL COMMENT 'Tax Percent',
  `base_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Price',
  `base_cost` decimal(12,4) DEFAULT NULL COMMENT 'Base Cost',
  `price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Price Incl Tax',
  `base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Price Incl Tax',
  `row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Row Total Incl Tax',
  `base_row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total Incl Tax',
  `discount_tax_compensation_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Tax Compensation Amount',
  `base_discount_tax_compensation_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Tax Compensation Amount',
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  `free_shipping` int(10) unsigned DEFAULT NULL COMMENT 'Free Shipping',
  PRIMARY KEY (`address_item_id`),
  KEY `QUOTE_ADDRESS_ITEM_QUOTE_ADDRESS_ID` (`quote_address_id`),
  KEY `QUOTE_ADDRESS_ITEM_PARENT_ITEM_ID` (`parent_item_id`),
  KEY `QUOTE_ADDRESS_ITEM_QUOTE_ITEM_ID` (`quote_item_id`),
  CONSTRAINT `QUOTE_ADDRESS_ITEM_QUOTE_ADDRESS_ID_QUOTE_ADDRESS_ADDRESS_ID` FOREIGN KEY (`quote_address_id`) REFERENCES `quote_address` (`address_id`) ON DELETE CASCADE,
  CONSTRAINT `QUOTE_ADDRESS_ITEM_QUOTE_ITEM_ID_QUOTE_ITEM_ITEM_ID` FOREIGN KEY (`quote_item_id`) REFERENCES `quote_item` (`item_id`) ON DELETE CASCADE,
  CONSTRAINT `QUOTE_ADDR_ITEM_PARENT_ITEM_ID_QUOTE_ADDR_ITEM_ADDR_ITEM_ID` FOREIGN KEY (`parent_item_id`) REFERENCES `quote_address_item` (`address_item_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Address Item';


DROP TABLE IF EXISTS `quote_id_mask`;
CREATE TABLE `quote_id_mask` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `quote_id` int(10) unsigned NOT NULL COMMENT 'Quote ID',
  `masked_id` varchar(32) DEFAULT NULL COMMENT 'Masked ID',
  PRIMARY KEY (`entity_id`,`quote_id`),
  KEY `QUOTE_ID_MASK_QUOTE_ID` (`quote_id`),
  KEY `QUOTE_ID_MASK_MASKED_ID` (`masked_id`),
  CONSTRAINT `QUOTE_ID_MASK_QUOTE_ID_QUOTE_ENTITY_ID` FOREIGN KEY (`quote_id`) REFERENCES `quote` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Quote ID and masked ID mapping';


DROP TABLE IF EXISTS `quote_item`;
CREATE TABLE `quote_item` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Item Id',
  `quote_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quote Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT 'Updated At',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `parent_item_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Item Id',
  `is_virtual` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Virtual',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `description` text COMMENT 'Description',
  `applied_rule_ids` text COMMENT 'Applied Rule Ids',
  `additional_data` text COMMENT 'Additional Data',
  `is_qty_decimal` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Qty Decimal',
  `no_discount` smallint(5) unsigned DEFAULT '0' COMMENT 'No Discount',
  `weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Weight',
  `qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `base_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Price',
  `custom_price` decimal(12,4) DEFAULT NULL COMMENT 'Custom Price',
  `discount_percent` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Percent',
  `discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Amount',
  `base_discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Discount Amount',
  `tax_percent` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Percent',
  `tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Amount',
  `base_tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Tax Amount',
  `row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Row Total',
  `base_row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Row Total',
  `row_total_with_discount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Row Total With Discount',
  `row_weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Row Weight',
  `product_type` varchar(255) DEFAULT NULL COMMENT 'Product Type',
  `base_tax_before_discount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Before Discount',
  `tax_before_discount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Before Discount',
  `original_custom_price` decimal(12,4) DEFAULT NULL COMMENT 'Original Custom Price',
  `redirect_url` varchar(255) DEFAULT NULL COMMENT 'Redirect Url',
  `base_cost` decimal(12,4) DEFAULT NULL COMMENT 'Base Cost',
  `price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Price Incl Tax',
  `base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Price Incl Tax',
  `row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Row Total Incl Tax',
  `base_row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total Incl Tax',
  `discount_tax_compensation_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Tax Compensation Amount',
  `base_discount_tax_compensation_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Tax Compensation Amount',
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  `free_shipping` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Free Shipping',
  `weee_tax_applied` text COMMENT 'Weee Tax Applied',
  `weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Amount',
  `weee_tax_applied_row_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Row Amount',
  `weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Disposition',
  `weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Row Disposition',
  `base_weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Amount',
  `base_weee_tax_applied_row_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Row Amnt',
  `base_weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Disposition',
  `base_weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Row Disposition',
  PRIMARY KEY (`item_id`),
  KEY `QUOTE_ITEM_PARENT_ITEM_ID` (`parent_item_id`),
  KEY `QUOTE_ITEM_PRODUCT_ID` (`product_id`),
  KEY `QUOTE_ITEM_QUOTE_ID` (`quote_id`),
  KEY `QUOTE_ITEM_STORE_ID` (`store_id`),
  CONSTRAINT `QUOTE_ITEM_PARENT_ITEM_ID_QUOTE_ITEM_ITEM_ID` FOREIGN KEY (`parent_item_id`) REFERENCES `quote_item` (`item_id`) ON DELETE CASCADE,
  CONSTRAINT `QUOTE_ITEM_QUOTE_ID_QUOTE_ENTITY_ID` FOREIGN KEY (`quote_id`) REFERENCES `quote` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `QUOTE_ITEM_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Item';

INSERT INTO `quote_item` (`item_id`, `quote_id`, `created_at`, `updated_at`, `product_id`, `store_id`, `parent_item_id`, `is_virtual`, `sku`, `name`, `description`, `applied_rule_ids`, `additional_data`, `is_qty_decimal`, `no_discount`, `weight`, `qty`, `price`, `base_price`, `custom_price`, `discount_percent`, `discount_amount`, `base_discount_amount`, `tax_percent`, `tax_amount`, `base_tax_amount`, `row_total`, `base_row_total`, `row_total_with_discount`, `row_weight`, `product_type`, `base_tax_before_discount`, `tax_before_discount`, `original_custom_price`, `redirect_url`, `base_cost`, `price_incl_tax`, `base_price_incl_tax`, `row_total_incl_tax`, `base_row_total_incl_tax`, `discount_tax_compensation_amount`, `base_discount_tax_compensation_amount`, `gift_message_id`, `free_shipping`, `weee_tax_applied`, `weee_tax_applied_amount`, `weee_tax_applied_row_amount`, `weee_tax_disposition`, `weee_tax_row_disposition`, `base_weee_tax_applied_amount`, `base_weee_tax_applied_row_amnt`, `base_weee_tax_disposition`, `base_weee_tax_row_disposition`) VALUES
(1,	1,	'2019-02-18 15:09:47',	'0000-00-00 00:00:00',	1,	1,	NULL,	0,	'Simple Product 1',	'Simple Product 1',	NULL,	NULL,	NULL,	0,	0,	0.2000,	1.0000,	10.0000,	10.0000,	NULL,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	10.0000,	10.0000,	0.0000,	0.2000,	'simple',	NULL,	NULL,	NULL,	NULL,	NULL,	10.0000,	10.0000,	10.0000,	10.0000,	0.0000,	0.0000,	NULL,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(2,	2,	'2019-02-18 15:16:03',	'0000-00-00 00:00:00',	1,	1,	NULL,	0,	'Simple Product 1',	'Simple Product 1',	NULL,	NULL,	NULL,	0,	0,	0.2000,	1.0000,	10.0000,	10.0000,	NULL,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	10.0000,	10.0000,	0.0000,	0.2000,	'simple',	NULL,	NULL,	NULL,	NULL,	NULL,	10.0000,	10.0000,	10.0000,	10.0000,	0.0000,	0.0000,	NULL,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(3,	3,	'2019-02-18 15:17:15',	'0000-00-00 00:00:00',	1,	1,	NULL,	0,	'Simple Product 1',	'Simple Product 1',	NULL,	NULL,	NULL,	0,	0,	0.2000,	1.0000,	10.0000,	10.0000,	NULL,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	10.0000,	10.0000,	0.0000,	0.2000,	'simple',	NULL,	NULL,	NULL,	NULL,	NULL,	10.0000,	10.0000,	10.0000,	10.0000,	0.0000,	0.0000,	NULL,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(4,	4,	'2019-02-18 15:47:04',	'0000-00-00 00:00:00',	1,	1,	NULL,	0,	'Simple Product 1',	'Simple Product 1',	NULL,	NULL,	NULL,	0,	0,	0.2000,	1.0000,	10.0000,	10.0000,	NULL,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	10.0000,	10.0000,	0.0000,	0.2000,	'simple',	NULL,	NULL,	NULL,	NULL,	NULL,	10.0000,	10.0000,	10.0000,	10.0000,	0.0000,	0.0000,	NULL,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);

DROP TABLE IF EXISTS `quote_item_option`;
CREATE TABLE `quote_item_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Id',
  `item_id` int(10) unsigned NOT NULL COMMENT 'Item Id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `value` text COMMENT 'Value',
  PRIMARY KEY (`option_id`),
  KEY `QUOTE_ITEM_OPTION_ITEM_ID` (`item_id`),
  CONSTRAINT `QUOTE_ITEM_OPTION_ITEM_ID_QUOTE_ITEM_ITEM_ID` FOREIGN KEY (`item_id`) REFERENCES `quote_item` (`item_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Item Option';

INSERT INTO `quote_item_option` (`option_id`, `item_id`, `product_id`, `code`, `value`) VALUES
(1,	1,	1,	'info_buyRequest',	'{\"uenc\":\"aHR0cDovL21hZ2VudG8yMy5sb2NhbC8,\",\"product\":\"1\",\"qty\":1}'),
(2,	2,	1,	'info_buyRequest',	'{\"uenc\":\"aHR0cDovL21hZ2VudG8yMy5sb2NhbC8,\",\"product\":\"1\",\"qty\":1}'),
(3,	3,	1,	'info_buyRequest',	'{\"uenc\":\"aHR0cDovL21hZ2VudG8yMy5sb2NhbC8,\",\"product\":\"1\",\"qty\":1}'),
(4,	4,	1,	'info_buyRequest',	'{\"uenc\":\"aHR0cDovL21hZ2VudG8yMy5sb2NhbC8,\",\"product\":\"1\",\"qty\":1}');

DROP TABLE IF EXISTS `quote_payment`;
CREATE TABLE `quote_payment` (
  `payment_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Payment Id',
  `quote_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quote Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT 'Updated At',
  `method` varchar(255) DEFAULT NULL COMMENT 'Method',
  `cc_type` varchar(255) DEFAULT NULL COMMENT 'Cc Type',
  `cc_number_enc` varchar(255) DEFAULT NULL COMMENT 'Cc Number Enc',
  `cc_last_4` varchar(255) DEFAULT NULL COMMENT 'Cc Last 4',
  `cc_cid_enc` varchar(255) DEFAULT NULL COMMENT 'Cc Cid Enc',
  `cc_owner` varchar(255) DEFAULT NULL COMMENT 'Cc Owner',
  `cc_exp_month` varchar(255) DEFAULT NULL COMMENT 'Cc Exp Month',
  `cc_exp_year` smallint(5) unsigned DEFAULT '0' COMMENT 'Cc Exp Year',
  `cc_ss_owner` varchar(255) DEFAULT NULL COMMENT 'Cc Ss Owner',
  `cc_ss_start_month` smallint(5) unsigned DEFAULT '0' COMMENT 'Cc Ss Start Month',
  `cc_ss_start_year` smallint(5) unsigned DEFAULT '0' COMMENT 'Cc Ss Start Year',
  `po_number` varchar(255) DEFAULT NULL COMMENT 'Po Number',
  `additional_data` text COMMENT 'Additional Data',
  `cc_ss_issue` varchar(255) DEFAULT NULL COMMENT 'Cc Ss Issue',
  `additional_information` text COMMENT 'Additional Information',
  `paypal_payer_id` varchar(255) DEFAULT NULL COMMENT 'Paypal Payer Id',
  `paypal_payer_status` varchar(255) DEFAULT NULL COMMENT 'Paypal Payer Status',
  `paypal_correlation_id` varchar(255) DEFAULT NULL COMMENT 'Paypal Correlation Id',
  PRIMARY KEY (`payment_id`),
  KEY `QUOTE_PAYMENT_QUOTE_ID` (`quote_id`),
  CONSTRAINT `QUOTE_PAYMENT_QUOTE_ID_QUOTE_ENTITY_ID` FOREIGN KEY (`quote_id`) REFERENCES `quote` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Payment';

INSERT INTO `quote_payment` (`payment_id`, `quote_id`, `created_at`, `updated_at`, `method`, `cc_type`, `cc_number_enc`, `cc_last_4`, `cc_cid_enc`, `cc_owner`, `cc_exp_month`, `cc_exp_year`, `cc_ss_owner`, `cc_ss_start_month`, `cc_ss_start_year`, `po_number`, `additional_data`, `cc_ss_issue`, `additional_information`, `paypal_payer_id`, `paypal_payer_status`, `paypal_correlation_id`) VALUES
(1,	1,	'2019-02-18 15:10:15',	'0000-00-00 00:00:00',	'checkmo',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0,	NULL,	0,	0,	NULL,	NULL,	NULL,	'null',	NULL,	NULL,	NULL),
(2,	2,	'2019-02-18 15:16:45',	'0000-00-00 00:00:00',	'chmoneriscc',	'MC',	NULL,	'5454',	NULL,	NULL,	'1',	2023,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'null',	NULL,	NULL,	NULL),
(3,	3,	'2019-02-18 15:18:04',	'0000-00-00 00:00:00',	'chmoneriscc',	'MC',	NULL,	'5454',	NULL,	NULL,	'2',	2027,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'null',	NULL,	NULL,	NULL);

DROP TABLE IF EXISTS `quote_shipping_rate`;
CREATE TABLE `quote_shipping_rate` (
  `rate_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rate Id',
  `address_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Address Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT 'Updated At',
  `carrier` varchar(255) DEFAULT NULL COMMENT 'Carrier',
  `carrier_title` varchar(255) DEFAULT NULL COMMENT 'Carrier Title',
  `code` varchar(255) DEFAULT NULL COMMENT 'Code',
  `method` varchar(255) DEFAULT NULL COMMENT 'Method',
  `method_description` text COMMENT 'Method Description',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `error_message` text COMMENT 'Error Message',
  `method_title` text COMMENT 'Method Title',
  PRIMARY KEY (`rate_id`),
  KEY `QUOTE_SHIPPING_RATE_ADDRESS_ID` (`address_id`),
  CONSTRAINT `QUOTE_SHIPPING_RATE_ADDRESS_ID_QUOTE_ADDRESS_ADDRESS_ID` FOREIGN KEY (`address_id`) REFERENCES `quote_address` (`address_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Shipping Rate';

INSERT INTO `quote_shipping_rate` (`rate_id`, `address_id`, `created_at`, `updated_at`, `carrier`, `carrier_title`, `code`, `method`, `method_description`, `price`, `error_message`, `method_title`) VALUES
(2,	2,	'2019-02-18 15:10:15',	'0000-00-00 00:00:00',	'flatrate',	'Flat Rate',	'flatrate_flatrate',	'flatrate',	NULL,	5.0000,	NULL,	'Fixed'),
(4,	5,	'2019-02-18 15:16:45',	'0000-00-00 00:00:00',	'flatrate',	'Flat Rate',	'flatrate_flatrate',	'flatrate',	NULL,	5.0000,	NULL,	'Fixed'),
(6,	8,	'2019-02-18 15:18:03',	'0000-00-00 00:00:00',	'flatrate',	'Flat Rate',	'flatrate_flatrate',	'flatrate',	NULL,	5.0000,	NULL,	'Fixed'),
(7,	11,	'2019-02-18 15:47:18',	'0000-00-00 00:00:00',	'flatrate',	'Flat Rate',	'flatrate_flatrate',	'flatrate',	NULL,	5.0000,	NULL,	'Fixed');

DROP TABLE IF EXISTS `rating`;
CREATE TABLE `rating` (
  `rating_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rating Id',
  `entity_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `rating_code` varchar(64) NOT NULL COMMENT 'Rating Code',
  `position` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Position On Storefront',
  `is_active` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Rating is active.',
  PRIMARY KEY (`rating_id`),
  UNIQUE KEY `RATING_RATING_CODE` (`rating_code`),
  KEY `RATING_ENTITY_ID` (`entity_id`),
  CONSTRAINT `RATING_ENTITY_ID_RATING_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `rating_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Ratings';

INSERT INTO `rating` (`rating_id`, `entity_id`, `rating_code`, `position`, `is_active`) VALUES
(1,	1,	'Quality',	0,	1),
(2,	1,	'Value',	0,	1),
(3,	1,	'Price',	0,	1);

DROP TABLE IF EXISTS `rating_entity`;
CREATE TABLE `rating_entity` (
  `entity_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `entity_code` varchar(64) NOT NULL COMMENT 'Entity Code',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `RATING_ENTITY_ENTITY_CODE` (`entity_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Rating entities';

INSERT INTO `rating_entity` (`entity_id`, `entity_code`) VALUES
(1,	'product'),
(2,	'product_review'),
(3,	'review');

DROP TABLE IF EXISTS `rating_option`;
CREATE TABLE `rating_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rating Option Id',
  `rating_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Id',
  `code` varchar(32) NOT NULL COMMENT 'Rating Option Code',
  `value` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Option Value',
  `position` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Ration option position on Storefront',
  PRIMARY KEY (`option_id`),
  KEY `RATING_OPTION_RATING_ID` (`rating_id`),
  CONSTRAINT `RATING_OPTION_RATING_ID_RATING_RATING_ID` FOREIGN KEY (`rating_id`) REFERENCES `rating` (`rating_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Rating options';

INSERT INTO `rating_option` (`option_id`, `rating_id`, `code`, `value`, `position`) VALUES
(1,	1,	'1',	1,	1),
(2,	1,	'2',	2,	2),
(3,	1,	'3',	3,	3),
(4,	1,	'4',	4,	4),
(5,	1,	'5',	5,	5),
(6,	2,	'1',	1,	1),
(7,	2,	'2',	2,	2),
(8,	2,	'3',	3,	3),
(9,	2,	'4',	4,	4),
(10,	2,	'5',	5,	5),
(11,	3,	'1',	1,	1),
(12,	3,	'2',	2,	2),
(13,	3,	'3',	3,	3),
(14,	3,	'4',	4,	4),
(15,	3,	'5',	5,	5);

DROP TABLE IF EXISTS `rating_option_vote`;
CREATE TABLE `rating_option_vote` (
  `vote_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Vote id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Vote option id',
  `remote_ip` varchar(16) NOT NULL COMMENT 'Customer IP',
  `remote_ip_long` bigint(20) NOT NULL DEFAULT '0' COMMENT 'Customer IP converted to long integer format',
  `customer_id` int(10) unsigned DEFAULT '0' COMMENT 'Customer Id',
  `entity_pk_value` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Product id',
  `rating_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating id',
  `review_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Review id',
  `percent` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Percent amount',
  `value` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Vote option value',
  PRIMARY KEY (`vote_id`),
  KEY `RATING_OPTION_VOTE_REVIEW_ID_REVIEW_REVIEW_ID` (`review_id`),
  KEY `RATING_OPTION_VOTE_OPTION_ID` (`option_id`),
  CONSTRAINT `RATING_OPTION_VOTE_OPTION_ID_RATING_OPTION_OPTION_ID` FOREIGN KEY (`option_id`) REFERENCES `rating_option` (`option_id`) ON DELETE CASCADE,
  CONSTRAINT `RATING_OPTION_VOTE_REVIEW_ID_REVIEW_REVIEW_ID` FOREIGN KEY (`review_id`) REFERENCES `review` (`review_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Rating option values';


DROP TABLE IF EXISTS `rating_option_vote_aggregated`;
CREATE TABLE `rating_option_vote_aggregated` (
  `primary_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Vote aggregation id',
  `rating_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating id',
  `entity_pk_value` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Product id',
  `vote_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Vote dty',
  `vote_value_sum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'General vote sum',
  `percent` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Vote percent',
  `percent_approved` smallint(6) DEFAULT '0' COMMENT 'Vote percent approved by admin',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  PRIMARY KEY (`primary_id`),
  KEY `RATING_OPTION_VOTE_AGGREGATED_RATING_ID` (`rating_id`),
  KEY `RATING_OPTION_VOTE_AGGREGATED_STORE_ID` (`store_id`),
  CONSTRAINT `RATING_OPTION_VOTE_AGGREGATED_RATING_ID_RATING_RATING_ID` FOREIGN KEY (`rating_id`) REFERENCES `rating` (`rating_id`) ON DELETE CASCADE,
  CONSTRAINT `RATING_OPTION_VOTE_AGGREGATED_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Rating vote aggregated';


DROP TABLE IF EXISTS `rating_store`;
CREATE TABLE `rating_store` (
  `rating_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store id',
  PRIMARY KEY (`rating_id`,`store_id`),
  KEY `RATING_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `RATING_STORE_RATING_ID_RATING_RATING_ID` FOREIGN KEY (`rating_id`) REFERENCES `rating` (`rating_id`) ON DELETE CASCADE,
  CONSTRAINT `RATING_STORE_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Rating Store';


DROP TABLE IF EXISTS `rating_title`;
CREATE TABLE `rating_title` (
  `rating_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `value` varchar(255) NOT NULL COMMENT 'Rating Label',
  PRIMARY KEY (`rating_id`,`store_id`),
  KEY `RATING_TITLE_STORE_ID` (`store_id`),
  CONSTRAINT `RATING_TITLE_RATING_ID_RATING_RATING_ID` FOREIGN KEY (`rating_id`) REFERENCES `rating` (`rating_id`) ON DELETE CASCADE,
  CONSTRAINT `RATING_TITLE_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Rating Title';


DROP TABLE IF EXISTS `release_notification_viewer_log`;
CREATE TABLE `release_notification_viewer_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Log ID',
  `viewer_id` int(10) unsigned NOT NULL COMMENT 'Viewer admin user ID',
  `last_view_version` varchar(16) NOT NULL COMMENT 'Viewer last view on product version',
  PRIMARY KEY (`id`),
  UNIQUE KEY `RELEASE_NOTIFICATION_VIEWER_LOG_VIEWER_ID` (`viewer_id`),
  CONSTRAINT `RELEASE_NOTIFICATION_VIEWER_LOG_VIEWER_ID_ADMIN_USER_USER_ID` FOREIGN KEY (`viewer_id`) REFERENCES `admin_user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Release Notification Viewer Log Table';

INSERT INTO `release_notification_viewer_log` (`id`, `viewer_id`, `last_view_version`) VALUES
(1,	1,	'2.3.0');

DROP TABLE IF EXISTS `reporting_counts`;
CREATE TABLE `reporting_counts` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `type` varchar(255) DEFAULT NULL COMMENT 'Item Reported',
  `count` int(10) unsigned DEFAULT NULL COMMENT 'Count Value',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Updated At',
  PRIMARY KEY (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Reporting for all count related events generated via the cron job';


DROP TABLE IF EXISTS `reporting_module_status`;
CREATE TABLE `reporting_module_status` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Module Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Module Name',
  `active` varchar(255) DEFAULT NULL COMMENT 'Module Active Status',
  `setup_version` varchar(255) DEFAULT NULL COMMENT 'Module Version',
  `state` varchar(255) DEFAULT NULL COMMENT 'Module State',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Updated At',
  PRIMARY KEY (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Module Status Table';


DROP TABLE IF EXISTS `reporting_orders`;
CREATE TABLE `reporting_orders` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `total` decimal(10,0) unsigned DEFAULT NULL,
  `total_base` decimal(10,0) unsigned DEFAULT NULL,
  `item_count` int(10) unsigned NOT NULL COMMENT 'Line Item Count',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Updated At',
  PRIMARY KEY (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Reporting for all orders';


DROP TABLE IF EXISTS `reporting_system_updates`;
CREATE TABLE `reporting_system_updates` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `type` varchar(255) DEFAULT NULL COMMENT 'Update Type',
  `action` varchar(255) DEFAULT NULL COMMENT 'Action Performed',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Updated At',
  PRIMARY KEY (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Reporting for system updates';


DROP TABLE IF EXISTS `reporting_users`;
CREATE TABLE `reporting_users` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `type` varchar(255) DEFAULT NULL COMMENT 'User Type',
  `action` varchar(255) DEFAULT NULL COMMENT 'Action Performed',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Updated At',
  PRIMARY KEY (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Reporting for user actions';


DROP TABLE IF EXISTS `report_compared_product_index`;
CREATE TABLE `report_compared_product_index` (
  `index_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Index Id',
  `visitor_id` int(10) unsigned DEFAULT NULL COMMENT 'Visitor Id',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `added_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Added At',
  PRIMARY KEY (`index_id`),
  UNIQUE KEY `REPORT_COMPARED_PRODUCT_INDEX_VISITOR_ID_PRODUCT_ID` (`visitor_id`,`product_id`),
  UNIQUE KEY `REPORT_COMPARED_PRODUCT_INDEX_CUSTOMER_ID_PRODUCT_ID` (`customer_id`,`product_id`),
  KEY `REPORT_COMPARED_PRODUCT_INDEX_STORE_ID` (`store_id`),
  KEY `REPORT_COMPARED_PRODUCT_INDEX_ADDED_AT` (`added_at`),
  KEY `REPORT_COMPARED_PRODUCT_INDEX_PRODUCT_ID` (`product_id`),
  CONSTRAINT `REPORT_CMPD_PRD_IDX_CSTR_ID_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `REPORT_CMPD_PRD_IDX_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `REPORT_COMPARED_PRODUCT_INDEX_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Reports Compared Product Index Table';


DROP TABLE IF EXISTS `report_event`;
CREATE TABLE `report_event` (
  `event_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Event Id',
  `logged_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Logged At',
  `event_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Event Type Id',
  `object_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Object Id',
  `subject_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Subject Id',
  `subtype` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Subtype',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  PRIMARY KEY (`event_id`),
  KEY `REPORT_EVENT_EVENT_TYPE_ID` (`event_type_id`),
  KEY `REPORT_EVENT_SUBJECT_ID` (`subject_id`),
  KEY `REPORT_EVENT_OBJECT_ID` (`object_id`),
  KEY `REPORT_EVENT_SUBTYPE` (`subtype`),
  KEY `REPORT_EVENT_STORE_ID` (`store_id`),
  CONSTRAINT `REPORT_EVENT_EVENT_TYPE_ID_REPORT_EVENT_TYPES_EVENT_TYPE_ID` FOREIGN KEY (`event_type_id`) REFERENCES `report_event_types` (`event_type_id`) ON DELETE CASCADE,
  CONSTRAINT `REPORT_EVENT_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Reports Event Table';

INSERT INTO `report_event` (`event_id`, `logged_at`, `event_type_id`, `object_id`, `subject_id`, `subtype`, `store_id`) VALUES
(1,	'2019-02-18 15:09:47',	4,	1,	1,	0,	1),
(2,	'2019-02-18 15:16:03',	4,	1,	1,	0,	1),
(3,	'2019-02-18 15:17:15',	4,	1,	1,	0,	1),
(4,	'2019-02-18 15:47:04',	4,	1,	1,	0,	1);

DROP TABLE IF EXISTS `report_event_types`;
CREATE TABLE `report_event_types` (
  `event_type_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Event Type Id',
  `event_name` varchar(64) NOT NULL COMMENT 'Event Name',
  `customer_login` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Login',
  PRIMARY KEY (`event_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Reports Event Type Table';

INSERT INTO `report_event_types` (`event_type_id`, `event_name`, `customer_login`) VALUES
(1,	'catalog_product_view',	0),
(2,	'sendfriend_product',	0),
(3,	'catalog_product_compare_add_product',	0),
(4,	'checkout_cart_add_product',	0),
(5,	'wishlist_add_product',	0),
(6,	'wishlist_share',	0);

DROP TABLE IF EXISTS `report_viewed_product_aggregated_daily`;
CREATE TABLE `report_viewed_product_aggregated_daily` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `views_num` int(11) NOT NULL DEFAULT '0' COMMENT 'Number of Views',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `REPORT_VIEWED_PRD_AGGRED_DAILY_PERIOD_STORE_ID_PRD_ID` (`period`,`store_id`,`product_id`),
  KEY `REPORT_VIEWED_PRODUCT_AGGREGATED_DAILY_STORE_ID` (`store_id`),
  KEY `REPORT_VIEWED_PRODUCT_AGGREGATED_DAILY_PRODUCT_ID` (`product_id`),
  CONSTRAINT `REPORT_VIEWED_PRD_AGGRED_DAILY_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `REPORT_VIEWED_PRODUCT_AGGREGATED_DAILY_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Most Viewed Products Aggregated Daily';


DROP TABLE IF EXISTS `report_viewed_product_aggregated_monthly`;
CREATE TABLE `report_viewed_product_aggregated_monthly` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `views_num` int(11) NOT NULL DEFAULT '0' COMMENT 'Number of Views',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `REPORT_VIEWED_PRD_AGGRED_MONTHLY_PERIOD_STORE_ID_PRD_ID` (`period`,`store_id`,`product_id`),
  KEY `REPORT_VIEWED_PRODUCT_AGGREGATED_MONTHLY_STORE_ID` (`store_id`),
  KEY `REPORT_VIEWED_PRODUCT_AGGREGATED_MONTHLY_PRODUCT_ID` (`product_id`),
  CONSTRAINT `REPORT_VIEWED_PRD_AGGRED_MONTHLY_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `REPORT_VIEWED_PRODUCT_AGGREGATED_MONTHLY_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Most Viewed Products Aggregated Monthly';


DROP TABLE IF EXISTS `report_viewed_product_aggregated_yearly`;
CREATE TABLE `report_viewed_product_aggregated_yearly` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `views_num` int(11) NOT NULL DEFAULT '0' COMMENT 'Number of Views',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `REPORT_VIEWED_PRD_AGGRED_YEARLY_PERIOD_STORE_ID_PRD_ID` (`period`,`store_id`,`product_id`),
  KEY `REPORT_VIEWED_PRODUCT_AGGREGATED_YEARLY_STORE_ID` (`store_id`),
  KEY `REPORT_VIEWED_PRODUCT_AGGREGATED_YEARLY_PRODUCT_ID` (`product_id`),
  CONSTRAINT `REPORT_VIEWED_PRD_AGGRED_YEARLY_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `REPORT_VIEWED_PRODUCT_AGGREGATED_YEARLY_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Most Viewed Products Aggregated Yearly';


DROP TABLE IF EXISTS `report_viewed_product_index`;
CREATE TABLE `report_viewed_product_index` (
  `index_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Index Id',
  `visitor_id` int(10) unsigned DEFAULT NULL COMMENT 'Visitor Id',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `added_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Added At',
  PRIMARY KEY (`index_id`),
  UNIQUE KEY `REPORT_VIEWED_PRODUCT_INDEX_VISITOR_ID_PRODUCT_ID` (`visitor_id`,`product_id`),
  UNIQUE KEY `REPORT_VIEWED_PRODUCT_INDEX_CUSTOMER_ID_PRODUCT_ID` (`customer_id`,`product_id`),
  KEY `REPORT_VIEWED_PRODUCT_INDEX_STORE_ID` (`store_id`),
  KEY `REPORT_VIEWED_PRODUCT_INDEX_ADDED_AT` (`added_at`),
  KEY `REPORT_VIEWED_PRODUCT_INDEX_PRODUCT_ID` (`product_id`),
  CONSTRAINT `REPORT_VIEWED_PRD_IDX_CSTR_ID_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `REPORT_VIEWED_PRD_IDX_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `REPORT_VIEWED_PRODUCT_INDEX_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Reports Viewed Product Index Table';


DROP TABLE IF EXISTS `review`;
CREATE TABLE `review` (
  `review_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Review id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Review create date',
  `entity_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity id',
  `entity_pk_value` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product id',
  `status_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Status code',
  PRIMARY KEY (`review_id`),
  KEY `REVIEW_ENTITY_ID` (`entity_id`),
  KEY `REVIEW_STATUS_ID` (`status_id`),
  KEY `REVIEW_ENTITY_PK_VALUE` (`entity_pk_value`),
  CONSTRAINT `REVIEW_ENTITY_ID_REVIEW_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `review_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `REVIEW_STATUS_ID_REVIEW_STATUS_STATUS_ID` FOREIGN KEY (`status_id`) REFERENCES `review_status` (`status_id`) ON DELETE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Review base information';


DROP TABLE IF EXISTS `review_detail`;
CREATE TABLE `review_detail` (
  `detail_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Review detail id',
  `review_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Review id',
  `store_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Store id',
  `title` varchar(255) NOT NULL COMMENT 'Title',
  `detail` text NOT NULL COMMENT 'Detail description',
  `nickname` varchar(128) NOT NULL COMMENT 'User nickname',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  PRIMARY KEY (`detail_id`),
  KEY `REVIEW_DETAIL_REVIEW_ID` (`review_id`),
  KEY `REVIEW_DETAIL_STORE_ID` (`store_id`),
  KEY `REVIEW_DETAIL_CUSTOMER_ID` (`customer_id`),
  CONSTRAINT `REVIEW_DETAIL_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE SET NULL,
  CONSTRAINT `REVIEW_DETAIL_REVIEW_ID_REVIEW_REVIEW_ID` FOREIGN KEY (`review_id`) REFERENCES `review` (`review_id`) ON DELETE CASCADE,
  CONSTRAINT `REVIEW_DETAIL_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Review detail information';


DROP TABLE IF EXISTS `review_entity`;
CREATE TABLE `review_entity` (
  `entity_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Review entity id',
  `entity_code` varchar(32) NOT NULL COMMENT 'Review entity code',
  PRIMARY KEY (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Review entities';

INSERT INTO `review_entity` (`entity_id`, `entity_code`) VALUES
(1,	'product'),
(2,	'customer'),
(3,	'category');

DROP TABLE IF EXISTS `review_entity_summary`;
CREATE TABLE `review_entity_summary` (
  `primary_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Summary review entity id',
  `entity_pk_value` bigint(20) NOT NULL DEFAULT '0' COMMENT 'Product id',
  `entity_type` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Entity type id',
  `reviews_count` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Qty of reviews',
  `rating_summary` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Summarized rating',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store id',
  PRIMARY KEY (`primary_id`),
  KEY `REVIEW_ENTITY_SUMMARY_STORE_ID` (`store_id`),
  CONSTRAINT `REVIEW_ENTITY_SUMMARY_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Review aggregates';


DROP TABLE IF EXISTS `review_status`;
CREATE TABLE `review_status` (
  `status_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Status id',
  `status_code` varchar(32) NOT NULL COMMENT 'Status code',
  PRIMARY KEY (`status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Review statuses';

INSERT INTO `review_status` (`status_id`, `status_code`) VALUES
(1,	'Approved'),
(2,	'Pending'),
(3,	'Not Approved');

DROP TABLE IF EXISTS `review_store`;
CREATE TABLE `review_store` (
  `review_id` bigint(20) unsigned NOT NULL COMMENT 'Review Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  PRIMARY KEY (`review_id`,`store_id`),
  KEY `REVIEW_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `REVIEW_STORE_REVIEW_ID_REVIEW_REVIEW_ID` FOREIGN KEY (`review_id`) REFERENCES `review` (`review_id`) ON DELETE CASCADE,
  CONSTRAINT `REVIEW_STORE_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Review Store';


DROP TABLE IF EXISTS `salesrule`;
CREATE TABLE `salesrule` (
  `rule_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `description` text COMMENT 'Description',
  `from_date` date DEFAULT NULL COMMENT 'From',
  `to_date` date DEFAULT NULL COMMENT 'To',
  `uses_per_customer` int(11) NOT NULL DEFAULT '0' COMMENT 'Uses Per Customer',
  `is_active` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is Active',
  `conditions_serialized` mediumtext COMMENT 'Conditions Serialized',
  `actions_serialized` mediumtext COMMENT 'Actions Serialized',
  `stop_rules_processing` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Stop Rules Processing',
  `is_advanced` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Advanced',
  `product_ids` text COMMENT 'Product Ids',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `simple_action` varchar(32) DEFAULT NULL COMMENT 'Simple Action',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount',
  `discount_qty` decimal(12,4) DEFAULT NULL COMMENT 'Discount Qty',
  `discount_step` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Discount Step',
  `apply_to_shipping` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Apply To Shipping',
  `times_used` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Times Used',
  `is_rss` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is Rss',
  `coupon_type` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Coupon Type',
  `use_auto_generation` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Use Auto Generation',
  `uses_per_coupon` int(11) NOT NULL DEFAULT '0' COMMENT 'User Per Coupon',
  `simple_free_shipping` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Simple Free Shipping',
  PRIMARY KEY (`rule_id`),
  KEY `SALESRULE_IS_ACTIVE_SORT_ORDER_TO_DATE_FROM_DATE` (`is_active`,`sort_order`,`to_date`,`from_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Salesrule';


DROP TABLE IF EXISTS `salesrule_coupon`;
CREATE TABLE `salesrule_coupon` (
  `coupon_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Coupon Id',
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `code` varchar(255) DEFAULT NULL COMMENT 'Code',
  `usage_limit` int(10) unsigned DEFAULT NULL COMMENT 'Usage Limit',
  `usage_per_customer` int(10) unsigned DEFAULT NULL COMMENT 'Usage Per Customer',
  `times_used` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Times Used',
  `expiration_date` timestamp NULL DEFAULT NULL COMMENT 'Expiration Date',
  `is_primary` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Primary',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Coupon Code Creation Date',
  `type` smallint(6) DEFAULT '0' COMMENT 'Coupon Code Type',
  `generated_by_dotmailer` smallint(6) DEFAULT NULL COMMENT '1 = Generated by dotmailer',
  PRIMARY KEY (`coupon_id`),
  UNIQUE KEY `SALESRULE_COUPON_CODE` (`code`),
  UNIQUE KEY `SALESRULE_COUPON_RULE_ID_IS_PRIMARY` (`rule_id`,`is_primary`),
  KEY `SALESRULE_COUPON_RULE_ID` (`rule_id`),
  CONSTRAINT `SALESRULE_COUPON_RULE_ID_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `salesrule` (`rule_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Salesrule Coupon';


DROP TABLE IF EXISTS `salesrule_coupon_aggregated`;
CREATE TABLE `salesrule_coupon_aggregated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date NOT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `coupon_code` varchar(50) DEFAULT NULL COMMENT 'Coupon Code',
  `coupon_uses` int(11) NOT NULL DEFAULT '0' COMMENT 'Coupon Uses',
  `subtotal_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal Amount',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount',
  `total_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Amount',
  `subtotal_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal Amount Actual',
  `discount_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount Actual',
  `total_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Amount Actual',
  `rule_name` varchar(255) DEFAULT NULL COMMENT 'Rule Name',
  PRIMARY KEY (`id`),
  UNIQUE KEY `SALESRULE_COUPON_AGGRED_PERIOD_STORE_ID_ORDER_STS_COUPON_CODE` (`period`,`store_id`,`order_status`,`coupon_code`),
  KEY `SALESRULE_COUPON_AGGREGATED_STORE_ID` (`store_id`),
  KEY `SALESRULE_COUPON_AGGREGATED_RULE_NAME` (`rule_name`),
  CONSTRAINT `SALESRULE_COUPON_AGGREGATED_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Coupon Aggregated';


DROP TABLE IF EXISTS `salesrule_coupon_aggregated_order`;
CREATE TABLE `salesrule_coupon_aggregated_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date NOT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `coupon_code` varchar(50) DEFAULT NULL COMMENT 'Coupon Code',
  `coupon_uses` int(11) NOT NULL DEFAULT '0' COMMENT 'Coupon Uses',
  `subtotal_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal Amount',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount',
  `total_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Amount',
  `rule_name` varchar(255) DEFAULT NULL COMMENT 'Rule Name',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_1094D1FBBCBB11704A29DEF3ACC37D2B` (`period`,`store_id`,`order_status`,`coupon_code`),
  KEY `SALESRULE_COUPON_AGGREGATED_ORDER_STORE_ID` (`store_id`),
  KEY `SALESRULE_COUPON_AGGREGATED_ORDER_RULE_NAME` (`rule_name`),
  CONSTRAINT `SALESRULE_COUPON_AGGREGATED_ORDER_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Coupon Aggregated Order';


DROP TABLE IF EXISTS `salesrule_coupon_aggregated_updated`;
CREATE TABLE `salesrule_coupon_aggregated_updated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date NOT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `coupon_code` varchar(50) DEFAULT NULL COMMENT 'Coupon Code',
  `coupon_uses` int(11) NOT NULL DEFAULT '0' COMMENT 'Coupon Uses',
  `subtotal_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal Amount',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount',
  `total_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Amount',
  `subtotal_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal Amount Actual',
  `discount_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount Actual',
  `total_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Amount Actual',
  `rule_name` varchar(255) DEFAULT NULL COMMENT 'Rule Name',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_7196FA120A4F0F84E1B66605E87E213E` (`period`,`store_id`,`order_status`,`coupon_code`),
  KEY `SALESRULE_COUPON_AGGREGATED_UPDATED_STORE_ID` (`store_id`),
  KEY `SALESRULE_COUPON_AGGREGATED_UPDATED_RULE_NAME` (`rule_name`),
  CONSTRAINT `SALESRULE_COUPON_AGGREGATED_UPDATED_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Salesrule Coupon Aggregated Updated';


DROP TABLE IF EXISTS `salesrule_coupon_usage`;
CREATE TABLE `salesrule_coupon_usage` (
  `coupon_id` int(10) unsigned NOT NULL COMMENT 'Coupon Id',
  `customer_id` int(10) unsigned NOT NULL COMMENT 'Customer Id',
  `times_used` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Times Used',
  PRIMARY KEY (`coupon_id`,`customer_id`),
  KEY `SALESRULE_COUPON_USAGE_CUSTOMER_ID` (`customer_id`),
  CONSTRAINT `SALESRULE_COUPON_USAGE_COUPON_ID_SALESRULE_COUPON_COUPON_ID` FOREIGN KEY (`coupon_id`) REFERENCES `salesrule_coupon` (`coupon_id`) ON DELETE CASCADE,
  CONSTRAINT `SALESRULE_COUPON_USAGE_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Salesrule Coupon Usage';


DROP TABLE IF EXISTS `salesrule_customer`;
CREATE TABLE `salesrule_customer` (
  `rule_customer_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rule Customer Id',
  `rule_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Rule Id',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Id',
  `times_used` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Times Used',
  PRIMARY KEY (`rule_customer_id`),
  KEY `SALESRULE_CUSTOMER_RULE_ID_CUSTOMER_ID` (`rule_id`,`customer_id`),
  KEY `SALESRULE_CUSTOMER_CUSTOMER_ID_RULE_ID` (`customer_id`,`rule_id`),
  CONSTRAINT `SALESRULE_CUSTOMER_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `SALESRULE_CUSTOMER_RULE_ID_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `salesrule` (`rule_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Salesrule Customer';


DROP TABLE IF EXISTS `salesrule_customer_group`;
CREATE TABLE `salesrule_customer_group` (
  `rule_id` int(10) unsigned NOT NULL,
  `customer_group_id` int(10) unsigned NOT NULL COMMENT 'Customer Group Id',
  PRIMARY KEY (`rule_id`,`customer_group_id`),
  KEY `SALESRULE_CUSTOMER_GROUP_CUSTOMER_GROUP_ID` (`customer_group_id`),
  CONSTRAINT `SALESRULE_CSTR_GROUP_CSTR_GROUP_ID_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE,
  CONSTRAINT `SALESRULE_CUSTOMER_GROUP_RULE_ID_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `salesrule` (`rule_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Rules To Customer Groups Relations';


DROP TABLE IF EXISTS `salesrule_label`;
CREATE TABLE `salesrule_label` (
  `label_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Label Id',
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `label` varchar(255) DEFAULT NULL COMMENT 'Label',
  PRIMARY KEY (`label_id`),
  UNIQUE KEY `SALESRULE_LABEL_RULE_ID_STORE_ID` (`rule_id`,`store_id`),
  KEY `SALESRULE_LABEL_STORE_ID` (`store_id`),
  CONSTRAINT `SALESRULE_LABEL_RULE_ID_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `salesrule` (`rule_id`) ON DELETE CASCADE,
  CONSTRAINT `SALESRULE_LABEL_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Salesrule Label';


DROP TABLE IF EXISTS `salesrule_product_attribute`;
CREATE TABLE `salesrule_product_attribute` (
  `rule_id` int(10) unsigned NOT NULL,
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `customer_group_id` int(10) unsigned NOT NULL COMMENT 'Customer Group Id',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  PRIMARY KEY (`rule_id`,`website_id`,`customer_group_id`,`attribute_id`),
  KEY `SALESRULE_PRODUCT_ATTRIBUTE_WEBSITE_ID` (`website_id`),
  KEY `SALESRULE_PRODUCT_ATTRIBUTE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `SALESRULE_PRODUCT_ATTRIBUTE_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `SALESRULE_PRD_ATTR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `SALESRULE_PRD_ATTR_CSTR_GROUP_ID_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE,
  CONSTRAINT `SALESRULE_PRODUCT_ATTRIBUTE_RULE_ID_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `salesrule` (`rule_id`) ON DELETE CASCADE,
  CONSTRAINT `SALESRULE_PRODUCT_ATTRIBUTE_WEBSITE_ID_STORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Salesrule Product Attribute';


DROP TABLE IF EXISTS `salesrule_website`;
CREATE TABLE `salesrule_website` (
  `rule_id` int(10) unsigned NOT NULL,
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  PRIMARY KEY (`rule_id`,`website_id`),
  KEY `SALESRULE_WEBSITE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `SALESRULE_WEBSITE_RULE_ID_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `salesrule` (`rule_id`) ON DELETE CASCADE,
  CONSTRAINT `SALESRULE_WEBSITE_WEBSITE_ID_STORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Rules To Websites Relations';


DROP TABLE IF EXISTS `sales_bestsellers_aggregated_daily`;
CREATE TABLE `sales_bestsellers_aggregated_daily` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `qty_ordered` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty Ordered',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `SALES_BESTSELLERS_AGGREGATED_DAILY_PERIOD_STORE_ID_PRODUCT_ID` (`period`,`store_id`,`product_id`),
  KEY `SALES_BESTSELLERS_AGGREGATED_DAILY_STORE_ID` (`store_id`),
  KEY `SALES_BESTSELLERS_AGGREGATED_DAILY_PRODUCT_ID` (`product_id`),
  CONSTRAINT `SALES_BESTSELLERS_AGGREGATED_DAILY_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Bestsellers Aggregated Daily';


DROP TABLE IF EXISTS `sales_bestsellers_aggregated_monthly`;
CREATE TABLE `sales_bestsellers_aggregated_monthly` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `qty_ordered` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty Ordered',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `SALES_BESTSELLERS_AGGREGATED_MONTHLY_PERIOD_STORE_ID_PRODUCT_ID` (`period`,`store_id`,`product_id`),
  KEY `SALES_BESTSELLERS_AGGREGATED_MONTHLY_STORE_ID` (`store_id`),
  KEY `SALES_BESTSELLERS_AGGREGATED_MONTHLY_PRODUCT_ID` (`product_id`),
  CONSTRAINT `SALES_BESTSELLERS_AGGREGATED_MONTHLY_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Bestsellers Aggregated Monthly';


DROP TABLE IF EXISTS `sales_bestsellers_aggregated_yearly`;
CREATE TABLE `sales_bestsellers_aggregated_yearly` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `qty_ordered` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty Ordered',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `SALES_BESTSELLERS_AGGREGATED_YEARLY_PERIOD_STORE_ID_PRODUCT_ID` (`period`,`store_id`,`product_id`),
  KEY `SALES_BESTSELLERS_AGGREGATED_YEARLY_STORE_ID` (`store_id`),
  KEY `SALES_BESTSELLERS_AGGREGATED_YEARLY_PRODUCT_ID` (`product_id`),
  CONSTRAINT `SALES_BESTSELLERS_AGGREGATED_YEARLY_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Bestsellers Aggregated Yearly';


DROP TABLE IF EXISTS `sales_creditmemo`;
CREATE TABLE `sales_creditmemo` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `adjustment_positive` decimal(12,4) DEFAULT NULL COMMENT 'Adjustment Positive',
  `base_shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Tax Amount',
  `store_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Order Rate',
  `base_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Amount',
  `base_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Order Rate',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `base_adjustment_negative` decimal(12,4) DEFAULT NULL COMMENT 'Base Adjustment Negative',
  `base_subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Incl Tax',
  `shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Amount',
  `subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Incl Tax',
  `adjustment_negative` decimal(12,4) DEFAULT NULL COMMENT 'Adjustment Negative',
  `base_shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Amount',
  `store_to_base_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Base Rate',
  `base_to_global_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Global Rate',
  `base_adjustment` decimal(12,4) DEFAULT NULL COMMENT 'Base Adjustment',
  `base_subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal',
  `discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Amount',
  `subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal',
  `adjustment` decimal(12,4) DEFAULT NULL COMMENT 'Adjustment',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `base_adjustment_positive` decimal(12,4) DEFAULT NULL COMMENT 'Base Adjustment Positive',
  `base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Amount',
  `shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Tax Amount',
  `tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Amount',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `email_sent` smallint(5) unsigned DEFAULT NULL COMMENT 'Email Sent',
  `send_email` smallint(5) unsigned DEFAULT NULL COMMENT 'Send Email',
  `creditmemo_status` int(11) DEFAULT NULL COMMENT 'Creditmemo Status',
  `state` int(11) DEFAULT NULL COMMENT 'State',
  `shipping_address_id` int(11) DEFAULT NULL COMMENT 'Shipping Address Id',
  `billing_address_id` int(11) DEFAULT NULL COMMENT 'Billing Address Id',
  `invoice_id` int(11) DEFAULT NULL COMMENT 'Invoice Id',
  `store_currency_code` varchar(3) DEFAULT NULL COMMENT 'Store Currency Code',
  `order_currency_code` varchar(3) DEFAULT NULL COMMENT 'Order Currency Code',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `global_currency_code` varchar(3) DEFAULT NULL COMMENT 'Global Currency Code',
  `transaction_id` varchar(255) DEFAULT NULL COMMENT 'Transaction Id',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Updated At',
  `discount_tax_compensation_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Tax Compensation Amount',
  `base_discount_tax_compensation_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Tax Compensation Amount',
  `shipping_discount_tax_compensation_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Discount Tax Compensation Amount',
  `base_shipping_discount_tax_compensation_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Discount Tax Compensation Amount',
  `shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Incl Tax',
  `base_shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Incl Tax',
  `discount_description` varchar(255) DEFAULT NULL COMMENT 'Discount Description',
  `customer_note` text COMMENT 'Customer Note',
  `customer_note_notify` smallint(5) unsigned DEFAULT NULL COMMENT 'Customer Note Notify',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `SALES_CREDITMEMO_INCREMENT_ID_STORE_ID` (`increment_id`,`store_id`),
  KEY `SALES_CREDITMEMO_STORE_ID` (`store_id`),
  KEY `SALES_CREDITMEMO_ORDER_ID` (`order_id`),
  KEY `SALES_CREDITMEMO_CREDITMEMO_STATUS` (`creditmemo_status`),
  KEY `SALES_CREDITMEMO_STATE` (`state`),
  KEY `SALES_CREDITMEMO_CREATED_AT` (`created_at`),
  KEY `SALES_CREDITMEMO_UPDATED_AT` (`updated_at`),
  KEY `SALES_CREDITMEMO_SEND_EMAIL` (`send_email`),
  KEY `SALES_CREDITMEMO_EMAIL_SENT` (`email_sent`),
  CONSTRAINT `SALES_CREDITMEMO_ORDER_ID_SALES_ORDER_ENTITY_ID` FOREIGN KEY (`order_id`) REFERENCES `sales_order` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `SALES_CREDITMEMO_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Creditmemo';


DROP TABLE IF EXISTS `sales_creditmemo_comment`;
CREATE TABLE `sales_creditmemo_comment` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `is_customer_notified` int(11) DEFAULT NULL COMMENT 'Is Customer Notified',
  `is_visible_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible On Front',
  `comment` text COMMENT 'Comment',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  PRIMARY KEY (`entity_id`),
  KEY `SALES_CREDITMEMO_COMMENT_CREATED_AT` (`created_at`),
  KEY `SALES_CREDITMEMO_COMMENT_PARENT_ID` (`parent_id`),
  CONSTRAINT `SALES_CREDITMEMO_COMMENT_PARENT_ID_SALES_CREDITMEMO_ENTITY_ID` FOREIGN KEY (`parent_id`) REFERENCES `sales_creditmemo` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Creditmemo Comment';


DROP TABLE IF EXISTS `sales_creditmemo_grid`;
CREATE TABLE `sales_creditmemo_grid` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `order_increment_id` varchar(50) DEFAULT NULL COMMENT 'Order Increment Id',
  `order_created_at` timestamp NULL DEFAULT NULL COMMENT 'Order Created At',
  `billing_name` varchar(255) DEFAULT NULL COMMENT 'Billing Name',
  `state` int(11) DEFAULT NULL COMMENT 'Status',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `order_status` varchar(32) DEFAULT NULL COMMENT 'Order Status',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `billing_address` varchar(255) DEFAULT NULL COMMENT 'Billing Address',
  `shipping_address` varchar(255) DEFAULT NULL COMMENT 'Shipping Address',
  `customer_name` varchar(128) NOT NULL COMMENT 'Customer Name',
  `customer_email` varchar(128) DEFAULT NULL COMMENT 'Customer Email',
  `customer_group_id` smallint(6) DEFAULT NULL COMMENT 'Customer Group Id',
  `payment_method` varchar(32) DEFAULT NULL COMMENT 'Payment Method',
  `shipping_information` varchar(255) DEFAULT NULL COMMENT 'Shipping Method Name',
  `subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal',
  `shipping_and_handling` decimal(12,4) DEFAULT NULL COMMENT 'Shipping and handling amount',
  `adjustment_positive` decimal(12,4) DEFAULT NULL COMMENT 'Adjustment Positive',
  `adjustment_negative` decimal(12,4) DEFAULT NULL COMMENT 'Adjustment Negative',
  `order_base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Order Grand Total',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `SALES_CREDITMEMO_GRID_INCREMENT_ID_STORE_ID` (`increment_id`,`store_id`),
  KEY `SALES_CREDITMEMO_GRID_ORDER_INCREMENT_ID` (`order_increment_id`),
  KEY `SALES_CREDITMEMO_GRID_CREATED_AT` (`created_at`),
  KEY `SALES_CREDITMEMO_GRID_UPDATED_AT` (`updated_at`),
  KEY `SALES_CREDITMEMO_GRID_ORDER_CREATED_AT` (`order_created_at`),
  KEY `SALES_CREDITMEMO_GRID_STATE` (`state`),
  KEY `SALES_CREDITMEMO_GRID_BILLING_NAME` (`billing_name`),
  KEY `SALES_CREDITMEMO_GRID_ORDER_STATUS` (`order_status`),
  KEY `SALES_CREDITMEMO_GRID_BASE_GRAND_TOTAL` (`base_grand_total`),
  KEY `SALES_CREDITMEMO_GRID_STORE_ID` (`store_id`),
  KEY `SALES_CREDITMEMO_GRID_ORDER_BASE_GRAND_TOTAL` (`order_base_grand_total`),
  KEY `SALES_CREDITMEMO_GRID_ORDER_ID` (`order_id`),
  FULLTEXT KEY `FTI_32B7BA885941A8254EE84AE650ABDC86` (`increment_id`,`order_increment_id`,`billing_name`,`billing_address`,`shipping_address`,`customer_name`,`customer_email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Creditmemo Grid';


DROP TABLE IF EXISTS `sales_creditmemo_item`;
CREATE TABLE `sales_creditmemo_item` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `base_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Price',
  `tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Amount',
  `base_row_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total',
  `discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Amount',
  `row_total` decimal(12,4) DEFAULT NULL COMMENT 'Row Total',
  `base_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Amount',
  `price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Price Incl Tax',
  `base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Amount',
  `base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Price Incl Tax',
  `qty` decimal(12,4) DEFAULT NULL COMMENT 'Qty',
  `base_cost` decimal(12,4) DEFAULT NULL COMMENT 'Base Cost',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `base_row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total Incl Tax',
  `row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Row Total Incl Tax',
  `product_id` int(11) DEFAULT NULL COMMENT 'Product Id',
  `order_item_id` int(11) DEFAULT NULL COMMENT 'Order Item Id',
  `additional_data` text COMMENT 'Additional Data',
  `description` text COMMENT 'Description',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `discount_tax_compensation_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Tax Compensation Amount',
  `base_discount_tax_compensation_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Tax Compensation Amount',
  `tax_ratio` text COMMENT 'Ratio of tax in the creditmemo item over tax of the order item',
  `weee_tax_applied` text COMMENT 'Weee Tax Applied',
  `weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Amount',
  `weee_tax_applied_row_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Row Amount',
  `weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Disposition',
  `weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Row Disposition',
  `base_weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Amount',
  `base_weee_tax_applied_row_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Row Amnt',
  `base_weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Disposition',
  `base_weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Row Disposition',
  PRIMARY KEY (`entity_id`),
  KEY `SALES_CREDITMEMO_ITEM_PARENT_ID` (`parent_id`),
  CONSTRAINT `SALES_CREDITMEMO_ITEM_PARENT_ID_SALES_CREDITMEMO_ENTITY_ID` FOREIGN KEY (`parent_id`) REFERENCES `sales_creditmemo` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Creditmemo Item';


DROP TABLE IF EXISTS `sales_invoice`;
CREATE TABLE `sales_invoice` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Tax Amount',
  `tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Amount',
  `base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Amount',
  `store_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Order Rate',
  `base_shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Tax Amount',
  `base_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Amount',
  `base_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Order Rate',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Amount',
  `subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Incl Tax',
  `base_subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Incl Tax',
  `store_to_base_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Base Rate',
  `base_shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Amount',
  `total_qty` decimal(12,4) DEFAULT NULL COMMENT 'Total Qty',
  `base_to_global_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Global Rate',
  `subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal',
  `base_subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal',
  `discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Amount',
  `billing_address_id` int(11) DEFAULT NULL COMMENT 'Billing Address Id',
  `is_used_for_refund` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Used For Refund',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `email_sent` smallint(5) unsigned DEFAULT NULL COMMENT 'Email Sent',
  `send_email` smallint(5) unsigned DEFAULT NULL COMMENT 'Send Email',
  `can_void_flag` smallint(5) unsigned DEFAULT NULL COMMENT 'Can Void Flag',
  `state` int(11) DEFAULT NULL COMMENT 'State',
  `shipping_address_id` int(11) DEFAULT NULL COMMENT 'Shipping Address Id',
  `store_currency_code` varchar(3) DEFAULT NULL COMMENT 'Store Currency Code',
  `transaction_id` varchar(255) DEFAULT NULL COMMENT 'Transaction Id',
  `order_currency_code` varchar(3) DEFAULT NULL COMMENT 'Order Currency Code',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `global_currency_code` varchar(3) DEFAULT NULL COMMENT 'Global Currency Code',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Updated At',
  `discount_tax_compensation_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Tax Compensation Amount',
  `base_discount_tax_compensation_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Tax Compensation Amount',
  `shipping_discount_tax_compensation_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Discount Tax Compensation Amount',
  `base_shipping_discount_tax_compensation_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Discount Tax Compensation Amount',
  `shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Incl Tax',
  `base_shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Incl Tax',
  `base_total_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Refunded',
  `discount_description` varchar(255) DEFAULT NULL COMMENT 'Discount Description',
  `customer_note` text COMMENT 'Customer Note',
  `customer_note_notify` smallint(5) unsigned DEFAULT NULL COMMENT 'Customer Note Notify',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `SALES_INVOICE_INCREMENT_ID_STORE_ID` (`increment_id`,`store_id`),
  KEY `SALES_INVOICE_STORE_ID` (`store_id`),
  KEY `SALES_INVOICE_GRAND_TOTAL` (`grand_total`),
  KEY `SALES_INVOICE_ORDER_ID` (`order_id`),
  KEY `SALES_INVOICE_STATE` (`state`),
  KEY `SALES_INVOICE_CREATED_AT` (`created_at`),
  KEY `SALES_INVOICE_UPDATED_AT` (`updated_at`),
  KEY `SALES_INVOICE_SEND_EMAIL` (`send_email`),
  KEY `SALES_INVOICE_EMAIL_SENT` (`email_sent`),
  CONSTRAINT `SALES_INVOICE_ORDER_ID_SALES_ORDER_ENTITY_ID` FOREIGN KEY (`order_id`) REFERENCES `sales_order` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `SALES_INVOICE_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Invoice';

INSERT INTO `sales_invoice` (`entity_id`, `store_id`, `base_grand_total`, `shipping_tax_amount`, `tax_amount`, `base_tax_amount`, `store_to_order_rate`, `base_shipping_tax_amount`, `base_discount_amount`, `base_to_order_rate`, `grand_total`, `shipping_amount`, `subtotal_incl_tax`, `base_subtotal_incl_tax`, `store_to_base_rate`, `base_shipping_amount`, `total_qty`, `base_to_global_rate`, `subtotal`, `base_subtotal`, `discount_amount`, `billing_address_id`, `is_used_for_refund`, `order_id`, `email_sent`, `send_email`, `can_void_flag`, `state`, `shipping_address_id`, `store_currency_code`, `transaction_id`, `order_currency_code`, `base_currency_code`, `global_currency_code`, `increment_id`, `created_at`, `updated_at`, `discount_tax_compensation_amount`, `base_discount_tax_compensation_amount`, `shipping_discount_tax_compensation_amount`, `base_shipping_discount_tax_compensation_amnt`, `shipping_incl_tax`, `base_shipping_incl_tax`, `base_total_refunded`, `discount_description`, `customer_note`, `customer_note_notify`) VALUES
(1,	1,	15.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	1.0000,	15.0000,	5.0000,	10.0000,	10.0000,	0.0000,	5.0000,	1.0000,	1.0000,	10.0000,	10.0000,	0.0000,	6,	NULL,	3,	NULL,	NULL,	NULL,	2,	5,	'USD',	'536664-1_13',	'USD',	'USD',	'USD',	'000000001',	'2019-02-18 15:18:47',	'2019-02-18 15:18:47',	0.0000,	0.0000,	0.0000,	0.0000,	5.0000,	5.0000,	NULL,	NULL,	NULL,	NULL);

DROP TABLE IF EXISTS `sales_invoiced_aggregated`;
CREATE TABLE `sales_invoiced_aggregated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `orders_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Orders Invoiced',
  `invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced',
  `invoiced_captured` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced Captured',
  `invoiced_not_captured` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced Not Captured',
  PRIMARY KEY (`id`),
  UNIQUE KEY `SALES_INVOICED_AGGREGATED_PERIOD_STORE_ID_ORDER_STATUS` (`period`,`store_id`,`order_status`),
  KEY `SALES_INVOICED_AGGREGATED_STORE_ID` (`store_id`),
  CONSTRAINT `SALES_INVOICED_AGGREGATED_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Invoiced Aggregated';


DROP TABLE IF EXISTS `sales_invoiced_aggregated_order`;
CREATE TABLE `sales_invoiced_aggregated_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) NOT NULL COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `orders_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Orders Invoiced',
  `invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced',
  `invoiced_captured` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced Captured',
  `invoiced_not_captured` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced Not Captured',
  PRIMARY KEY (`id`),
  UNIQUE KEY `SALES_INVOICED_AGGREGATED_ORDER_PERIOD_STORE_ID_ORDER_STATUS` (`period`,`store_id`,`order_status`),
  KEY `SALES_INVOICED_AGGREGATED_ORDER_STORE_ID` (`store_id`),
  CONSTRAINT `SALES_INVOICED_AGGREGATED_ORDER_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Invoiced Aggregated Order';


DROP TABLE IF EXISTS `sales_invoice_comment`;
CREATE TABLE `sales_invoice_comment` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `is_customer_notified` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Customer Notified',
  `is_visible_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible On Front',
  `comment` text COMMENT 'Comment',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  PRIMARY KEY (`entity_id`),
  KEY `SALES_INVOICE_COMMENT_CREATED_AT` (`created_at`),
  KEY `SALES_INVOICE_COMMENT_PARENT_ID` (`parent_id`),
  CONSTRAINT `SALES_INVOICE_COMMENT_PARENT_ID_SALES_INVOICE_ENTITY_ID` FOREIGN KEY (`parent_id`) REFERENCES `sales_invoice` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Invoice Comment';


DROP TABLE IF EXISTS `sales_invoice_grid`;
CREATE TABLE `sales_invoice_grid` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `state` int(11) DEFAULT NULL COMMENT 'State',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `store_name` varchar(255) DEFAULT NULL COMMENT 'Store Name',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `order_increment_id` varchar(50) DEFAULT NULL COMMENT 'Order Increment Id',
  `order_created_at` timestamp NULL DEFAULT NULL COMMENT 'Order Created At',
  `customer_name` varchar(255) DEFAULT NULL COMMENT 'Customer Name',
  `customer_email` varchar(255) DEFAULT NULL COMMENT 'Customer Email',
  `customer_group_id` int(11) DEFAULT NULL,
  `payment_method` varchar(128) DEFAULT NULL COMMENT 'Payment Method',
  `store_currency_code` varchar(3) DEFAULT NULL COMMENT 'Store Currency Code',
  `order_currency_code` varchar(3) DEFAULT NULL COMMENT 'Order Currency Code',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `global_currency_code` varchar(3) DEFAULT NULL COMMENT 'Global Currency Code',
  `billing_name` varchar(255) DEFAULT NULL COMMENT 'Billing Name',
  `billing_address` varchar(255) DEFAULT NULL COMMENT 'Billing Address',
  `shipping_address` varchar(255) DEFAULT NULL COMMENT 'Shipping Address',
  `shipping_information` varchar(255) DEFAULT NULL COMMENT 'Shipping Method Name',
  `subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal',
  `shipping_and_handling` decimal(12,4) DEFAULT NULL COMMENT 'Shipping and handling amount',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `SALES_INVOICE_GRID_INCREMENT_ID_STORE_ID` (`increment_id`,`store_id`),
  KEY `SALES_INVOICE_GRID_STORE_ID` (`store_id`),
  KEY `SALES_INVOICE_GRID_GRAND_TOTAL` (`grand_total`),
  KEY `SALES_INVOICE_GRID_ORDER_ID` (`order_id`),
  KEY `SALES_INVOICE_GRID_STATE` (`state`),
  KEY `SALES_INVOICE_GRID_ORDER_INCREMENT_ID` (`order_increment_id`),
  KEY `SALES_INVOICE_GRID_CREATED_AT` (`created_at`),
  KEY `SALES_INVOICE_GRID_UPDATED_AT` (`updated_at`),
  KEY `SALES_INVOICE_GRID_ORDER_CREATED_AT` (`order_created_at`),
  KEY `SALES_INVOICE_GRID_BILLING_NAME` (`billing_name`),
  KEY `SALES_INVOICE_GRID_BASE_GRAND_TOTAL` (`base_grand_total`),
  FULLTEXT KEY `FTI_95D9C924DD6A8734EB8B5D01D60F90DE` (`increment_id`,`order_increment_id`,`billing_name`,`billing_address`,`shipping_address`,`customer_name`,`customer_email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Invoice Grid';

INSERT INTO `sales_invoice_grid` (`entity_id`, `increment_id`, `state`, `store_id`, `store_name`, `order_id`, `order_increment_id`, `order_created_at`, `customer_name`, `customer_email`, `customer_group_id`, `payment_method`, `store_currency_code`, `order_currency_code`, `base_currency_code`, `global_currency_code`, `billing_name`, `billing_address`, `shipping_address`, `shipping_information`, `subtotal`, `shipping_and_handling`, `grand_total`, `created_at`, `updated_at`, `base_grand_total`) VALUES
(1,	'000000001',	2,	1,	'Main Website\nMain Website Store\n',	3,	'000000003',	'2019-02-18 15:18:09',	'xavi nguyen',	'xnguyen@collinsharper.com',	1,	'chmoneriscc',	'USD',	'USD',	'USD',	'USD',	'phat nguyen',	'ho chi minh,ho chi minh,700000',	'ho chi minh,ho chi minh,700000',	'Flat Rate - Fixed',	10.0000,	5.0000,	15.0000,	'2019-02-18 15:18:47',	'2019-02-18 15:18:47',	15.0000);

DROP TABLE IF EXISTS `sales_invoice_item`;
CREATE TABLE `sales_invoice_item` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `base_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Price',
  `tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Amount',
  `base_row_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total',
  `discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Amount',
  `row_total` decimal(12,4) DEFAULT NULL COMMENT 'Row Total',
  `base_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Amount',
  `price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Price Incl Tax',
  `base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Amount',
  `base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Price Incl Tax',
  `qty` decimal(12,4) DEFAULT NULL COMMENT 'Qty',
  `base_cost` decimal(12,4) DEFAULT NULL COMMENT 'Base Cost',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `base_row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total Incl Tax',
  `row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Row Total Incl Tax',
  `product_id` int(11) DEFAULT NULL COMMENT 'Product Id',
  `order_item_id` int(11) DEFAULT NULL COMMENT 'Order Item Id',
  `additional_data` text COMMENT 'Additional Data',
  `description` text COMMENT 'Description',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `discount_tax_compensation_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Tax Compensation Amount',
  `base_discount_tax_compensation_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Tax Compensation Amount',
  `tax_ratio` text COMMENT 'Ratio of tax invoiced over tax of the order item',
  `weee_tax_applied` text COMMENT 'Weee Tax Applied',
  `weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Amount',
  `weee_tax_applied_row_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Row Amount',
  `weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Disposition',
  `weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Row Disposition',
  `base_weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Amount',
  `base_weee_tax_applied_row_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Row Amnt',
  `base_weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Disposition',
  `base_weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Row Disposition',
  PRIMARY KEY (`entity_id`),
  KEY `SALES_INVOICE_ITEM_PARENT_ID` (`parent_id`),
  CONSTRAINT `SALES_INVOICE_ITEM_PARENT_ID_SALES_INVOICE_ENTITY_ID` FOREIGN KEY (`parent_id`) REFERENCES `sales_invoice` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Invoice Item';

INSERT INTO `sales_invoice_item` (`entity_id`, `parent_id`, `base_price`, `tax_amount`, `base_row_total`, `discount_amount`, `row_total`, `base_discount_amount`, `price_incl_tax`, `base_tax_amount`, `base_price_incl_tax`, `qty`, `base_cost`, `price`, `base_row_total_incl_tax`, `row_total_incl_tax`, `product_id`, `order_item_id`, `additional_data`, `description`, `sku`, `name`, `discount_tax_compensation_amount`, `base_discount_tax_compensation_amount`, `tax_ratio`, `weee_tax_applied`, `weee_tax_applied_amount`, `weee_tax_applied_row_amount`, `weee_tax_disposition`, `weee_tax_row_disposition`, `base_weee_tax_applied_amount`, `base_weee_tax_applied_row_amnt`, `base_weee_tax_disposition`, `base_weee_tax_row_disposition`) VALUES
(1,	1,	10.0000,	0.0000,	10.0000,	NULL,	10.0000,	NULL,	10.0000,	0.0000,	10.0000,	1.0000,	NULL,	10.0000,	10.0000,	10.0000,	1,	3,	NULL,	NULL,	'Simple Product 1',	'Simple Product 1',	0.0000,	0.0000,	NULL,	'[]',	NULL,	0.0000,	NULL,	0.0000,	NULL,	NULL,	NULL,	0.0000);

DROP TABLE IF EXISTS `sales_order`;
CREATE TABLE `sales_order` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `state` varchar(32) DEFAULT NULL COMMENT 'State',
  `status` varchar(32) DEFAULT NULL COMMENT 'Status',
  `coupon_code` varchar(255) DEFAULT NULL COMMENT 'Coupon Code',
  `protect_code` varchar(255) DEFAULT NULL COMMENT 'Protect Code',
  `shipping_description` varchar(255) DEFAULT NULL COMMENT 'Shipping Description',
  `is_virtual` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Virtual',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `base_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Amount',
  `base_discount_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Canceled',
  `base_discount_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Invoiced',
  `base_discount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Refunded',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `base_shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Amount',
  `base_shipping_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Canceled',
  `base_shipping_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Invoiced',
  `base_shipping_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Refunded',
  `base_shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Tax Amount',
  `base_shipping_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Tax Refunded',
  `base_subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal',
  `base_subtotal_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Canceled',
  `base_subtotal_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Invoiced',
  `base_subtotal_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Refunded',
  `base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Amount',
  `base_tax_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Canceled',
  `base_tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Invoiced',
  `base_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Refunded',
  `base_to_global_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Global Rate',
  `base_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Order Rate',
  `base_total_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Canceled',
  `base_total_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Invoiced',
  `base_total_invoiced_cost` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Invoiced Cost',
  `base_total_offline_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Offline Refunded',
  `base_total_online_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Online Refunded',
  `base_total_paid` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Paid',
  `base_total_qty_ordered` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Qty Ordered',
  `base_total_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Refunded',
  `discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Amount',
  `discount_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Discount Canceled',
  `discount_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Discount Invoiced',
  `discount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Discount Refunded',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Amount',
  `shipping_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Canceled',
  `shipping_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Invoiced',
  `shipping_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Refunded',
  `shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Tax Amount',
  `shipping_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Tax Refunded',
  `store_to_base_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Base Rate',
  `store_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Order Rate',
  `subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal',
  `subtotal_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Canceled',
  `subtotal_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Invoiced',
  `subtotal_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Refunded',
  `tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Amount',
  `tax_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Tax Canceled',
  `tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Tax Invoiced',
  `tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Tax Refunded',
  `total_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Total Canceled',
  `total_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Total Invoiced',
  `total_offline_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Total Offline Refunded',
  `total_online_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Total Online Refunded',
  `total_paid` decimal(12,4) DEFAULT NULL COMMENT 'Total Paid',
  `total_qty_ordered` decimal(12,4) DEFAULT NULL COMMENT 'Total Qty Ordered',
  `total_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Total Refunded',
  `can_ship_partially` smallint(5) unsigned DEFAULT NULL COMMENT 'Can Ship Partially',
  `can_ship_partially_item` smallint(5) unsigned DEFAULT NULL COMMENT 'Can Ship Partially Item',
  `customer_is_guest` smallint(5) unsigned DEFAULT NULL COMMENT 'Customer Is Guest',
  `customer_note_notify` smallint(5) unsigned DEFAULT NULL COMMENT 'Customer Note Notify',
  `billing_address_id` int(11) DEFAULT NULL COMMENT 'Billing Address Id',
  `customer_group_id` int(11) DEFAULT NULL,
  `edit_increment` int(11) DEFAULT NULL COMMENT 'Edit Increment',
  `email_sent` smallint(5) unsigned DEFAULT NULL COMMENT 'Email Sent',
  `send_email` smallint(5) unsigned DEFAULT NULL COMMENT 'Send Email',
  `forced_shipment_with_invoice` smallint(5) unsigned DEFAULT NULL COMMENT 'Forced Do Shipment With Invoice',
  `payment_auth_expiration` int(11) DEFAULT NULL COMMENT 'Payment Authorization Expiration',
  `quote_address_id` int(11) DEFAULT NULL COMMENT 'Quote Address Id',
  `quote_id` int(11) DEFAULT NULL COMMENT 'Quote Id',
  `shipping_address_id` int(11) DEFAULT NULL COMMENT 'Shipping Address Id',
  `adjustment_negative` decimal(12,4) DEFAULT NULL COMMENT 'Adjustment Negative',
  `adjustment_positive` decimal(12,4) DEFAULT NULL COMMENT 'Adjustment Positive',
  `base_adjustment_negative` decimal(12,4) DEFAULT NULL COMMENT 'Base Adjustment Negative',
  `base_adjustment_positive` decimal(12,4) DEFAULT NULL COMMENT 'Base Adjustment Positive',
  `base_shipping_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Discount Amount',
  `base_subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Incl Tax',
  `base_total_due` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Due',
  `payment_authorization_amount` decimal(12,4) DEFAULT NULL COMMENT 'Payment Authorization Amount',
  `shipping_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Discount Amount',
  `subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Incl Tax',
  `total_due` decimal(12,4) DEFAULT NULL COMMENT 'Total Due',
  `weight` decimal(12,4) DEFAULT NULL COMMENT 'Weight',
  `customer_dob` datetime DEFAULT NULL COMMENT 'Customer Dob',
  `increment_id` varchar(32) DEFAULT NULL COMMENT 'Increment Id',
  `applied_rule_ids` varchar(128) DEFAULT NULL COMMENT 'Applied Rule Ids',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `customer_email` varchar(128) DEFAULT NULL COMMENT 'Customer Email',
  `customer_firstname` varchar(128) DEFAULT NULL COMMENT 'Customer Firstname',
  `customer_lastname` varchar(128) DEFAULT NULL COMMENT 'Customer Lastname',
  `customer_middlename` varchar(128) DEFAULT NULL COMMENT 'Customer Middlename',
  `customer_prefix` varchar(32) DEFAULT NULL COMMENT 'Customer Prefix',
  `customer_suffix` varchar(32) DEFAULT NULL COMMENT 'Customer Suffix',
  `customer_taxvat` varchar(32) DEFAULT NULL COMMENT 'Customer Taxvat',
  `discount_description` varchar(255) DEFAULT NULL COMMENT 'Discount Description',
  `ext_customer_id` varchar(32) DEFAULT NULL COMMENT 'Ext Customer Id',
  `ext_order_id` varchar(32) DEFAULT NULL COMMENT 'Ext Order Id',
  `global_currency_code` varchar(3) DEFAULT NULL COMMENT 'Global Currency Code',
  `hold_before_state` varchar(32) DEFAULT NULL COMMENT 'Hold Before State',
  `hold_before_status` varchar(32) DEFAULT NULL COMMENT 'Hold Before Status',
  `order_currency_code` varchar(3) DEFAULT NULL COMMENT 'Order Currency Code',
  `original_increment_id` varchar(32) DEFAULT NULL COMMENT 'Original Increment Id',
  `relation_child_id` varchar(32) DEFAULT NULL COMMENT 'Relation Child Id',
  `relation_child_real_id` varchar(32) DEFAULT NULL COMMENT 'Relation Child Real Id',
  `relation_parent_id` varchar(32) DEFAULT NULL COMMENT 'Relation Parent Id',
  `relation_parent_real_id` varchar(32) DEFAULT NULL COMMENT 'Relation Parent Real Id',
  `remote_ip` varchar(45) DEFAULT NULL COMMENT 'Remote Ip',
  `shipping_method` varchar(120) DEFAULT NULL,
  `store_currency_code` varchar(3) DEFAULT NULL COMMENT 'Store Currency Code',
  `store_name` varchar(32) DEFAULT NULL COMMENT 'Store Name',
  `x_forwarded_for` varchar(32) DEFAULT NULL COMMENT 'X Forwarded For',
  `customer_note` text COMMENT 'Customer Note',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Updated At',
  `total_item_count` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Total Item Count',
  `customer_gender` int(11) DEFAULT NULL COMMENT 'Customer Gender',
  `discount_tax_compensation_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Tax Compensation Amount',
  `base_discount_tax_compensation_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Tax Compensation Amount',
  `shipping_discount_tax_compensation_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Discount Tax Compensation Amount',
  `base_shipping_discount_tax_compensation_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Discount Tax Compensation Amount',
  `discount_tax_compensation_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Discount Tax Compensation Invoiced',
  `base_discount_tax_compensation_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Tax Compensation Invoiced',
  `discount_tax_compensation_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Discount Tax Compensation Refunded',
  `base_discount_tax_compensation_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Tax Compensation Refunded',
  `shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Incl Tax',
  `base_shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Incl Tax',
  `coupon_rule_name` varchar(255) DEFAULT NULL COMMENT 'Coupon Sales Rule Name',
  `paypal_ipn_customer_notified` int(11) DEFAULT '0' COMMENT 'Paypal Ipn Customer Notified',
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `SALES_ORDER_INCREMENT_ID_STORE_ID` (`increment_id`,`store_id`),
  KEY `SALES_ORDER_STATUS` (`status`),
  KEY `SALES_ORDER_STATE` (`state`),
  KEY `SALES_ORDER_STORE_ID` (`store_id`),
  KEY `SALES_ORDER_CREATED_AT` (`created_at`),
  KEY `SALES_ORDER_CUSTOMER_ID` (`customer_id`),
  KEY `SALES_ORDER_EXT_ORDER_ID` (`ext_order_id`),
  KEY `SALES_ORDER_QUOTE_ID` (`quote_id`),
  KEY `SALES_ORDER_UPDATED_AT` (`updated_at`),
  KEY `SALES_ORDER_SEND_EMAIL` (`send_email`),
  KEY `SALES_ORDER_EMAIL_SENT` (`email_sent`),
  CONSTRAINT `SALES_ORDER_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE SET NULL,
  CONSTRAINT `SALES_ORDER_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order';

INSERT INTO `sales_order` (`entity_id`, `state`, `status`, `coupon_code`, `protect_code`, `shipping_description`, `is_virtual`, `store_id`, `customer_id`, `base_discount_amount`, `base_discount_canceled`, `base_discount_invoiced`, `base_discount_refunded`, `base_grand_total`, `base_shipping_amount`, `base_shipping_canceled`, `base_shipping_invoiced`, `base_shipping_refunded`, `base_shipping_tax_amount`, `base_shipping_tax_refunded`, `base_subtotal`, `base_subtotal_canceled`, `base_subtotal_invoiced`, `base_subtotal_refunded`, `base_tax_amount`, `base_tax_canceled`, `base_tax_invoiced`, `base_tax_refunded`, `base_to_global_rate`, `base_to_order_rate`, `base_total_canceled`, `base_total_invoiced`, `base_total_invoiced_cost`, `base_total_offline_refunded`, `base_total_online_refunded`, `base_total_paid`, `base_total_qty_ordered`, `base_total_refunded`, `discount_amount`, `discount_canceled`, `discount_invoiced`, `discount_refunded`, `grand_total`, `shipping_amount`, `shipping_canceled`, `shipping_invoiced`, `shipping_refunded`, `shipping_tax_amount`, `shipping_tax_refunded`, `store_to_base_rate`, `store_to_order_rate`, `subtotal`, `subtotal_canceled`, `subtotal_invoiced`, `subtotal_refunded`, `tax_amount`, `tax_canceled`, `tax_invoiced`, `tax_refunded`, `total_canceled`, `total_invoiced`, `total_offline_refunded`, `total_online_refunded`, `total_paid`, `total_qty_ordered`, `total_refunded`, `can_ship_partially`, `can_ship_partially_item`, `customer_is_guest`, `customer_note_notify`, `billing_address_id`, `customer_group_id`, `edit_increment`, `email_sent`, `send_email`, `forced_shipment_with_invoice`, `payment_auth_expiration`, `quote_address_id`, `quote_id`, `shipping_address_id`, `adjustment_negative`, `adjustment_positive`, `base_adjustment_negative`, `base_adjustment_positive`, `base_shipping_discount_amount`, `base_subtotal_incl_tax`, `base_total_due`, `payment_authorization_amount`, `shipping_discount_amount`, `subtotal_incl_tax`, `total_due`, `weight`, `customer_dob`, `increment_id`, `applied_rule_ids`, `base_currency_code`, `customer_email`, `customer_firstname`, `customer_lastname`, `customer_middlename`, `customer_prefix`, `customer_suffix`, `customer_taxvat`, `discount_description`, `ext_customer_id`, `ext_order_id`, `global_currency_code`, `hold_before_state`, `hold_before_status`, `order_currency_code`, `original_increment_id`, `relation_child_id`, `relation_child_real_id`, `relation_parent_id`, `relation_parent_real_id`, `remote_ip`, `shipping_method`, `store_currency_code`, `store_name`, `x_forwarded_for`, `customer_note`, `created_at`, `updated_at`, `total_item_count`, `customer_gender`, `discount_tax_compensation_amount`, `base_discount_tax_compensation_amount`, `shipping_discount_tax_compensation_amount`, `base_shipping_discount_tax_compensation_amnt`, `discount_tax_compensation_invoiced`, `base_discount_tax_compensation_invoiced`, `discount_tax_compensation_refunded`, `base_discount_tax_compensation_refunded`, `shipping_incl_tax`, `base_shipping_incl_tax`, `coupon_rule_name`, `paypal_ipn_customer_notified`, `gift_message_id`) VALUES
(1,	'new',	'pending',	NULL,	'b930f852b64ebb807b19c551e5bf6ff1',	'Flat Rate - Fixed',	0,	1,	1,	0.0000,	NULL,	NULL,	NULL,	15.0000,	5.0000,	NULL,	NULL,	NULL,	0.0000,	NULL,	10.0000,	NULL,	NULL,	NULL,	0.0000,	NULL,	NULL,	NULL,	1.0000,	1.0000,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0.0000,	NULL,	NULL,	NULL,	15.0000,	5.0000,	NULL,	NULL,	NULL,	0.0000,	NULL,	0.0000,	0.0000,	10.0000,	NULL,	NULL,	NULL,	0.0000,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	1.0000,	NULL,	NULL,	NULL,	0,	1,	2,	1,	NULL,	NULL,	1,	NULL,	NULL,	NULL,	1,	1,	NULL,	NULL,	NULL,	NULL,	0.0000,	10.0000,	15.0000,	NULL,	0.0000,	10.0000,	15.0000,	0.2000,	NULL,	'000000001',	NULL,	'USD',	'xnguyen@collinsharper.com',	'xavi',	'nguyen',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'USD',	NULL,	NULL,	'USD',	NULL,	NULL,	NULL,	NULL,	NULL,	'172.22.0.1',	'flatrate_flatrate',	'USD',	'Main Website\nMain Website Store\n',	NULL,	NULL,	'2019-02-18 15:10:16',	'2019-02-18 15:10:17',	1,	NULL,	0.0000,	0.0000,	0.0000,	0.0000,	NULL,	NULL,	NULL,	NULL,	5.0000,	5.0000,	NULL,	0,	NULL),
(2,	'processing',	'processing',	NULL,	'22e9c94697fcb463c2c9b6f8d2ae0d48',	'Flat Rate - Fixed',	0,	1,	1,	0.0000,	NULL,	NULL,	NULL,	15.0000,	5.0000,	NULL,	NULL,	NULL,	0.0000,	NULL,	10.0000,	NULL,	NULL,	NULL,	0.0000,	NULL,	NULL,	NULL,	1.0000,	1.0000,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0.0000,	NULL,	NULL,	NULL,	15.0000,	5.0000,	NULL,	NULL,	NULL,	0.0000,	NULL,	0.0000,	0.0000,	10.0000,	NULL,	NULL,	NULL,	0.0000,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	1.0000,	NULL,	NULL,	NULL,	0,	1,	4,	1,	NULL,	NULL,	1,	NULL,	NULL,	NULL,	2,	3,	NULL,	NULL,	NULL,	NULL,	0.0000,	10.0000,	15.0000,	NULL,	0.0000,	10.0000,	15.0000,	0.2000,	NULL,	'000000002',	NULL,	'USD',	'xnguyen@collinsharper.com',	'xavi',	'nguyen',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'USD',	NULL,	NULL,	'USD',	NULL,	NULL,	NULL,	NULL,	NULL,	'172.22.0.1',	'flatrate_flatrate',	'USD',	'Main Website\nMain Website Store\n',	NULL,	NULL,	'2019-02-18 15:16:51',	'2019-02-18 15:16:53',	1,	NULL,	0.0000,	0.0000,	0.0000,	0.0000,	NULL,	NULL,	NULL,	NULL,	5.0000,	5.0000,	NULL,	0,	NULL),
(3,	'processing',	'processing',	NULL,	'728066614d057d5bb19b14509fc7c9b6',	'Flat Rate - Fixed',	0,	1,	1,	0.0000,	NULL,	0.0000,	NULL,	15.0000,	5.0000,	NULL,	5.0000,	NULL,	0.0000,	NULL,	10.0000,	NULL,	10.0000,	NULL,	0.0000,	NULL,	0.0000,	NULL,	1.0000,	1.0000,	NULL,	15.0000,	0.0000,	NULL,	NULL,	15.0000,	NULL,	NULL,	0.0000,	NULL,	0.0000,	NULL,	15.0000,	5.0000,	NULL,	5.0000,	NULL,	0.0000,	NULL,	0.0000,	0.0000,	10.0000,	NULL,	10.0000,	NULL,	0.0000,	NULL,	0.0000,	NULL,	NULL,	15.0000,	NULL,	NULL,	15.0000,	1.0000,	NULL,	NULL,	NULL,	0,	0,	6,	1,	NULL,	NULL,	1,	NULL,	NULL,	NULL,	3,	5,	NULL,	NULL,	NULL,	NULL,	0.0000,	10.0000,	0.0000,	NULL,	0.0000,	10.0000,	0.0000,	0.2000,	NULL,	'000000003',	NULL,	'USD',	'xnguyen@collinsharper.com',	'xavi',	'nguyen',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'USD',	NULL,	NULL,	'USD',	NULL,	NULL,	NULL,	NULL,	NULL,	'172.22.0.1',	'flatrate_flatrate',	'USD',	'Main Website\nMain Website Store\n',	NULL,	NULL,	'2019-02-18 15:18:09',	'2019-02-18 15:18:47',	1,	NULL,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	NULL,	NULL,	5.0000,	5.0000,	NULL,	0,	NULL);

DROP TABLE IF EXISTS `sales_order_address`;
CREATE TABLE `sales_order_address` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Id',
  `customer_address_id` int(11) DEFAULT NULL COMMENT 'Customer Address Id',
  `quote_address_id` int(11) DEFAULT NULL COMMENT 'Quote Address Id',
  `region_id` int(11) DEFAULT NULL COMMENT 'Region Id',
  `customer_id` int(11) DEFAULT NULL COMMENT 'Customer Id',
  `fax` varchar(255) DEFAULT NULL COMMENT 'Fax',
  `region` varchar(255) DEFAULT NULL COMMENT 'Region',
  `postcode` varchar(255) DEFAULT NULL COMMENT 'Postcode',
  `lastname` varchar(255) DEFAULT NULL COMMENT 'Lastname',
  `street` varchar(255) DEFAULT NULL COMMENT 'Street',
  `city` varchar(255) DEFAULT NULL COMMENT 'City',
  `email` varchar(255) DEFAULT NULL COMMENT 'Email',
  `telephone` varchar(255) DEFAULT NULL COMMENT 'Phone Number',
  `country_id` varchar(2) DEFAULT NULL COMMENT 'Country Id',
  `firstname` varchar(255) DEFAULT NULL COMMENT 'Firstname',
  `address_type` varchar(255) DEFAULT NULL COMMENT 'Address Type',
  `prefix` varchar(255) DEFAULT NULL COMMENT 'Prefix',
  `middlename` varchar(255) DEFAULT NULL COMMENT 'Middlename',
  `suffix` varchar(255) DEFAULT NULL COMMENT 'Suffix',
  `company` varchar(255) DEFAULT NULL COMMENT 'Company',
  `vat_id` text COMMENT 'Vat Id',
  `vat_is_valid` smallint(6) DEFAULT NULL COMMENT 'Vat Is Valid',
  `vat_request_id` text COMMENT 'Vat Request Id',
  `vat_request_date` text COMMENT 'Vat Request Date',
  `vat_request_success` smallint(6) DEFAULT NULL COMMENT 'Vat Request Success',
  PRIMARY KEY (`entity_id`),
  KEY `SALES_ORDER_ADDRESS_PARENT_ID` (`parent_id`),
  CONSTRAINT `SALES_ORDER_ADDRESS_PARENT_ID_SALES_ORDER_ENTITY_ID` FOREIGN KEY (`parent_id`) REFERENCES `sales_order` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order Address';

INSERT INTO `sales_order_address` (`entity_id`, `parent_id`, `customer_address_id`, `quote_address_id`, `region_id`, `customer_id`, `fax`, `region`, `postcode`, `lastname`, `street`, `city`, `email`, `telephone`, `country_id`, `firstname`, `address_type`, `prefix`, `middlename`, `suffix`, `company`, `vat_id`, `vat_is_valid`, `vat_request_id`, `vat_request_date`, `vat_request_success`) VALUES
(1,	1,	1,	2,	NULL,	NULL,	NULL,	NULL,	'700000',	'nguyen',	'ho chi minh',	'ho chi minh',	'xnguyen@collinsharper.com',	'123213213',	'VN',	'phat',	'shipping',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(2,	1,	NULL,	3,	NULL,	NULL,	NULL,	NULL,	'700000',	'nguyen',	'ho chi minh',	'ho chi minh',	'xnguyen@collinsharper.com',	'123213213',	'VN',	'phat',	'billing',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(3,	2,	1,	5,	NULL,	NULL,	NULL,	NULL,	'700000',	'nguyen',	'ho chi minh',	'ho chi minh',	'xnguyen@collinsharper.com',	'123213213',	'VN',	'phat',	'shipping',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(4,	2,	1,	6,	NULL,	NULL,	NULL,	NULL,	'700000',	'nguyen',	'ho chi minh',	'ho chi minh',	'xnguyen@collinsharper.com',	'123213213',	'VN',	'phat',	'billing',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(5,	3,	1,	8,	NULL,	NULL,	NULL,	NULL,	'700000',	'nguyen',	'ho chi minh',	'ho chi minh',	'xnguyen@collinsharper.com',	'123213213',	'VN',	'phat',	'shipping',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(6,	3,	1,	9,	NULL,	NULL,	NULL,	NULL,	'700000',	'nguyen',	'ho chi minh',	'ho chi minh',	'xnguyen@collinsharper.com',	'123213213',	'VN',	'phat',	'billing',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);

DROP TABLE IF EXISTS `sales_order_aggregated_created`;
CREATE TABLE `sales_order_aggregated_created` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) NOT NULL COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `total_qty_ordered` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Qty Ordered',
  `total_qty_invoiced` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Qty Invoiced',
  `total_income_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Income Amount',
  `total_revenue_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Revenue Amount',
  `total_profit_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Profit Amount',
  `total_invoiced_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Invoiced Amount',
  `total_canceled_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Canceled Amount',
  `total_paid_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Paid Amount',
  `total_refunded_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Refunded Amount',
  `total_tax_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Tax Amount',
  `total_tax_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Tax Amount Actual',
  `total_shipping_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Shipping Amount',
  `total_shipping_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Shipping Amount Actual',
  `total_discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Discount Amount',
  `total_discount_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Discount Amount Actual',
  PRIMARY KEY (`id`),
  UNIQUE KEY `SALES_ORDER_AGGREGATED_CREATED_PERIOD_STORE_ID_ORDER_STATUS` (`period`,`store_id`,`order_status`),
  KEY `SALES_ORDER_AGGREGATED_CREATED_STORE_ID` (`store_id`),
  CONSTRAINT `SALES_ORDER_AGGREGATED_CREATED_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Aggregated Created';


DROP TABLE IF EXISTS `sales_order_aggregated_updated`;
CREATE TABLE `sales_order_aggregated_updated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) NOT NULL COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `total_qty_ordered` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Qty Ordered',
  `total_qty_invoiced` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Qty Invoiced',
  `total_income_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Income Amount',
  `total_revenue_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Revenue Amount',
  `total_profit_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Profit Amount',
  `total_invoiced_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Invoiced Amount',
  `total_canceled_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Canceled Amount',
  `total_paid_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Paid Amount',
  `total_refunded_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Refunded Amount',
  `total_tax_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Tax Amount',
  `total_tax_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Tax Amount Actual',
  `total_shipping_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Shipping Amount',
  `total_shipping_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Shipping Amount Actual',
  `total_discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Discount Amount',
  `total_discount_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Discount Amount Actual',
  PRIMARY KEY (`id`),
  UNIQUE KEY `SALES_ORDER_AGGREGATED_UPDATED_PERIOD_STORE_ID_ORDER_STATUS` (`period`,`store_id`,`order_status`),
  KEY `SALES_ORDER_AGGREGATED_UPDATED_STORE_ID` (`store_id`),
  CONSTRAINT `SALES_ORDER_AGGREGATED_UPDATED_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Aggregated Updated';


DROP TABLE IF EXISTS `sales_order_grid`;
CREATE TABLE `sales_order_grid` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `status` varchar(32) DEFAULT NULL COMMENT 'Status',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `store_name` varchar(255) DEFAULT NULL COMMENT 'Store Name',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `base_total_paid` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Paid',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `total_paid` decimal(12,4) DEFAULT NULL COMMENT 'Total Paid',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `order_currency_code` varchar(255) DEFAULT NULL COMMENT 'Order Currency Code',
  `shipping_name` varchar(255) DEFAULT NULL COMMENT 'Shipping Name',
  `billing_name` varchar(255) DEFAULT NULL COMMENT 'Billing Name',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `billing_address` varchar(255) DEFAULT NULL COMMENT 'Billing Address',
  `shipping_address` varchar(255) DEFAULT NULL COMMENT 'Shipping Address',
  `shipping_information` varchar(255) DEFAULT NULL COMMENT 'Shipping Method Name',
  `customer_email` varchar(255) DEFAULT NULL COMMENT 'Customer Email',
  `customer_group` varchar(255) DEFAULT NULL COMMENT 'Customer Group',
  `subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal',
  `shipping_and_handling` decimal(12,4) DEFAULT NULL COMMENT 'Shipping and handling amount',
  `customer_name` varchar(255) DEFAULT NULL COMMENT 'Customer Name',
  `payment_method` varchar(255) DEFAULT NULL COMMENT 'Payment Method',
  `total_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Total Refunded',
  `signifyd_guarantee_status` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `SALES_ORDER_GRID_INCREMENT_ID_STORE_ID` (`increment_id`,`store_id`),
  KEY `SALES_ORDER_GRID_STATUS` (`status`),
  KEY `SALES_ORDER_GRID_STORE_ID` (`store_id`),
  KEY `SALES_ORDER_GRID_BASE_GRAND_TOTAL` (`base_grand_total`),
  KEY `SALES_ORDER_GRID_BASE_TOTAL_PAID` (`base_total_paid`),
  KEY `SALES_ORDER_GRID_GRAND_TOTAL` (`grand_total`),
  KEY `SALES_ORDER_GRID_TOTAL_PAID` (`total_paid`),
  KEY `SALES_ORDER_GRID_SHIPPING_NAME` (`shipping_name`),
  KEY `SALES_ORDER_GRID_BILLING_NAME` (`billing_name`),
  KEY `SALES_ORDER_GRID_CREATED_AT` (`created_at`),
  KEY `SALES_ORDER_GRID_CUSTOMER_ID` (`customer_id`),
  KEY `SALES_ORDER_GRID_UPDATED_AT` (`updated_at`),
  FULLTEXT KEY `FTI_65B9E9925EC58F0C7C2E2F6379C233E7` (`increment_id`,`billing_name`,`shipping_name`,`shipping_address`,`billing_address`,`customer_name`,`customer_email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order Grid';

INSERT INTO `sales_order_grid` (`entity_id`, `status`, `store_id`, `store_name`, `customer_id`, `base_grand_total`, `base_total_paid`, `grand_total`, `total_paid`, `increment_id`, `base_currency_code`, `order_currency_code`, `shipping_name`, `billing_name`, `created_at`, `updated_at`, `billing_address`, `shipping_address`, `shipping_information`, `customer_email`, `customer_group`, `subtotal`, `shipping_and_handling`, `customer_name`, `payment_method`, `total_refunded`, `signifyd_guarantee_status`) VALUES
(1,	'pending',	1,	'Main Website\nMain Website Store\n',	1,	15.0000,	NULL,	15.0000,	NULL,	'000000001',	'USD',	'USD',	'phat nguyen',	'phat nguyen',	'2019-02-18 15:10:16',	'2019-02-18 15:10:16',	'ho chi minh,ho chi minh,700000',	'ho chi minh,ho chi minh,700000',	'Flat Rate - Fixed',	'xnguyen@collinsharper.com',	'1',	10.0000,	5.0000,	'xavi nguyen',	'checkmo',	NULL,	NULL),
(2,	'processing',	1,	'Main Website\nMain Website Store\n',	1,	15.0000,	NULL,	15.0000,	NULL,	'000000002',	'USD',	'USD',	'phat nguyen',	'phat nguyen',	'2019-02-18 15:16:51',	'2019-02-18 15:16:52',	'ho chi minh,ho chi minh,700000',	'ho chi minh,ho chi minh,700000',	'Flat Rate - Fixed',	'xnguyen@collinsharper.com',	'1',	10.0000,	5.0000,	'xavi nguyen',	'chmoneriscc',	NULL,	NULL),
(3,	'processing',	1,	'Main Website\nMain Website Store\n',	1,	15.0000,	15.0000,	15.0000,	15.0000,	'000000003',	'USD',	'USD',	'phat nguyen',	'phat nguyen',	'2019-02-18 15:18:09',	'2019-02-18 15:18:47',	'ho chi minh,ho chi minh,700000',	'ho chi minh,ho chi minh,700000',	'Flat Rate - Fixed',	'xnguyen@collinsharper.com',	'1',	10.0000,	5.0000,	'xavi nguyen',	'chmoneriscc',	NULL,	NULL);

DROP TABLE IF EXISTS `sales_order_item`;
CREATE TABLE `sales_order_item` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Item Id',
  `order_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Order Id',
  `parent_item_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Item Id',
  `quote_item_id` int(10) unsigned DEFAULT NULL COMMENT 'Quote Item Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Updated At',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_type` varchar(255) DEFAULT NULL COMMENT 'Product Type',
  `product_options` text COMMENT 'Product Options',
  `weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Weight',
  `is_virtual` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Virtual',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `description` text COMMENT 'Description',
  `applied_rule_ids` text COMMENT 'Applied Rule Ids',
  `additional_data` text COMMENT 'Additional Data',
  `is_qty_decimal` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Qty Decimal',
  `no_discount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'No Discount',
  `qty_backordered` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Backordered',
  `qty_canceled` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Canceled',
  `qty_invoiced` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Invoiced',
  `qty_ordered` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Ordered',
  `qty_refunded` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Refunded',
  `qty_shipped` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Shipped',
  `base_cost` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Cost',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `base_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Price',
  `original_price` decimal(12,4) DEFAULT NULL COMMENT 'Original Price',
  `base_original_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Original Price',
  `tax_percent` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Percent',
  `tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Amount',
  `base_tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Tax Amount',
  `tax_invoiced` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Invoiced',
  `base_tax_invoiced` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Tax Invoiced',
  `discount_percent` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Percent',
  `discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Amount',
  `base_discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Discount Amount',
  `discount_invoiced` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Invoiced',
  `base_discount_invoiced` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Discount Invoiced',
  `amount_refunded` decimal(12,4) DEFAULT '0.0000' COMMENT 'Amount Refunded',
  `base_amount_refunded` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Amount Refunded',
  `row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Row Total',
  `base_row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Row Total',
  `row_invoiced` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Row Invoiced',
  `base_row_invoiced` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Row Invoiced',
  `row_weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Row Weight',
  `base_tax_before_discount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Before Discount',
  `tax_before_discount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Before Discount',
  `ext_order_item_id` varchar(255) DEFAULT NULL COMMENT 'Ext Order Item Id',
  `locked_do_invoice` smallint(5) unsigned DEFAULT NULL COMMENT 'Locked Do Invoice',
  `locked_do_ship` smallint(5) unsigned DEFAULT NULL COMMENT 'Locked Do Ship',
  `price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Price Incl Tax',
  `base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Price Incl Tax',
  `row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Row Total Incl Tax',
  `base_row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total Incl Tax',
  `discount_tax_compensation_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Tax Compensation Amount',
  `base_discount_tax_compensation_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Tax Compensation Amount',
  `discount_tax_compensation_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Discount Tax Compensation Invoiced',
  `base_discount_tax_compensation_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Tax Compensation Invoiced',
  `discount_tax_compensation_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Discount Tax Compensation Refunded',
  `base_discount_tax_compensation_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Tax Compensation Refunded',
  `tax_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Tax Canceled',
  `discount_tax_compensation_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Discount Tax Compensation Canceled',
  `tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Tax Refunded',
  `base_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Refunded',
  `discount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Discount Refunded',
  `base_discount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Refunded',
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  `gift_message_available` int(11) DEFAULT NULL COMMENT 'Gift Message Available',
  `free_shipping` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Free Shipping',
  `weee_tax_applied` text COMMENT 'Weee Tax Applied',
  `weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Amount',
  `weee_tax_applied_row_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Row Amount',
  `weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Disposition',
  `weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Row Disposition',
  `base_weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Amount',
  `base_weee_tax_applied_row_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Row Amnt',
  `base_weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Disposition',
  `base_weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Row Disposition',
  PRIMARY KEY (`item_id`),
  KEY `SALES_ORDER_ITEM_ORDER_ID` (`order_id`),
  KEY `SALES_ORDER_ITEM_STORE_ID` (`store_id`),
  CONSTRAINT `SALES_ORDER_ITEM_ORDER_ID_SALES_ORDER_ENTITY_ID` FOREIGN KEY (`order_id`) REFERENCES `sales_order` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `SALES_ORDER_ITEM_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order Item';

INSERT INTO `sales_order_item` (`item_id`, `order_id`, `parent_item_id`, `quote_item_id`, `store_id`, `created_at`, `updated_at`, `product_id`, `product_type`, `product_options`, `weight`, `is_virtual`, `sku`, `name`, `description`, `applied_rule_ids`, `additional_data`, `is_qty_decimal`, `no_discount`, `qty_backordered`, `qty_canceled`, `qty_invoiced`, `qty_ordered`, `qty_refunded`, `qty_shipped`, `base_cost`, `price`, `base_price`, `original_price`, `base_original_price`, `tax_percent`, `tax_amount`, `base_tax_amount`, `tax_invoiced`, `base_tax_invoiced`, `discount_percent`, `discount_amount`, `base_discount_amount`, `discount_invoiced`, `base_discount_invoiced`, `amount_refunded`, `base_amount_refunded`, `row_total`, `base_row_total`, `row_invoiced`, `base_row_invoiced`, `row_weight`, `base_tax_before_discount`, `tax_before_discount`, `ext_order_item_id`, `locked_do_invoice`, `locked_do_ship`, `price_incl_tax`, `base_price_incl_tax`, `row_total_incl_tax`, `base_row_total_incl_tax`, `discount_tax_compensation_amount`, `base_discount_tax_compensation_amount`, `discount_tax_compensation_invoiced`, `base_discount_tax_compensation_invoiced`, `discount_tax_compensation_refunded`, `base_discount_tax_compensation_refunded`, `tax_canceled`, `discount_tax_compensation_canceled`, `tax_refunded`, `base_tax_refunded`, `discount_refunded`, `base_discount_refunded`, `gift_message_id`, `gift_message_available`, `free_shipping`, `weee_tax_applied`, `weee_tax_applied_amount`, `weee_tax_applied_row_amount`, `weee_tax_disposition`, `weee_tax_row_disposition`, `base_weee_tax_applied_amount`, `base_weee_tax_applied_row_amnt`, `base_weee_tax_disposition`, `base_weee_tax_row_disposition`) VALUES
(1,	1,	NULL,	1,	1,	'2019-02-18 15:10:16',	'2019-02-18 15:10:16',	1,	'simple',	'{\"info_buyRequest\":{\"uenc\":\"aHR0cDovL21hZ2VudG8yMy5sb2NhbC8,\",\"product\":\"1\",\"qty\":1}}',	0.2000,	0,	'Simple Product 1',	'Simple Product 1',	NULL,	NULL,	NULL,	0,	0,	NULL,	0.0000,	0.0000,	1.0000,	0.0000,	0.0000,	NULL,	10.0000,	10.0000,	10.0000,	10.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	10.0000,	10.0000,	0.0000,	0.0000,	0.2000,	NULL,	NULL,	NULL,	NULL,	NULL,	10.0000,	10.0000,	10.0000,	10.0000,	0.0000,	0.0000,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(2,	2,	NULL,	2,	1,	'2019-02-18 15:16:51',	'2019-02-18 15:16:51',	1,	'simple',	'{\"info_buyRequest\":{\"uenc\":\"aHR0cDovL21hZ2VudG8yMy5sb2NhbC8,\",\"product\":\"1\",\"qty\":1}}',	0.2000,	0,	'Simple Product 1',	'Simple Product 1',	NULL,	NULL,	NULL,	0,	0,	NULL,	0.0000,	0.0000,	1.0000,	0.0000,	0.0000,	NULL,	10.0000,	10.0000,	10.0000,	10.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	10.0000,	10.0000,	0.0000,	0.0000,	0.2000,	NULL,	NULL,	NULL,	NULL,	NULL,	10.0000,	10.0000,	10.0000,	10.0000,	0.0000,	0.0000,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(3,	3,	NULL,	3,	1,	'2019-02-18 15:18:10',	'2019-02-18 15:18:47',	1,	'simple',	'{\"info_buyRequest\":{\"uenc\":\"aHR0cDovL21hZ2VudG8yMy5sb2NhbC8,\",\"product\":\"1\",\"qty\":1}}',	0.2000,	0,	'Simple Product 1',	'Simple Product 1',	NULL,	NULL,	NULL,	0,	0,	NULL,	0.0000,	1.0000,	1.0000,	0.0000,	0.0000,	NULL,	10.0000,	10.0000,	10.0000,	10.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	0.0000,	10.0000,	10.0000,	10.0000,	10.0000,	0.2000,	NULL,	NULL,	NULL,	NULL,	NULL,	10.0000,	10.0000,	10.0000,	10.0000,	0.0000,	0.0000,	0.0000,	0.0000,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0,	'[]',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);

DROP TABLE IF EXISTS `sales_order_payment`;
CREATE TABLE `sales_order_payment` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `base_shipping_captured` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Captured',
  `shipping_captured` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Captured',
  `amount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Amount Refunded',
  `base_amount_paid` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Paid',
  `amount_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Amount Canceled',
  `base_amount_authorized` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Authorized',
  `base_amount_paid_online` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Paid Online',
  `base_amount_refunded_online` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Refunded Online',
  `base_shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Amount',
  `shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Amount',
  `amount_paid` decimal(12,4) DEFAULT NULL COMMENT 'Amount Paid',
  `amount_authorized` decimal(12,4) DEFAULT NULL COMMENT 'Amount Authorized',
  `base_amount_ordered` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Ordered',
  `base_shipping_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Refunded',
  `shipping_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Refunded',
  `base_amount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Refunded',
  `amount_ordered` decimal(12,4) DEFAULT NULL COMMENT 'Amount Ordered',
  `base_amount_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Canceled',
  `quote_payment_id` int(11) DEFAULT NULL COMMENT 'Quote Payment Id',
  `additional_data` text COMMENT 'Additional Data',
  `cc_exp_month` varchar(12) DEFAULT NULL COMMENT 'Cc Exp Month',
  `cc_ss_start_year` varchar(12) DEFAULT NULL COMMENT 'Cc Ss Start Year',
  `echeck_bank_name` varchar(128) DEFAULT NULL COMMENT 'Echeck Bank Name',
  `method` varchar(128) DEFAULT NULL COMMENT 'Method',
  `cc_debug_request_body` varchar(32) DEFAULT NULL COMMENT 'Cc Debug Request Body',
  `cc_secure_verify` varchar(32) DEFAULT NULL COMMENT 'Cc Secure Verify',
  `protection_eligibility` varchar(32) DEFAULT NULL COMMENT 'Protection Eligibility',
  `cc_approval` varchar(32) DEFAULT NULL COMMENT 'Cc Approval',
  `cc_last_4` varchar(100) DEFAULT NULL COMMENT 'Cc Last 4',
  `cc_status_description` varchar(32) DEFAULT NULL COMMENT 'Cc Status Description',
  `echeck_type` varchar(32) DEFAULT NULL COMMENT 'Echeck Type',
  `cc_debug_response_serialized` varchar(32) DEFAULT NULL COMMENT 'Cc Debug Response Serialized',
  `cc_ss_start_month` varchar(128) DEFAULT NULL COMMENT 'Cc Ss Start Month',
  `echeck_account_type` varchar(255) DEFAULT NULL COMMENT 'Echeck Account Type',
  `last_trans_id` varchar(32) DEFAULT NULL COMMENT 'Last Trans Id',
  `cc_cid_status` varchar(32) DEFAULT NULL COMMENT 'Cc Cid Status',
  `cc_owner` varchar(128) DEFAULT NULL COMMENT 'Cc Owner',
  `cc_type` varchar(32) DEFAULT NULL COMMENT 'Cc Type',
  `po_number` varchar(32) DEFAULT NULL COMMENT 'Po Number',
  `cc_exp_year` varchar(4) DEFAULT NULL COMMENT 'Cc Exp Year',
  `cc_status` varchar(4) DEFAULT NULL COMMENT 'Cc Status',
  `echeck_routing_number` varchar(32) DEFAULT NULL COMMENT 'Echeck Routing Number',
  `account_status` varchar(32) DEFAULT NULL COMMENT 'Account Status',
  `anet_trans_method` varchar(32) DEFAULT NULL COMMENT 'Anet Trans Method',
  `cc_debug_response_body` varchar(32) DEFAULT NULL COMMENT 'Cc Debug Response Body',
  `cc_ss_issue` varchar(32) DEFAULT NULL COMMENT 'Cc Ss Issue',
  `echeck_account_name` varchar(32) DEFAULT NULL COMMENT 'Echeck Account Name',
  `cc_avs_status` varchar(32) DEFAULT NULL COMMENT 'Cc Avs Status',
  `cc_number_enc` varchar(128) DEFAULT NULL,
  `cc_trans_id` varchar(32) DEFAULT NULL COMMENT 'Cc Trans Id',
  `address_status` varchar(32) DEFAULT NULL COMMENT 'Address Status',
  `additional_information` text COMMENT 'Additional Information',
  PRIMARY KEY (`entity_id`),
  KEY `SALES_ORDER_PAYMENT_PARENT_ID` (`parent_id`),
  CONSTRAINT `SALES_ORDER_PAYMENT_PARENT_ID_SALES_ORDER_ENTITY_ID` FOREIGN KEY (`parent_id`) REFERENCES `sales_order` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order Payment';

INSERT INTO `sales_order_payment` (`entity_id`, `parent_id`, `base_shipping_captured`, `shipping_captured`, `amount_refunded`, `base_amount_paid`, `amount_canceled`, `base_amount_authorized`, `base_amount_paid_online`, `base_amount_refunded_online`, `base_shipping_amount`, `shipping_amount`, `amount_paid`, `amount_authorized`, `base_amount_ordered`, `base_shipping_refunded`, `shipping_refunded`, `base_amount_refunded`, `amount_ordered`, `base_amount_canceled`, `quote_payment_id`, `additional_data`, `cc_exp_month`, `cc_ss_start_year`, `echeck_bank_name`, `method`, `cc_debug_request_body`, `cc_secure_verify`, `protection_eligibility`, `cc_approval`, `cc_last_4`, `cc_status_description`, `echeck_type`, `cc_debug_response_serialized`, `cc_ss_start_month`, `echeck_account_type`, `last_trans_id`, `cc_cid_status`, `cc_owner`, `cc_type`, `po_number`, `cc_exp_year`, `cc_status`, `echeck_routing_number`, `account_status`, `anet_trans_method`, `cc_debug_response_body`, `cc_ss_issue`, `echeck_account_name`, `cc_avs_status`, `cc_number_enc`, `cc_trans_id`, `address_status`, `additional_information`) VALUES
(1,	1,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	5.0000,	5.0000,	NULL,	NULL,	15.0000,	NULL,	NULL,	NULL,	15.0000,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'checkmo',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'{\"method_title\":\"Check \\/ Money order\"}'),
(2,	2,	NULL,	NULL,	NULL,	NULL,	NULL,	15.0000,	NULL,	NULL,	5.0000,	5.0000,	NULL,	15.0000,	15.0000,	NULL,	NULL,	NULL,	15.0000,	NULL,	NULL,	NULL,	'1',	NULL,	NULL,	'chmoneriscc',	NULL,	NULL,	NULL,	'967461',	'5454',	NULL,	NULL,	NULL,	NULL,	NULL,	'880716-0_13',	NULL,	NULL,	'MC',	NULL,	'2023',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'880716-0_13',	NULL,	'{\"method_title\":\"Moneris Credit Card\",\"payment_type\":\"authorize\",\"receipt_id\":\"000000002-52340651370729182035\"}'),
(3,	3,	5.0000,	5.0000,	NULL,	15.0000,	NULL,	15.0000,	15.0000,	NULL,	5.0000,	5.0000,	15.0000,	15.0000,	15.0000,	NULL,	NULL,	NULL,	15.0000,	NULL,	NULL,	NULL,	'2',	NULL,	NULL,	'chmoneriscc',	NULL,	NULL,	NULL,	'988677',	'5454',	NULL,	NULL,	NULL,	NULL,	NULL,	'536664-1_13',	NULL,	NULL,	'MC',	NULL,	'2027',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'536664-1_13',	NULL,	'{\"method_title\":\"Moneris Credit Card\",\"payment_type\":\"authorize\",\"receipt_id\":\"000000003-93230159462342669402\"}');

DROP TABLE IF EXISTS `sales_order_status`;
CREATE TABLE `sales_order_status` (
  `status` varchar(32) NOT NULL COMMENT 'Status',
  `label` varchar(128) NOT NULL COMMENT 'Label',
  PRIMARY KEY (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Status Table';

INSERT INTO `sales_order_status` (`status`, `label`) VALUES
('canceled',	'Canceled'),
('closed',	'Closed'),
('complete',	'Complete'),
('fraud',	'Suspected Fraud'),
('holded',	'On Hold'),
('payment_review',	'Payment Review'),
('paypal_canceled_reversal',	'PayPal Canceled Reversal'),
('paypal_reversed',	'PayPal Reversed'),
('pending',	'Pending'),
('pending_payment',	'Pending Payment'),
('pending_paypal',	'Pending PayPal'),
('processing',	'Processing');

DROP TABLE IF EXISTS `sales_order_status_history`;
CREATE TABLE `sales_order_status_history` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `is_customer_notified` int(11) DEFAULT NULL COMMENT 'Is Customer Notified',
  `is_visible_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible On Front',
  `comment` text COMMENT 'Comment',
  `status` varchar(32) DEFAULT NULL COMMENT 'Status',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `entity_name` varchar(32) DEFAULT NULL COMMENT 'Shows what entity history is bind to.',
  PRIMARY KEY (`entity_id`),
  KEY `SALES_ORDER_STATUS_HISTORY_PARENT_ID` (`parent_id`),
  KEY `SALES_ORDER_STATUS_HISTORY_CREATED_AT` (`created_at`),
  CONSTRAINT `SALES_ORDER_STATUS_HISTORY_PARENT_ID_SALES_ORDER_ENTITY_ID` FOREIGN KEY (`parent_id`) REFERENCES `sales_order` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order Status History';

INSERT INTO `sales_order_status_history` (`entity_id`, `parent_id`, `is_customer_notified`, `is_visible_on_front`, `comment`, `status`, `created_at`, `entity_name`) VALUES
(1,	2,	NULL,	0,	'Authorized amount of $15.00. Transaction ID: \"880716-0_13\"',	'processing',	'2019-02-18 15:16:51',	'order'),
(2,	3,	NULL,	0,	'Authorized amount of $15.00. Transaction ID: \"536662-0_13\"',	'processing',	'2019-02-18 15:18:10',	'order'),
(3,	3,	NULL,	0,	'Captured amount of $15.00 online. Transaction ID: \"536664-1_13\"',	'processing',	'2019-02-18 15:18:47',	'invoice');

DROP TABLE IF EXISTS `sales_order_status_label`;
CREATE TABLE `sales_order_status_label` (
  `status` varchar(32) NOT NULL COMMENT 'Status',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `label` varchar(128) NOT NULL COMMENT 'Label',
  PRIMARY KEY (`status`,`store_id`),
  KEY `SALES_ORDER_STATUS_LABEL_STORE_ID` (`store_id`),
  CONSTRAINT `SALES_ORDER_STATUS_LABEL_STATUS_SALES_ORDER_STATUS_STATUS` FOREIGN KEY (`status`) REFERENCES `sales_order_status` (`status`) ON DELETE CASCADE,
  CONSTRAINT `SALES_ORDER_STATUS_LABEL_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Status Label Table';


DROP TABLE IF EXISTS `sales_order_status_state`;
CREATE TABLE `sales_order_status_state` (
  `status` varchar(32) NOT NULL COMMENT 'Status',
  `state` varchar(32) NOT NULL COMMENT 'Label',
  `is_default` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Default',
  `visible_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Visible on front',
  PRIMARY KEY (`status`,`state`),
  CONSTRAINT `SALES_ORDER_STATUS_STATE_STATUS_SALES_ORDER_STATUS_STATUS` FOREIGN KEY (`status`) REFERENCES `sales_order_status` (`status`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Status Table';

INSERT INTO `sales_order_status_state` (`status`, `state`, `is_default`, `visible_on_front`) VALUES
('canceled',	'canceled',	1,	1),
('closed',	'closed',	1,	1),
('complete',	'complete',	1,	1),
('fraud',	'payment_review',	0,	1),
('fraud',	'processing',	0,	1),
('holded',	'holded',	1,	1),
('payment_review',	'payment_review',	1,	1),
('pending',	'new',	1,	1),
('pending_payment',	'pending_payment',	1,	0),
('processing',	'processing',	1,	1);

DROP TABLE IF EXISTS `sales_order_tax`;
CREATE TABLE `sales_order_tax` (
  `tax_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Tax Id',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `code` varchar(255) DEFAULT NULL COMMENT 'Code',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  `percent` decimal(12,4) DEFAULT NULL COMMENT 'Percent',
  `amount` decimal(12,4) DEFAULT NULL COMMENT 'Amount',
  `priority` int(11) NOT NULL COMMENT 'Priority',
  `position` int(11) NOT NULL COMMENT 'Position',
  `base_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount',
  `process` smallint(6) NOT NULL COMMENT 'Process',
  `base_real_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Real Amount',
  PRIMARY KEY (`tax_id`),
  KEY `SALES_ORDER_TAX_ORDER_ID_PRIORITY_POSITION` (`order_id`,`priority`,`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Tax Table';


DROP TABLE IF EXISTS `sales_order_tax_item`;
CREATE TABLE `sales_order_tax_item` (
  `tax_item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Tax Item Id',
  `tax_id` int(10) unsigned NOT NULL COMMENT 'Tax Id',
  `item_id` int(10) unsigned DEFAULT NULL COMMENT 'Item Id',
  `tax_percent` decimal(12,4) NOT NULL COMMENT 'Real Tax Percent For Item',
  `amount` decimal(12,4) NOT NULL COMMENT 'Tax amount for the item and tax rate',
  `base_amount` decimal(12,4) NOT NULL COMMENT 'Base tax amount for the item and tax rate',
  `real_amount` decimal(12,4) NOT NULL COMMENT 'Real tax amount for the item and tax rate',
  `real_base_amount` decimal(12,4) NOT NULL COMMENT 'Real base tax amount for the item and tax rate',
  `associated_item_id` int(10) unsigned DEFAULT NULL COMMENT 'Id of the associated item',
  `taxable_item_type` varchar(32) NOT NULL COMMENT 'Type of the taxable item',
  PRIMARY KEY (`tax_item_id`),
  UNIQUE KEY `SALES_ORDER_TAX_ITEM_TAX_ID_ITEM_ID` (`tax_id`,`item_id`),
  KEY `SALES_ORDER_TAX_ITEM_ASSOCIATED_ITEM_ID_SALES_ORDER_ITEM_ITEM_ID` (`associated_item_id`),
  KEY `SALES_ORDER_TAX_ITEM_ITEM_ID` (`item_id`),
  CONSTRAINT `SALES_ORDER_TAX_ITEM_ASSOCIATED_ITEM_ID_SALES_ORDER_ITEM_ITEM_ID` FOREIGN KEY (`associated_item_id`) REFERENCES `sales_order_item` (`item_id`) ON DELETE CASCADE,
  CONSTRAINT `SALES_ORDER_TAX_ITEM_ITEM_ID_SALES_ORDER_ITEM_ITEM_ID` FOREIGN KEY (`item_id`) REFERENCES `sales_order_item` (`item_id`) ON DELETE CASCADE,
  CONSTRAINT `SALES_ORDER_TAX_ITEM_TAX_ID_SALES_ORDER_TAX_TAX_ID` FOREIGN KEY (`tax_id`) REFERENCES `sales_order_tax` (`tax_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Tax Item';


DROP TABLE IF EXISTS `sales_payment_transaction`;
CREATE TABLE `sales_payment_transaction` (
  `transaction_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Transaction Id',
  `parent_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Id',
  `order_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Order Id',
  `payment_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Payment Id',
  `txn_id` varchar(100) DEFAULT NULL COMMENT 'Txn Id',
  `parent_txn_id` varchar(100) DEFAULT NULL COMMENT 'Parent Txn Id',
  `txn_type` varchar(15) DEFAULT NULL COMMENT 'Txn Type',
  `is_closed` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Closed',
  `additional_information` blob COMMENT 'Additional Information',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  PRIMARY KEY (`transaction_id`),
  UNIQUE KEY `SALES_PAYMENT_TRANSACTION_ORDER_ID_PAYMENT_ID_TXN_ID` (`order_id`,`payment_id`,`txn_id`),
  KEY `SALES_PAYMENT_TRANSACTION_PARENT_ID` (`parent_id`),
  KEY `SALES_PAYMENT_TRANSACTION_PAYMENT_ID` (`payment_id`),
  CONSTRAINT `FK_B99FF1A06402D725EBDB0F3A7ECD47A2` FOREIGN KEY (`parent_id`) REFERENCES `sales_payment_transaction` (`transaction_id`) ON DELETE CASCADE,
  CONSTRAINT `SALES_PAYMENT_TRANSACTION_ORDER_ID_SALES_ORDER_ENTITY_ID` FOREIGN KEY (`order_id`) REFERENCES `sales_order` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `SALES_PAYMENT_TRANSACTION_PAYMENT_ID_SALES_ORDER_PAYMENT_ENTT_ID` FOREIGN KEY (`payment_id`) REFERENCES `sales_order_payment` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Payment Transaction';

INSERT INTO `sales_payment_transaction` (`transaction_id`, `parent_id`, `order_id`, `payment_id`, `txn_id`, `parent_txn_id`, `txn_type`, `is_closed`, `additional_information`, `created_at`) VALUES
(1,	NULL,	2,	2,	'880716-0_13',	NULL,	'authorization',	0,	'{\"real_transaction_id\":\"880716-0_13\",\"orig_order_id\":\"000000002-52340651370729182035\"}',	'2019-02-18 15:16:51'),
(2,	NULL,	3,	3,	'536662-0_13',	NULL,	'authorization',	1,	'{\"real_transaction_id\":\"536662-0_13\",\"orig_order_id\":\"000000003-93230159462342669402\"}',	'2019-02-18 15:18:10'),
(3,	2,	3,	3,	'536664-1_13',	'536662-0_13',	'capture',	0,	'{\"real_transaction_id\":\"000000003-93230159462342669402\",\"orig_order_id\":\"000000003-93230159462342669402\"}',	'2019-02-18 15:18:47');

DROP TABLE IF EXISTS `sales_refunded_aggregated`;
CREATE TABLE `sales_refunded_aggregated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) NOT NULL COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `refunded` decimal(12,4) DEFAULT NULL COMMENT 'Refunded',
  `online_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Online Refunded',
  `offline_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Offline Refunded',
  PRIMARY KEY (`id`),
  UNIQUE KEY `SALES_REFUNDED_AGGREGATED_PERIOD_STORE_ID_ORDER_STATUS` (`period`,`store_id`,`order_status`),
  KEY `SALES_REFUNDED_AGGREGATED_STORE_ID` (`store_id`),
  CONSTRAINT `SALES_REFUNDED_AGGREGATED_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Refunded Aggregated';


DROP TABLE IF EXISTS `sales_refunded_aggregated_order`;
CREATE TABLE `sales_refunded_aggregated_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `refunded` decimal(12,4) DEFAULT NULL COMMENT 'Refunded',
  `online_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Online Refunded',
  `offline_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Offline Refunded',
  PRIMARY KEY (`id`),
  UNIQUE KEY `SALES_REFUNDED_AGGREGATED_ORDER_PERIOD_STORE_ID_ORDER_STATUS` (`period`,`store_id`,`order_status`),
  KEY `SALES_REFUNDED_AGGREGATED_ORDER_STORE_ID` (`store_id`),
  CONSTRAINT `SALES_REFUNDED_AGGREGATED_ORDER_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Refunded Aggregated Order';


DROP TABLE IF EXISTS `sales_sequence_meta`;
CREATE TABLE `sales_sequence_meta` (
  `meta_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `entity_type` varchar(32) NOT NULL COMMENT 'Prefix',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `sequence_table` varchar(32) NOT NULL COMMENT 'table for sequence',
  PRIMARY KEY (`meta_id`),
  UNIQUE KEY `SALES_SEQUENCE_META_ENTITY_TYPE_STORE_ID` (`entity_type`,`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='sales_sequence_meta';

INSERT INTO `sales_sequence_meta` (`meta_id`, `entity_type`, `store_id`, `sequence_table`) VALUES
(1,	'order',	0,	'sequence_order_0'),
(2,	'invoice',	0,	'sequence_invoice_0'),
(3,	'creditmemo',	0,	'sequence_creditmemo_0'),
(4,	'shipment',	0,	'sequence_shipment_0'),
(5,	'order',	1,	'sequence_order_1'),
(6,	'invoice',	1,	'sequence_invoice_1'),
(7,	'creditmemo',	1,	'sequence_creditmemo_1'),
(8,	'shipment',	1,	'sequence_shipment_1');

DROP TABLE IF EXISTS `sales_sequence_profile`;
CREATE TABLE `sales_sequence_profile` (
  `profile_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `meta_id` int(10) unsigned NOT NULL COMMENT 'Meta_id',
  `prefix` varchar(32) DEFAULT NULL COMMENT 'Prefix',
  `suffix` varchar(32) DEFAULT NULL COMMENT 'Suffix',
  `start_value` int(10) unsigned NOT NULL DEFAULT '1' COMMENT 'Start value for sequence',
  `step` int(10) unsigned NOT NULL DEFAULT '1' COMMENT 'Step for sequence',
  `max_value` int(10) unsigned NOT NULL COMMENT 'MaxValue for sequence',
  `warning_value` int(10) unsigned NOT NULL COMMENT 'WarningValue for sequence',
  `is_active` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'isActive flag',
  PRIMARY KEY (`profile_id`),
  UNIQUE KEY `SALES_SEQUENCE_PROFILE_META_ID_PREFIX_SUFFIX` (`meta_id`,`prefix`,`suffix`),
  CONSTRAINT `SALES_SEQUENCE_PROFILE_META_ID_SALES_SEQUENCE_META_META_ID` FOREIGN KEY (`meta_id`) REFERENCES `sales_sequence_meta` (`meta_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='sales_sequence_profile';

INSERT INTO `sales_sequence_profile` (`profile_id`, `meta_id`, `prefix`, `suffix`, `start_value`, `step`, `max_value`, `warning_value`, `is_active`) VALUES
(1,	1,	NULL,	NULL,	1,	1,	4294967295,	4294966295,	1),
(2,	2,	NULL,	NULL,	1,	1,	4294967295,	4294966295,	1),
(3,	3,	NULL,	NULL,	1,	1,	4294967295,	4294966295,	1),
(4,	4,	NULL,	NULL,	1,	1,	4294967295,	4294966295,	1),
(5,	5,	NULL,	NULL,	1,	1,	4294967295,	4294966295,	1),
(6,	6,	NULL,	NULL,	1,	1,	4294967295,	4294966295,	1),
(7,	7,	NULL,	NULL,	1,	1,	4294967295,	4294966295,	1),
(8,	8,	NULL,	NULL,	1,	1,	4294967295,	4294966295,	1);

DROP TABLE IF EXISTS `sales_shipment`;
CREATE TABLE `sales_shipment` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `total_weight` decimal(12,4) DEFAULT NULL COMMENT 'Total Weight',
  `total_qty` decimal(12,4) DEFAULT NULL COMMENT 'Total Qty',
  `email_sent` smallint(5) unsigned DEFAULT NULL COMMENT 'Email Sent',
  `send_email` smallint(5) unsigned DEFAULT NULL COMMENT 'Send Email',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `customer_id` int(11) DEFAULT NULL COMMENT 'Customer Id',
  `shipping_address_id` int(11) DEFAULT NULL COMMENT 'Shipping Address Id',
  `billing_address_id` int(11) DEFAULT NULL COMMENT 'Billing Address Id',
  `shipment_status` int(11) DEFAULT NULL COMMENT 'Shipment Status',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Updated At',
  `packages` text COMMENT 'Packed Products in Packages',
  `shipping_label` mediumblob COMMENT 'Shipping Label Content',
  `customer_note` text COMMENT 'Customer Note',
  `customer_note_notify` smallint(5) unsigned DEFAULT NULL COMMENT 'Customer Note Notify',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `SALES_SHIPMENT_INCREMENT_ID_STORE_ID` (`increment_id`,`store_id`),
  KEY `SALES_SHIPMENT_STORE_ID` (`store_id`),
  KEY `SALES_SHIPMENT_TOTAL_QTY` (`total_qty`),
  KEY `SALES_SHIPMENT_ORDER_ID` (`order_id`),
  KEY `SALES_SHIPMENT_CREATED_AT` (`created_at`),
  KEY `SALES_SHIPMENT_UPDATED_AT` (`updated_at`),
  KEY `SALES_SHIPMENT_SEND_EMAIL` (`send_email`),
  KEY `SALES_SHIPMENT_EMAIL_SENT` (`email_sent`),
  CONSTRAINT `SALES_SHIPMENT_ORDER_ID_SALES_ORDER_ENTITY_ID` FOREIGN KEY (`order_id`) REFERENCES `sales_order` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `SALES_SHIPMENT_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Shipment';


DROP TABLE IF EXISTS `sales_shipment_comment`;
CREATE TABLE `sales_shipment_comment` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `is_customer_notified` int(11) DEFAULT NULL COMMENT 'Is Customer Notified',
  `is_visible_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible On Front',
  `comment` text COMMENT 'Comment',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  PRIMARY KEY (`entity_id`),
  KEY `SALES_SHIPMENT_COMMENT_CREATED_AT` (`created_at`),
  KEY `SALES_SHIPMENT_COMMENT_PARENT_ID` (`parent_id`),
  CONSTRAINT `SALES_SHIPMENT_COMMENT_PARENT_ID_SALES_SHIPMENT_ENTITY_ID` FOREIGN KEY (`parent_id`) REFERENCES `sales_shipment` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Shipment Comment';


DROP TABLE IF EXISTS `sales_shipment_grid`;
CREATE TABLE `sales_shipment_grid` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_increment_id` varchar(32) NOT NULL COMMENT 'Order Increment Id',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `order_created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Order Increment Id',
  `customer_name` varchar(128) NOT NULL COMMENT 'Customer Name',
  `total_qty` decimal(12,4) DEFAULT NULL COMMENT 'Total Qty',
  `shipment_status` int(11) DEFAULT NULL COMMENT 'Shipment Status',
  `order_status` varchar(32) DEFAULT NULL COMMENT 'Order',
  `billing_address` varchar(255) DEFAULT NULL COMMENT 'Billing Address',
  `shipping_address` varchar(255) DEFAULT NULL COMMENT 'Shipping Address',
  `billing_name` varchar(128) DEFAULT NULL COMMENT 'Billing Name',
  `shipping_name` varchar(128) DEFAULT NULL COMMENT 'Shipping Name',
  `customer_email` varchar(128) DEFAULT NULL COMMENT 'Customer Email',
  `customer_group_id` int(11) DEFAULT NULL,
  `payment_method` varchar(32) DEFAULT NULL COMMENT 'Payment Method',
  `shipping_information` varchar(255) DEFAULT NULL COMMENT 'Shipping Method Name',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `SALES_SHIPMENT_GRID_INCREMENT_ID_STORE_ID` (`increment_id`,`store_id`),
  KEY `SALES_SHIPMENT_GRID_STORE_ID` (`store_id`),
  KEY `SALES_SHIPMENT_GRID_TOTAL_QTY` (`total_qty`),
  KEY `SALES_SHIPMENT_GRID_ORDER_INCREMENT_ID` (`order_increment_id`),
  KEY `SALES_SHIPMENT_GRID_SHIPMENT_STATUS` (`shipment_status`),
  KEY `SALES_SHIPMENT_GRID_ORDER_STATUS` (`order_status`),
  KEY `SALES_SHIPMENT_GRID_CREATED_AT` (`created_at`),
  KEY `SALES_SHIPMENT_GRID_UPDATED_AT` (`updated_at`),
  KEY `SALES_SHIPMENT_GRID_ORDER_CREATED_AT` (`order_created_at`),
  KEY `SALES_SHIPMENT_GRID_SHIPPING_NAME` (`shipping_name`),
  KEY `SALES_SHIPMENT_GRID_BILLING_NAME` (`billing_name`),
  FULLTEXT KEY `FTI_086B40C8955F167B8EA76653437879B4` (`increment_id`,`order_increment_id`,`shipping_name`,`customer_name`,`customer_email`,`billing_address`,`shipping_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Shipment Grid';


DROP TABLE IF EXISTS `sales_shipment_item`;
CREATE TABLE `sales_shipment_item` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `row_total` decimal(12,4) DEFAULT NULL COMMENT 'Row Total',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `weight` decimal(12,4) DEFAULT NULL COMMENT 'Weight',
  `qty` decimal(12,4) DEFAULT NULL COMMENT 'Qty',
  `product_id` int(11) DEFAULT NULL COMMENT 'Product Id',
  `order_item_id` int(11) DEFAULT NULL COMMENT 'Order Item Id',
  `additional_data` text COMMENT 'Additional Data',
  `description` text COMMENT 'Description',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  PRIMARY KEY (`entity_id`),
  KEY `SALES_SHIPMENT_ITEM_PARENT_ID` (`parent_id`),
  CONSTRAINT `SALES_SHIPMENT_ITEM_PARENT_ID_SALES_SHIPMENT_ENTITY_ID` FOREIGN KEY (`parent_id`) REFERENCES `sales_shipment` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Shipment Item';


DROP TABLE IF EXISTS `sales_shipment_track`;
CREATE TABLE `sales_shipment_track` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `weight` decimal(12,4) DEFAULT NULL COMMENT 'Weight',
  `qty` decimal(12,4) DEFAULT NULL COMMENT 'Qty',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `track_number` text COMMENT 'Number',
  `description` text COMMENT 'Description',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  `carrier_code` varchar(32) DEFAULT NULL COMMENT 'Carrier Code',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Updated At',
  PRIMARY KEY (`entity_id`),
  KEY `SALES_SHIPMENT_TRACK_PARENT_ID` (`parent_id`),
  KEY `SALES_SHIPMENT_TRACK_ORDER_ID` (`order_id`),
  KEY `SALES_SHIPMENT_TRACK_CREATED_AT` (`created_at`),
  CONSTRAINT `SALES_SHIPMENT_TRACK_PARENT_ID_SALES_SHIPMENT_ENTITY_ID` FOREIGN KEY (`parent_id`) REFERENCES `sales_shipment` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Shipment Track';


DROP TABLE IF EXISTS `sales_shipping_aggregated`;
CREATE TABLE `sales_shipping_aggregated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `shipping_description` varchar(255) DEFAULT NULL COMMENT 'Shipping Description',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `total_shipping` decimal(12,4) DEFAULT NULL COMMENT 'Total Shipping',
  `total_shipping_actual` decimal(12,4) DEFAULT NULL COMMENT 'Total Shipping Actual',
  PRIMARY KEY (`id`),
  UNIQUE KEY `SALES_SHPP_AGGRED_PERIOD_STORE_ID_ORDER_STS_SHPP_DESCRIPTION` (`period`,`store_id`,`order_status`,`shipping_description`),
  KEY `SALES_SHIPPING_AGGREGATED_STORE_ID` (`store_id`),
  CONSTRAINT `SALES_SHIPPING_AGGREGATED_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Shipping Aggregated';


DROP TABLE IF EXISTS `sales_shipping_aggregated_order`;
CREATE TABLE `sales_shipping_aggregated_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `shipping_description` varchar(255) DEFAULT NULL COMMENT 'Shipping Description',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `total_shipping` decimal(12,4) DEFAULT NULL COMMENT 'Total Shipping',
  `total_shipping_actual` decimal(12,4) DEFAULT NULL COMMENT 'Total Shipping Actual',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_C05FAE47282EEA68654D0924E946761F` (`period`,`store_id`,`order_status`,`shipping_description`),
  KEY `SALES_SHIPPING_AGGREGATED_ORDER_STORE_ID` (`store_id`),
  CONSTRAINT `SALES_SHIPPING_AGGREGATED_ORDER_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Shipping Aggregated Order';


DROP TABLE IF EXISTS `search_query`;
CREATE TABLE `search_query` (
  `query_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Query ID',
  `query_text` varchar(255) DEFAULT NULL COMMENT 'Query text',
  `num_results` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Num results',
  `popularity` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Popularity',
  `redirect` varchar(255) DEFAULT NULL COMMENT 'Redirect',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `display_in_terms` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Display in terms',
  `is_active` smallint(6) DEFAULT '1' COMMENT 'Active status',
  `is_processed` smallint(6) DEFAULT '0' COMMENT 'Processed status',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Updated at',
  PRIMARY KEY (`query_id`),
  UNIQUE KEY `SEARCH_QUERY_QUERY_TEXT_STORE_ID` (`query_text`,`store_id`),
  KEY `SEARCH_QUERY_QUERY_TEXT_STORE_ID_POPULARITY` (`query_text`,`store_id`,`popularity`),
  KEY `SEARCH_QUERY_STORE_ID` (`store_id`),
  KEY `SEARCH_QUERY_IS_PROCESSED` (`is_processed`),
  CONSTRAINT `SEARCH_QUERY_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Search query table';


DROP TABLE IF EXISTS `search_synonyms`;
CREATE TABLE `search_synonyms` (
  `group_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Synonyms Group Id',
  `synonyms` text NOT NULL COMMENT 'list of synonyms making up this group',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id - identifies the store view these synonyms belong to',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id - identifies the website id these synonyms belong to',
  PRIMARY KEY (`group_id`),
  KEY `SEARCH_SYNONYMS_STORE_ID` (`store_id`),
  KEY `SEARCH_SYNONYMS_WEBSITE_ID` (`website_id`),
  FULLTEXT KEY `SEARCH_SYNONYMS_SYNONYMS` (`synonyms`),
  CONSTRAINT `SEARCH_SYNONYMS_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `SEARCH_SYNONYMS_WEBSITE_ID_STORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='table storing various synonyms groups';


DROP TABLE IF EXISTS `sendfriend_log`;
CREATE TABLE `sendfriend_log` (
  `log_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Log ID',
  `ip` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer IP address',
  `time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Log time',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website ID',
  PRIMARY KEY (`log_id`),
  KEY `SENDFRIEND_LOG_IP` (`ip`),
  KEY `SENDFRIEND_LOG_TIME` (`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Send to friend function log storage table';


DROP TABLE IF EXISTS `sequence_creditmemo_0`;
CREATE TABLE `sequence_creditmemo_0` (
  `sequence_value` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`sequence_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `sequence_creditmemo_1`;
CREATE TABLE `sequence_creditmemo_1` (
  `sequence_value` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`sequence_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `sequence_invoice_0`;
CREATE TABLE `sequence_invoice_0` (
  `sequence_value` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`sequence_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `sequence_invoice_1`;
CREATE TABLE `sequence_invoice_1` (
  `sequence_value` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`sequence_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `sequence_invoice_1` (`sequence_value`) VALUES
(1);

DROP TABLE IF EXISTS `sequence_order_0`;
CREATE TABLE `sequence_order_0` (
  `sequence_value` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`sequence_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `sequence_order_1`;
CREATE TABLE `sequence_order_1` (
  `sequence_value` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`sequence_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `sequence_order_1` (`sequence_value`) VALUES
(1),
(2),
(3);

DROP TABLE IF EXISTS `sequence_shipment_0`;
CREATE TABLE `sequence_shipment_0` (
  `sequence_value` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`sequence_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `sequence_shipment_1`;
CREATE TABLE `sequence_shipment_1` (
  `sequence_value` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`sequence_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `session`;
CREATE TABLE `session` (
  `session_id` varchar(255) NOT NULL COMMENT 'Session Id',
  `session_expires` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Date of Session Expiration',
  `session_data` mediumblob NOT NULL COMMENT 'Session Data',
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Database Sessions Storage';


DROP TABLE IF EXISTS `setup_module`;
CREATE TABLE `setup_module` (
  `module` varchar(50) NOT NULL COMMENT 'Module',
  `schema_version` varchar(50) DEFAULT NULL COMMENT 'Schema Version',
  `data_version` varchar(50) DEFAULT NULL COMMENT 'Data Version',
  PRIMARY KEY (`module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Module versions registry';

INSERT INTO `setup_module` (`module`, `schema_version`, `data_version`) VALUES
('Amazon_Core',	'3.0.0',	'3.0.0'),
('Amazon_Login',	'3.0.0',	'3.0.0'),
('Amazon_Payment',	'3.0.0',	'3.0.0'),
('Dotdigitalgroup_Email',	'3.0.1',	'3.0.1'),
('Klarna_Core',	'5.0.0',	'5.0.0'),
('Klarna_Kp',	'6.0.0',	'6.0.0'),
('Klarna_Ordermanagement',	'5.0.2',	'5.0.2'),
('Magento_Inventory',	'1.0.0',	'1.0.0'),
('Magento_InventoryAdminUi',	'1.0.0',	'1.0.0'),
('Magento_InventoryApi',	'1.0.0',	'1.0.0'),
('Magento_InventoryBundleProduct',	'1.0.0',	'1.0.0'),
('Magento_InventoryBundleProductAdminUi',	'1.0.0',	'1.0.0'),
('Magento_InventoryCache',	'1.0.0',	'1.0.0'),
('Magento_InventoryCatalog',	'1.0.0',	'1.0.0'),
('Magento_InventoryCatalogAdminUi',	'1.0.0',	'1.0.0'),
('Magento_InventoryCatalogApi',	'1.0.0',	'1.0.0'),
('Magento_InventoryCatalogSearch',	'1.0.0',	'1.0.0'),
('Magento_InventoryConfigurableProduct',	'1.0.0',	'1.0.0'),
('Magento_InventoryConfigurableProductAdminUi',	'1.0.0',	'1.0.0'),
('Magento_InventoryConfigurableProductIndexer',	'1.0.0',	'1.0.0'),
('Magento_InventoryConfiguration',	'1.0.0',	'1.0.0'),
('Magento_InventoryConfigurationApi',	'1.0.0',	'1.0.0'),
('Magento_InventoryGroupedProduct',	'1.0.0',	'1.0.0'),
('Magento_InventoryGroupedProductAdminUi',	'1.0.0',	'1.0.0'),
('Magento_InventoryGroupedProductIndexer',	'1.0.0',	'1.0.0'),
('Magento_InventoryImportExport',	'1.0.0',	'1.0.0'),
('Magento_InventoryIndexer',	'1.0.0',	'1.0.0'),
('Magento_InventoryLowQuantityNotification',	'1.0.0',	'1.0.0'),
('Magento_InventoryLowQuantityNotificationAdminUi',	'1.0.0',	'1.0.0'),
('Magento_InventoryLowQuantityNotificationApi',	'1.0.0',	'1.0.0'),
('Magento_InventoryMultiDimensionalIndexerApi',	'1.0.0',	'1.0.0'),
('Magento_InventoryProductAlert',	'1.0.0',	'1.0.0'),
('Magento_InventoryReservations',	'1.0.0',	'1.0.0'),
('Magento_InventoryReservationsApi',	'1.0.0',	'1.0.0'),
('Magento_InventorySales',	'1.0.0',	'1.0.0'),
('Magento_InventorySalesAdminUi',	'1.0.0',	'1.0.0'),
('Magento_InventorySalesApi',	'1.0.0',	'1.0.0'),
('Magento_InventoryShipping',	'1.0.0',	'1.0.0'),
('Magento_InventoryShippingAdminUi',	'1.0.0',	'1.0.0'),
('Magento_InventorySourceDeductionApi',	'1.0.0',	'1.0.0'),
('Magento_InventorySourceSelection',	'1.0.0',	'1.0.0'),
('Magento_InventorySourceSelectionApi',	'1.0.0',	'1.0.0'),
('Moneris_CreditCard',	'3.0.2',	'3.0.2'),
('Moneris_Masterpass',	'1.0.1',	'1.0.1'),
('Moneris_MonerisCheckout',	'0.0.1',	'0.0.1'),
('Moneris_VisaCheckout',	'1.0.0',	'1.0.0'),
('MSP_ReCaptcha',	'1.5.0',	'1.5.0'),
('MSP_TwoFactorAuth',	'2.2.0',	'2.2.0'),
('Temando_Shipping',	'1.4.0',	'1.4.0'),
('Vertex_Tax',	'100.2.1',	'100.2.1');

DROP TABLE IF EXISTS `shipping_tablerate`;
CREATE TABLE `shipping_tablerate` (
  `pk` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  `website_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `dest_country_id` varchar(4) NOT NULL DEFAULT '0' COMMENT 'Destination coutry ISO/2 or ISO/3 code',
  `dest_region_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Destination Region Id',
  `dest_zip` varchar(10) NOT NULL DEFAULT '*' COMMENT 'Destination Post Code (Zip)',
  `condition_name` varchar(20) NOT NULL COMMENT 'Rate Condition name',
  `condition_value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Rate condition value',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `cost` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Cost',
  PRIMARY KEY (`pk`),
  UNIQUE KEY `UNQ_D60821CDB2AFACEE1566CFC02D0D4CAA` (`website_id`,`dest_country_id`,`dest_region_id`,`dest_zip`,`condition_name`,`condition_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Shipping Tablerate';


DROP TABLE IF EXISTS `signifyd_case`;
CREATE TABLE `signifyd_case` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity_id',
  `order_id` int(10) unsigned DEFAULT NULL COMMENT 'Order_id',
  `case_id` int(10) unsigned DEFAULT NULL COMMENT 'Case_id',
  `guarantee_eligible` tinyint(1) DEFAULT NULL COMMENT 'Guarantee_eligible',
  `guarantee_disposition` varchar(32) DEFAULT 'PENDING' COMMENT 'Guarantee_disposition',
  `status` varchar(32) DEFAULT 'PENDING' COMMENT 'Status',
  `score` int(10) unsigned DEFAULT NULL COMMENT 'Score',
  `associated_team` text COMMENT 'Associated_team',
  `review_disposition` varchar(32) DEFAULT NULL COMMENT 'Review_disposition',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created_at',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated_at',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `SIGNIFYD_CASE_ORDER_ID` (`order_id`),
  UNIQUE KEY `SIGNIFYD_CASE_CASE_ID` (`case_id`),
  CONSTRAINT `SIGNIFYD_CASE_ORDER_ID_SALES_ORDER_ENTITY_ID` FOREIGN KEY (`order_id`) REFERENCES `sales_order` (`entity_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='signifyd_case';


DROP TABLE IF EXISTS `sitemap`;
CREATE TABLE `sitemap` (
  `sitemap_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Sitemap Id',
  `sitemap_type` varchar(32) DEFAULT NULL COMMENT 'Sitemap Type',
  `sitemap_filename` varchar(32) DEFAULT NULL COMMENT 'Sitemap Filename',
  `sitemap_path` varchar(255) DEFAULT NULL COMMENT 'Sitemap Path',
  `sitemap_time` timestamp NULL DEFAULT NULL COMMENT 'Sitemap Time',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store id',
  PRIMARY KEY (`sitemap_id`),
  KEY `SITEMAP_STORE_ID` (`store_id`),
  CONSTRAINT `SITEMAP_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='XML Sitemap';


DROP TABLE IF EXISTS `store`;
CREATE TABLE `store` (
  `store_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Store Id',
  `code` varchar(32) DEFAULT NULL COMMENT 'Code',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Group Id',
  `name` varchar(255) NOT NULL COMMENT 'Store Name',
  `sort_order` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Sort Order',
  `is_active` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Activity',
  PRIMARY KEY (`store_id`),
  UNIQUE KEY `STORE_CODE` (`code`),
  KEY `STORE_WEBSITE_ID` (`website_id`),
  KEY `STORE_IS_ACTIVE_SORT_ORDER` (`is_active`,`sort_order`),
  KEY `STORE_GROUP_ID` (`group_id`),
  CONSTRAINT `STORE_GROUP_ID_STORE_GROUP_GROUP_ID` FOREIGN KEY (`group_id`) REFERENCES `store_group` (`group_id`) ON DELETE CASCADE,
  CONSTRAINT `STORE_WEBSITE_ID_STORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores';

INSERT INTO `store` (`store_id`, `code`, `website_id`, `group_id`, `name`, `sort_order`, `is_active`) VALUES
(0,	'admin',	0,	0,	'Admin',	0,	1),
(1,	'default',	1,	1,	'Default Store View',	0,	1);

DROP TABLE IF EXISTS `store_group`;
CREATE TABLE `store_group` (
  `group_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Group Id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `name` varchar(255) NOT NULL COMMENT 'Store Group Name',
  `root_category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Root Category Id',
  `default_store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Default Store Id',
  `code` varchar(32) DEFAULT NULL COMMENT 'Store group unique code',
  PRIMARY KEY (`group_id`),
  UNIQUE KEY `STORE_GROUP_CODE` (`code`),
  KEY `STORE_GROUP_WEBSITE_ID` (`website_id`),
  KEY `STORE_GROUP_DEFAULT_STORE_ID` (`default_store_id`),
  CONSTRAINT `STORE_GROUP_WEBSITE_ID_STORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Store Groups';

INSERT INTO `store_group` (`group_id`, `website_id`, `name`, `root_category_id`, `default_store_id`, `code`) VALUES
(0,	0,	'Default',	0,	0,	'default'),
(1,	1,	'Main Website Store',	2,	1,	'main_website_store');

DROP TABLE IF EXISTS `store_website`;
CREATE TABLE `store_website` (
  `website_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Website Id',
  `code` varchar(32) DEFAULT NULL COMMENT 'Code',
  `name` varchar(64) DEFAULT NULL COMMENT 'Website Name',
  `sort_order` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `default_group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Default Group Id',
  `is_default` smallint(5) unsigned DEFAULT '0' COMMENT 'Defines Is Website Default',
  PRIMARY KEY (`website_id`),
  UNIQUE KEY `STORE_WEBSITE_CODE` (`code`),
  KEY `STORE_WEBSITE_SORT_ORDER` (`sort_order`),
  KEY `STORE_WEBSITE_DEFAULT_GROUP_ID` (`default_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Websites';

INSERT INTO `store_website` (`website_id`, `code`, `name`, `sort_order`, `default_group_id`, `is_default`) VALUES
(0,	'admin',	'Admin',	0,	0,	0),
(1,	'base',	'Main Website',	0,	1,	1);

DROP TABLE IF EXISTS `tax_calculation`;
CREATE TABLE `tax_calculation` (
  `tax_calculation_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Tax Calculation Id',
  `tax_calculation_rate_id` int(11) NOT NULL COMMENT 'Tax Calculation Rate Id',
  `tax_calculation_rule_id` int(11) NOT NULL COMMENT 'Tax Calculation Rule Id',
  `customer_tax_class_id` smallint(6) NOT NULL COMMENT 'Customer Tax Class Id',
  `product_tax_class_id` smallint(6) NOT NULL COMMENT 'Product Tax Class Id',
  PRIMARY KEY (`tax_calculation_id`),
  KEY `TAX_CALCULATION_TAX_CALCULATION_RULE_ID` (`tax_calculation_rule_id`),
  KEY `TAX_CALCULATION_CUSTOMER_TAX_CLASS_ID` (`customer_tax_class_id`),
  KEY `TAX_CALCULATION_PRODUCT_TAX_CLASS_ID` (`product_tax_class_id`),
  KEY `TAX_CALC_TAX_CALC_RATE_ID_CSTR_TAX_CLASS_ID_PRD_TAX_CLASS_ID` (`tax_calculation_rate_id`,`customer_tax_class_id`,`product_tax_class_id`),
  CONSTRAINT `TAX_CALCULATION_CUSTOMER_TAX_CLASS_ID_TAX_CLASS_CLASS_ID` FOREIGN KEY (`customer_tax_class_id`) REFERENCES `tax_class` (`class_id`) ON DELETE CASCADE,
  CONSTRAINT `TAX_CALCULATION_PRODUCT_TAX_CLASS_ID_TAX_CLASS_CLASS_ID` FOREIGN KEY (`product_tax_class_id`) REFERENCES `tax_class` (`class_id`) ON DELETE CASCADE,
  CONSTRAINT `TAX_CALC_TAX_CALC_RATE_ID_TAX_CALC_RATE_TAX_CALC_RATE_ID` FOREIGN KEY (`tax_calculation_rate_id`) REFERENCES `tax_calculation_rate` (`tax_calculation_rate_id`) ON DELETE CASCADE,
  CONSTRAINT `TAX_CALC_TAX_CALC_RULE_ID_TAX_CALC_RULE_TAX_CALC_RULE_ID` FOREIGN KEY (`tax_calculation_rule_id`) REFERENCES `tax_calculation_rule` (`tax_calculation_rule_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tax Calculation';


DROP TABLE IF EXISTS `tax_calculation_rate`;
CREATE TABLE `tax_calculation_rate` (
  `tax_calculation_rate_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Tax Calculation Rate Id',
  `tax_country_id` varchar(2) NOT NULL COMMENT 'Tax Country Id',
  `tax_region_id` int(11) NOT NULL COMMENT 'Tax Region Id',
  `tax_postcode` varchar(21) DEFAULT NULL COMMENT 'Tax Postcode',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `rate` decimal(12,4) NOT NULL COMMENT 'Rate',
  `zip_is_range` smallint(6) DEFAULT NULL COMMENT 'Zip Is Range',
  `zip_from` int(10) unsigned DEFAULT NULL COMMENT 'Zip From',
  `zip_to` int(10) unsigned DEFAULT NULL COMMENT 'Zip To',
  PRIMARY KEY (`tax_calculation_rate_id`),
  KEY `TAX_CALCULATION_RATE_TAX_COUNTRY_ID_TAX_REGION_ID_TAX_POSTCODE` (`tax_country_id`,`tax_region_id`,`tax_postcode`),
  KEY `TAX_CALCULATION_RATE_CODE` (`code`),
  KEY `IDX_CA799F1E2CB843495F601E56C84A626D` (`tax_calculation_rate_id`,`tax_country_id`,`tax_region_id`,`zip_is_range`,`tax_postcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tax Calculation Rate';

INSERT INTO `tax_calculation_rate` (`tax_calculation_rate_id`, `tax_country_id`, `tax_region_id`, `tax_postcode`, `code`, `rate`, `zip_is_range`, `zip_from`, `zip_to`) VALUES
(1,	'US',	12,	'*',	'US-CA-*-Rate 1',	8.2500,	NULL,	NULL,	NULL),
(2,	'US',	43,	'*',	'US-NY-*-Rate 1',	8.3750,	NULL,	NULL,	NULL);

DROP TABLE IF EXISTS `tax_calculation_rate_title`;
CREATE TABLE `tax_calculation_rate_title` (
  `tax_calculation_rate_title_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Tax Calculation Rate Title Id',
  `tax_calculation_rate_id` int(11) NOT NULL COMMENT 'Tax Calculation Rate Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `value` varchar(255) NOT NULL COMMENT 'Value',
  PRIMARY KEY (`tax_calculation_rate_title_id`),
  KEY `TAX_CALCULATION_RATE_TITLE_TAX_CALCULATION_RATE_ID_STORE_ID` (`tax_calculation_rate_id`,`store_id`),
  KEY `TAX_CALCULATION_RATE_TITLE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_37FB965F786AD5897BB3AE90470C42AB` FOREIGN KEY (`tax_calculation_rate_id`) REFERENCES `tax_calculation_rate` (`tax_calculation_rate_id`) ON DELETE CASCADE,
  CONSTRAINT `TAX_CALCULATION_RATE_TITLE_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tax Calculation Rate Title';


DROP TABLE IF EXISTS `tax_calculation_rule`;
CREATE TABLE `tax_calculation_rule` (
  `tax_calculation_rule_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Tax Calculation Rule Id',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `priority` int(11) NOT NULL COMMENT 'Priority',
  `position` int(11) NOT NULL COMMENT 'Position',
  `calculate_subtotal` int(11) NOT NULL COMMENT 'Calculate off subtotal option',
  PRIMARY KEY (`tax_calculation_rule_id`),
  KEY `TAX_CALCULATION_RULE_PRIORITY_POSITION` (`priority`,`position`),
  KEY `TAX_CALCULATION_RULE_CODE` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tax Calculation Rule';


DROP TABLE IF EXISTS `tax_class`;
CREATE TABLE `tax_class` (
  `class_id` smallint(6) NOT NULL AUTO_INCREMENT COMMENT 'Class Id',
  `class_name` varchar(255) NOT NULL COMMENT 'Class Name',
  `class_type` varchar(8) NOT NULL DEFAULT 'CUSTOMER' COMMENT 'Class Type',
  PRIMARY KEY (`class_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tax Class';

INSERT INTO `tax_class` (`class_id`, `class_name`, `class_type`) VALUES
(2,	'Taxable Goods',	'PRODUCT'),
(3,	'Retail Customer',	'CUSTOMER'),
(4,	'Refund Adjustments',	'PRODUCT'),
(5,	'Gift Options',	'PRODUCT'),
(6,	'Order Gift Wrapping',	'PRODUCT'),
(7,	'Item Gift Wrapping',	'PRODUCT'),
(8,	'Printed Gift Card',	'PRODUCT'),
(9,	'Reward Points',	'PRODUCT');

DROP TABLE IF EXISTS `tax_order_aggregated_created`;
CREATE TABLE `tax_order_aggregated_created` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `order_status` varchar(50) NOT NULL COMMENT 'Order Status',
  `percent` float DEFAULT NULL COMMENT 'Percent',
  `orders_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `tax_base_amount_sum` float DEFAULT NULL COMMENT 'Tax Base Amount Sum',
  PRIMARY KEY (`id`),
  UNIQUE KEY `TAX_ORDER_AGGRED_CREATED_PERIOD_STORE_ID_CODE_PERCENT_ORDER_STS` (`period`,`store_id`,`code`,`percent`,`order_status`),
  KEY `TAX_ORDER_AGGREGATED_CREATED_STORE_ID` (`store_id`),
  CONSTRAINT `TAX_ORDER_AGGREGATED_CREATED_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tax Order Aggregation';


DROP TABLE IF EXISTS `tax_order_aggregated_updated`;
CREATE TABLE `tax_order_aggregated_updated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `order_status` varchar(50) NOT NULL COMMENT 'Order Status',
  `percent` float DEFAULT NULL COMMENT 'Percent',
  `orders_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `tax_base_amount_sum` float DEFAULT NULL COMMENT 'Tax Base Amount Sum',
  PRIMARY KEY (`id`),
  UNIQUE KEY `TAX_ORDER_AGGRED_UPDATED_PERIOD_STORE_ID_CODE_PERCENT_ORDER_STS` (`period`,`store_id`,`code`,`percent`,`order_status`),
  KEY `TAX_ORDER_AGGREGATED_UPDATED_STORE_ID` (`store_id`),
  CONSTRAINT `TAX_ORDER_AGGREGATED_UPDATED_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tax Order Aggregated Updated';


DROP TABLE IF EXISTS `temando_checkout_address`;
CREATE TABLE `temando_checkout_address` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `shipping_address_id` int(10) unsigned NOT NULL COMMENT 'Magento Quote Address Id',
  `service_selection` text COMMENT 'Value Added Services',
  PRIMARY KEY (`entity_id`),
  KEY `TEMANDO_CHKT_ADDR_SHPP_ADDR_ID_QUOTE_ADDR_ADDR_ID` (`shipping_address_id`),
  CONSTRAINT `TEMANDO_CHKT_ADDR_SHPP_ADDR_ID_QUOTE_ADDR_ADDR_ID` FOREIGN KEY (`shipping_address_id`) REFERENCES `quote_address` (`address_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Temando Checkout Address';


DROP TABLE IF EXISTS `temando_collection_point_search`;
CREATE TABLE `temando_collection_point_search` (
  `shipping_address_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `country_id` varchar(2) DEFAULT NULL,
  `postcode` varchar(255) DEFAULT NULL,
  `pending` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Pending',
  PRIMARY KEY (`shipping_address_id`),
  KEY `TEMANDO_COLLECTION_POINT_SRCH_COUNTRY_ID_DIR_COUNTRY_COUNTRY_ID` (`country_id`),
  CONSTRAINT `TEMANDO_COLLECTION_POINT_SRCH_COUNTRY_ID_DIR_COUNTRY_COUNTRY_ID` FOREIGN KEY (`country_id`) REFERENCES `directory_country` (`country_id`) ON DELETE NO ACTION,
  CONSTRAINT `TEMANDO_COLLECTION_POINT_SRCH_SHPP_ADDR_ID_QUOTE_ADDR_ADDR_ID` FOREIGN KEY (`shipping_address_id`) REFERENCES `quote_address` (`address_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Collection Point Search';


DROP TABLE IF EXISTS `temando_order`;
CREATE TABLE `temando_order` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Magento Order Id',
  `ext_order_id` varchar(64) NOT NULL COMMENT 'Temando Order Id',
  PRIMARY KEY (`entity_id`),
  KEY `TEMANDO_ORDER_ORDER_ID_SALES_ORDER_ENTITY_ID` (`order_id`),
  CONSTRAINT `TEMANDO_ORDER_ORDER_ID_SALES_ORDER_ENTITY_ID` FOREIGN KEY (`order_id`) REFERENCES `sales_order` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Temando Order';


DROP TABLE IF EXISTS `temando_order_collection_point`;
CREATE TABLE `temando_order_collection_point` (
  `recipient_address_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `collection_point_id` varchar(64) NOT NULL COMMENT 'Collection Point Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `country` varchar(2) NOT NULL COMMENT 'Country Code',
  `region` varchar(255) NOT NULL COMMENT 'Region',
  `postcode` varchar(255) NOT NULL COMMENT 'Zip/Postal Code',
  `city` varchar(255) NOT NULL COMMENT 'City',
  `street` text NOT NULL COMMENT 'Street',
  PRIMARY KEY (`recipient_address_id`),
  CONSTRAINT `FK_EEB9F0F035B969ECA24160257CFC6F6B` FOREIGN KEY (`recipient_address_id`) REFERENCES `sales_order_address` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Order Collection Point Entity';


DROP TABLE IF EXISTS `temando_order_pickup_location`;
CREATE TABLE `temando_order_pickup_location` (
  `recipient_address_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `pickup_location_id` varchar(64) NOT NULL COMMENT 'Pickup Location Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `country` varchar(2) NOT NULL COMMENT 'Country Code',
  `region` varchar(255) NOT NULL COMMENT 'Region',
  `postcode` varchar(255) NOT NULL COMMENT 'Zip/Postal Code',
  `city` varchar(255) NOT NULL COMMENT 'City',
  `street` text NOT NULL COMMENT 'Street',
  PRIMARY KEY (`recipient_address_id`),
  CONSTRAINT `FK_E106C6C0802F4A217B859D0FEA67E900` FOREIGN KEY (`recipient_address_id`) REFERENCES `sales_order_address` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Order Pickup Location Entity';


DROP TABLE IF EXISTS `temando_pickup_location_search`;
CREATE TABLE `temando_pickup_location_search` (
  `shipping_address_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `active` tinyint(1) NOT NULL COMMENT 'Active',
  PRIMARY KEY (`shipping_address_id`),
  CONSTRAINT `TEMANDO_PICKUP_LOCATION_SRCH_SHPP_ADDR_ID_QUOTE_ADDR_ADDR_ID` FOREIGN KEY (`shipping_address_id`) REFERENCES `quote_address` (`address_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Pickup Location Search';


DROP TABLE IF EXISTS `temando_quote_collection_point`;
CREATE TABLE `temando_quote_collection_point` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `recipient_address_id` int(10) unsigned NOT NULL COMMENT 'Quote Address Id',
  `collection_point_id` varchar(64) NOT NULL COMMENT 'Collection Point Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `country` varchar(2) NOT NULL COMMENT 'Country Code',
  `region` varchar(255) NOT NULL COMMENT 'Region',
  `postcode` varchar(255) NOT NULL COMMENT 'Zip/Postal Code',
  `city` varchar(255) NOT NULL COMMENT 'City',
  `street` text NOT NULL COMMENT 'Street',
  `opening_hours` text NOT NULL COMMENT 'Opening Hours',
  `shipping_experiences` text NOT NULL COMMENT 'Shipping Experiences',
  `selected` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Selected',
  PRIMARY KEY (`entity_id`),
  KEY `FK_4ABED96BBA0BAF57A5EC10E47B5A0F12` (`recipient_address_id`),
  CONSTRAINT `FK_4ABED96BBA0BAF57A5EC10E47B5A0F12` FOREIGN KEY (`recipient_address_id`) REFERENCES `temando_collection_point_search` (`shipping_address_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Quote Collection Point Entity';


DROP TABLE IF EXISTS `temando_quote_pickup_location`;
CREATE TABLE `temando_quote_pickup_location` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `recipient_address_id` int(10) unsigned NOT NULL COMMENT 'Quote Address Id',
  `pickup_location_id` varchar(64) NOT NULL COMMENT 'Pickup Location Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `country` varchar(2) NOT NULL COMMENT 'Country Code',
  `region` varchar(255) NOT NULL COMMENT 'Region',
  `postcode` varchar(255) NOT NULL COMMENT 'Zip/Postal Code',
  `city` varchar(255) NOT NULL COMMENT 'City',
  `street` text NOT NULL COMMENT 'Street',
  `opening_hours` text NOT NULL COMMENT 'Opening Hours',
  `shipping_experiences` text NOT NULL COMMENT 'Shipping Experiences',
  `selected` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Selected',
  PRIMARY KEY (`entity_id`),
  KEY `FK_9010B10870AF99FB0560ADA50F3F99F4` (`recipient_address_id`),
  CONSTRAINT `FK_9010B10870AF99FB0560ADA50F3F99F4` FOREIGN KEY (`recipient_address_id`) REFERENCES `temando_pickup_location_search` (`shipping_address_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Quote Pickup Location Entity';


DROP TABLE IF EXISTS `temando_shipment`;
CREATE TABLE `temando_shipment` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `shipment_id` int(10) unsigned NOT NULL COMMENT 'Magento Shipment Id',
  `ext_shipment_id` varchar(64) NOT NULL COMMENT 'External Shipment Id',
  `ext_location_id` varchar(64) DEFAULT NULL,
  `ext_tracking_url` varchar(255) DEFAULT NULL COMMENT 'External Tracking Url',
  `ext_tracking_reference` varchar(255) DEFAULT NULL COMMENT 'External Tracking Reference',
  `ext_return_shipment_id` varchar(64) DEFAULT NULL COMMENT 'External Return Shipment Id',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `TEMANDO_SHIPMENT_SHIPMENT_ID_EXT_SHIPMENT_ID` (`shipment_id`,`ext_shipment_id`),
  CONSTRAINT `TEMANDO_SHIPMENT_SHIPMENT_ID_SALES_SHIPMENT_ENTITY_ID` FOREIGN KEY (`shipment_id`) REFERENCES `sales_shipment` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Temando Shipment';


DROP TABLE IF EXISTS `theme`;
CREATE TABLE `theme` (
  `theme_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Theme identifier',
  `parent_id` int(11) DEFAULT NULL COMMENT 'Parent Id',
  `theme_path` varchar(255) DEFAULT NULL COMMENT 'Theme Path',
  `theme_title` varchar(255) NOT NULL COMMENT 'Theme Title',
  `preview_image` varchar(255) DEFAULT NULL COMMENT 'Preview Image',
  `is_featured` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Is Theme Featured',
  `area` varchar(255) NOT NULL COMMENT 'Theme Area',
  `type` smallint(6) NOT NULL COMMENT 'Theme type: 0:physical, 1:virtual, 2:staging',
  `code` text COMMENT 'Full theme code, including package',
  PRIMARY KEY (`theme_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Core theme';

INSERT INTO `theme` (`theme_id`, `parent_id`, `theme_path`, `theme_title`, `preview_image`, `is_featured`, `area`, `type`, `code`) VALUES
(1,	NULL,	'Magento/blank',	'Magento Blank',	'preview_image_5c6ac9bd0bff8.jpeg',	0,	'frontend',	0,	'Magento/blank'),
(2,	1,	'Magento/luma',	'Magento Luma',	'preview_image_5c6ac9bd26258.jpeg',	0,	'frontend',	0,	'Magento/luma'),
(3,	NULL,	'Magento/backend',	'Magento 2 backend',	NULL,	0,	'adminhtml',	0,	'Magento/backend');

DROP TABLE IF EXISTS `theme_file`;
CREATE TABLE `theme_file` (
  `theme_files_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Theme files identifier',
  `theme_id` int(10) unsigned NOT NULL COMMENT 'Theme Id',
  `file_path` varchar(255) DEFAULT NULL COMMENT 'Relative path to file',
  `file_type` varchar(32) NOT NULL COMMENT 'File Type',
  `content` longtext NOT NULL COMMENT 'File Content',
  `sort_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `is_temporary` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Is Temporary File',
  PRIMARY KEY (`theme_files_id`),
  KEY `THEME_FILE_THEME_ID_THEME_THEME_ID` (`theme_id`),
  CONSTRAINT `THEME_FILE_THEME_ID_THEME_THEME_ID` FOREIGN KEY (`theme_id`) REFERENCES `theme` (`theme_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Core theme files';


DROP TABLE IF EXISTS `translation`;
CREATE TABLE `translation` (
  `key_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Key Id of Translation',
  `string` varchar(255) NOT NULL DEFAULT 'Translate String' COMMENT 'Translation String',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `translate` varchar(255) DEFAULT NULL COMMENT 'Translate',
  `locale` varchar(20) NOT NULL DEFAULT 'en_US' COMMENT 'Locale',
  `crc_string` bigint(20) NOT NULL DEFAULT '1591228201' COMMENT 'Translation String CRC32 Hash',
  PRIMARY KEY (`key_id`),
  UNIQUE KEY `TRANSLATION_STORE_ID_LOCALE_CRC_STRING_STRING` (`store_id`,`locale`,`crc_string`,`string`),
  CONSTRAINT `TRANSLATION_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Translations';


DROP TABLE IF EXISTS `ui_bookmark`;
CREATE TABLE `ui_bookmark` (
  `bookmark_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Bookmark identifier',
  `user_id` int(10) unsigned NOT NULL COMMENT 'User Id',
  `namespace` varchar(255) NOT NULL COMMENT 'Bookmark namespace',
  `identifier` varchar(255) NOT NULL COMMENT 'Bookmark Identifier',
  `current` smallint(6) NOT NULL COMMENT 'Mark current bookmark per user and identifier',
  `title` varchar(255) DEFAULT NULL COMMENT 'Bookmark title',
  `config` longtext COMMENT 'Bookmark config',
  `created_at` datetime NOT NULL COMMENT 'Bookmark created at',
  `updated_at` datetime NOT NULL COMMENT 'Bookmark updated at',
  PRIMARY KEY (`bookmark_id`),
  KEY `UI_BOOKMARK_USER_ID_NAMESPACE_IDENTIFIER` (`user_id`,`namespace`,`identifier`),
  CONSTRAINT `UI_BOOKMARK_USER_ID_ADMIN_USER_USER_ID` FOREIGN KEY (`user_id`) REFERENCES `admin_user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Bookmark';

INSERT INTO `ui_bookmark` (`bookmark_id`, `user_id`, `namespace`, `identifier`, `current`, `title`, `config`, `created_at`, `updated_at`) VALUES
(1,	1,	'product_listing',	'current',	0,	NULL,	'{\"current\":{\"filters\":{\"applied\":{\"placeholder\":true}},\"columns\":{\"entity_id\":{\"visible\":true,\"sorting\":\"asc\"},\"name\":{\"visible\":true,\"sorting\":false},\"sku\":{\"visible\":true,\"sorting\":false},\"price\":{\"visible\":true,\"sorting\":false},\"websites\":{\"visible\":true,\"sorting\":false},\"qty\":{\"visible\":true,\"sorting\":false},\"short_description\":{\"visible\":false,\"sorting\":false},\"special_price\":{\"visible\":false,\"sorting\":false},\"cost\":{\"visible\":false,\"sorting\":false},\"weight\":{\"visible\":false,\"sorting\":false},\"meta_title\":{\"visible\":false,\"sorting\":false},\"meta_keyword\":{\"visible\":false,\"sorting\":false},\"meta_description\":{\"visible\":false,\"sorting\":false},\"msrp\":{\"visible\":false,\"sorting\":false},\"url_key\":{\"visible\":false,\"sorting\":false},\"actions\":{\"visible\":true,\"sorting\":false},\"ids\":{\"visible\":true,\"sorting\":false},\"type_id\":{\"visible\":true,\"sorting\":false},\"attribute_set_id\":{\"visible\":true,\"sorting\":false},\"visibility\":{\"visible\":true,\"sorting\":false},\"status\":{\"visible\":true,\"sorting\":false},\"manufacturer\":{\"visible\":false,\"sorting\":false},\"color\":{\"visible\":false,\"sorting\":false},\"custom_design\":{\"visible\":false,\"sorting\":false},\"page_layout\":{\"visible\":false,\"sorting\":false},\"country_of_manufacture\":{\"visible\":false,\"sorting\":false},\"custom_layout\":{\"visible\":false,\"sorting\":false},\"gift_message_available\":{\"visible\":false,\"sorting\":false},\"tax_class_id\":{\"visible\":false,\"sorting\":false},\"salable_quantity\":{\"visible\":true,\"sorting\":false},\"special_from_date\":{\"visible\":false,\"sorting\":false},\"special_to_date\":{\"visible\":false,\"sorting\":false},\"news_from_date\":{\"visible\":false,\"sorting\":false},\"news_to_date\":{\"visible\":false,\"sorting\":false},\"custom_design_from\":{\"visible\":false,\"sorting\":false},\"custom_design_to\":{\"visible\":false,\"sorting\":false},\"thumbnail\":{\"visible\":true,\"sorting\":false}},\"search\":{\"value\":\"\"},\"displayMode\":\"grid\",\"positions\":{\"ids\":0,\"entity_id\":1,\"thumbnail\":2,\"name\":3,\"type_id\":4,\"attribute_set_id\":5,\"sku\":6,\"price\":7,\"qty\":8,\"salable_quantity\":9,\"visibility\":10,\"status\":11,\"websites\":12,\"short_description\":13,\"special_price\":14,\"special_from_date\":15,\"special_to_date\":16,\"cost\":17,\"weight\":18,\"manufacturer\":19,\"meta_title\":20,\"meta_keyword\":21,\"meta_description\":22,\"color\":23,\"news_from_date\":24,\"news_to_date\":25,\"custom_design\":26,\"custom_design_from\":27,\"custom_design_to\":28,\"page_layout\":29,\"country_of_manufacture\":30,\"custom_layout\":31,\"msrp\":32,\"url_key\":33,\"gift_message_available\":34,\"tax_class_id\":35,\"actions\":36},\"paging\":{\"options\":{\"20\":{\"value\":20,\"label\":20},\"30\":{\"value\":30,\"label\":30},\"50\":{\"value\":50,\"label\":50},\"100\":{\"value\":100,\"label\":100},\"200\":{\"value\":200,\"label\":200}},\"value\":20}}}',	'0000-00-00 00:00:00',	'0000-00-00 00:00:00'),
(2,	1,	'product_listing',	'default',	1,	'Default View',	'{\"views\":{\"default\":{\"label\":\"Default View\",\"index\":\"default\",\"editable\":false,\"data\":{\"filters\":{\"applied\":{\"placeholder\":true}},\"columns\":{\"entity_id\":{\"visible\":true,\"sorting\":\"asc\"},\"name\":{\"visible\":true,\"sorting\":false},\"sku\":{\"visible\":true,\"sorting\":false},\"price\":{\"visible\":true,\"sorting\":false},\"websites\":{\"visible\":true,\"sorting\":false},\"qty\":{\"visible\":true,\"sorting\":false},\"short_description\":{\"visible\":false,\"sorting\":false},\"special_price\":{\"visible\":false,\"sorting\":false},\"cost\":{\"visible\":false,\"sorting\":false},\"weight\":{\"visible\":false,\"sorting\":false},\"meta_title\":{\"visible\":false,\"sorting\":false},\"meta_keyword\":{\"visible\":false,\"sorting\":false},\"meta_description\":{\"visible\":false,\"sorting\":false},\"msrp\":{\"visible\":false,\"sorting\":false},\"url_key\":{\"visible\":false,\"sorting\":false},\"actions\":{\"visible\":true,\"sorting\":false},\"ids\":{\"visible\":true,\"sorting\":false},\"type_id\":{\"visible\":true,\"sorting\":false},\"attribute_set_id\":{\"visible\":true,\"sorting\":false},\"visibility\":{\"visible\":true,\"sorting\":false},\"status\":{\"visible\":true,\"sorting\":false},\"manufacturer\":{\"visible\":false,\"sorting\":false},\"color\":{\"visible\":false,\"sorting\":false},\"custom_design\":{\"visible\":false,\"sorting\":false},\"page_layout\":{\"visible\":false,\"sorting\":false},\"country_of_manufacture\":{\"visible\":false,\"sorting\":false},\"custom_layout\":{\"visible\":false,\"sorting\":false},\"gift_message_available\":{\"visible\":false,\"sorting\":false},\"tax_class_id\":{\"visible\":false,\"sorting\":false},\"salable_quantity\":{\"visible\":true,\"sorting\":false},\"special_from_date\":{\"visible\":false,\"sorting\":false},\"special_to_date\":{\"visible\":false,\"sorting\":false},\"news_from_date\":{\"visible\":false,\"sorting\":false},\"news_to_date\":{\"visible\":false,\"sorting\":false},\"custom_design_from\":{\"visible\":false,\"sorting\":false},\"custom_design_to\":{\"visible\":false,\"sorting\":false},\"thumbnail\":{\"visible\":true,\"sorting\":false}},\"search\":{\"value\":\"\"},\"displayMode\":\"grid\",\"positions\":{\"ids\":0,\"entity_id\":1,\"thumbnail\":2,\"name\":3,\"type_id\":4,\"attribute_set_id\":5,\"sku\":6,\"price\":7,\"qty\":8,\"salable_quantity\":9,\"visibility\":10,\"status\":11,\"websites\":12,\"short_description\":13,\"special_price\":14,\"special_from_date\":15,\"special_to_date\":16,\"cost\":17,\"weight\":18,\"manufacturer\":19,\"meta_title\":20,\"meta_keyword\":21,\"meta_description\":22,\"color\":23,\"news_from_date\":24,\"news_to_date\":25,\"custom_design\":26,\"custom_design_from\":27,\"custom_design_to\":28,\"page_layout\":29,\"country_of_manufacture\":30,\"custom_layout\":31,\"msrp\":32,\"url_key\":33,\"gift_message_available\":34,\"tax_class_id\":35,\"actions\":36},\"paging\":{\"options\":{\"20\":{\"value\":20,\"label\":20},\"30\":{\"value\":30,\"label\":30},\"50\":{\"value\":50,\"label\":50},\"100\":{\"value\":100,\"label\":100},\"200\":{\"value\":200,\"label\":200}},\"value\":20}},\"value\":\"Default View\"}}}',	'0000-00-00 00:00:00',	'0000-00-00 00:00:00'),
(3,	1,	'cms_page_listing',	'default',	1,	'Default View',	'{\"views\":{\"default\":{\"label\":\"Default View\",\"index\":\"default\",\"editable\":false,\"data\":{\"search\":{\"value\":\"\"},\"filters\":{\"applied\":{\"placeholder\":true}},\"columns\":{\"page_id\":{\"visible\":true,\"sorting\":\"asc\"},\"title\":{\"visible\":true,\"sorting\":false},\"identifier\":{\"visible\":true,\"sorting\":false},\"store_id\":{\"visible\":true,\"sorting\":false},\"meta_title\":{\"visible\":false,\"sorting\":false},\"meta_keywords\":{\"visible\":false,\"sorting\":false},\"meta_description\":{\"visible\":false,\"sorting\":false},\"actions\":{\"visible\":true,\"sorting\":false},\"ids\":{\"visible\":true,\"sorting\":false},\"page_layout\":{\"visible\":true,\"sorting\":false},\"is_active\":{\"visible\":true,\"sorting\":false},\"custom_theme\":{\"visible\":false,\"sorting\":false},\"custom_root_template\":{\"visible\":false,\"sorting\":false},\"creation_time\":{\"visible\":true,\"sorting\":false},\"update_time\":{\"visible\":true,\"sorting\":false},\"custom_theme_from\":{\"visible\":false,\"sorting\":false},\"custom_theme_to\":{\"visible\":false,\"sorting\":false}},\"displayMode\":\"grid\",\"paging\":{\"options\":{\"20\":{\"value\":20,\"label\":20},\"30\":{\"value\":30,\"label\":30},\"50\":{\"value\":50,\"label\":50},\"100\":{\"value\":100,\"label\":100},\"200\":{\"value\":200,\"label\":200}},\"value\":20},\"positions\":{\"ids\":0,\"page_id\":1,\"title\":2,\"identifier\":3,\"page_layout\":4,\"store_id\":5,\"is_active\":6,\"creation_time\":7,\"update_time\":8,\"custom_theme_from\":9,\"custom_theme_to\":10,\"custom_theme\":11,\"custom_root_template\":12,\"meta_title\":13,\"meta_keywords\":14,\"meta_description\":15,\"actions\":16}},\"value\":\"Default View\"}}}',	'0000-00-00 00:00:00',	'0000-00-00 00:00:00'),
(4,	1,	'cms_page_listing',	'current',	0,	NULL,	'{\"current\":{\"search\":{\"value\":\"\"},\"filters\":{\"applied\":{\"placeholder\":true}},\"columns\":{\"page_id\":{\"visible\":true,\"sorting\":\"asc\"},\"title\":{\"visible\":true,\"sorting\":false},\"identifier\":{\"visible\":true,\"sorting\":false},\"store_id\":{\"visible\":true,\"sorting\":false},\"meta_title\":{\"visible\":false,\"sorting\":false},\"meta_keywords\":{\"visible\":false,\"sorting\":false},\"meta_description\":{\"visible\":false,\"sorting\":false},\"actions\":{\"visible\":true,\"sorting\":false},\"ids\":{\"visible\":true,\"sorting\":false},\"page_layout\":{\"visible\":true,\"sorting\":false},\"is_active\":{\"visible\":true,\"sorting\":false},\"custom_theme\":{\"visible\":false,\"sorting\":false},\"custom_root_template\":{\"visible\":false,\"sorting\":false},\"creation_time\":{\"visible\":true,\"sorting\":false},\"update_time\":{\"visible\":true,\"sorting\":false},\"custom_theme_from\":{\"visible\":false,\"sorting\":false},\"custom_theme_to\":{\"visible\":false,\"sorting\":false}},\"displayMode\":\"grid\",\"paging\":{\"options\":{\"20\":{\"value\":20,\"label\":20},\"30\":{\"value\":30,\"label\":30},\"50\":{\"value\":50,\"label\":50},\"100\":{\"value\":100,\"label\":100},\"200\":{\"value\":200,\"label\":200}},\"value\":20},\"positions\":{\"ids\":0,\"page_id\":1,\"title\":2,\"identifier\":3,\"page_layout\":4,\"store_id\":5,\"is_active\":6,\"creation_time\":7,\"update_time\":8,\"custom_theme_from\":9,\"custom_theme_to\":10,\"custom_theme\":11,\"custom_root_template\":12,\"meta_title\":13,\"meta_keywords\":14,\"meta_description\":15,\"actions\":16}}}',	'0000-00-00 00:00:00',	'0000-00-00 00:00:00'),
(5,	1,	'sales_order_grid',	'current',	0,	NULL,	'{\"current\":{\"search\":{\"value\":\"\"},\"columns\":{\"increment_id\":{\"visible\":true,\"sorting\":false},\"store_id\":{\"visible\":true,\"sorting\":false},\"billing_name\":{\"visible\":true,\"sorting\":false},\"shipping_name\":{\"visible\":true,\"sorting\":false},\"base_grand_total\":{\"visible\":true,\"sorting\":false},\"grand_total\":{\"visible\":true,\"sorting\":false},\"billing_address\":{\"visible\":false,\"sorting\":false},\"shipping_address\":{\"visible\":false,\"sorting\":false},\"shipping_information\":{\"visible\":false,\"sorting\":false},\"customer_email\":{\"visible\":false,\"sorting\":false},\"subtotal\":{\"visible\":false,\"sorting\":false},\"shipping_and_handling\":{\"visible\":false,\"sorting\":false},\"customer_name\":{\"visible\":false,\"sorting\":false},\"total_refunded\":{\"visible\":false,\"sorting\":false},\"actions\":{\"visible\":true,\"sorting\":false},\"created_at\":{\"visible\":true,\"sorting\":\"desc\"},\"ids\":{\"visible\":true,\"sorting\":false},\"status\":{\"visible\":true,\"sorting\":false},\"customer_group\":{\"visible\":false,\"sorting\":false},\"payment_method\":{\"visible\":false,\"sorting\":false},\"signifyd_guarantee_status\":{\"visible\":true,\"sorting\":false}},\"filters\":{\"applied\":{\"placeholder\":true}},\"displayMode\":\"grid\",\"positions\":{\"ids\":0,\"increment_id\":1,\"store_id\":2,\"created_at\":3,\"billing_name\":4,\"shipping_name\":5,\"base_grand_total\":6,\"grand_total\":7,\"status\":8,\"billing_address\":9,\"shipping_address\":10,\"shipping_information\":11,\"customer_email\":12,\"customer_group\":13,\"subtotal\":14,\"shipping_and_handling\":15,\"customer_name\":16,\"payment_method\":17,\"total_refunded\":18,\"actions\":19,\"signifyd_guarantee_status\":20},\"paging\":{\"options\":{\"20\":{\"value\":20,\"label\":20},\"30\":{\"value\":30,\"label\":30},\"50\":{\"value\":50,\"label\":50},\"100\":{\"value\":100,\"label\":100},\"200\":{\"value\":200,\"label\":200}},\"value\":20}}}',	'0000-00-00 00:00:00',	'0000-00-00 00:00:00'),
(6,	1,	'sales_order_grid',	'default',	1,	'Default View',	'{\"views\":{\"default\":{\"label\":\"Default View\",\"index\":\"default\",\"editable\":false,\"data\":{\"search\":{\"value\":\"\"},\"columns\":{\"increment_id\":{\"visible\":true,\"sorting\":false},\"store_id\":{\"visible\":true,\"sorting\":false},\"billing_name\":{\"visible\":true,\"sorting\":false},\"shipping_name\":{\"visible\":true,\"sorting\":false},\"base_grand_total\":{\"visible\":true,\"sorting\":false},\"grand_total\":{\"visible\":true,\"sorting\":false},\"billing_address\":{\"visible\":false,\"sorting\":false},\"shipping_address\":{\"visible\":false,\"sorting\":false},\"shipping_information\":{\"visible\":false,\"sorting\":false},\"customer_email\":{\"visible\":false,\"sorting\":false},\"subtotal\":{\"visible\":false,\"sorting\":false},\"shipping_and_handling\":{\"visible\":false,\"sorting\":false},\"customer_name\":{\"visible\":false,\"sorting\":false},\"total_refunded\":{\"visible\":false,\"sorting\":false},\"actions\":{\"visible\":true,\"sorting\":false},\"created_at\":{\"visible\":true,\"sorting\":\"desc\"},\"ids\":{\"visible\":true,\"sorting\":false},\"status\":{\"visible\":true,\"sorting\":false},\"customer_group\":{\"visible\":false,\"sorting\":false},\"payment_method\":{\"visible\":false,\"sorting\":false},\"signifyd_guarantee_status\":{\"visible\":true,\"sorting\":false}},\"filters\":{\"applied\":{\"placeholder\":true}},\"displayMode\":\"grid\",\"positions\":{\"ids\":0,\"increment_id\":1,\"store_id\":2,\"created_at\":3,\"billing_name\":4,\"shipping_name\":5,\"base_grand_total\":6,\"grand_total\":7,\"status\":8,\"billing_address\":9,\"shipping_address\":10,\"shipping_information\":11,\"customer_email\":12,\"customer_group\":13,\"subtotal\":14,\"shipping_and_handling\":15,\"customer_name\":16,\"payment_method\":17,\"total_refunded\":18,\"actions\":19,\"signifyd_guarantee_status\":20},\"paging\":{\"options\":{\"20\":{\"value\":20,\"label\":20},\"30\":{\"value\":30,\"label\":30},\"50\":{\"value\":50,\"label\":50},\"100\":{\"value\":100,\"label\":100},\"200\":{\"value\":200,\"label\":200}},\"value\":20}},\"value\":\"Default View\"}}}',	'0000-00-00 00:00:00',	'0000-00-00 00:00:00'),
(7,	1,	'sales_order_view_invoice_grid',	'default',	1,	'Default View',	'{\"views\":{\"default\":{\"label\":\"Default View\",\"index\":\"default\",\"editable\":false,\"data\":{\"filters\":{\"applied\":{\"placeholder\":true}},\"columns\":{\"increment_id\":{\"visible\":true,\"sorting\":\"asc\"},\"order_increment_id\":{\"visible\":true,\"sorting\":false},\"billing_name\":{\"visible\":true,\"sorting\":false},\"grand_total\":{\"visible\":true,\"sorting\":false},\"store_id\":{\"visible\":false,\"sorting\":false},\"billing_address\":{\"visible\":false,\"sorting\":false},\"shipping_address\":{\"visible\":false,\"sorting\":false},\"customer_name\":{\"visible\":false,\"sorting\":false},\"customer_email\":{\"visible\":false,\"sorting\":false},\"shipping_information\":{\"visible\":false,\"sorting\":false},\"subtotal\":{\"visible\":false,\"sorting\":false},\"shipping_and_handling\":{\"visible\":false,\"sorting\":false},\"actions\":{\"visible\":true,\"sorting\":false},\"ids\":{\"visible\":true,\"sorting\":false},\"created_at\":{\"visible\":true,\"sorting\":false},\"order_created_at\":{\"visible\":true,\"sorting\":false},\"state\":{\"visible\":true,\"sorting\":false},\"customer_group_id\":{\"visible\":false,\"sorting\":false},\"payment_method\":{\"visible\":false,\"sorting\":false}},\"displayMode\":\"grid\",\"paging\":{\"options\":{\"20\":{\"value\":20,\"label\":20},\"30\":{\"value\":30,\"label\":30},\"50\":{\"value\":50,\"label\":50},\"100\":{\"value\":100,\"label\":100},\"200\":{\"value\":200,\"label\":200}},\"value\":20},\"positions\":{\"ids\":0,\"increment_id\":1,\"created_at\":2,\"order_increment_id\":3,\"order_created_at\":4,\"billing_name\":5,\"state\":6,\"grand_total\":7,\"store_id\":8,\"billing_address\":9,\"shipping_address\":10,\"customer_name\":11,\"customer_email\":12,\"customer_group_id\":13,\"payment_method\":14,\"shipping_information\":15,\"subtotal\":16,\"shipping_and_handling\":17,\"actions\":18},\"search\":{\"value\":\"\"}},\"value\":\"Default View\"}}}',	'0000-00-00 00:00:00',	'0000-00-00 00:00:00'),
(8,	1,	'sales_order_view_creditmemo_grid',	'default',	1,	'Default View',	'{\"views\":{\"default\":{\"label\":\"Default View\",\"index\":\"default\",\"editable\":false,\"data\":{\"filters\":{\"applied\":{\"placeholder\":true}},\"columns\":{\"increment_id\":{\"visible\":true,\"sorting\":false},\"order_increment_id\":{\"visible\":true,\"sorting\":false},\"billing_name\":{\"visible\":true,\"sorting\":false},\"base_grand_total\":{\"visible\":true,\"sorting\":false},\"store_id\":{\"visible\":false,\"sorting\":false},\"billing_address\":{\"visible\":false,\"sorting\":false},\"shipping_address\":{\"visible\":false,\"sorting\":false},\"customer_name\":{\"visible\":false,\"sorting\":false},\"customer_email\":{\"visible\":false,\"sorting\":false},\"shipping_information\":{\"visible\":false,\"sorting\":false},\"subtotal\":{\"visible\":false,\"sorting\":false},\"shipping_and_handling\":{\"visible\":false,\"sorting\":false},\"adjustment_positive\":{\"visible\":false,\"sorting\":false},\"adjustment_negative\":{\"visible\":false,\"sorting\":false},\"order_base_grand_total\":{\"visible\":false,\"sorting\":false},\"actions\":{\"visible\":true,\"sorting\":false},\"ids\":{\"visible\":true,\"sorting\":false},\"created_at\":{\"visible\":true,\"sorting\":false},\"order_created_at\":{\"visible\":true,\"sorting\":false},\"state\":{\"visible\":true,\"sorting\":false},\"order_status\":{\"visible\":false,\"sorting\":false},\"customer_group_id\":{\"visible\":false,\"sorting\":false},\"payment_method\":{\"visible\":false,\"sorting\":false}},\"displayMode\":\"grid\",\"paging\":{\"options\":{\"20\":{\"value\":20,\"label\":20},\"30\":{\"value\":30,\"label\":30},\"50\":{\"value\":50,\"label\":50},\"100\":{\"value\":100,\"label\":100},\"200\":{\"value\":200,\"label\":200}},\"value\":20},\"positions\":{\"ids\":0,\"increment_id\":1,\"created_at\":2,\"order_increment_id\":3,\"order_created_at\":4,\"billing_name\":5,\"state\":6,\"base_grand_total\":7,\"order_status\":8,\"store_id\":9,\"billing_address\":10,\"shipping_address\":11,\"customer_name\":12,\"customer_email\":13,\"customer_group_id\":14,\"payment_method\":15,\"shipping_information\":16,\"subtotal\":17,\"shipping_and_handling\":18,\"adjustment_positive\":19,\"adjustment_negative\":20,\"order_base_grand_total\":21,\"actions\":22},\"search\":{\"value\":\"\"}},\"value\":\"Default View\"}}}',	'0000-00-00 00:00:00',	'0000-00-00 00:00:00'),
(9,	1,	'sales_order_view_shipment_grid',	'default',	1,	'Default View',	'{\"views\":{\"default\":{\"label\":\"Default View\",\"index\":\"default\",\"editable\":false,\"data\":{\"filters\":{\"applied\":{\"placeholder\":true}},\"columns\":{\"increment_id\":{\"visible\":true,\"sorting\":\"asc\"},\"order_increment_id\":{\"visible\":true,\"sorting\":false},\"shipping_name\":{\"visible\":true,\"sorting\":false},\"total_qty\":{\"visible\":true,\"sorting\":false},\"store_id\":{\"visible\":false,\"sorting\":false},\"customer_name\":{\"visible\":false,\"sorting\":false},\"customer_email\":{\"visible\":false,\"sorting\":false},\"billing_address\":{\"visible\":false,\"sorting\":false},\"shipping_address\":{\"visible\":false,\"sorting\":false},\"shipping_information\":{\"visible\":false,\"sorting\":false},\"actions\":{\"visible\":true,\"sorting\":false},\"ids\":{\"visible\":true,\"sorting\":false},\"created_at\":{\"visible\":true,\"sorting\":false},\"order_created_at\":{\"visible\":true,\"sorting\":false},\"order_status\":{\"visible\":false,\"sorting\":false},\"customer_group_id\":{\"visible\":false,\"sorting\":false},\"payment_method\":{\"visible\":false,\"sorting\":false}},\"displayMode\":\"grid\",\"paging\":{\"options\":{\"20\":{\"value\":20,\"label\":20},\"30\":{\"value\":30,\"label\":30},\"50\":{\"value\":50,\"label\":50},\"100\":{\"value\":100,\"label\":100},\"200\":{\"value\":200,\"label\":200}},\"value\":20},\"positions\":{\"ids\":0,\"increment_id\":1,\"created_at\":2,\"order_increment_id\":3,\"order_created_at\":4,\"shipping_name\":5,\"total_qty\":6,\"order_status\":7,\"store_id\":8,\"customer_name\":9,\"customer_email\":10,\"customer_group_id\":11,\"billing_address\":12,\"shipping_address\":13,\"payment_method\":14,\"shipping_information\":15,\"actions\":16},\"search\":{\"value\":\"\"}},\"value\":\"Default View\"}}}',	'0000-00-00 00:00:00',	'0000-00-00 00:00:00'),
(10,	1,	'sales_order_view_creditmemo_grid',	'current',	0,	NULL,	'{\"current\":{\"filters\":{\"applied\":{\"placeholder\":true}},\"columns\":{\"increment_id\":{\"visible\":true,\"sorting\":false},\"order_increment_id\":{\"visible\":true,\"sorting\":false},\"billing_name\":{\"visible\":true,\"sorting\":false},\"base_grand_total\":{\"visible\":true,\"sorting\":false},\"store_id\":{\"visible\":false,\"sorting\":false},\"billing_address\":{\"visible\":false,\"sorting\":false},\"shipping_address\":{\"visible\":false,\"sorting\":false},\"customer_name\":{\"visible\":false,\"sorting\":false},\"customer_email\":{\"visible\":false,\"sorting\":false},\"shipping_information\":{\"visible\":false,\"sorting\":false},\"subtotal\":{\"visible\":false,\"sorting\":false},\"shipping_and_handling\":{\"visible\":false,\"sorting\":false},\"adjustment_positive\":{\"visible\":false,\"sorting\":false},\"adjustment_negative\":{\"visible\":false,\"sorting\":false},\"order_base_grand_total\":{\"visible\":false,\"sorting\":false},\"actions\":{\"visible\":true,\"sorting\":false},\"ids\":{\"visible\":true,\"sorting\":false},\"created_at\":{\"visible\":true,\"sorting\":false},\"order_created_at\":{\"visible\":true,\"sorting\":false},\"state\":{\"visible\":true,\"sorting\":false},\"order_status\":{\"visible\":false,\"sorting\":false},\"customer_group_id\":{\"visible\":false,\"sorting\":false},\"payment_method\":{\"visible\":false,\"sorting\":false}},\"displayMode\":\"grid\",\"paging\":{\"options\":{\"20\":{\"value\":20,\"label\":20},\"30\":{\"value\":30,\"label\":30},\"50\":{\"value\":50,\"label\":50},\"100\":{\"value\":100,\"label\":100},\"200\":{\"value\":200,\"label\":200}},\"value\":20},\"positions\":{\"ids\":0,\"increment_id\":1,\"created_at\":2,\"order_increment_id\":3,\"order_created_at\":4,\"billing_name\":5,\"state\":6,\"base_grand_total\":7,\"order_status\":8,\"store_id\":9,\"billing_address\":10,\"shipping_address\":11,\"customer_name\":12,\"customer_email\":13,\"customer_group_id\":14,\"payment_method\":15,\"shipping_information\":16,\"subtotal\":17,\"shipping_and_handling\":18,\"adjustment_positive\":19,\"adjustment_negative\":20,\"order_base_grand_total\":21,\"actions\":22},\"search\":{\"value\":\"\"}}}',	'0000-00-00 00:00:00',	'0000-00-00 00:00:00'),
(11,	1,	'sales_order_view_shipment_grid',	'current',	0,	NULL,	'{\"current\":{\"filters\":{\"applied\":{\"placeholder\":true}},\"columns\":{\"increment_id\":{\"visible\":true,\"sorting\":\"asc\"},\"order_increment_id\":{\"visible\":true,\"sorting\":false},\"shipping_name\":{\"visible\":true,\"sorting\":false},\"total_qty\":{\"visible\":true,\"sorting\":false},\"store_id\":{\"visible\":false,\"sorting\":false},\"customer_name\":{\"visible\":false,\"sorting\":false},\"customer_email\":{\"visible\":false,\"sorting\":false},\"billing_address\":{\"visible\":false,\"sorting\":false},\"shipping_address\":{\"visible\":false,\"sorting\":false},\"shipping_information\":{\"visible\":false,\"sorting\":false},\"actions\":{\"visible\":true,\"sorting\":false},\"ids\":{\"visible\":true,\"sorting\":false},\"created_at\":{\"visible\":true,\"sorting\":false},\"order_created_at\":{\"visible\":true,\"sorting\":false},\"order_status\":{\"visible\":false,\"sorting\":false},\"customer_group_id\":{\"visible\":false,\"sorting\":false},\"payment_method\":{\"visible\":false,\"sorting\":false}},\"displayMode\":\"grid\",\"paging\":{\"options\":{\"20\":{\"value\":20,\"label\":20},\"30\":{\"value\":30,\"label\":30},\"50\":{\"value\":50,\"label\":50},\"100\":{\"value\":100,\"label\":100},\"200\":{\"value\":200,\"label\":200}},\"value\":20},\"positions\":{\"ids\":0,\"increment_id\":1,\"created_at\":2,\"order_increment_id\":3,\"order_created_at\":4,\"shipping_name\":5,\"total_qty\":6,\"order_status\":7,\"store_id\":8,\"customer_name\":9,\"customer_email\":10,\"customer_group_id\":11,\"billing_address\":12,\"shipping_address\":13,\"payment_method\":14,\"shipping_information\":15,\"actions\":16},\"search\":{\"value\":\"\"}}}',	'0000-00-00 00:00:00',	'0000-00-00 00:00:00'),
(12,	1,	'sales_order_view_invoice_grid',	'current',	0,	NULL,	'{\"current\":{\"filters\":{\"applied\":{\"placeholder\":true}},\"columns\":{\"increment_id\":{\"visible\":true,\"sorting\":\"asc\"},\"order_increment_id\":{\"visible\":true,\"sorting\":false},\"billing_name\":{\"visible\":true,\"sorting\":false},\"grand_total\":{\"visible\":true,\"sorting\":false},\"store_id\":{\"visible\":false,\"sorting\":false},\"billing_address\":{\"visible\":false,\"sorting\":false},\"shipping_address\":{\"visible\":false,\"sorting\":false},\"customer_name\":{\"visible\":false,\"sorting\":false},\"customer_email\":{\"visible\":false,\"sorting\":false},\"shipping_information\":{\"visible\":false,\"sorting\":false},\"subtotal\":{\"visible\":false,\"sorting\":false},\"shipping_and_handling\":{\"visible\":false,\"sorting\":false},\"actions\":{\"visible\":true,\"sorting\":false},\"ids\":{\"visible\":true,\"sorting\":false},\"created_at\":{\"visible\":true,\"sorting\":false},\"order_created_at\":{\"visible\":true,\"sorting\":false},\"state\":{\"visible\":true,\"sorting\":false},\"customer_group_id\":{\"visible\":false,\"sorting\":false},\"payment_method\":{\"visible\":false,\"sorting\":false}},\"displayMode\":\"grid\",\"paging\":{\"options\":{\"20\":{\"value\":20,\"label\":20},\"30\":{\"value\":30,\"label\":30},\"50\":{\"value\":50,\"label\":50},\"100\":{\"value\":100,\"label\":100},\"200\":{\"value\":200,\"label\":200}},\"value\":20},\"positions\":{\"ids\":0,\"increment_id\":1,\"created_at\":2,\"order_increment_id\":3,\"order_created_at\":4,\"billing_name\":5,\"state\":6,\"grand_total\":7,\"store_id\":8,\"billing_address\":9,\"shipping_address\":10,\"customer_name\":11,\"customer_email\":12,\"customer_group_id\":13,\"payment_method\":14,\"shipping_information\":15,\"subtotal\":16,\"shipping_and_handling\":17,\"actions\":18},\"search\":{\"value\":\"\"}}}',	'0000-00-00 00:00:00',	'0000-00-00 00:00:00');

DROP TABLE IF EXISTS `url_rewrite`;
CREATE TABLE `url_rewrite` (
  `url_rewrite_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rewrite Id',
  `entity_type` varchar(32) NOT NULL COMMENT 'Entity type code',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `request_path` varchar(255) DEFAULT NULL COMMENT 'Request Path',
  `target_path` varchar(255) DEFAULT NULL COMMENT 'Target Path',
  `redirect_type` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Redirect Type',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `description` varchar(255) DEFAULT NULL COMMENT 'Description',
  `is_autogenerated` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is rewrite generated automatically flag',
  `metadata` varchar(255) DEFAULT NULL COMMENT 'Meta data for url rewrite',
  PRIMARY KEY (`url_rewrite_id`),
  UNIQUE KEY `URL_REWRITE_REQUEST_PATH_STORE_ID` (`request_path`,`store_id`),
  KEY `URL_REWRITE_TARGET_PATH` (`target_path`),
  KEY `URL_REWRITE_STORE_ID_ENTITY_ID` (`store_id`,`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Url Rewrites';

INSERT INTO `url_rewrite` (`url_rewrite_id`, `entity_type`, `entity_id`, `request_path`, `target_path`, `redirect_type`, `store_id`, `description`, `is_autogenerated`, `metadata`) VALUES
(1,	'cms-page',	1,	'no-route',	'cms/page/view/page_id/1',	0,	1,	NULL,	1,	NULL),
(2,	'cms-page',	2,	'home',	'cms/page/view/page_id/2',	0,	1,	NULL,	1,	NULL),
(3,	'cms-page',	3,	'enable-cookies',	'cms/page/view/page_id/3',	0,	1,	NULL,	1,	NULL),
(4,	'cms-page',	4,	'privacy-policy-cookie-restriction-mode',	'cms/page/view/page_id/4',	0,	1,	NULL,	1,	NULL),
(5,	'product',	1,	'simple-product-1.html',	'catalog/product/view/id/1',	0,	1,	NULL,	1,	NULL);

DROP TABLE IF EXISTS `variable`;
CREATE TABLE `variable` (
  `variable_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Variable Id',
  `code` varchar(255) DEFAULT NULL COMMENT 'Variable Code',
  `name` varchar(255) DEFAULT NULL COMMENT 'Variable Name',
  PRIMARY KEY (`variable_id`),
  UNIQUE KEY `VARIABLE_CODE` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Variables';


DROP TABLE IF EXISTS `variable_value`;
CREATE TABLE `variable_value` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Variable Value Id',
  `variable_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Variable Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `plain_value` text COMMENT 'Plain Text Value',
  `html_value` text COMMENT 'Html Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `VARIABLE_VALUE_VARIABLE_ID_STORE_ID` (`variable_id`,`store_id`),
  KEY `VARIABLE_VALUE_STORE_ID` (`store_id`),
  CONSTRAINT `VARIABLE_VALUE_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `VARIABLE_VALUE_VARIABLE_ID_VARIABLE_VARIABLE_ID` FOREIGN KEY (`variable_id`) REFERENCES `variable` (`variable_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Variable Value';


DROP TABLE IF EXISTS `vault_payment_token`;
CREATE TABLE `vault_payment_token` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `public_hash` varchar(128) NOT NULL COMMENT 'Hash code for using on frontend',
  `payment_method_code` varchar(128) NOT NULL COMMENT 'Payment method code',
  `type` varchar(128) NOT NULL COMMENT 'Type',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `expires_at` timestamp NULL DEFAULT NULL COMMENT 'Expires At',
  `gateway_token` varchar(255) NOT NULL COMMENT 'Gateway Token',
  `details` text COMMENT 'Details',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_visible` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `VAULT_PAYMENT_TOKEN_PUBLIC_HASH` (`public_hash`),
  UNIQUE KEY `VAULT_PAYMENT_TOKEN_PAYMENT_METHOD_CODE_CSTR_ID_GATEWAY_TOKEN` (`payment_method_code`,`customer_id`,`gateway_token`),
  KEY `VAULT_PAYMENT_TOKEN_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` (`customer_id`),
  CONSTRAINT `VAULT_PAYMENT_TOKEN_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Vault tokens of payment';


DROP TABLE IF EXISTS `vault_payment_token_order_payment_link`;
CREATE TABLE `vault_payment_token_order_payment_link` (
  `order_payment_id` int(10) unsigned NOT NULL COMMENT 'Order payment Id',
  `payment_token_id` int(10) unsigned NOT NULL COMMENT 'Payment token Id',
  PRIMARY KEY (`order_payment_id`,`payment_token_id`),
  KEY `FK_4ED894655446D385894580BECA993862` (`payment_token_id`),
  CONSTRAINT `FK_4ED894655446D385894580BECA993862` FOREIGN KEY (`payment_token_id`) REFERENCES `vault_payment_token` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_CF37B9D854256534BE23C818F6291CA2` FOREIGN KEY (`order_payment_id`) REFERENCES `sales_order_payment` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Order payments to vault token';


DROP TABLE IF EXISTS `vertex_customer_code`;
CREATE TABLE `vertex_customer_code` (
  `customer_id` int(10) unsigned NOT NULL COMMENT 'Customer ID',
  `customer_code` text COMMENT 'Customer Code for Vertex',
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='vertex_customer_code';


DROP TABLE IF EXISTS `vertex_invoice_sent`;
CREATE TABLE `vertex_invoice_sent` (
  `invoice_id` int(10) unsigned NOT NULL COMMENT 'Invoice ID',
  `sent_to_vertex` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Invoice has been logged in Vertex',
  PRIMARY KEY (`invoice_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='vertex_invoice_sent';


DROP TABLE IF EXISTS `vertex_order_invoice_status`;
CREATE TABLE `vertex_order_invoice_status` (
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order ID',
  `sent_to_vertex` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Invoice has been logged in Vertex',
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='vertex_order_invoice_status';


DROP TABLE IF EXISTS `vertex_taxrequest`;
CREATE TABLE `vertex_taxrequest` (
  `request_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `request_type` varchar(255) NOT NULL COMMENT 'Request Type',
  `quote_id` bigint(20) DEFAULT NULL,
  `order_id` bigint(20) DEFAULT NULL,
  `total_tax` varchar(255) NOT NULL COMMENT 'Total Tax Amount',
  `source_path` varchar(255) NOT NULL COMMENT 'Source path controller_module_action',
  `tax_area_id` varchar(255) NOT NULL COMMENT 'Tax Jurisdictions Id',
  `sub_total` varchar(255) NOT NULL COMMENT 'Response Subtotal Amount',
  `total` varchar(255) NOT NULL COMMENT 'Response Total Amount',
  `lookup_result` varchar(255) NOT NULL COMMENT 'Tax Area Response Lookup Result',
  `request_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Request create date',
  `request_xml` text NOT NULL COMMENT 'Request XML',
  `response_xml` text NOT NULL COMMENT 'Response XML',
  PRIMARY KEY (`request_id`),
  UNIQUE KEY `VERTEX_TAXREQUEST_REQUEST_ID` (`request_id`),
  KEY `VERTEX_TAXREQUEST_REQUEST_TYPE` (`request_type`),
  KEY `VERTEX_TAXREQUEST_ORDER_ID` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Log of requests to Vertex';


DROP TABLE IF EXISTS `weee_tax`;
CREATE TABLE `weee_tax` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `country` varchar(2) DEFAULT NULL COMMENT 'Country',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  `state` int(11) NOT NULL DEFAULT '0' COMMENT 'State',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  PRIMARY KEY (`value_id`),
  KEY `WEEE_TAX_WEBSITE_ID` (`website_id`),
  KEY `WEEE_TAX_ENTITY_ID` (`entity_id`),
  KEY `WEEE_TAX_COUNTRY` (`country`),
  KEY `WEEE_TAX_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `WEEE_TAX_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `WEEE_TAX_COUNTRY_DIRECTORY_COUNTRY_COUNTRY_ID` FOREIGN KEY (`country`) REFERENCES `directory_country` (`country_id`) ON DELETE CASCADE,
  CONSTRAINT `WEEE_TAX_ENTITY_ID_CATALOG_PRODUCT_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `WEEE_TAX_WEBSITE_ID_STORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Weee Tax';


DROP TABLE IF EXISTS `widget`;
CREATE TABLE `widget` (
  `widget_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Widget Id',
  `widget_code` varchar(255) DEFAULT NULL COMMENT 'Widget code for template directive',
  `widget_type` varchar(255) DEFAULT NULL COMMENT 'Widget Type',
  `parameters` text COMMENT 'Parameters',
  PRIMARY KEY (`widget_id`),
  KEY `WIDGET_WIDGET_CODE` (`widget_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Preconfigured Widgets';


DROP TABLE IF EXISTS `widget_instance`;
CREATE TABLE `widget_instance` (
  `instance_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Instance Id',
  `instance_type` varchar(255) DEFAULT NULL COMMENT 'Instance Type',
  `theme_id` int(10) unsigned NOT NULL COMMENT 'Theme id',
  `title` varchar(255) DEFAULT NULL COMMENT 'Widget Title',
  `store_ids` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Store ids',
  `widget_parameters` text COMMENT 'Widget parameters',
  `sort_order` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort order',
  PRIMARY KEY (`instance_id`),
  KEY `WIDGET_INSTANCE_THEME_ID_THEME_THEME_ID` (`theme_id`),
  CONSTRAINT `WIDGET_INSTANCE_THEME_ID_THEME_THEME_ID` FOREIGN KEY (`theme_id`) REFERENCES `theme` (`theme_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Instances of Widget for Package Theme';


DROP TABLE IF EXISTS `widget_instance_page`;
CREATE TABLE `widget_instance_page` (
  `page_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Page Id',
  `instance_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Instance Id',
  `page_group` varchar(25) DEFAULT NULL COMMENT 'Block Group Type',
  `layout_handle` varchar(255) DEFAULT NULL COMMENT 'Layout Handle',
  `block_reference` varchar(255) DEFAULT NULL COMMENT 'Container',
  `page_for` varchar(25) DEFAULT NULL COMMENT 'For instance entities',
  `entities` text COMMENT 'Catalog entities (comma separated)',
  `page_template` varchar(255) DEFAULT NULL COMMENT 'Path to widget template',
  PRIMARY KEY (`page_id`),
  KEY `WIDGET_INSTANCE_PAGE_INSTANCE_ID` (`instance_id`),
  CONSTRAINT `WIDGET_INSTANCE_PAGE_INSTANCE_ID_WIDGET_INSTANCE_INSTANCE_ID` FOREIGN KEY (`instance_id`) REFERENCES `widget_instance` (`instance_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Instance of Widget on Page';


DROP TABLE IF EXISTS `widget_instance_page_layout`;
CREATE TABLE `widget_instance_page_layout` (
  `page_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Page Id',
  `layout_update_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Layout Update Id',
  UNIQUE KEY `WIDGET_INSTANCE_PAGE_LAYOUT_LAYOUT_UPDATE_ID_PAGE_ID` (`layout_update_id`,`page_id`),
  KEY `WIDGET_INSTANCE_PAGE_LAYOUT_PAGE_ID` (`page_id`),
  CONSTRAINT `WIDGET_INSTANCE_PAGE_LAYOUT_PAGE_ID_WIDGET_INSTANCE_PAGE_PAGE_ID` FOREIGN KEY (`page_id`) REFERENCES `widget_instance_page` (`page_id`) ON DELETE CASCADE,
  CONSTRAINT `WIDGET_INSTANCE_PAGE_LYT_LYT_UPDATE_ID_LYT_UPDATE_LYT_UPDATE_ID` FOREIGN KEY (`layout_update_id`) REFERENCES `layout_update` (`layout_update_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Layout updates';


DROP TABLE IF EXISTS `wishlist`;
CREATE TABLE `wishlist` (
  `wishlist_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Wishlist ID',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer ID',
  `shared` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Sharing flag (0 or 1)',
  `sharing_code` varchar(32) DEFAULT NULL COMMENT 'Sharing encrypted code',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Last updated date',
  PRIMARY KEY (`wishlist_id`),
  UNIQUE KEY `WISHLIST_CUSTOMER_ID` (`customer_id`),
  KEY `WISHLIST_SHARED` (`shared`),
  CONSTRAINT `WISHLIST_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Wishlist main Table';

INSERT INTO `wishlist` (`wishlist_id`, `customer_id`, `shared`, `sharing_code`, `updated_at`) VALUES
(1,	1,	0,	'xAcmgCH0DjSYsZ0DE4GqQpTQp7oPms5X',	'2019-02-18 15:06:45');

DROP TABLE IF EXISTS `wishlist_item`;
CREATE TABLE `wishlist_item` (
  `wishlist_item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Wishlist item ID',
  `wishlist_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Wishlist ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store ID',
  `added_at` timestamp NULL DEFAULT NULL COMMENT 'Add date and time',
  `description` text COMMENT 'Short description of wish list item',
  `qty` decimal(12,4) NOT NULL COMMENT 'Qty',
  PRIMARY KEY (`wishlist_item_id`),
  KEY `WISHLIST_ITEM_WISHLIST_ID` (`wishlist_id`),
  KEY `WISHLIST_ITEM_PRODUCT_ID` (`product_id`),
  KEY `WISHLIST_ITEM_STORE_ID` (`store_id`),
  CONSTRAINT `WISHLIST_ITEM_PRODUCT_ID_CATALOG_PRODUCT_ENTITY_ENTITY_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `WISHLIST_ITEM_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE SET NULL,
  CONSTRAINT `WISHLIST_ITEM_WISHLIST_ID_WISHLIST_WISHLIST_ID` FOREIGN KEY (`wishlist_id`) REFERENCES `wishlist` (`wishlist_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Wishlist items';


DROP TABLE IF EXISTS `wishlist_item_option`;
CREATE TABLE `wishlist_item_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Id',
  `wishlist_item_id` int(10) unsigned NOT NULL COMMENT 'Wishlist Item Id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `value` text COMMENT 'Value',
  PRIMARY KEY (`option_id`),
  KEY `FK_A014B30B04B72DD0EAB3EECD779728D6` (`wishlist_item_id`),
  CONSTRAINT `FK_A014B30B04B72DD0EAB3EECD779728D6` FOREIGN KEY (`wishlist_item_id`) REFERENCES `wishlist_item` (`wishlist_item_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Wishlist Item Option Table';


DROP TABLE IF EXISTS `inventory_stock_1`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY INVOKER VIEW `inventory_stock_1` AS select distinct `legacy_stock_status`.`product_id` AS `product_id`,`legacy_stock_status`.`website_id` AS `website_id`,`legacy_stock_status`.`stock_id` AS `stock_id`,`legacy_stock_status`.`qty` AS `quantity`,`legacy_stock_status`.`stock_status` AS `is_salable`,`product`.`sku` AS `sku` from (`cataloginventory_stock_status` `legacy_stock_status` join `catalog_product_entity` `product` on((`legacy_stock_status`.`product_id` = `product`.`entity_id`)));

-- 2019-02-19 13:53:01
