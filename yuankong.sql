-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- 主机: localhost
-- 生成日期: 2015 年 06 月 18 日 09:36
-- 服务器版本: 5.5.24-log
-- PHP 版本: 5.4.3

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 数据库: `yuankong`
--

-- --------------------------------------------------------

--
-- 表的结构 `yk_address`
--

CREATE TABLE IF NOT EXISTS `yk_address` (
  `address_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `firstname` varchar(32) NOT NULL,
  `lastname` varchar(32) NOT NULL,
  `company` varchar(32) NOT NULL,
  `company_id` varchar(32) NOT NULL,
  `tax_id` varchar(32) NOT NULL,
  `address_1` varchar(128) NOT NULL,
  `address_2` varchar(128) NOT NULL,
  `city` varchar(128) NOT NULL,
  `postcode` varchar(10) NOT NULL,
  `country_id` int(11) NOT NULL DEFAULT '0',
  `zone_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`address_id`),
  KEY `customer_id` (`customer_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `yk_affiliate`
--

CREATE TABLE IF NOT EXISTS `yk_affiliate` (
  `affiliate_id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` smallint(6) NOT NULL DEFAULT '0',
  `firstname` varchar(32) NOT NULL,
  `lastname` varchar(32) NOT NULL,
  `email` varchar(96) NOT NULL,
  `telephone` varchar(32) NOT NULL,
  `fax` varchar(32) NOT NULL,
  `password` varchar(40) NOT NULL,
  `salt` varchar(9) NOT NULL,
  `company` varchar(32) NOT NULL,
  `website` varchar(255) NOT NULL,
  `address_1` varchar(128) NOT NULL,
  `address_2` varchar(128) NOT NULL,
  `city` varchar(128) NOT NULL,
  `postcode` varchar(10) NOT NULL,
  `country_id` int(11) NOT NULL,
  `zone_id` int(11) NOT NULL,
  `code` varchar(64) NOT NULL,
  `commission` decimal(4,2) NOT NULL DEFAULT '0.00',
  `tax` varchar(64) NOT NULL,
  `payment` varchar(6) NOT NULL,
  `cheque` varchar(100) NOT NULL,
  `paypal` varchar(64) NOT NULL,
  `bank_name` varchar(64) NOT NULL,
  `bank_branch_number` varchar(64) NOT NULL,
  `bank_swift_code` varchar(64) NOT NULL,
  `bank_account_name` varchar(64) NOT NULL,
  `bank_account_number` varchar(64) NOT NULL,
  `ip` varchar(40) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `approved` tinyint(1) NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`affiliate_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `yk_affiliate_group`
--

CREATE TABLE IF NOT EXISTS `yk_affiliate_group` (
  `group_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `show` tinyint(4) NOT NULL DEFAULT '0',
  `sort_order` int(3) NOT NULL,
  PRIMARY KEY (`group_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `yk_affiliate_group`
--

INSERT INTO `yk_affiliate_group` (`group_id`, `name`, `show`, `sort_order`) VALUES
(1, '设计公司', 0, 1),
(2, '检测公司', 0, 1),
(3, '维保公司', 0, 1),
(4, '工程公司', 0, 1);

-- --------------------------------------------------------

--
-- 表的结构 `yk_affiliate_transaction`
--

CREATE TABLE IF NOT EXISTS `yk_affiliate_transaction` (
  `affiliate_transaction_id` int(11) NOT NULL AUTO_INCREMENT,
  `affiliate_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `description` text NOT NULL,
  `amount` decimal(15,4) NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`affiliate_transaction_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `yk_attribute`
--

CREATE TABLE IF NOT EXISTS `yk_attribute` (
  `attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `attribute_group_id` int(11) NOT NULL,
  `sort_order` int(3) NOT NULL,
  PRIMARY KEY (`attribute_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

--
-- 转存表中的数据 `yk_attribute`
--

INSERT INTO `yk_attribute` (`attribute_id`, `attribute_group_id`, `sort_order`) VALUES
(1, 6, 1),
(2, 6, 5),
(3, 6, 3),
(4, 3, 1),
(5, 3, 2),
(6, 3, 3),
(7, 3, 4),
(8, 3, 5),
(9, 3, 6),
(10, 3, 7),
(11, 3, 8);

-- --------------------------------------------------------

--
-- 表的结构 `yk_attribute_description`
--

CREATE TABLE IF NOT EXISTS `yk_attribute_description` (
  `attribute_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`attribute_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `yk_attribute_description`
--

INSERT INTO `yk_attribute_description` (`attribute_id`, `language_id`, `name`) VALUES
(1, 2, 'Description'),
(2, 2, 'No. of Cores'),
(4, 2, 'test 1'),
(5, 2, 'test 2'),
(6, 2, 'test 3'),
(7, 2, 'test 4'),
(8, 2, 'test 5'),
(9, 2, 'test 6'),
(10, 2, 'test 7'),
(11, 2, 'test 8'),
(3, 2, 'Clockspeed');

-- --------------------------------------------------------

--
-- 表的结构 `yk_attribute_group_description`
--

CREATE TABLE IF NOT EXISTS `yk_attribute_group_description` (
  `attribute_group_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`attribute_group_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `yk_attribute_group_description`
--

INSERT INTO `yk_attribute_group_description` (`attribute_group_id`, `language_id`, `name`) VALUES
(3, 2, 'Memory'),
(4, 2, 'Technical'),
(5, 2, 'Motherboard'),
(6, 2, 'Processor');

-- --------------------------------------------------------

--
-- 表的结构 `yk_banner`
--

CREATE TABLE IF NOT EXISTS `yk_banner` (
  `banner_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY (`banner_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

-- --------------------------------------------------------

--
-- 表的结构 `yk_banner_image`
--

CREATE TABLE IF NOT EXISTS `yk_banner_image` (
  `banner_image_id` int(11) NOT NULL AUTO_INCREMENT,
  `banner_id` int(11) NOT NULL,
  `link` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  PRIMARY KEY (`banner_image_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=78 ;

-- --------------------------------------------------------

--
-- 表的结构 `yk_banner_image_description`
--

CREATE TABLE IF NOT EXISTS `yk_banner_image_description` (
  `banner_image_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `banner_id` int(11) NOT NULL,
  `title` varchar(64) NOT NULL,
  PRIMARY KEY (`banner_image_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `yk_case`
--

CREATE TABLE IF NOT EXISTS `yk_case` (
  `case_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `desc` text,
  `cover` varchar(255) DEFAULT NULL,
  `sort_order` int(3) NOT NULL,
  PRIMARY KEY (`case_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `yk_case`
--

INSERT INTO `yk_case` (`case_id`, `name`, `desc`, `cover`, `sort_order`) VALUES
(1, '大润发', '', 'data/case/logopic6.jpg', 0),
(2, 'SubWay', '', 'data/case/logopic2.jpg', 0),
(3, '肯德基', '', 'data/case/logopic1.jpg', 0),
(4, '沃尔玛', '', 'data/case/logopic5.jpg', 0);

-- --------------------------------------------------------

--
-- 表的结构 `yk_case_image`
--

CREATE TABLE IF NOT EXISTS `yk_case_image` (
  `case_id` int(11) NOT NULL,
  `name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `path` varchar(512) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `yk_case_image`
--

INSERT INTO `yk_case_image` (`case_id`, `name`, `path`) VALUES
(4, 'shoppic4.jpg', '../asset/upload/20150615/20150615045851_af337968.jpg'),
(4, 'shoppic5.jpg', '../asset/upload/20150615/20150615045855_86408726.jpg');

-- --------------------------------------------------------

--
-- 表的结构 `yk_case_imgae`
--

CREATE TABLE IF NOT EXISTS `yk_case_imgae` (
  `case_id` int(11) NOT NULL,
  `name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `path` varchar(512) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `yk_category`
--

CREATE TABLE IF NOT EXISTS `yk_category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `image` varchar(255) DEFAULT NULL,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `top` tinyint(1) NOT NULL,
  `column` int(3) NOT NULL,
  `sort_order` int(3) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL,
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`category_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=139 ;

--
-- 转存表中的数据 `yk_category`
--

INSERT INTO `yk_category` (`category_id`, `image`, `parent_id`, `top`, `column`, `sort_order`, `status`, `date_added`, `date_modified`) VALUES
(78, '', 75, 0, 1, 0, 1, '2015-06-10 17:32:09', '2015-06-10 17:32:09'),
(77, '', 75, 0, 1, 0, 1, '2015-06-10 17:31:33', '2015-06-10 17:31:33'),
(75, '', 59, 0, 1, 0, 1, '2015-06-10 17:15:02', '2015-06-10 17:15:02'),
(61, '', 59, 0, 1, 0, 1, '2015-06-10 16:58:03', '2015-06-10 16:58:03'),
(62, '', 61, 0, 1, 0, 1, '2015-06-10 16:59:08', '2015-06-10 16:59:08'),
(60, '', 0, 0, 1, 0, 1, '2015-06-10 16:55:53', '2015-06-10 16:55:53'),
(76, '', 75, 0, 1, 0, 1, '2015-06-10 17:28:06', '2015-06-10 17:28:06'),
(81, '', 75, 0, 1, 0, 1, '2015-06-10 17:33:14', '2015-06-10 17:33:14'),
(80, '', 75, 0, 1, 0, 1, '2015-06-10 17:32:58', '2015-06-10 17:32:58'),
(79, '', 75, 0, 1, 0, 1, '2015-06-10 17:32:41', '2015-06-10 17:32:41'),
(63, '', 61, 0, 1, 0, 1, '2015-06-10 17:01:18', '2015-06-10 17:01:18'),
(64, '', 61, 0, 1, 0, 1, '2015-06-10 17:01:44', '2015-06-10 17:01:44'),
(74, '', 69, 0, 1, 0, 1, '2015-06-10 17:14:27', '2015-06-10 17:14:27'),
(73, '', 69, 0, 1, 0, 1, '2015-06-10 17:14:02', '2015-06-10 17:14:02'),
(72, '', 69, 0, 1, 0, 1, '2015-06-10 17:13:14', '2015-06-10 17:13:14'),
(71, '', 69, 0, 1, 0, 1, '2015-06-10 17:12:46', '2015-06-10 17:12:46'),
(70, '', 69, 0, 1, 0, 1, '2015-06-10 17:11:49', '2015-06-10 17:11:49'),
(69, '', 59, 0, 1, 0, 1, '2015-06-10 17:11:04', '2015-06-10 17:11:04'),
(68, '', 61, 0, 1, 0, 1, '2015-06-10 17:08:04', '2015-06-10 17:10:24'),
(67, '', 61, 0, 1, 0, 1, '2015-06-10 17:02:58', '2015-06-10 17:02:58'),
(66, '', 61, 0, 1, 0, 1, '2015-06-10 17:02:39', '2015-06-10 17:02:39'),
(65, '', 61, 0, 1, 0, 1, '2015-06-10 17:02:21', '2015-06-10 17:02:21'),
(59, '', 0, 0, 1, 0, 1, '2015-06-10 16:55:33', '2015-06-10 16:55:33'),
(82, '', 75, 0, 1, 0, 1, '2015-06-10 17:33:47', '2015-06-10 17:33:47'),
(83, '', 75, 0, 1, 0, 1, '2015-06-10 17:34:34', '2015-06-10 17:34:34'),
(84, '', 59, 0, 1, 0, 1, '2015-06-10 20:58:37', '2015-06-10 20:58:37'),
(85, '', 84, 0, 1, 0, 1, '2015-06-10 20:59:14', '2015-06-10 20:59:14'),
(86, '', 84, 0, 1, 0, 1, '2015-06-10 23:09:48', '2015-06-10 23:09:48'),
(87, '', 84, 0, 1, 0, 1, '2015-06-10 23:10:15', '2015-06-10 23:10:15'),
(88, '', 84, 0, 1, 0, 1, '2015-06-10 23:10:29', '2015-06-10 23:10:29'),
(89, '', 59, 0, 1, 0, 1, '2015-06-10 23:11:00', '2015-06-10 23:11:00'),
(90, '', 89, 0, 1, 0, 1, '2015-06-10 23:11:20', '2015-06-10 23:13:03'),
(91, '', 89, 0, 1, 0, 1, '2015-06-10 23:13:40', '2015-06-10 23:13:40'),
(92, '', 89, 0, 1, 0, 1, '2015-06-10 23:14:02', '2015-06-10 23:14:02'),
(93, '', 89, 0, 1, 0, 1, '2015-06-10 23:14:25', '2015-06-10 23:14:25'),
(94, '', 59, 0, 1, 0, 1, '2015-06-10 23:14:43', '2015-06-10 23:14:43'),
(95, '', 94, 0, 1, 0, 1, '2015-06-10 23:15:07', '2015-06-10 23:15:07'),
(96, '', 94, 0, 1, 0, 1, '2015-06-10 23:15:22', '2015-06-10 23:15:22'),
(97, '', 60, 0, 1, 0, 1, '2015-06-10 23:15:44', '2015-06-10 23:15:44'),
(98, '', 97, 0, 1, 0, 1, '2015-06-10 23:16:21', '2015-06-10 23:16:21'),
(99, '', 97, 0, 1, 0, 1, '2015-06-10 23:16:45', '2015-06-10 23:16:45'),
(100, '', 97, 0, 1, 0, 1, '2015-06-10 23:17:18', '2015-06-10 23:17:18'),
(101, '', 97, 0, 1, 0, 1, '2015-06-10 23:17:38', '2015-06-10 23:17:38'),
(102, '', 97, 0, 1, 0, 1, '2015-06-10 23:17:52', '2015-06-10 23:17:52'),
(103, '', 97, 0, 1, 0, 1, '2015-06-11 12:55:38', '2015-06-11 12:55:38'),
(104, '', 97, 0, 1, 0, 1, '2015-06-11 12:55:59', '2015-06-11 12:55:59'),
(105, '', 97, 0, 1, 0, 1, '2015-06-11 12:56:14', '2015-06-11 12:56:14'),
(106, '', 97, 0, 1, 0, 1, '2015-06-11 12:56:31', '2015-06-11 12:56:31'),
(107, '', 97, 0, 1, 0, 1, '2015-06-11 12:57:49', '2015-06-11 12:57:49'),
(108, '', 97, 0, 1, 0, 1, '2015-06-11 12:58:04', '2015-06-11 12:58:04'),
(109, '', 60, 0, 1, 0, 1, '2015-06-11 12:58:19', '2015-06-11 12:58:19'),
(110, '', 109, 0, 1, 0, 1, '2015-06-11 12:59:43', '2015-06-11 12:59:43'),
(111, '', 109, 0, 1, 0, 1, '2015-06-11 12:59:56', '2015-06-11 12:59:56'),
(112, '', 109, 0, 1, 0, 1, '2015-06-11 13:00:12', '2015-06-11 13:00:12'),
(113, '', 109, 0, 1, 0, 1, '2015-06-11 13:00:30', '2015-06-11 13:00:30'),
(114, '', 109, 0, 1, 0, 1, '2015-06-11 13:04:27', '2015-06-11 13:04:27'),
(115, '', 60, 0, 1, 0, 1, '2015-06-11 13:04:45', '2015-06-11 13:04:45'),
(116, '', 115, 0, 1, 0, 1, '2015-06-11 13:05:05', '2015-06-11 13:05:05'),
(117, '', 115, 0, 1, 0, 1, '2015-06-11 13:05:20', '2015-06-11 13:05:20'),
(118, '', 115, 0, 1, 0, 1, '2015-06-11 13:05:37', '2015-06-11 13:05:37'),
(119, '', 115, 0, 1, 0, 1, '2015-06-11 13:05:55', '2015-06-11 13:05:55'),
(120, '', 115, 0, 1, 0, 1, '2015-06-11 13:06:39', '2015-06-11 13:06:39'),
(121, '', 115, 0, 1, 0, 1, '2015-06-11 13:06:56', '2015-06-11 13:06:56'),
(122, '', 115, 0, 1, 0, 1, '2015-06-11 13:07:11', '2015-06-11 13:07:11'),
(123, '', 115, 0, 1, 0, 1, '2015-06-11 13:07:24', '2015-06-11 13:07:24'),
(124, '', 115, 0, 1, 0, 1, '2015-06-11 13:07:47', '2015-06-11 13:07:47'),
(125, '', 115, 0, 1, 0, 1, '2015-06-11 13:08:06', '2015-06-11 13:08:06'),
(126, '', 115, 0, 1, 0, 1, '2015-06-11 13:08:20', '2015-06-11 13:08:20'),
(127, '', 115, 0, 1, 0, 1, '2015-06-11 13:08:37', '2015-06-11 13:08:37'),
(128, '', 60, 0, 1, 0, 1, '2015-06-11 13:08:51', '2015-06-11 13:08:51'),
(129, '', 128, 0, 1, 0, 1, '2015-06-11 13:09:04', '2015-06-11 13:09:04'),
(130, '', 128, 0, 1, 0, 1, '2015-06-11 13:09:16', '2015-06-11 13:09:16'),
(131, '', 128, 0, 1, 0, 1, '2015-06-11 13:09:27', '2015-06-11 13:09:27'),
(132, '', 128, 0, 1, 0, 1, '2015-06-11 13:09:39', '2015-06-11 13:09:39'),
(133, '', 128, 0, 1, 0, 1, '2015-06-11 13:09:51', '2015-06-11 13:09:51'),
(134, '', 128, 0, 1, 0, 1, '2015-06-11 13:10:07', '2015-06-11 13:10:07'),
(135, '', 128, 0, 1, 0, 1, '2015-06-11 13:10:20', '2015-06-11 13:10:20'),
(136, '', 128, 0, 1, 0, 1, '2015-06-11 13:10:35', '2015-06-11 13:10:35'),
(137, '', 128, 0, 1, 0, 1, '2015-06-11 13:11:17', '2015-06-11 13:11:17'),
(138, '', 128, 0, 1, 0, 1, '2015-06-11 13:11:30', '2015-06-11 13:11:30');

-- --------------------------------------------------------

--
-- 表的结构 `yk_category_description`
--

CREATE TABLE IF NOT EXISTS `yk_category_description` (
  `category_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `meta_description` varchar(255) NOT NULL,
  `meta_keyword` varchar(255) NOT NULL,
  PRIMARY KEY (`category_id`,`language_id`),
  KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `yk_category_description`
--

INSERT INTO `yk_category_description` (`category_id`, `language_id`, `name`, `description`, `meta_description`, `meta_keyword`) VALUES
(60, 2, '消防装备', '', '', ''),
(61, 2, '消火栓系统', '', '', ''),
(62, 2, '消火栓', '', '', ''),
(63, 2, '消防水带', '', '', ''),
(64, 2, '消火栓箱', '', '', ''),
(65, 2, '消防泵', '', '', ''),
(66, 2, '消防水炮', '', '', ''),
(67, 2, '消防水枪', '', '', ''),
(68, 2, '消防卷盘', '', '', ''),
(69, 2, '火灾自动报警系统', '', '', ''),
(70, 2, '火灾探测器', '', '', ''),
(71, 2, '声光报警器', '', '', ''),
(72, 2, '应急广播', '', '', ''),
(73, 2, '消防警铃', '', '', ''),
(74, 2, '漏电火灾报警系统', '', '', ''),
(75, 2, '自动灭火系统', '', '', ''),
(76, 2, '消防泵', '', '', ''),
(77, 2, '喷淋', '', '', ''),
(78, 2, '阀门', '', '', ''),
(79, 2, '灭火器', '', '', ''),
(80, 2, '水流指示器', '', '', ''),
(81, 2, '灭火剂', '', '', ''),
(82, 2, '气体检测仪', '', '', ''),
(83, 2, '泡沫灭火装置', '', '', ''),
(59, 2, '消防产品', '', '', ''),
(84, 2, '防火分隔系统', '', '', ''),
(85, 2, '防火门', '', '', ''),
(86, 2, '防火阀', '', '', ''),
(87, 2, '防火卷帘', '', '', ''),
(88, 2, '防火水幕带', '', '', ''),
(89, 2, '防、排烟系统', '', '', ''),
(90, 2, '风机', '', '', ''),
(91, 2, '风阀', '', '', ''),
(92, 2, '管件', '', '', ''),
(93, 2, '风机电气控制箱', '', '', ''),
(94, 2, '应急疏散系统', '', '', ''),
(95, 2, '应急照明', '', '', ''),
(96, 2, '疏散指示标志', '', '', ''),
(97, 2, '个人防护装备', '', '', ''),
(98, 2, '头盔', '', '', ''),
(99, 2, '战斗服', '', '', ''),
(100, 2, '消防手套', '', '', ''),
(101, 2, '安全带', '', '', ''),
(102, 2, '消防头灯', '', '', ''),
(103, 2, '导向绳', '', '', ''),
(104, 2, '消防腰斧', '', '', ''),
(105, 2, '战斗靴', '', '', ''),
(106, 2, '空气呼吸器', '', '', ''),
(107, 2, '呼救器', '', '', ''),
(108, 2, '方位灯', '', '', ''),
(109, 2, '特种防护装备', '', '', ''),
(110, 2, '避火服', '', '', ''),
(111, 2, '隔热服', '', '', ''),
(112, 2, '防化服', '', '', ''),
(113, 2, '耐寒战斗服', '', '', ''),
(114, 2, '消防空气呼吸器', '', '', ''),
(115, 2, '抢险救援装备', '', '', ''),
(116, 2, '担架', '', '', ''),
(117, 2, '救援网', '', '', ''),
(118, 2, '止坠器', '', '', ''),
(119, 2, '头盔', '', '', ''),
(120, 2, '安全带', '', '', ''),
(121, 2, '防爆灯', '', '', ''),
(122, 2, '消防服', '', '', ''),
(123, 2, '缓降器', '', '', ''),
(124, 2, '破拆工具', '', '', ''),
(125, 2, '呼吸器', '', '', ''),
(126, 2, '空气压缩机', '', '', ''),
(127, 2, '生命探测仪', '', '', ''),
(128, 2, '灭火救援装备', '', '', ''),
(129, 2, '消防斧', '', '', ''),
(130, 2, '铁锹', '', '', ''),
(131, 2, '铁铤', '', '', ''),
(132, 2, '绝缘剪', '', '', ''),
(133, 2, '液压扩张器', '', '', ''),
(134, 2, '液压钳剪切钳', '', '', ''),
(135, 2, '液压千斤顶', '', '', ''),
(136, 2, '液压机动泵', '', '', ''),
(137, 2, '无齿锯', '', '', ''),
(138, 2, '消防安全吊带', '', '', '');

-- --------------------------------------------------------

--
-- 表的结构 `yk_category_filter`
--

CREATE TABLE IF NOT EXISTS `yk_category_filter` (
  `category_id` int(11) NOT NULL,
  `filter_id` int(11) NOT NULL,
  PRIMARY KEY (`category_id`,`filter_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `yk_category_path`
--

CREATE TABLE IF NOT EXISTS `yk_category_path` (
  `category_id` int(11) NOT NULL,
  `path_id` int(11) NOT NULL,
  `level` int(11) NOT NULL,
  PRIMARY KEY (`category_id`,`path_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `yk_category_path`
--

INSERT INTO `yk_category_path` (`category_id`, `path_id`, `level`) VALUES
(83, 59, 0),
(83, 75, 1),
(83, 83, 2),
(82, 59, 0),
(82, 75, 1),
(82, 82, 2),
(81, 59, 0),
(81, 75, 1),
(81, 81, 2),
(80, 59, 0),
(80, 75, 1),
(80, 80, 2),
(79, 59, 0),
(79, 75, 1),
(79, 79, 2),
(78, 59, 0),
(78, 75, 1),
(78, 78, 2),
(77, 59, 0),
(77, 75, 1),
(61, 61, 1),
(77, 77, 2),
(76, 59, 0),
(76, 75, 1),
(76, 76, 2),
(75, 59, 0),
(60, 60, 0),
(75, 75, 1),
(74, 59, 0),
(74, 69, 1),
(74, 74, 2),
(73, 59, 0),
(73, 69, 1),
(73, 73, 2),
(72, 59, 0),
(72, 69, 1),
(72, 72, 2),
(71, 59, 0),
(71, 69, 1),
(71, 71, 2),
(70, 59, 0),
(70, 69, 1),
(70, 70, 2),
(69, 59, 0),
(69, 69, 1),
(68, 59, 0),
(68, 68, 2),
(68, 61, 1),
(67, 59, 0),
(67, 61, 1),
(67, 67, 2),
(66, 59, 0),
(66, 61, 1),
(66, 66, 2),
(65, 59, 0),
(65, 61, 1),
(65, 65, 2),
(64, 59, 0),
(64, 61, 1),
(64, 64, 2),
(63, 59, 0),
(63, 61, 1),
(63, 63, 2),
(62, 59, 0),
(62, 61, 1),
(62, 62, 2),
(61, 59, 0),
(59, 59, 0),
(84, 84, 1),
(84, 59, 0),
(85, 85, 2),
(85, 84, 1),
(85, 59, 0),
(86, 86, 2),
(86, 84, 1),
(86, 59, 0),
(87, 87, 2),
(87, 84, 1),
(87, 59, 0),
(88, 88, 2),
(88, 84, 1),
(88, 59, 0),
(89, 59, 0),
(89, 89, 1),
(90, 59, 0),
(90, 90, 2),
(90, 89, 1),
(91, 59, 0),
(91, 89, 1),
(91, 91, 2),
(92, 59, 0),
(92, 89, 1),
(92, 92, 2),
(93, 59, 0),
(93, 89, 1),
(93, 93, 2),
(94, 59, 0),
(94, 94, 1),
(95, 59, 0),
(95, 94, 1),
(95, 95, 2),
(96, 59, 0),
(96, 94, 1),
(96, 96, 2),
(97, 60, 0),
(97, 97, 1),
(98, 60, 0),
(98, 97, 1),
(98, 98, 2),
(99, 60, 0),
(99, 97, 1),
(99, 99, 2),
(100, 60, 0),
(100, 97, 1),
(100, 100, 2),
(101, 60, 0),
(101, 97, 1),
(101, 101, 2),
(102, 60, 0),
(102, 97, 1),
(102, 102, 2),
(103, 60, 0),
(103, 97, 1),
(103, 103, 2),
(104, 60, 0),
(104, 97, 1),
(104, 104, 2),
(105, 60, 0),
(105, 97, 1),
(105, 105, 2),
(106, 60, 0),
(106, 97, 1),
(106, 106, 2),
(107, 60, 0),
(107, 97, 1),
(107, 107, 2),
(108, 60, 0),
(108, 97, 1),
(108, 108, 2),
(109, 60, 0),
(109, 109, 1),
(110, 60, 0),
(110, 109, 1),
(110, 110, 2),
(111, 60, 0),
(111, 109, 1),
(111, 111, 2),
(112, 60, 0),
(112, 109, 1),
(112, 112, 2),
(113, 60, 0),
(113, 109, 1),
(113, 113, 2),
(114, 60, 0),
(114, 109, 1),
(114, 114, 2),
(115, 60, 0),
(115, 115, 1),
(116, 60, 0),
(116, 115, 1),
(116, 116, 2),
(117, 60, 0),
(117, 115, 1),
(117, 117, 2),
(118, 60, 0),
(118, 115, 1),
(118, 118, 2),
(119, 60, 0),
(119, 115, 1),
(119, 119, 2),
(120, 60, 0),
(120, 115, 1),
(120, 120, 2),
(121, 60, 0),
(121, 115, 1),
(121, 121, 2),
(122, 60, 0),
(122, 115, 1),
(122, 122, 2),
(123, 60, 0),
(123, 115, 1),
(123, 123, 2),
(124, 60, 0),
(124, 115, 1),
(124, 124, 2),
(125, 60, 0),
(125, 115, 1),
(125, 125, 2),
(126, 60, 0),
(126, 115, 1),
(126, 126, 2),
(127, 60, 0),
(127, 115, 1),
(127, 127, 2),
(128, 60, 0),
(128, 128, 1),
(129, 60, 0),
(129, 128, 1),
(129, 129, 2),
(130, 60, 0),
(130, 128, 1),
(130, 130, 2),
(131, 60, 0),
(131, 128, 1),
(131, 131, 2),
(132, 60, 0),
(132, 128, 1),
(132, 132, 2),
(133, 60, 0),
(133, 128, 1),
(133, 133, 2),
(134, 60, 0),
(134, 128, 1),
(134, 134, 2),
(135, 60, 0),
(135, 128, 1),
(135, 135, 2),
(136, 60, 0),
(136, 128, 1),
(136, 136, 2),
(137, 60, 0),
(137, 128, 1),
(137, 137, 2),
(138, 60, 0),
(138, 128, 1),
(138, 138, 2);

-- --------------------------------------------------------

--
-- 表的结构 `yk_category_to_layout`
--

CREATE TABLE IF NOT EXISTS `yk_category_to_layout` (
  `category_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  `layout_id` int(11) NOT NULL,
  PRIMARY KEY (`category_id`,`store_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `yk_category_to_store`
--

CREATE TABLE IF NOT EXISTS `yk_category_to_store` (
  `category_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  PRIMARY KEY (`category_id`,`store_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `yk_category_to_store`
--

INSERT INTO `yk_category_to_store` (`category_id`, `store_id`) VALUES
(59, 0),
(60, 0),
(61, 0),
(62, 0),
(63, 0),
(64, 0),
(65, 0),
(66, 0),
(67, 0),
(68, 0),
(69, 0),
(70, 0),
(71, 0),
(72, 0),
(73, 0),
(74, 0),
(75, 0),
(76, 0),
(77, 0),
(78, 0),
(79, 0),
(80, 0),
(81, 0),
(82, 0),
(83, 0),
(84, 0),
(85, 0),
(86, 0),
(87, 0),
(88, 0),
(89, 0),
(90, 0),
(91, 0),
(92, 0),
(93, 0),
(94, 0),
(95, 0),
(96, 0),
(97, 0),
(98, 0),
(99, 0),
(100, 0),
(101, 0),
(102, 0),
(103, 0),
(104, 0),
(105, 0),
(106, 0),
(107, 0),
(108, 0),
(109, 0),
(110, 0),
(111, 0),
(112, 0),
(113, 0),
(114, 0),
(115, 0),
(116, 0),
(117, 0),
(118, 0),
(119, 0),
(120, 0),
(121, 0),
(122, 0),
(123, 0),
(124, 0),
(125, 0),
(126, 0),
(127, 0),
(128, 0),
(129, 0),
(130, 0),
(131, 0),
(132, 0),
(133, 0),
(134, 0),
(135, 0),
(136, 0),
(137, 0),
(138, 0);

-- --------------------------------------------------------

--
-- 表的结构 `yk_country`
--

CREATE TABLE IF NOT EXISTS `yk_country` (
  `country_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `iso_code_2` varchar(2) NOT NULL,
  `iso_code_3` varchar(3) NOT NULL,
  `address_format` text NOT NULL,
  `postcode_required` tinyint(1) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`country_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=258 ;

--
-- 转存表中的数据 `yk_country`
--

INSERT INTO `yk_country` (`country_id`, `name`, `iso_code_2`, `iso_code_3`, `address_format`, `postcode_required`, `status`) VALUES
(44, '中国(China)', 'CN', 'CHN', '', 0, 1);

-- --------------------------------------------------------

--
-- 表的结构 `yk_coupon`
--

CREATE TABLE IF NOT EXISTS `yk_coupon` (
  `coupon_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `code` varchar(10) NOT NULL,
  `type` char(1) NOT NULL,
  `discount` decimal(15,4) NOT NULL,
  `logged` tinyint(1) NOT NULL,
  `shipping` tinyint(1) NOT NULL,
  `total` decimal(15,4) NOT NULL,
  `date_start` date NOT NULL DEFAULT '0000-00-00',
  `date_end` date NOT NULL DEFAULT '0000-00-00',
  `uses_total` int(11) NOT NULL,
  `uses_customer` varchar(11) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`coupon_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- 转存表中的数据 `yk_coupon`
--

INSERT INTO `yk_coupon` (`coupon_id`, `name`, `code`, `type`, `discount`, `logged`, `shipping`, `total`, `date_start`, `date_end`, `uses_total`, `uses_customer`, `status`, `date_added`) VALUES
(4, '-10% Discount', '2222', 'P', '10.0000', 0, 0, '0.0000', '2011-01-01', '2012-01-01', 10, '10', 1, '2009-01-27 13:55:03'),
(5, 'Free Shipping', '3333', 'P', '0.0000', 0, 1, '100.0000', '2009-03-01', '2009-08-31', 10, '10', 1, '2009-03-14 21:13:53'),
(6, '-10.00 Discount', '1111', 'F', '10.0000', 0, 0, '10.0000', '1970-11-01', '2020-11-01', 100000, '10000', 1, '2009-03-14 21:15:18');

-- --------------------------------------------------------

--
-- 表的结构 `yk_coupon_category`
--

CREATE TABLE IF NOT EXISTS `yk_coupon_category` (
  `coupon_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`coupon_id`,`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `yk_coupon_history`
--

CREATE TABLE IF NOT EXISTS `yk_coupon_history` (
  `coupon_history_id` int(11) NOT NULL AUTO_INCREMENT,
  `coupon_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `amount` decimal(15,4) NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`coupon_history_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `yk_coupon_product`
--

CREATE TABLE IF NOT EXISTS `yk_coupon_product` (
  `coupon_product_id` int(11) NOT NULL AUTO_INCREMENT,
  `coupon_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  PRIMARY KEY (`coupon_product_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `yk_currency`
--

CREATE TABLE IF NOT EXISTS `yk_currency` (
  `currency_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) NOT NULL,
  `code` varchar(3) NOT NULL,
  `symbol_left` varchar(12) NOT NULL,
  `symbol_right` varchar(12) NOT NULL,
  `decimal_place` char(1) NOT NULL,
  `value` float(15,8) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `date_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`currency_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- 转存表中的数据 `yk_currency`
--

INSERT INTO `yk_currency` (`currency_id`, `title`, `code`, `symbol_left`, `symbol_right`, `decimal_place`, `value`, `status`, `date_modified`) VALUES
(2, '人民币', 'CNY', '￥', '', '2', 1.00000000, 1, '2015-06-04 16:09:45');

-- --------------------------------------------------------

--
-- 表的结构 `yk_customer`
--

CREATE TABLE IF NOT EXISTS `yk_customer` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `firstname` varchar(32) NOT NULL,
  `lastname` varchar(32) NOT NULL,
  `email` varchar(96) NOT NULL,
  `telephone` varchar(32) NOT NULL,
  `fax` varchar(32) NOT NULL,
  `password` varchar(40) NOT NULL,
  `salt` varchar(9) NOT NULL,
  `cart` text,
  `wishlist` text,
  `newsletter` tinyint(1) NOT NULL DEFAULT '0',
  `address_id` int(11) NOT NULL DEFAULT '0',
  `customer_group_id` int(11) NOT NULL,
  `ip` varchar(40) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL,
  `approved` tinyint(1) NOT NULL,
  `token` varchar(255) NOT NULL,
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`customer_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `yk_customer`
--

INSERT INTO `yk_customer` (`customer_id`, `store_id`, `firstname`, `lastname`, `email`, `telephone`, `fax`, `password`, `salt`, `cart`, `wishlist`, `newsletter`, `address_id`, `customer_group_id`, `ip`, `status`, `approved`, `token`, `date_added`) VALUES
(1, 0, '靖', '郭', 'guojing@shediao.cn', '123123', '', '3838e00e6e59c95a65bc786ff38d303252338a3f', '7abf86dd9', 'a:0:{}', '', 0, 0, 1, '127.0.0.1', 1, 0, '', '2015-06-12 17:34:52');

-- --------------------------------------------------------

--
-- 表的结构 `yk_customer_ban_ip`
--

CREATE TABLE IF NOT EXISTS `yk_customer_ban_ip` (
  `customer_ban_ip_id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(40) NOT NULL,
  PRIMARY KEY (`customer_ban_ip_id`),
  KEY `ip` (`ip`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `yk_customer_field`
--

CREATE TABLE IF NOT EXISTS `yk_customer_field` (
  `customer_id` int(11) NOT NULL,
  `custom_field_id` int(11) NOT NULL,
  `custom_field_value_id` int(11) NOT NULL,
  `name` int(128) NOT NULL,
  `value` text NOT NULL,
  `sort_order` int(3) NOT NULL,
  PRIMARY KEY (`customer_id`,`custom_field_id`,`custom_field_value_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `yk_customer_group`
--

CREATE TABLE IF NOT EXISTS `yk_customer_group` (
  `customer_group_id` int(11) NOT NULL AUTO_INCREMENT,
  `approval` int(1) NOT NULL,
  `company_id_display` int(1) NOT NULL,
  `company_id_required` int(1) NOT NULL,
  `tax_id_display` int(1) NOT NULL,
  `tax_id_required` int(1) NOT NULL,
  `sort_order` int(3) NOT NULL,
  PRIMARY KEY (`customer_group_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `yk_customer_group`
--

INSERT INTO `yk_customer_group` (`customer_group_id`, `approval`, `company_id_display`, `company_id_required`, `tax_id_display`, `tax_id_required`, `sort_order`) VALUES
(1, 0, 1, 0, 0, 1, 1);

-- --------------------------------------------------------

--
-- 表的结构 `yk_customer_group_description`
--

CREATE TABLE IF NOT EXISTS `yk_customer_group_description` (
  `customer_group_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`customer_group_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `yk_customer_group_description`
--

INSERT INTO `yk_customer_group_description` (`customer_group_id`, `language_id`, `name`, `description`) VALUES
(1, 2, 'Default', 'test');

-- --------------------------------------------------------

--
-- 表的结构 `yk_customer_history`
--

CREATE TABLE IF NOT EXISTS `yk_customer_history` (
  `customer_history_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `comment` text NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`customer_history_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `yk_customer_ip`
--

CREATE TABLE IF NOT EXISTS `yk_customer_ip` (
  `customer_ip_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `ip` varchar(40) NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`customer_ip_id`),
  KEY `ip` (`ip`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `yk_customer_ip`
--

INSERT INTO `yk_customer_ip` (`customer_ip_id`, `customer_id`, `ip`, `date_added`) VALUES
(1, 1, '127.0.0.1', '2015-06-12 17:35:00');

-- --------------------------------------------------------

--
-- 表的结构 `yk_customer_online`
--

CREATE TABLE IF NOT EXISTS `yk_customer_online` (
  `ip` varchar(40) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `url` text NOT NULL,
  `referer` text NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`ip`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `yk_customer_reward`
--

CREATE TABLE IF NOT EXISTS `yk_customer_reward` (
  `customer_reward_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL DEFAULT '0',
  `order_id` int(11) NOT NULL DEFAULT '0',
  `description` text NOT NULL,
  `points` int(8) NOT NULL DEFAULT '0',
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`customer_reward_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `yk_customer_transaction`
--

CREATE TABLE IF NOT EXISTS `yk_customer_transaction` (
  `customer_transaction_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `description` text NOT NULL,
  `amount` decimal(15,4) NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`customer_transaction_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `yk_custom_field`
--

CREATE TABLE IF NOT EXISTS `yk_custom_field` (
  `custom_field_id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(32) NOT NULL,
  `value` text NOT NULL,
  `required` tinyint(1) NOT NULL,
  `location` varchar(32) NOT NULL,
  `position` int(3) NOT NULL,
  `sort_order` int(3) NOT NULL,
  PRIMARY KEY (`custom_field_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `yk_custom_field_description`
--

CREATE TABLE IF NOT EXISTS `yk_custom_field_description` (
  `custom_field_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  PRIMARY KEY (`custom_field_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `yk_custom_field_to_customer_group`
--

CREATE TABLE IF NOT EXISTS `yk_custom_field_to_customer_group` (
  `custom_field_id` int(11) NOT NULL,
  `customer_group_id` int(11) NOT NULL,
  PRIMARY KEY (`custom_field_id`,`customer_group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `yk_custom_field_value`
--

CREATE TABLE IF NOT EXISTS `yk_custom_field_value` (
  `custom_field_value_id` int(11) NOT NULL AUTO_INCREMENT,
  `custom_field_id` int(11) NOT NULL,
  `sort_order` int(3) NOT NULL,
  PRIMARY KEY (`custom_field_value_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `yk_custom_field_value_description`
--

CREATE TABLE IF NOT EXISTS `yk_custom_field_value_description` (
  `custom_field_value_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `custom_field_id` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  PRIMARY KEY (`custom_field_value_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `yk_download`
--

CREATE TABLE IF NOT EXISTS `yk_download` (
  `download_id` int(11) NOT NULL AUTO_INCREMENT,
  `filename` varchar(128) NOT NULL,
  `mask` varchar(128) NOT NULL,
  `remaining` int(11) NOT NULL DEFAULT '0',
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`download_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `yk_download_description`
--

CREATE TABLE IF NOT EXISTS `yk_download_description` (
  `download_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`download_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `yk_extension`
--

CREATE TABLE IF NOT EXISTS `yk_extension` (
  `extension_id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(32) NOT NULL,
  `code` varchar(32) NOT NULL,
  PRIMARY KEY (`extension_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=459 ;

--
-- 转存表中的数据 `yk_extension`
--

INSERT INTO `yk_extension` (`extension_id`, `type`, `code`) VALUES
(23, 'payment', 'cod'),
(22, 'total', 'shipping'),
(57, 'total', 'sub_total'),
(58, 'total', 'tax'),
(59, 'total', 'total'),
(436, 'module', 'pavcontentslider'),
(426, 'module', 'carousel'),
(390, 'total', 'credit'),
(387, 'shipping', 'flat'),
(349, 'total', 'handling'),
(350, 'total', 'low_order_fee'),
(389, 'total', 'coupon'),
(413, 'module', 'category'),
(411, 'module', 'affiliate'),
(408, 'module', 'account'),
(393, 'total', 'reward'),
(398, 'total', 'voucher'),
(407, 'payment', 'free_checkout'),
(427, 'module', 'featured'),
(435, 'module', 'pavcustom'),
(429, 'module', 'news'),
(430, 'module', 'themecontrol'),
(439, 'module', 'yknews'),
(440, 'module', 'ykproject'),
(441, 'module', 'pavmegamenu'),
(444, 'module', 'ykcase'),
(448, 'module', 'ykwiki'),
(455, 'module', 'ykaffiliate'),
(456, 'module', 'ykcarousel'),
(457, 'module', 'ykproduct'),
(458, 'module', 'yknavigation');

-- --------------------------------------------------------

--
-- 表的结构 `yk_filter`
--

CREATE TABLE IF NOT EXISTS `yk_filter` (
  `filter_id` int(11) NOT NULL AUTO_INCREMENT,
  `filter_group_id` int(11) NOT NULL,
  `sort_order` int(3) NOT NULL,
  PRIMARY KEY (`filter_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `yk_filter_description`
--

CREATE TABLE IF NOT EXISTS `yk_filter_description` (
  `filter_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `filter_group_id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`filter_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `yk_filter_group`
--

CREATE TABLE IF NOT EXISTS `yk_filter_group` (
  `filter_group_id` int(11) NOT NULL AUTO_INCREMENT,
  `sort_order` int(3) NOT NULL,
  PRIMARY KEY (`filter_group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `yk_filter_group_description`
--

CREATE TABLE IF NOT EXISTS `yk_filter_group_description` (
  `filter_group_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`filter_group_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `yk_geo_zone`
--

CREATE TABLE IF NOT EXISTS `yk_geo_zone` (
  `geo_zone_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `description` varchar(255) NOT NULL,
  `date_modified` datetime NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`geo_zone_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- 转存表中的数据 `yk_geo_zone`
--

INSERT INTO `yk_geo_zone` (`geo_zone_id`, `name`, `description`, `date_modified`, `date_added`) VALUES
(3, '中国普通地区', '中国普通地区', '2015-04-01 22:23:18', '2009-01-06 23:26:25'),
(4, '中国偏远地区配送', '中国偏远地区配送', '2015-04-01 22:11:53', '2009-06-23 01:14:53'),
(5, '中国特别地区', '中国特别地区', '0000-00-00 00:00:00', '2015-04-01 22:24:09');

-- --------------------------------------------------------

--
-- 表的结构 `yk_help`
--

CREATE TABLE IF NOT EXISTS `yk_help` (
  `help_id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` smallint(6) NOT NULL DEFAULT '0',
  `account` varchar(128) NOT NULL,
  `telephone` varchar(16) NOT NULL,
  `text` varchar(512) DEFAULT NULL,
  `is_top` tinyint(4) NOT NULL DEFAULT '0',
  `sort_order` smallint(6) NOT NULL DEFAULT '0',
  `reply` text,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `date_replied` datetime DEFAULT NULL,
  `date_added` datetime DEFAULT NULL,
  PRIMARY KEY (`help_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- 转存表中的数据 `yk_help`
--

INSERT INTO `yk_help` (`help_id`, `group_id`, `account`, `telephone`, `text`, `is_top`, `sort_order`, `reply`, `user_id`, `status`, `date_replied`, `date_added`) VALUES
(1, 0, '宝马为740i准备了代号B58的新一代直列六缸涡轮增压汽油发动机', '12312312', 'asdsadasdasdas', 0, 0, 'asdsadasdsa', 1, 1, '2015-06-10 06:14:38', '2015-06-10 06:14:38'),
(2, 0, 'asdsafafasdasd', '12321321312', 'adasdasdsadassa', 0, 0, NULL, 0, 1, NULL, '2015-05-25 07:37:26'),
(3, 0, '汉武帝开拓疆域：中国国家雏形形成', '1312434243', '汉代建立起中原王朝的一个初步形态，尤以汉武帝对\r\n\r\n疆域的拓展最具开创意义。[详细]', 1, 2, '在李莎与李立三的后代看来，李莎"为了爱情的远行"\r\n\r\n，虽然为此付出了巨大的代价，但终生无悔。[详', 1, 1, NULL, '2015-06-10 08:25:06');

-- --------------------------------------------------------

--
-- 表的结构 `yk_help_group`
--

CREATE TABLE IF NOT EXISTS `yk_help_group` (
  `group_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `show` tinyint(4) NOT NULL DEFAULT '0',
  `sort_order` int(3) NOT NULL,
  PRIMARY KEY (`group_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

-- --------------------------------------------------------

--
-- 表的结构 `yk_information`
--

CREATE TABLE IF NOT EXISTS `yk_information` (
  `information_id` int(11) NOT NULL AUTO_INCREMENT,
  `bottom` int(1) NOT NULL DEFAULT '0',
  `sort_order` int(3) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`information_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- 转存表中的数据 `yk_information`
--

INSERT INTO `yk_information` (`information_id`, `bottom`, `sort_order`, `status`) VALUES
(3, 1, 3, 1),
(4, 1, 1, 1),
(5, 1, 4, 1),
(6, 1, 2, 1);

-- --------------------------------------------------------

--
-- 表的结构 `yk_information_description`
--

CREATE TABLE IF NOT EXISTS `yk_information_description` (
  `information_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `title` varchar(64) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`information_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `yk_information_description`
--

INSERT INTO `yk_information_description` (`information_id`, `language_id`, `title`, `description`) VALUES
(4, 2, 'About Us', '&lt;p&gt;\r\n	About Us&lt;/p&gt;\r\n'),
(5, 2, 'Terms &amp; Conditions', '&lt;p&gt;\r\n	Terms &amp;amp; Conditions&lt;/p&gt;\r\n'),
(3, 2, 'Privacy Policy', '&lt;p&gt;\r\n	Privacy Policy&lt;/p&gt;\r\n'),
(6, 2, 'Delivery Information', '&lt;p&gt;\r\n	Delivery Information&lt;/p&gt;\r\n');

-- --------------------------------------------------------

--
-- 表的结构 `yk_information_to_layout`
--

CREATE TABLE IF NOT EXISTS `yk_information_to_layout` (
  `information_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  `layout_id` int(11) NOT NULL,
  PRIMARY KEY (`information_id`,`store_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `yk_information_to_store`
--

CREATE TABLE IF NOT EXISTS `yk_information_to_store` (
  `information_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  PRIMARY KEY (`information_id`,`store_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `yk_information_to_store`
--

INSERT INTO `yk_information_to_store` (`information_id`, `store_id`) VALUES
(3, 0),
(4, 0),
(5, 0),
(6, 0);

-- --------------------------------------------------------

--
-- 表的结构 `yk_language`
--

CREATE TABLE IF NOT EXISTS `yk_language` (
  `language_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `code` varchar(5) NOT NULL,
  `locale` varchar(255) NOT NULL,
  `image` varchar(64) NOT NULL,
  `directory` varchar(32) NOT NULL,
  `filename` varchar(64) NOT NULL,
  `sort_order` int(3) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY (`language_id`),
  KEY `name` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `yk_language`
--

INSERT INTO `yk_language` (`language_id`, `name`, `code`, `locale`, `image`, `directory`, `filename`, `sort_order`, `status`) VALUES
(2, '简体中文', 'cn', 'zh,zh-hk,zh-cn,zh-cn.UTF-8,cn-gb,chinese ', 'cn.png', 'chinese', 'chinese', 1, 1);

-- --------------------------------------------------------

--
-- 表的结构 `yk_layout`
--

CREATE TABLE IF NOT EXISTS `yk_layout` (
  `layout_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`layout_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

--
-- 转存表中的数据 `yk_layout`
--

INSERT INTO `yk_layout` (`layout_id`, `name`) VALUES
(1, 'Home'),
(2, 'Product'),
(3, 'Category'),
(4, 'Default'),
(5, 'Manufacturer'),
(6, 'Account'),
(7, 'Checkout'),
(8, 'Contact'),
(9, 'Sitemap'),
(10, 'Affiliate'),
(11, 'Information');

-- --------------------------------------------------------

--
-- 表的结构 `yk_layout_route`
--

CREATE TABLE IF NOT EXISTS `yk_layout_route` (
  `layout_route_id` int(11) NOT NULL AUTO_INCREMENT,
  `layout_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  `route` varchar(255) NOT NULL,
  PRIMARY KEY (`layout_route_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=33 ;

--
-- 转存表中的数据 `yk_layout_route`
--

INSERT INTO `yk_layout_route` (`layout_route_id`, `layout_id`, `store_id`, `route`) VALUES
(30, 6, 0, 'account'),
(17, 10, 0, 'affiliate/'),
(29, 3, 0, 'product/category'),
(26, 1, 0, 'common/home'),
(20, 2, 0, 'product/product'),
(24, 11, 0, 'information/information'),
(22, 5, 0, 'product/manufacturer'),
(23, 7, 0, 'checkout/'),
(31, 8, 0, 'information/contact'),
(32, 9, 0, 'information/sitemap');

-- --------------------------------------------------------

--
-- 表的结构 `yk_length_class`
--

CREATE TABLE IF NOT EXISTS `yk_length_class` (
  `length_class_id` int(11) NOT NULL AUTO_INCREMENT,
  `value` decimal(15,8) NOT NULL,
  PRIMARY KEY (`length_class_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- 转存表中的数据 `yk_length_class`
--

INSERT INTO `yk_length_class` (`length_class_id`, `value`) VALUES
(1, '1.00000000'),
(2, '10.00000000'),
(3, '0.39370000');

-- --------------------------------------------------------

--
-- 表的结构 `yk_length_class_description`
--

CREATE TABLE IF NOT EXISTS `yk_length_class_description` (
  `length_class_id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `title` varchar(32) NOT NULL,
  `unit` varchar(4) NOT NULL,
  PRIMARY KEY (`length_class_id`,`language_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- 转存表中的数据 `yk_length_class_description`
--

INSERT INTO `yk_length_class_description` (`length_class_id`, `language_id`, `title`, `unit`) VALUES
(1, 2, '厘 米', 'cm'),
(2, 2, '毫 米', 'mm'),
(3, 2, '英 寸', 'in');

-- --------------------------------------------------------

--
-- 表的结构 `yk_link`
--

CREATE TABLE IF NOT EXISTS `yk_link` (
  `link_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `url` varchar(256) COLLATE utf8_unicode_ci NOT NULL,
  `status` tinyint(4) NOT NULL,
  `sort_order` smallint(6) NOT NULL,
  PRIMARY KEY (`link_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `yk_link`
--

INSERT INTO `yk_link` (`link_id`, `name`, `url`, `status`, `sort_order`) VALUES
(1, '新浪', 'http://www.sina.com.cn/', 1, 1),
(2, '百度', 'https://www.baidu.com/', 1, 2);

-- --------------------------------------------------------

--
-- 表的结构 `yk_manufacturer`
--

CREATE TABLE IF NOT EXISTS `yk_manufacturer` (
  `manufacturer_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `sort_order` int(3) NOT NULL,
  PRIMARY KEY (`manufacturer_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

-- --------------------------------------------------------

--
-- 表的结构 `yk_manufacturer_to_store`
--

CREATE TABLE IF NOT EXISTS `yk_manufacturer_to_store` (
  `manufacturer_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  PRIMARY KEY (`manufacturer_id`,`store_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `yk_megamenu`
--

CREATE TABLE IF NOT EXISTS `yk_megamenu` (
  `megamenu_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `image` varchar(255) NOT NULL DEFAULT '',
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `is_group` smallint(6) NOT NULL DEFAULT '2',
  `width` varchar(255) DEFAULT NULL,
  `submenu_width` varchar(255) DEFAULT NULL,
  `colum_width` varchar(255) DEFAULT NULL,
  `submenu_colum_width` varchar(255) DEFAULT NULL,
  `item` varchar(255) DEFAULT NULL,
  `colums` varchar(255) DEFAULT '1',
  `type` varchar(255) NOT NULL,
  `is_content` smallint(6) NOT NULL DEFAULT '2',
  `show_title` smallint(6) NOT NULL DEFAULT '1',
  `type_submenu` varchar(10) NOT NULL DEFAULT '1',
  `level_depth` smallint(6) NOT NULL DEFAULT '0',
  `published` smallint(6) NOT NULL DEFAULT '1',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `position` int(11) unsigned NOT NULL DEFAULT '0',
  `show_sub` smallint(6) NOT NULL DEFAULT '0',
  `url` varchar(255) DEFAULT NULL,
  `target` varchar(25) DEFAULT NULL,
  `privacy` smallint(5) unsigned NOT NULL DEFAULT '0',
  `position_type` varchar(25) DEFAULT 'top',
  `menu_class` varchar(25) DEFAULT NULL,
  `description` text,
  `content_text` text,
  `submenu_content` text,
  `level` int(11) NOT NULL,
  `left` int(11) NOT NULL,
  `right` int(11) NOT NULL,
  PRIMARY KEY (`megamenu_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=41 ;

--
-- 转存表中的数据 `yk_megamenu`
--

INSERT INTO `yk_megamenu` (`megamenu_id`, `image`, `parent_id`, `is_group`, `width`, `submenu_width`, `colum_width`, `submenu_colum_width`, `item`, `colums`, `type`, `is_content`, `show_title`, `type_submenu`, `level_depth`, `published`, `store_id`, `position`, `show_sub`, `url`, `target`, `privacy`, `position_type`, `menu_class`, `description`, `content_text`, `submenu_content`, `level`, `left`, `right`) VALUES
(1, '', 0, 2, NULL, NULL, NULL, NULL, NULL, '1', '', 2, 1, '1', 0, 1, 0, 0, 0, NULL, NULL, 0, 'top', NULL, NULL, NULL, NULL, -5, 34, 47),
(4, '', 3, 0, NULL, NULL, NULL, '', '25', '1', 'category', 0, 1, 'menu', 0, 1, 0, 1, 0, '', NULL, 0, 'top', 'pav-parrent', NULL, '', '', 0, 0, 0),
(5, '', 1, 0, NULL, NULL, NULL, '', '17', '1', 'category', 0, 1, 'menu', 0, 1, 0, 3, 0, '', NULL, 0, 'top', 'pav-parrent', NULL, '', '', 0, 0, 0),
(7, '', 1, 0, NULL, NULL, NULL, '', '33', '1', 'category', 0, 1, 'menu', 0, 1, 0, 4, 0, '', NULL, 0, 'top', '', NULL, '', '', 0, 0, 0),
(10, '', 8, 0, NULL, NULL, NULL, '', '59', '1', 'category', 0, 1, 'menu', 0, 1, 0, 1, 0, '', NULL, 0, 'top', 'pav-menu-child', NULL, '', '', 0, 0, 0),
(11, '', 8, 0, NULL, NULL, NULL, '', '60', '1', 'category', 0, 1, 'menu', 0, 1, 0, 2, 0, '', NULL, 0, 'top', 'pav-menu-child', NULL, '', '', 0, 0, 0),
(12, '', 8, 0, NULL, NULL, NULL, '', '61', '1', 'category', 0, 1, 'menu', 0, 1, 0, 3, 0, '', NULL, 0, 'top', 'pav-menu-child', NULL, '', '', 0, 0, 0),
(13, '', 8, 0, NULL, NULL, NULL, '', '62', '1', 'category', 0, 1, 'menu', 0, 1, 0, 4, 0, '', NULL, 0, 'top', 'pav-menu-child', NULL, '', '', 0, 0, 0),
(14, '', 8, 0, NULL, NULL, NULL, '', '63', '1', 'category', 0, 1, 'menu', 0, 1, 0, 5, 0, '', NULL, 0, 'top', 'pav-menu-child', NULL, '', '', 0, 0, 0),
(15, '', 8, 0, NULL, NULL, NULL, '', '64', '1', 'category', 0, 1, 'menu', 0, 1, 0, 6, 0, '', NULL, 0, 'top', 'pav-menu-child', NULL, '', '', 0, 0, 0),
(16, '', 8, 0, NULL, NULL, NULL, '', '65', '1', 'category', 0, 1, 'menu', 0, 1, 0, 7, 0, '', NULL, 0, 'top', 'pav-menu-child', NULL, '', '', 0, 0, 0),
(17, '', 9, 0, NULL, NULL, NULL, '', '66', '1', 'category', 0, 1, 'menu', 0, 1, 0, 1, 0, '', NULL, 0, 'top', '', NULL, '', '', 0, 0, 0),
(18, '', 9, 0, NULL, NULL, NULL, '', '67', '1', 'category', 0, 1, 'menu', 0, 1, 0, 2, 0, '', NULL, 0, 'top', 'pav-menu-child', NULL, '', '', 0, 0, 0),
(19, '', 9, 0, NULL, NULL, NULL, '', '68', '1', 'category', 0, 1, 'menu', 0, 1, 0, 3, 0, '', NULL, 0, 'top', 'pav-menu-child', NULL, '', '', 0, 0, 0),
(20, '', 9, 0, NULL, NULL, NULL, '', '71', '1', 'category', 0, 1, 'menu', 0, 1, 0, 4, 0, '', NULL, 0, 'top', 'pav-menu-child', NULL, '', '', 0, 0, 0),
(21, '', 9, 0, NULL, NULL, NULL, '', '72', '1', 'category', 0, 1, 'menu', 0, 1, 0, 5, 0, '', NULL, 0, 'top', 'pav-menu-child', NULL, '', '', 0, 0, 0),
(22, '', 9, 0, NULL, NULL, NULL, '', '69', '1', 'category', 0, 1, 'menu', 0, 1, 0, 6, 0, '', NULL, 0, 'top', 'pav-menu-child', NULL, '', '', 0, 0, 0),
(23, '', 9, 0, NULL, NULL, NULL, '', '70', '1', 'category', 0, 1, 'menu', 0, 1, 0, 7, 0, '', NULL, 0, 'top', 'pav-menu-child', NULL, '', '', 0, 0, 0),
(24, '', 2, 0, NULL, NULL, NULL, '', '', '1', 'html', 1, 1, 'menu', 0, 1, 0, 3, 0, '', NULL, 0, 'top', 'pav-menu-child', NULL, '&lt;div class=&quot;pav-menu-video&quot;&gt;&lt;iframe allowfullscreen=&quot;&quot; frameborder=&quot;0&quot; height=&quot;157&quot; src=&quot;http://www.youtube.com/embed/NBuLeA7nNFk&quot; width=&quot;279&quot;&gt;&lt;/iframe&gt;\r\n&lt;h3&gt;Lorem ipsum dolor sit&lt;/h3&gt;\r\n\r\n&lt;p&gt;Dorem ipsum dolor sit amet consectetur adipiscing elit congue sit amet erat roin tincidunt vehicula lorem in adipiscing urna iaculis vel.&lt;/p&gt;\r\n&lt;/div&gt;\r\n', '', 0, 0, 0),
(25, '', 3, 0, NULL, NULL, NULL, '', '79', '1', 'category', 0, 1, 'menu', 0, 1, 0, 2, 0, '', NULL, 0, 'top', '', NULL, '', '', 0, 0, 0),
(26, '', 3, 0, NULL, NULL, NULL, '', '74', '1', 'category', 0, 1, 'menu', 0, 1, 0, 3, 0, '', NULL, 0, 'top', '', NULL, '', '', 0, 0, 0),
(27, '', 3, 0, NULL, NULL, NULL, '', '73', '1', 'category', 0, 1, 'menu', 0, 1, 0, 4, 0, '', NULL, 0, 'top', '', NULL, '', '', 0, 0, 0),
(28, '', 3, 0, NULL, NULL, NULL, '', '80', '1', 'category', 0, 1, 'menu', 0, 1, 0, 5, 0, '', NULL, 0, 'top', '', NULL, '', '', 0, 0, 0),
(29, '', 3, 0, NULL, NULL, NULL, '', '', '1', 'category', 0, 1, 'menu', 0, 1, 0, 6, 0, '', NULL, 0, 'top', '', NULL, '', '', 0, 0, 0),
(30, '', 3, 0, NULL, NULL, NULL, '', '46', '1', 'category', 0, 1, 'menu', 0, 1, 0, 7, 0, '', NULL, 0, 'top', '', NULL, '', '', 0, 0, 0),
(31, '', 3, 0, NULL, NULL, NULL, '', '75', '1', 'category', 0, 1, 'menu', 0, 1, 0, 8, 0, '', NULL, 0, 'top', '', NULL, '', '', 0, 0, 0),
(32, '', 3, 0, NULL, NULL, NULL, '', '78', '1', 'category', 0, 1, 'menu', 0, 1, 0, 9, 0, '', NULL, 0, 'top', '', NULL, '', '', 0, 0, 0),
(33, '', 3, 0, NULL, NULL, NULL, '', '77', '1', 'category', 0, 1, 'menu', 0, 1, 0, 10, 0, '', NULL, 0, 'top', '', NULL, '', '', 0, 0, 0),
(34, '', 3, 0, NULL, NULL, NULL, '', '77', '1', 'category', 0, 1, 'menu', 0, 1, 0, 11, 0, '', NULL, 0, 'top', '', NULL, '', '', 0, 0, 0),
(35, '', 3, 0, NULL, NULL, NULL, '', '45', '1', 'category', 0, 1, 'menu', 0, 1, 0, 12, 0, '', NULL, 0, 'top', '', NULL, '', '', 0, 0, 0),
(36, '', 3, 0, NULL, NULL, NULL, '', '45', '1', 'category', 0, 1, 'menu', 0, 1, 0, 13, 0, '', NULL, 0, 'top', '', NULL, '', '', 0, 0, 0),
(37, '', 1, 0, NULL, NULL, NULL, '', '25', '1', 'category', 0, 1, 'menu', 0, 1, 0, 6, 0, '', NULL, 0, 'top', '', NULL, '', '', 0, 0, 0),
(38, '', 1, 0, NULL, NULL, NULL, '', '57', '1', 'category', 0, 1, 'menu', 0, 1, 0, 7, 0, '', NULL, 0, 'top', '', NULL, '', '', 0, 0, 0),
(40, '', 1, 0, NULL, NULL, NULL, '', '', '1', 'url', 0, 1, 'menu', 0, 1, 0, 1, 0, '?route=common/home', NULL, 0, 'top', 'home', NULL, '', '', 0, 0, 0);

-- --------------------------------------------------------

--
-- 表的结构 `yk_megamenu_description`
--

CREATE TABLE IF NOT EXISTS `yk_megamenu_description` (
  `megamenu_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`megamenu_id`,`language_id`),
  KEY `name` (`title`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `yk_megamenu_description`
--

INSERT INTO `yk_megamenu_description` (`megamenu_id`, `language_id`, `title`, `description`) VALUES
(4, 2, 'Watches', ''),
(4, 1, 'Watches', ''),
(5, 2, 'Books', ''),
(5, 1, 'Books', ''),
(37, 2, 'Watches', ''),
(7, 2, 'Office', ''),
(7, 1, 'Office', ''),
(10, 2, 'Duis tempor', ''),
(10, 1, 'Duis tempor', ''),
(11, 2, 'Pellentesque eget', ''),
(11, 1, 'Pellentesque eget ', ''),
(12, 2, 'Nam nunc ante', ''),
(12, 1, 'Nam nunc ante', ''),
(13, 2, 'Condimentum eu', ''),
(13, 1, 'Condimentum eu', ''),
(14, 2, 'Lehicula lorem', ''),
(14, 1, 'Lehicula lorem', ''),
(15, 2, 'Integer semper', ''),
(15, 1, 'Integer semper', ''),
(16, 2, 'Sollicitudin lacus', ''),
(16, 1, 'Sollicitudin lacus', ''),
(17, 2, 'Nam ipsum ', ''),
(17, 1, 'Nam ipsum ', ''),
(18, 2, 'Curabitur turpis ', ''),
(18, 1, 'Curabitur turpis ', ''),
(19, 1, 'Molestie eu mattis ', ''),
(19, 2, 'Molestie eu mattis ', ''),
(20, 1, 'Suspendisse eu ', ''),
(20, 2, 'Suspendisse eu ', ''),
(21, 1, 'Nunc imperdiet ', ''),
(21, 2, 'Nunc imperdiet ', ''),
(22, 1, 'Mauris mattis', ''),
(22, 2, 'Mauris mattis', ''),
(23, 1, 'Lacus sed iaculis ', ''),
(23, 2, 'Lacus sed iaculis ', ''),
(24, 2, 'Lorem ipsum dolor sit ', ''),
(24, 1, 'Lorem ipsum dolor sit ', ''),
(37, 1, 'Watches', ''),
(25, 1, 'Aliquam', ''),
(25, 2, 'Aliquam', ''),
(26, 1, 'Claritas', ''),
(26, 2, 'Claritas', ''),
(27, 2, 'Consectetuer', ''),
(27, 1, 'Consectetuer', ''),
(28, 1, 'Hendrerit', ''),
(28, 2, 'Hendrerit', ''),
(29, 1, 'Litterarum', ''),
(29, 2, 'Litterarum', ''),
(30, 1, 'Macs', ''),
(30, 2, 'Macs', ''),
(31, 1, 'Sollemnes', ''),
(31, 2, 'Sollemnes', ''),
(32, 1, 'Tempor', ''),
(32, 2, 'Tempor', ''),
(33, 1, 'Vulputate', ''),
(33, 2, 'Vulputate', ''),
(34, 1, 'Vulputate', ''),
(34, 2, 'Vulputate', ''),
(35, 1, 'Windows', ''),
(35, 2, 'Windows', ''),
(36, 1, 'Windows', ''),
(36, 2, 'Windows', ''),
(38, 1, 'Tablets', ''),
(38, 2, 'Tablets', ''),
(40, 2, 'Home', ''),
(40, 1, 'Home', '');

-- --------------------------------------------------------

--
-- 表的结构 `yk_news`
--

CREATE TABLE IF NOT EXISTS `yk_news` (
  `news_id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` smallint(4) DEFAULT '0',
  `user_id` int(11) DEFAULT NULL,
  `title` varchar(128) DEFAULT NULL,
  `subtitle` varchar(256) NOT NULL,
  `text` text,
  `status` tinyint(4) DEFAULT '0',
  `is_top` tinyint(4) NOT NULL DEFAULT '0',
  `from` varchar(512) DEFAULT NULL,
  `sort_order` smallint(6) NOT NULL DEFAULT '0',
  `date_added` datetime DEFAULT NULL,
  PRIMARY KEY (`news_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `yk_news`
--

INSERT INTO `yk_news` (`news_id`, `group_id`, `user_id`, `title`, `subtitle`, `text`, `status`, `is_top`, `from`, `sort_order`, `date_added`) VALUES
(2, 2, 1, '新闻测试数据标题', '新闻测试数据副本标题', '&lt;span style=&quot;font-family:Tahoma, Helvetica, Arial, 宋体, sans-serif;font-size:14px;line-height:30px;&quot;&gt;2015年5月初，美国数字地球公司拍摄的卫星照片显示越南非法建岛行为，在非法侵占我南沙岛礁上大规模填海造地。越南非法建岛激起了中方愤慨，我外交部发言人洪磊表示，中国要求有关国家立即停止一切侵犯中国主权和权益的言行。洪磊还揭露，越南非法建岛，共计侵占20多个岛礁，填海造地的同时还设立了机场、港池，甚至还有导弹阵地，中国外交部严厉指责越南非法建岛行为。&lt;/span&gt;', 1, 0, '腾讯新闻', 0, '2015-05-24 21:37:30'),
(3, 3, 1, '最新款式灭火器', '5.1日家用汽载灭火器全场5折', '&lt;span style=&quot;color:#CC0000;font-family:arial;font-size:13px;line-height:20.0200004577637px;background-color:#FFFFFF;&quot;&gt;齐齐哈尔&lt;/span&gt;&lt;span style=&quot;color:#333333;font-family:arial;font-size:13px;line-height:20.0200004577637px;background-color:#FFFFFF;&quot;&gt;警方与绑架案犯发生激烈&lt;/span&gt;&lt;span style=&quot;color:#CC0000;font-family:arial;font-size:13px;line-height:20.0200004577637px;background-color:#FFFFFF;&quot;&gt;枪战&lt;/span&gt;&lt;span style=&quot;color:#333333;font-family:arial;font-size:13px;line-height:20.0200004577637px;background-color:#FFFFFF;&quot;&gt;&amp;nbsp;一民警头部中弹&lt;/span&gt;', 1, 0, '消防e站', 2, '0000-00-00 00:00:00'),
(4, 1, 1, '新一代宝马7系官网曝光 6月10日首发', '新一代宝马7系官网曝光', '<p>车型代号G11的新一代宝马7系的官图和部分信息在宝马奥地利官网曝光，新车将在6月10日正式发布，10月上市销售。新一代7系在奥地利市场的起价为100445欧元(约合人民币69.2万元)。<img alt="" src="http://www.yuankong.com/image/data/demo/apple_logo.jpg" />12321312</p>', 0, 0, '新浪汽车', 0, '2015-06-10 05:20:56');

-- --------------------------------------------------------

--
-- 表的结构 `yk_news_group`
--

CREATE TABLE IF NOT EXISTS `yk_news_group` (
  `group_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `show` tinyint(4) NOT NULL DEFAULT '0',
  `sort_order` int(3) NOT NULL,
  PRIMARY KEY (`group_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- 转存表中的数据 `yk_news_group`
--

INSERT INTO `yk_news_group` (`group_id`, `name`, `show`, `sort_order`) VALUES
(1, '消防法规', 0, 1),
(2, '消防新闻', 0, 2),
(3, '官方公告', 0, 3),
(4, '消防知识', 0, 4),
(7, '管理培训', 0, 5);

-- --------------------------------------------------------

--
-- 表的结构 `yk_option`
--

CREATE TABLE IF NOT EXISTS `yk_option` (
  `option_id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(32) NOT NULL,
  `sort_order` int(3) NOT NULL,
  PRIMARY KEY (`option_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

--
-- 转存表中的数据 `yk_option`
--

INSERT INTO `yk_option` (`option_id`, `type`, `sort_order`) VALUES
(1, 'radio', 2),
(2, 'checkbox', 3),
(4, 'text', 4),
(5, 'select', 1),
(6, 'textarea', 5),
(7, 'file', 6),
(8, 'date', 7),
(9, 'time', 8),
(10, 'datetime', 9),
(11, 'select', 1),
(12, 'date', 1);

-- --------------------------------------------------------

--
-- 表的结构 `yk_option_description`
--

CREATE TABLE IF NOT EXISTS `yk_option_description` (
  `option_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  PRIMARY KEY (`option_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `yk_option_description`
--

INSERT INTO `yk_option_description` (`option_id`, `language_id`, `name`) VALUES
(1, 2, 'Radio'),
(2, 2, 'Checkbox'),
(4, 2, 'Text'),
(6, 2, 'Textarea'),
(8, 2, 'Date'),
(7, 2, 'File'),
(5, 2, 'Select'),
(9, 2, 'Time'),
(10, 2, 'Date &amp; Time'),
(12, 2, 'Delivery Date'),
(11, 2, 'Size');

-- --------------------------------------------------------

--
-- 表的结构 `yk_option_value`
--

CREATE TABLE IF NOT EXISTS `yk_option_value` (
  `option_value_id` int(11) NOT NULL AUTO_INCREMENT,
  `option_id` int(11) NOT NULL,
  `image` varchar(255) NOT NULL,
  `sort_order` int(3) NOT NULL,
  PRIMARY KEY (`option_value_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=49 ;

--
-- 转存表中的数据 `yk_option_value`
--

INSERT INTO `yk_option_value` (`option_value_id`, `option_id`, `image`, `sort_order`) VALUES
(43, 1, '', 3),
(32, 1, '', 1),
(45, 2, '', 4),
(44, 2, '', 3),
(42, 5, '', 4),
(41, 5, '', 3),
(39, 5, '', 1),
(40, 5, '', 2),
(31, 1, '', 2),
(23, 2, '', 1),
(24, 2, '', 2),
(46, 11, '', 1),
(47, 11, '', 2),
(48, 11, '', 3);

-- --------------------------------------------------------

--
-- 表的结构 `yk_option_value_description`
--

CREATE TABLE IF NOT EXISTS `yk_option_value_description` (
  `option_value_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `option_id` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  PRIMARY KEY (`option_value_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `yk_option_value_description`
--

INSERT INTO `yk_option_value_description` (`option_value_id`, `language_id`, `option_id`, `name`) VALUES
(43, 2, 1, 'Large'),
(32, 2, 1, 'Small'),
(45, 2, 2, 'Checkbox 4'),
(44, 2, 2, 'Checkbox 3'),
(31, 2, 1, 'Medium'),
(42, 2, 5, 'Yellow'),
(41, 2, 5, 'Green'),
(39, 2, 5, 'Red'),
(40, 2, 5, 'Blue'),
(23, 2, 2, 'Checkbox 1'),
(24, 2, 2, 'Checkbox 2'),
(48, 2, 11, 'Large'),
(47, 2, 11, 'Medium'),
(46, 2, 11, 'Small');

-- --------------------------------------------------------

--
-- 表的结构 `yk_order`
--

CREATE TABLE IF NOT EXISTS `yk_order` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_no` int(11) NOT NULL DEFAULT '0',
  `invoice_prefix` varchar(26) NOT NULL,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `store_name` varchar(64) NOT NULL,
  `store_url` varchar(255) NOT NULL,
  `customer_id` int(11) NOT NULL DEFAULT '0',
  `customer_group_id` int(11) NOT NULL DEFAULT '0',
  `firstname` varchar(32) NOT NULL,
  `lastname` varchar(32) NOT NULL,
  `email` varchar(96) NOT NULL,
  `telephone` varchar(32) NOT NULL,
  `fax` varchar(32) NOT NULL,
  `payment_firstname` varchar(32) NOT NULL,
  `payment_lastname` varchar(32) NOT NULL,
  `payment_company` varchar(32) NOT NULL,
  `payment_company_id` varchar(32) NOT NULL,
  `payment_tax_id` varchar(32) NOT NULL,
  `payment_address_1` varchar(128) NOT NULL,
  `payment_address_2` varchar(128) NOT NULL,
  `payment_city` varchar(128) NOT NULL,
  `payment_postcode` varchar(10) NOT NULL,
  `payment_country` varchar(128) NOT NULL,
  `payment_country_id` int(11) NOT NULL,
  `payment_zone` varchar(128) NOT NULL,
  `payment_zone_id` int(11) NOT NULL,
  `payment_address_format` text NOT NULL,
  `payment_method` varchar(128) NOT NULL,
  `payment_code` varchar(128) NOT NULL,
  `shipping_firstname` varchar(32) NOT NULL,
  `shipping_lastname` varchar(32) NOT NULL,
  `shipping_company` varchar(32) NOT NULL,
  `shipping_address_1` varchar(128) NOT NULL,
  `shipping_address_2` varchar(128) NOT NULL,
  `shipping_city` varchar(128) NOT NULL,
  `shipping_postcode` varchar(10) NOT NULL,
  `shipping_country` varchar(128) NOT NULL,
  `shipping_country_id` int(11) NOT NULL,
  `shipping_zone` varchar(128) NOT NULL,
  `shipping_zone_id` int(11) NOT NULL,
  `shipping_address_format` text NOT NULL,
  `shipping_method` varchar(128) NOT NULL,
  `shipping_code` varchar(128) NOT NULL,
  `comment` text NOT NULL,
  `total` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `order_status_id` int(11) NOT NULL DEFAULT '0',
  `affiliate_id` int(11) NOT NULL,
  `commission` decimal(15,4) NOT NULL,
  `language_id` int(11) NOT NULL,
  `currency_id` int(11) NOT NULL,
  `currency_code` varchar(3) NOT NULL,
  `currency_value` decimal(15,8) NOT NULL DEFAULT '1.00000000',
  `ip` varchar(40) NOT NULL,
  `forwarded_ip` varchar(40) NOT NULL,
  `user_agent` varchar(255) NOT NULL,
  `accept_language` varchar(255) NOT NULL,
  `date_added` datetime NOT NULL,
  `date_modified` datetime NOT NULL,
  PRIMARY KEY (`order_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `yk_order_download`
--

CREATE TABLE IF NOT EXISTS `yk_order_download` (
  `order_download_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `order_product_id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `filename` varchar(128) NOT NULL,
  `mask` varchar(128) NOT NULL,
  `remaining` int(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`order_download_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `yk_order_field`
--

CREATE TABLE IF NOT EXISTS `yk_order_field` (
  `order_id` int(11) NOT NULL,
  `custom_field_id` int(11) NOT NULL,
  `custom_field_value_id` int(11) NOT NULL,
  `name` int(128) NOT NULL,
  `value` text NOT NULL,
  `sort_order` int(3) NOT NULL,
  PRIMARY KEY (`order_id`,`custom_field_id`,`custom_field_value_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `yk_order_fraud`
--

CREATE TABLE IF NOT EXISTS `yk_order_fraud` (
  `order_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `country_match` varchar(3) NOT NULL,
  `country_code` varchar(2) NOT NULL,
  `high_risk_country` varchar(3) NOT NULL,
  `distance` int(11) NOT NULL,
  `ip_region` varchar(255) NOT NULL,
  `ip_city` varchar(255) NOT NULL,
  `ip_latitude` decimal(10,6) NOT NULL,
  `ip_longitude` decimal(10,6) NOT NULL,
  `ip_isp` varchar(255) NOT NULL,
  `ip_org` varchar(255) NOT NULL,
  `ip_asnum` int(11) NOT NULL,
  `ip_user_type` varchar(255) NOT NULL,
  `ip_country_confidence` varchar(3) NOT NULL,
  `ip_region_confidence` varchar(3) NOT NULL,
  `ip_city_confidence` varchar(3) NOT NULL,
  `ip_postal_confidence` varchar(3) NOT NULL,
  `ip_postal_code` varchar(10) NOT NULL,
  `ip_accuracy_radius` int(11) NOT NULL,
  `ip_net_speed_cell` varchar(255) NOT NULL,
  `ip_metro_code` int(3) NOT NULL,
  `ip_area_code` int(3) NOT NULL,
  `ip_time_zone` varchar(255) NOT NULL,
  `ip_region_name` varchar(255) NOT NULL,
  `ip_domain` varchar(255) NOT NULL,
  `ip_country_name` varchar(255) NOT NULL,
  `ip_continent_code` varchar(2) NOT NULL,
  `ip_corporate_proxy` varchar(3) NOT NULL,
  `anonymous_proxy` varchar(3) NOT NULL,
  `proxy_score` int(3) NOT NULL,
  `is_trans_proxy` varchar(3) NOT NULL,
  `free_mail` varchar(3) NOT NULL,
  `carder_email` varchar(3) NOT NULL,
  `high_risk_username` varchar(3) NOT NULL,
  `high_risk_password` varchar(3) NOT NULL,
  `bin_match` varchar(10) NOT NULL,
  `bin_country` varchar(2) NOT NULL,
  `bin_name_match` varchar(3) NOT NULL,
  `bin_name` varchar(255) NOT NULL,
  `bin_phone_match` varchar(3) NOT NULL,
  `bin_phone` varchar(32) NOT NULL,
  `customer_phone_in_billing_location` varchar(8) NOT NULL,
  `ship_forward` varchar(3) NOT NULL,
  `city_postal_match` varchar(3) NOT NULL,
  `ship_city_postal_match` varchar(3) NOT NULL,
  `score` decimal(10,5) NOT NULL,
  `explanation` text NOT NULL,
  `risk_score` decimal(10,5) NOT NULL,
  `queries_remaining` int(11) NOT NULL,
  `maxmind_id` varchar(8) NOT NULL,
  `error` text NOT NULL,
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`order_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `yk_order_history`
--

CREATE TABLE IF NOT EXISTS `yk_order_history` (
  `order_history_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `order_status_id` int(5) NOT NULL,
  `notify` tinyint(1) NOT NULL DEFAULT '0',
  `comment` text NOT NULL,
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`order_history_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `yk_order_option`
--

CREATE TABLE IF NOT EXISTS `yk_order_option` (
  `order_option_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `order_product_id` int(11) NOT NULL,
  `product_option_id` int(11) NOT NULL,
  `product_option_value_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `value` text NOT NULL,
  `type` varchar(32) NOT NULL,
  PRIMARY KEY (`order_option_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `yk_order_product`
--

CREATE TABLE IF NOT EXISTS `yk_order_product` (
  `order_product_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `model` varchar(64) NOT NULL,
  `quantity` int(4) NOT NULL,
  `price` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `total` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `tax` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `reward` int(8) NOT NULL,
  PRIMARY KEY (`order_product_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `yk_order_status`
--

CREATE TABLE IF NOT EXISTS `yk_order_status` (
  `order_status_id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  PRIMARY KEY (`order_status_id`,`language_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=17 ;

--
-- 转存表中的数据 `yk_order_status`
--

INSERT INTO `yk_order_status` (`order_status_id`, `language_id`, `name`) VALUES
(2, 2, '处理中'),
(3, 2, '已发货'),
(7, 2, '已取消'),
(5, 2, '已完成'),
(11, 2, '已退款'),
(1, 2, '待处理'),
(15, 2, '已处理'),
(10, 2, '付款失败');

-- --------------------------------------------------------

--
-- 表的结构 `yk_order_total`
--

CREATE TABLE IF NOT EXISTS `yk_order_total` (
  `order_total_id` int(10) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `code` varchar(32) NOT NULL,
  `title` varchar(255) NOT NULL,
  `text` varchar(255) NOT NULL,
  `value` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `sort_order` int(3) NOT NULL,
  PRIMARY KEY (`order_total_id`),
  KEY `idx_orders_total_orders_id` (`order_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `yk_order_voucher`
--

CREATE TABLE IF NOT EXISTS `yk_order_voucher` (
  `order_voucher_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `voucher_id` int(11) NOT NULL,
  `description` varchar(255) NOT NULL,
  `code` varchar(10) NOT NULL,
  `from_name` varchar(64) NOT NULL,
  `from_email` varchar(96) NOT NULL,
  `to_name` varchar(64) NOT NULL,
  `to_email` varchar(96) NOT NULL,
  `voucher_theme_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `amount` decimal(15,4) NOT NULL,
  PRIMARY KEY (`order_voucher_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `yk_product`
--

CREATE TABLE IF NOT EXISTS `yk_product` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `model` varchar(64) NOT NULL,
  `sku` varchar(64) NOT NULL,
  `upc` varchar(12) NOT NULL,
  `ean` varchar(14) NOT NULL,
  `jan` varchar(13) NOT NULL,
  `isbn` varchar(13) NOT NULL,
  `mpn` varchar(64) NOT NULL,
  `location` varchar(128) NOT NULL,
  `quantity` int(4) NOT NULL DEFAULT '0',
  `stock_status_id` int(11) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `manufacturer_id` int(11) NOT NULL,
  `shipping` tinyint(1) NOT NULL DEFAULT '1',
  `price` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `points` int(8) NOT NULL DEFAULT '0',
  `tax_class_id` int(11) NOT NULL,
  `date_available` date NOT NULL,
  `weight` decimal(15,8) NOT NULL DEFAULT '0.00000000',
  `weight_class_id` int(11) NOT NULL DEFAULT '0',
  `length` decimal(15,8) NOT NULL DEFAULT '0.00000000',
  `width` decimal(15,8) NOT NULL DEFAULT '0.00000000',
  `height` decimal(15,8) NOT NULL DEFAULT '0.00000000',
  `length_class_id` int(11) NOT NULL DEFAULT '0',
  `subtract` tinyint(1) NOT NULL DEFAULT '1',
  `minimum` int(11) NOT NULL DEFAULT '1',
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `viewed` int(5) NOT NULL DEFAULT '0',
  PRIMARY KEY (`product_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=56 ;

--
-- 转存表中的数据 `yk_product`
--

INSERT INTO `yk_product` (`product_id`, `model`, `sku`, `upc`, `ean`, `jan`, `isbn`, `mpn`, `location`, `quantity`, `stock_status_id`, `image`, `manufacturer_id`, `shipping`, `price`, `points`, `tax_class_id`, `date_available`, `weight`, `weight_class_id`, `length`, `width`, `height`, `length_class_id`, `subtract`, `minimum`, `sort_order`, `status`, `date_added`, `date_modified`, `viewed`) VALUES
(50, '132143', '', '', '', '', '', '', '', 1000, 7, 'data/yuankong/shoppic1.jpg', 0, 1, '126.0000', 0, 0, '2015-06-15', '0.00000000', 1, '0.00000000', '0.00000000', '0.00000000', 1, 0, 1, 1, 1, '2015-06-16 14:52:22', '2015-06-16 16:23:34', 0),
(51, 'ae123213', '', '', '', '', '', '', '', 1000, 7, 'data/yuankong/shoppic2.jpg', 0, 1, '123.0000', 0, 0, '2015-06-15', '0.00000000', 1, '0.00000000', '0.00000000', '0.00000000', 1, 0, 1, 1, 1, '2015-06-16 09:00:49', '0000-00-00 00:00:00', 0),
(52, '123123', '', '', '', '', '', '', '', 1000, 7, 'data/yuankong/shoppic4.jpg', 0, 1, '123.0000', 0, 0, '2015-06-15', '0.00000000', 1, '0.00000000', '0.00000000', '0.00000000', 1, 0, 1, 1, 1, '2015-06-16 16:29:23', '0000-00-00 00:00:00', 0),
(53, '231414', '', '', '', '', '', '', '', 1000, 7, 'data/yuankong/shoppic3.jpg', 0, 1, '125.0000', 0, 0, '2015-06-15', '0.00000000', 1, '0.00000000', '0.00000000', '0.00000000', 1, 0, 1, 1, 1, '2015-06-16 09:02:14', '0000-00-00 00:00:00', 0),
(54, '2144232', '', '', '', '', '', '', '', 1000, 7, 'data/yuankong/shoppic5.jpg', 0, 1, '128.0000', 0, 0, '2015-06-15', '0.00000000', 1, '0.00000000', '0.00000000', '0.00000000', 1, 0, 1, 1, 1, '2015-06-16 09:03:38', '0000-00-00 00:00:00', 0),
(55, 'xf1325324', '', '', '', '', '', '', '', 1000, 7, 'data/yuankong/shoppic6.jpg', 0, 1, '158.0000', 0, 0, '2015-06-15', '0.00000000', 1, '0.00000000', '0.00000000', '0.00000000', 1, 0, 1, 1, 1, '2015-06-16 09:05:42', '0000-00-00 00:00:00', 0);

-- --------------------------------------------------------

--
-- 表的结构 `yk_product_attribute`
--

CREATE TABLE IF NOT EXISTS `yk_product_attribute` (
  `product_id` int(11) NOT NULL,
  `attribute_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `text` text NOT NULL,
  PRIMARY KEY (`product_id`,`attribute_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `yk_product_description`
--

CREATE TABLE IF NOT EXISTS `yk_product_description` (
  `product_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `subtitle` varchar(255) DEFAULT NULL,
  `description` text NOT NULL,
  `meta_description` varchar(255) NOT NULL,
  `meta_keyword` varchar(255) NOT NULL,
  `tag` text NOT NULL,
  PRIMARY KEY (`product_id`,`language_id`),
  KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `yk_product_description`
--

INSERT INTO `yk_product_description` (`product_id`, `language_id`, `name`, `subtitle`, `description`, `meta_description`, `meta_keyword`, `tag`) VALUES
(50, 2, '嵌入式插电安全出口疏散指示灯', NULL, '&lt;div class=&quot;rel z-i&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; position: relative; z-index: 1;&quot;&gt;\r\n&lt;p style=&quot;margin: 0px; padding: 0px; border: 0px;&quot;&gt;&lt;a class=&quot;db rel&quot; href=&quot;#&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; color: rgb(136, 136, 136); text-decoration: none; display: block; position: relative; width: 234px; height: 184px; overflow: hidden; font-size: 12px; font-family: ''microsoft yahei''; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 25px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);&quot;&gt;全场5折起售，10件更优惠&lt;/a&gt;&lt;/p&gt;\r\n&lt;/div&gt;\r\n', '', '', ''),
(51, 2, '消防应急照明灯具', '消防应急照明灯具', '&lt;p&gt;消防应急照明灯具&lt;/p&gt;', '', '', ''),
(52, 2, '灭火器箱', NULL, '', '', '', ''),
(1, 2, '消防应急照明灯具', '', '', '', '', ''),
(53, 2, '源控消防水带', '源控消防水带', '&lt;p&gt;源控消防水带&lt;/p&gt;', '源控消防水带', '', ''),
(54, 2, '源控灭火器', '源控灭火器', '&lt;p&gt;源控灭火器&lt;/p&gt;', '源控灭火器', '', ''),
(55, 2, '源控消防泵', '源控消防泵 717大促 77折', '&lt;p&gt;sadsada&lt;/p&gt;', '', '', '');

-- --------------------------------------------------------

--
-- 表的结构 `yk_product_discount`
--

CREATE TABLE IF NOT EXISTS `yk_product_discount` (
  `product_discount_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `customer_group_id` int(11) NOT NULL,
  `quantity` int(4) NOT NULL DEFAULT '0',
  `priority` int(5) NOT NULL DEFAULT '1',
  `price` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `date_start` date NOT NULL DEFAULT '0000-00-00',
  `date_end` date NOT NULL DEFAULT '0000-00-00',
  PRIMARY KEY (`product_discount_id`),
  KEY `product_id` (`product_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=441 ;

-- --------------------------------------------------------

--
-- 表的结构 `yk_product_filter`
--

CREATE TABLE IF NOT EXISTS `yk_product_filter` (
  `product_id` int(11) NOT NULL,
  `filter_id` int(11) NOT NULL,
  PRIMARY KEY (`product_id`,`filter_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `yk_product_image`
--

CREATE TABLE IF NOT EXISTS `yk_product_image` (
  `product_image_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `sort_order` int(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`product_image_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2354 ;

--
-- 转存表中的数据 `yk_product_image`
--

INSERT INTO `yk_product_image` (`product_image_id`, `product_id`, `image`, `sort_order`) VALUES
(2353, 50, 'no_image.jpg', 0);

-- --------------------------------------------------------

--
-- 表的结构 `yk_product_option`
--

CREATE TABLE IF NOT EXISTS `yk_product_option` (
  `product_option_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `option_id` int(11) NOT NULL,
  `option_value` text NOT NULL,
  `required` tinyint(1) NOT NULL,
  PRIMARY KEY (`product_option_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=227 ;

-- --------------------------------------------------------

--
-- 表的结构 `yk_product_option_value`
--

CREATE TABLE IF NOT EXISTS `yk_product_option_value` (
  `product_option_value_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_option_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `option_id` int(11) NOT NULL,
  `option_value_id` int(11) NOT NULL,
  `quantity` int(3) NOT NULL,
  `subtract` tinyint(1) NOT NULL,
  `price` decimal(15,4) NOT NULL,
  `price_prefix` varchar(1) NOT NULL,
  `points` int(8) NOT NULL,
  `points_prefix` varchar(1) NOT NULL,
  `weight` decimal(15,8) NOT NULL,
  `weight_prefix` varchar(1) NOT NULL,
  PRIMARY KEY (`product_option_value_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=17 ;

-- --------------------------------------------------------

--
-- 表的结构 `yk_product_related`
--

CREATE TABLE IF NOT EXISTS `yk_product_related` (
  `product_id` int(11) NOT NULL,
  `related_id` int(11) NOT NULL,
  PRIMARY KEY (`product_id`,`related_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `yk_product_reward`
--

CREATE TABLE IF NOT EXISTS `yk_product_reward` (
  `product_reward_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL DEFAULT '0',
  `customer_group_id` int(11) NOT NULL DEFAULT '0',
  `points` int(8) NOT NULL DEFAULT '0',
  PRIMARY KEY (`product_reward_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=546 ;

-- --------------------------------------------------------

--
-- 表的结构 `yk_product_special`
--

CREATE TABLE IF NOT EXISTS `yk_product_special` (
  `product_special_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `customer_group_id` int(11) NOT NULL,
  `priority` int(5) NOT NULL DEFAULT '1',
  `price` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `date_start` date NOT NULL DEFAULT '0000-00-00',
  `date_end` date NOT NULL DEFAULT '0000-00-00',
  PRIMARY KEY (`product_special_id`),
  KEY `product_id` (`product_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=440 ;

-- --------------------------------------------------------

--
-- 表的结构 `yk_product_to_category`
--

CREATE TABLE IF NOT EXISTS `yk_product_to_category` (
  `product_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`product_id`,`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `yk_product_to_category`
--

INSERT INTO `yk_product_to_category` (`product_id`, `category_id`) VALUES
(1, 95),
(50, 95),
(50, 96),
(51, 95),
(52, 64),
(53, 63),
(54, 79),
(55, 65);

-- --------------------------------------------------------

--
-- 表的结构 `yk_product_to_download`
--

CREATE TABLE IF NOT EXISTS `yk_product_to_download` (
  `product_id` int(11) NOT NULL,
  `download_id` int(11) NOT NULL,
  PRIMARY KEY (`product_id`,`download_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `yk_product_to_layout`
--

CREATE TABLE IF NOT EXISTS `yk_product_to_layout` (
  `product_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  `layout_id` int(11) NOT NULL,
  PRIMARY KEY (`product_id`,`store_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `yk_product_to_store`
--

CREATE TABLE IF NOT EXISTS `yk_product_to_store` (
  `product_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`product_id`,`store_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `yk_product_to_store`
--

INSERT INTO `yk_product_to_store` (`product_id`, `store_id`) VALUES
(1, 0),
(50, 0),
(51, 0),
(52, 0),
(53, 0),
(54, 0),
(55, 0);

-- --------------------------------------------------------

--
-- 表的结构 `yk_project`
--

CREATE TABLE IF NOT EXISTS `yk_project` (
  `project_id` int(11) NOT NULL AUTO_INCREMENT,
  `project_sn` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `group_id` smallint(6) NOT NULL DEFAULT '0',
  `group` char(4) COLLATE utf8_unicode_ci NOT NULL,
  `account` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `telephone` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `date_applied` datetime DEFAULT NULL,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `date_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`project_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=8 ;

--
-- 转存表中的数据 `yk_project`
--

INSERT INTO `yk_project` (`project_id`, `project_sn`, `group_id`, `group`, `account`, `telephone`, `status`, `date_applied`, `user_id`, `date_modified`) VALUES
(1, 'xf2015121501', 1, 'xfsj', 'sadsadsadsa', '15951997250', 1, '2015-05-27 09:28:30', 1, NULL),
(2, 'xf2015151301', 2, 'xfwb', 'dasdasdasdas', '15951117250', 2, '2015-05-27 19:28:30', 2, '2015-05-27 19:38:30'),
(3, 'xf2015128501', 3, 'xfjc', 'assdaq21212', '13351997250', 3, '2015-05-27 09:38:30', 2, '2015-06-03 20:57:39'),
(4, 'xf2015151301', 2, 'xfwb', 'dasdasdasdas', '15951117250', 2, '2015-05-27 19:48:30', 3, '2015-05-27 19:49:30'),
(5, 'xf2015058501', 4, 'xfgc', 'assdaq21212', '13351997250', 2, '2015-05-27 09:38:30', 2, '2015-05-27 19:49:30'),
(6, 'xf2015061301', 4, 'xfgc', '45dasdasdasdas', '18951117250', 3, '2015-05-27 19:48:30', 3, '2015-05-27 19:49:30'),
(7, 'xf2015151901', 2, 'xfwb', '879dasdasdasdas', '15991117250', 3, '2015-05-27 19:28:30', 2, '2015-05-27 19:38:30');

-- --------------------------------------------------------

--
-- 表的结构 `yk_project_group`
--

CREATE TABLE IF NOT EXISTS `yk_project_group` (
  `group_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `show` tinyint(4) NOT NULL DEFAULT '0',
  `sort_order` int(3) NOT NULL,
  PRIMARY KEY (`group_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- 转存表中的数据 `yk_project_group`
--

INSERT INTO `yk_project_group` (`group_id`, `name`, `show`, `sort_order`) VALUES
(1, '消防设计', 0, 1),
(2, '消防检测', 0, 2),
(3, '消防工程', 0, 3),
(4, '消防维保', 0, 4);

-- --------------------------------------------------------

--
-- 表的结构 `yk_return`
--

CREATE TABLE IF NOT EXISTS `yk_return` (
  `return_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `firstname` varchar(32) NOT NULL,
  `lastname` varchar(32) NOT NULL,
  `email` varchar(96) NOT NULL,
  `telephone` varchar(32) NOT NULL,
  `product` varchar(255) NOT NULL,
  `model` varchar(64) NOT NULL,
  `quantity` int(4) NOT NULL,
  `opened` tinyint(1) NOT NULL,
  `return_reason_id` int(11) NOT NULL,
  `return_action_id` int(11) NOT NULL,
  `return_status_id` int(11) NOT NULL,
  `comment` text,
  `date_ordered` date NOT NULL,
  `date_added` datetime NOT NULL,
  `date_modified` datetime NOT NULL,
  PRIMARY KEY (`return_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `yk_return_action`
--

CREATE TABLE IF NOT EXISTS `yk_return_action` (
  `return_action_id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`return_action_id`,`language_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- 转存表中的数据 `yk_return_action`
--

INSERT INTO `yk_return_action` (`return_action_id`, `language_id`, `name`) VALUES
(1, 2, '买错了'),
(2, 2, '支付问题'),
(3, 2, '我不想买了');

-- --------------------------------------------------------

--
-- 表的结构 `yk_return_history`
--

CREATE TABLE IF NOT EXISTS `yk_return_history` (
  `return_history_id` int(11) NOT NULL AUTO_INCREMENT,
  `return_id` int(11) NOT NULL,
  `return_status_id` int(11) NOT NULL,
  `notify` tinyint(1) NOT NULL,
  `comment` text NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`return_history_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `yk_return_reason`
--

CREATE TABLE IF NOT EXISTS `yk_return_reason` (
  `return_reason_id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(128) NOT NULL,
  PRIMARY KEY (`return_reason_id`,`language_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- 转存表中的数据 `yk_return_reason`
--

INSERT INTO `yk_return_reason` (`return_reason_id`, `language_id`, `name`) VALUES
(1, 2, 'Dead On Arrival'),
(2, 2, 'Received Wrong Item'),
(3, 2, 'Order Error'),
(4, 2, 'Faulty, please supply details'),
(5, 2, 'Other, please supply details');

-- --------------------------------------------------------

--
-- 表的结构 `yk_return_status`
--

CREATE TABLE IF NOT EXISTS `yk_return_status` (
  `return_status_id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(32) NOT NULL,
  PRIMARY KEY (`return_status_id`,`language_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- 转存表中的数据 `yk_return_status`
--

INSERT INTO `yk_return_status` (`return_status_id`, `language_id`, `name`) VALUES
(1, 2, '待处理'),
(3, 2, '已完成'),
(2, 2, '等候商品');

-- --------------------------------------------------------

--
-- 表的结构 `yk_review`
--

CREATE TABLE IF NOT EXISTS `yk_review` (
  `review_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `author` varchar(64) NOT NULL,
  `text` text NOT NULL,
  `rating` int(1) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`review_id`),
  KEY `product_id` (`product_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `yk_setting`
--

CREATE TABLE IF NOT EXISTS `yk_setting` (
  `setting_id` int(11) NOT NULL AUTO_INCREMENT,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `group` varchar(32) NOT NULL,
  `key` varchar(64) NOT NULL,
  `value` text NOT NULL,
  `serialized` tinyint(1) NOT NULL,
  PRIMARY KEY (`setting_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=892 ;

--
-- 转存表中的数据 `yk_setting`
--

INSERT INTO `yk_setting` (`setting_id`, `store_id`, `group`, `key`, `value`, `serialized`) VALUES
(1, 0, 'shipping', 'shipping_sort_order', '3', 0),
(2, 0, 'sub_total', 'sub_total_sort_order', '1', 0),
(3, 0, 'sub_total', 'sub_total_status', '1', 0),
(4, 0, 'tax', 'tax_status', '1', 0),
(5, 0, 'total', 'total_sort_order', '9', 0),
(6, 0, 'total', 'total_status', '1', 0),
(7, 0, 'tax', 'tax_sort_order', '5', 0),
(8, 0, 'free_checkout', 'free_checkout_sort_order', '1', 0),
(9, 0, 'cod', 'cod_sort_order', '5', 0),
(10, 0, 'cod', 'cod_total', '0.01', 0),
(11, 0, 'cod', 'cod_order_status_id', '1', 0),
(12, 0, 'cod', 'cod_geo_zone_id', '0', 0),
(13, 0, 'cod', 'cod_status', '1', 0),
(14, 0, 'shipping', 'shipping_status', '1', 0),
(15, 0, 'shipping', 'shipping_estimator', '1', 0),
(27, 0, 'coupon', 'coupon_sort_order', '4', 0),
(28, 0, 'coupon', 'coupon_status', '1', 0),
(34, 0, 'flat', 'flat_sort_order', '1', 0),
(35, 0, 'flat', 'flat_status', '1', 0),
(36, 0, 'flat', 'flat_geo_zone_id', '0', 0),
(37, 0, 'flat', 'flat_tax_class_id', '9', 0),
(882, 0, 'carousel', 'carousel_module', 'a:1:{i:0;a:8:{s:5:"limit";s:1:"5";s:6:"scroll";s:1:"3";s:5:"width";s:2:"80";s:6:"height";s:2:"80";s:9:"layout_id";s:1:"1";s:8:"position";s:14:"content_bottom";s:6:"status";s:1:"0";s:10:"sort_order";i:1;}}', 1),
(880, 0, 'featured', 'featured_product', '43,40,42,49,46,47,28', 0),
(881, 0, 'featured', 'featured_module', 'a:1:{i:0;a:7:{s:5:"limit";s:1:"6";s:11:"image_width";s:2:"80";s:12:"image_height";s:2:"80";s:9:"layout_id";s:1:"1";s:8:"position";s:11:"content_top";s:6:"status";s:1:"0";s:10:"sort_order";i:1;}}', 1),
(41, 0, 'flat', 'flat_cost', '5.00', 0),
(42, 0, 'credit', 'credit_sort_order', '7', 0),
(43, 0, 'credit', 'credit_status', '1', 0),
(53, 0, 'reward', 'reward_sort_order', '2', 0),
(54, 0, 'reward', 'reward_status', '1', 0),
(727, 0, 'category', 'category_module', 'a:2:{i:0;a:4:{s:9:"layout_id";s:1:"3";s:8:"position";s:11:"column_left";s:6:"status";s:1:"1";s:10:"sort_order";s:1:"1";}i:1;a:4:{s:9:"layout_id";s:1:"2";s:8:"position";s:11:"column_left";s:6:"status";s:1:"0";s:10:"sort_order";s:1:"1";}}', 1),
(658, 0, 'account', 'account_module', 'a:1:{i:0;a:4:{s:9:"layout_id";s:1:"6";s:8:"position";s:12:"column_right";s:6:"status";s:1:"0";s:10:"sort_order";s:1:"1";}}', 1),
(647, 0, 'config', 'config_seo_url', '0', 0),
(648, 0, 'config', 'config_file_extension_allowed', 'txt\r\npng\r\njpe\r\njpeg\r\njpg\r\ngif\r\nbmp\r\nico\r\ntiff\r\ntif\r\nsvg\r\nsvgz\r\nzip\r\nrar\r\nmsi\r\ncab\r\nmp3\r\nqt\r\nmov\r\npdf\r\npsd\r\nai\r\neps\r\nps\r\ndoc\r\nrtf\r\nxls\r\nppt\r\nodt\r\nods', 0),
(649, 0, 'config', 'config_file_mime_allowed', 'text/plain\r\nimage/png\r\nimage/jpeg\r\nimage/jpeg\r\nimage/jpeg\r\nimage/gif\r\nimage/bmp\r\nimage/vnd.microsoft.icon\r\nimage/tiff\r\nimage/tiff\r\nimage/svg+xml\r\nimage/svg+xml\r\napplication/zip\r\napplication/x-rar-compressed\r\napplication/x-msdownload\r\napplication/vnd.ms-cab-compressed\r\naudio/mpeg\r\nvideo/quicktime\r\nvideo/quicktime\r\napplication/pdf\r\nimage/vnd.adobe.photoshop\r\napplication/postscript\r\napplication/postscript\r\napplication/postscript\r\napplication/msword\r\napplication/rtf\r\napplication/vnd.ms-excel\r\napplication/vnd.ms-powerpoint\r\napplication/vnd.oasis.opendocument.text\r\napplication/vnd.oasis.opendocument.spreadsheet', 0),
(94, 0, 'voucher', 'voucher_sort_order', '8', 0),
(95, 0, 'voucher', 'voucher_status', '1', 0),
(103, 0, 'free_checkout', 'free_checkout_status', '1', 0),
(104, 0, 'free_checkout', 'free_checkout_order_status_id', '1', 0),
(646, 0, 'config', 'config_robots', 'abot\r\ndbot\r\nebot\r\nhbot\r\nkbot\r\nlbot\r\nmbot\r\nnbot\r\nobot\r\npbot\r\nrbot\r\nsbot\r\ntbot\r\nvbot\r\nybot\r\nzbot\r\nbot.\r\nbot/\r\n_bot\r\n.bot\r\n/bot\r\n-bot\r\n:bot\r\n(bot\r\ncrawl\r\nslurp\r\nspider\r\nseek\r\naccoona\r\nacoon\r\nadressendeutschland\r\nah-ha.com\r\nahoy\r\naltavista\r\nananzi\r\nanthill\r\nappie\r\narachnophilia\r\narale\r\naraneo\r\naranha\r\narchitext\r\naretha\r\narks\r\nasterias\r\natlocal\r\natn\r\natomz\r\naugurfind\r\nbackrub\r\nbannana_bot\r\nbaypup\r\nbdfetch\r\nbig brother\r\nbiglotron\r\nbjaaland\r\nblackwidow\r\nblaiz\r\nblog\r\nblo.\r\nbloodhound\r\nboitho\r\nbooch\r\nbradley\r\nbutterfly\r\ncalif\r\ncassandra\r\nccubee\r\ncfetch\r\ncharlotte\r\nchurl\r\ncienciaficcion\r\ncmc\r\ncollective\r\ncomagent\r\ncombine\r\ncomputingsite\r\ncsci\r\ncurl\r\ncusco\r\ndaumoa\r\ndeepindex\r\ndelorie\r\ndepspid\r\ndeweb\r\ndie blinde kuh\r\ndigger\r\nditto\r\ndmoz\r\ndocomo\r\ndownload express\r\ndtaagent\r\ndwcp\r\nebiness\r\nebingbong\r\ne-collector\r\nejupiter\r\nemacs-w3 search engine\r\nesther\r\nevliya celebi\r\nezresult\r\nfalcon\r\nfelix ide\r\nferret\r\nfetchrover\r\nfido\r\nfindlinks\r\nfireball\r\nfish search\r\nfouineur\r\nfunnelweb\r\ngazz\r\ngcreep\r\ngenieknows\r\ngetterroboplus\r\ngeturl\r\nglx\r\ngoforit\r\ngolem\r\ngrabber\r\ngrapnel\r\ngralon\r\ngriffon\r\ngromit\r\ngrub\r\ngulliver\r\nhamahakki\r\nharvest\r\nhavindex\r\nhelix\r\nheritrix\r\nhku www octopus\r\nhomerweb\r\nhtdig\r\nhtml index\r\nhtml_analyzer\r\nhtmlgobble\r\nhubater\r\nhyper-decontextualizer\r\nia_archiver\r\nibm_planetwide\r\nichiro\r\niconsurf\r\niltrovatore\r\nimage.kapsi.net\r\nimagelock\r\nincywincy\r\nindexer\r\ninfobee\r\ninformant\r\ningrid\r\ninktomisearch.com\r\ninspector web\r\nintelliagent\r\ninternet shinchakubin\r\nip3000\r\niron33\r\nisraeli-search\r\nivia\r\njack\r\njakarta\r\njavabee\r\njetbot\r\njumpstation\r\nkatipo\r\nkdd-explorer\r\nkilroy\r\nknowledge\r\nkototoi\r\nkretrieve\r\nlabelgrabber\r\nlachesis\r\nlarbin\r\nlegs\r\nlibwww\r\nlinkalarm\r\nlink validator\r\nlinkscan\r\nlockon\r\nlwp\r\nlycos\r\nmagpie\r\nmantraagent\r\nmapoftheinternet\r\nmarvin/\r\nmattie\r\nmediafox\r\nmediapartners\r\nmercator\r\nmerzscope\r\nmicrosoft url control\r\nminirank\r\nmiva\r\nmj12\r\nmnogosearch\r\nmoget\r\nmonster\r\nmoose\r\nmotor\r\nmultitext\r\nmuncher\r\nmuscatferret\r\nmwd.search\r\nmyweb\r\nnajdi\r\nnameprotect\r\nnationaldirectory\r\nnazilla\r\nncsa beta\r\nnec-meshexplorer\r\nnederland.zoek\r\nnetcarta webmap engine\r\nnetmechanic\r\nnetresearchserver\r\nnetscoop\r\nnewscan-online\r\nnhse\r\nnokia6682/\r\nnomad\r\nnoyona\r\nnutch\r\nnzexplorer\r\nobjectssearch\r\noccam\r\nomni\r\nopen text\r\nopenfind\r\nopenintelligencedata\r\norb search\r\nosis-project\r\npack rat\r\npageboy\r\npagebull\r\npage_verifier\r\npanscient\r\nparasite\r\npartnersite\r\npatric\r\npear.\r\npegasus\r\nperegrinator\r\npgp key agent\r\nphantom\r\nphpdig\r\npicosearch\r\npiltdownman\r\npimptrain\r\npinpoint\r\npioneer\r\npiranha\r\nplumtreewebaccessor\r\npogodak\r\npoirot\r\npompos\r\npoppelsdorf\r\npoppi\r\npopular iconoclast\r\npsycheclone\r\npublisher\r\npython\r\nrambler\r\nraven search\r\nroach\r\nroad runner\r\nroadhouse\r\nrobbie\r\nrobofox\r\nrobozilla\r\nrules\r\nsalty\r\nsbider\r\nscooter\r\nscoutjet\r\nscrubby\r\nsearch.\r\nsearchprocess\r\nsemanticdiscovery\r\nsenrigan\r\nsg-scout\r\nshai''hulud\r\nshark\r\nshopwiki\r\nsidewinder\r\nsift\r\nsilk\r\nsimmany\r\nsite searcher\r\nsite valet\r\nsitetech-rover\r\nskymob.com\r\nsleek\r\nsmartwit\r\nsna-\r\nsnappy\r\nsnooper\r\nsohu\r\nspeedfind\r\nsphere\r\nsphider\r\nspinner\r\nspyder\r\nsteeler/\r\nsuke\r\nsuntek\r\nsupersnooper\r\nsurfnomore\r\nsven\r\nsygol\r\nszukacz\r\ntach black widow\r\ntarantula\r\ntempleton\r\n/teoma\r\nt-h-u-n-d-e-r-s-t-o-n-e\r\ntheophrastus\r\ntitan\r\ntitin\r\ntkwww\r\ntoutatis\r\nt-rex\r\ntutorgig\r\ntwiceler\r\ntwisted\r\nucsd\r\nudmsearch\r\nurl check\r\nupdated\r\nvagabondo\r\nvalkyrie\r\nverticrawl\r\nvictoria\r\nvision-search\r\nvolcano\r\nvoyager/\r\nvoyager-hc\r\nw3c_validator\r\nw3m2\r\nw3mir\r\nwalker\r\nwallpaper\r\nwanderer\r\nwauuu\r\nwavefire\r\nweb core\r\nweb hopper\r\nweb wombat\r\nwebbandit\r\nwebcatcher\r\nwebcopy\r\nwebfoot\r\nweblayers\r\nweblinker\r\nweblog monitor\r\nwebmirror\r\nwebmonkey\r\nwebquest\r\nwebreaper\r\nwebsitepulse\r\nwebsnarf\r\nwebstolperer\r\nwebvac\r\nwebwalk\r\nwebwatch\r\nwebwombat\r\nwebzinger\r\nwhizbang\r\nwhowhere\r\nwild ferret\r\nworldlight\r\nwwwc\r\nwwwster\r\nxenu\r\nxget\r\nxift\r\nxirq\r\nyandex\r\nyanga\r\nyeti\r\nyodao\r\nzao\r\nzippp\r\nzyborg', 0),
(645, 0, 'config', 'config_shared', '0', 0),
(644, 0, 'config', 'config_secure', '0', 0),
(643, 0, 'config', 'config_fraud_status_id', '7', 0),
(642, 0, 'config', 'config_fraud_score', '', 0),
(641, 0, 'config', 'config_fraud_key', '', 0),
(640, 0, 'config', 'config_fraud_detection', '0', 0),
(639, 0, 'config', 'config_alert_emails', '', 0),
(638, 0, 'config', 'config_account_mail', '0', 0),
(637, 0, 'config', 'config_alert_mail', '0', 0),
(635, 0, 'config', 'config_smtp_port', '25', 0),
(636, 0, 'config', 'config_smtp_timeout', '5', 0),
(634, 0, 'config', 'config_smtp_password', '', 0),
(633, 0, 'config', 'config_smtp_username', '', 0),
(632, 0, 'config', 'config_smtp_host', '', 0),
(631, 0, 'config', 'config_mail_parameter', '', 0),
(630, 0, 'config', 'config_mail_protocol', 'mail', 0),
(629, 0, 'config', 'config_ftp_status', '0', 0),
(627, 0, 'config', 'config_ftp_password', '', 0),
(628, 0, 'config', 'config_ftp_root', '', 0),
(626, 0, 'config', 'config_ftp_username', '', 0),
(625, 0, 'config', 'config_ftp_port', '21', 0),
(624, 0, 'config', 'config_ftp_host', 'yuankong.com', 0),
(623, 0, 'config', 'config_image_cart_height', '47', 0),
(622, 0, 'config', 'config_image_cart_width', '47', 0),
(621, 0, 'config', 'config_image_wishlist_height', '47', 0),
(620, 0, 'config', 'config_image_wishlist_width', '47', 0),
(619, 0, 'config', 'config_image_compare_height', '90', 0),
(618, 0, 'config', 'config_image_compare_width', '90', 0),
(617, 0, 'config', 'config_image_related_height', '80', 0),
(616, 0, 'config', 'config_image_related_width', '80', 0),
(614, 0, 'config', 'config_image_additional_width', '74', 0),
(615, 0, 'config', 'config_image_additional_height', '74', 0),
(613, 0, 'config', 'config_image_product_height', '80', 0),
(612, 0, 'config', 'config_image_product_width', '80', 0),
(611, 0, 'config', 'config_image_popup_height', '500', 0),
(610, 0, 'config', 'config_image_popup_width', '500', 0),
(608, 0, 'config', 'config_image_thumb_width', '228', 0),
(609, 0, 'config', 'config_image_thumb_height', '228', 0),
(607, 0, 'config', 'config_image_category_height', '80', 0),
(606, 0, 'config', 'config_image_category_width', '80', 0),
(605, 0, 'config', 'config_icon', 'data/cart.png', 0),
(604, 0, 'config', 'config_logo', 'data/logo.png', 0),
(603, 0, 'config', 'config_return_status_id', '1', 0),
(602, 0, 'config', 'config_return_id', '0', 0),
(601, 0, 'config', 'config_commission', '5', 0),
(600, 0, 'config', 'config_affiliate_id', '4', 0),
(599, 0, 'config', 'config_stock_status_id', '7', 0),
(598, 0, 'config', 'config_stock_checkout', '0', 0),
(597, 0, 'config', 'config_stock_warning', '0', 0),
(596, 0, 'config', 'config_stock_display', '0', 0),
(595, 0, 'config', 'config_complete_status_id', '5', 0),
(594, 0, 'config', 'config_order_status_id', '1', 0),
(593, 0, 'config', 'config_invoice_prefix', 'INV-2015-00', 0),
(592, 0, 'config', 'config_order_edit', '100', 0),
(590, 0, 'config', 'config_guest_checkout', '1', 0),
(591, 0, 'config', 'config_checkout_id', '5', 0),
(589, 0, 'config', 'config_cart_weight', '1', 0),
(588, 0, 'config', 'config_account_id', '3', 0),
(587, 0, 'config', 'config_customer_price', '0', 0),
(586, 0, 'config', 'config_customer_group_display', 'a:1:{i:0;s:1:"1";}', 1),
(585, 0, 'config', 'config_customer_group_id', '1', 0),
(584, 0, 'config', 'config_customer_online', '0', 0),
(583, 0, 'config', 'config_tax_customer', 'shipping', 0),
(582, 0, 'config', 'config_tax_default', 'shipping', 0),
(581, 0, 'config', 'config_vat', '0', 0),
(580, 0, 'config', 'config_tax', '1', 0),
(574, 0, 'config', 'config_admin_limit', '20', 0),
(575, 0, 'config', 'config_product_count', '1', 0),
(576, 0, 'config', 'config_review_status', '1', 0),
(577, 0, 'config', 'config_download', '1', 0),
(578, 0, 'config', 'config_voucher_min', '1', 0),
(579, 0, 'config', 'config_voucher_max', '1000', 0),
(573, 0, 'config', 'config_catalog_limit', '15', 0),
(570, 0, 'config', 'config_currency_auto', '0', 0),
(571, 0, 'config', 'config_length_class_id', '1', 0),
(572, 0, 'config', 'config_weight_class_id', '1', 0),
(560, 0, 'config', 'config_fax', '', 0),
(561, 0, 'config', 'config_title', '消防器材_消防装备_消防公司_消防网上商城【消防E站官网】', 0),
(562, 0, 'config', 'config_meta_description', '苏州源控', 0),
(563, 0, 'config', 'config_template', 'yuankong', 0),
(564, 0, 'config', 'config_layout_id', '4', 0),
(565, 0, 'config', 'config_country_id', '44', 0),
(566, 0, 'config', 'config_zone_id', '700', 0),
(567, 0, 'config', 'config_language', 'cn', 0),
(568, 0, 'config', 'config_admin_language', 'cn', 0),
(569, 0, 'config', 'config_currency', 'CNY', 0),
(559, 0, 'config', 'config_telephone', '123456789', 0),
(558, 0, 'config', 'config_email', 'admin@yuankong.com', 0),
(557, 0, 'config', 'config_address', '苏州太仓', 0),
(556, 0, 'config', 'config_owner', '苏州源控', 0),
(555, 0, 'config', 'config_name', '源控智能', 0),
(872, 0, 'pavmegamenu', 'pavmegamenu_module', 'a:1:{i:0;a:4:{s:9:"layout_id";s:5:"99999";s:8:"position";s:8:"mainmenu";s:6:"status";s:1:"0";s:10:"sort_order";i:1;}}', 1),
(876, 0, 'yknews', 'yknews_module', 'a:1:{i:0;a:8:{s:9:"layout_id";s:1:"1";s:8:"position";s:9:"promotion";s:8:"group_id";s:1:"0";s:5:"title";s:10:"e站快报";s:5:"limit";s:1:"5";s:11:"first_class";s:3:"cff";s:6:"status";s:1:"1";s:10:"sort_order";i:3;}}', 1),
(875, 0, 'pavcontentslider', 'pavcontentslider_module', 'a:1:{i:0;a:12:{s:9:"layout_id";s:1:"1";s:8:"position";s:9:"promotion";s:6:"status";s:1:"1";s:10:"sort_order";i:2;s:9:"auto_play";s:1:"1";s:13:"text_interval";s:4:"8000";s:5:"width";s:3:"940";s:6:"height";s:3:"350";s:15:"image_navigator";s:1:"1";s:13:"navimg_weight";s:3:"177";s:13:"navimg_height";s:2:"97";s:12:"banner_image";a:3:{i:1;a:4:{s:5:"image";s:16:"data/banner1.jpg";s:4:"link";s:0:"";s:5:"title";a:1:{i:2;s:0:"";}s:11:"description";a:1:{i:2;s:0:"";}}i:2;a:4:{s:5:"image";s:16:"data/banner2.jpg";s:4:"link";s:0:"";s:5:"title";a:1:{i:2;s:0:"";}s:11:"description";a:1:{i:2;s:0:"";}}i:3;a:4:{s:5:"image";s:16:"data/banner3.jpg";s:4:"link";s:0:"";s:5:"title";a:1:{i:2;s:0:"";}s:11:"description";a:1:{i:2;s:0:"";}}}}}', 1),
(874, 0, 'ykproject', 'ykproject_module', 'a:1:{i:0;a:12:{s:9:"layout_id";s:1:"1";s:8:"position";s:9:"promotion";s:6:"status";s:1:"1";s:10:"sort_order";i:1;s:9:"auto_play";s:1:"0";s:13:"text_interval";s:4:"8000";s:5:"width";s:3:"940";s:6:"height";s:3:"350";s:15:"image_navigator";s:1:"0";s:13:"navimg_weight";s:3:"177";s:13:"navimg_height";s:2:"97";s:12:"banner_image";N;}}', 1),
(890, 0, 'pavcustom', 'pavcustom_module', 'a:4:{i:1;a:7:{s:12:"module_title";a:1:{i:2;s:12:"页底导航";}s:11:"description";a:1:{i:2;s:816:"&lt;div class=&quot;foot tc&quot;&gt;\r\n&lt;p class=&quot;lh30&quot;&gt;&lt;a href=&quot;#&quot;&gt;关于我们&lt;/a&gt; &lt;b&gt;|&lt;/b&gt; &lt;a href=&quot;#&quot;&gt;项目工程&lt;/a&gt; &lt;b&gt;|&lt;/b&gt; &lt;a href=&quot;#&quot;&gt;入驻消防e站&lt;/a&gt; &lt;b&gt;|&lt;/b&gt; &lt;a href=&quot;#&quot;&gt;诚聘英才&lt;/a&gt; &lt;b&gt;|&lt;/b&gt; &lt;a href=&quot;#&quot;&gt;联系我们&lt;/a&gt; &lt;b&gt;|&lt;/b&gt; &lt;a href=&quot;#&quot;&gt;网站地图&lt;/a&gt;&lt;/p&gt;\r\n\r\n&lt;p class=&quot;pt5 c8&quot;&gt;消防e站 版权所有Copyright ? 2015-2025 www.yk119.com.cn www.yk119.cn All rights reserved&lt;br /&gt;\r\n苏ICP备15012632号 组织机构代码证：320585000221760&lt;br /&gt;\r\n中国互联网协会信用评价中心网信认证 网信编码:1664391091&lt;/p&gt;\r\n&lt;/div&gt;\r\n";}s:9:"layout_id";s:5:"99999";s:8:"position";s:13:"footer_bottom";s:6:"status";s:1:"1";s:12:"module_class";s:0:"";s:10:"sort_order";i:1;}i:2;a:7:{s:12:"module_title";a:1:{i:2;s:12:"消防流程";}s:11:"description";a:1:{i:2;s:1409:"&lt;div class=&quot;rel htitle&quot;&gt;\r\n&lt;h3 class=&quot;lc-title&quot;&gt;消防流程&lt;/h3&gt;\r\n\r\n&lt;div class=&quot;line-r&quot;&gt;&amp;nbsp;&lt;/div&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;div class=&quot;ovh&quot;&gt;\r\n&lt;ul class=&quot;lc-ul fix&quot;&gt;\r\n	&lt;li class=&quot;lc-li&quot;&gt;&lt;a class=&quot;lc-lia&quot; href=&quot;#&quot;&gt;消防设计&lt;/a&gt;&lt;/li&gt;\r\n	&lt;li class=&quot;lc-li&quot;&gt;&lt;a class=&quot;lc-lia&quot; href=&quot;#&quot;&gt;消防施工&lt;/a&gt;&lt;/li&gt;\r\n	&lt;li class=&quot;lc-li&quot;&gt;&lt;a class=&quot;lc-lia&quot; href=&quot;#&quot;&gt;装修材料检测&lt;/a&gt;&lt;/li&gt;\r\n	&lt;li class=&quot;lc-li&quot;&gt;&lt;a class=&quot;lc-lia&quot; href=&quot;#&quot;&gt;消防设施检测&lt;/a&gt;&lt;/li&gt;\r\n	&lt;li class=&quot;lc-li&quot;&gt;&lt;a class=&quot;lc-lia&quot; href=&quot;#&quot;&gt;消防审核验收&lt;/a&gt;&lt;/li&gt;\r\n	&lt;li class=&quot;lc-li&quot;&gt;&lt;a class=&quot;lc-lia&quot; href=&quot;#&quot;&gt;消防维保&lt;/a&gt;&lt;/li&gt;\r\n	&lt;li class=&quot;lc-li&quot;&gt;&lt;a class=&quot;lc-lia&quot; href=&quot;#&quot;&gt;消防托管&lt;/a&gt;&lt;/li&gt;\r\n	&lt;li class=&quot;lc-li&quot;&gt;&lt;a class=&quot;lc-lia&quot; href=&quot;#&quot;&gt;消防培训&lt;/a&gt;&lt;/li&gt;\r\n	&lt;li class=&quot;lc-li&quot;&gt;&lt;a class=&quot;lc-lia&quot; href=&quot;#&quot;&gt;消防保障&lt;/a&gt;&lt;/li&gt;\r\n&lt;/ul&gt;\r\n&lt;/div&gt;\r\n";}s:9:"layout_id";s:1:"1";s:8:"position";s:9:"slideshow";s:6:"status";s:1:"1";s:12:"module_class";s:0:"";s:10:"sort_order";s:0:"";}i:3;a:7:{s:12:"module_title";a:1:{i:2;s:13:"e站直通车";}s:11:"description";a:1:{i:2;s:2388:"&lt;div class=&quot;rel pb10&quot;&gt;\r\n&lt;h3 class=&quot;index-t l-fens&quot;&gt;e站直通车&lt;/h3&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;div class=&quot;ovh fix b_f btb3 bd2 p10&quot;&gt;&lt;span class=&quot;ztc-pic&quot;&gt;&lt;img src=&quot;http://www.yuankong.com/asset/image/data/yuankong/bkpic7.jpg&quot; /&gt;&lt;/span&gt;\r\n\r\n&lt;ul class=&quot;l ztc-ul fix&quot;&gt;\r\n	&lt;li class=&quot;ztc-li&quot;&gt;&lt;a href=&quot;#&quot; rel=&quot;nofollow&quot;&gt;建设工程&lt;br /&gt;\r\n	消防备案&lt;/a&gt;&lt;/li&gt;\r\n	&lt;li class=&quot;ztc-li bor3&quot;&gt;&lt;a href=&quot;#&quot; rel=&quot;nofollow&quot;&gt;消防技术&lt;br /&gt;\r\n	服务&lt;/a&gt;&lt;/li&gt;\r\n	&lt;li class=&quot;ztc-li bor1&quot;&gt;&lt;a href=&quot;#&quot; rel=&quot;nofollow&quot;&gt;消防产品装修&lt;br /&gt;\r\n	材料检验&lt;/a&gt;&lt;/li&gt;\r\n	&lt;li class=&quot;ztc-li bor2&quot;&gt;&lt;a href=&quot;#&quot; rel=&quot;nofollow&quot;&gt;生产企业消防&lt;br /&gt;\r\n	产品抽封样&lt;/a&gt;&lt;/li&gt;\r\n	&lt;li class=&quot;ztc-li bor4&quot;&gt;&lt;a href=&quot;#&quot; rel=&quot;nofollow&quot;&gt;消防产品市场&lt;br /&gt;\r\n	准入查询&lt;/a&gt;&lt;/li&gt;\r\n	&lt;li class=&quot;ztc-li bor5&quot;&gt;&lt;a href=&quot;#&quot; rel=&quot;nofollow&quot;&gt;建筑施工资质&lt;br /&gt;\r\n	证书查询&lt;/a&gt;&lt;/li&gt;\r\n	&lt;li class=&quot;ztc-li bor6&quot;&gt;&lt;a href=&quot;#&quot; rel=&quot;nofollow&quot;&gt;社会单位消防安全&lt;br /&gt;\r\n	户籍化管理系统&lt;/a&gt;&lt;/li&gt;\r\n	&lt;li class=&quot;ztc-li&quot;&gt;&lt;a href=&quot;#&quot; rel=&quot;nofollow&quot;&gt;灭火器维修技术&lt;br /&gt;\r\n	服务管理&lt;/a&gt;&lt;/li&gt;\r\n	&lt;li class=&quot;ztc-li bor1&quot;&gt;&lt;a href=&quot;#&quot; rel=&quot;nofollow&quot;&gt;建设工程消防&lt;br /&gt;\r\n	检查信息管理&lt;/a&gt;&lt;/li&gt;\r\n	&lt;li class=&quot;ztc-li bor3&quot;&gt;&lt;a href=&quot;#&quot; rel=&quot;nofollow&quot;&gt;灭火器维修技术&lt;br /&gt;\r\n	服务机构查询&lt;/a&gt;&lt;/li&gt;\r\n	&lt;li class=&quot;ztc-li bor5&quot;&gt;&lt;a href=&quot;#&quot; rel=&quot;nofollow&quot;&gt;建筑消防设施维修保养&lt;br /&gt;\r\n	技术服务机构查询&lt;/a&gt;&lt;/li&gt;\r\n	&lt;li class=&quot;ztc-li bor4&quot;&gt;&lt;a href=&quot;#&quot; rel=&quot;nofollow&quot;&gt;建筑消防设施检测&lt;br /&gt;\r\n	技术服务机构查询&lt;/a&gt;&lt;/li&gt;\r\n&lt;/ul&gt;\r\n&lt;/div&gt;\r\n";}s:9:"layout_id";s:1:"1";s:8:"position";s:11:"mass_bottom";s:6:"status";s:1:"1";s:12:"module_class";s:0:"";s:10:"sort_order";s:1:"3";}i:4;a:7:{s:12:"module_title";a:1:{i:2;s:12:"友情链接";}s:11:"description";a:1:{i:2;s:788:"&lt;div class=&quot;w&quot;&gt;&lt;a href=&quot;#&quot;&gt;阿里巴巴集团&lt;/a&gt;|&lt;a href=&quot;#&quot;&gt;淘宝网&lt;/a&gt;|&lt;a href=&quot;#&quot;&gt;天猫&lt;/a&gt;|&lt;a href=&quot;#&quot;&gt;聚划算&lt;/a&gt;|&lt;a href=&quot;#&quot;&gt;全球速卖通&lt;/a&gt;|&lt;a href=&quot;#&quot;&gt;阿里巴巴国际交易市场&lt;/a&gt;|&lt;a href=&quot;#&quot;&gt;1688&lt;/a&gt;|&lt;a href=&quot;#&quot;&gt;阿里妈妈&lt;/a&gt;|&lt;a href=&quot;#&quot;&gt;阿里云计算&lt;/a&gt;|&lt;a href=&quot;#&quot;&gt;YunOS&lt;/a&gt;|&lt;a href=&quot;#&quot;&gt;阿里通信&lt;/a&gt;|&lt;a href=&quot;#&quot;&gt;万网&lt;/a&gt;|&lt;a href=&quot;#&quot;&gt;高德&lt;/a&gt;|&lt;a href=&quot;#&quot;&gt;优视&lt;/a&gt;|&lt;a href=&quot;#&quot;&gt;友盟&lt;/a&gt;&lt;/div&gt;\r\n";}s:9:"layout_id";s:5:"99999";s:8:"position";s:10:"footer_top";s:6:"status";s:1:"1";s:12:"module_class";s:0:"";s:10:"sort_order";s:0:"";}}', 1),
(883, 0, 'affiliate', 'affiliate_module', 'a:2:{i:0;a:4:{s:9:"layout_id";s:2:"10";s:8:"position";s:12:"column_right";s:6:"status";s:1:"0";s:10:"sort_order";s:1:"1";}i:1;a:4:{s:9:"layout_id";s:1:"1";s:8:"position";s:12:"column_right";s:6:"status";s:1:"0";s:10:"sort_order";i:1;}}', 1),
(650, 0, 'config', 'config_maintenance', '0', 0),
(651, 0, 'config', 'config_password', '1', 0),
(652, 0, 'config', 'config_encryption', '8e7509edd480014c251f1b57bb4ef5f4', 0),
(653, 0, 'config', 'config_compression', '0', 0),
(654, 0, 'config', 'config_error_display', '1', 0),
(655, 0, 'config', 'config_error_log', '1', 0),
(656, 0, 'config', 'config_error_filename', 'error.txt', 0),
(657, 0, 'config', 'config_google_analytics', '', 0),
(878, 0, 'ykcase', 'ykcase_module', 'a:1:{i:0;a:6:{s:9:"layout_id";s:1:"1";s:8:"position";s:8:"showcase";s:5:"title";s:12:"案例精选";s:5:"limit";s:2:"16";s:6:"status";s:1:"1";s:10:"sort_order";i:1;}}', 1),
(888, 0, 'ykwiki', 'ykwiki_module', 'a:1:{i:1;a:10:{s:5:"title";a:1:{i:2;s:12:"消防百科";}s:11:"description";a:1:{i:2;s:0:"";}s:9:"layout_id";s:1:"1";s:8:"position";s:11:"mass_bottom";s:6:"status";s:1:"1";s:10:"sort_order";i:5;s:13:"category_tabs";a:6:{i:0;s:1:"1";i:1;s:1:"2";i:2;s:1:"3";i:3;s:1:"0";i:4;s:1:"4";i:5;s:1:"7";}s:5:"limit";a:6:{i:0;s:1:"5";i:1;s:1:"5";i:2;s:1:"5";i:3;s:1:"5";i:4;s:1:"5";i:5;s:1:"5";}s:5:"image";a:6:{i:0;s:24:"data/yuankong/bkpic1.jpg";i:1;s:24:"data/yuankong/bkpic2.jpg";i:2;s:24:"data/yuankong/bkpic3.jpg";i:3;s:24:"data/yuankong/bkpic4.jpg";i:4;s:24:"data/yuankong/bkpic5.jpg";i:5;s:24:"data/yuankong/bkpic6.jpg";}s:4:"sort";a:6:{i:0;s:1:"1";i:1;s:1:"2";i:2;s:1:"3";i:3;s:1:"4";i:4;s:1:"5";i:5;s:1:"6";}}}', 1),
(887, 0, 'ykaffiliate', 'ykaffiliate_module', 'a:1:{i:1;a:10:{s:5:"title";a:1:{i:2;s:12:"消防公司";}s:9:"layout_id";s:1:"1";s:8:"position";s:11:"mass_bottom";s:6:"status";s:1:"1";s:7:"lateast";s:1:"5";s:10:"sort_order";i:4;s:13:"category_tabs";a:4:{i:0;s:1:"1";i:1;s:1:"2";i:2;s:1:"3";i:3;s:1:"4";}s:5:"limit";a:4:{i:0;s:1:"5";i:1;s:1:"5";i:2;s:1:"5";i:3;s:1:"5";}s:10:"icon_class";a:4:{i:0;s:14:"icon design-gs";i:1;s:10:"icon jc-gs";i:2;s:10:"icon wb-gs";i:3;s:10:"icon gc-gs";}s:4:"sort";a:4:{i:0;s:1:"1";i:1;s:1:"2";i:2;s:1:"3";i:3;s:1:"4";}}}', 1),
(885, 0, 'ykproduct', 'ykproduct_module', 'a:2:{i:1;a:10:{s:5:"title";a:1:{i:2;s:12:"消防器材";}s:9:"layout_id";s:1:"1";s:8:"position";s:11:"mass_bottom";s:6:"status";s:1:"1";s:11:"title_class";s:14:"index-t l-blue";s:16:"additional_class";s:0:"";s:10:"sort_order";s:1:"1";s:13:"category_tabs";a:3:{s:8:"category";a:6:{i:0;s:2:"61";i:1;s:2:"69";i:2;s:2:"75";i:3;s:2:"84";i:4;s:2:"89";i:5;s:2:"94";}s:5:"limit";a:6:{i:0;s:1:"3";i:1;s:1:"2";i:2;s:1:"2";i:3;s:1:"3";i:4;s:1:"2";i:5;s:1:"3";}s:4:"sort";a:6:{i:0;s:1:"1";i:1;s:1:"2";i:2;s:1:"3";i:3;s:1:"4";i:4;s:1:"5";i:5;s:1:"6";}}s:12:"product_tabs";a:3:{s:7:"product";a:6:{i:0;s:2:"53";i:1;s:2:"52";i:2;s:2:"55";i:3;s:2:"54";i:4;s:2:"50";i:5;s:2:"51";}s:5:"image";a:6:{i:0;s:26:"data/yuankong/shoppic3.jpg";i:1;s:26:"data/yuankong/shoppic4.jpg";i:2;s:26:"data/yuankong/shoppic6.jpg";i:3;s:26:"data/yuankong/shoppic5.jpg";i:4;s:26:"data/yuankong/shoppic1.jpg";i:5;s:26:"data/yuankong/shoppic2.jpg";}s:4:"sort";a:6:{i:0;s:1:"1";i:1;s:1:"2";i:2;s:1:"3";i:3;s:1:"4";i:4;s:1:"5";i:5;s:1:"6";}}s:11:"banner_tabs";a:3:{s:5:"image";a:3:{i:0;s:25:"data/yuankong/banner4.jpg";i:1;s:25:"data/yuankong/banner5.jpg";i:2;s:25:"data/yuankong/banner6.jpg";}s:4:"link";a:3:{i:0;s:18:"www.yk119.com.cn/1";i:1;s:18:"www.yk119.com.cn/2";i:2;s:18:"www.yk119.com.cn/3";}s:4:"sort";a:3:{i:0;s:1:"1";i:1;s:1:"2";i:2;s:1:"3";}}}i:2;a:10:{s:5:"title";a:1:{i:2;s:12:"消防装备";}s:9:"layout_id";s:1:"1";s:8:"position";s:11:"mass_bottom";s:6:"status";s:1:"1";s:11:"title_class";s:15:"index-t l-zongs";s:16:"additional_class";s:6:"shebei";s:10:"sort_order";i:2;s:13:"category_tabs";a:3:{s:8:"category";a:4:{i:0;s:2:"97";i:1;s:3:"109";i:2;s:3:"115";i:3;s:3:"128";}s:5:"limit";a:4:{i:0;s:1:"6";i:1;s:1:"5";i:2;s:1:"6";i:3;s:1:"5";}s:4:"sort";a:4:{i:0;s:1:"0";i:1;s:1:"0";i:2;s:1:"0";i:3;s:1:"0";}}s:12:"product_tabs";a:3:{s:7:"product";a:6:{i:0;s:2:"50";i:1;s:2:"51";i:2;s:2:"54";i:3;s:2:"53";i:4;s:2:"55";i:5;s:2:"52";}s:5:"image";a:6:{i:0;s:26:"data/yuankong/shoppic1.jpg";i:1;s:26:"data/yuankong/shoppic2.jpg";i:2;s:26:"data/yuankong/shoppic5.jpg";i:3;s:26:"data/yuankong/shoppic3.jpg";i:4;s:26:"data/yuankong/shoppic6.jpg";i:5;s:26:"data/yuankong/shoppic4.jpg";}s:4:"sort";a:6:{i:0;s:1:"1";i:1;s:1:"2";i:2;s:1:"3";i:3;s:1:"4";i:4;s:1:"5";i:5;s:1:"6";}}s:11:"banner_tabs";a:3:{s:5:"image";a:3:{i:0;s:25:"data/yuankong/banner6.jpg";i:1;s:25:"data/yuankong/banner5.jpg";i:2;s:25:"data/yuankong/banner4.jpg";}s:4:"link";a:3:{i:0;s:24:"http://www.yuankong.com/";i:1;s:24:"http://www.yuankong.com/";i:2;s:24:"http://www.yuankong.com/";}s:4:"sort";a:3:{i:0;s:1:"1";i:1;s:1:"2";i:2;s:1:"3";}}}}', 1),
(873, 0, 'yknavigation', 'yknavigation_module', 'a:1:{i:0;a:5:{s:9:"layout_id";s:5:"99999";s:8:"position";s:8:"mainmenu";s:6:"status";s:1:"1";s:10:"sort_order";i:2;s:9:"navigator";a:6:{i:0;a:8:{s:5:"title";s:6:"首页";s:5:"route";s:11:"common/home";s:5:"param";s:0:"";s:16:"additional_class";s:0:"";s:4:"icon";s:0:"";s:6:"status";s:1:"1";s:8:"selected";s:1:"1";s:4:"sort";s:1:"1";}i:1;a:8:{s:5:"title";s:12:"消防商城";s:5:"route";s:16:"product/category";s:5:"param";s:0:"";s:16:"additional_class";s:0:"";s:4:"icon";s:0:"";s:6:"status";s:1:"1";s:8:"selected";s:1:"0";s:4:"sort";s:1:"2";}i:2;a:8:{s:5:"title";s:13:"工程-设计";s:5:"route";s:15:"service/project";s:5:"param";s:0:"";s:16:"additional_class";s:0:"";s:4:"icon";s:10:"icon freem";s:6:"status";s:1:"1";s:8:"selected";s:1:"0";s:4:"sort";s:1:"3";}i:3;a:8:{s:5:"title";s:12:"精选案例";s:5:"route";s:12:"service/case";s:5:"param";s:0:"";s:16:"additional_class";s:0:"";s:4:"icon";s:0:"";s:6:"status";s:1:"1";s:8:"selected";s:1:"0";s:4:"sort";s:1:"4";}i:4;a:8:{s:5:"title";s:12:"消防公司";s:5:"route";s:17:"affiliate/company";s:5:"param";s:0:"";s:16:"additional_class";s:0:"";s:4:"icon";s:0:"";s:6:"status";s:1:"1";s:8:"selected";s:1:"0";s:4:"sort";s:1:"5";}i:5;a:8:{s:5:"title";s:12:"消防百科";s:5:"route";s:16:"information/help";s:5:"param";s:0:"";s:16:"additional_class";s:0:"";s:4:"icon";s:0:"";s:6:"status";s:1:"1";s:8:"selected";s:1:"0";s:4:"sort";s:1:"6";}}}}', 1),
(879, 0, 'featured', 'product', '', 0),
(891, 0, 'themecontrol', 'themecontrol', 'a:22:{s:13:"default_theme";s:8:"yuankong";s:9:"layout_id";s:1:"1";s:8:"position";s:1:"1";s:21:"cateogry_display_mode";s:4:"grid";s:20:"cateogry_product_row";s:1:"0";s:14:"category_pzoom";s:1:"1";s:18:"product_enablezoom";s:1:"1";s:19:"product_zoomgallery";s:6:"slider";s:16:"product_zoommode";s:5:"basic";s:20:"product_zoomlenssize";s:3:"150";s:18:"product_zoomeasing";s:1:"1";s:21:"product_zoomlensshape";s:5:"basic";s:22:"product_related_column";s:1:"0";s:6:"search";a:3:{s:6:"option";a:3:{i:0;s:7:"product";i:1;s:4:"news";i:2;s:8:"category";}s:11:"placeholder";s:9:"消防栓";s:7:"keyword";a:4:{i:0;a:4:{s:5:"title";s:15:"干粉灭火器";s:4:"link";s:23:"http://www.yuankong.com";s:16:"additional_class";s:0:"";s:4:"sort";s:1:"1";}i:1;a:4:{s:5:"title";s:15:"应急指示灯";s:4:"link";s:23:"http://www.yuankong.com";s:16:"additional_class";s:0:"";s:4:"sort";s:1:"2";}i:2;a:4:{s:5:"title";s:12:"防毒面罩";s:4:"link";s:23:"http://www.yuankong.com";s:16:"additional_class";s:0:"";s:4:"sort";s:1:"3";}i:3;a:4:{s:5:"title";s:9:"消防栓";s:4:"link";s:23:"http://www.yuankong.com";s:16:"additional_class";s:0:"";s:4:"sort";s:1:"4";}}}s:20:"copyright_customhtml";a:1:{i:2;s:0:"";}s:18:"topleft_customhtml";a:1:{i:2;s:432:"&lt;div class=&quot;h-weix l rel&quot;&gt;\r\n  &lt;i class=&quot;icon2 wxtub&quot;&gt;&lt;/i&gt;&lt;em class=&quot;icon2 h-down&quot;&gt;&lt;/em&gt;\r\n&lt;div class=&quot;wxbox&quot;&gt;&lt;img src=&quot;http://www.yuankong.com/asset/image/data/yuankong/ewm2.jpg&quot; /&gt;\r\n&lt;p class=&quot;c8&quot;&gt;打开微信，点击“发现”，使用“扫一扫”即可关注爱游戏官方微信&lt;/p&gt;\r\n&lt;/div&gt;\r\n&lt;/div&gt;";}s:18:"contact_customhtml";a:1:{i:2;s:0:"";}s:15:"block_promotion";s:0:"";s:14:"block_showcase";s:0:"";s:16:"block_footer_top";s:0:"";s:19:"block_footer_center";s:0:"";s:19:"block_footer_bottom";s:0:"";}', 1);

-- --------------------------------------------------------

--
-- 表的结构 `yk_stock_status`
--

CREATE TABLE IF NOT EXISTS `yk_stock_status` (
  `stock_status_id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  PRIMARY KEY (`stock_status_id`,`language_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- 转存表中的数据 `yk_stock_status`
--

INSERT INTO `yk_stock_status` (`stock_status_id`, `language_id`, `name`) VALUES
(7, 2, '有 货'),
(8, 2, '预 定'),
(5, 2, '无 货'),
(6, 2, '2 - 3 Days');

-- --------------------------------------------------------

--
-- 表的结构 `yk_store`
--

CREATE TABLE IF NOT EXISTS `yk_store` (
  `store_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `url` varchar(255) NOT NULL,
  `ssl` varchar(255) NOT NULL,
  PRIMARY KEY (`store_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `yk_tax_class`
--

CREATE TABLE IF NOT EXISTS `yk_tax_class` (
  `tax_class_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) NOT NULL,
  `description` varchar(255) NOT NULL,
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`tax_class_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

-- --------------------------------------------------------

--
-- 表的结构 `yk_tax_rate`
--

CREATE TABLE IF NOT EXISTS `yk_tax_rate` (
  `tax_rate_id` int(11) NOT NULL AUTO_INCREMENT,
  `geo_zone_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(32) NOT NULL,
  `rate` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `type` char(1) NOT NULL,
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`tax_rate_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=88 ;

--
-- 转存表中的数据 `yk_tax_rate`
--

INSERT INTO `yk_tax_rate` (`tax_rate_id`, `geo_zone_id`, `name`, `rate`, `type`, `date_added`, `date_modified`) VALUES
(86, 3, 'VAT (17.5%)', '17.5000', 'P', '2011-03-09 21:17:10', '2011-09-22 22:24:29'),
(87, 3, 'Eco Tax (-2.00)', '2.0000', 'F', '2011-09-21 21:49:23', '2011-09-23 00:40:19');

-- --------------------------------------------------------

--
-- 表的结构 `yk_tax_rate_to_customer_group`
--

CREATE TABLE IF NOT EXISTS `yk_tax_rate_to_customer_group` (
  `tax_rate_id` int(11) NOT NULL,
  `customer_group_id` int(11) NOT NULL,
  PRIMARY KEY (`tax_rate_id`,`customer_group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `yk_tax_rate_to_customer_group`
--

INSERT INTO `yk_tax_rate_to_customer_group` (`tax_rate_id`, `customer_group_id`) VALUES
(86, 1),
(87, 1);

-- --------------------------------------------------------

--
-- 表的结构 `yk_tax_rule`
--

CREATE TABLE IF NOT EXISTS `yk_tax_rule` (
  `tax_rule_id` int(11) NOT NULL AUTO_INCREMENT,
  `tax_class_id` int(11) NOT NULL,
  `tax_rate_id` int(11) NOT NULL,
  `based` varchar(10) NOT NULL,
  `priority` int(5) NOT NULL DEFAULT '1',
  PRIMARY KEY (`tax_rule_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=129 ;

-- --------------------------------------------------------

--
-- 表的结构 `yk_url_alias`
--

CREATE TABLE IF NOT EXISTS `yk_url_alias` (
  `url_alias_id` int(11) NOT NULL AUTO_INCREMENT,
  `query` varchar(255) NOT NULL,
  `keyword` varchar(255) NOT NULL,
  PRIMARY KEY (`url_alias_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=774 ;

--
-- 转存表中的数据 `yk_url_alias`
--

INSERT INTO `yk_url_alias` (`url_alias_id`, `query`, `keyword`) VALUES
(772, 'information_id=4', 'about_us');

-- --------------------------------------------------------

--
-- 表的结构 `yk_user`
--

CREATE TABLE IF NOT EXISTS `yk_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_group_id` int(11) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(40) NOT NULL,
  `salt` varchar(9) NOT NULL,
  `firstname` varchar(32) NOT NULL,
  `lastname` varchar(32) NOT NULL,
  `email` varchar(96) NOT NULL,
  `code` varchar(40) NOT NULL,
  `ip` varchar(40) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`user_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `yk_user`
--

INSERT INTO `yk_user` (`user_id`, `user_group_id`, `username`, `password`, `salt`, `firstname`, `lastname`, `email`, `code`, `ip`, `status`, `date_added`) VALUES
(1, 1, 'admin', '5a3d95a74b486c04eda38f37d126368659a490b9', 'eeb90b591', '景修', '朱', 'zhujingxiu@yuankong.com', '', '127.0.0.1', 1, '2015-06-04 15:57:18');

-- --------------------------------------------------------

--
-- 表的结构 `yk_user_group`
--

CREATE TABLE IF NOT EXISTS `yk_user_group` (
  `user_group_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `permission` text NOT NULL,
  PRIMARY KEY (`user_group_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

--
-- 转存表中的数据 `yk_user_group`
--

INSERT INTO `yk_user_group` (`user_group_id`, `name`, `permission`) VALUES
(1, 'Top Administrator', 'a:2:{s:6:"access";a:153:{i:0;s:17:"catalog/attribute";i:1;s:23:"catalog/attribute_group";i:2;s:16:"catalog/category";i:3;s:16:"catalog/download";i:4;s:14:"catalog/filter";i:5;s:19:"catalog/information";i:6;s:20:"catalog/manufacturer";i:7;s:14:"catalog/option";i:8;s:15:"catalog/product";i:9;s:14:"catalog/review";i:10;s:18:"common/filemanager";i:11;s:13:"design/banner";i:12;s:13:"design/layout";i:13;s:14:"extension/feed";i:14;s:17:"extension/manager";i:15;s:16:"extension/module";i:16;s:17:"extension/payment";i:17;s:18:"extension/shipping";i:18;s:15:"extension/total";i:19;s:16:"feed/google_base";i:20;s:19:"feed/google_sitemap";i:21;s:20:"localisation/country";i:22;s:21:"localisation/currency";i:23;s:21:"localisation/geo_zone";i:24;s:21:"localisation/language";i:25;s:25:"localisation/length_class";i:26;s:25:"localisation/order_status";i:27;s:26:"localisation/return_action";i:28;s:26:"localisation/return_reason";i:29;s:26:"localisation/return_status";i:30;s:25:"localisation/stock_status";i:31;s:22:"localisation/tax_class";i:32;s:21:"localisation/tax_rate";i:33;s:25:"localisation/weight_class";i:34;s:17:"localisation/zone";i:35;s:14:"module/account";i:36;s:16:"module/affiliate";i:37;s:13:"module/banner";i:38;s:17:"module/bestseller";i:39;s:15:"module/carousel";i:40;s:15:"module/category";i:41;s:15:"module/featured";i:42;s:13:"module/filter";i:43;s:18:"module/google_talk";i:44;s:18:"module/information";i:45;s:13:"module/latest";i:46;s:16:"module/slideshow";i:47;s:14:"module/special";i:48;s:12:"module/store";i:49;s:14:"module/welcome";i:50;s:24:"payment/authorizenet_aim";i:51;s:21:"payment/bank_transfer";i:52;s:14:"payment/cheque";i:53;s:11:"payment/cod";i:54;s:21:"payment/free_checkout";i:55;s:14:"payment/liqpay";i:56;s:20:"payment/moneybookers";i:57;s:14:"payment/nochex";i:58;s:15:"payment/paymate";i:59;s:16:"payment/paypoint";i:60;s:13:"payment/payza";i:61;s:26:"payment/perpetual_payments";i:62;s:14:"payment/pp_pro";i:63;s:17:"payment/pp_pro_uk";i:64;s:19:"payment/pp_standard";i:65;s:15:"payment/sagepay";i:66;s:22:"payment/sagepay_direct";i:67;s:18:"payment/sagepay_us";i:68;s:19:"payment/twocheckout";i:69;s:28:"payment/web_payment_software";i:70;s:16:"payment/worldpay";i:71;s:27:"report/affiliate_commission";i:72;s:22:"report/customer_credit";i:73;s:22:"report/customer_online";i:74;s:21:"report/customer_order";i:75;s:22:"report/customer_reward";i:76;s:24:"report/product_purchased";i:77;s:21:"report/product_viewed";i:78;s:18:"report/sale_coupon";i:79;s:17:"report/sale_order";i:80;s:18:"report/sale_return";i:81;s:20:"report/sale_shipping";i:82;s:15:"report/sale_tax";i:83;s:14:"sale/affiliate";i:84;s:12:"sale/contact";i:85;s:11:"sale/coupon";i:86;s:13:"sale/customer";i:87;s:20:"sale/customer_ban_ip";i:88;s:19:"sale/customer_group";i:89;s:10:"sale/order";i:90;s:11:"sale/return";i:91;s:12:"sale/voucher";i:92;s:18:"sale/voucher_theme";i:93;s:15:"setting/setting";i:94;s:13:"setting/store";i:95;s:16:"shipping/auspost";i:96;s:17:"shipping/citylink";i:97;s:14:"shipping/fedex";i:98;s:13:"shipping/flat";i:99;s:13:"shipping/free";i:100;s:13:"shipping/item";i:101;s:23:"shipping/parcelforce_48";i:102;s:15:"shipping/pickup";i:103;s:19:"shipping/royal_mail";i:104;s:12:"shipping/ups";i:105;s:13:"shipping/usps";i:106;s:15:"shipping/weight";i:107;s:11:"tool/backup";i:108;s:14:"tool/error_log";i:109;s:12:"total/coupon";i:110;s:12:"total/credit";i:111;s:14:"total/handling";i:112;s:16:"total/klarna_fee";i:113;s:19:"total/low_order_fee";i:114;s:12:"total/reward";i:115;s:14:"total/shipping";i:116;s:15:"total/sub_total";i:117;s:9:"total/tax";i:118;s:11:"total/total";i:119;s:13:"total/voucher";i:120;s:9:"user/user";i:121;s:20:"user/user_permission";i:122;s:11:"module/news";i:123;s:11:"module/news";i:124;s:19:"module/themecontrol";i:125;s:16:"module/pavcustom";i:126;s:23:"module/pavcontentslider";i:127;s:25:"module/pavproductcarousel";i:128;s:18:"module/pavproducts";i:129;s:16:"module/pavcustom";i:130;s:23:"module/pavcontentslider";i:131;s:16:"module/ykproject";i:132;s:13:"module/yknews";i:133;s:13:"module/yknews";i:134;s:16:"module/ykproject";i:135;s:18:"module/pavmegamenu";i:136;s:17:"module/ykshowcase";i:137;s:13:"module/ykcase";i:138;s:13:"module/ykcase";i:139;s:25:"module/pavproductcarousel";i:140;s:18:"module/information";i:141;s:20:"module/ykinformation";i:142;s:13:"module/ykwiki";i:143;s:13:"module/ykwiki";i:144;s:13:"module/ykwiki";i:145;s:13:"module/ykwiki";i:146;s:13:"module/ykwiki";i:147;s:13:"module/ykwiki";i:148;s:13:"module/ykwiki";i:149;s:18:"module/ykaffiliate";i:150;s:17:"module/ykcarousel";i:151;s:16:"module/ykproduct";i:152;s:19:"module/yknavigation";}s:6:"modify";a:153:{i:0;s:17:"catalog/attribute";i:1;s:23:"catalog/attribute_group";i:2;s:16:"catalog/category";i:3;s:16:"catalog/download";i:4;s:14:"catalog/filter";i:5;s:19:"catalog/information";i:6;s:20:"catalog/manufacturer";i:7;s:14:"catalog/option";i:8;s:15:"catalog/product";i:9;s:14:"catalog/review";i:10;s:18:"common/filemanager";i:11;s:13:"design/banner";i:12;s:13:"design/layout";i:13;s:14:"extension/feed";i:14;s:17:"extension/manager";i:15;s:16:"extension/module";i:16;s:17:"extension/payment";i:17;s:18:"extension/shipping";i:18;s:15:"extension/total";i:19;s:16:"feed/google_base";i:20;s:19:"feed/google_sitemap";i:21;s:20:"localisation/country";i:22;s:21:"localisation/currency";i:23;s:21:"localisation/geo_zone";i:24;s:21:"localisation/language";i:25;s:25:"localisation/length_class";i:26;s:25:"localisation/order_status";i:27;s:26:"localisation/return_action";i:28;s:26:"localisation/return_reason";i:29;s:26:"localisation/return_status";i:30;s:25:"localisation/stock_status";i:31;s:22:"localisation/tax_class";i:32;s:21:"localisation/tax_rate";i:33;s:25:"localisation/weight_class";i:34;s:17:"localisation/zone";i:35;s:14:"module/account";i:36;s:16:"module/affiliate";i:37;s:13:"module/banner";i:38;s:17:"module/bestseller";i:39;s:15:"module/carousel";i:40;s:15:"module/category";i:41;s:15:"module/featured";i:42;s:13:"module/filter";i:43;s:18:"module/google_talk";i:44;s:18:"module/information";i:45;s:13:"module/latest";i:46;s:16:"module/slideshow";i:47;s:14:"module/special";i:48;s:12:"module/store";i:49;s:14:"module/welcome";i:50;s:24:"payment/authorizenet_aim";i:51;s:21:"payment/bank_transfer";i:52;s:14:"payment/cheque";i:53;s:11:"payment/cod";i:54;s:21:"payment/free_checkout";i:55;s:14:"payment/liqpay";i:56;s:20:"payment/moneybookers";i:57;s:14:"payment/nochex";i:58;s:15:"payment/paymate";i:59;s:16:"payment/paypoint";i:60;s:13:"payment/payza";i:61;s:26:"payment/perpetual_payments";i:62;s:14:"payment/pp_pro";i:63;s:17:"payment/pp_pro_uk";i:64;s:19:"payment/pp_standard";i:65;s:15:"payment/sagepay";i:66;s:22:"payment/sagepay_direct";i:67;s:18:"payment/sagepay_us";i:68;s:19:"payment/twocheckout";i:69;s:28:"payment/web_payment_software";i:70;s:16:"payment/worldpay";i:71;s:27:"report/affiliate_commission";i:72;s:22:"report/customer_credit";i:73;s:22:"report/customer_online";i:74;s:21:"report/customer_order";i:75;s:22:"report/customer_reward";i:76;s:24:"report/product_purchased";i:77;s:21:"report/product_viewed";i:78;s:18:"report/sale_coupon";i:79;s:17:"report/sale_order";i:80;s:18:"report/sale_return";i:81;s:20:"report/sale_shipping";i:82;s:15:"report/sale_tax";i:83;s:14:"sale/affiliate";i:84;s:12:"sale/contact";i:85;s:11:"sale/coupon";i:86;s:13:"sale/customer";i:87;s:20:"sale/customer_ban_ip";i:88;s:19:"sale/customer_group";i:89;s:10:"sale/order";i:90;s:11:"sale/return";i:91;s:12:"sale/voucher";i:92;s:18:"sale/voucher_theme";i:93;s:15:"setting/setting";i:94;s:13:"setting/store";i:95;s:16:"shipping/auspost";i:96;s:17:"shipping/citylink";i:97;s:14:"shipping/fedex";i:98;s:13:"shipping/flat";i:99;s:13:"shipping/free";i:100;s:13:"shipping/item";i:101;s:23:"shipping/parcelforce_48";i:102;s:15:"shipping/pickup";i:103;s:19:"shipping/royal_mail";i:104;s:12:"shipping/ups";i:105;s:13:"shipping/usps";i:106;s:15:"shipping/weight";i:107;s:11:"tool/backup";i:108;s:14:"tool/error_log";i:109;s:12:"total/coupon";i:110;s:12:"total/credit";i:111;s:14:"total/handling";i:112;s:16:"total/klarna_fee";i:113;s:19:"total/low_order_fee";i:114;s:12:"total/reward";i:115;s:14:"total/shipping";i:116;s:15:"total/sub_total";i:117;s:9:"total/tax";i:118;s:11:"total/total";i:119;s:13:"total/voucher";i:120;s:9:"user/user";i:121;s:20:"user/user_permission";i:122;s:11:"module/news";i:123;s:11:"module/news";i:124;s:19:"module/themecontrol";i:125;s:16:"module/pavcustom";i:126;s:23:"module/pavcontentslider";i:127;s:25:"module/pavproductcarousel";i:128;s:18:"module/pavproducts";i:129;s:16:"module/pavcustom";i:130;s:23:"module/pavcontentslider";i:131;s:16:"module/ykproject";i:132;s:13:"module/yknews";i:133;s:13:"module/yknews";i:134;s:16:"module/ykproject";i:135;s:18:"module/pavmegamenu";i:136;s:17:"module/ykshowcase";i:137;s:13:"module/ykcase";i:138;s:13:"module/ykcase";i:139;s:25:"module/pavproductcarousel";i:140;s:18:"module/information";i:141;s:20:"module/ykinformation";i:142;s:13:"module/ykwiki";i:143;s:13:"module/ykwiki";i:144;s:13:"module/ykwiki";i:145;s:13:"module/ykwiki";i:146;s:13:"module/ykwiki";i:147;s:13:"module/ykwiki";i:148;s:13:"module/ykwiki";i:149;s:18:"module/ykaffiliate";i:150;s:17:"module/ykcarousel";i:151;s:16:"module/ykproduct";i:152;s:19:"module/yknavigation";}}'),
(10, 'Demonstration', '');

-- --------------------------------------------------------

--
-- 表的结构 `yk_voucher`
--

CREATE TABLE IF NOT EXISTS `yk_voucher` (
  `voucher_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `code` varchar(10) NOT NULL,
  `from_name` varchar(64) NOT NULL,
  `from_email` varchar(96) NOT NULL,
  `to_name` varchar(64) NOT NULL,
  `to_email` varchar(96) NOT NULL,
  `voucher_theme_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `amount` decimal(15,4) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`voucher_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `yk_voucher_history`
--

CREATE TABLE IF NOT EXISTS `yk_voucher_history` (
  `voucher_history_id` int(11) NOT NULL AUTO_INCREMENT,
  `voucher_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `amount` decimal(15,4) NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`voucher_history_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `yk_voucher_theme`
--

CREATE TABLE IF NOT EXISTS `yk_voucher_theme` (
  `voucher_theme_id` int(11) NOT NULL AUTO_INCREMENT,
  `image` varchar(255) NOT NULL,
  PRIMARY KEY (`voucher_theme_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- 转存表中的数据 `yk_voucher_theme`
--

INSERT INTO `yk_voucher_theme` (`voucher_theme_id`, `image`) VALUES
(8, 'data/demo/canon_eos_5d_2.jpg'),
(7, 'data/demo/gift-voucher-birthday.jpg'),
(6, 'data/demo/apple_logo.jpg');

-- --------------------------------------------------------

--
-- 表的结构 `yk_voucher_theme_description`
--

CREATE TABLE IF NOT EXISTS `yk_voucher_theme_description` (
  `voucher_theme_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  PRIMARY KEY (`voucher_theme_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `yk_voucher_theme_description`
--

INSERT INTO `yk_voucher_theme_description` (`voucher_theme_id`, `language_id`, `name`) VALUES
(6, 2, 'Christmas'),
(7, 2, 'Birthday'),
(8, 2, 'General');

-- --------------------------------------------------------

--
-- 表的结构 `yk_weight_class`
--

CREATE TABLE IF NOT EXISTS `yk_weight_class` (
  `weight_class_id` int(11) NOT NULL AUTO_INCREMENT,
  `value` decimal(15,8) NOT NULL DEFAULT '0.00000000',
  PRIMARY KEY (`weight_class_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- 转存表中的数据 `yk_weight_class`
--

INSERT INTO `yk_weight_class` (`weight_class_id`, `value`) VALUES
(1, '1.00000000'),
(2, '1000.00000000'),
(5, '2.20460000'),
(6, '35.27400000');

-- --------------------------------------------------------

--
-- 表的结构 `yk_weight_class_description`
--

CREATE TABLE IF NOT EXISTS `yk_weight_class_description` (
  `weight_class_id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `title` varchar(32) NOT NULL,
  `unit` varchar(4) NOT NULL,
  PRIMARY KEY (`weight_class_id`,`language_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- 转存表中的数据 `yk_weight_class_description`
--

INSERT INTO `yk_weight_class_description` (`weight_class_id`, `language_id`, `title`, `unit`) VALUES
(1, 2, '千克 ', 'kg'),
(2, 2, '克  ', 'g'),
(5, 2, ' 镑 ', 'lb'),
(6, 2, '盎司 ', 'oz');

-- --------------------------------------------------------

--
-- 表的结构 `yk_zone`
--

CREATE TABLE IF NOT EXISTS `yk_zone` (
  `zone_id` int(11) NOT NULL AUTO_INCREMENT,
  `country_id` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  `code` varchar(32) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`zone_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4227 ;

--
-- 转存表中的数据 `yk_zone`
--

INSERT INTO `yk_zone` (`zone_id`, `country_id`, `name`, `code`, `status`) VALUES
(684, 44, '安徽省', 'AN', 1),
(685, 44, '北京市', 'BE', 1),
(686, 44, '重庆', 'CH', 1),
(687, 44, '福建省', 'FU', 1),
(688, 44, '甘肃省', 'GA', 1),
(689, 44, '广东省', 'GU', 1),
(690, 44, '广西壮族自治区', 'GX', 1),
(691, 44, '贵州省', 'GZ', 1),
(692, 44, '海南省', 'HA', 1),
(693, 44, '河北省', 'HB', 1),
(694, 44, '黑龙江省', 'HL', 1),
(695, 44, '河南省', 'HE', 1),
(696, 44, '香港特别行政区', 'HK', 1),
(697, 44, '湖北省', 'HU', 1),
(698, 44, '湖南省', 'HN', 1),
(699, 44, '内蒙古自治区', 'IM', 1),
(700, 44, '江苏省', 'JI', 1),
(701, 44, '江西省', 'JX', 1),
(702, 44, '吉林省', 'JL', 1),
(703, 44, '辽宁省', 'LI', 1),
(704, 44, '澳门特别行政区', 'MA', 1),
(705, 44, '宁夏回族自治区', 'NI', 1),
(706, 44, '陕西省', 'SH', 1),
(707, 44, '山东省', 'SA', 1),
(708, 44, '上海市', 'SG', 1),
(709, 44, '山西省', 'SX', 1),
(710, 44, '四川省', 'SI', 1),
(711, 44, '天津市', 'TI', 1),
(712, 44, '新疆维吾尔自治区', 'XI', 1),
(713, 44, '云南省', 'YU', 1),
(714, 44, '浙江省', 'ZH', 1),
(4225, 44, '西藏自治区', 'TB', 1),
(4226, 44, '台湾省', 'TW', 1);

-- --------------------------------------------------------

--
-- 表的结构 `yk_zone_to_geo_zone`
--

CREATE TABLE IF NOT EXISTS `yk_zone_to_geo_zone` (
  `zone_to_geo_zone_id` int(11) NOT NULL AUTO_INCREMENT,
  `country_id` int(11) NOT NULL,
  `zone_id` int(11) NOT NULL DEFAULT '0',
  `geo_zone_id` int(11) NOT NULL,
  `date_added` datetime NOT NULL,
  `date_modified` datetime NOT NULL,
  PRIMARY KEY (`zone_to_geo_zone_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=142 ;

--
-- 转存表中的数据 `yk_zone_to_geo_zone`
--

INSERT INTO `yk_zone_to_geo_zone` (`zone_to_geo_zone_id`, `country_id`, `zone_id`, `geo_zone_id`, `date_added`, `date_modified`) VALUES
(110, 44, 712, 4, '2015-04-01 22:11:53', '0000-00-00 00:00:00'),
(141, 44, 4226, 5, '2015-04-01 22:24:09', '0000-00-00 00:00:00'),
(140, 44, 696, 5, '2015-04-01 22:24:09', '0000-00-00 00:00:00'),
(139, 44, 704, 5, '2015-04-01 22:24:09', '0000-00-00 00:00:00'),
(138, 44, 694, 3, '2015-04-01 22:23:18', '0000-00-00 00:00:00'),
(137, 44, 706, 3, '2015-04-01 22:23:18', '0000-00-00 00:00:00'),
(136, 44, 686, 3, '2015-04-01 22:23:18', '0000-00-00 00:00:00'),
(135, 44, 703, 3, '2015-04-01 22:23:18', '0000-00-00 00:00:00'),
(134, 44, 691, 3, '2015-04-01 22:23:18', '0000-00-00 00:00:00'),
(133, 44, 687, 3, '2015-04-01 22:23:18', '0000-00-00 00:00:00'),
(132, 44, 688, 3, '2015-04-01 22:23:18', '0000-00-00 00:00:00'),
(131, 44, 698, 3, '2015-04-01 22:23:18', '0000-00-00 00:00:00'),
(130, 44, 697, 3, '2015-04-01 22:23:18', '0000-00-00 00:00:00'),
(129, 44, 692, 3, '2015-04-01 22:23:18', '0000-00-00 00:00:00'),
(128, 44, 714, 3, '2015-04-01 22:23:18', '0000-00-00 00:00:00'),
(127, 44, 695, 3, '2015-04-01 22:23:18', '0000-00-00 00:00:00'),
(126, 44, 693, 3, '2015-04-01 22:23:18', '0000-00-00 00:00:00'),
(125, 44, 701, 3, '2015-04-01 22:23:18', '0000-00-00 00:00:00'),
(124, 44, 700, 3, '2015-04-01 22:23:18', '0000-00-00 00:00:00'),
(123, 44, 690, 3, '2015-04-01 22:23:18', '0000-00-00 00:00:00'),
(122, 44, 689, 3, '2015-04-01 22:23:18', '0000-00-00 00:00:00'),
(121, 44, 709, 3, '2015-04-01 22:23:18', '0000-00-00 00:00:00'),
(120, 44, 707, 3, '2015-04-01 22:23:18', '0000-00-00 00:00:00'),
(119, 44, 684, 3, '2015-04-01 22:23:18', '0000-00-00 00:00:00'),
(118, 44, 711, 3, '2015-04-01 22:23:18', '0000-00-00 00:00:00'),
(117, 44, 710, 3, '2015-04-01 22:23:18', '0000-00-00 00:00:00'),
(116, 44, 702, 3, '2015-04-01 22:23:18', '0000-00-00 00:00:00'),
(115, 44, 685, 3, '2015-04-01 22:23:18', '0000-00-00 00:00:00'),
(114, 44, 713, 3, '2015-04-01 22:23:18', '0000-00-00 00:00:00'),
(113, 44, 708, 3, '2015-04-01 22:23:18', '0000-00-00 00:00:00'),
(111, 44, 4225, 4, '2015-04-01 22:11:53', '0000-00-00 00:00:00'),
(112, 44, 705, 4, '2015-04-01 22:11:53', '0000-00-00 00:00:00');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
