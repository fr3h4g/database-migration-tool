-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 10.118.20.48
-- Generation Time: Aug 02, 2022 at 09:38 PM
-- Server version: 8.0.29
-- PHP Version: 8.0.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `svenska_spel_sub_sys`
--

-- --------------------------------------------------------

--
-- Table structure for table `account_transfers`
--

CREATE TABLE `account_transfers` (
  `row_id` int NOT NULL,
  `customer_number` int NOT NULL,
  `amount` decimal(10,0) NOT NULL,
  `transfer_type` varchar(10) NOT NULL,
  `status` int NOT NULL,
  `filename` int NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `bank_clearing_number` varchar(4) NOT NULL,
  `bank_account_number` varchar(20) NOT NULL,
  `data` json NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `autogiro_admissions`
--

CREATE TABLE `autogiro_admissions` (
  `id` int NOT NULL,
  `payer_number` varchar(50) NOT NULL,
  `personal_id_number` varchar(20) NOT NULL,
  `bg_number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '2040442',
  `clearing_number` varchar(4) NOT NULL,
  `account_number` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'added',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `datewritten` date NOT NULL,
  `processed` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `autogiro_admissions_log`
--

CREATE TABLE `autogiro_admissions_log` (
  `id` int NOT NULL,
  `personal_id_number` varchar(20) NOT NULL,
  `payer_number` varchar(50) DEFAULT NULL,
  `clearing_number` varchar(4) NOT NULL,
  `account_number` varchar(16) DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'added',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `actiondate` date DEFAULT NULL,
  `validitydate` date NOT NULL,
  `last_updated` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `information_code` varchar(5) DEFAULT NULL,
  `information_text` varchar(255) DEFAULT NULL,
  `comment_code` varchar(5) DEFAULT NULL,
  `comment_text` varchar(255) DEFAULT NULL,
  `filedate` date NOT NULL,
  `filename` varchar(255) NOT NULL,
  `updated_by` varchar(255) NOT NULL,
  `bg_number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `autogiro_admissions_log_old`
--

CREATE TABLE `autogiro_admissions_log_old` (
  `id` int NOT NULL,
  `payer_number` varchar(50) NOT NULL,
  `status` varchar(20) NOT NULL,
  `text` text NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `autogiro_admissions_old`
--

CREATE TABLE `autogiro_admissions_old` (
  `id` int NOT NULL,
  `personal_id_number` varchar(20) NOT NULL,
  `payer_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `clearing_number` varchar(4) NOT NULL,
  `account_number` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'added',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_updated` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `information_code` varchar(5) DEFAULT NULL,
  `information_text` text,
  `comment_code` varchar(5) DEFAULT NULL,
  `comment_text` text,
  `filename` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `batches`
--

CREATE TABLE `batches` (
  `row_id` int NOT NULL,
  `batch_number` int DEFAULT NULL,
  `batch_part` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `external_batch_number` int DEFAULT NULL,
  `sequence` int DEFAULT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'created',
  `transport_mode` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `delivery_date` date DEFAULT NULL,
  `order_number` int NOT NULL,
  `order_position` int NOT NULL,
  `format` varchar(10) NOT NULL,
  `customer_number` int NOT NULL,
  `invoice_number` int DEFAULT NULL,
  `upgrade_invoice_1` int DEFAULT NULL,
  `upgrade_invoice_2` int DEFAULT NULL,
  `upgrade_invoice_3` int DEFAULT NULL,
  `product_number` varchar(20) NOT NULL,
  `base_layout` varchar(50) NOT NULL,
  `print_layout` varchar(50) NOT NULL,
  `lottery_1_quantity` int DEFAULT '0',
  `lottery_1_number` int DEFAULT NULL,
  `lottery_1_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `lottery_2_quantity` int DEFAULT '0',
  `lottery_2_number` int DEFAULT NULL,
  `lottery_2_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `lottery_3_quantity` int DEFAULT '0',
  `lottery_3_number` int DEFAULT NULL,
  `lottery_3_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `lottery_4_quantity` int DEFAULT '0',
  `lottery_4_number` int DEFAULT NULL,
  `lottery_4_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `enclosure_1_quantity` int DEFAULT NULL,
  `enclosure_1_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `enclosure_2_quantity` int DEFAULT NULL,
  `enclosure_2_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `enclosure_3_quantity` int DEFAULT NULL,
  `enclosure_3_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `enclosure_4_quantity` int DEFAULT NULL,
  `enclosure_4_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `enclosure_5_quantity` int DEFAULT NULL,
  `enclosure_5_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `enclosure_6_quantity` int DEFAULT NULL,
  `enclosure_6_product_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `batches_backup`
--

CREATE TABLE `batches_backup` (
  `row_id` int NOT NULL,
  `batch_number` int DEFAULT NULL,
  `batch_part` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `external_batch_number` varchar(10) DEFAULT NULL,
  `sequence` int DEFAULT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'created',
  `transport_mode` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `delivery_date` date DEFAULT NULL,
  `order_number` varchar(20) NOT NULL,
  `order_position` int NOT NULL,
  `format` varchar(10) NOT NULL,
  `customer_number` int NOT NULL,
  `invoice_number` int DEFAULT NULL,
  `upgrade_invoice_1` int DEFAULT NULL,
  `upgrade_invoice_2` int DEFAULT NULL,
  `upgrade_invoice_3` int DEFAULT NULL,
  `product_number` varchar(20) NOT NULL,
  `base_layout` varchar(50) NOT NULL,
  `print_layout` varchar(50) NOT NULL,
  `lottery_1_quantity` int DEFAULT '0',
  `lottery_1_number` int DEFAULT NULL,
  `lottery_1_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `lottery_2_quantity` int DEFAULT '0',
  `lottery_2_number` int DEFAULT NULL,
  `lottery_2_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `lottery_3_quantity` int DEFAULT '0',
  `lottery_3_number` int DEFAULT NULL,
  `lottery_3_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `lottery_4_quantity` int DEFAULT '0',
  `lottery_4_number` int DEFAULT NULL,
  `lottery_4_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `enclosure_1_quantity` int DEFAULT NULL,
  `enclosure_1_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `enclosure_2_quantity` int DEFAULT NULL,
  `enclosure_2_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `enclosure_3_quantity` int DEFAULT NULL,
  `enclosure_3_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `enclosure_4_quantity` int DEFAULT NULL,
  `enclosure_4_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `enclosure_5_quantity` int DEFAULT NULL,
  `enclosure_5_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `enclosure_6_quantity` int DEFAULT NULL,
  `enclosure_6_product_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `batches_fel_fix`
--

CREATE TABLE `batches_fel_fix` (
  `row_id` int NOT NULL,
  `batch_number` int DEFAULT NULL,
  `batch_part` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `external_batch_number` int DEFAULT NULL,
  `sequence` int DEFAULT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'created',
  `transport_mode` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `delivery_date` date DEFAULT NULL,
  `order_number` int NOT NULL,
  `order_position` int NOT NULL,
  `format` varchar(10) NOT NULL,
  `customer_number` int NOT NULL,
  `invoice_number` int DEFAULT NULL,
  `upgrade_invoice_1` int DEFAULT NULL,
  `upgrade_invoice_2` int DEFAULT NULL,
  `upgrade_invoice_3` int DEFAULT NULL,
  `product_number` varchar(20) NOT NULL,
  `base_layout` varchar(50) NOT NULL,
  `print_layout` varchar(50) NOT NULL,
  `lottery_1_quantity` int DEFAULT '0',
  `lottery_1_number` int DEFAULT NULL,
  `lottery_1_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `lottery_2_quantity` int DEFAULT '0',
  `lottery_2_number` int DEFAULT NULL,
  `lottery_2_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `lottery_3_quantity` int DEFAULT '0',
  `lottery_3_number` int DEFAULT NULL,
  `lottery_3_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `lottery_4_quantity` int DEFAULT '0',
  `lottery_4_number` int DEFAULT NULL,
  `lottery_4_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `enclosure_1_quantity` int DEFAULT NULL,
  `enclosure_1_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `enclosure_2_quantity` int DEFAULT NULL,
  `enclosure_2_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `enclosure_3_quantity` int DEFAULT NULL,
  `enclosure_3_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `enclosure_4_quantity` int DEFAULT NULL,
  `enclosure_4_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `enclosure_5_quantity` int DEFAULT NULL,
  `enclosure_5_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `enclosure_6_quantity` int DEFAULT NULL,
  `enclosure_6_product_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cs_letters`
--

CREATE TABLE `cs_letters` (
  `row_id` int NOT NULL,
  `customer_number` int NOT NULL,
  `order_prefix` varchar(5) DEFAULT NULL,
  `order_number` int DEFAULT NULL,
  `print_layout` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `base_layout` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `format` varchar(10) DEFAULT NULL,
  `invoice_type` varchar(20) DEFAULT NULL,
  `invoice_number` int DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'created',
  `type` varchar(50) NOT NULL DEFAULT 'triss',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cs_letters_backup_20210527`
--

CREATE TABLE `cs_letters_backup_20210527` (
  `row_id` int NOT NULL,
  `customer_number` int NOT NULL,
  `order_prefix` varchar(5) DEFAULT NULL,
  `order_number` int DEFAULT NULL,
  `print_layout` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `base_layout` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `format` varchar(10) DEFAULT NULL,
  `invoice_type` varchar(20) DEFAULT NULL,
  `invoice_number` int DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'created',
  `type` varchar(50) NOT NULL DEFAULT 'triss',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cs_letters_backup_prod`
--

CREATE TABLE `cs_letters_backup_prod` (
  `row_id` int NOT NULL,
  `customer_number` int NOT NULL,
  `order_prefix` varchar(5) DEFAULT NULL,
  `order_number` int DEFAULT NULL,
  `print_layout` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `base_layout` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `format` varchar(10) DEFAULT NULL,
  `invoice_type` varchar(20) DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'created',
  `type` varchar(50) NOT NULL DEFAULT 'triss'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cs_letters_old`
--

CREATE TABLE `cs_letters_old` (
  `row_id` int NOT NULL,
  `customer_number` int NOT NULL,
  `order_prefix` varchar(5) DEFAULT NULL,
  `order_number` int DEFAULT NULL,
  `print_layout` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `base_layout` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `format` varchar(10) DEFAULT NULL,
  `invoice_type` varchar(20) DEFAULT NULL,
  `invoice_number` int DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'created',
  `type` varchar(50) NOT NULL DEFAULT 'triss',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_number` int NOT NULL,
  `personal_id_number` varchar(20) NOT NULL,
  `first_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `last_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `address_1` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `address_2` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '',
  `postal_code` varchar(10) DEFAULT NULL,
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `country` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'SE',
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'active',
  `paused` tinyint(1) NOT NULL DEFAULT '0',
  `blocked` tinyint(1) NOT NULL DEFAULT '0',
  `print_type` varchar(50) NOT NULL DEFAULT 'Normal',
  `invoice_type` varchar(20) NOT NULL DEFAULT 'invoice',
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `bank_clearing_number` varchar(4) NOT NULL DEFAULT '',
  `bank_account_number` varchar(20) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customer_accounts`
--

CREATE TABLE `customer_accounts` (
  `id` int NOT NULL,
  `customer_number` int NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `error_amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `description` tinytext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `invoice_number_paid` bigint DEFAULT NULL,
  `ocr_number` varchar(50) DEFAULT NULL,
  `error` tinytext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `payers_name` varchar(35) DEFAULT NULL,
  `extra_name` varchar(35) DEFAULT NULL,
  `payers_address` varchar(35) DEFAULT NULL,
  `payers_postcode` varchar(9) DEFAULT NULL,
  `payers_city` varchar(35) DEFAULT NULL,
  `payers_country` varchar(35) DEFAULT NULL,
  `payers_countrycode` varchar(2) DEFAULT NULL,
  `reference_code` varchar(1) DEFAULT NULL,
  `payment_channel_code` varchar(1) DEFAULT NULL,
  `bgc_serial_number` varchar(12) DEFAULT NULL,
  `image_marking` varchar(1) DEFAULT NULL,
  `filename` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `duplicate_payments`
--

CREATE TABLE `duplicate_payments` (
  `id` int NOT NULL,
  `customer_number` int NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `amount` decimal(10,2) NOT NULL,
  `description` tinytext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `invoice_number_paid` int DEFAULT NULL,
  `ocr_number` varchar(50) DEFAULT NULL,
  `error` tinytext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `payers_name` varchar(35) DEFAULT NULL,
  `extra_name` varchar(35) DEFAULT NULL,
  `payers_address` varchar(35) DEFAULT NULL,
  `payers_postcode` varchar(9) DEFAULT NULL,
  `payers_city` varchar(35) DEFAULT NULL,
  `payers_country` varchar(35) DEFAULT NULL,
  `payers_countrycode` varchar(2) DEFAULT NULL,
  `reference_code` varchar(1) DEFAULT NULL,
  `payment_channel_code` varchar(1) DEFAULT NULL,
  `bgc_serial_number` varchar(12) DEFAULT NULL,
  `image_marking` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `id` int NOT NULL,
  `transaction_id` varchar(50) NOT NULL,
  `event` varchar(100) NOT NULL,
  `data` json NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `started` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `inventory_events`
--

CREATE TABLE `inventory_events` (
  `id` int NOT NULL,
  `event` varchar(20) NOT NULL,
  `category` varchar(10) DEFAULT NULL,
  `product_number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `product_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `cost` decimal(16,2) NOT NULL DEFAULT '0.00',
  `sale_price` decimal(16,2) NOT NULL DEFAULT '0.00',
  `bussiness_area` varchar(20) DEFAULT NULL,
  `Provision` decimal(10,2) NOT NULL DEFAULT '0.00',
  `comment` text,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

CREATE TABLE `invoices` (
  `invoice_id` int NOT NULL,
  `invoice_number` int NOT NULL,
  `date` date NOT NULL,
  `order_prefix` varchar(5) NOT NULL DEFAULT 'OSU',
  `order_number` int NOT NULL,
  `order_position` int NOT NULL,
  `order_subposition` int NOT NULL DEFAULT '0',
  `customer_number` int NOT NULL,
  `product_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `due_date` date DEFAULT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'created',
  `amount` decimal(10,2) NOT NULL,
  `paid_amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `payment_date` date DEFAULT NULL,
  `payment_type` varchar(20) NOT NULL,
  `ocr_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'normal',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `sent_to_bgc` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `letter_types`
--

CREATE TABLE `letter_types` (
  `Name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Description` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lotto_customers`
--

CREATE TABLE `lotto_customers` (
  `customer_number` int NOT NULL,
  `personal_id_number` varchar(20) NOT NULL,
  `first_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `last_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `address_1` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `address_2` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '',
  `postal_code` varchar(20) DEFAULT NULL,
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `country` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'Sweden',
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'Active',
  `playeraccountstatus` varchar(20) DEFAULT NULL,
  `communicationselectiondone` varchar(10) DEFAULT NULL,
  `advertiseVia` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `communicationSettingsLink` tinytext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `email` tinytext NOT NULL,
  `mobile` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `changed` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lotto_packages`
--

CREATE TABLE `lotto_packages` (
  `package_number` int NOT NULL,
  `package_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lotto_payments`
--

CREATE TABLE `lotto_payments` (
  `row_id` int NOT NULL,
  `customer_number` varchar(20) NOT NULL,
  `subscription_number` varchar(20) DEFAULT NULL,
  `package` varchar(20) DEFAULT NULL,
  `success` varchar(10) DEFAULT NULL,
  `amount` decimal(10,0) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `disabled` varchar(10) DEFAULT NULL,
  `interval_from` date DEFAULT NULL,
  `interval_to` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lotto_subscriptions`
--

CREATE TABLE `lotto_subscriptions` (
  `customer_number` int NOT NULL,
  `subscription_number` varchar(50) NOT NULL,
  `created` timestamp NOT NULL,
  `last_changed` timestamp NOT NULL,
  `package_number` varchar(10) NOT NULL,
  `package_name` varchar(50) DEFAULT NULL,
  `channel` varchar(25) NOT NULL,
  `offer_code` varchar(25) NOT NULL,
  `campaign_code` varchar(25) NOT NULL,
  `status` varchar(50) NOT NULL,
  `missed_payments` int NOT NULL DEFAULT '0',
  `amount` int NOT NULL,
  `invoices` int NOT NULL,
  `disabled_from` date DEFAULT NULL,
  `expiration_date` date DEFAULT NULL,
  `bets` json NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lotto_subscription_events`
--

CREATE TABLE `lotto_subscription_events` (
  `id` int NOT NULL,
  `number` varchar(10) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `custno` int DEFAULT NULL,
  `package` int DEFAULT NULL,
  `data` json DEFAULT NULL,
  `processed` int NOT NULL DEFAULT '0',
  `timestamp_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `monitor`
--

CREATE TABLE `monitor` (
  `row_id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `series` varchar(50) NOT NULL,
  `state` varchar(20) NOT NULL,
  `json` json NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `monthly_setups`
--

CREATE TABLE `monthly_setups` (
  `id` int NOT NULL,
  `period_from` date NOT NULL,
  `period_to` date NOT NULL,
  `format` varchar(10) NOT NULL,
  `payment_type` varchar(20) DEFAULT NULL,
  `print_layout` varchar(20) NOT NULL,
  `base_layout` varchar(20) NOT NULL,
  `delivery_date` date DEFAULT NULL,
  `triss_lottery_number` int DEFAULT NULL,
  `extra_lottery_number` int DEFAULT NULL,
  `campaign_lottery_number` int DEFAULT NULL,
  `campaign_name` varchar(50) DEFAULT NULL,
  `campaign_package_prefix_1` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `campaign_package_prefix_2` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `campaign_package_prefix_3` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `enclosure_1` varchar(20) DEFAULT NULL,
  `enclosure_2` varchar(20) DEFAULT NULL,
  `enclosure_3` varchar(20) DEFAULT NULL,
  `enclosure_4` varchar(20) DEFAULT NULL,
  `enclosure_5` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notes`
--

CREATE TABLE `notes` (
  `id` int NOT NULL,
  `customer_number` int NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `text` text NOT NULL,
  `user` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `number_invoice`
--

CREATE TABLE `number_invoice` (
  `number` int NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `online_orders`
--

CREATE TABLE `online_orders` (
  `customer_number` int NOT NULL,
  `batch_number` int NOT NULL,
  `product_id` int NOT NULL,
  `amount` int NOT NULL,
  `delivery_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `row_id` int NOT NULL,
  `order_prefix` varchar(10) NOT NULL DEFAULT 'OSU',
  `order_number` int NOT NULL,
  `customer_number` int NOT NULL,
  `invoice_number` int DEFAULT NULL,
  `position` int NOT NULL,
  `sub_position` int NOT NULL DEFAULT '0',
  `campaign_code` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `offer_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `ship_date` date DEFAULT NULL,
  `expected_delivery_date` date DEFAULT NULL,
  `scratch_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'created',
  `date_delivered` date DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_types`
--

CREATE TABLE `order_types` (
  `order_prefix` varchar(10) NOT NULL,
  `order_type` varchar(50) NOT NULL,
  `recurring` tinyint NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `packages`
--

CREATE TABLE `packages` (
  `row_id` int NOT NULL,
  `package_number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `package_name` varchar(100) NOT NULL,
  `total_price` int NOT NULL,
  `subscription_interval` int NOT NULL,
  `lottery_1_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `lottery_1_amount` int DEFAULT NULL,
  `lottery_1_price` int DEFAULT NULL,
  `lottery_2_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `lottery_2_amount` int DEFAULT NULL,
  `lottery_2_price` int DEFAULT NULL,
  `lottery_3_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `lottery_3_amount` int DEFAULT NULL,
  `lottery_3_price` int DEFAULT NULL,
  `lottery_4_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `lottery_4_amount` int DEFAULT NULL,
  `lottery_4_price` int DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `changed` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `visible` tinyint NOT NULL DEFAULT '0',
  `package_code` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `printfile_subscriptions`
--

CREATE TABLE `printfile_subscriptions` (
  `row_id` int NOT NULL,
  `order_prefix` varchar(5) DEFAULT NULL,
  `order_number` int NOT NULL,
  `product_number` varchar(50) NOT NULL,
  `product_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ship_date` date NOT NULL,
  `customer_number` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `process_batch_files`
--

CREATE TABLE `process_batch_files` (
  `id` int NOT NULL,
  `base_layout` varchar(50) NOT NULL,
  `format` varchar(10) NOT NULL,
  `transport_mode` varchar(10) NOT NULL,
  `delivery_date` date NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'added',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `process_campaign_upgrades`
--

CREATE TABLE `process_campaign_upgrades` (
  `id` int NOT NULL,
  `order_number` varchar(20) NOT NULL,
  `customer_number` int NOT NULL,
  `choice` int NOT NULL,
  `period` varchar(6) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(20) NOT NULL DEFAULT 'added'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `process_invoice_payments`
--

CREATE TABLE `process_invoice_payments` (
  `row_id` int NOT NULL,
  `timestamp_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `data` json DEFAULT NULL,
  `processed` int NOT NULL DEFAULT '0',
  `checksum` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `timestamp_processed` timestamp NULL DEFAULT NULL,
  `error_message` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `process_invoice_payments_old`
--

CREATE TABLE `process_invoice_payments_old` (
  `row_id` int NOT NULL,
  `timestamp_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `data` json DEFAULT NULL,
  `processed` int NOT NULL DEFAULT '0',
  `checksum` varchar(20) NOT NULL,
  `timestamp_processed` timestamp NULL DEFAULT NULL,
  `error_message` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int NOT NULL,
  `product_id` int NOT NULL,
  `name` varchar(50) NOT NULL,
  `price` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `python_exceptions`
--

CREATE TABLE `python_exceptions` (
  `id` int NOT NULL,
  `service_id` int DEFAULT NULL,
  `service_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `group_hash` varchar(50) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `data` json NOT NULL,
  `resolved` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `python_exceptions_mail`
--

CREATE TABLE `python_exceptions_mail` (
  `id` int NOT NULL,
  `group_hash` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `scheduler`
--

CREATE TABLE `scheduler` (
  `id` int NOT NULL,
  `data` json NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `scheduler_backup`
--

CREATE TABLE `scheduler_backup` (
  `id` int NOT NULL,
  `data` json NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subscriptions`
--

CREATE TABLE `subscriptions` (
  `order_number` int NOT NULL,
  `order_prefix` varchar(10) NOT NULL DEFAULT 'OSU',
  `customer_number` int NOT NULL,
  `package_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `invoice_type` varchar(20) NOT NULL DEFAULT 'invoice',
  `old_package_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `agent_type` varchar(20) DEFAULT NULL,
  `agent_number` varchar(20) DEFAULT NULL,
  `offer_code` varchar(20) DEFAULT NULL,
  `campaign_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'active',
  `upgraded` int NOT NULL DEFAULT '0',
  `old_delivered_packages` int NOT NULL DEFAULT '0',
  `old_invoices_count` int NOT NULL DEFAULT '0',
  `old_invoices_amount` int NOT NULL DEFAULT '0',
  `latest_payment_date` date DEFAULT NULL,
  `changed` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `termination_letter_sent` int NOT NULL DEFAULT '0',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `timestamp_deleted` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subscriptions_20210716`
--

CREATE TABLE `subscriptions_20210716` (
  `order_number` int NOT NULL,
  `order_prefix` varchar(10) NOT NULL DEFAULT 'OSU',
  `customer_number` int NOT NULL,
  `package_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `invoice_type` varchar(20) NOT NULL DEFAULT 'invoice',
  `old_package_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `agent_type` varchar(20) DEFAULT NULL,
  `agent_number` varchar(20) DEFAULT NULL,
  `offer_code` varchar(20) DEFAULT NULL,
  `campaign_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'active',
  `upgraded` int NOT NULL DEFAULT '0',
  `old_delivered_packages` int NOT NULL DEFAULT '0',
  `old_invoices_count` int NOT NULL DEFAULT '0',
  `old_invoices_amount` int NOT NULL DEFAULT '0',
  `latest_payment_date` date DEFAULT NULL,
  `changed` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `termination_letter_sent` int NOT NULL DEFAULT '0',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `timestamp_deleted` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subscriptions_fel`
--

CREATE TABLE `subscriptions_fel` (
  `order_number` int NOT NULL,
  `order_prefix` varchar(10) NOT NULL DEFAULT 'OSU',
  `customer_number` int NOT NULL,
  `package_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `invoice_type` varchar(20) NOT NULL DEFAULT 'invoice',
  `old_package_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `agent_type` varchar(20) DEFAULT NULL,
  `agent_number` varchar(20) DEFAULT NULL,
  `offer_code` varchar(20) DEFAULT NULL,
  `campaign_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'active',
  `upgraded` int NOT NULL DEFAULT '0',
  `old_delivered_packages` int NOT NULL DEFAULT '0',
  `old_invoices_count` int NOT NULL DEFAULT '0',
  `old_invoices_amount` int NOT NULL DEFAULT '0',
  `latest_payment_date` date DEFAULT NULL,
  `changed` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `termination_letter_sent` int NOT NULL DEFAULT '0',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `timestamp_deleted` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `account_transfers`
--
ALTER TABLE `account_transfers`
  ADD PRIMARY KEY (`row_id`);

--
-- Indexes for table `autogiro_admissions`
--
ALTER TABLE `autogiro_admissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Unik` (`personal_id_number`,`bg_number`);

--
-- Indexes for table `autogiro_admissions_log`
--
ALTER TABLE `autogiro_admissions_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `autogiro_admissions_log_old`
--
ALTER TABLE `autogiro_admissions_log_old`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `autogiro_admissions_old`
--
ALTER TABLE `autogiro_admissions_old`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `batches`
--
ALTER TABLE `batches`
  ADD PRIMARY KEY (`row_id`),
  ADD UNIQUE KEY `unik` (`order_number`,`order_position`),
  ADD KEY `invoice_number` (`invoice_number`),
  ADD KEY `batch_number` (`batch_number`),
  ADD KEY `order_number` (`order_number`),
  ADD KEY `order_position` (`order_position`),
  ADD KEY `base_layout` (`base_layout`),
  ADD KEY `print_layout` (`print_layout`),
  ADD KEY `customer_number` (`customer_number`),
  ADD KEY `format` (`format`),
  ADD KEY `status` (`status`),
  ADD KEY `transport_mode` (`transport_mode`),
  ADD KEY `delivery_date` (`delivery_date`),
  ADD KEY `product_number` (`product_number`);

--
-- Indexes for table `batches_backup`
--
ALTER TABLE `batches_backup`
  ADD PRIMARY KEY (`row_id`),
  ADD UNIQUE KEY `unik` (`order_number`,`order_position`),
  ADD KEY `invoice_number` (`invoice_number`),
  ADD KEY `batch_number` (`batch_number`),
  ADD KEY `order_number` (`order_number`),
  ADD KEY `order_position` (`order_position`),
  ADD KEY `base_layout` (`base_layout`),
  ADD KEY `print_layout` (`print_layout`),
  ADD KEY `customer_number` (`customer_number`),
  ADD KEY `format` (`format`),
  ADD KEY `status` (`status`),
  ADD KEY `transport_mode` (`transport_mode`),
  ADD KEY `delivery_date` (`delivery_date`);

--
-- Indexes for table `batches_fel_fix`
--
ALTER TABLE `batches_fel_fix`
  ADD PRIMARY KEY (`row_id`),
  ADD UNIQUE KEY `unik` (`order_number`,`order_position`),
  ADD KEY `invoice_number` (`invoice_number`),
  ADD KEY `batch_number` (`batch_number`),
  ADD KEY `order_number` (`order_number`),
  ADD KEY `order_position` (`order_position`),
  ADD KEY `base_layout` (`base_layout`),
  ADD KEY `print_layout` (`print_layout`),
  ADD KEY `customer_number` (`customer_number`),
  ADD KEY `format` (`format`),
  ADD KEY `status` (`status`),
  ADD KEY `transport_mode` (`transport_mode`),
  ADD KEY `delivery_date` (`delivery_date`);

--
-- Indexes for table `cs_letters`
--
ALTER TABLE `cs_letters`
  ADD PRIMARY KEY (`row_id`);

--
-- Indexes for table `cs_letters_backup_20210527`
--
ALTER TABLE `cs_letters_backup_20210527`
  ADD PRIMARY KEY (`row_id`);

--
-- Indexes for table `cs_letters_backup_prod`
--
ALTER TABLE `cs_letters_backup_prod`
  ADD PRIMARY KEY (`row_id`);

--
-- Indexes for table `cs_letters_old`
--
ALTER TABLE `cs_letters_old`
  ADD PRIMARY KEY (`row_id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_number`);

--
-- Indexes for table `customer_accounts`
--
ALTER TABLE `customer_accounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unik` (`customer_number`,`ocr_number`,`bgc_serial_number`,`filename`),
  ADD KEY `bgc_serial_number` (`bgc_serial_number`),
  ADD KEY `customer_number` (`customer_number`),
  ADD KEY `amount` (`amount`);

--
-- Indexes for table `duplicate_payments`
--
ALTER TABLE `duplicate_payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `event` (`event`),
  ADD KEY `transaction_id` (`transaction_id`),
  ADD KEY `timestamp` (`timestamp`);

--
-- Indexes for table `inventory_events`
--
ALTER TABLE `inventory_events`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`invoice_id`),
  ADD UNIQUE KEY `invoice_number` (`invoice_number`) USING BTREE,
  ADD UNIQUE KEY `order_number_2` (`order_number`,`order_position`,`order_subposition`) USING BTREE,
  ADD KEY `order_position` (`order_position`),
  ADD KEY `order_number` (`order_number`),
  ADD KEY `ocr_number` (`ocr_number`),
  ADD KEY `product_number` (`product_number`),
  ADD KEY `due_date` (`due_date`),
  ADD KEY `customer_number` (`customer_number`),
  ADD KEY `payment_type` (`payment_type`),
  ADD KEY `payment_date` (`payment_date`),
  ADD KEY `order_prefix` (`order_prefix`);

--
-- Indexes for table `letter_types`
--
ALTER TABLE `letter_types`
  ADD PRIMARY KEY (`Name`);

--
-- Indexes for table `lotto_customers`
--
ALTER TABLE `lotto_customers`
  ADD PRIMARY KEY (`customer_number`),
  ADD UNIQUE KEY `unik` (`customer_number`),
  ADD KEY `status` (`status`);

--
-- Indexes for table `lotto_packages`
--
ALTER TABLE `lotto_packages`
  ADD PRIMARY KEY (`package_number`);

--
-- Indexes for table `lotto_payments`
--
ALTER TABLE `lotto_payments`
  ADD PRIMARY KEY (`row_id`),
  ADD KEY `customer_number` (`customer_number`),
  ADD KEY `subscription_number` (`subscription_number`);

--
-- Indexes for table `lotto_subscriptions`
--
ALTER TABLE `lotto_subscriptions`
  ADD UNIQUE KEY `unik` (`customer_number`,`subscription_number`),
  ADD KEY `subscription_number` (`subscription_number`),
  ADD KEY `last_changed` (`last_changed`),
  ADD KEY `status` (`status`),
  ADD KEY `package_number` (`package_number`),
  ADD KEY `customer_number` (`customer_number`);

--
-- Indexes for table `lotto_subscription_events`
--
ALTER TABLE `lotto_subscription_events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `processed` (`processed`);

--
-- Indexes for table `monitor`
--
ALTER TABLE `monitor`
  ADD PRIMARY KEY (`row_id`);

--
-- Indexes for table `monthly_setups`
--
ALTER TABLE `monthly_setups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `format` (`format`),
  ADD KEY `payment_type` (`payment_type`),
  ADD KEY `period_from` (`period_from`),
  ADD KEY `period_to` (`period_to`);

--
-- Indexes for table `notes`
--
ALTER TABLE `notes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `number_invoice`
--
ALTER TABLE `number_invoice`
  ADD PRIMARY KEY (`number`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`row_id`),
  ADD UNIQUE KEY `order_number_2` (`order_number`,`position`),
  ADD KEY `position` (`position`),
  ADD KEY `order_number` (`order_number`),
  ADD KEY `customer_number` (`customer_number`),
  ADD KEY `invoice_number` (`invoice_number`),
  ADD KEY `date_delivered` (`date_delivered`),
  ADD KEY `order_prefix` (`order_prefix`);

--
-- Indexes for table `order_types`
--
ALTER TABLE `order_types`
  ADD PRIMARY KEY (`order_prefix`);

--
-- Indexes for table `packages`
--
ALTER TABLE `packages`
  ADD PRIMARY KEY (`row_id`),
  ADD UNIQUE KEY `package_number` (`package_number`);

--
-- Indexes for table `printfile_subscriptions`
--
ALTER TABLE `printfile_subscriptions`
  ADD PRIMARY KEY (`row_id`),
  ADD UNIQUE KEY `unik` (`order_number`,`customer_number`,`order_prefix`) USING BTREE,
  ADD KEY `ship_date` (`ship_date`);

--
-- Indexes for table `process_batch_files`
--
ALTER TABLE `process_batch_files`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `process_campaign_upgrades`
--
ALTER TABLE `process_campaign_upgrades`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `process_invoice_payments`
--
ALTER TABLE `process_invoice_payments`
  ADD PRIMARY KEY (`row_id`),
  ADD UNIQUE KEY `checksum` (`checksum`);

--
-- Indexes for table `process_invoice_payments_old`
--
ALTER TABLE `process_invoice_payments_old`
  ADD PRIMARY KEY (`row_id`),
  ADD UNIQUE KEY `checksum` (`checksum`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `product_id` (`product_id`);

--
-- Indexes for table `python_exceptions`
--
ALTER TABLE `python_exceptions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `group_hash` (`group_hash`),
  ADD KEY `resolved` (`resolved`);

--
-- Indexes for table `python_exceptions_mail`
--
ALTER TABLE `python_exceptions_mail`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `scheduler`
--
ALTER TABLE `scheduler`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `scheduler_backup`
--
ALTER TABLE `scheduler_backup`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD PRIMARY KEY (`order_number`),
  ADD KEY `package_number` (`package_number`),
  ADD KEY `customer_number` (`customer_number`),
  ADD KEY `status` (`status`),
  ADD KEY `invoice_type` (`invoice_type`),
  ADD KEY `order_prefix` (`order_prefix`);

--
-- Indexes for table `subscriptions_20210716`
--
ALTER TABLE `subscriptions_20210716`
  ADD PRIMARY KEY (`order_number`),
  ADD KEY `package_number` (`package_number`),
  ADD KEY `customer_number` (`customer_number`),
  ADD KEY `status` (`status`),
  ADD KEY `invoice_type` (`invoice_type`);

--
-- Indexes for table `subscriptions_fel`
--
ALTER TABLE `subscriptions_fel`
  ADD PRIMARY KEY (`order_number`),
  ADD KEY `package_number` (`package_number`),
  ADD KEY `customer_number` (`customer_number`),
  ADD KEY `status` (`status`),
  ADD KEY `invoice_type` (`invoice_type`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `account_transfers`
--
ALTER TABLE `account_transfers`
  MODIFY `row_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `autogiro_admissions`
--
ALTER TABLE `autogiro_admissions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `autogiro_admissions_log`
--
ALTER TABLE `autogiro_admissions_log`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `autogiro_admissions_log_old`
--
ALTER TABLE `autogiro_admissions_log_old`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `autogiro_admissions_old`
--
ALTER TABLE `autogiro_admissions_old`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `batches`
--
ALTER TABLE `batches`
  MODIFY `row_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `batches_backup`
--
ALTER TABLE `batches_backup`
  MODIFY `row_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `batches_fel_fix`
--
ALTER TABLE `batches_fel_fix`
  MODIFY `row_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cs_letters`
--
ALTER TABLE `cs_letters`
  MODIFY `row_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cs_letters_backup_20210527`
--
ALTER TABLE `cs_letters_backup_20210527`
  MODIFY `row_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cs_letters_backup_prod`
--
ALTER TABLE `cs_letters_backup_prod`
  MODIFY `row_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cs_letters_old`
--
ALTER TABLE `cs_letters_old`
  MODIFY `row_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_number` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customer_accounts`
--
ALTER TABLE `customer_accounts`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `duplicate_payments`
--
ALTER TABLE `duplicate_payments`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inventory_events`
--
ALTER TABLE `inventory_events`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `invoices`
--
ALTER TABLE `invoices`
  MODIFY `invoice_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lotto_customers`
--
ALTER TABLE `lotto_customers`
  MODIFY `customer_number` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lotto_payments`
--
ALTER TABLE `lotto_payments`
  MODIFY `row_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lotto_subscription_events`
--
ALTER TABLE `lotto_subscription_events`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `monitor`
--
ALTER TABLE `monitor`
  MODIFY `row_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `monthly_setups`
--
ALTER TABLE `monthly_setups`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notes`
--
ALTER TABLE `notes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `number_invoice`
--
ALTER TABLE `number_invoice`
  MODIFY `number` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `row_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `packages`
--
ALTER TABLE `packages`
  MODIFY `row_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `printfile_subscriptions`
--
ALTER TABLE `printfile_subscriptions`
  MODIFY `row_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `process_batch_files`
--
ALTER TABLE `process_batch_files`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `process_campaign_upgrades`
--
ALTER TABLE `process_campaign_upgrades`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `process_invoice_payments`
--
ALTER TABLE `process_invoice_payments`
  MODIFY `row_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `process_invoice_payments_old`
--
ALTER TABLE `process_invoice_payments_old`
  MODIFY `row_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `python_exceptions`
--
ALTER TABLE `python_exceptions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `python_exceptions_mail`
--
ALTER TABLE `python_exceptions_mail`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `scheduler`
--
ALTER TABLE `scheduler`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `scheduler_backup`
--
ALTER TABLE `scheduler_backup`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subscriptions`
--
ALTER TABLE `subscriptions`
  MODIFY `order_number` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subscriptions_20210716`
--
ALTER TABLE `subscriptions_20210716`
  MODIFY `order_number` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subscriptions_fel`
--
ALTER TABLE `subscriptions_fel`
  MODIFY `order_number` int NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
