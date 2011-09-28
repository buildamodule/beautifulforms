-- MySQL dump 10.13  Distrib 5.1.37, for apple-darwin8.11.1 (i386)
--
-- Host: localhost    Database: loc_beautifulform_com
-- ------------------------------------------------------
-- Server version	5.1.37

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `actions`
--

DROP TABLE IF EXISTS `actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actions` (
  `aid` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Primary Key: Unique actions ID.',
  `type` varchar(32) NOT NULL DEFAULT '' COMMENT 'The object that that action acts on (node, user, comment, system or custom types.)',
  `callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The callback function that executes when the action runs.',
  `parameters` longblob NOT NULL COMMENT 'Parameters to be passed to the callback function.',
  `label` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Label of the action.',
  PRIMARY KEY (`aid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores action information.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actions`
--

LOCK TABLES `actions` WRITE;
/*!40000 ALTER TABLE `actions` DISABLE KEYS */;
INSERT INTO `actions` VALUES ('comment_publish_action','comment','comment_publish_action','','Publish comment');
INSERT INTO `actions` VALUES ('comment_save_action','comment','comment_save_action','','Save comment');
INSERT INTO `actions` VALUES ('comment_unpublish_action','comment','comment_unpublish_action','','Unpublish comment');
INSERT INTO `actions` VALUES ('node_make_sticky_action','node','node_make_sticky_action','','Make content sticky');
INSERT INTO `actions` VALUES ('node_make_unsticky_action','node','node_make_unsticky_action','','Make content unsticky');
INSERT INTO `actions` VALUES ('node_promote_action','node','node_promote_action','','Promote content to front page');
INSERT INTO `actions` VALUES ('node_publish_action','node','node_publish_action','','Publish content');
INSERT INTO `actions` VALUES ('node_save_action','node','node_save_action','','Save content');
INSERT INTO `actions` VALUES ('node_unpromote_action','node','node_unpromote_action','','Remove content from front page');
INSERT INTO `actions` VALUES ('node_unpublish_action','node','node_unpublish_action','','Unpublish content');
INSERT INTO `actions` VALUES ('system_block_ip_action','user','system_block_ip_action','','Ban IP address of current user');
INSERT INTO `actions` VALUES ('user_block_user_action','user','user_block_user_action','','Block current user');
/*!40000 ALTER TABLE `actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authmap`
--

DROP TABLE IF EXISTS `authmap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authmap` (
  `aid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique authmap ID.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'User’s users.uid.',
  `authname` varchar(128) NOT NULL DEFAULT '' COMMENT 'Unique authentication name.',
  `module` varchar(128) NOT NULL DEFAULT '' COMMENT 'Module which is controlling the authentication.',
  PRIMARY KEY (`aid`),
  UNIQUE KEY `authname` (`authname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores distributed authentication mapping.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authmap`
--

LOCK TABLES `authmap` WRITE;
/*!40000 ALTER TABLE `authmap` DISABLE KEYS */;
/*!40000 ALTER TABLE `authmap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batch`
--

DROP TABLE IF EXISTS `batch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `batch` (
  `bid` int(10) unsigned NOT NULL COMMENT 'Primary Key: Unique batch ID.',
  `token` varchar(64) NOT NULL COMMENT 'A string token generated against the current user’s session id and the batch id, used to ensure that only the user who submitted the batch can effectively access it.',
  `timestamp` int(11) NOT NULL COMMENT 'A Unix timestamp indicating when this batch was submitted for processing. Stale batches are purged at cron time.',
  `batch` longblob COMMENT 'A serialized array containing the processing data for the batch.',
  PRIMARY KEY (`bid`),
  KEY `token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores details about batches (processes that run in...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batch`
--

LOCK TABLES `batch` WRITE;
/*!40000 ALTER TABLE `batch` DISABLE KEYS */;
/*!40000 ALTER TABLE `batch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `block`
--

DROP TABLE IF EXISTS `block`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `block` (
  `bid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique block ID.',
  `module` varchar(64) NOT NULL DEFAULT '' COMMENT 'The module from which the block originates; for example, ’user’ for the Who’s Online block, and ’block’ for any custom blocks.',
  `delta` varchar(32) NOT NULL DEFAULT '0' COMMENT 'Unique ID for block within a module.',
  `theme` varchar(64) NOT NULL DEFAULT '' COMMENT 'The theme under which the block settings apply.',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Block enabled status. (1 = enabled, 0 = disabled)',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Block weight within region.',
  `region` varchar(64) NOT NULL DEFAULT '' COMMENT 'Theme region within which the block is set.',
  `custom` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Flag to indicate how users may control visibility of the block. (0 = Users cannot control, 1 = On by default, but can be hidden, 2 = Hidden by default, but can be shown)',
  `visibility` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Flag to indicate how to show blocks on pages. (0 = Show on all pages except listed pages, 1 = Show only on listed pages, 2 = Use custom PHP code to determine visibility)',
  `pages` text NOT NULL COMMENT 'Contents of the "Pages" block; contains either a list of paths on which to include/exclude the block or PHP code, depending on "visibility" setting.',
  `title` varchar(64) NOT NULL DEFAULT '' COMMENT 'Custom title for the block. (Empty string will use block default title, <none> will remove the title, text will cause block to use specified title.)',
  `cache` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Binary flag to indicate block cache mode. (-2: Custom cache, -1: Do not cache, 1: Cache per role, 2: Cache per user, 4: Cache per page, 8: Block cache global) See DRUPAL_CACHE_* constants in ../includes/common.inc for more detailed information.',
  PRIMARY KEY (`bid`),
  UNIQUE KEY `tmd` (`theme`,`module`,`delta`),
  KEY `list` (`theme`,`status`,`region`,`weight`,`module`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COMMENT='Stores block settings, such as region and visibility...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `block`
--

LOCK TABLES `block` WRITE;
/*!40000 ALTER TABLE `block` DISABLE KEYS */;
INSERT INTO `block` VALUES (1,'system','main','bartik',1,0,'content',0,0,'','',-1);
INSERT INTO `block` VALUES (2,'search','form','bartik',1,-1,'sidebar_first',0,0,'','',-1);
INSERT INTO `block` VALUES (3,'node','recent','seven',1,10,'dashboard_main',0,0,'','',-1);
INSERT INTO `block` VALUES (4,'user','login','bartik',1,0,'sidebar_first',0,0,'','',-1);
INSERT INTO `block` VALUES (5,'system','navigation','bartik',1,0,'sidebar_first',0,0,'','',-1);
INSERT INTO `block` VALUES (6,'system','powered-by','bartik',1,10,'footer',0,0,'','',-1);
INSERT INTO `block` VALUES (7,'system','help','bartik',1,0,'help',0,0,'','',-1);
INSERT INTO `block` VALUES (8,'system','main','seven',1,0,'content',0,0,'','',-1);
INSERT INTO `block` VALUES (9,'system','help','seven',1,0,'help',0,0,'','',-1);
INSERT INTO `block` VALUES (10,'user','login','seven',1,10,'content',0,0,'','',-1);
INSERT INTO `block` VALUES (11,'user','new','seven',1,0,'dashboard_sidebar',0,0,'','',-1);
INSERT INTO `block` VALUES (12,'search','form','seven',1,-10,'dashboard_sidebar',0,0,'','',-1);
INSERT INTO `block` VALUES (13,'comment','recent','bartik',0,0,'-1',0,0,'','',1);
INSERT INTO `block` VALUES (14,'node','syndicate','bartik',0,0,'-1',0,0,'','',-1);
INSERT INTO `block` VALUES (15,'node','recent','bartik',0,0,'-1',0,0,'','',1);
INSERT INTO `block` VALUES (16,'shortcut','shortcuts','bartik',0,0,'-1',0,0,'','',-1);
INSERT INTO `block` VALUES (17,'system','management','bartik',0,0,'-1',0,0,'','',-1);
INSERT INTO `block` VALUES (18,'system','user-menu','bartik',0,0,'-1',0,0,'','',-1);
INSERT INTO `block` VALUES (19,'system','main-menu','bartik',0,0,'-1',0,0,'','',-1);
INSERT INTO `block` VALUES (20,'user','new','bartik',0,0,'-1',0,0,'','',1);
INSERT INTO `block` VALUES (21,'user','online','bartik',0,0,'-1',0,0,'','',-1);
INSERT INTO `block` VALUES (22,'comment','recent','seven',1,0,'dashboard_inactive',0,0,'','',1);
INSERT INTO `block` VALUES (23,'node','syndicate','seven',0,0,'-1',0,0,'','',-1);
INSERT INTO `block` VALUES (24,'shortcut','shortcuts','seven',0,0,'-1',0,0,'','',-1);
INSERT INTO `block` VALUES (25,'system','powered-by','seven',0,10,'-1',0,0,'','',-1);
INSERT INTO `block` VALUES (26,'system','navigation','seven',0,0,'-1',0,0,'','',-1);
INSERT INTO `block` VALUES (27,'system','management','seven',0,0,'-1',0,0,'','',-1);
INSERT INTO `block` VALUES (28,'system','user-menu','seven',0,0,'-1',0,0,'','',-1);
INSERT INTO `block` VALUES (29,'system','main-menu','seven',0,0,'-1',0,0,'','',-1);
INSERT INTO `block` VALUES (30,'user','online','seven',1,0,'dashboard_inactive',0,0,'','',-1);
/*!40000 ALTER TABLE `block` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `block_custom`
--

DROP TABLE IF EXISTS `block_custom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `block_custom` (
  `bid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The block’s block.bid.',
  `body` longtext COMMENT 'Block contents.',
  `info` varchar(128) NOT NULL DEFAULT '' COMMENT 'Block description.',
  `format` varchar(255) DEFAULT NULL COMMENT 'The filter_format.format of the block body.',
  PRIMARY KEY (`bid`),
  UNIQUE KEY `info` (`info`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores contents of custom-made blocks.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `block_custom`
--

LOCK TABLES `block_custom` WRITE;
/*!40000 ALTER TABLE `block_custom` DISABLE KEYS */;
/*!40000 ALTER TABLE `block_custom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `block_node_type`
--

DROP TABLE IF EXISTS `block_node_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `block_node_type` (
  `module` varchar(64) NOT NULL COMMENT 'The block’s origin module, from block.module.',
  `delta` varchar(32) NOT NULL COMMENT 'The block’s unique delta within module, from block.delta.',
  `type` varchar(32) NOT NULL COMMENT 'The machine-readable name of this type from node_type.type.',
  PRIMARY KEY (`module`,`delta`,`type`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sets up display criteria for blocks based on content types';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `block_node_type`
--

LOCK TABLES `block_node_type` WRITE;
/*!40000 ALTER TABLE `block_node_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `block_node_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `block_role`
--

DROP TABLE IF EXISTS `block_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `block_role` (
  `module` varchar(64) NOT NULL COMMENT 'The block’s origin module, from block.module.',
  `delta` varchar(32) NOT NULL COMMENT 'The block’s unique delta within module, from block.delta.',
  `rid` int(10) unsigned NOT NULL COMMENT 'The user’s role ID from users_roles.rid.',
  PRIMARY KEY (`module`,`delta`,`rid`),
  KEY `rid` (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sets up access permissions for blocks based on user roles';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `block_role`
--

LOCK TABLES `block_role` WRITE;
/*!40000 ALTER TABLE `block_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `block_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blocked_ips`
--

DROP TABLE IF EXISTS `blocked_ips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blocked_ips` (
  `iid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: unique ID for IP addresses.',
  `ip` varchar(40) NOT NULL DEFAULT '' COMMENT 'IP address',
  PRIMARY KEY (`iid`),
  KEY `blocked_ip` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores blocked IP addresses.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blocked_ips`
--

LOCK TABLES `blocked_ips` WRITE;
/*!40000 ALTER TABLE `blocked_ips` DISABLE KEYS */;
/*!40000 ALTER TABLE `blocked_ips` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Generic cache table for caching things not separated out...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
INSERT INTO `cache` VALUES ('','a:7:{s:7:\"comment\";a:6:{s:6:\"fields\";a:14:{s:3:\"cid\";a:2:{s:4:\"type\";s:6:\"serial\";s:8:\"not null\";b:1;}s:3:\"pid\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:3:\"nid\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:3:\"uid\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:7:\"subject\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:64;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:8:\"hostname\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:128;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:7:\"created\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:7:\"changed\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:6:\"status\";a:5:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:1;s:4:\"size\";s:4:\"tiny\";}s:6:\"thread\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;}s:4:\"name\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:60;s:8:\"not null\";b:0;}s:4:\"mail\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:64;s:8:\"not null\";b:0;}s:8:\"homepage\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:0;}s:8:\"language\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:12;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}}s:7:\"indexes\";a:5:{s:18:\"comment_status_pid\";a:2:{i:0;s:3:\"pid\";i:1;s:6:\"status\";}s:15:\"comment_num_new\";a:5:{i:0;s:3:\"nid\";i:1;s:6:\"status\";i:2;s:7:\"created\";i:3;s:3:\"cid\";i:4;s:6:\"thread\";}s:11:\"comment_uid\";a:1:{i:0;s:3:\"uid\";}s:20:\"comment_nid_language\";a:2:{i:0;s:3:\"nid\";i:1;s:8:\"language\";}s:15:\"comment_created\";a:1:{i:0;s:7:\"created\";}}s:11:\"primary key\";a:1:{i:0;s:3:\"cid\";}s:12:\"foreign keys\";a:2:{s:12:\"comment_node\";a:2:{s:5:\"table\";s:4:\"node\";s:7:\"columns\";a:1:{s:3:\"nid\";s:3:\"nid\";}}s:14:\"comment_author\";a:2:{s:5:\"table\";s:5:\"users\";s:7:\"columns\";a:1:{s:3:\"uid\";s:3:\"uid\";}}}s:6:\"module\";s:7:\"comment\";s:4:\"name\";s:7:\"comment\";}s:4:\"node\";a:7:{s:6:\"fields\";a:14:{s:3:\"nid\";a:3:{s:4:\"type\";s:6:\"serial\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:3:\"vid\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:4:\"type\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:32;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:8:\"language\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:12;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:5:\"title\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:3:\"uid\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:6:\"status\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:1;}s:7:\"created\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:7:\"changed\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:7:\"comment\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:7:\"promote\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:6:\"sticky\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:4:\"tnid\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:9:\"translate\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}}s:7:\"indexes\";a:9:{s:12:\"node_changed\";a:1:{i:0;s:7:\"changed\";}s:12:\"node_created\";a:1:{i:0;s:7:\"created\";}s:14:\"node_frontpage\";a:4:{i:0;s:7:\"promote\";i:1;s:6:\"status\";i:2;s:6:\"sticky\";i:3;s:7:\"created\";}s:16:\"node_status_type\";a:3:{i:0;s:6:\"status\";i:1;s:4:\"type\";i:2;s:3:\"nid\";}s:15:\"node_title_type\";a:2:{i:0;s:5:\"title\";i:1;a:2:{i:0;s:4:\"type\";i:1;i:4;}}s:9:\"node_type\";a:1:{i:0;a:2:{i:0;s:4:\"type\";i:1;i:4;}}s:3:\"uid\";a:1:{i:0;s:3:\"uid\";}s:4:\"tnid\";a:1:{i:0;s:4:\"tnid\";}s:9:\"translate\";a:1:{i:0;s:9:\"translate\";}}s:11:\"unique keys\";a:1:{s:3:\"vid\";a:1:{i:0;s:3:\"vid\";}}s:12:\"foreign keys\";a:2:{s:13:\"node_revision\";a:2:{s:5:\"table\";s:13:\"node_revision\";s:7:\"columns\";a:1:{s:3:\"vid\";s:3:\"vid\";}}s:11:\"node_author\";a:2:{s:5:\"table\";s:5:\"users\";s:7:\"columns\";a:1:{s:3:\"uid\";s:3:\"uid\";}}}s:11:\"primary key\";a:1:{i:0;s:3:\"nid\";}s:6:\"module\";s:4:\"node\";s:4:\"name\";s:4:\"node\";}s:13:\"node_revision\";a:6:{s:6:\"fields\";a:10:{s:3:\"nid\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:3:\"vid\";a:3:{s:4:\"type\";s:6:\"serial\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:3:\"uid\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:5:\"title\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:3:\"log\";a:3:{s:4:\"type\";s:4:\"text\";s:8:\"not null\";b:1;s:4:\"size\";s:3:\"big\";}s:9:\"timestamp\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:6:\"status\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:1;}s:7:\"comment\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:7:\"promote\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:6:\"sticky\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}}s:7:\"indexes\";a:2:{s:3:\"nid\";a:1:{i:0;s:3:\"nid\";}s:3:\"uid\";a:1:{i:0;s:3:\"uid\";}}s:11:\"primary key\";a:1:{i:0;s:3:\"vid\";}s:12:\"foreign keys\";a:2:{s:14:\"versioned_node\";a:2:{s:5:\"table\";s:4:\"node\";s:7:\"columns\";a:1:{s:3:\"nid\";s:3:\"nid\";}}s:14:\"version_author\";a:2:{s:5:\"table\";s:5:\"users\";s:7:\"columns\";a:1:{s:3:\"uid\";s:3:\"uid\";}}}s:6:\"module\";s:4:\"node\";s:4:\"name\";s:13:\"node_revision\";}s:12:\"file_managed\";a:7:{s:6:\"fields\";a:8:{s:3:\"fid\";a:3:{s:4:\"type\";s:6:\"serial\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:3:\"uid\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:8:\"filename\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:3:\"uri\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:8:\"filemime\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:8:\"filesize\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:6:\"status\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;s:4:\"size\";s:4:\"tiny\";}s:9:\"timestamp\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}}s:7:\"indexes\";a:3:{s:3:\"uid\";a:1:{i:0;s:3:\"uid\";}s:6:\"status\";a:1:{i:0;s:6:\"status\";}s:9:\"timestamp\";a:1:{i:0;s:9:\"timestamp\";}}s:11:\"unique keys\";a:1:{s:3:\"uri\";a:1:{i:0;s:3:\"uri\";}}s:11:\"primary key\";a:1:{i:0;s:3:\"fid\";}s:12:\"foreign keys\";a:1:{s:10:\"file_owner\";a:2:{s:5:\"table\";s:5:\"users\";s:7:\"columns\";a:1:{s:3:\"uid\";s:3:\"uid\";}}}s:6:\"module\";s:6:\"system\";s:4:\"name\";s:12:\"file_managed\";}s:18:\"taxonomy_term_data\";a:6:{s:6:\"fields\";a:6:{s:3:\"tid\";a:3:{s:4:\"type\";s:6:\"serial\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:3:\"vid\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:4:\"name\";a:5:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";s:12:\"translatable\";b:1;}s:11:\"description\";a:4:{s:4:\"type\";s:4:\"text\";s:8:\"not null\";b:0;s:4:\"size\";s:3:\"big\";s:12:\"translatable\";b:1;}s:6:\"format\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:0;}s:6:\"weight\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}}s:11:\"primary key\";a:1:{i:0;s:3:\"tid\";}s:12:\"foreign keys\";a:1:{s:10:\"vocabulary\";a:2:{s:5:\"table\";s:19:\"taxonomy_vocabulary\";s:7:\"columns\";a:1:{s:3:\"vid\";s:3:\"vid\";}}}s:7:\"indexes\";a:3:{s:13:\"taxonomy_tree\";a:3:{i:0;s:3:\"vid\";i:1;s:6:\"weight\";i:2;s:4:\"name\";}s:8:\"vid_name\";a:2:{i:0;s:3:\"vid\";i:1;s:4:\"name\";}s:4:\"name\";a:1:{i:0;s:4:\"name\";}}s:6:\"module\";s:8:\"taxonomy\";s:4:\"name\";s:18:\"taxonomy_term_data\";}s:19:\"taxonomy_vocabulary\";a:6:{s:6:\"fields\";a:7:{s:3:\"vid\";a:3:{s:4:\"type\";s:6:\"serial\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:4:\"name\";a:5:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";s:12:\"translatable\";b:1;}s:12:\"machine_name\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:11:\"description\";a:4:{s:4:\"type\";s:4:\"text\";s:8:\"not null\";b:0;s:4:\"size\";s:3:\"big\";s:12:\"translatable\";b:1;}s:9:\"hierarchy\";a:5:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;s:4:\"size\";s:4:\"tiny\";}s:6:\"module\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:6:\"weight\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}}s:11:\"primary key\";a:1:{i:0;s:3:\"vid\";}s:7:\"indexes\";a:1:{s:4:\"list\";a:2:{i:0;s:6:\"weight\";i:1;s:4:\"name\";}}s:11:\"unique keys\";a:1:{s:12:\"machine_name\";a:1:{i:0;s:12:\"machine_name\";}}s:6:\"module\";s:8:\"taxonomy\";s:4:\"name\";s:19:\"taxonomy_vocabulary\";}s:5:\"users\";a:7:{s:6:\"fields\";a:16:{s:3:\"uid\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:4:\"name\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:60;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:4:\"pass\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:128;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:4:\"mail\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:254;s:8:\"not null\";b:0;s:7:\"default\";s:0:\"\";}s:5:\"theme\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:9:\"signature\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:16:\"signature_format\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:0;}s:7:\"created\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:6:\"access\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:5:\"login\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:6:\"status\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;s:4:\"size\";s:4:\"tiny\";}s:8:\"timezone\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:32;s:8:\"not null\";b:0;}s:8:\"language\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:12;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:7:\"picture\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:4:\"init\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:254;s:8:\"not null\";b:0;s:7:\"default\";s:0:\"\";}s:4:\"data\";a:4:{s:4:\"type\";s:4:\"blob\";s:8:\"not null\";b:0;s:4:\"size\";s:3:\"big\";s:9:\"serialize\";b:1;}}s:7:\"indexes\";a:3:{s:6:\"access\";a:1:{i:0;s:6:\"access\";}s:7:\"created\";a:1:{i:0;s:7:\"created\";}s:4:\"mail\";a:1:{i:0;s:4:\"mail\";}}s:11:\"unique keys\";a:1:{s:4:\"name\";a:1:{i:0;s:4:\"name\";}}s:11:\"primary key\";a:1:{i:0;s:3:\"uid\";}s:12:\"foreign keys\";a:1:{s:16:\"signature_format\";a:2:{s:5:\"table\";s:13:\"filter_format\";s:7:\"columns\";a:1:{s:16:\"signature_format\";s:6:\"format\";}}}s:6:\"module\";s:4:\"user\";s:4:\"name\";s:5:\"users\";}}',0,1317181162,1);
INSERT INTO `cache` VALUES ('entity_info:en','a:6:{s:7:\"comment\";a:13:{s:5:\"label\";s:7:\"Comment\";s:10:\"base table\";s:7:\"comment\";s:12:\"uri callback\";s:11:\"comment_uri\";s:9:\"fieldable\";b:1;s:16:\"controller class\";s:17:\"CommentController\";s:11:\"entity keys\";a:4:{s:2:\"id\";s:3:\"cid\";s:6:\"bundle\";s:9:\"node_type\";s:5:\"label\";s:7:\"subject\";s:8:\"revision\";s:0:\"\";}s:7:\"bundles\";a:2:{s:20:\"comment_node_article\";a:3:{s:5:\"label\";s:15:\"Article comment\";s:5:\"admin\";a:4:{s:4:\"path\";s:55:\"admin/structure/types/manage/%comment_node_type/comment\";s:15:\"bundle argument\";i:4;s:9:\"real path\";s:44:\"admin/structure/types/manage/article/comment\";s:16:\"access arguments\";a:1:{i:0;s:24:\"administer content types\";}}s:11:\"rdf_mapping\";a:8:{s:7:\"rdftype\";a:2:{i:0;s:9:\"sioc:Post\";i:1;s:13:\"sioct:Comment\";}s:5:\"title\";a:1:{s:10:\"predicates\";a:1:{i:0;s:8:\"dc:title\";}}s:7:\"created\";a:3:{s:10:\"predicates\";a:2:{i:0;s:7:\"dc:date\";i:1;s:10:\"dc:created\";}s:8:\"datatype\";s:12:\"xsd:dateTime\";s:8:\"callback\";s:12:\"date_iso8601\";}s:7:\"changed\";a:3:{s:10:\"predicates\";a:1:{i:0;s:11:\"dc:modified\";}s:8:\"datatype\";s:12:\"xsd:dateTime\";s:8:\"callback\";s:12:\"date_iso8601\";}s:12:\"comment_body\";a:1:{s:10:\"predicates\";a:1:{i:0;s:15:\"content:encoded\";}}s:3:\"pid\";a:2:{s:10:\"predicates\";a:1:{i:0;s:13:\"sioc:reply_of\";}s:4:\"type\";s:3:\"rel\";}s:3:\"uid\";a:2:{s:10:\"predicates\";a:1:{i:0;s:16:\"sioc:has_creator\";}s:4:\"type\";s:3:\"rel\";}s:4:\"name\";a:1:{s:10:\"predicates\";a:1:{i:0;s:9:\"foaf:name\";}}}}s:17:\"comment_node_page\";a:3:{s:5:\"label\";s:18:\"Basic page comment\";s:5:\"admin\";a:4:{s:4:\"path\";s:55:\"admin/structure/types/manage/%comment_node_type/comment\";s:15:\"bundle argument\";i:4;s:9:\"real path\";s:41:\"admin/structure/types/manage/page/comment\";s:16:\"access arguments\";a:1:{i:0;s:24:\"administer content types\";}}s:11:\"rdf_mapping\";a:8:{s:7:\"rdftype\";a:2:{i:0;s:9:\"sioc:Post\";i:1;s:13:\"sioct:Comment\";}s:5:\"title\";a:1:{s:10:\"predicates\";a:1:{i:0;s:8:\"dc:title\";}}s:7:\"created\";a:3:{s:10:\"predicates\";a:2:{i:0;s:7:\"dc:date\";i:1;s:10:\"dc:created\";}s:8:\"datatype\";s:12:\"xsd:dateTime\";s:8:\"callback\";s:12:\"date_iso8601\";}s:7:\"changed\";a:3:{s:10:\"predicates\";a:1:{i:0;s:11:\"dc:modified\";}s:8:\"datatype\";s:12:\"xsd:dateTime\";s:8:\"callback\";s:12:\"date_iso8601\";}s:12:\"comment_body\";a:1:{s:10:\"predicates\";a:1:{i:0;s:15:\"content:encoded\";}}s:3:\"pid\";a:2:{s:10:\"predicates\";a:1:{i:0;s:13:\"sioc:reply_of\";}s:4:\"type\";s:3:\"rel\";}s:3:\"uid\";a:2:{s:10:\"predicates\";a:1:{i:0;s:16:\"sioc:has_creator\";}s:4:\"type\";s:3:\"rel\";}s:4:\"name\";a:1:{s:10:\"predicates\";a:1:{i:0;s:9:\"foaf:name\";}}}}}s:10:\"view modes\";a:1:{s:4:\"full\";a:2:{s:5:\"label\";s:12:\"Full comment\";s:15:\"custom settings\";b:0;}}s:12:\"static cache\";b:0;s:11:\"field cache\";b:1;s:9:\"load hook\";s:12:\"comment_load\";s:11:\"translation\";a:0:{}s:17:\"schema_fields_sql\";a:1:{s:10:\"base table\";a:14:{i:0;s:3:\"cid\";i:1;s:3:\"pid\";i:2;s:3:\"nid\";i:3;s:3:\"uid\";i:4;s:7:\"subject\";i:5;s:8:\"hostname\";i:6;s:7:\"created\";i:7;s:7:\"changed\";i:8;s:6:\"status\";i:9;s:6:\"thread\";i:10;s:4:\"name\";i:11;s:4:\"mail\";i:12;s:8:\"homepage\";i:13;s:8:\"language\";}}}s:4:\"node\";a:15:{s:5:\"label\";s:4:\"Node\";s:16:\"controller class\";s:14:\"NodeController\";s:10:\"base table\";s:4:\"node\";s:14:\"revision table\";s:13:\"node_revision\";s:12:\"uri callback\";s:8:\"node_uri\";s:9:\"fieldable\";b:1;s:11:\"entity keys\";a:4:{s:2:\"id\";s:3:\"nid\";s:8:\"revision\";s:3:\"vid\";s:6:\"bundle\";s:4:\"type\";s:5:\"label\";s:5:\"title\";}s:11:\"bundle keys\";a:1:{s:6:\"bundle\";s:4:\"type\";}s:7:\"bundles\";a:2:{s:7:\"article\";a:3:{s:5:\"label\";s:7:\"Article\";s:5:\"admin\";a:4:{s:4:\"path\";s:39:\"admin/structure/types/manage/%node_type\";s:9:\"real path\";s:36:\"admin/structure/types/manage/article\";s:15:\"bundle argument\";i:4;s:16:\"access arguments\";a:1:{i:0;s:24:\"administer content types\";}}s:11:\"rdf_mapping\";a:11:{s:11:\"field_image\";a:2:{s:10:\"predicates\";a:2:{i:0;s:8:\"og:image\";i:1;s:12:\"rdfs:seeAlso\";}s:4:\"type\";s:3:\"rel\";}s:10:\"field_tags\";a:2:{s:10:\"predicates\";a:1:{i:0;s:10:\"dc:subject\";}s:4:\"type\";s:3:\"rel\";}s:7:\"rdftype\";a:2:{i:0;s:9:\"sioc:Item\";i:1;s:13:\"foaf:Document\";}s:5:\"title\";a:1:{s:10:\"predicates\";a:1:{i:0;s:8:\"dc:title\";}}s:7:\"created\";a:3:{s:10:\"predicates\";a:2:{i:0;s:7:\"dc:date\";i:1;s:10:\"dc:created\";}s:8:\"datatype\";s:12:\"xsd:dateTime\";s:8:\"callback\";s:12:\"date_iso8601\";}s:7:\"changed\";a:3:{s:10:\"predicates\";a:1:{i:0;s:11:\"dc:modified\";}s:8:\"datatype\";s:12:\"xsd:dateTime\";s:8:\"callback\";s:12:\"date_iso8601\";}s:4:\"body\";a:1:{s:10:\"predicates\";a:1:{i:0;s:15:\"content:encoded\";}}s:3:\"uid\";a:2:{s:10:\"predicates\";a:1:{i:0;s:16:\"sioc:has_creator\";}s:4:\"type\";s:3:\"rel\";}s:4:\"name\";a:1:{s:10:\"predicates\";a:1:{i:0;s:9:\"foaf:name\";}}s:13:\"comment_count\";a:2:{s:10:\"predicates\";a:1:{i:0;s:16:\"sioc:num_replies\";}s:8:\"datatype\";s:11:\"xsd:integer\";}s:13:\"last_activity\";a:3:{s:10:\"predicates\";a:1:{i:0;s:23:\"sioc:last_activity_date\";}s:8:\"datatype\";s:12:\"xsd:dateTime\";s:8:\"callback\";s:12:\"date_iso8601\";}}}s:4:\"page\";a:3:{s:5:\"label\";s:10:\"Basic page\";s:5:\"admin\";a:4:{s:4:\"path\";s:39:\"admin/structure/types/manage/%node_type\";s:9:\"real path\";s:33:\"admin/structure/types/manage/page\";s:15:\"bundle argument\";i:4;s:16:\"access arguments\";a:1:{i:0;s:24:\"administer content types\";}}s:11:\"rdf_mapping\";a:9:{s:7:\"rdftype\";a:1:{i:0;s:13:\"foaf:Document\";}s:5:\"title\";a:1:{s:10:\"predicates\";a:1:{i:0;s:8:\"dc:title\";}}s:7:\"created\";a:3:{s:10:\"predicates\";a:2:{i:0;s:7:\"dc:date\";i:1;s:10:\"dc:created\";}s:8:\"datatype\";s:12:\"xsd:dateTime\";s:8:\"callback\";s:12:\"date_iso8601\";}s:7:\"changed\";a:3:{s:10:\"predicates\";a:1:{i:0;s:11:\"dc:modified\";}s:8:\"datatype\";s:12:\"xsd:dateTime\";s:8:\"callback\";s:12:\"date_iso8601\";}s:4:\"body\";a:1:{s:10:\"predicates\";a:1:{i:0;s:15:\"content:encoded\";}}s:3:\"uid\";a:2:{s:10:\"predicates\";a:1:{i:0;s:16:\"sioc:has_creator\";}s:4:\"type\";s:3:\"rel\";}s:4:\"name\";a:1:{s:10:\"predicates\";a:1:{i:0;s:9:\"foaf:name\";}}s:13:\"comment_count\";a:2:{s:10:\"predicates\";a:1:{i:0;s:16:\"sioc:num_replies\";}s:8:\"datatype\";s:11:\"xsd:integer\";}s:13:\"last_activity\";a:3:{s:10:\"predicates\";a:1:{i:0;s:23:\"sioc:last_activity_date\";}s:8:\"datatype\";s:12:\"xsd:dateTime\";s:8:\"callback\";s:12:\"date_iso8601\";}}}}s:10:\"view modes\";a:5:{s:4:\"full\";a:2:{s:5:\"label\";s:12:\"Full content\";s:15:\"custom settings\";b:0;}s:6:\"teaser\";a:2:{s:5:\"label\";s:6:\"Teaser\";s:15:\"custom settings\";b:1;}s:3:\"rss\";a:2:{s:5:\"label\";s:3:\"RSS\";s:15:\"custom settings\";b:0;}s:12:\"search_index\";a:2:{s:5:\"label\";s:12:\"Search index\";s:15:\"custom settings\";b:0;}s:13:\"search_result\";a:2:{s:5:\"label\";s:13:\"Search result\";s:15:\"custom settings\";b:0;}}s:12:\"static cache\";b:1;s:11:\"field cache\";b:1;s:9:\"load hook\";s:9:\"node_load\";s:11:\"translation\";a:0:{}s:17:\"schema_fields_sql\";a:2:{s:10:\"base table\";a:14:{i:0;s:3:\"nid\";i:1;s:3:\"vid\";i:2;s:4:\"type\";i:3;s:8:\"language\";i:4;s:5:\"title\";i:5;s:3:\"uid\";i:6;s:6:\"status\";i:7;s:7:\"created\";i:8;s:7:\"changed\";i:9;s:7:\"comment\";i:10;s:7:\"promote\";i:11;s:6:\"sticky\";i:12;s:4:\"tnid\";i:13;s:9:\"translate\";}s:14:\"revision table\";a:10:{i:0;s:3:\"nid\";i:1;s:3:\"vid\";i:2;s:3:\"uid\";i:3;s:5:\"title\";i:4;s:3:\"log\";i:5;s:9:\"timestamp\";i:6;s:6:\"status\";i:7;s:7:\"comment\";i:8;s:7:\"promote\";i:9;s:6:\"sticky\";}}}s:4:\"file\";a:12:{s:5:\"label\";s:4:\"File\";s:10:\"base table\";s:12:\"file_managed\";s:11:\"entity keys\";a:4:{s:2:\"id\";s:3:\"fid\";s:5:\"label\";s:8:\"filename\";s:8:\"revision\";s:0:\"\";s:6:\"bundle\";s:0:\"\";}s:12:\"static cache\";b:0;s:9:\"fieldable\";b:0;s:16:\"controller class\";s:29:\"DrupalDefaultEntityController\";s:11:\"field cache\";b:1;s:9:\"load hook\";s:9:\"file_load\";s:7:\"bundles\";a:1:{s:4:\"file\";a:2:{s:5:\"label\";s:4:\"File\";s:11:\"rdf_mapping\";a:0:{}}}s:10:\"view modes\";a:0:{}s:11:\"translation\";a:0:{}s:17:\"schema_fields_sql\";a:1:{s:10:\"base table\";a:8:{i:0;s:3:\"fid\";i:1;s:3:\"uid\";i:2;s:8:\"filename\";i:3;s:3:\"uri\";i:4;s:8:\"filemime\";i:5;s:8:\"filesize\";i:6;s:6:\"status\";i:7;s:9:\"timestamp\";}}}s:13:\"taxonomy_term\";a:14:{s:5:\"label\";s:13:\"Taxonomy term\";s:16:\"controller class\";s:22:\"TaxonomyTermController\";s:10:\"base table\";s:18:\"taxonomy_term_data\";s:12:\"uri callback\";s:17:\"taxonomy_term_uri\";s:9:\"fieldable\";b:1;s:11:\"entity keys\";a:4:{s:2:\"id\";s:3:\"tid\";s:6:\"bundle\";s:23:\"vocabulary_machine_name\";s:5:\"label\";s:4:\"name\";s:8:\"revision\";s:0:\"\";}s:11:\"bundle keys\";a:1:{s:6:\"bundle\";s:12:\"machine_name\";}s:7:\"bundles\";a:1:{s:4:\"tags\";a:3:{s:5:\"label\";s:4:\"Tags\";s:5:\"admin\";a:4:{s:4:\"path\";s:58:\"admin/structure/taxonomy/%taxonomy_vocabulary_machine_name\";s:9:\"real path\";s:29:\"admin/structure/taxonomy/tags\";s:15:\"bundle argument\";i:3;s:16:\"access arguments\";a:1:{i:0;s:19:\"administer taxonomy\";}}s:11:\"rdf_mapping\";a:5:{s:7:\"rdftype\";a:1:{i:0;s:12:\"skos:Concept\";}s:4:\"name\";a:1:{s:10:\"predicates\";a:2:{i:0;s:10:\"rdfs:label\";i:1;s:14:\"skos:prefLabel\";}}s:11:\"description\";a:1:{s:10:\"predicates\";a:1:{i:0;s:15:\"skos:definition\";}}s:3:\"vid\";a:2:{s:10:\"predicates\";a:1:{i:0;s:13:\"skos:inScheme\";}s:4:\"type\";s:3:\"rel\";}s:6:\"parent\";a:2:{s:10:\"predicates\";a:1:{i:0;s:12:\"skos:broader\";}s:4:\"type\";s:3:\"rel\";}}}}s:10:\"view modes\";a:1:{s:4:\"full\";a:2:{s:5:\"label\";s:18:\"Taxonomy term page\";s:15:\"custom settings\";b:0;}}s:12:\"static cache\";b:1;s:11:\"field cache\";b:1;s:9:\"load hook\";s:18:\"taxonomy_term_load\";s:11:\"translation\";a:0:{}s:17:\"schema_fields_sql\";a:1:{s:10:\"base table\";a:6:{i:0;s:3:\"tid\";i:1;s:3:\"vid\";i:2;s:4:\"name\";i:3;s:11:\"description\";i:4;s:6:\"format\";i:5;s:6:\"weight\";}}}s:19:\"taxonomy_vocabulary\";a:12:{s:5:\"label\";s:19:\"Taxonomy vocabulary\";s:16:\"controller class\";s:28:\"TaxonomyVocabularyController\";s:10:\"base table\";s:19:\"taxonomy_vocabulary\";s:11:\"entity keys\";a:4:{s:2:\"id\";s:3:\"vid\";s:5:\"label\";s:4:\"name\";s:8:\"revision\";s:0:\"\";s:6:\"bundle\";s:0:\"\";}s:9:\"fieldable\";b:0;s:12:\"static cache\";b:1;s:11:\"field cache\";b:1;s:9:\"load hook\";s:24:\"taxonomy_vocabulary_load\";s:7:\"bundles\";a:1:{s:19:\"taxonomy_vocabulary\";a:2:{s:5:\"label\";s:19:\"Taxonomy vocabulary\";s:11:\"rdf_mapping\";a:3:{s:7:\"rdftype\";a:1:{i:0;s:18:\"skos:ConceptScheme\";}s:4:\"name\";a:1:{s:10:\"predicates\";a:1:{i:0;s:8:\"dc:title\";}}s:11:\"description\";a:1:{s:10:\"predicates\";a:1:{i:0;s:12:\"rdfs:comment\";}}}}}s:10:\"view modes\";a:0:{}s:11:\"translation\";a:0:{}s:17:\"schema_fields_sql\";a:1:{s:10:\"base table\";a:7:{i:0;s:3:\"vid\";i:1;s:4:\"name\";i:2;s:12:\"machine_name\";i:3;s:11:\"description\";i:4;s:9:\"hierarchy\";i:5;s:6:\"module\";i:6;s:6:\"weight\";}}}s:4:\"user\";a:14:{s:5:\"label\";s:4:\"User\";s:16:\"controller class\";s:14:\"UserController\";s:10:\"base table\";s:5:\"users\";s:12:\"uri callback\";s:8:\"user_uri\";s:14:\"label callback\";s:15:\"format_username\";s:9:\"fieldable\";b:1;s:11:\"entity keys\";a:3:{s:2:\"id\";s:3:\"uid\";s:8:\"revision\";s:0:\"\";s:6:\"bundle\";s:0:\"\";}s:7:\"bundles\";a:1:{s:4:\"user\";a:3:{s:5:\"label\";s:4:\"User\";s:5:\"admin\";a:2:{s:4:\"path\";s:28:\"admin/config/people/accounts\";s:16:\"access arguments\";a:1:{i:0;s:16:\"administer users\";}}s:11:\"rdf_mapping\";a:3:{s:7:\"rdftype\";a:1:{i:0;s:16:\"sioc:UserAccount\";}s:4:\"name\";a:1:{s:10:\"predicates\";a:1:{i:0;s:9:\"foaf:name\";}}s:8:\"homepage\";a:2:{s:10:\"predicates\";a:1:{i:0;s:9:\"foaf:page\";}s:4:\"type\";s:3:\"rel\";}}}}s:10:\"view modes\";a:1:{s:4:\"full\";a:2:{s:5:\"label\";s:12:\"User account\";s:15:\"custom settings\";b:0;}}s:12:\"static cache\";b:1;s:11:\"field cache\";b:1;s:9:\"load hook\";s:9:\"user_load\";s:11:\"translation\";a:0:{}s:17:\"schema_fields_sql\";a:1:{s:10:\"base table\";a:16:{i:0;s:3:\"uid\";i:1;s:4:\"name\";i:2;s:4:\"pass\";i:3;s:4:\"mail\";i:4;s:5:\"theme\";i:5;s:9:\"signature\";i:6;s:16:\"signature_format\";i:7;s:7:\"created\";i:8;s:6:\"access\";i:9;s:5:\"login\";i:10;s:6:\"status\";i:11;s:8:\"timezone\";i:12;s:8:\"language\";i:13;s:7:\"picture\";i:14;s:4:\"init\";i:15;s:4:\"data\";}}}}',0,1317181162,1);
INSERT INTO `cache` VALUES ('node_types:en','O:8:\"stdClass\":2:{s:5:\"types\";a:2:{s:7:\"article\";O:8:\"stdClass\":14:{s:4:\"type\";s:7:\"article\";s:4:\"name\";s:7:\"Article\";s:4:\"base\";s:12:\"node_content\";s:6:\"module\";s:4:\"node\";s:11:\"description\";s:89:\"Use <em>articles</em> for time-sensitive content like news, press releases or blog posts.\";s:4:\"help\";s:0:\"\";s:9:\"has_title\";s:1:\"1\";s:11:\"title_label\";s:5:\"Title\";s:6:\"custom\";s:1:\"1\";s:8:\"modified\";s:1:\"1\";s:6:\"locked\";s:1:\"0\";s:8:\"disabled\";s:1:\"0\";s:9:\"orig_type\";s:7:\"article\";s:16:\"disabled_changed\";b:0;}s:4:\"page\";O:8:\"stdClass\":14:{s:4:\"type\";s:4:\"page\";s:4:\"name\";s:10:\"Basic page\";s:4:\"base\";s:12:\"node_content\";s:6:\"module\";s:4:\"node\";s:11:\"description\";s:77:\"Use <em>basic pages</em> for your static content, such as an \'About us\' page.\";s:4:\"help\";s:0:\"\";s:9:\"has_title\";s:1:\"1\";s:11:\"title_label\";s:5:\"Title\";s:6:\"custom\";s:1:\"1\";s:8:\"modified\";s:1:\"1\";s:6:\"locked\";s:1:\"0\";s:8:\"disabled\";s:1:\"0\";s:9:\"orig_type\";s:4:\"page\";s:16:\"disabled_changed\";b:0;}}s:5:\"names\";a:2:{s:7:\"article\";s:7:\"Article\";s:4:\"page\";s:10:\"Basic page\";}}',0,1317181162,1);
INSERT INTO `cache` VALUES ('schema','a:73:{s:5:\"block\";a:6:{s:6:\"fields\";a:12:{s:3:\"bid\";a:2:{s:4:\"type\";s:6:\"serial\";s:8:\"not null\";b:1;}s:6:\"module\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:64;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:5:\"delta\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:32;s:8:\"not null\";b:1;s:7:\"default\";s:1:\"0\";}s:5:\"theme\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:64;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:6:\"status\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;s:4:\"size\";s:4:\"tiny\";}s:6:\"weight\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:6:\"region\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:64;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:6:\"custom\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;s:4:\"size\";s:4:\"tiny\";}s:10:\"visibility\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;s:4:\"size\";s:4:\"tiny\";}s:5:\"pages\";a:2:{s:4:\"type\";s:4:\"text\";s:8:\"not null\";b:1;}s:5:\"title\";a:5:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:64;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";s:12:\"translatable\";b:1;}s:5:\"cache\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:1;s:4:\"size\";s:4:\"tiny\";}}s:11:\"primary key\";a:1:{i:0;s:3:\"bid\";}s:11:\"unique keys\";a:1:{s:3:\"tmd\";a:3:{i:0;s:5:\"theme\";i:1;s:6:\"module\";i:2;s:5:\"delta\";}}s:7:\"indexes\";a:1:{s:4:\"list\";a:5:{i:0;s:5:\"theme\";i:1;s:6:\"status\";i:2;s:6:\"region\";i:3;s:6:\"weight\";i:4;s:6:\"module\";}}s:6:\"module\";s:5:\"block\";s:4:\"name\";s:5:\"block\";}s:10:\"block_role\";a:5:{s:6:\"fields\";a:3:{s:6:\"module\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:64;s:8:\"not null\";b:1;}s:5:\"delta\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:32;s:8:\"not null\";b:1;}s:3:\"rid\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}}s:11:\"primary key\";a:3:{i:0;s:6:\"module\";i:1;s:5:\"delta\";i:2;s:3:\"rid\";}s:7:\"indexes\";a:1:{s:3:\"rid\";a:1:{i:0;s:3:\"rid\";}}s:6:\"module\";s:5:\"block\";s:4:\"name\";s:10:\"block_role\";}s:12:\"block_custom\";a:5:{s:6:\"fields\";a:4:{s:3:\"bid\";a:3:{s:4:\"type\";s:6:\"serial\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:4:\"body\";a:4:{s:4:\"type\";s:4:\"text\";s:8:\"not null\";b:0;s:4:\"size\";s:3:\"big\";s:12:\"translatable\";b:1;}s:4:\"info\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:128;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:6:\"format\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:0;}}s:11:\"unique keys\";a:1:{s:4:\"info\";a:1:{i:0;s:4:\"info\";}}s:11:\"primary key\";a:1:{i:0;s:3:\"bid\";}s:6:\"module\";s:5:\"block\";s:4:\"name\";s:12:\"block_custom\";}s:11:\"cache_block\";a:5:{s:6:\"fields\";a:5:{s:3:\"cid\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:4:\"data\";a:3:{s:4:\"type\";s:4:\"blob\";s:8:\"not null\";b:0;s:4:\"size\";s:3:\"big\";}s:6:\"expire\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:7:\"created\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:10:\"serialized\";a:4:{s:4:\"type\";s:3:\"int\";s:4:\"size\";s:5:\"small\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}}s:7:\"indexes\";a:1:{s:6:\"expire\";a:1:{i:0;s:6:\"expire\";}}s:11:\"primary key\";a:1:{i:0;s:3:\"cid\";}s:6:\"module\";s:5:\"block\";s:4:\"name\";s:11:\"cache_block\";}s:7:\"comment\";a:6:{s:6:\"fields\";a:14:{s:3:\"cid\";a:2:{s:4:\"type\";s:6:\"serial\";s:8:\"not null\";b:1;}s:3:\"pid\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:3:\"nid\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:3:\"uid\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:7:\"subject\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:64;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:8:\"hostname\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:128;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:7:\"created\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:7:\"changed\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:6:\"status\";a:5:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:1;s:4:\"size\";s:4:\"tiny\";}s:6:\"thread\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;}s:4:\"name\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:60;s:8:\"not null\";b:0;}s:4:\"mail\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:64;s:8:\"not null\";b:0;}s:8:\"homepage\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:0;}s:8:\"language\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:12;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}}s:7:\"indexes\";a:5:{s:18:\"comment_status_pid\";a:2:{i:0;s:3:\"pid\";i:1;s:6:\"status\";}s:15:\"comment_num_new\";a:5:{i:0;s:3:\"nid\";i:1;s:6:\"status\";i:2;s:7:\"created\";i:3;s:3:\"cid\";i:4;s:6:\"thread\";}s:11:\"comment_uid\";a:1:{i:0;s:3:\"uid\";}s:20:\"comment_nid_language\";a:2:{i:0;s:3:\"nid\";i:1;s:8:\"language\";}s:15:\"comment_created\";a:1:{i:0;s:7:\"created\";}}s:11:\"primary key\";a:1:{i:0;s:3:\"cid\";}s:12:\"foreign keys\";a:2:{s:12:\"comment_node\";a:2:{s:5:\"table\";s:4:\"node\";s:7:\"columns\";a:1:{s:3:\"nid\";s:3:\"nid\";}}s:14:\"comment_author\";a:2:{s:5:\"table\";s:5:\"users\";s:7:\"columns\";a:1:{s:3:\"uid\";s:3:\"uid\";}}}s:6:\"module\";s:7:\"comment\";s:4:\"name\";s:7:\"comment\";}s:23:\"node_comment_statistics\";a:6:{s:6:\"fields\";a:6:{s:3:\"nid\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:3:\"cid\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:22:\"last_comment_timestamp\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:17:\"last_comment_name\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:60;s:8:\"not null\";b:0;}s:16:\"last_comment_uid\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:13:\"comment_count\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}}s:11:\"primary key\";a:1:{i:0;s:3:\"nid\";}s:7:\"indexes\";a:3:{s:22:\"node_comment_timestamp\";a:1:{i:0;s:22:\"last_comment_timestamp\";}s:13:\"comment_count\";a:1:{i:0;s:13:\"comment_count\";}s:16:\"last_comment_uid\";a:1:{i:0;s:16:\"last_comment_uid\";}}s:12:\"foreign keys\";a:2:{s:15:\"statistics_node\";a:2:{s:5:\"table\";s:4:\"node\";s:7:\"columns\";a:1:{s:3:\"nid\";s:3:\"nid\";}}s:19:\"last_comment_author\";a:2:{s:5:\"table\";s:5:\"users\";s:7:\"columns\";a:1:{s:16:\"last_comment_uid\";s:3:\"uid\";}}}s:6:\"module\";s:7:\"comment\";s:4:\"name\";s:23:\"node_comment_statistics\";}s:8:\"watchdog\";a:5:{s:6:\"fields\";a:11:{s:3:\"wid\";a:2:{s:4:\"type\";s:6:\"serial\";s:8:\"not null\";b:1;}s:3:\"uid\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:4:\"type\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:64;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:7:\"message\";a:3:{s:4:\"type\";s:4:\"text\";s:8:\"not null\";b:1;s:4:\"size\";s:3:\"big\";}s:9:\"variables\";a:3:{s:4:\"type\";s:4:\"blob\";s:8:\"not null\";b:1;s:4:\"size\";s:3:\"big\";}s:8:\"severity\";a:5:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;s:4:\"size\";s:4:\"tiny\";}s:4:\"link\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:0;s:7:\"default\";s:0:\"\";}s:8:\"location\";a:2:{s:4:\"type\";s:4:\"text\";s:8:\"not null\";b:1;}s:7:\"referer\";a:2:{s:4:\"type\";s:4:\"text\";s:8:\"not null\";b:0;}s:8:\"hostname\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:128;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:9:\"timestamp\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}}s:11:\"primary key\";a:1:{i:0;s:3:\"wid\";}s:7:\"indexes\";a:2:{s:4:\"type\";a:1:{i:0;s:4:\"type\";}s:3:\"uid\";a:1:{i:0;s:3:\"uid\";}}s:6:\"module\";s:5:\"dblog\";s:4:\"name\";s:8:\"watchdog\";}s:12:\"field_config\";a:5:{s:6:\"fields\";a:13:{s:2:\"id\";a:2:{s:4:\"type\";s:6:\"serial\";s:8:\"not null\";b:1;}s:10:\"field_name\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:32;s:8:\"not null\";b:1;}s:4:\"type\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:128;s:8:\"not null\";b:1;}s:6:\"module\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:128;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:6:\"active\";a:4:{s:4:\"type\";s:3:\"int\";s:4:\"size\";s:4:\"tiny\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:12:\"storage_type\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:128;s:8:\"not null\";b:1;}s:14:\"storage_module\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:128;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:14:\"storage_active\";a:4:{s:4:\"type\";s:3:\"int\";s:4:\"size\";s:4:\"tiny\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:6:\"locked\";a:4:{s:4:\"type\";s:3:\"int\";s:4:\"size\";s:4:\"tiny\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:4:\"data\";a:4:{s:4:\"type\";s:4:\"blob\";s:4:\"size\";s:3:\"big\";s:8:\"not null\";b:1;s:9:\"serialize\";b:1;}s:11:\"cardinality\";a:4:{s:4:\"type\";s:3:\"int\";s:4:\"size\";s:4:\"tiny\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:12:\"translatable\";a:4:{s:4:\"type\";s:3:\"int\";s:4:\"size\";s:4:\"tiny\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:7:\"deleted\";a:4:{s:4:\"type\";s:3:\"int\";s:4:\"size\";s:4:\"tiny\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}}s:11:\"primary key\";a:1:{i:0;s:2:\"id\";}s:7:\"indexes\";a:8:{s:10:\"field_name\";a:1:{i:0;s:10:\"field_name\";}s:6:\"active\";a:1:{i:0;s:6:\"active\";}s:14:\"storage_active\";a:1:{i:0;s:14:\"storage_active\";}s:7:\"deleted\";a:1:{i:0;s:7:\"deleted\";}s:6:\"module\";a:1:{i:0;s:6:\"module\";}s:14:\"storage_module\";a:1:{i:0;s:14:\"storage_module\";}s:4:\"type\";a:1:{i:0;s:4:\"type\";}s:12:\"storage_type\";a:1:{i:0;s:12:\"storage_type\";}}s:6:\"module\";s:5:\"field\";s:4:\"name\";s:12:\"field_config\";}s:21:\"field_config_instance\";a:5:{s:6:\"fields\";a:7:{s:2:\"id\";a:2:{s:4:\"type\";s:6:\"serial\";s:8:\"not null\";b:1;}s:8:\"field_id\";a:2:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;}s:10:\"field_name\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:32;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:11:\"entity_type\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:32;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:6:\"bundle\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:128;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:4:\"data\";a:4:{s:4:\"type\";s:4:\"blob\";s:4:\"size\";s:3:\"big\";s:8:\"not null\";b:1;s:9:\"serialize\";b:1;}s:7:\"deleted\";a:4:{s:4:\"type\";s:3:\"int\";s:4:\"size\";s:4:\"tiny\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}}s:11:\"primary key\";a:1:{i:0;s:2:\"id\";}s:7:\"indexes\";a:2:{s:17:\"field_name_bundle\";a:3:{i:0;s:10:\"field_name\";i:1;s:11:\"entity_type\";i:2;s:6:\"bundle\";}s:7:\"deleted\";a:1:{i:0;s:7:\"deleted\";}}s:6:\"module\";s:5:\"field\";s:4:\"name\";s:21:\"field_config_instance\";}s:11:\"cache_field\";a:5:{s:6:\"fields\";a:5:{s:3:\"cid\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:4:\"data\";a:3:{s:4:\"type\";s:4:\"blob\";s:8:\"not null\";b:0;s:4:\"size\";s:3:\"big\";}s:6:\"expire\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:7:\"created\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:10:\"serialized\";a:4:{s:4:\"type\";s:3:\"int\";s:4:\"size\";s:5:\"small\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}}s:7:\"indexes\";a:1:{s:6:\"expire\";a:1:{i:0;s:6:\"expire\";}}s:11:\"primary key\";a:1:{i:0;s:3:\"cid\";}s:6:\"module\";s:5:\"field\";s:4:\"name\";s:11:\"cache_field\";}s:23:\"field_data_comment_body\";a:6:{s:6:\"fields\";a:9:{s:11:\"entity_type\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:128;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:6:\"bundle\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:128;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:7:\"deleted\";a:4:{s:4:\"type\";s:3:\"int\";s:4:\"size\";s:4:\"tiny\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:9:\"entity_id\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:11:\"revision_id\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:0;}s:8:\"language\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:32;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:5:\"delta\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:18:\"comment_body_value\";a:3:{s:4:\"type\";s:4:\"text\";s:4:\"size\";s:3:\"big\";s:8:\"not null\";b:0;}s:19:\"comment_body_format\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:0;}}s:11:\"primary key\";a:5:{i:0;s:11:\"entity_type\";i:1;s:9:\"entity_id\";i:2;s:7:\"deleted\";i:3;s:5:\"delta\";i:4;s:8:\"language\";}s:7:\"indexes\";a:7:{s:11:\"entity_type\";a:1:{i:0;s:11:\"entity_type\";}s:6:\"bundle\";a:1:{i:0;s:6:\"bundle\";}s:7:\"deleted\";a:1:{i:0;s:7:\"deleted\";}s:9:\"entity_id\";a:1:{i:0;s:9:\"entity_id\";}s:11:\"revision_id\";a:1:{i:0;s:11:\"revision_id\";}s:8:\"language\";a:1:{i:0;s:8:\"language\";}s:19:\"comment_body_format\";a:1:{i:0;s:19:\"comment_body_format\";}}s:12:\"foreign keys\";a:1:{s:19:\"comment_body_format\";a:2:{s:5:\"table\";s:13:\"filter_format\";s:7:\"columns\";a:1:{s:19:\"comment_body_format\";s:6:\"format\";}}}s:6:\"module\";s:17:\"field_sql_storage\";s:4:\"name\";s:23:\"field_data_comment_body\";}s:27:\"field_revision_comment_body\";a:6:{s:6:\"fields\";a:9:{s:11:\"entity_type\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:128;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:6:\"bundle\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:128;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:7:\"deleted\";a:4:{s:4:\"type\";s:3:\"int\";s:4:\"size\";s:4:\"tiny\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:9:\"entity_id\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:11:\"revision_id\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:8:\"language\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:32;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:5:\"delta\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:18:\"comment_body_value\";a:3:{s:4:\"type\";s:4:\"text\";s:4:\"size\";s:3:\"big\";s:8:\"not null\";b:0;}s:19:\"comment_body_format\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:0;}}s:11:\"primary key\";a:6:{i:0;s:11:\"entity_type\";i:1;s:9:\"entity_id\";i:2;s:11:\"revision_id\";i:3;s:7:\"deleted\";i:4;s:5:\"delta\";i:5;s:8:\"language\";}s:7:\"indexes\";a:7:{s:11:\"entity_type\";a:1:{i:0;s:11:\"entity_type\";}s:6:\"bundle\";a:1:{i:0;s:6:\"bundle\";}s:7:\"deleted\";a:1:{i:0;s:7:\"deleted\";}s:9:\"entity_id\";a:1:{i:0;s:9:\"entity_id\";}s:11:\"revision_id\";a:1:{i:0;s:11:\"revision_id\";}s:8:\"language\";a:1:{i:0;s:8:\"language\";}s:19:\"comment_body_format\";a:1:{i:0;s:19:\"comment_body_format\";}}s:12:\"foreign keys\";a:1:{s:19:\"comment_body_format\";a:2:{s:5:\"table\";s:13:\"filter_format\";s:7:\"columns\";a:1:{s:19:\"comment_body_format\";s:6:\"format\";}}}s:6:\"module\";s:17:\"field_sql_storage\";s:4:\"name\";s:27:\"field_revision_comment_body\";}s:15:\"field_data_body\";a:6:{s:6:\"fields\";a:10:{s:11:\"entity_type\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:128;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:6:\"bundle\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:128;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:7:\"deleted\";a:4:{s:4:\"type\";s:3:\"int\";s:4:\"size\";s:4:\"tiny\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:9:\"entity_id\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:11:\"revision_id\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:0;}s:8:\"language\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:32;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:5:\"delta\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:10:\"body_value\";a:3:{s:4:\"type\";s:4:\"text\";s:4:\"size\";s:3:\"big\";s:8:\"not null\";b:0;}s:12:\"body_summary\";a:3:{s:4:\"type\";s:4:\"text\";s:4:\"size\";s:3:\"big\";s:8:\"not null\";b:0;}s:11:\"body_format\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:0;}}s:11:\"primary key\";a:5:{i:0;s:11:\"entity_type\";i:1;s:9:\"entity_id\";i:2;s:7:\"deleted\";i:3;s:5:\"delta\";i:4;s:8:\"language\";}s:7:\"indexes\";a:7:{s:11:\"entity_type\";a:1:{i:0;s:11:\"entity_type\";}s:6:\"bundle\";a:1:{i:0;s:6:\"bundle\";}s:7:\"deleted\";a:1:{i:0;s:7:\"deleted\";}s:9:\"entity_id\";a:1:{i:0;s:9:\"entity_id\";}s:11:\"revision_id\";a:1:{i:0;s:11:\"revision_id\";}s:8:\"language\";a:1:{i:0;s:8:\"language\";}s:11:\"body_format\";a:1:{i:0;s:11:\"body_format\";}}s:12:\"foreign keys\";a:1:{s:11:\"body_format\";a:2:{s:5:\"table\";s:13:\"filter_format\";s:7:\"columns\";a:1:{s:11:\"body_format\";s:6:\"format\";}}}s:6:\"module\";s:17:\"field_sql_storage\";s:4:\"name\";s:15:\"field_data_body\";}s:19:\"field_revision_body\";a:6:{s:6:\"fields\";a:10:{s:11:\"entity_type\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:128;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:6:\"bundle\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:128;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:7:\"deleted\";a:4:{s:4:\"type\";s:3:\"int\";s:4:\"size\";s:4:\"tiny\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:9:\"entity_id\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:11:\"revision_id\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:8:\"language\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:32;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:5:\"delta\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:10:\"body_value\";a:3:{s:4:\"type\";s:4:\"text\";s:4:\"size\";s:3:\"big\";s:8:\"not null\";b:0;}s:12:\"body_summary\";a:3:{s:4:\"type\";s:4:\"text\";s:4:\"size\";s:3:\"big\";s:8:\"not null\";b:0;}s:11:\"body_format\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:0;}}s:11:\"primary key\";a:6:{i:0;s:11:\"entity_type\";i:1;s:9:\"entity_id\";i:2;s:11:\"revision_id\";i:3;s:7:\"deleted\";i:4;s:5:\"delta\";i:5;s:8:\"language\";}s:7:\"indexes\";a:7:{s:11:\"entity_type\";a:1:{i:0;s:11:\"entity_type\";}s:6:\"bundle\";a:1:{i:0;s:6:\"bundle\";}s:7:\"deleted\";a:1:{i:0;s:7:\"deleted\";}s:9:\"entity_id\";a:1:{i:0;s:9:\"entity_id\";}s:11:\"revision_id\";a:1:{i:0;s:11:\"revision_id\";}s:8:\"language\";a:1:{i:0;s:8:\"language\";}s:11:\"body_format\";a:1:{i:0;s:11:\"body_format\";}}s:12:\"foreign keys\";a:1:{s:11:\"body_format\";a:2:{s:5:\"table\";s:13:\"filter_format\";s:7:\"columns\";a:1:{s:11:\"body_format\";s:6:\"format\";}}}s:6:\"module\";s:17:\"field_sql_storage\";s:4:\"name\";s:19:\"field_revision_body\";}s:21:\"field_data_field_tags\";a:6:{s:6:\"fields\";a:8:{s:11:\"entity_type\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:128;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:6:\"bundle\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:128;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:7:\"deleted\";a:4:{s:4:\"type\";s:3:\"int\";s:4:\"size\";s:4:\"tiny\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:9:\"entity_id\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:11:\"revision_id\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:0;}s:8:\"language\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:32;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:5:\"delta\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:14:\"field_tags_tid\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:0;}}s:11:\"primary key\";a:5:{i:0;s:11:\"entity_type\";i:1;s:9:\"entity_id\";i:2;s:7:\"deleted\";i:3;s:5:\"delta\";i:4;s:8:\"language\";}s:7:\"indexes\";a:7:{s:11:\"entity_type\";a:1:{i:0;s:11:\"entity_type\";}s:6:\"bundle\";a:1:{i:0;s:6:\"bundle\";}s:7:\"deleted\";a:1:{i:0;s:7:\"deleted\";}s:9:\"entity_id\";a:1:{i:0;s:9:\"entity_id\";}s:11:\"revision_id\";a:1:{i:0;s:11:\"revision_id\";}s:8:\"language\";a:1:{i:0;s:8:\"language\";}s:14:\"field_tags_tid\";a:1:{i:0;s:14:\"field_tags_tid\";}}s:12:\"foreign keys\";a:1:{s:14:\"field_tags_tid\";a:2:{s:5:\"table\";s:18:\"taxonomy_term_data\";s:7:\"columns\";a:1:{s:14:\"field_tags_tid\";s:3:\"tid\";}}}s:6:\"module\";s:17:\"field_sql_storage\";s:4:\"name\";s:21:\"field_data_field_tags\";}s:25:\"field_revision_field_tags\";a:6:{s:6:\"fields\";a:8:{s:11:\"entity_type\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:128;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:6:\"bundle\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:128;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:7:\"deleted\";a:4:{s:4:\"type\";s:3:\"int\";s:4:\"size\";s:4:\"tiny\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:9:\"entity_id\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:11:\"revision_id\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:8:\"language\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:32;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:5:\"delta\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:14:\"field_tags_tid\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:0;}}s:11:\"primary key\";a:6:{i:0;s:11:\"entity_type\";i:1;s:9:\"entity_id\";i:2;s:11:\"revision_id\";i:3;s:7:\"deleted\";i:4;s:5:\"delta\";i:5;s:8:\"language\";}s:7:\"indexes\";a:7:{s:11:\"entity_type\";a:1:{i:0;s:11:\"entity_type\";}s:6:\"bundle\";a:1:{i:0;s:6:\"bundle\";}s:7:\"deleted\";a:1:{i:0;s:7:\"deleted\";}s:9:\"entity_id\";a:1:{i:0;s:9:\"entity_id\";}s:11:\"revision_id\";a:1:{i:0;s:11:\"revision_id\";}s:8:\"language\";a:1:{i:0;s:8:\"language\";}s:14:\"field_tags_tid\";a:1:{i:0;s:14:\"field_tags_tid\";}}s:12:\"foreign keys\";a:1:{s:14:\"field_tags_tid\";a:2:{s:5:\"table\";s:18:\"taxonomy_term_data\";s:7:\"columns\";a:1:{s:14:\"field_tags_tid\";s:3:\"tid\";}}}s:6:\"module\";s:17:\"field_sql_storage\";s:4:\"name\";s:25:\"field_revision_field_tags\";}s:22:\"field_data_field_image\";a:6:{s:6:\"fields\";a:10:{s:11:\"entity_type\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:128;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:6:\"bundle\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:128;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:7:\"deleted\";a:4:{s:4:\"type\";s:3:\"int\";s:4:\"size\";s:4:\"tiny\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:9:\"entity_id\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:11:\"revision_id\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:0;}s:8:\"language\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:32;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:5:\"delta\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:15:\"field_image_fid\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:0;s:8:\"unsigned\";b:1;}s:15:\"field_image_alt\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:128;s:8:\"not null\";b:0;}s:17:\"field_image_title\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:128;s:8:\"not null\";b:0;}}s:11:\"primary key\";a:5:{i:0;s:11:\"entity_type\";i:1;s:9:\"entity_id\";i:2;s:7:\"deleted\";i:3;s:5:\"delta\";i:4;s:8:\"language\";}s:7:\"indexes\";a:7:{s:11:\"entity_type\";a:1:{i:0;s:11:\"entity_type\";}s:6:\"bundle\";a:1:{i:0;s:6:\"bundle\";}s:7:\"deleted\";a:1:{i:0;s:7:\"deleted\";}s:9:\"entity_id\";a:1:{i:0;s:9:\"entity_id\";}s:11:\"revision_id\";a:1:{i:0;s:11:\"revision_id\";}s:8:\"language\";a:1:{i:0;s:8:\"language\";}s:15:\"field_image_fid\";a:1:{i:0;s:15:\"field_image_fid\";}}s:12:\"foreign keys\";a:1:{s:15:\"field_image_fid\";a:2:{s:5:\"table\";s:12:\"file_managed\";s:7:\"columns\";a:1:{s:15:\"field_image_fid\";s:3:\"fid\";}}}s:6:\"module\";s:17:\"field_sql_storage\";s:4:\"name\";s:22:\"field_data_field_image\";}s:26:\"field_revision_field_image\";a:6:{s:6:\"fields\";a:10:{s:11:\"entity_type\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:128;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:6:\"bundle\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:128;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:7:\"deleted\";a:4:{s:4:\"type\";s:3:\"int\";s:4:\"size\";s:4:\"tiny\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:9:\"entity_id\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:11:\"revision_id\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:8:\"language\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:32;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:5:\"delta\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:15:\"field_image_fid\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:0;s:8:\"unsigned\";b:1;}s:15:\"field_image_alt\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:128;s:8:\"not null\";b:0;}s:17:\"field_image_title\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:128;s:8:\"not null\";b:0;}}s:11:\"primary key\";a:6:{i:0;s:11:\"entity_type\";i:1;s:9:\"entity_id\";i:2;s:11:\"revision_id\";i:3;s:7:\"deleted\";i:4;s:5:\"delta\";i:5;s:8:\"language\";}s:7:\"indexes\";a:7:{s:11:\"entity_type\";a:1:{i:0;s:11:\"entity_type\";}s:6:\"bundle\";a:1:{i:0;s:6:\"bundle\";}s:7:\"deleted\";a:1:{i:0;s:7:\"deleted\";}s:9:\"entity_id\";a:1:{i:0;s:9:\"entity_id\";}s:11:\"revision_id\";a:1:{i:0;s:11:\"revision_id\";}s:8:\"language\";a:1:{i:0;s:8:\"language\";}s:15:\"field_image_fid\";a:1:{i:0;s:15:\"field_image_fid\";}}s:12:\"foreign keys\";a:1:{s:15:\"field_image_fid\";a:2:{s:5:\"table\";s:12:\"file_managed\";s:7:\"columns\";a:1:{s:15:\"field_image_fid\";s:3:\"fid\";}}}s:6:\"module\";s:17:\"field_sql_storage\";s:4:\"name\";s:26:\"field_revision_field_image\";}s:6:\"filter\";a:5:{s:6:\"fields\";a:6:{s:6:\"format\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;}s:6:\"module\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:64;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:4:\"name\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:32;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:6:\"weight\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:6:\"status\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:8:\"settings\";a:4:{s:4:\"type\";s:4:\"blob\";s:8:\"not null\";b:0;s:4:\"size\";s:3:\"big\";s:9:\"serialize\";b:1;}}s:11:\"primary key\";a:2:{i:0;s:6:\"format\";i:1;s:4:\"name\";}s:7:\"indexes\";a:1:{s:4:\"list\";a:3:{i:0;s:6:\"weight\";i:1;s:6:\"module\";i:2;s:4:\"name\";}}s:6:\"module\";s:6:\"filter\";s:4:\"name\";s:6:\"filter\";}s:13:\"filter_format\";a:6:{s:6:\"fields\";a:5:{s:6:\"format\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;}s:4:\"name\";a:5:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";s:12:\"translatable\";b:1;}s:5:\"cache\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;s:4:\"size\";s:4:\"tiny\";}s:6:\"status\";a:5:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:1;s:4:\"size\";s:4:\"tiny\";}s:6:\"weight\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}}s:11:\"primary key\";a:1:{i:0;s:6:\"format\";}s:11:\"unique keys\";a:1:{s:4:\"name\";a:1:{i:0;s:4:\"name\";}}s:7:\"indexes\";a:1:{s:13:\"status_weight\";a:2:{i:0;s:6:\"status\";i:1;s:6:\"weight\";}}s:6:\"module\";s:6:\"filter\";s:4:\"name\";s:13:\"filter_format\";}s:12:\"cache_filter\";a:5:{s:6:\"fields\";a:5:{s:3:\"cid\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:4:\"data\";a:3:{s:4:\"type\";s:4:\"blob\";s:8:\"not null\";b:0;s:4:\"size\";s:3:\"big\";}s:6:\"expire\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:7:\"created\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:10:\"serialized\";a:4:{s:4:\"type\";s:3:\"int\";s:4:\"size\";s:5:\"small\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}}s:7:\"indexes\";a:1:{s:6:\"expire\";a:1:{i:0;s:6:\"expire\";}}s:11:\"primary key\";a:1:{i:0;s:3:\"cid\";}s:6:\"module\";s:6:\"filter\";s:4:\"name\";s:12:\"cache_filter\";}s:11:\"cache_image\";a:5:{s:6:\"fields\";a:5:{s:3:\"cid\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:4:\"data\";a:3:{s:4:\"type\";s:4:\"blob\";s:8:\"not null\";b:0;s:4:\"size\";s:3:\"big\";}s:6:\"expire\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:7:\"created\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:10:\"serialized\";a:4:{s:4:\"type\";s:3:\"int\";s:4:\"size\";s:5:\"small\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}}s:7:\"indexes\";a:1:{s:6:\"expire\";a:1:{i:0;s:6:\"expire\";}}s:11:\"primary key\";a:1:{i:0;s:3:\"cid\";}s:6:\"module\";s:5:\"image\";s:4:\"name\";s:11:\"cache_image\";}s:12:\"image_styles\";a:5:{s:6:\"fields\";a:2:{s:4:\"isid\";a:3:{s:4:\"type\";s:6:\"serial\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:4:\"name\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;}}s:11:\"primary key\";a:1:{i:0;s:4:\"isid\";}s:11:\"unique keys\";a:1:{s:4:\"name\";a:1:{i:0;s:4:\"name\";}}s:6:\"module\";s:5:\"image\";s:4:\"name\";s:12:\"image_styles\";}s:13:\"image_effects\";a:6:{s:6:\"fields\";a:5:{s:4:\"ieid\";a:3:{s:4:\"type\";s:6:\"serial\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:4:\"isid\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:6:\"weight\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:0;s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:4:\"name\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;}s:4:\"data\";a:4:{s:4:\"type\";s:4:\"blob\";s:8:\"not null\";b:1;s:4:\"size\";s:3:\"big\";s:9:\"serialize\";b:1;}}s:11:\"primary key\";a:1:{i:0;s:4:\"ieid\";}s:7:\"indexes\";a:2:{s:4:\"isid\";a:1:{i:0;s:4:\"isid\";}s:6:\"weight\";a:1:{i:0;s:6:\"weight\";}}s:12:\"foreign keys\";a:1:{s:11:\"image_style\";a:2:{s:5:\"table\";s:12:\"image_styles\";s:7:\"columns\";a:1:{s:4:\"isid\";s:4:\"isid\";}}}s:6:\"module\";s:5:\"image\";s:4:\"name\";s:13:\"image_effects\";}s:11:\"menu_custom\";a:4:{s:6:\"fields\";a:3:{s:9:\"menu_name\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:32;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:5:\"title\";a:5:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";s:12:\"translatable\";b:1;}s:11:\"description\";a:3:{s:4:\"type\";s:4:\"text\";s:8:\"not null\";b:0;s:12:\"translatable\";b:1;}}s:11:\"primary key\";a:1:{i:0;s:9:\"menu_name\";}s:6:\"module\";s:4:\"menu\";s:4:\"name\";s:11:\"menu_custom\";}s:4:\"node\";a:7:{s:6:\"fields\";a:14:{s:3:\"nid\";a:3:{s:4:\"type\";s:6:\"serial\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:3:\"vid\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:4:\"type\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:32;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:8:\"language\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:12;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:5:\"title\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:3:\"uid\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:6:\"status\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:1;}s:7:\"created\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:7:\"changed\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:7:\"comment\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:7:\"promote\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:6:\"sticky\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:4:\"tnid\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:9:\"translate\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}}s:7:\"indexes\";a:9:{s:12:\"node_changed\";a:1:{i:0;s:7:\"changed\";}s:12:\"node_created\";a:1:{i:0;s:7:\"created\";}s:14:\"node_frontpage\";a:4:{i:0;s:7:\"promote\";i:1;s:6:\"status\";i:2;s:6:\"sticky\";i:3;s:7:\"created\";}s:16:\"node_status_type\";a:3:{i:0;s:6:\"status\";i:1;s:4:\"type\";i:2;s:3:\"nid\";}s:15:\"node_title_type\";a:2:{i:0;s:5:\"title\";i:1;a:2:{i:0;s:4:\"type\";i:1;i:4;}}s:9:\"node_type\";a:1:{i:0;a:2:{i:0;s:4:\"type\";i:1;i:4;}}s:3:\"uid\";a:1:{i:0;s:3:\"uid\";}s:4:\"tnid\";a:1:{i:0;s:4:\"tnid\";}s:9:\"translate\";a:1:{i:0;s:9:\"translate\";}}s:11:\"unique keys\";a:1:{s:3:\"vid\";a:1:{i:0;s:3:\"vid\";}}s:12:\"foreign keys\";a:2:{s:13:\"node_revision\";a:2:{s:5:\"table\";s:13:\"node_revision\";s:7:\"columns\";a:1:{s:3:\"vid\";s:3:\"vid\";}}s:11:\"node_author\";a:2:{s:5:\"table\";s:5:\"users\";s:7:\"columns\";a:1:{s:3:\"uid\";s:3:\"uid\";}}}s:11:\"primary key\";a:1:{i:0;s:3:\"nid\";}s:6:\"module\";s:4:\"node\";s:4:\"name\";s:4:\"node\";}s:11:\"node_access\";a:5:{s:6:\"fields\";a:6:{s:3:\"nid\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:3:\"gid\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:5:\"realm\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:10:\"grant_view\";a:5:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;s:4:\"size\";s:4:\"tiny\";}s:12:\"grant_update\";a:5:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;s:4:\"size\";s:4:\"tiny\";}s:12:\"grant_delete\";a:5:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;s:4:\"size\";s:4:\"tiny\";}}s:11:\"primary key\";a:3:{i:0;s:3:\"nid\";i:1;s:3:\"gid\";i:2;s:5:\"realm\";}s:12:\"foreign keys\";a:1:{s:13:\"affected_node\";a:2:{s:5:\"table\";s:4:\"node\";s:7:\"columns\";a:1:{s:3:\"nid\";s:3:\"nid\";}}}s:6:\"module\";s:4:\"node\";s:4:\"name\";s:11:\"node_access\";}s:13:\"node_revision\";a:6:{s:6:\"fields\";a:10:{s:3:\"nid\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:3:\"vid\";a:3:{s:4:\"type\";s:6:\"serial\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:3:\"uid\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:5:\"title\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:3:\"log\";a:3:{s:4:\"type\";s:4:\"text\";s:8:\"not null\";b:1;s:4:\"size\";s:3:\"big\";}s:9:\"timestamp\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:6:\"status\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:1;}s:7:\"comment\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:7:\"promote\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:6:\"sticky\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}}s:7:\"indexes\";a:2:{s:3:\"nid\";a:1:{i:0;s:3:\"nid\";}s:3:\"uid\";a:1:{i:0;s:3:\"uid\";}}s:11:\"primary key\";a:1:{i:0;s:3:\"vid\";}s:12:\"foreign keys\";a:2:{s:14:\"versioned_node\";a:2:{s:5:\"table\";s:4:\"node\";s:7:\"columns\";a:1:{s:3:\"nid\";s:3:\"nid\";}}s:14:\"version_author\";a:2:{s:5:\"table\";s:5:\"users\";s:7:\"columns\";a:1:{s:3:\"uid\";s:3:\"uid\";}}}s:6:\"module\";s:4:\"node\";s:4:\"name\";s:13:\"node_revision\";}s:9:\"node_type\";a:4:{s:6:\"fields\";a:13:{s:4:\"type\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:32;s:8:\"not null\";b:1;}s:4:\"name\";a:5:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";s:12:\"translatable\";b:1;}s:4:\"base\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;}s:6:\"module\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;}s:11:\"description\";a:4:{s:4:\"type\";s:4:\"text\";s:8:\"not null\";b:1;s:4:\"size\";s:6:\"medium\";s:12:\"translatable\";b:1;}s:4:\"help\";a:4:{s:4:\"type\";s:4:\"text\";s:8:\"not null\";b:1;s:4:\"size\";s:6:\"medium\";s:12:\"translatable\";b:1;}s:9:\"has_title\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:4:\"size\";s:4:\"tiny\";}s:11:\"title_label\";a:5:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";s:12:\"translatable\";b:1;}s:6:\"custom\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;s:4:\"size\";s:4:\"tiny\";}s:8:\"modified\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;s:4:\"size\";s:4:\"tiny\";}s:6:\"locked\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;s:4:\"size\";s:4:\"tiny\";}s:8:\"disabled\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;s:4:\"size\";s:4:\"tiny\";}s:9:\"orig_type\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}}s:11:\"primary key\";a:1:{i:0;s:4:\"type\";}s:6:\"module\";s:4:\"node\";s:4:\"name\";s:9:\"node_type\";}s:15:\"block_node_type\";a:5:{s:6:\"fields\";a:3:{s:6:\"module\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:64;s:8:\"not null\";b:1;}s:5:\"delta\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:32;s:8:\"not null\";b:1;}s:4:\"type\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:32;s:8:\"not null\";b:1;}}s:11:\"primary key\";a:3:{i:0;s:6:\"module\";i:1;s:5:\"delta\";i:2;s:4:\"type\";}s:7:\"indexes\";a:1:{s:4:\"type\";a:1:{i:0;s:4:\"type\";}}s:6:\"module\";s:4:\"node\";s:4:\"name\";s:15:\"block_node_type\";}s:7:\"history\";a:5:{s:6:\"fields\";a:3:{s:3:\"uid\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:3:\"nid\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:9:\"timestamp\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}}s:11:\"primary key\";a:2:{i:0;s:3:\"uid\";i:1;s:3:\"nid\";}s:7:\"indexes\";a:1:{s:3:\"nid\";a:1:{i:0;s:3:\"nid\";}}s:6:\"module\";s:4:\"node\";s:4:\"name\";s:7:\"history\";}s:11:\"rdf_mapping\";a:4:{s:6:\"fields\";a:3:{s:4:\"type\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:128;s:8:\"not null\";b:1;}s:6:\"bundle\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:128;s:8:\"not null\";b:1;}s:7:\"mapping\";a:4:{s:4:\"type\";s:4:\"blob\";s:8:\"not null\";b:0;s:4:\"size\";s:3:\"big\";s:9:\"serialize\";b:1;}}s:11:\"primary key\";a:2:{i:0;s:4:\"type\";i:1;s:6:\"bundle\";}s:6:\"module\";s:3:\"rdf\";s:4:\"name\";s:11:\"rdf_mapping\";}s:14:\"search_dataset\";a:4:{s:6:\"fields\";a:4:{s:3:\"sid\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:4:\"type\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:16;s:8:\"not null\";b:1;}s:4:\"data\";a:3:{s:4:\"type\";s:4:\"text\";s:8:\"not null\";b:1;s:4:\"size\";s:3:\"big\";}s:7:\"reindex\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}}s:11:\"primary key\";a:2:{i:0;s:3:\"sid\";i:1;s:4:\"type\";}s:6:\"module\";s:6:\"search\";s:4:\"name\";s:14:\"search_dataset\";}s:12:\"search_index\";a:6:{s:6:\"fields\";a:4:{s:4:\"word\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:50;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:3:\"sid\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:4:\"type\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:16;s:8:\"not null\";b:1;}s:5:\"score\";a:2:{s:4:\"type\";s:5:\"float\";s:8:\"not null\";b:0;}}s:7:\"indexes\";a:1:{s:8:\"sid_type\";a:2:{i:0;s:3:\"sid\";i:1;s:4:\"type\";}}s:12:\"foreign keys\";a:1:{s:14:\"search_dataset\";a:2:{s:5:\"table\";s:14:\"search_dataset\";s:7:\"columns\";a:2:{s:3:\"sid\";s:3:\"sid\";s:4:\"type\";s:4:\"type\";}}}s:11:\"primary key\";a:3:{i:0;s:4:\"word\";i:1;s:3:\"sid\";i:2;s:4:\"type\";}s:6:\"module\";s:6:\"search\";s:4:\"name\";s:12:\"search_index\";}s:12:\"search_total\";a:4:{s:6:\"fields\";a:2:{s:4:\"word\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:50;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:5:\"count\";a:2:{s:4:\"type\";s:5:\"float\";s:8:\"not null\";b:0;}}s:11:\"primary key\";a:1:{i:0;s:4:\"word\";}s:6:\"module\";s:6:\"search\";s:4:\"name\";s:12:\"search_total\";}s:17:\"search_node_links\";a:5:{s:6:\"fields\";a:4:{s:3:\"sid\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:4:\"type\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:16;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:3:\"nid\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:7:\"caption\";a:3:{s:4:\"type\";s:4:\"text\";s:4:\"size\";s:3:\"big\";s:8:\"not null\";b:0;}}s:11:\"primary key\";a:3:{i:0;s:3:\"sid\";i:1;s:4:\"type\";i:2;s:3:\"nid\";}s:7:\"indexes\";a:1:{s:3:\"nid\";a:1:{i:0;s:3:\"nid\";}}s:6:\"module\";s:6:\"search\";s:4:\"name\";s:17:\"search_node_links\";}s:12:\"shortcut_set\";a:5:{s:6:\"fields\";a:2:{s:8:\"set_name\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:32;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:5:\"title\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}}s:11:\"primary key\";a:1:{i:0;s:8:\"set_name\";}s:12:\"foreign keys\";a:1:{s:9:\"menu_name\";a:2:{s:5:\"table\";s:10:\"menu_links\";s:7:\"columns\";a:1:{s:8:\"set_name\";s:9:\"menu_name\";}}}s:6:\"module\";s:8:\"shortcut\";s:4:\"name\";s:12:\"shortcut_set\";}s:18:\"shortcut_set_users\";a:6:{s:6:\"fields\";a:2:{s:3:\"uid\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:8:\"set_name\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:32;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}}s:11:\"primary key\";a:1:{i:0;s:3:\"uid\";}s:7:\"indexes\";a:1:{s:8:\"set_name\";a:1:{i:0;s:8:\"set_name\";}}s:12:\"foreign keys\";a:2:{s:8:\"set_user\";a:2:{s:5:\"table\";s:5:\"users\";s:7:\"columns\";a:1:{s:3:\"uid\";s:3:\"uid\";}}s:8:\"set_name\";a:2:{s:5:\"table\";s:12:\"shortcut_set\";s:7:\"columns\";a:1:{s:8:\"set_name\";s:8:\"set_name\";}}}s:6:\"module\";s:8:\"shortcut\";s:4:\"name\";s:18:\"shortcut_set_users\";}s:8:\"variable\";a:4:{s:6:\"fields\";a:2:{s:4:\"name\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:128;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:5:\"value\";a:4:{s:4:\"type\";s:4:\"blob\";s:8:\"not null\";b:1;s:4:\"size\";s:3:\"big\";s:12:\"translatable\";b:1;}}s:11:\"primary key\";a:1:{i:0;s:4:\"name\";}s:6:\"module\";s:6:\"system\";s:4:\"name\";s:8:\"variable\";}s:7:\"actions\";a:4:{s:6:\"fields\";a:5:{s:3:\"aid\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:1:\"0\";}s:4:\"type\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:32;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:8:\"callback\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:10:\"parameters\";a:3:{s:4:\"type\";s:4:\"blob\";s:8:\"not null\";b:1;s:4:\"size\";s:3:\"big\";}s:5:\"label\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:1:\"0\";}}s:11:\"primary key\";a:1:{i:0;s:3:\"aid\";}s:6:\"module\";s:6:\"system\";s:4:\"name\";s:7:\"actions\";}s:5:\"batch\";a:5:{s:6:\"fields\";a:4:{s:3:\"bid\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:5:\"token\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:64;s:8:\"not null\";b:1;}s:9:\"timestamp\";a:2:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;}s:5:\"batch\";a:3:{s:4:\"type\";s:4:\"blob\";s:8:\"not null\";b:0;s:4:\"size\";s:3:\"big\";}}s:11:\"primary key\";a:1:{i:0;s:3:\"bid\";}s:7:\"indexes\";a:1:{s:5:\"token\";a:1:{i:0;s:5:\"token\";}}s:6:\"module\";s:6:\"system\";s:4:\"name\";s:5:\"batch\";}s:11:\"blocked_ips\";a:5:{s:6:\"fields\";a:2:{s:3:\"iid\";a:3:{s:4:\"type\";s:6:\"serial\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:2:\"ip\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:40;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}}s:7:\"indexes\";a:1:{s:10:\"blocked_ip\";a:1:{i:0;s:2:\"ip\";}}s:11:\"primary key\";a:1:{i:0;s:3:\"iid\";}s:6:\"module\";s:6:\"system\";s:4:\"name\";s:11:\"blocked_ips\";}s:5:\"cache\";a:5:{s:6:\"fields\";a:5:{s:3:\"cid\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:4:\"data\";a:3:{s:4:\"type\";s:4:\"blob\";s:8:\"not null\";b:0;s:4:\"size\";s:3:\"big\";}s:6:\"expire\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:7:\"created\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:10:\"serialized\";a:4:{s:4:\"type\";s:3:\"int\";s:4:\"size\";s:5:\"small\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}}s:7:\"indexes\";a:1:{s:6:\"expire\";a:1:{i:0;s:6:\"expire\";}}s:11:\"primary key\";a:1:{i:0;s:3:\"cid\";}s:6:\"module\";s:6:\"system\";s:4:\"name\";s:5:\"cache\";}s:15:\"cache_bootstrap\";a:5:{s:6:\"fields\";a:5:{s:3:\"cid\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:4:\"data\";a:3:{s:4:\"type\";s:4:\"blob\";s:8:\"not null\";b:0;s:4:\"size\";s:3:\"big\";}s:6:\"expire\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:7:\"created\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:10:\"serialized\";a:4:{s:4:\"type\";s:3:\"int\";s:4:\"size\";s:5:\"small\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}}s:7:\"indexes\";a:1:{s:6:\"expire\";a:1:{i:0;s:6:\"expire\";}}s:11:\"primary key\";a:1:{i:0;s:3:\"cid\";}s:6:\"module\";s:6:\"system\";s:4:\"name\";s:15:\"cache_bootstrap\";}s:10:\"cache_form\";a:5:{s:6:\"fields\";a:5:{s:3:\"cid\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:4:\"data\";a:3:{s:4:\"type\";s:4:\"blob\";s:8:\"not null\";b:0;s:4:\"size\";s:3:\"big\";}s:6:\"expire\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:7:\"created\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:10:\"serialized\";a:4:{s:4:\"type\";s:3:\"int\";s:4:\"size\";s:5:\"small\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}}s:7:\"indexes\";a:1:{s:6:\"expire\";a:1:{i:0;s:6:\"expire\";}}s:11:\"primary key\";a:1:{i:0;s:3:\"cid\";}s:6:\"module\";s:6:\"system\";s:4:\"name\";s:10:\"cache_form\";}s:10:\"cache_page\";a:5:{s:6:\"fields\";a:5:{s:3:\"cid\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:4:\"data\";a:3:{s:4:\"type\";s:4:\"blob\";s:8:\"not null\";b:0;s:4:\"size\";s:3:\"big\";}s:6:\"expire\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:7:\"created\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:10:\"serialized\";a:4:{s:4:\"type\";s:3:\"int\";s:4:\"size\";s:5:\"small\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}}s:7:\"indexes\";a:1:{s:6:\"expire\";a:1:{i:0;s:6:\"expire\";}}s:11:\"primary key\";a:1:{i:0;s:3:\"cid\";}s:6:\"module\";s:6:\"system\";s:4:\"name\";s:10:\"cache_page\";}s:10:\"cache_menu\";a:5:{s:6:\"fields\";a:5:{s:3:\"cid\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:4:\"data\";a:3:{s:4:\"type\";s:4:\"blob\";s:8:\"not null\";b:0;s:4:\"size\";s:3:\"big\";}s:6:\"expire\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:7:\"created\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:10:\"serialized\";a:4:{s:4:\"type\";s:3:\"int\";s:4:\"size\";s:5:\"small\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}}s:7:\"indexes\";a:1:{s:6:\"expire\";a:1:{i:0;s:6:\"expire\";}}s:11:\"primary key\";a:1:{i:0;s:3:\"cid\";}s:6:\"module\";s:6:\"system\";s:4:\"name\";s:10:\"cache_menu\";}s:10:\"cache_path\";a:5:{s:6:\"fields\";a:5:{s:3:\"cid\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:4:\"data\";a:3:{s:4:\"type\";s:4:\"blob\";s:8:\"not null\";b:0;s:4:\"size\";s:3:\"big\";}s:6:\"expire\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:7:\"created\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:10:\"serialized\";a:4:{s:4:\"type\";s:3:\"int\";s:4:\"size\";s:5:\"small\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}}s:7:\"indexes\";a:1:{s:6:\"expire\";a:1:{i:0;s:6:\"expire\";}}s:11:\"primary key\";a:1:{i:0;s:3:\"cid\";}s:6:\"module\";s:6:\"system\";s:4:\"name\";s:10:\"cache_path\";}s:16:\"date_format_type\";a:5:{s:6:\"fields\";a:3:{s:4:\"type\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:64;s:8:\"not null\";b:1;}s:5:\"title\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;}s:6:\"locked\";a:4:{s:4:\"type\";s:3:\"int\";s:4:\"size\";s:4:\"tiny\";s:7:\"default\";i:0;s:8:\"not null\";b:1;}}s:11:\"primary key\";a:1:{i:0;s:4:\"type\";}s:7:\"indexes\";a:1:{s:5:\"title\";a:1:{i:0;s:5:\"title\";}}s:6:\"module\";s:6:\"system\";s:4:\"name\";s:16:\"date_format_type\";}s:12:\"date_formats\";a:5:{s:6:\"fields\";a:4:{s:4:\"dfid\";a:3:{s:4:\"type\";s:6:\"serial\";s:8:\"not null\";b:1;s:8:\"unsigned\";b:1;}s:6:\"format\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:100;s:8:\"not null\";b:1;}s:4:\"type\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:64;s:8:\"not null\";b:1;}s:6:\"locked\";a:4:{s:4:\"type\";s:3:\"int\";s:4:\"size\";s:4:\"tiny\";s:7:\"default\";i:0;s:8:\"not null\";b:1;}}s:11:\"primary key\";a:1:{i:0;s:4:\"dfid\";}s:11:\"unique keys\";a:1:{s:7:\"formats\";a:2:{i:0;s:6:\"format\";i:1;s:4:\"type\";}}s:6:\"module\";s:6:\"system\";s:4:\"name\";s:12:\"date_formats\";}s:18:\"date_format_locale\";a:4:{s:6:\"fields\";a:3:{s:6:\"format\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:100;s:8:\"not null\";b:1;}s:4:\"type\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:64;s:8:\"not null\";b:1;}s:8:\"language\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:12;s:8:\"not null\";b:1;}}s:11:\"primary key\";a:2:{i:0;s:4:\"type\";i:1;s:8:\"language\";}s:6:\"module\";s:6:\"system\";s:4:\"name\";s:18:\"date_format_locale\";}s:12:\"file_managed\";a:7:{s:6:\"fields\";a:8:{s:3:\"fid\";a:3:{s:4:\"type\";s:6:\"serial\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:3:\"uid\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:8:\"filename\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:3:\"uri\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:8:\"filemime\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:8:\"filesize\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:6:\"status\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;s:4:\"size\";s:4:\"tiny\";}s:9:\"timestamp\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}}s:7:\"indexes\";a:3:{s:3:\"uid\";a:1:{i:0;s:3:\"uid\";}s:6:\"status\";a:1:{i:0;s:6:\"status\";}s:9:\"timestamp\";a:1:{i:0;s:9:\"timestamp\";}}s:11:\"unique keys\";a:1:{s:3:\"uri\";a:1:{i:0;s:3:\"uri\";}}s:11:\"primary key\";a:1:{i:0;s:3:\"fid\";}s:12:\"foreign keys\";a:1:{s:10:\"file_owner\";a:2:{s:5:\"table\";s:5:\"users\";s:7:\"columns\";a:1:{s:3:\"uid\";s:3:\"uid\";}}}s:6:\"module\";s:6:\"system\";s:4:\"name\";s:12:\"file_managed\";}s:10:\"file_usage\";a:5:{s:6:\"fields\";a:5:{s:3:\"fid\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:6:\"module\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:4:\"type\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:64;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:2:\"id\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:5:\"count\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}}s:11:\"primary key\";a:4:{i:0;s:3:\"fid\";i:1;s:4:\"type\";i:2;s:2:\"id\";i:3;s:6:\"module\";}s:7:\"indexes\";a:3:{s:7:\"type_id\";a:2:{i:0;s:4:\"type\";i:1;s:2:\"id\";}s:9:\"fid_count\";a:2:{i:0;s:3:\"fid\";i:1;s:5:\"count\";}s:10:\"fid_module\";a:2:{i:0;s:3:\"fid\";i:1;s:6:\"module\";}}s:6:\"module\";s:6:\"system\";s:4:\"name\";s:10:\"file_usage\";}s:5:\"flood\";a:5:{s:6:\"fields\";a:5:{s:3:\"fid\";a:2:{s:4:\"type\";s:6:\"serial\";s:8:\"not null\";b:1;}s:5:\"event\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:64;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:10:\"identifier\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:128;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:9:\"timestamp\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:10:\"expiration\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}}s:11:\"primary key\";a:1:{i:0;s:3:\"fid\";}s:7:\"indexes\";a:2:{s:5:\"allow\";a:3:{i:0;s:5:\"event\";i:1;s:10:\"identifier\";i:2;s:9:\"timestamp\";}s:5:\"purge\";a:1:{i:0;s:10:\"expiration\";}}s:6:\"module\";s:6:\"system\";s:4:\"name\";s:5:\"flood\";}s:11:\"menu_router\";a:5:{s:6:\"fields\";a:23:{s:4:\"path\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:14:\"load_functions\";a:2:{s:4:\"type\";s:4:\"blob\";s:8:\"not null\";b:1;}s:16:\"to_arg_functions\";a:2:{s:4:\"type\";s:4:\"blob\";s:8:\"not null\";b:1;}s:15:\"access_callback\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:16:\"access_arguments\";a:2:{s:4:\"type\";s:4:\"blob\";s:8:\"not null\";b:0;}s:13:\"page_callback\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:14:\"page_arguments\";a:2:{s:4:\"type\";s:4:\"blob\";s:8:\"not null\";b:0;}s:17:\"delivery_callback\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:3:\"fit\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:12:\"number_parts\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;s:4:\"size\";s:5:\"small\";}s:7:\"context\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:10:\"tab_parent\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:8:\"tab_root\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:5:\"title\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:14:\"title_callback\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:15:\"title_arguments\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:14:\"theme_callback\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:15:\"theme_arguments\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:4:\"type\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:11:\"description\";a:2:{s:4:\"type\";s:4:\"text\";s:8:\"not null\";b:1;}s:8:\"position\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:6:\"weight\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:12:\"include_file\";a:2:{s:4:\"type\";s:4:\"text\";s:4:\"size\";s:6:\"medium\";}}s:7:\"indexes\";a:3:{s:3:\"fit\";a:1:{i:0;s:3:\"fit\";}s:10:\"tab_parent\";a:3:{i:0;a:2:{i:0;s:10:\"tab_parent\";i:1;i:64;}i:1;s:6:\"weight\";i:2;s:5:\"title\";}s:21:\"tab_root_weight_title\";a:3:{i:0;a:2:{i:0;s:8:\"tab_root\";i:1;i:64;}i:1;s:6:\"weight\";i:2;s:5:\"title\";}}s:11:\"primary key\";a:1:{i:0;s:4:\"path\";}s:6:\"module\";s:6:\"system\";s:4:\"name\";s:11:\"menu_router\";}s:10:\"menu_links\";a:5:{s:6:\"fields\";a:25:{s:9:\"menu_name\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:32;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:4:\"mlid\";a:3:{s:4:\"type\";s:6:\"serial\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:4:\"plid\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:9:\"link_path\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:11:\"router_path\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:10:\"link_title\";a:5:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";s:12:\"translatable\";b:1;}s:7:\"options\";a:3:{s:4:\"type\";s:4:\"blob\";s:8:\"not null\";b:0;s:12:\"translatable\";b:1;}s:6:\"module\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:6:\"system\";}s:6:\"hidden\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;s:4:\"size\";s:5:\"small\";}s:8:\"external\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;s:4:\"size\";s:5:\"small\";}s:12:\"has_children\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;s:4:\"size\";s:5:\"small\";}s:8:\"expanded\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;s:4:\"size\";s:5:\"small\";}s:6:\"weight\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:5:\"depth\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;s:4:\"size\";s:5:\"small\";}s:10:\"customized\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;s:4:\"size\";s:5:\"small\";}s:2:\"p1\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:2:\"p2\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:2:\"p3\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:2:\"p4\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:2:\"p5\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:2:\"p6\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:2:\"p7\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:2:\"p8\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:2:\"p9\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:7:\"updated\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;s:4:\"size\";s:5:\"small\";}}s:7:\"indexes\";a:4:{s:9:\"path_menu\";a:2:{i:0;a:2:{i:0;s:9:\"link_path\";i:1;i:128;}i:1;s:9:\"menu_name\";}s:22:\"menu_plid_expand_child\";a:4:{i:0;s:9:\"menu_name\";i:1;s:4:\"plid\";i:2;s:8:\"expanded\";i:3;s:12:\"has_children\";}s:12:\"menu_parents\";a:10:{i:0;s:9:\"menu_name\";i:1;s:2:\"p1\";i:2;s:2:\"p2\";i:3;s:2:\"p3\";i:4;s:2:\"p4\";i:5;s:2:\"p5\";i:6;s:2:\"p6\";i:7;s:2:\"p7\";i:8;s:2:\"p8\";i:9;s:2:\"p9\";}s:11:\"router_path\";a:1:{i:0;a:2:{i:0;s:11:\"router_path\";i:1;i:128;}}}s:11:\"primary key\";a:1:{i:0;s:4:\"mlid\";}s:6:\"module\";s:6:\"system\";s:4:\"name\";s:10:\"menu_links\";}s:5:\"queue\";a:5:{s:6:\"fields\";a:5:{s:7:\"item_id\";a:3:{s:4:\"type\";s:6:\"serial\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:4:\"name\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:4:\"data\";a:4:{s:4:\"type\";s:4:\"blob\";s:8:\"not null\";b:0;s:4:\"size\";s:3:\"big\";s:9:\"serialize\";b:1;}s:6:\"expire\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:7:\"created\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}}s:11:\"primary key\";a:1:{i:0;s:7:\"item_id\";}s:7:\"indexes\";a:2:{s:12:\"name_created\";a:2:{i:0;s:4:\"name\";i:1;s:7:\"created\";}s:6:\"expire\";a:1:{i:0;s:6:\"expire\";}}s:6:\"module\";s:6:\"system\";s:4:\"name\";s:5:\"queue\";}s:8:\"registry\";a:5:{s:6:\"fields\";a:5:{s:4:\"name\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:4:\"type\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:9;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:8:\"filename\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;}s:6:\"module\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:6:\"weight\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}}s:11:\"primary key\";a:2:{i:0;s:4:\"name\";i:1;s:4:\"type\";}s:7:\"indexes\";a:1:{s:4:\"hook\";a:3:{i:0;s:4:\"type\";i:1;s:6:\"weight\";i:2;s:6:\"module\";}}s:6:\"module\";s:6:\"system\";s:4:\"name\";s:8:\"registry\";}s:13:\"registry_file\";a:4:{s:6:\"fields\";a:2:{s:8:\"filename\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;}s:4:\"hash\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:64;s:8:\"not null\";b:1;}}s:11:\"primary key\";a:1:{i:0;s:8:\"filename\";}s:6:\"module\";s:6:\"system\";s:4:\"name\";s:13:\"registry_file\";}s:9:\"semaphore\";a:5:{s:6:\"fields\";a:3:{s:4:\"name\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:5:\"value\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:6:\"expire\";a:3:{s:4:\"type\";s:5:\"float\";s:4:\"size\";s:3:\"big\";s:8:\"not null\";b:1;}}s:7:\"indexes\";a:2:{s:5:\"value\";a:1:{i:0;s:5:\"value\";}s:6:\"expire\";a:1:{i:0;s:6:\"expire\";}}s:11:\"primary key\";a:1:{i:0;s:4:\"name\";}s:6:\"module\";s:6:\"system\";s:4:\"name\";s:9:\"semaphore\";}s:9:\"sequences\";a:4:{s:6:\"fields\";a:1:{s:5:\"value\";a:3:{s:4:\"type\";s:6:\"serial\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}}s:11:\"primary key\";a:1:{i:0;s:5:\"value\";}s:6:\"module\";s:6:\"system\";s:4:\"name\";s:9:\"sequences\";}s:8:\"sessions\";a:6:{s:6:\"fields\";a:7:{s:3:\"uid\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:3:\"sid\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:128;s:8:\"not null\";b:1;}s:4:\"ssid\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:128;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:8:\"hostname\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:128;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:9:\"timestamp\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:5:\"cache\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:7:\"session\";a:3:{s:4:\"type\";s:4:\"blob\";s:8:\"not null\";b:0;s:4:\"size\";s:3:\"big\";}}s:11:\"primary key\";a:2:{i:0;s:3:\"sid\";i:1;s:4:\"ssid\";}s:7:\"indexes\";a:3:{s:9:\"timestamp\";a:1:{i:0;s:9:\"timestamp\";}s:3:\"uid\";a:1:{i:0;s:3:\"uid\";}s:4:\"ssid\";a:1:{i:0;s:4:\"ssid\";}}s:12:\"foreign keys\";a:1:{s:12:\"session_user\";a:2:{s:5:\"table\";s:5:\"users\";s:7:\"columns\";a:1:{s:3:\"uid\";s:3:\"uid\";}}}s:6:\"module\";s:6:\"system\";s:4:\"name\";s:8:\"sessions\";}s:6:\"system\";a:5:{s:6:\"fields\";a:9:{s:8:\"filename\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:4:\"name\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:4:\"type\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:12;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:5:\"owner\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:6:\"status\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:9:\"bootstrap\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:14:\"schema_version\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:-1;s:4:\"size\";s:5:\"small\";}s:6:\"weight\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:4:\"info\";a:2:{s:4:\"type\";s:4:\"blob\";s:8:\"not null\";b:0;}}s:11:\"primary key\";a:1:{i:0;s:8:\"filename\";}s:7:\"indexes\";a:2:{s:11:\"system_list\";a:5:{i:0;s:6:\"status\";i:1;s:9:\"bootstrap\";i:2;s:4:\"type\";i:3;s:6:\"weight\";i:4;s:4:\"name\";}s:9:\"type_name\";a:2:{i:0;s:4:\"type\";i:1;s:4:\"name\";}}s:6:\"module\";s:6:\"system\";s:4:\"name\";s:6:\"system\";}s:9:\"url_alias\";a:5:{s:6:\"fields\";a:4:{s:3:\"pid\";a:3:{s:4:\"type\";s:6:\"serial\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:6:\"source\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:5:\"alias\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:8:\"language\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:12;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}}s:11:\"primary key\";a:1:{i:0;s:3:\"pid\";}s:7:\"indexes\";a:2:{s:18:\"alias_language_pid\";a:3:{i:0;s:5:\"alias\";i:1;s:8:\"language\";i:2;s:3:\"pid\";}s:19:\"source_language_pid\";a:3:{i:0;s:6:\"source\";i:1;s:8:\"language\";i:2;s:3:\"pid\";}}s:6:\"module\";s:6:\"system\";s:4:\"name\";s:9:\"url_alias\";}s:18:\"taxonomy_term_data\";a:6:{s:6:\"fields\";a:6:{s:3:\"tid\";a:3:{s:4:\"type\";s:6:\"serial\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:3:\"vid\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:4:\"name\";a:5:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";s:12:\"translatable\";b:1;}s:11:\"description\";a:4:{s:4:\"type\";s:4:\"text\";s:8:\"not null\";b:0;s:4:\"size\";s:3:\"big\";s:12:\"translatable\";b:1;}s:6:\"format\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:0;}s:6:\"weight\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}}s:11:\"primary key\";a:1:{i:0;s:3:\"tid\";}s:12:\"foreign keys\";a:1:{s:10:\"vocabulary\";a:2:{s:5:\"table\";s:19:\"taxonomy_vocabulary\";s:7:\"columns\";a:1:{s:3:\"vid\";s:3:\"vid\";}}}s:7:\"indexes\";a:3:{s:13:\"taxonomy_tree\";a:3:{i:0;s:3:\"vid\";i:1;s:6:\"weight\";i:2;s:4:\"name\";}s:8:\"vid_name\";a:2:{i:0;s:3:\"vid\";i:1;s:4:\"name\";}s:4:\"name\";a:1:{i:0;s:4:\"name\";}}s:6:\"module\";s:8:\"taxonomy\";s:4:\"name\";s:18:\"taxonomy_term_data\";}s:23:\"taxonomy_term_hierarchy\";a:6:{s:6:\"fields\";a:2:{s:3:\"tid\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:6:\"parent\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}}s:7:\"indexes\";a:1:{s:6:\"parent\";a:1:{i:0;s:6:\"parent\";}}s:12:\"foreign keys\";a:1:{s:18:\"taxonomy_term_data\";a:2:{s:5:\"table\";s:18:\"taxonomy_term_data\";s:7:\"columns\";a:1:{s:3:\"tid\";s:3:\"tid\";}}}s:11:\"primary key\";a:2:{i:0;s:3:\"tid\";i:1;s:6:\"parent\";}s:6:\"module\";s:8:\"taxonomy\";s:4:\"name\";s:23:\"taxonomy_term_hierarchy\";}s:19:\"taxonomy_vocabulary\";a:6:{s:6:\"fields\";a:7:{s:3:\"vid\";a:3:{s:4:\"type\";s:6:\"serial\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:4:\"name\";a:5:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";s:12:\"translatable\";b:1;}s:12:\"machine_name\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:11:\"description\";a:4:{s:4:\"type\";s:4:\"text\";s:8:\"not null\";b:0;s:4:\"size\";s:3:\"big\";s:12:\"translatable\";b:1;}s:9:\"hierarchy\";a:5:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;s:4:\"size\";s:4:\"tiny\";}s:6:\"module\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:6:\"weight\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}}s:11:\"primary key\";a:1:{i:0;s:3:\"vid\";}s:7:\"indexes\";a:1:{s:4:\"list\";a:2:{i:0;s:6:\"weight\";i:1;s:4:\"name\";}}s:11:\"unique keys\";a:1:{s:12:\"machine_name\";a:1:{i:0;s:12:\"machine_name\";}}s:6:\"module\";s:8:\"taxonomy\";s:4:\"name\";s:19:\"taxonomy_vocabulary\";}s:14:\"taxonomy_index\";a:5:{s:6:\"fields\";a:4:{s:3:\"nid\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:3:\"tid\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:6:\"sticky\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:0;s:7:\"default\";i:0;s:4:\"size\";s:4:\"tiny\";}s:7:\"created\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}}s:7:\"indexes\";a:2:{s:9:\"term_node\";a:3:{i:0;s:3:\"tid\";i:1;s:6:\"sticky\";i:2;s:7:\"created\";}s:3:\"nid\";a:1:{i:0;s:3:\"nid\";}}s:12:\"foreign keys\";a:2:{s:12:\"tracked_node\";a:2:{s:5:\"table\";s:4:\"node\";s:7:\"columns\";a:1:{s:3:\"nid\";s:3:\"nid\";}}s:4:\"term\";a:2:{s:5:\"table\";s:18:\"taxonomy_term_data\";s:7:\"columns\";a:1:{s:3:\"tid\";s:3:\"tid\";}}}s:6:\"module\";s:8:\"taxonomy\";s:4:\"name\";s:14:\"taxonomy_index\";}s:7:\"authmap\";a:6:{s:6:\"fields\";a:4:{s:3:\"aid\";a:3:{s:4:\"type\";s:6:\"serial\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:3:\"uid\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:8:\"authname\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:128;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:6:\"module\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:128;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}}s:11:\"unique keys\";a:1:{s:8:\"authname\";a:1:{i:0;s:8:\"authname\";}}s:11:\"primary key\";a:1:{i:0;s:3:\"aid\";}s:12:\"foreign keys\";a:1:{s:4:\"user\";a:2:{s:5:\"table\";s:5:\"users\";s:7:\"columns\";a:1:{s:3:\"uid\";s:3:\"uid\";}}}s:6:\"module\";s:4:\"user\";s:4:\"name\";s:7:\"authmap\";}s:15:\"role_permission\";a:6:{s:6:\"fields\";a:3:{s:3:\"rid\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:10:\"permission\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:128;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:6:\"module\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}}s:11:\"primary key\";a:2:{i:0;s:3:\"rid\";i:1;s:10:\"permission\";}s:7:\"indexes\";a:1:{s:10:\"permission\";a:1:{i:0;s:10:\"permission\";}}s:12:\"foreign keys\";a:1:{s:4:\"role\";a:2:{s:5:\"table\";s:5:\"roles\";s:7:\"columns\";a:1:{s:3:\"rid\";s:3:\"rid\";}}}s:6:\"module\";s:4:\"user\";s:4:\"name\";s:15:\"role_permission\";}s:4:\"role\";a:6:{s:6:\"fields\";a:3:{s:3:\"rid\";a:3:{s:4:\"type\";s:6:\"serial\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:4:\"name\";a:5:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:64;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";s:12:\"translatable\";b:1;}s:6:\"weight\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}}s:11:\"unique keys\";a:1:{s:4:\"name\";a:1:{i:0;s:4:\"name\";}}s:11:\"primary key\";a:1:{i:0;s:3:\"rid\";}s:7:\"indexes\";a:1:{s:11:\"name_weight\";a:2:{i:0;s:4:\"name\";i:1;s:6:\"weight\";}}s:6:\"module\";s:4:\"user\";s:4:\"name\";s:4:\"role\";}s:5:\"users\";a:7:{s:6:\"fields\";a:16:{s:3:\"uid\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:4:\"name\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:60;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:4:\"pass\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:128;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:4:\"mail\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:254;s:8:\"not null\";b:0;s:7:\"default\";s:0:\"\";}s:5:\"theme\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:9:\"signature\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:16:\"signature_format\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:0;}s:7:\"created\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:6:\"access\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:5:\"login\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:6:\"status\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;s:4:\"size\";s:4:\"tiny\";}s:8:\"timezone\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:32;s:8:\"not null\";b:0;}s:8:\"language\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:12;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:7:\"picture\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:4:\"init\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:254;s:8:\"not null\";b:0;s:7:\"default\";s:0:\"\";}s:4:\"data\";a:4:{s:4:\"type\";s:4:\"blob\";s:8:\"not null\";b:0;s:4:\"size\";s:3:\"big\";s:9:\"serialize\";b:1;}}s:7:\"indexes\";a:3:{s:6:\"access\";a:1:{i:0;s:6:\"access\";}s:7:\"created\";a:1:{i:0;s:7:\"created\";}s:4:\"mail\";a:1:{i:0;s:4:\"mail\";}}s:11:\"unique keys\";a:1:{s:4:\"name\";a:1:{i:0;s:4:\"name\";}}s:11:\"primary key\";a:1:{i:0;s:3:\"uid\";}s:12:\"foreign keys\";a:1:{s:16:\"signature_format\";a:2:{s:5:\"table\";s:13:\"filter_format\";s:7:\"columns\";a:1:{s:16:\"signature_format\";s:6:\"format\";}}}s:6:\"module\";s:4:\"user\";s:4:\"name\";s:5:\"users\";}s:11:\"users_roles\";a:6:{s:6:\"fields\";a:2:{s:3:\"uid\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:3:\"rid\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}}s:11:\"primary key\";a:2:{i:0;s:3:\"uid\";i:1;s:3:\"rid\";}s:7:\"indexes\";a:1:{s:3:\"rid\";a:1:{i:0;s:3:\"rid\";}}s:12:\"foreign keys\";a:2:{s:4:\"user\";a:2:{s:5:\"table\";s:5:\"users\";s:7:\"columns\";a:1:{s:3:\"uid\";s:3:\"uid\";}}s:4:\"role\";a:2:{s:5:\"table\";s:5:\"roles\";s:7:\"columns\";a:1:{s:3:\"rid\";s:3:\"rid\";}}}s:6:\"module\";s:4:\"user\";s:4:\"name\";s:11:\"users_roles\";}}',0,1317181162,1);
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_block`
--

DROP TABLE IF EXISTS `cache_block`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_block` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the Block module to store already built...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_block`
--

LOCK TABLES `cache_block` WRITE;
/*!40000 ALTER TABLE `cache_block` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_block` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_bootstrap`
--

DROP TABLE IF EXISTS `cache_bootstrap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_bootstrap` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for data required to bootstrap Drupal, may be...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_bootstrap`
--

LOCK TABLES `cache_bootstrap` WRITE;
/*!40000 ALTER TABLE `cache_bootstrap` DISABLE KEYS */;
INSERT INTO `cache_bootstrap` VALUES ('bootstrap_modules','a:2:{s:5:\"dblog\";O:8:\"stdClass\":2:{s:4:\"name\";s:5:\"dblog\";s:8:\"filename\";s:26:\"modules/dblog/dblog.module\";}s:7:\"overlay\";O:8:\"stdClass\":2:{s:4:\"name\";s:7:\"overlay\";s:8:\"filename\";s:30:\"modules/overlay/overlay.module\";}}',0,1317181162,1);
INSERT INTO `cache_bootstrap` VALUES ('hook_info','a:4:{s:10:\"token_info\";a:1:{s:5:\"group\";s:6:\"tokens\";}s:16:\"token_info_alter\";a:1:{s:5:\"group\";s:6:\"tokens\";}s:6:\"tokens\";a:1:{s:5:\"group\";s:6:\"tokens\";}s:12:\"tokens_alter\";a:1:{s:5:\"group\";s:6:\"tokens\";}}',0,1317181162,1);
INSERT INTO `cache_bootstrap` VALUES ('lookup_cache','a:1:{s:30:\"cDrupalDefaultEntityController\";s:19:\"includes/entity.inc\";}',0,1317181162,1);
INSERT INTO `cache_bootstrap` VALUES ('module_implements','a:32:{s:15:\"stream_wrappers\";a:1:{s:6:\"system\";b:0;}s:23:\"module_implements_alter\";a:0:{}s:21:\"stream_wrappers_alter\";a:0:{}s:17:\"url_inbound_alter\";a:0:{}s:12:\"custom_theme\";a:1:{s:6:\"system\";b:0;}s:4:\"menu\";a:19:{s:5:\"block\";b:0;s:7:\"comment\";b:0;s:9:\"dashboard\";b:0;s:5:\"dblog\";b:0;s:8:\"field_ui\";b:0;s:4:\"file\";b:0;s:6:\"filter\";b:0;s:4:\"help\";b:0;s:5:\"image\";b:0;s:4:\"menu\";b:0;s:4:\"node\";b:0;s:7:\"overlay\";b:0;s:4:\"path\";b:0;s:6:\"search\";b:0;s:8:\"shortcut\";b:0;s:6:\"system\";b:0;s:8:\"taxonomy\";b:0;s:7:\"toolbar\";b:0;s:4:\"user\";b:0;}s:11:\"entity_info\";a:5:{s:7:\"comment\";b:0;s:4:\"node\";b:0;s:6:\"system\";b:0;s:8:\"taxonomy\";b:0;s:4:\"user\";b:0;}s:9:\"node_info\";a:0:{}s:11:\"query_alter\";a:0:{}s:24:\"query_translatable_alter\";a:0:{}s:28:\"query_node_type_access_alter\";a:0:{}s:6:\"schema\";a:15:{s:5:\"block\";b:0;s:7:\"comment\";b:0;s:5:\"dblog\";b:0;s:5:\"field\";b:0;s:17:\"field_sql_storage\";b:0;s:6:\"filter\";b:0;s:5:\"image\";b:0;s:4:\"menu\";b:0;s:4:\"node\";b:0;s:3:\"rdf\";b:0;s:6:\"search\";b:0;s:8:\"shortcut\";b:0;s:6:\"system\";b:0;s:8:\"taxonomy\";b:0;s:4:\"user\";b:0;}s:16:\"field_read_field\";a:0:{}s:12:\"schema_alter\";a:0:{}s:17:\"entity_info_alter\";a:1:{s:3:\"rdf\";b:0;}s:11:\"rdf_mapping\";a:4:{s:7:\"comment\";b:0;s:4:\"node\";b:0;s:8:\"taxonomy\";b:0;s:4:\"user\";b:0;}s:4:\"help\";a:28:{s:5:\"block\";b:0;s:5:\"color\";b:0;s:7:\"comment\";b:0;s:10:\"contextual\";b:0;s:9:\"dashboard\";b:0;s:5:\"dblog\";b:0;s:5:\"field\";b:0;s:17:\"field_sql_storage\";b:0;s:8:\"field_ui\";b:0;s:4:\"file\";b:0;s:6:\"filter\";b:0;s:4:\"help\";b:0;s:5:\"image\";b:0;s:4:\"list\";b:0;s:4:\"menu\";b:0;s:4:\"node\";b:0;s:6:\"number\";b:0;s:7:\"options\";b:0;s:7:\"overlay\";b:0;s:4:\"path\";b:0;s:3:\"rdf\";b:0;s:6:\"search\";b:0;s:8:\"shortcut\";b:0;s:6:\"system\";b:0;s:8:\"taxonomy\";b:0;s:4:\"text\";b:0;s:7:\"toolbar\";b:0;s:4:\"user\";b:0;}s:11:\"search_info\";a:2:{s:4:\"node\";b:0;s:4:\"user\";b:0;}s:15:\"user_categories\";a:1:{s:4:\"user\";b:0;}s:10:\"menu_alter\";a:1:{s:7:\"comment\";b:0;}s:15:\"menu_link_alter\";a:1:{s:4:\"user\";b:0;}s:16:\"menu_link_insert\";a:0:{}s:16:\"menu_link_update\";a:0:{}s:19:\"menu_get_item_alter\";a:0:{}s:18:\"url_outbound_alter\";a:0:{}s:13:\"library_alter\";a:0:{}s:4:\"init\";a:3:{s:5:\"dblog\";b:0;s:7:\"overlay\";b:0;s:6:\"system\";b:0;}s:11:\"admin_paths\";a:7:{s:5:\"block\";b:0;s:4:\"node\";b:0;s:7:\"overlay\";b:0;s:8:\"shortcut\";b:0;s:6:\"system\";b:0;s:8:\"taxonomy\";b:0;s:4:\"user\";b:0;}s:17:\"admin_paths_alter\";a:0:{}s:22:\"menu_site_status_alter\";a:1:{s:4:\"user\";b:0;}s:28:\"page_delivery_callback_alter\";a:1:{s:7:\"overlay\";b:0;}s:4:\"exit\";a:1:{s:7:\"overlay\";b:0;}}',0,1317181162,1);
INSERT INTO `cache_bootstrap` VALUES ('system_list','a:3:{s:14:\"module_enabled\";a:29:{s:5:\"block\";O:8:\"stdClass\":9:{s:8:\"filename\";s:26:\"modules/block/block.module\";s:4:\"name\";s:5:\"block\";s:4:\"type\";s:6:\"module\";s:5:\"owner\";s:0:\"\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:4:\"7008\";s:6:\"weight\";s:2:\"-5\";s:4:\"info\";a:12:{s:4:\"name\";s:5:\"Block\";s:11:\"description\";s:140:\"Controls the visual building blocks a page is constructed with. Blocks are boxes of content rendered into an area, or region, of a web page.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:10:\"block.test\";}s:9:\"configure\";s:21:\"admin/structure/block\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}}s:5:\"color\";O:8:\"stdClass\":9:{s:8:\"filename\";s:26:\"modules/color/color.module\";s:4:\"name\";s:5:\"color\";s:4:\"type\";s:6:\"module\";s:5:\"owner\";s:0:\"\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:4:\"7001\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:11:{s:4:\"name\";s:5:\"Color\";s:11:\"description\";s:70:\"Allows administrators to change the color scheme of compatible themes.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:10:\"color.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}}s:7:\"comment\";O:8:\"stdClass\":9:{s:8:\"filename\";s:30:\"modules/comment/comment.module\";s:4:\"name\";s:7:\"comment\";s:4:\"type\";s:6:\"module\";s:5:\"owner\";s:0:\"\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:4:\"7008\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:13:{s:4:\"name\";s:7:\"Comment\";s:11:\"description\";s:57:\"Allows users to comment on and discuss published content.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:4:\"text\";}s:5:\"files\";a:2:{i:0;s:14:\"comment.module\";i:1;s:12:\"comment.test\";}s:9:\"configure\";s:21:\"admin/content/comment\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:11:\"comment.css\";s:27:\"modules/comment/comment.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}}s:10:\"contextual\";O:8:\"stdClass\":9:{s:8:\"filename\";s:36:\"modules/contextual/contextual.module\";s:4:\"name\";s:10:\"contextual\";s:4:\"type\";s:6:\"module\";s:5:\"owner\";s:0:\"\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:1:\"0\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:11:{s:4:\"name\";s:16:\"Contextual links\";s:11:\"description\";s:75:\"Provides contextual links to perform actions related to elements on a page.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}}s:9:\"dashboard\";O:8:\"stdClass\":9:{s:8:\"filename\";s:34:\"modules/dashboard/dashboard.module\";s:4:\"name\";s:9:\"dashboard\";s:4:\"type\";s:6:\"module\";s:5:\"owner\";s:0:\"\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:1:\"0\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:12:{s:4:\"name\";s:9:\"Dashboard\";s:11:\"description\";s:136:\"Provides a dashboard page in the administrative interface for organizing administrative tasks and tracking information within your site.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:5:\"files\";a:1:{i:0;s:14:\"dashboard.test\";}s:12:\"dependencies\";a:1:{i:0;s:5:\"block\";}s:9:\"configure\";s:25:\"admin/dashboard/customize\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}}s:5:\"dblog\";O:8:\"stdClass\":9:{s:8:\"filename\";s:26:\"modules/dblog/dblog.module\";s:4:\"name\";s:5:\"dblog\";s:4:\"type\";s:6:\"module\";s:5:\"owner\";s:0:\"\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"1\";s:14:\"schema_version\";s:4:\"7001\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:11:{s:4:\"name\";s:16:\"Database logging\";s:11:\"description\";s:47:\"Logs and records system events to the database.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:10:\"dblog.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}}s:5:\"field\";O:8:\"stdClass\":9:{s:8:\"filename\";s:26:\"modules/field/field.module\";s:4:\"name\";s:5:\"field\";s:4:\"type\";s:6:\"module\";s:5:\"owner\";s:0:\"\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:4:\"7001\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:13:{s:4:\"name\";s:5:\"Field\";s:11:\"description\";s:57:\"Field API to add fields to entities like nodes and users.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:3:{i:0;s:12:\"field.module\";i:1;s:16:\"field.attach.inc\";i:2;s:16:\"tests/field.test\";}s:12:\"dependencies\";a:1:{i:0;s:17:\"field_sql_storage\";}s:8:\"required\";b:1;s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:15:\"theme/field.css\";s:29:\"modules/field/theme/field.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}}s:17:\"field_sql_storage\";O:8:\"stdClass\":9:{s:8:\"filename\";s:64:\"modules/field/modules/field_sql_storage/field_sql_storage.module\";s:4:\"name\";s:17:\"field_sql_storage\";s:4:\"type\";s:6:\"module\";s:5:\"owner\";s:0:\"\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:4:\"7002\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:12:{s:4:\"name\";s:17:\"Field SQL storage\";s:11:\"description\";s:37:\"Stores field data in an SQL database.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:5:\"field\";}s:5:\"files\";a:1:{i:0;s:22:\"field_sql_storage.test\";}s:8:\"required\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}}s:8:\"field_ui\";O:8:\"stdClass\":9:{s:8:\"filename\";s:32:\"modules/field_ui/field_ui.module\";s:4:\"name\";s:8:\"field_ui\";s:4:\"type\";s:6:\"module\";s:5:\"owner\";s:0:\"\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:1:\"0\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:11:{s:4:\"name\";s:8:\"Field UI\";s:11:\"description\";s:33:\"User interface for the Field API.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:5:\"field\";}s:5:\"files\";a:1:{i:0;s:13:\"field_ui.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}}s:4:\"file\";O:8:\"stdClass\":9:{s:8:\"filename\";s:24:\"modules/file/file.module\";s:4:\"name\";s:4:\"file\";s:4:\"type\";s:6:\"module\";s:5:\"owner\";s:0:\"\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:1:\"0\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:11:{s:4:\"name\";s:4:\"File\";s:11:\"description\";s:26:\"Defines a file field type.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:5:\"field\";}s:5:\"files\";a:1:{i:0;s:15:\"tests/file.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}}s:6:\"filter\";O:8:\"stdClass\":9:{s:8:\"filename\";s:28:\"modules/filter/filter.module\";s:4:\"name\";s:6:\"filter\";s:4:\"type\";s:6:\"module\";s:5:\"owner\";s:0:\"\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:4:\"7010\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:13:{s:4:\"name\";s:6:\"Filter\";s:11:\"description\";s:43:\"Filters content in preparation for display.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:11:\"filter.test\";}s:8:\"required\";b:1;s:9:\"configure\";s:28:\"admin/config/content/formats\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}}s:4:\"help\";O:8:\"stdClass\":9:{s:8:\"filename\";s:24:\"modules/help/help.module\";s:4:\"name\";s:4:\"help\";s:4:\"type\";s:6:\"module\";s:5:\"owner\";s:0:\"\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:1:\"0\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:11:{s:4:\"name\";s:4:\"Help\";s:11:\"description\";s:35:\"Manages the display of online help.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:9:\"help.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}}s:5:\"image\";O:8:\"stdClass\":9:{s:8:\"filename\";s:26:\"modules/image/image.module\";s:4:\"name\";s:5:\"image\";s:4:\"type\";s:6:\"module\";s:5:\"owner\";s:0:\"\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:4:\"7001\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:14:{s:4:\"name\";s:5:\"Image\";s:11:\"description\";s:34:\"Provides image manipulation tools.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:4:\"file\";}s:5:\"files\";a:1:{i:0;s:10:\"image.test\";}s:9:\"configure\";s:31:\"admin/config/media/image-styles\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;s:8:\"required\";b:1;s:11:\"explanation\";s:76:\"Field type(s) in use - see <a href=\"/?q=admin/reports/fields\">Field list</a>\";}}s:4:\"list\";O:8:\"stdClass\":9:{s:8:\"filename\";s:38:\"modules/field/modules/list/list.module\";s:4:\"name\";s:4:\"list\";s:4:\"type\";s:6:\"module\";s:5:\"owner\";s:0:\"\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:4:\"7002\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:11:{s:4:\"name\";s:4:\"List\";s:11:\"description\";s:69:\"Defines list field types. Use with Options to create selection lists.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:2:{i:0;s:5:\"field\";i:1;s:7:\"options\";}s:5:\"files\";a:1:{i:0;s:15:\"tests/list.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}}s:4:\"menu\";O:8:\"stdClass\":9:{s:8:\"filename\";s:24:\"modules/menu/menu.module\";s:4:\"name\";s:4:\"menu\";s:4:\"type\";s:6:\"module\";s:5:\"owner\";s:0:\"\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:4:\"7002\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:12:{s:4:\"name\";s:4:\"Menu\";s:11:\"description\";s:60:\"Allows administrators to customize the site navigation menu.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:9:\"menu.test\";}s:9:\"configure\";s:20:\"admin/structure/menu\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}}s:4:\"node\";O:8:\"stdClass\":9:{s:8:\"filename\";s:24:\"modules/node/node.module\";s:4:\"name\";s:4:\"node\";s:4:\"type\";s:6:\"module\";s:5:\"owner\";s:0:\"\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:4:\"7012\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:14:{s:4:\"name\";s:4:\"Node\";s:11:\"description\";s:66:\"Allows content to be submitted to the site and displayed on pages.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:2:{i:0;s:11:\"node.module\";i:1;s:9:\"node.test\";}s:8:\"required\";b:1;s:9:\"configure\";s:21:\"admin/structure/types\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:8:\"node.css\";s:21:\"modules/node/node.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}}s:6:\"number\";O:8:\"stdClass\":9:{s:8:\"filename\";s:42:\"modules/field/modules/number/number.module\";s:4:\"name\";s:6:\"number\";s:4:\"type\";s:6:\"module\";s:5:\"owner\";s:0:\"\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:1:\"0\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:11:{s:4:\"name\";s:6:\"Number\";s:11:\"description\";s:28:\"Defines numeric field types.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:5:\"field\";}s:5:\"files\";a:1:{i:0;s:11:\"number.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}}s:7:\"options\";O:8:\"stdClass\":9:{s:8:\"filename\";s:44:\"modules/field/modules/options/options.module\";s:4:\"name\";s:7:\"options\";s:4:\"type\";s:6:\"module\";s:5:\"owner\";s:0:\"\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:1:\"0\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:11:{s:4:\"name\";s:7:\"Options\";s:11:\"description\";s:82:\"Defines selection, check box and radio button widgets for text and numeric fields.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:5:\"field\";}s:5:\"files\";a:1:{i:0;s:12:\"options.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}}s:7:\"overlay\";O:8:\"stdClass\":9:{s:8:\"filename\";s:30:\"modules/overlay/overlay.module\";s:4:\"name\";s:7:\"overlay\";s:4:\"type\";s:6:\"module\";s:5:\"owner\";s:0:\"\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"1\";s:14:\"schema_version\";s:1:\"0\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:11:{s:4:\"name\";s:7:\"Overlay\";s:11:\"description\";s:59:\"Displays the Drupal administration interface in an overlay.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}}s:4:\"path\";O:8:\"stdClass\":9:{s:8:\"filename\";s:24:\"modules/path/path.module\";s:4:\"name\";s:4:\"path\";s:4:\"type\";s:6:\"module\";s:5:\"owner\";s:0:\"\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:1:\"0\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:12:{s:4:\"name\";s:4:\"Path\";s:11:\"description\";s:28:\"Allows users to rename URLs.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:9:\"path.test\";}s:9:\"configure\";s:24:\"admin/config/search/path\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}}s:3:\"rdf\";O:8:\"stdClass\":9:{s:8:\"filename\";s:22:\"modules/rdf/rdf.module\";s:4:\"name\";s:3:\"rdf\";s:4:\"type\";s:6:\"module\";s:5:\"owner\";s:0:\"\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:1:\"0\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:11:{s:4:\"name\";s:3:\"RDF\";s:11:\"description\";s:148:\"Enriches your content with metadata to let other applications (e.g. search engines, aggregators) better understand its relationships and attributes.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:8:\"rdf.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}}s:6:\"search\";O:8:\"stdClass\":9:{s:8:\"filename\";s:28:\"modules/search/search.module\";s:4:\"name\";s:6:\"search\";s:4:\"type\";s:6:\"module\";s:5:\"owner\";s:0:\"\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:4:\"7000\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:13:{s:4:\"name\";s:6:\"Search\";s:11:\"description\";s:36:\"Enables site-wide keyword searching.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:2:{i:0;s:19:\"search.extender.inc\";i:1;s:11:\"search.test\";}s:9:\"configure\";s:28:\"admin/config/search/settings\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:10:\"search.css\";s:25:\"modules/search/search.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}}s:8:\"shortcut\";O:8:\"stdClass\":9:{s:8:\"filename\";s:32:\"modules/shortcut/shortcut.module\";s:4:\"name\";s:8:\"shortcut\";s:4:\"type\";s:6:\"module\";s:5:\"owner\";s:0:\"\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:1:\"0\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:12:{s:4:\"name\";s:8:\"Shortcut\";s:11:\"description\";s:60:\"Allows users to manage customizable lists of shortcut links.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:13:\"shortcut.test\";}s:9:\"configure\";s:36:\"admin/config/user-interface/shortcut\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}}s:6:\"system\";O:8:\"stdClass\":9:{s:8:\"filename\";s:28:\"modules/system/system.module\";s:4:\"name\";s:6:\"system\";s:4:\"type\";s:6:\"module\";s:5:\"owner\";s:0:\"\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:4:\"7071\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:13:{s:4:\"name\";s:6:\"System\";s:11:\"description\";s:54:\"Handles general site configuration for administrators.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:6:{i:0;s:19:\"system.archiver.inc\";i:1;s:15:\"system.mail.inc\";i:2;s:16:\"system.queue.inc\";i:3;s:14:\"system.tar.inc\";i:4;s:18:\"system.updater.inc\";i:5;s:11:\"system.test\";}s:8:\"required\";b:1;s:9:\"configure\";s:19:\"admin/config/system\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}}s:8:\"taxonomy\";O:8:\"stdClass\":9:{s:8:\"filename\";s:32:\"modules/taxonomy/taxonomy.module\";s:4:\"name\";s:8:\"taxonomy\";s:4:\"type\";s:6:\"module\";s:5:\"owner\";s:0:\"\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:4:\"7010\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:14:{s:4:\"name\";s:8:\"Taxonomy\";s:11:\"description\";s:38:\"Enables the categorization of content.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:7:\"options\";}s:5:\"files\";a:2:{i:0;s:15:\"taxonomy.module\";i:1;s:13:\"taxonomy.test\";}s:9:\"configure\";s:24:\"admin/structure/taxonomy\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;s:8:\"required\";b:1;s:11:\"explanation\";s:76:\"Field type(s) in use - see <a href=\"/?q=admin/reports/fields\">Field list</a>\";}}s:4:\"text\";O:8:\"stdClass\":9:{s:8:\"filename\";s:38:\"modules/field/modules/text/text.module\";s:4:\"name\";s:4:\"text\";s:4:\"type\";s:6:\"module\";s:5:\"owner\";s:0:\"\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:4:\"7000\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:13:{s:4:\"name\";s:4:\"Text\";s:11:\"description\";s:32:\"Defines simple text field types.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:5:\"field\";}s:5:\"files\";a:1:{i:0;s:9:\"text.test\";}s:8:\"required\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;s:11:\"explanation\";s:76:\"Field type(s) in use - see <a href=\"/?q=admin/reports/fields\">Field list</a>\";}}s:7:\"toolbar\";O:8:\"stdClass\":9:{s:8:\"filename\";s:30:\"modules/toolbar/toolbar.module\";s:4:\"name\";s:7:\"toolbar\";s:4:\"type\";s:6:\"module\";s:5:\"owner\";s:0:\"\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:1:\"0\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:11:{s:4:\"name\";s:7:\"Toolbar\";s:11:\"description\";s:99:\"Provides a toolbar that shows the top-level administration menu items and links from other modules.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}}s:4:\"user\";O:8:\"stdClass\":9:{s:8:\"filename\";s:24:\"modules/user/user.module\";s:4:\"name\";s:4:\"user\";s:4:\"type\";s:6:\"module\";s:5:\"owner\";s:0:\"\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:4:\"7017\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:14:{s:4:\"name\";s:4:\"User\";s:11:\"description\";s:47:\"Manages the user registration and login system.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:2:{i:0;s:11:\"user.module\";i:1;s:9:\"user.test\";}s:8:\"required\";b:1;s:9:\"configure\";s:19:\"admin/config/people\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:8:\"user.css\";s:21:\"modules/user/user.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}}s:8:\"standard\";O:8:\"stdClass\":9:{s:8:\"filename\";s:34:\"profiles/standard/standard.profile\";s:4:\"name\";s:8:\"standard\";s:4:\"type\";s:6:\"module\";s:5:\"owner\";s:0:\"\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:1:\"0\";s:6:\"weight\";s:4:\"1000\";s:4:\"info\";a:14:{s:4:\"name\";s:8:\"Standard\";s:11:\"description\";s:51:\"Install with commonly used features pre-configured.\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:21:{i:0;s:5:\"block\";i:1;s:5:\"color\";i:2;s:7:\"comment\";i:3;s:10:\"contextual\";i:4;s:9:\"dashboard\";i:5;s:4:\"help\";i:6;s:5:\"image\";i:7;s:4:\"list\";i:8;s:4:\"menu\";i:9;s:6:\"number\";i:10;s:7:\"options\";i:11;s:4:\"path\";i:12;s:8:\"taxonomy\";i:13;s:5:\"dblog\";i:14;s:6:\"search\";i:15;s:8:\"shortcut\";i:16;s:7:\"toolbar\";i:17;s:7:\"overlay\";i:18;s:8:\"field_ui\";i:19;s:4:\"file\";i:20;s:3:\"rdf\";}s:5:\"files\";a:1:{i:0;s:16:\"standard.profile\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:7:\"package\";s:5:\"Other\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;s:6:\"hidden\";b:1;s:8:\"required\";b:1;s:17:\"distribution_name\";s:6:\"Drupal\";}}}s:5:\"theme\";a:7:{s:6:\"bartik\";O:8:\"stdClass\":9:{s:8:\"filename\";s:25:\"themes/bartik/bartik.info\";s:4:\"name\";s:6:\"bartik\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:18:{s:4:\"name\";s:6:\"Bartik\";s:11:\"description\";s:48:\"A flexible, recolorable theme with many regions.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:3:{s:14:\"css/layout.css\";s:28:\"themes/bartik/css/layout.css\";s:13:\"css/style.css\";s:27:\"themes/bartik/css/style.css\";s:14:\"css/colors.css\";s:28:\"themes/bartik/css/colors.css\";}s:5:\"print\";a:1:{s:13:\"css/print.css\";s:27:\"themes/bartik/css/print.css\";}}s:7:\"regions\";a:20:{s:6:\"header\";s:6:\"Header\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:11:\"highlighted\";s:11:\"Highlighted\";s:8:\"featured\";s:8:\"Featured\";s:7:\"content\";s:7:\"Content\";s:13:\"sidebar_first\";s:13:\"Sidebar first\";s:14:\"sidebar_second\";s:14:\"Sidebar second\";s:14:\"triptych_first\";s:14:\"Triptych first\";s:15:\"triptych_middle\";s:15:\"Triptych middle\";s:13:\"triptych_last\";s:13:\"Triptych last\";s:18:\"footer_firstcolumn\";s:19:\"Footer first column\";s:19:\"footer_secondcolumn\";s:20:\"Footer second column\";s:18:\"footer_thirdcolumn\";s:19:\"Footer third column\";s:19:\"footer_fourthcolumn\";s:20:\"Footer fourth column\";s:6:\"footer\";s:6:\"Footer\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"settings\";a:1:{s:20:\"shortcut_module_link\";s:1:\"0\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:6:\"engine\";s:11:\"phptemplate\";s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:28:\"themes/bartik/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}}s:7:\"garland\";O:8:\"stdClass\":9:{s:8:\"filename\";s:27:\"themes/garland/garland.info\";s:4:\"name\";s:7:\"garland\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"0\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:18:{s:4:\"name\";s:7:\"Garland\";s:11:\"description\";s:111:\"A multi-column theme which can be configured to modify colors and switch between fixed and fluid width layouts.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:1:{s:9:\"style.css\";s:24:\"themes/garland/style.css\";}s:5:\"print\";a:1:{s:9:\"print.css\";s:24:\"themes/garland/print.css\";}}s:8:\"settings\";a:1:{s:13:\"garland_width\";s:5:\"fluid\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:29:\"themes/garland/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}}s:5:\"seven\";O:8:\"stdClass\":9:{s:8:\"filename\";s:23:\"themes/seven/seven.info\";s:4:\"name\";s:5:\"seven\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:18:{s:4:\"name\";s:5:\"Seven\";s:11:\"description\";s:65:\"A simple one-column, tableless, fluid width administration theme.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:1:{s:6:\"screen\";a:2:{s:9:\"reset.css\";s:22:\"themes/seven/reset.css\";s:9:\"style.css\";s:22:\"themes/seven/style.css\";}}s:8:\"settings\";a:1:{s:20:\"shortcut_module_link\";s:1:\"1\";}s:7:\"regions\";a:8:{s:7:\"content\";s:7:\"Content\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:13:\"sidebar_first\";s:13:\"First sidebar\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:14:\"regions_hidden\";a:3:{i:0;s:13:\"sidebar_first\";i:1;s:8:\"page_top\";i:2;s:11:\"page_bottom\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:6:\"engine\";s:11:\"phptemplate\";s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:27:\"themes/seven/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}}s:5:\"stark\";O:8:\"stdClass\":9:{s:8:\"filename\";s:23:\"themes/stark/stark.info\";s:4:\"name\";s:5:\"stark\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"0\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:17:{s:4:\"name\";s:5:\"Stark\";s:11:\"description\";s:208:\"This theme demonstrates Drupal\'s default HTML markup and CSS styles. To learn how to build your own theme and override Drupal\'s default code, see the <a href=\"http://drupal.org/theme-guide\">Theming Guide</a>.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:10:\"layout.css\";s:23:\"themes/stark/layout.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:27:\"themes/stark/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}}s:10:\"test_theme\";O:8:\"stdClass\":9:{s:8:\"filename\";s:39:\"themes/tests/test_theme/test_theme.info\";s:4:\"name\";s:10:\"test_theme\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"0\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:17:{s:4:\"name\";s:10:\"Test theme\";s:11:\"description\";s:34:\"Theme for testing the theme system\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:15:\"system.base.css\";s:39:\"themes/tests/test_theme/system.base.css\";}}s:7:\"version\";s:3:\"7.8\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:38:\"themes/tests/test_theme/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}}s:21:\"update_test_basetheme\";O:8:\"stdClass\":9:{s:8:\"filename\";s:61:\"themes/tests/update_test_basetheme/update_test_basetheme.info\";s:4:\"name\";s:21:\"update_test_basetheme\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"0\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:17:{s:4:\"name\";s:22:\"Update test base theme\";s:11:\"description\";s:63:\"Test theme which acts as a base theme for other test subthemes.\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"version\";s:3:\"7.8\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:49:\"themes/tests/update_test_basetheme/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:11:\"stylesheets\";a:0:{}s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}}s:20:\"update_test_subtheme\";O:8:\"stdClass\":9:{s:8:\"filename\";s:59:\"themes/tests/update_test_subtheme/update_test_subtheme.info\";s:4:\"name\";s:20:\"update_test_subtheme\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"0\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:18:{s:4:\"name\";s:20:\"Update test subtheme\";s:11:\"description\";s:62:\"Test theme which uses update_test_basetheme as the base theme.\";s:4:\"core\";s:3:\"7.x\";s:10:\"base theme\";s:21:\"update_test_basetheme\";s:6:\"hidden\";b:1;s:7:\"version\";s:3:\"7.8\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:48:\"themes/tests/update_test_subtheme/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:11:\"stylesheets\";a:0:{}s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}}}s:9:\"filepaths\";a:31:{i:0;a:3:{s:4:\"type\";s:6:\"module\";s:4:\"name\";s:5:\"block\";s:8:\"filepath\";s:26:\"modules/block/block.module\";}i:1;a:3:{s:4:\"type\";s:5:\"theme\";s:4:\"name\";s:6:\"bartik\";s:8:\"filepath\";s:25:\"themes/bartik/bartik.info\";}i:2;a:3:{s:4:\"type\";s:6:\"module\";s:4:\"name\";s:5:\"color\";s:8:\"filepath\";s:26:\"modules/color/color.module\";}i:3;a:3:{s:4:\"type\";s:6:\"module\";s:4:\"name\";s:7:\"comment\";s:8:\"filepath\";s:30:\"modules/comment/comment.module\";}i:4;a:3:{s:4:\"type\";s:6:\"module\";s:4:\"name\";s:10:\"contextual\";s:8:\"filepath\";s:36:\"modules/contextual/contextual.module\";}i:5;a:3:{s:4:\"type\";s:6:\"module\";s:4:\"name\";s:9:\"dashboard\";s:8:\"filepath\";s:34:\"modules/dashboard/dashboard.module\";}i:6;a:3:{s:4:\"type\";s:6:\"module\";s:4:\"name\";s:5:\"dblog\";s:8:\"filepath\";s:26:\"modules/dblog/dblog.module\";}i:7;a:3:{s:4:\"type\";s:6:\"module\";s:4:\"name\";s:5:\"field\";s:8:\"filepath\";s:26:\"modules/field/field.module\";}i:8;a:3:{s:4:\"type\";s:6:\"module\";s:4:\"name\";s:17:\"field_sql_storage\";s:8:\"filepath\";s:64:\"modules/field/modules/field_sql_storage/field_sql_storage.module\";}i:9;a:3:{s:4:\"type\";s:6:\"module\";s:4:\"name\";s:8:\"field_ui\";s:8:\"filepath\";s:32:\"modules/field_ui/field_ui.module\";}i:10;a:3:{s:4:\"type\";s:6:\"module\";s:4:\"name\";s:4:\"file\";s:8:\"filepath\";s:24:\"modules/file/file.module\";}i:11;a:3:{s:4:\"type\";s:6:\"module\";s:4:\"name\";s:6:\"filter\";s:8:\"filepath\";s:28:\"modules/filter/filter.module\";}i:12;a:3:{s:4:\"type\";s:6:\"module\";s:4:\"name\";s:4:\"help\";s:8:\"filepath\";s:24:\"modules/help/help.module\";}i:13;a:3:{s:4:\"type\";s:6:\"module\";s:4:\"name\";s:5:\"image\";s:8:\"filepath\";s:26:\"modules/image/image.module\";}i:14;a:3:{s:4:\"type\";s:6:\"module\";s:4:\"name\";s:4:\"list\";s:8:\"filepath\";s:38:\"modules/field/modules/list/list.module\";}i:15;a:3:{s:4:\"type\";s:6:\"module\";s:4:\"name\";s:4:\"menu\";s:8:\"filepath\";s:24:\"modules/menu/menu.module\";}i:16;a:3:{s:4:\"type\";s:6:\"module\";s:4:\"name\";s:4:\"node\";s:8:\"filepath\";s:24:\"modules/node/node.module\";}i:17;a:3:{s:4:\"type\";s:6:\"module\";s:4:\"name\";s:6:\"number\";s:8:\"filepath\";s:42:\"modules/field/modules/number/number.module\";}i:18;a:3:{s:4:\"type\";s:6:\"module\";s:4:\"name\";s:7:\"options\";s:8:\"filepath\";s:44:\"modules/field/modules/options/options.module\";}i:19;a:3:{s:4:\"type\";s:6:\"module\";s:4:\"name\";s:7:\"overlay\";s:8:\"filepath\";s:30:\"modules/overlay/overlay.module\";}i:20;a:3:{s:4:\"type\";s:6:\"module\";s:4:\"name\";s:4:\"path\";s:8:\"filepath\";s:24:\"modules/path/path.module\";}i:21;a:3:{s:4:\"type\";s:6:\"module\";s:4:\"name\";s:3:\"rdf\";s:8:\"filepath\";s:22:\"modules/rdf/rdf.module\";}i:22;a:3:{s:4:\"type\";s:6:\"module\";s:4:\"name\";s:6:\"search\";s:8:\"filepath\";s:28:\"modules/search/search.module\";}i:23;a:3:{s:4:\"type\";s:5:\"theme\";s:4:\"name\";s:5:\"seven\";s:8:\"filepath\";s:23:\"themes/seven/seven.info\";}i:24;a:3:{s:4:\"type\";s:6:\"module\";s:4:\"name\";s:8:\"shortcut\";s:8:\"filepath\";s:32:\"modules/shortcut/shortcut.module\";}i:25;a:3:{s:4:\"type\";s:6:\"module\";s:4:\"name\";s:6:\"system\";s:8:\"filepath\";s:28:\"modules/system/system.module\";}i:26;a:3:{s:4:\"type\";s:6:\"module\";s:4:\"name\";s:8:\"taxonomy\";s:8:\"filepath\";s:32:\"modules/taxonomy/taxonomy.module\";}i:27;a:3:{s:4:\"type\";s:6:\"module\";s:4:\"name\";s:4:\"text\";s:8:\"filepath\";s:38:\"modules/field/modules/text/text.module\";}i:28;a:3:{s:4:\"type\";s:6:\"module\";s:4:\"name\";s:7:\"toolbar\";s:8:\"filepath\";s:30:\"modules/toolbar/toolbar.module\";}i:29;a:3:{s:4:\"type\";s:6:\"module\";s:4:\"name\";s:4:\"user\";s:8:\"filepath\";s:24:\"modules/user/user.module\";}i:30;a:3:{s:4:\"type\";s:6:\"module\";s:4:\"name\";s:8:\"standard\";s:8:\"filepath\";s:34:\"profiles/standard/standard.profile\";}}}',0,1317181162,1);
INSERT INTO `cache_bootstrap` VALUES ('variables','a:20:{s:11:\"admin_theme\";s:5:\"seven\";s:12:\"comment_page\";i:0;s:8:\"cron_key\";s:43:\"BFZcTbhF4gFM4RaOvTJZ1kYUrn6XrlwpyjuEjozt0-c\";s:19:\"css_js_query_string\";s:6:\"ls7rhi\";s:18:\"drupal_private_key\";s:43:\"kBP4FdIS3UTfVXgo3ZGdpwnB9uogHlwJTQAJfzvpXVM\";s:22:\"filter_fallback_format\";s:10:\"plain_text\";s:12:\"install_task\";s:23:\"install_profile_modules\";s:13:\"menu_expanded\";a:0:{}s:10:\"menu_masks\";a:34:{i:0;i:501;i:1;i:493;i:2;i:250;i:3;i:247;i:4;i:246;i:5;i:245;i:6;i:125;i:7;i:123;i:8;i:122;i:9;i:121;i:10;i:117;i:11;i:63;i:12;i:62;i:13;i:61;i:14;i:60;i:15;i:59;i:16;i:58;i:17;i:44;i:18;i:31;i:19;i:30;i:20;i:29;i:21;i:28;i:22;i:24;i:23;i:21;i:24;i:15;i:25;i:14;i:26;i:13;i:27;i:11;i:28;i:7;i:29;i:6;i:30;i:5;i:31;i:3;i:32;i:2;i:33;i:1;}s:16:\"node_admin_theme\";s:1:\"1\";s:17:\"node_options_page\";a:1:{i:0;s:6:\"status\";}s:19:\"node_submitted_page\";b:0;s:20:\"path_alias_whitelist\";a:0:{}s:13:\"theme_default\";s:6:\"bartik\";s:15:\"user_admin_role\";s:1:\"3\";s:13:\"user_pictures\";s:1:\"1\";s:23:\"user_picture_dimensions\";s:9:\"1024x1024\";s:22:\"user_picture_file_size\";s:3:\"800\";s:18:\"user_picture_style\";s:9:\"thumbnail\";s:13:\"user_register\";i:2;}',0,1317181163,1);
/*!40000 ALTER TABLE `cache_bootstrap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_field`
--

DROP TABLE IF EXISTS `cache_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_field` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Generic cache table for caching things not separated out...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_field`
--

LOCK TABLES `cache_field` WRITE;
/*!40000 ALTER TABLE `cache_field` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_filter`
--

DROP TABLE IF EXISTS `cache_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_filter` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the Filter module to store already...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_filter`
--

LOCK TABLES `cache_filter` WRITE;
/*!40000 ALTER TABLE `cache_filter` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_filter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_form`
--

DROP TABLE IF EXISTS `cache_form`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_form` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the form system to store recently built...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_form`
--

LOCK TABLES `cache_form` WRITE;
/*!40000 ALTER TABLE `cache_form` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_form` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_image`
--

DROP TABLE IF EXISTS `cache_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_image` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table used to store information about image...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_image`
--

LOCK TABLES `cache_image` WRITE;
/*!40000 ALTER TABLE `cache_image` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_menu`
--

DROP TABLE IF EXISTS `cache_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_menu` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the menu system to store router...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_menu`
--

LOCK TABLES `cache_menu` WRITE;
/*!40000 ALTER TABLE `cache_menu` DISABLE KEYS */;
INSERT INTO `cache_menu` VALUES ('menu_item:372d0e62f362362417aedfebec05472d8a2d77db091d05aa01eaf754e4195d0d','a:23:{s:4:\"path\";s:15:\"system/timezone\";s:14:\"load_functions\";s:0:\"\";s:16:\"to_arg_functions\";s:0:\"\";s:15:\"access_callback\";s:1:\"1\";s:16:\"access_arguments\";s:6:\"a:0:{}\";s:13:\"page_callback\";s:15:\"system_timezone\";s:14:\"page_arguments\";s:6:\"a:0:{}\";s:17:\"delivery_callback\";s:0:\"\";s:3:\"fit\";s:1:\"3\";s:12:\"number_parts\";s:1:\"2\";s:7:\"context\";s:1:\"0\";s:10:\"tab_parent\";s:0:\"\";s:8:\"tab_root\";s:15:\"system/timezone\";s:5:\"title\";s:9:\"Time zone\";s:14:\"title_callback\";s:1:\"t\";s:15:\"title_arguments\";s:0:\"\";s:14:\"theme_callback\";s:0:\"\";s:15:\"theme_arguments\";s:6:\"a:0:{}\";s:4:\"type\";s:1:\"0\";s:11:\"description\";s:0:\"\";s:8:\"position\";s:0:\"\";s:6:\"weight\";s:1:\"0\";s:12:\"include_file\";s:31:\"modules/system/system.admin.inc\";}',0,1317181162,1);
INSERT INTO `cache_menu` VALUES ('menu_item:c2b44b984a0997b15484eb0e18888132d29224c78976e475ed37811d40ff4e04','a:23:{s:4:\"path\";s:36:\"admin/config/search/clean-urls/check\";s:14:\"load_functions\";s:0:\"\";s:16:\"to_arg_functions\";s:0:\"\";s:15:\"access_callback\";s:1:\"1\";s:16:\"access_arguments\";s:6:\"a:0:{}\";s:13:\"page_callback\";s:18:\"drupal_json_output\";s:14:\"page_arguments\";s:33:\"a:1:{i:0;a:1:{s:6:\"status\";b:1;}}\";s:17:\"delivery_callback\";s:0:\"\";s:3:\"fit\";s:2:\"31\";s:12:\"number_parts\";s:1:\"5\";s:7:\"context\";s:1:\"0\";s:10:\"tab_parent\";s:0:\"\";s:8:\"tab_root\";s:36:\"admin/config/search/clean-urls/check\";s:5:\"title\";s:15:\"Clean URL check\";s:14:\"title_callback\";s:1:\"t\";s:15:\"title_arguments\";s:0:\"\";s:14:\"theme_callback\";s:0:\"\";s:15:\"theme_arguments\";s:6:\"a:0:{}\";s:4:\"type\";s:1:\"0\";s:11:\"description\";s:0:\"\";s:8:\"position\";s:0:\"\";s:6:\"weight\";s:1:\"0\";s:12:\"include_file\";s:31:\"modules/system/system.admin.inc\";}',0,1317181163,1);
/*!40000 ALTER TABLE `cache_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_page`
--

DROP TABLE IF EXISTS `cache_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_page` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table used to store compressed pages for anonymous...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_page`
--

LOCK TABLES `cache_page` WRITE;
/*!40000 ALTER TABLE `cache_page` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_path`
--

DROP TABLE IF EXISTS `cache_path`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_path` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for path alias lookup.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_path`
--

LOCK TABLES `cache_path` WRITE;
/*!40000 ALTER TABLE `cache_path` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_path` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comment` (
  `cid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique comment ID.',
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT 'The comment.cid to which this comment is a reply. If set to 0, this comment is not a reply to an existing comment.',
  `nid` int(11) NOT NULL DEFAULT '0' COMMENT 'The node.nid to which this comment is a reply.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid who authored the comment. If set to 0, this comment was created by an anonymous user.',
  `subject` varchar(64) NOT NULL DEFAULT '' COMMENT 'The comment title.',
  `hostname` varchar(128) NOT NULL DEFAULT '' COMMENT 'The author’s host name.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The time that the comment was created, as a Unix timestamp.',
  `changed` int(11) NOT NULL DEFAULT '0' COMMENT 'The time that the comment was last edited, as a Unix timestamp.',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'The published status of a comment. (0 = Not Published, 1 = Published)',
  `thread` varchar(255) NOT NULL COMMENT 'The vancode representation of the comment’s place in a thread.',
  `name` varchar(60) DEFAULT NULL COMMENT 'The comment author’s name. Uses users.name if the user is logged in, otherwise uses the value typed into the comment form.',
  `mail` varchar(64) DEFAULT NULL COMMENT 'The comment author’s e-mail address from the comment form, if user is anonymous, and the ’Anonymous users may/must leave their contact information’ setting is turned on.',
  `homepage` varchar(255) DEFAULT NULL COMMENT 'The comment author’s home page address from the comment form, if user is anonymous, and the ’Anonymous users may/must leave their contact information’ setting is turned on.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The languages.language of this comment.',
  PRIMARY KEY (`cid`),
  KEY `comment_status_pid` (`pid`,`status`),
  KEY `comment_num_new` (`nid`,`status`,`created`,`cid`,`thread`),
  KEY `comment_uid` (`uid`),
  KEY `comment_nid_language` (`nid`,`language`),
  KEY `comment_created` (`created`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores comments and associated data.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `date_format_locale`
--

DROP TABLE IF EXISTS `date_format_locale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `date_format_locale` (
  `format` varchar(100) NOT NULL COMMENT 'The date format string.',
  `type` varchar(64) NOT NULL COMMENT 'The date format type, e.g. medium.',
  `language` varchar(12) NOT NULL COMMENT 'A languages.language for this format to be used with.',
  PRIMARY KEY (`type`,`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configured date formats for each locale.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `date_format_locale`
--

LOCK TABLES `date_format_locale` WRITE;
/*!40000 ALTER TABLE `date_format_locale` DISABLE KEYS */;
/*!40000 ALTER TABLE `date_format_locale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `date_format_type`
--

DROP TABLE IF EXISTS `date_format_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `date_format_type` (
  `type` varchar(64) NOT NULL COMMENT 'The date format type, e.g. medium.',
  `title` varchar(255) NOT NULL COMMENT 'The human readable name of the format type.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Whether or not this is a system provided format.',
  PRIMARY KEY (`type`),
  KEY `title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configured date format types.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `date_format_type`
--

LOCK TABLES `date_format_type` WRITE;
/*!40000 ALTER TABLE `date_format_type` DISABLE KEYS */;
INSERT INTO `date_format_type` VALUES ('long','Long',1);
INSERT INTO `date_format_type` VALUES ('medium','Medium',1);
INSERT INTO `date_format_type` VALUES ('short','Short',1);
/*!40000 ALTER TABLE `date_format_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `date_formats`
--

DROP TABLE IF EXISTS `date_formats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `date_formats` (
  `dfid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The date format identifier.',
  `format` varchar(100) NOT NULL COMMENT 'The date format string.',
  `type` varchar(64) NOT NULL COMMENT 'The date format type, e.g. medium.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Whether or not this format can be modified.',
  PRIMARY KEY (`dfid`),
  UNIQUE KEY `formats` (`format`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COMMENT='Stores configured date formats.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `date_formats`
--

LOCK TABLES `date_formats` WRITE;
/*!40000 ALTER TABLE `date_formats` DISABLE KEYS */;
INSERT INTO `date_formats` VALUES (1,'Y-m-d H:i','short',1);
INSERT INTO `date_formats` VALUES (2,'m/d/Y - H:i','short',1);
INSERT INTO `date_formats` VALUES (3,'d/m/Y - H:i','short',1);
INSERT INTO `date_formats` VALUES (4,'Y/m/d - H:i','short',1);
INSERT INTO `date_formats` VALUES (5,'d.m.Y - H:i','short',1);
INSERT INTO `date_formats` VALUES (6,'m/d/Y - g:ia','short',1);
INSERT INTO `date_formats` VALUES (7,'d/m/Y - g:ia','short',1);
INSERT INTO `date_formats` VALUES (8,'Y/m/d - g:ia','short',1);
INSERT INTO `date_formats` VALUES (9,'M j Y - H:i','short',1);
INSERT INTO `date_formats` VALUES (10,'j M Y - H:i','short',1);
INSERT INTO `date_formats` VALUES (11,'Y M j - H:i','short',1);
INSERT INTO `date_formats` VALUES (12,'M j Y - g:ia','short',1);
INSERT INTO `date_formats` VALUES (13,'j M Y - g:ia','short',1);
INSERT INTO `date_formats` VALUES (14,'Y M j - g:ia','short',1);
INSERT INTO `date_formats` VALUES (15,'D, Y-m-d H:i','medium',1);
INSERT INTO `date_formats` VALUES (16,'D, m/d/Y - H:i','medium',1);
INSERT INTO `date_formats` VALUES (17,'D, d/m/Y - H:i','medium',1);
INSERT INTO `date_formats` VALUES (18,'D, Y/m/d - H:i','medium',1);
INSERT INTO `date_formats` VALUES (19,'F j, Y - H:i','medium',1);
INSERT INTO `date_formats` VALUES (20,'j F, Y - H:i','medium',1);
INSERT INTO `date_formats` VALUES (21,'Y, F j - H:i','medium',1);
INSERT INTO `date_formats` VALUES (22,'D, m/d/Y - g:ia','medium',1);
INSERT INTO `date_formats` VALUES (23,'D, d/m/Y - g:ia','medium',1);
INSERT INTO `date_formats` VALUES (24,'D, Y/m/d - g:ia','medium',1);
INSERT INTO `date_formats` VALUES (25,'F j, Y - g:ia','medium',1);
INSERT INTO `date_formats` VALUES (26,'j F Y - g:ia','medium',1);
INSERT INTO `date_formats` VALUES (27,'Y, F j - g:ia','medium',1);
INSERT INTO `date_formats` VALUES (28,'j. F Y - G:i','medium',1);
INSERT INTO `date_formats` VALUES (29,'l, F j, Y - H:i','long',1);
INSERT INTO `date_formats` VALUES (30,'l, j F, Y - H:i','long',1);
INSERT INTO `date_formats` VALUES (31,'l, Y,  F j - H:i','long',1);
INSERT INTO `date_formats` VALUES (32,'l, F j, Y - g:ia','long',1);
INSERT INTO `date_formats` VALUES (33,'l, j F Y - g:ia','long',1);
INSERT INTO `date_formats` VALUES (34,'l, Y,  F j - g:ia','long',1);
INSERT INTO `date_formats` VALUES (35,'l, j. F Y - G:i','long',1);
/*!40000 ALTER TABLE `date_formats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_config`
--

DROP TABLE IF EXISTS `field_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a field',
  `field_name` varchar(32) NOT NULL COMMENT 'The name of this field. Non-deleted field names are unique, but multiple deleted fields can have the same name.',
  `type` varchar(128) NOT NULL COMMENT 'The type of this field.',
  `module` varchar(128) NOT NULL DEFAULT '' COMMENT 'The module that implements the field type.',
  `active` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the module that implements the field type is enabled.',
  `storage_type` varchar(128) NOT NULL COMMENT 'The storage backend for the field.',
  `storage_module` varchar(128) NOT NULL DEFAULT '' COMMENT 'The module that implements the storage backend.',
  `storage_active` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the module that implements the storage backend is enabled.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT '@TODO',
  `data` longblob NOT NULL COMMENT 'Serialized data containing the field properties that do not warrant a dedicated column.',
  `cardinality` tinyint(4) NOT NULL DEFAULT '0',
  `translatable` tinyint(4) NOT NULL DEFAULT '0',
  `deleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `field_name` (`field_name`),
  KEY `active` (`active`),
  KEY `storage_active` (`storage_active`),
  KEY `deleted` (`deleted`),
  KEY `module` (`module`),
  KEY `storage_module` (`storage_module`),
  KEY `type` (`type`),
  KEY `storage_type` (`storage_type`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_config`
--

LOCK TABLES `field_config` WRITE;
/*!40000 ALTER TABLE `field_config` DISABLE KEYS */;
INSERT INTO `field_config` VALUES (1,'comment_body','text_long','text',1,'field_sql_storage','field_sql_storage',1,0,'a:6:{s:12:\"entity_types\";a:1:{i:0;s:7:\"comment\";}s:12:\"translatable\";b:0;s:8:\"settings\";a:0:{}s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}s:12:\"foreign keys\";a:1:{s:6:\"format\";a:2:{s:5:\"table\";s:13:\"filter_format\";s:7:\"columns\";a:1:{s:6:\"format\";s:6:\"format\";}}}s:7:\"indexes\";a:1:{s:6:\"format\";a:1:{i:0;s:6:\"format\";}}}',1,0,0);
INSERT INTO `field_config` VALUES (2,'body','text_with_summary','text',1,'field_sql_storage','field_sql_storage',1,0,'a:6:{s:12:\"entity_types\";a:1:{i:0;s:4:\"node\";}s:12:\"translatable\";b:0;s:8:\"settings\";a:0:{}s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}s:12:\"foreign keys\";a:1:{s:6:\"format\";a:2:{s:5:\"table\";s:13:\"filter_format\";s:7:\"columns\";a:1:{s:6:\"format\";s:6:\"format\";}}}s:7:\"indexes\";a:1:{s:6:\"format\";a:1:{i:0;s:6:\"format\";}}}',1,0,0);
INSERT INTO `field_config` VALUES (3,'field_tags','taxonomy_term_reference','taxonomy',1,'field_sql_storage','field_sql_storage',1,0,'a:6:{s:8:\"settings\";a:1:{s:14:\"allowed_values\";a:1:{i:0;a:2:{s:10:\"vocabulary\";s:4:\"tags\";s:6:\"parent\";i:0;}}}s:12:\"entity_types\";a:0:{}s:12:\"translatable\";b:0;s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}s:12:\"foreign keys\";a:1:{s:3:\"tid\";a:2:{s:5:\"table\";s:18:\"taxonomy_term_data\";s:7:\"columns\";a:1:{s:3:\"tid\";s:3:\"tid\";}}}s:7:\"indexes\";a:1:{s:3:\"tid\";a:1:{i:0;s:3:\"tid\";}}}',-1,0,0);
INSERT INTO `field_config` VALUES (4,'field_image','image','image',1,'field_sql_storage','field_sql_storage',1,0,'a:6:{s:7:\"indexes\";a:1:{s:3:\"fid\";a:1:{i:0;s:3:\"fid\";}}s:8:\"settings\";a:2:{s:10:\"uri_scheme\";s:6:\"public\";s:13:\"default_image\";b:0;}s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}s:12:\"entity_types\";a:0:{}s:12:\"translatable\";b:0;s:12:\"foreign keys\";a:1:{s:3:\"fid\";a:2:{s:5:\"table\";s:12:\"file_managed\";s:7:\"columns\";a:1:{s:3:\"fid\";s:3:\"fid\";}}}}',1,0,0);
/*!40000 ALTER TABLE `field_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_config_instance`
--

DROP TABLE IF EXISTS `field_config_instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_config_instance` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a field instance',
  `field_id` int(11) NOT NULL COMMENT 'The identifier of the field attached by this instance',
  `field_name` varchar(32) NOT NULL DEFAULT '',
  `entity_type` varchar(32) NOT NULL DEFAULT '',
  `bundle` varchar(128) NOT NULL DEFAULT '',
  `data` longblob NOT NULL,
  `deleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `field_name_bundle` (`field_name`,`entity_type`,`bundle`),
  KEY `deleted` (`deleted`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_config_instance`
--

LOCK TABLES `field_config_instance` WRITE;
/*!40000 ALTER TABLE `field_config_instance` DISABLE KEYS */;
INSERT INTO `field_config_instance` VALUES (1,1,'comment_body','comment','comment_node_page','a:6:{s:5:\"label\";s:7:\"Comment\";s:8:\"settings\";a:2:{s:15:\"text_processing\";i:1;s:18:\"user_register_form\";b:0;}s:8:\"required\";b:1;s:7:\"display\";a:1:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";i:0;s:8:\"settings\";a:0:{}s:6:\"module\";s:4:\"text\";}}s:6:\"widget\";a:4:{s:4:\"type\";s:13:\"text_textarea\";s:8:\"settings\";a:1:{s:4:\"rows\";i:5;}s:6:\"weight\";i:0;s:6:\"module\";s:4:\"text\";}s:11:\"description\";s:0:\"\";}',0);
INSERT INTO `field_config_instance` VALUES (2,2,'body','node','page','a:6:{s:5:\"label\";s:4:\"Body\";s:6:\"widget\";a:4:{s:4:\"type\";s:26:\"text_textarea_with_summary\";s:8:\"settings\";a:2:{s:4:\"rows\";i:20;s:12:\"summary_rows\";i:5;}s:6:\"weight\";i:-4;s:6:\"module\";s:4:\"text\";}s:8:\"settings\";a:3:{s:15:\"display_summary\";b:1;s:15:\"text_processing\";i:1;s:18:\"user_register_form\";b:0;}s:7:\"display\";a:2:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:12:\"text_default\";s:8:\"settings\";a:0:{}s:6:\"module\";s:4:\"text\";s:6:\"weight\";i:0;}s:6:\"teaser\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:23:\"text_summary_or_trimmed\";s:8:\"settings\";a:1:{s:11:\"trim_length\";i:600;}s:6:\"module\";s:4:\"text\";s:6:\"weight\";i:0;}}s:8:\"required\";b:0;s:11:\"description\";s:0:\"\";}',0);
INSERT INTO `field_config_instance` VALUES (3,1,'comment_body','comment','comment_node_article','a:6:{s:5:\"label\";s:7:\"Comment\";s:8:\"settings\";a:2:{s:15:\"text_processing\";i:1;s:18:\"user_register_form\";b:0;}s:8:\"required\";b:1;s:7:\"display\";a:1:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";i:0;s:8:\"settings\";a:0:{}s:6:\"module\";s:4:\"text\";}}s:6:\"widget\";a:4:{s:4:\"type\";s:13:\"text_textarea\";s:8:\"settings\";a:1:{s:4:\"rows\";i:5;}s:6:\"weight\";i:0;s:6:\"module\";s:4:\"text\";}s:11:\"description\";s:0:\"\";}',0);
INSERT INTO `field_config_instance` VALUES (4,2,'body','node','article','a:6:{s:5:\"label\";s:4:\"Body\";s:6:\"widget\";a:4:{s:4:\"type\";s:26:\"text_textarea_with_summary\";s:8:\"settings\";a:2:{s:4:\"rows\";i:20;s:12:\"summary_rows\";i:5;}s:6:\"weight\";i:-4;s:6:\"module\";s:4:\"text\";}s:8:\"settings\";a:3:{s:15:\"display_summary\";b:1;s:15:\"text_processing\";i:1;s:18:\"user_register_form\";b:0;}s:7:\"display\";a:2:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:12:\"text_default\";s:8:\"settings\";a:0:{}s:6:\"module\";s:4:\"text\";s:6:\"weight\";i:0;}s:6:\"teaser\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:23:\"text_summary_or_trimmed\";s:8:\"settings\";a:1:{s:11:\"trim_length\";i:600;}s:6:\"module\";s:4:\"text\";s:6:\"weight\";i:0;}}s:8:\"required\";b:0;s:11:\"description\";s:0:\"\";}',0);
INSERT INTO `field_config_instance` VALUES (5,3,'field_tags','node','article','a:6:{s:5:\"label\";s:4:\"Tags\";s:11:\"description\";s:63:\"Enter a comma-separated list of words to describe your content.\";s:6:\"widget\";a:4:{s:4:\"type\";s:21:\"taxonomy_autocomplete\";s:6:\"weight\";i:-4;s:8:\"settings\";a:2:{s:4:\"size\";i:60;s:17:\"autocomplete_path\";s:21:\"taxonomy/autocomplete\";}s:6:\"module\";s:8:\"taxonomy\";}s:7:\"display\";a:2:{s:7:\"default\";a:5:{s:4:\"type\";s:28:\"taxonomy_term_reference_link\";s:6:\"weight\";i:10;s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:6:\"module\";s:8:\"taxonomy\";}s:6:\"teaser\";a:5:{s:4:\"type\";s:28:\"taxonomy_term_reference_link\";s:6:\"weight\";i:10;s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:6:\"module\";s:8:\"taxonomy\";}}s:8:\"settings\";a:1:{s:18:\"user_register_form\";b:0;}s:8:\"required\";b:0;}',0);
INSERT INTO `field_config_instance` VALUES (6,4,'field_image','node','article','a:6:{s:5:\"label\";s:5:\"Image\";s:11:\"description\";s:40:\"Upload an image to go with this article.\";s:8:\"required\";b:0;s:8:\"settings\";a:8:{s:14:\"file_directory\";s:11:\"field/image\";s:15:\"file_extensions\";s:16:\"png gif jpg jpeg\";s:12:\"max_filesize\";s:0:\"\";s:14:\"max_resolution\";s:0:\"\";s:14:\"min_resolution\";s:0:\"\";s:9:\"alt_field\";b:1;s:11:\"title_field\";s:0:\"\";s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:4:{s:4:\"type\";s:11:\"image_image\";s:8:\"settings\";a:2:{s:18:\"progress_indicator\";s:8:\"throbber\";s:19:\"preview_image_style\";s:9:\"thumbnail\";}s:6:\"weight\";i:-1;s:6:\"module\";s:5:\"image\";}s:7:\"display\";a:2:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:5:\"image\";s:8:\"settings\";a:2:{s:11:\"image_style\";s:5:\"large\";s:10:\"image_link\";s:0:\"\";}s:6:\"weight\";i:-1;s:6:\"module\";s:5:\"image\";}s:6:\"teaser\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:5:\"image\";s:8:\"settings\";a:2:{s:11:\"image_style\";s:6:\"medium\";s:10:\"image_link\";s:7:\"content\";}s:6:\"weight\";i:-1;s:6:\"module\";s:5:\"image\";}}}',0);
/*!40000 ALTER TABLE `field_config_instance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_body`
--

DROP TABLE IF EXISTS `field_data_body`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `body_value` longtext,
  `body_summary` longtext,
  `body_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `body_format` (`body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 2 (body)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_body`
--

LOCK TABLES `field_data_body` WRITE;
/*!40000 ALTER TABLE `field_data_body` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_data_body` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_comment_body`
--

DROP TABLE IF EXISTS `field_data_comment_body`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_comment_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `comment_body_value` longtext,
  `comment_body_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `comment_body_format` (`comment_body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 1 (comment_body)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_comment_body`
--

LOCK TABLES `field_data_comment_body` WRITE;
/*!40000 ALTER TABLE `field_data_comment_body` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_data_comment_body` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_field_image`
--

DROP TABLE IF EXISTS `field_data_field_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_image_alt` varchar(128) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_image_title` varchar(128) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_image_fid` (`field_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 4 (field_image)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_field_image`
--

LOCK TABLES `field_data_field_image` WRITE;
/*!40000 ALTER TABLE `field_data_field_image` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_data_field_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_field_tags`
--

DROP TABLE IF EXISTS `field_data_field_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_tags` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_tags_tid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_tags_tid` (`field_tags_tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 3 (field_tags)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_field_tags`
--

LOCK TABLES `field_data_field_tags` WRITE;
/*!40000 ALTER TABLE `field_data_field_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_data_field_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_body`
--

DROP TABLE IF EXISTS `field_revision_body`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `body_value` longtext,
  `body_summary` longtext,
  `body_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `body_format` (`body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 2 (body)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_body`
--

LOCK TABLES `field_revision_body` WRITE;
/*!40000 ALTER TABLE `field_revision_body` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_revision_body` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_comment_body`
--

DROP TABLE IF EXISTS `field_revision_comment_body`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_comment_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `comment_body_value` longtext,
  `comment_body_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `comment_body_format` (`comment_body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 1 (comment_body)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_comment_body`
--

LOCK TABLES `field_revision_comment_body` WRITE;
/*!40000 ALTER TABLE `field_revision_comment_body` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_revision_comment_body` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_field_image`
--

DROP TABLE IF EXISTS `field_revision_field_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_image_alt` varchar(128) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_image_title` varchar(128) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_image_fid` (`field_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 4 (field_image)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_field_image`
--

LOCK TABLES `field_revision_field_image` WRITE;
/*!40000 ALTER TABLE `field_revision_field_image` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_revision_field_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_field_tags`
--

DROP TABLE IF EXISTS `field_revision_field_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_tags` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_tags_tid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_tags_tid` (`field_tags_tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 3 (field_tags)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_field_tags`
--

LOCK TABLES `field_revision_field_tags` WRITE;
/*!40000 ALTER TABLE `field_revision_field_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_revision_field_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file_managed`
--

DROP TABLE IF EXISTS `file_managed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file_managed` (
  `fid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'File ID.',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The users.uid of the user who is associated with the file.',
  `filename` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the file with no path components. This may differ from the basename of the URI if the file is renamed to avoid overwriting an existing file.',
  `uri` varchar(255) NOT NULL DEFAULT '' COMMENT 'The URI to access the file (either local or remote).',
  `filemime` varchar(255) NOT NULL DEFAULT '' COMMENT 'The file’s MIME type.',
  `filesize` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The size of the file in bytes.',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A field indicating the status of the file. Two status are defined in core: temporary (0) and permanent (1). Temporary files older than DRUPAL_MAXIMUM_TEMP_FILE_AGE will be removed during a cron run.',
  `timestamp` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'UNIX timestamp for when the file was added.',
  PRIMARY KEY (`fid`),
  UNIQUE KEY `uri` (`uri`),
  KEY `uid` (`uid`),
  KEY `status` (`status`),
  KEY `timestamp` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information for uploaded files.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file_managed`
--

LOCK TABLES `file_managed` WRITE;
/*!40000 ALTER TABLE `file_managed` DISABLE KEYS */;
/*!40000 ALTER TABLE `file_managed` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file_usage`
--

DROP TABLE IF EXISTS `file_usage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file_usage` (
  `fid` int(10) unsigned NOT NULL COMMENT 'File ID.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the module that is using the file.',
  `type` varchar(64) NOT NULL DEFAULT '' COMMENT 'The name of the object type in which the file is used.',
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The primary key of the object using the file.',
  `count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The number of times this file is used by this object.',
  PRIMARY KEY (`fid`,`type`,`id`,`module`),
  KEY `type_id` (`type`,`id`),
  KEY `fid_count` (`fid`,`count`),
  KEY `fid_module` (`fid`,`module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Track where a file is used.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file_usage`
--

LOCK TABLES `file_usage` WRITE;
/*!40000 ALTER TABLE `file_usage` DISABLE KEYS */;
/*!40000 ALTER TABLE `file_usage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `filter`
--

DROP TABLE IF EXISTS `filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `filter` (
  `format` varchar(255) NOT NULL COMMENT 'Foreign key: The filter_format.format to which this filter is assigned.',
  `module` varchar(64) NOT NULL DEFAULT '' COMMENT 'The origin module of the filter.',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT 'Name of the filter being referenced.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Weight of filter within format.',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT 'Filter enabled status. (1 = enabled, 0 = disabled)',
  `settings` longblob COMMENT 'A serialized array of name value pairs that store the filter settings for the specific format.',
  PRIMARY KEY (`format`,`name`),
  KEY `list` (`weight`,`module`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table that maps filters (HTML corrector) to text formats ...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `filter`
--

LOCK TABLES `filter` WRITE;
/*!40000 ALTER TABLE `filter` DISABLE KEYS */;
INSERT INTO `filter` VALUES ('filtered_html','filter','filter_autop',2,1,'a:0:{}');
INSERT INTO `filter` VALUES ('filtered_html','filter','filter_html',1,1,'a:3:{s:12:\"allowed_html\";s:74:\"<a> <em> <strong> <cite> <blockquote> <code> <ul> <ol> <li> <dl> <dt> <dd>\";s:16:\"filter_html_help\";i:1;s:20:\"filter_html_nofollow\";i:0;}');
INSERT INTO `filter` VALUES ('filtered_html','filter','filter_htmlcorrector',10,1,'a:0:{}');
INSERT INTO `filter` VALUES ('filtered_html','filter','filter_html_escape',10,0,'a:0:{}');
INSERT INTO `filter` VALUES ('filtered_html','filter','filter_url',0,1,'a:1:{s:17:\"filter_url_length\";i:72;}');
INSERT INTO `filter` VALUES ('full_html','filter','filter_autop',1,1,'a:0:{}');
INSERT INTO `filter` VALUES ('full_html','filter','filter_html',10,0,'a:3:{s:12:\"allowed_html\";s:74:\"<a> <em> <strong> <cite> <blockquote> <code> <ul> <ol> <li> <dl> <dt> <dd>\";s:16:\"filter_html_help\";i:1;s:20:\"filter_html_nofollow\";i:0;}');
INSERT INTO `filter` VALUES ('full_html','filter','filter_htmlcorrector',10,1,'a:0:{}');
INSERT INTO `filter` VALUES ('full_html','filter','filter_html_escape',10,0,'a:0:{}');
INSERT INTO `filter` VALUES ('full_html','filter','filter_url',0,1,'a:1:{s:17:\"filter_url_length\";i:72;}');
INSERT INTO `filter` VALUES ('plain_text','filter','filter_autop',2,1,'a:0:{}');
INSERT INTO `filter` VALUES ('plain_text','filter','filter_html',10,0,'a:3:{s:12:\"allowed_html\";s:74:\"<a> <em> <strong> <cite> <blockquote> <code> <ul> <ol> <li> <dl> <dt> <dd>\";s:16:\"filter_html_help\";i:1;s:20:\"filter_html_nofollow\";i:0;}');
INSERT INTO `filter` VALUES ('plain_text','filter','filter_htmlcorrector',10,0,'a:0:{}');
INSERT INTO `filter` VALUES ('plain_text','filter','filter_html_escape',0,1,'a:0:{}');
INSERT INTO `filter` VALUES ('plain_text','filter','filter_url',1,1,'a:1:{s:17:\"filter_url_length\";i:72;}');
/*!40000 ALTER TABLE `filter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `filter_format`
--

DROP TABLE IF EXISTS `filter_format`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `filter_format` (
  `format` varchar(255) NOT NULL COMMENT 'Primary Key: Unique machine name of the format.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the text format (Filtered HTML).',
  `cache` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Flag to indicate whether format is cacheable. (1 = cacheable, 0 = not cacheable)',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'The status of the text format. (1 = enabled, 0 = disabled)',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Weight of text format to use when listing.',
  PRIMARY KEY (`format`),
  UNIQUE KEY `name` (`name`),
  KEY `status_weight` (`status`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores text formats: custom groupings of filters, such as...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `filter_format`
--

LOCK TABLES `filter_format` WRITE;
/*!40000 ALTER TABLE `filter_format` DISABLE KEYS */;
INSERT INTO `filter_format` VALUES ('filtered_html','Filtered HTML',1,1,0);
INSERT INTO `filter_format` VALUES ('full_html','Full HTML',1,1,1);
INSERT INTO `filter_format` VALUES ('plain_text','Plain text',1,1,10);
/*!40000 ALTER TABLE `filter_format` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flood`
--

DROP TABLE IF EXISTS `flood`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flood` (
  `fid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique flood event ID.',
  `event` varchar(64) NOT NULL DEFAULT '' COMMENT 'Name of event (e.g. contact).',
  `identifier` varchar(128) NOT NULL DEFAULT '' COMMENT 'Identifier of the visitor, such as an IP address or hostname.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp of the event.',
  `expiration` int(11) NOT NULL DEFAULT '0' COMMENT 'Expiration timestamp. Expired events are purged on cron run.',
  PRIMARY KEY (`fid`),
  KEY `allow` (`event`,`identifier`,`timestamp`),
  KEY `purge` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Flood controls the threshold of events, such as the...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flood`
--

LOCK TABLES `flood` WRITE;
/*!40000 ALTER TABLE `flood` DISABLE KEYS */;
/*!40000 ALTER TABLE `flood` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history`
--

DROP TABLE IF EXISTS `history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history` (
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that read the node nid.',
  `nid` int(11) NOT NULL DEFAULT '0' COMMENT 'The node.nid that was read.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp at which the read occurred.',
  PRIMARY KEY (`uid`,`nid`),
  KEY `nid` (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A record of which users have read which nodes.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history`
--

LOCK TABLES `history` WRITE;
/*!40000 ALTER TABLE `history` DISABLE KEYS */;
/*!40000 ALTER TABLE `history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `image_effects`
--

DROP TABLE IF EXISTS `image_effects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `image_effects` (
  `ieid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for an image effect.',
  `isid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The image_styles.isid for an image style.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of the effect in the style.',
  `name` varchar(255) NOT NULL COMMENT 'The unique name of the effect to be executed.',
  `data` longblob NOT NULL COMMENT 'The configuration data for the effect.',
  PRIMARY KEY (`ieid`),
  KEY `isid` (`isid`),
  KEY `weight` (`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configuration options for image effects.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image_effects`
--

LOCK TABLES `image_effects` WRITE;
/*!40000 ALTER TABLE `image_effects` DISABLE KEYS */;
/*!40000 ALTER TABLE `image_effects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `image_styles`
--

DROP TABLE IF EXISTS `image_styles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `image_styles` (
  `isid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for an image style.',
  `name` varchar(255) NOT NULL COMMENT 'The style name.',
  PRIMARY KEY (`isid`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configuration options for image styles.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image_styles`
--

LOCK TABLES `image_styles` WRITE;
/*!40000 ALTER TABLE `image_styles` DISABLE KEYS */;
/*!40000 ALTER TABLE `image_styles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_custom`
--

DROP TABLE IF EXISTS `menu_custom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu_custom` (
  `menu_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique key for menu. This is used as a block delta so length is 32.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'Menu title; displayed at top of block.',
  `description` text COMMENT 'Menu description.',
  PRIMARY KEY (`menu_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Holds definitions for top-level custom menus (for example...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_custom`
--

LOCK TABLES `menu_custom` WRITE;
/*!40000 ALTER TABLE `menu_custom` DISABLE KEYS */;
INSERT INTO `menu_custom` VALUES ('main-menu','Main menu','The <em>Main</em> menu is used on many sites to show the major sections of the site, often in a top navigation bar.');
INSERT INTO `menu_custom` VALUES ('management','Management','The <em>Management</em> menu contains links for administrative tasks.');
INSERT INTO `menu_custom` VALUES ('navigation','Navigation','The <em>Navigation</em> menu contains links intended for site visitors. Links are added to the <em>Navigation</em> menu automatically by some modules.');
INSERT INTO `menu_custom` VALUES ('user-menu','User menu','The <em>User</em> menu contains links related to the user\'s account, as well as the \'Log out\' link.');
/*!40000 ALTER TABLE `menu_custom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_links`
--

DROP TABLE IF EXISTS `menu_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu_links` (
  `menu_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'The menu name. All links with the same menu name (such as ’navigation’) are part of the same menu.',
  `mlid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The menu link ID (mlid) is the integer primary key.',
  `plid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The parent link ID (plid) is the mlid of the link above in the hierarchy, or zero if the link is at the top level in its menu.',
  `link_path` varchar(255) NOT NULL DEFAULT '' COMMENT 'The Drupal path or external path this link points to.',
  `router_path` varchar(255) NOT NULL DEFAULT '' COMMENT 'For links corresponding to a Drupal path (external = 0), this connects the link to a menu_router.path for joins.',
  `link_title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The text displayed for the link, which may be modified by a title callback stored in menu_router.',
  `options` blob COMMENT 'A serialized array of options to be passed to the url() or l() function, such as a query string or HTML attributes.',
  `module` varchar(255) NOT NULL DEFAULT 'system' COMMENT 'The name of the module that generated this link.',
  `hidden` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag for whether the link should be rendered in menus. (1 = a disabled menu item that may be shown on admin screens, -1 = a menu callback, 0 = a normal, visible link)',
  `external` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate if the link points to a full URL starting with a protocol, like http:// (1 = external, 0 = internal).',
  `has_children` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Flag indicating whether any links have this link as a parent (1 = children exist, 0 = no children).',
  `expanded` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Flag for whether this link should be rendered as expanded in menus - expanded links always have their child links displayed, instead of only when the link is in the active trail (1 = expanded, 0 = not expanded)',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Link weight among links in the same menu at the same depth.',
  `depth` smallint(6) NOT NULL DEFAULT '0' COMMENT 'The depth relative to the top level. A link with plid == 0 will have depth == 1.',
  `customized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate that the user has manually created or edited the link (1 = customized, 0 = not customized).',
  `p1` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The first mlid in the materialized path. If N = depth, then pN must equal the mlid. If depth > 1 then p(N-1) must equal the plid. All pX where X > depth must equal zero. The columns p1 .. p9 are also called the parents.',
  `p2` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The second mlid in the materialized path. See p1.',
  `p3` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The third mlid in the materialized path. See p1.',
  `p4` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The fourth mlid in the materialized path. See p1.',
  `p5` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The fifth mlid in the materialized path. See p1.',
  `p6` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The sixth mlid in the materialized path. See p1.',
  `p7` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The seventh mlid in the materialized path. See p1.',
  `p8` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The eighth mlid in the materialized path. See p1.',
  `p9` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The ninth mlid in the materialized path. See p1.',
  `updated` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Flag that indicates that this link was generated during the update from Drupal 5.',
  PRIMARY KEY (`mlid`),
  KEY `path_menu` (`link_path`(128),`menu_name`),
  KEY `menu_plid_expand_child` (`menu_name`,`plid`,`expanded`,`has_children`),
  KEY `menu_parents` (`menu_name`,`p1`,`p2`,`p3`,`p4`,`p5`,`p6`,`p7`,`p8`,`p9`),
  KEY `router_path` (`router_path`(128))
) ENGINE=InnoDB AUTO_INCREMENT=269 DEFAULT CHARSET=utf8 COMMENT='Contains the individual links within a menu.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_links`
--

LOCK TABLES `menu_links` WRITE;
/*!40000 ALTER TABLE `menu_links` DISABLE KEYS */;
INSERT INTO `menu_links` VALUES ('management',1,0,'admin','admin','Administration','a:0:{}','system',0,0,1,0,9,1,0,1,0,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('user-menu',2,0,'user','user','User account','a:1:{s:5:\"alter\";b:1;}','system',0,0,0,0,-10,1,0,2,0,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',3,0,'comment/%','comment/%','Comment permalink','a:0:{}','system',0,0,1,0,0,1,0,3,0,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',4,0,'filter/tips','filter/tips','Compose tips','a:0:{}','system',1,0,0,0,0,1,0,4,0,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',5,0,'node/%','node/%','','a:0:{}','system',0,0,0,0,0,1,0,5,0,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',6,0,'node/add','node/add','Add content','a:0:{}','system',0,0,1,0,0,1,0,6,0,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',7,1,'admin/appearance','admin/appearance','Appearance','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:33:\"Select and configure your themes.\";}}','system',0,0,0,0,-6,2,0,1,7,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',8,1,'admin/config','admin/config','Configuration','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:20:\"Administer settings.\";}}','system',0,0,1,0,0,2,0,1,8,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',9,1,'admin/content','admin/content','Content','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:32:\"Administer content and comments.\";}}','system',0,0,1,0,-10,2,0,1,9,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('user-menu',10,2,'user/register','user/register','Create new account','a:0:{}','system',-1,0,0,0,0,2,0,2,10,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',11,1,'admin/dashboard','admin/dashboard','Dashboard','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:34:\"View and customize your dashboard.\";}}','system',0,0,0,0,-15,2,0,1,11,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',12,1,'admin/help','admin/help','Help','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:48:\"Reference for usage, configuration, and modules.\";}}','system',0,0,0,0,9,2,0,1,12,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',13,1,'admin/index','admin/index','Index','a:0:{}','system',-1,0,0,0,-18,2,0,1,13,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('user-menu',14,2,'user/login','user/login','Log in','a:0:{}','system',-1,0,0,0,0,2,0,2,14,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('user-menu',15,0,'user/logout','user/logout','Log out','a:0:{}','system',0,0,0,0,10,1,0,15,0,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',16,1,'admin/modules','admin/modules','Modules','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:26:\"Extend site functionality.\";}}','system',0,0,0,0,-2,2,0,1,16,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',17,0,'user/%','user/%','My account','a:0:{}','system',0,0,1,0,0,1,0,17,0,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',18,1,'admin/people','admin/people','People','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:45:\"Manage user accounts, roles, and permissions.\";}}','system',0,0,0,0,-4,2,0,1,18,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',19,1,'admin/reports','admin/reports','Reports','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:34:\"View reports, updates, and errors.\";}}','system',0,0,1,0,5,2,0,1,19,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('user-menu',20,2,'user/password','user/password','Request new password','a:0:{}','system',-1,0,0,0,0,2,0,2,20,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',21,1,'admin/structure','admin/structure','Structure','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:45:\"Administer blocks, content types, menus, etc.\";}}','system',0,0,1,0,-8,2,0,1,21,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',22,1,'admin/tasks','admin/tasks','Tasks','a:0:{}','system',-1,0,0,0,-20,2,0,1,22,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',23,0,'comment/reply/%','comment/reply/%','Add new comment','a:0:{}','system',0,0,0,0,0,1,0,23,0,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',24,3,'comment/%/approve','comment/%/approve','Approve','a:0:{}','system',0,0,0,0,1,2,0,3,24,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',25,3,'comment/%/delete','comment/%/delete','Delete','a:0:{}','system',-1,0,0,0,2,2,0,3,25,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',26,3,'comment/%/edit','comment/%/edit','Edit','a:0:{}','system',-1,0,0,0,0,2,0,3,26,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',27,0,'taxonomy/term/%','taxonomy/term/%','Taxonomy term','a:0:{}','system',0,0,0,0,0,1,0,27,0,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',28,3,'comment/%/view','comment/%/view','View comment','a:0:{}','system',-1,0,0,0,-10,2,0,3,28,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',29,18,'admin/people/create','admin/people/create','Add user','a:0:{}','system',-1,0,0,0,0,3,0,1,18,29,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',30,21,'admin/structure/block','admin/structure/block','Blocks','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:79:\"Configure what block content appears in your site\'s sidebars and other regions.\";}}','system',0,0,1,0,0,3,0,1,21,30,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',31,17,'user/%/cancel','user/%/cancel','Cancel account','a:0:{}','system',0,0,1,0,0,2,0,17,31,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',32,9,'admin/content/comment','admin/content/comment','Comments','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:59:\"List and edit site comments and the comment approval queue.\";}}','system',0,0,0,0,0,3,0,1,9,32,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',33,11,'admin/dashboard/configure','admin/dashboard/configure','Configure available dashboard blocks','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:53:\"Configure which blocks can be shown on the dashboard.\";}}','system',-1,0,0,0,0,3,0,1,11,33,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',34,9,'admin/content/node','admin/content/node','Content','a:0:{}','system',-1,0,0,0,-10,3,0,1,9,34,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',35,8,'admin/config/content','admin/config/content','Content authoring','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:53:\"Settings related to formatting and authoring content.\";}}','system',0,0,1,0,-15,3,0,1,8,35,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',36,21,'admin/structure/types','admin/structure/types','Content types','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:92:\"Manage content types, including default status, front page promotion, comment settings, etc.\";}}','system',0,0,1,0,0,3,0,1,21,36,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',37,11,'admin/dashboard/customize','admin/dashboard/customize','Customize dashboard','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:25:\"Customize your dashboard.\";}}','system',-1,0,0,0,0,3,0,1,11,37,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',38,5,'node/%/delete','node/%/delete','Delete','a:0:{}','system',-1,0,0,0,1,2,0,5,38,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',39,8,'admin/config/development','admin/config/development','Development','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:18:\"Development tools.\";}}','system',0,0,1,0,-10,3,0,1,8,39,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',40,17,'user/%/edit','user/%/edit','Edit','a:0:{}','system',-1,0,0,0,0,2,0,17,40,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',41,5,'node/%/edit','node/%/edit','Edit','a:0:{}','system',-1,0,0,0,0,2,0,5,41,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',42,19,'admin/reports/fields','admin/reports/fields','Field list','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:39:\"Overview of fields on all entity types.\";}}','system',0,0,0,0,0,3,0,1,19,42,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',43,7,'admin/appearance/list','admin/appearance/list','List','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:31:\"Select and configure your theme\";}}','system',-1,0,0,0,-1,3,0,1,7,43,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',44,16,'admin/modules/list','admin/modules/list','List','a:0:{}','system',-1,0,0,0,0,3,0,1,16,44,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',45,18,'admin/people/people','admin/people/people','List','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:50:\"Find and manage people interacting with your site.\";}}','system',-1,0,0,0,-10,3,0,1,18,45,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',46,8,'admin/config/media','admin/config/media','Media','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:12:\"Media tools.\";}}','system',0,0,1,0,-10,3,0,1,8,46,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',47,21,'admin/structure/menu','admin/structure/menu','Menus','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:86:\"Add new menus to your site, edit existing menus, and rename and reorganize menu links.\";}}','system',0,0,1,0,0,3,0,1,21,47,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',48,8,'admin/config/people','admin/config/people','People','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:24:\"Configure user accounts.\";}}','system',0,0,1,0,-20,3,0,1,8,48,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',49,18,'admin/people/permissions','admin/people/permissions','Permissions','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:64:\"Determine access to features by selecting permissions for roles.\";}}','system',-1,0,0,0,0,3,0,1,18,49,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',50,19,'admin/reports/dblog','admin/reports/dblog','Recent log messages','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:43:\"View events that have recently been logged.\";}}','system',0,0,0,0,-1,3,0,1,19,50,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',51,8,'admin/config/regional','admin/config/regional','Regional and language','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:48:\"Regional settings, localization and translation.\";}}','system',0,0,1,0,-5,3,0,1,8,51,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',52,5,'node/%/revisions','node/%/revisions','Revisions','a:0:{}','system',-1,0,1,0,2,2,0,5,52,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',53,8,'admin/config/search','admin/config/search','Search and metadata','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:36:\"Local site search, metadata and SEO.\";}}','system',0,0,1,0,-10,3,0,1,8,53,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',54,7,'admin/appearance/settings','admin/appearance/settings','Settings','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:46:\"Configure default and theme specific settings.\";}}','system',-1,0,0,0,20,3,0,1,7,54,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',55,19,'admin/reports/status','admin/reports/status','Status report','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:74:\"Get a status report about your site\'s operation and any detected problems.\";}}','system',0,0,0,0,-60,3,0,1,19,55,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',56,8,'admin/config/system','admin/config/system','System','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:37:\"General system related configuration.\";}}','system',0,0,1,0,-20,3,0,1,8,56,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',57,21,'admin/structure/taxonomy','admin/structure/taxonomy','Taxonomy','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:67:\"Manage tagging, categorization, and classification of your content.\";}}','system',0,0,1,0,0,3,0,1,21,57,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',58,19,'admin/reports/access-denied','admin/reports/access-denied','Top \'access denied\' errors','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:35:\"View \'access denied\' errors (403s).\";}}','system',0,0,0,0,0,3,0,1,19,58,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',59,19,'admin/reports/page-not-found','admin/reports/page-not-found','Top \'page not found\' errors','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:36:\"View \'page not found\' errors (404s).\";}}','system',0,0,0,0,0,3,0,1,19,59,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',60,16,'admin/modules/uninstall','admin/modules/uninstall','Uninstall','a:0:{}','system',-1,0,0,0,20,3,0,1,16,60,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',61,8,'admin/config/user-interface','admin/config/user-interface','User interface','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:38:\"Tools that enhance the user interface.\";}}','system',0,0,1,0,-15,3,0,1,8,61,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',62,5,'node/%/view','node/%/view','View','a:0:{}','system',-1,0,0,0,-10,2,0,5,62,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',63,17,'user/%/view','user/%/view','View','a:0:{}','system',-1,0,0,0,-10,2,0,17,63,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',64,8,'admin/config/services','admin/config/services','Web services','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:30:\"Tools related to web services.\";}}','system',0,0,1,0,0,3,0,1,8,64,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',65,8,'admin/config/workflow','admin/config/workflow','Workflow','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:43:\"Content workflow, editorial workflow tools.\";}}','system',0,0,0,0,5,3,0,1,8,65,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',66,12,'admin/help/block','admin/help/block','block','a:0:{}','system',-1,0,0,0,0,3,0,1,12,66,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',67,12,'admin/help/color','admin/help/color','color','a:0:{}','system',-1,0,0,0,0,3,0,1,12,67,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',68,12,'admin/help/comment','admin/help/comment','comment','a:0:{}','system',-1,0,0,0,0,3,0,1,12,68,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',69,12,'admin/help/contextual','admin/help/contextual','contextual','a:0:{}','system',-1,0,0,0,0,3,0,1,12,69,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',70,12,'admin/help/dashboard','admin/help/dashboard','dashboard','a:0:{}','system',-1,0,0,0,0,3,0,1,12,70,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',71,12,'admin/help/dblog','admin/help/dblog','dblog','a:0:{}','system',-1,0,0,0,0,3,0,1,12,71,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',72,12,'admin/help/field','admin/help/field','field','a:0:{}','system',-1,0,0,0,0,3,0,1,12,72,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',73,12,'admin/help/field_sql_storage','admin/help/field_sql_storage','field_sql_storage','a:0:{}','system',-1,0,0,0,0,3,0,1,12,73,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',74,12,'admin/help/field_ui','admin/help/field_ui','field_ui','a:0:{}','system',-1,0,0,0,0,3,0,1,12,74,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',75,12,'admin/help/file','admin/help/file','file','a:0:{}','system',-1,0,0,0,0,3,0,1,12,75,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',76,12,'admin/help/filter','admin/help/filter','filter','a:0:{}','system',-1,0,0,0,0,3,0,1,12,76,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',77,12,'admin/help/help','admin/help/help','help','a:0:{}','system',-1,0,0,0,0,3,0,1,12,77,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',78,12,'admin/help/image','admin/help/image','image','a:0:{}','system',-1,0,0,0,0,3,0,1,12,78,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',79,12,'admin/help/list','admin/help/list','list','a:0:{}','system',-1,0,0,0,0,3,0,1,12,79,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',80,12,'admin/help/menu','admin/help/menu','menu','a:0:{}','system',-1,0,0,0,0,3,0,1,12,80,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',81,12,'admin/help/node','admin/help/node','node','a:0:{}','system',-1,0,0,0,0,3,0,1,12,81,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',82,12,'admin/help/options','admin/help/options','options','a:0:{}','system',-1,0,0,0,0,3,0,1,12,82,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',83,12,'admin/help/system','admin/help/system','system','a:0:{}','system',-1,0,0,0,0,3,0,1,12,83,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',84,12,'admin/help/taxonomy','admin/help/taxonomy','taxonomy','a:0:{}','system',-1,0,0,0,0,3,0,1,12,84,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',85,12,'admin/help/text','admin/help/text','text','a:0:{}','system',-1,0,0,0,0,3,0,1,12,85,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',86,12,'admin/help/user','admin/help/user','user','a:0:{}','system',-1,0,0,0,0,3,0,1,12,86,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',87,27,'taxonomy/term/%/edit','taxonomy/term/%/edit','Edit','a:0:{}','system',-1,0,0,0,10,2,0,27,87,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',88,27,'taxonomy/term/%/view','taxonomy/term/%/view','View','a:0:{}','system',-1,0,0,0,0,2,0,27,88,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',89,48,'admin/config/people/accounts','admin/config/people/accounts','Account settings','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:109:\"Configure default behavior of users, including registration requirements, e-mails, fields, and user pictures.\";}}','system',0,0,0,0,-10,4,0,1,8,48,89,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',90,56,'admin/config/system/actions','admin/config/system/actions','Actions','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:41:\"Manage the actions defined for your site.\";}}','system',0,0,1,0,0,4,0,1,8,56,90,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',91,30,'admin/structure/block/add','admin/structure/block/add','Add block','a:0:{}','system',-1,0,0,0,0,4,0,1,21,30,91,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',92,36,'admin/structure/types/add','admin/structure/types/add','Add content type','a:0:{}','system',-1,0,0,0,0,4,0,1,21,36,92,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',93,47,'admin/structure/menu/add','admin/structure/menu/add','Add menu','a:0:{}','system',-1,0,0,0,0,4,0,1,21,47,93,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',94,57,'admin/structure/taxonomy/add','admin/structure/taxonomy/add','Add vocabulary','a:0:{}','system',-1,0,0,0,0,4,0,1,21,57,94,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',95,54,'admin/appearance/settings/bartik','admin/appearance/settings/bartik','Bartik','a:0:{}','system',-1,0,0,0,0,4,0,1,7,54,95,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',96,53,'admin/config/search/clean-urls','admin/config/search/clean-urls','Clean URLs','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:43:\"Enable or disable clean URLs for your site.\";}}','system',0,0,0,0,5,4,0,1,8,53,96,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',97,56,'admin/config/system/cron','admin/config/system/cron','Cron','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:40:\"Manage automatic site maintenance tasks.\";}}','system',0,0,0,0,20,4,0,1,8,56,97,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',98,51,'admin/config/regional/date-time','admin/config/regional/date-time','Date and time','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:44:\"Configure display formats for date and time.\";}}','system',0,0,0,0,-15,4,0,1,8,51,98,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',99,19,'admin/reports/event/%','admin/reports/event/%','Details','a:0:{}','system',0,0,0,0,0,3,0,1,19,99,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',100,46,'admin/config/media/file-system','admin/config/media/file-system','File system','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:68:\"Tell Drupal where to store uploaded files and how they are accessed.\";}}','system',0,0,0,0,-10,4,0,1,8,46,100,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',101,54,'admin/appearance/settings/garland','admin/appearance/settings/garland','Garland','a:0:{}','system',-1,0,0,0,0,4,0,1,7,54,101,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',102,54,'admin/appearance/settings/global','admin/appearance/settings/global','Global settings','a:0:{}','system',-1,0,0,0,-1,4,0,1,7,54,102,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',103,48,'admin/config/people/ip-blocking','admin/config/people/ip-blocking','IP address blocking','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:28:\"Manage blocked IP addresses.\";}}','system',0,0,1,0,10,4,0,1,8,48,103,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',104,46,'admin/config/media/image-styles','admin/config/media/image-styles','Image styles','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:78:\"Configure styles that can be used for resizing or adjusting images on display.\";}}','system',0,0,1,0,0,4,0,1,8,46,104,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',105,46,'admin/config/media/image-toolkit','admin/config/media/image-toolkit','Image toolkit','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:74:\"Choose which image toolkit to use if you have installed optional toolkits.\";}}','system',0,0,0,0,20,4,0,1,8,46,105,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',106,44,'admin/modules/list/confirm','admin/modules/list/confirm','List','a:0:{}','system',-1,0,0,0,0,4,0,1,16,44,106,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',107,36,'admin/structure/types/list','admin/structure/types/list','List','a:0:{}','system',-1,0,0,0,-10,4,0,1,21,36,107,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',108,57,'admin/structure/taxonomy/list','admin/structure/taxonomy/list','List','a:0:{}','system',-1,0,0,0,-10,4,0,1,21,57,108,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',109,47,'admin/structure/menu/list','admin/structure/menu/list','List menus','a:0:{}','system',-1,0,0,0,-10,4,0,1,21,47,109,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',110,39,'admin/config/development/logging','admin/config/development/logging','Logging and errors','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:154:\"Settings for logging and alerts modules. Various modules can route Drupal\'s system events to different destinations, such as syslog, database, email, etc.\";}}','system',0,0,0,0,-15,4,0,1,8,39,110,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',111,39,'admin/config/development/maintenance','admin/config/development/maintenance','Maintenance mode','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:62:\"Take the site offline for maintenance or bring it back online.\";}}','system',0,0,0,0,-10,4,0,1,8,39,111,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',112,39,'admin/config/development/performance','admin/config/development/performance','Performance','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:101:\"Enable or disable page caching for anonymous users and set CSS and JS bandwidth optimization options.\";}}','system',0,0,0,0,-20,4,0,1,8,39,112,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',113,49,'admin/people/permissions/list','admin/people/permissions/list','Permissions','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:64:\"Determine access to features by selecting permissions for roles.\";}}','system',-1,0,0,0,-8,4,0,1,18,49,113,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',114,32,'admin/content/comment/new','admin/content/comment/new','Published comments','a:0:{}','system',-1,0,0,0,-10,4,0,1,9,32,114,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',115,64,'admin/config/services/rss-publishing','admin/config/services/rss-publishing','RSS publishing','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:114:\"Configure the site description, the number of items per feed and whether feeds should be titles/teasers/full-text.\";}}','system',0,0,0,0,0,4,0,1,8,64,115,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',116,51,'admin/config/regional/settings','admin/config/regional/settings','Regional settings','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:54:\"Settings for the site\'s default time zone and country.\";}}','system',0,0,0,0,-20,4,0,1,8,51,116,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',117,49,'admin/people/permissions/roles','admin/people/permissions/roles','Roles','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:30:\"List, edit, or add user roles.\";}}','system',-1,0,1,0,-5,4,0,1,18,49,117,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',118,47,'admin/structure/menu/settings','admin/structure/menu/settings','Settings','a:0:{}','system',-1,0,0,0,5,4,0,1,21,47,118,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',119,54,'admin/appearance/settings/seven','admin/appearance/settings/seven','Seven','a:0:{}','system',-1,0,0,0,0,4,0,1,7,54,119,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',120,56,'admin/config/system/site-information','admin/config/system/site-information','Site information','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:104:\"Change site name, e-mail address, slogan, default front page, and number of posts per page, error pages.\";}}','system',0,0,0,0,-20,4,0,1,8,56,120,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',121,54,'admin/appearance/settings/stark','admin/appearance/settings/stark','Stark','a:0:{}','system',-1,0,0,0,0,4,0,1,7,54,121,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',122,54,'admin/appearance/settings/test_theme','admin/appearance/settings/test_theme','Test theme','a:0:{}','system',-1,0,0,0,0,4,0,1,7,54,122,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',123,35,'admin/config/content/formats','admin/config/content/formats','Text formats','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:127:\"Configure how content input by users is filtered, including allowed HTML tags. Also allows enabling of module-provided filters.\";}}','system',0,0,1,0,0,4,0,1,8,35,123,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',124,32,'admin/content/comment/approval','admin/content/comment/approval','Unapproved comments','a:0:{}','system',-1,0,0,0,0,4,0,1,9,32,124,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',125,60,'admin/modules/uninstall/confirm','admin/modules/uninstall/confirm','Uninstall','a:0:{}','system',-1,0,0,0,0,4,0,1,16,60,125,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',126,54,'admin/appearance/settings/update_test_basetheme','admin/appearance/settings/update_test_basetheme','Update test base theme','a:0:{}','system',-1,0,0,0,0,4,0,1,7,54,126,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',127,57,'admin/structure/taxonomy/%','admin/structure/taxonomy/%','','a:0:{}','system',0,0,0,0,0,4,0,1,21,57,127,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',128,54,'admin/appearance/settings/update_test_subtheme','admin/appearance/settings/update_test_subtheme','Update test subtheme','a:0:{}','system',-1,0,0,0,0,4,0,1,7,54,128,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',129,40,'user/%/edit/account','user/%/edit/account','Account','a:0:{}','system',-1,0,0,0,0,3,0,17,40,129,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',130,123,'admin/config/content/formats/%','admin/config/content/formats/%','','a:0:{}','system',0,0,1,0,0,5,0,1,8,35,123,130,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',131,104,'admin/config/media/image-styles/add','admin/config/media/image-styles/add','Add style','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:22:\"Add a new image style.\";}}','system',-1,0,0,0,2,5,0,1,8,46,104,131,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',132,127,'admin/structure/taxonomy/%/add','admin/structure/taxonomy/%/add','Add term','a:0:{}','system',-1,0,0,0,0,5,0,1,21,57,127,132,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',133,123,'admin/config/content/formats/add','admin/config/content/formats/add','Add text format','a:0:{}','system',-1,0,0,0,1,5,0,1,8,35,123,133,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',134,30,'admin/structure/block/list/bartik','admin/structure/block/list/bartik','Bartik','a:0:{}','system',-1,0,0,0,-10,4,0,1,21,30,134,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',135,90,'admin/config/system/actions/configure','admin/config/system/actions/configure','Configure an advanced action','a:0:{}','system',-1,0,0,0,0,5,0,1,8,56,90,135,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',136,47,'admin/structure/menu/manage/%','admin/structure/menu/manage/%','Customize menu','a:0:{}','system',0,0,1,0,0,4,0,1,21,47,136,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',137,127,'admin/structure/taxonomy/%/edit','admin/structure/taxonomy/%/edit','Edit','a:0:{}','system',-1,0,0,0,-10,5,0,1,21,57,127,137,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',138,36,'admin/structure/types/manage/%','admin/structure/types/manage/%','Edit content type','a:0:{}','system',0,0,1,0,0,4,0,1,21,36,138,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',139,98,'admin/config/regional/date-time/formats','admin/config/regional/date-time/formats','Formats','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:51:\"Configure display format strings for date and time.\";}}','system',-1,0,1,0,-9,5,0,1,8,51,98,139,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',140,30,'admin/structure/block/list/garland','admin/structure/block/list/garland','Garland','a:0:{}','system',-1,0,0,0,0,4,0,1,21,30,140,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',141,123,'admin/config/content/formats/list','admin/config/content/formats/list','List','a:0:{}','system',-1,0,0,0,0,5,0,1,8,35,123,141,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',142,127,'admin/structure/taxonomy/%/list','admin/structure/taxonomy/%/list','List','a:0:{}','system',-1,0,0,0,-20,5,0,1,21,57,127,142,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',143,104,'admin/config/media/image-styles/list','admin/config/media/image-styles/list','List','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:42:\"List the current image styles on the site.\";}}','system',-1,0,0,0,1,5,0,1,8,46,104,143,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',144,90,'admin/config/system/actions/manage','admin/config/system/actions/manage','Manage actions','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:41:\"Manage the actions defined for your site.\";}}','system',-1,0,0,0,-2,5,0,1,8,56,90,144,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',145,89,'admin/config/people/accounts/settings','admin/config/people/accounts/settings','Settings','a:0:{}','system',-1,0,0,0,-10,5,0,1,8,48,89,145,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',146,30,'admin/structure/block/list/seven','admin/structure/block/list/seven','Seven','a:0:{}','system',-1,0,0,0,0,4,0,1,21,30,146,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',147,30,'admin/structure/block/list/stark','admin/structure/block/list/stark','Stark','a:0:{}','system',-1,0,0,0,0,4,0,1,21,30,147,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',148,30,'admin/structure/block/list/test_theme','admin/structure/block/list/test_theme','Test theme','a:0:{}','system',-1,0,0,0,0,4,0,1,21,30,148,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',149,98,'admin/config/regional/date-time/types','admin/config/regional/date-time/types','Types','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:44:\"Configure display formats for date and time.\";}}','system',-1,0,1,0,-10,5,0,1,8,51,98,149,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',150,30,'admin/structure/block/list/update_test_basetheme','admin/structure/block/list/update_test_basetheme','Update test base theme','a:0:{}','system',-1,0,0,0,0,4,0,1,21,30,150,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',151,30,'admin/structure/block/list/update_test_subtheme','admin/structure/block/list/update_test_subtheme','Update test subtheme','a:0:{}','system',-1,0,0,0,0,4,0,1,21,30,151,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',152,52,'node/%/revisions/%/delete','node/%/revisions/%/delete','Delete earlier revision','a:0:{}','system',0,0,0,0,0,3,0,5,52,152,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',153,52,'node/%/revisions/%/revert','node/%/revisions/%/revert','Revert to earlier revision','a:0:{}','system',0,0,0,0,0,3,0,5,52,153,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',154,52,'node/%/revisions/%/view','node/%/revisions/%/view','Revisions','a:0:{}','system',0,0,0,0,0,3,0,5,52,154,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',155,140,'admin/structure/block/list/garland/add','admin/structure/block/list/garland/add','Add block','a:0:{}','system',-1,0,0,0,0,5,0,1,21,30,140,155,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',156,146,'admin/structure/block/list/seven/add','admin/structure/block/list/seven/add','Add block','a:0:{}','system',-1,0,0,0,0,5,0,1,21,30,146,156,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',157,147,'admin/structure/block/list/stark/add','admin/structure/block/list/stark/add','Add block','a:0:{}','system',-1,0,0,0,0,5,0,1,21,30,147,157,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',158,148,'admin/structure/block/list/test_theme/add','admin/structure/block/list/test_theme/add','Add block','a:0:{}','system',-1,0,0,0,0,5,0,1,21,30,148,158,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',159,150,'admin/structure/block/list/update_test_basetheme/add','admin/structure/block/list/update_test_basetheme/add','Add block','a:0:{}','system',-1,0,0,0,0,5,0,1,21,30,150,159,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',160,151,'admin/structure/block/list/update_test_subtheme/add','admin/structure/block/list/update_test_subtheme/add','Add block','a:0:{}','system',-1,0,0,0,0,5,0,1,21,30,151,160,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',161,149,'admin/config/regional/date-time/types/add','admin/config/regional/date-time/types/add','Add date type','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:18:\"Add new date type.\";}}','system',-1,0,0,0,-10,6,0,1,8,51,98,149,161,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',162,139,'admin/config/regional/date-time/formats/add','admin/config/regional/date-time/formats/add','Add format','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:43:\"Allow users to add additional date formats.\";}}','system',-1,0,0,0,-10,6,0,1,8,51,98,139,162,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',163,136,'admin/structure/menu/manage/%/add','admin/structure/menu/manage/%/add','Add link','a:0:{}','system',-1,0,0,0,0,5,0,1,21,47,136,163,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',164,30,'admin/structure/block/manage/%/%','admin/structure/block/manage/%/%','Configure block','a:0:{}','system',0,0,0,0,0,4,0,1,21,30,164,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',165,31,'user/%/cancel/confirm/%/%','user/%/cancel/confirm/%/%','Confirm account cancellation','a:0:{}','system',0,0,0,0,0,3,0,17,31,165,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',166,138,'admin/structure/types/manage/%/delete','admin/structure/types/manage/%/delete','Delete','a:0:{}','system',0,0,0,0,0,5,0,1,21,36,138,166,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',167,103,'admin/config/people/ip-blocking/delete/%','admin/config/people/ip-blocking/delete/%','Delete IP address','a:0:{}','system',0,0,0,0,0,5,0,1,8,48,103,167,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',168,90,'admin/config/system/actions/delete/%','admin/config/system/actions/delete/%','Delete action','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:17:\"Delete an action.\";}}','system',0,0,0,0,0,5,0,1,8,56,90,168,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',169,136,'admin/structure/menu/manage/%/delete','admin/structure/menu/manage/%/delete','Delete menu','a:0:{}','system',0,0,0,0,0,5,0,1,21,47,136,169,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',170,47,'admin/structure/menu/item/%/delete','admin/structure/menu/item/%/delete','Delete menu link','a:0:{}','system',0,0,0,0,0,4,0,1,21,47,170,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',171,117,'admin/people/permissions/roles/delete/%','admin/people/permissions/roles/delete/%','Delete role','a:0:{}','system',0,0,0,0,0,5,0,1,18,49,117,171,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',172,130,'admin/config/content/formats/%/disable','admin/config/content/formats/%/disable','Disable text format','a:0:{}','system',0,0,0,0,0,6,0,1,8,35,123,130,172,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',173,138,'admin/structure/types/manage/%/edit','admin/structure/types/manage/%/edit','Edit','a:0:{}','system',-1,0,0,0,0,5,0,1,21,36,138,173,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',174,136,'admin/structure/menu/manage/%/edit','admin/structure/menu/manage/%/edit','Edit menu','a:0:{}','system',-1,0,0,0,0,5,0,1,21,47,136,174,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',175,47,'admin/structure/menu/item/%/edit','admin/structure/menu/item/%/edit','Edit menu link','a:0:{}','system',0,0,0,0,0,4,0,1,21,47,175,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',176,117,'admin/people/permissions/roles/edit/%','admin/people/permissions/roles/edit/%','Edit role','a:0:{}','system',0,0,0,0,0,5,0,1,18,49,117,176,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',177,104,'admin/config/media/image-styles/edit/%','admin/config/media/image-styles/edit/%','Edit style','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:25:\"Configure an image style.\";}}','system',0,0,1,0,0,5,0,1,8,46,104,177,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',178,136,'admin/structure/menu/manage/%/list','admin/structure/menu/manage/%/list','List links','a:0:{}','system',-1,0,0,0,-10,5,0,1,21,47,136,178,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',179,47,'admin/structure/menu/item/%/reset','admin/structure/menu/item/%/reset','Reset menu link','a:0:{}','system',0,0,0,0,0,4,0,1,21,47,179,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',180,104,'admin/config/media/image-styles/delete/%','admin/config/media/image-styles/delete/%','Delete style','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:22:\"Delete an image style.\";}}','system',0,0,0,0,0,5,0,1,8,46,104,180,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',181,104,'admin/config/media/image-styles/revert/%','admin/config/media/image-styles/revert/%','Revert style','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:22:\"Revert an image style.\";}}','system',0,0,0,0,0,5,0,1,8,46,104,181,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',182,138,'admin/structure/types/manage/%/comment/display','admin/structure/types/manage/%/comment/display','Comment display','a:0:{}','system',-1,0,0,0,4,5,0,1,21,36,138,182,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',183,138,'admin/structure/types/manage/%/comment/fields','admin/structure/types/manage/%/comment/fields','Comment fields','a:0:{}','system',-1,0,1,0,3,5,0,1,21,36,138,183,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',184,164,'admin/structure/block/manage/%/%/configure','admin/structure/block/manage/%/%/configure','Configure block','a:0:{}','system',-1,0,0,0,0,5,0,1,21,30,164,184,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',185,164,'admin/structure/block/manage/%/%/delete','admin/structure/block/manage/%/%/delete','Delete block','a:0:{}','system',-1,0,0,0,0,5,0,1,21,30,164,185,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',186,139,'admin/config/regional/date-time/formats/%/delete','admin/config/regional/date-time/formats/%/delete','Delete date format','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:47:\"Allow users to delete a configured date format.\";}}','system',0,0,0,0,0,6,0,1,8,51,98,139,186,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',187,149,'admin/config/regional/date-time/types/%/delete','admin/config/regional/date-time/types/%/delete','Delete date type','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:45:\"Allow users to delete a configured date type.\";}}','system',0,0,0,0,0,6,0,1,8,51,98,149,187,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',188,139,'admin/config/regional/date-time/formats/%/edit','admin/config/regional/date-time/formats/%/edit','Edit date format','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:45:\"Allow users to edit a configured date format.\";}}','system',0,0,0,0,0,6,0,1,8,51,98,139,188,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',189,177,'admin/config/media/image-styles/edit/%/add/%','admin/config/media/image-styles/edit/%/add/%','Add image effect','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:28:\"Add a new effect to a style.\";}}','system',0,0,0,0,0,6,0,1,8,46,104,177,189,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',190,177,'admin/config/media/image-styles/edit/%/effects/%','admin/config/media/image-styles/edit/%/effects/%','Edit image effect','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:39:\"Edit an existing effect within a style.\";}}','system',0,0,1,0,0,6,0,1,8,46,104,177,190,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',191,190,'admin/config/media/image-styles/edit/%/effects/%/delete','admin/config/media/image-styles/edit/%/effects/%/delete','Delete image effect','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:39:\"Delete an existing effect from a style.\";}}','system',0,0,0,0,0,7,0,1,8,46,104,177,190,191,0,0,0);
INSERT INTO `menu_links` VALUES ('management',192,47,'admin/structure/menu/manage/main-menu','admin/structure/menu/manage/%','Main menu','a:0:{}','menu',0,0,0,0,0,4,0,1,21,47,192,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',193,47,'admin/structure/menu/manage/management','admin/structure/menu/manage/%','Management','a:0:{}','menu',0,0,0,0,0,4,0,1,21,47,193,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',194,47,'admin/structure/menu/manage/navigation','admin/structure/menu/manage/%','Navigation','a:0:{}','menu',0,0,0,0,0,4,0,1,21,47,194,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',195,47,'admin/structure/menu/manage/user-menu','admin/structure/menu/manage/%','User menu','a:0:{}','menu',0,0,0,0,0,4,0,1,21,47,195,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',196,0,'search','search','Search','a:0:{}','system',1,0,0,0,0,1,0,196,0,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',197,196,'search/node','search/node','Content','a:0:{}','system',-1,0,0,0,-10,2,0,196,197,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',198,196,'search/user','search/user','Users','a:0:{}','system',-1,0,0,0,0,2,0,196,198,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',199,197,'search/node/%','search/node/%','Content','a:0:{}','system',-1,0,0,0,0,3,0,196,197,199,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',200,17,'user/%/shortcuts','user/%/shortcuts','Shortcuts','a:0:{}','system',-1,0,0,0,0,2,0,17,200,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',201,19,'admin/reports/search','admin/reports/search','Top search phrases','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:33:\"View most popular search phrases.\";}}','system',0,0,0,0,0,3,0,1,19,201,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',202,198,'search/user/%','search/user/%','Users','a:0:{}','system',-1,0,0,0,0,3,0,196,198,202,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',203,12,'admin/help/number','admin/help/number','number','a:0:{}','system',-1,0,0,0,0,3,0,1,12,203,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',204,12,'admin/help/overlay','admin/help/overlay','overlay','a:0:{}','system',-1,0,0,0,0,3,0,1,12,204,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',205,12,'admin/help/path','admin/help/path','path','a:0:{}','system',-1,0,0,0,0,3,0,1,12,205,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',206,12,'admin/help/rdf','admin/help/rdf','rdf','a:0:{}','system',-1,0,0,0,0,3,0,1,12,206,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',207,12,'admin/help/search','admin/help/search','search','a:0:{}','system',-1,0,0,0,0,3,0,1,12,207,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',208,12,'admin/help/shortcut','admin/help/shortcut','shortcut','a:0:{}','system',-1,0,0,0,0,3,0,1,12,208,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',209,53,'admin/config/search/settings','admin/config/search/settings','Search settings','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:67:\"Configure relevance settings for search and other indexing options.\";}}','system',0,0,0,0,-10,4,0,1,8,53,209,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',210,61,'admin/config/user-interface/shortcut','admin/config/user-interface/shortcut','Shortcuts','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:29:\"Add and modify shortcut sets.\";}}','system',0,0,1,0,0,4,0,1,8,61,210,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',211,53,'admin/config/search/path','admin/config/search/path','URL aliases','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:46:\"Change your site\'s URL paths by aliasing them.\";}}','system',0,0,1,0,-5,4,0,1,8,53,211,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',212,211,'admin/config/search/path/add','admin/config/search/path/add','Add alias','a:0:{}','system',-1,0,0,0,0,5,0,1,8,53,211,212,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',213,210,'admin/config/user-interface/shortcut/add-set','admin/config/user-interface/shortcut/add-set','Add shortcut set','a:0:{}','system',-1,0,0,0,0,5,0,1,8,61,210,213,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',214,209,'admin/config/search/settings/reindex','admin/config/search/settings/reindex','Clear index','a:0:{}','system',-1,0,0,0,0,5,0,1,8,53,209,214,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',215,210,'admin/config/user-interface/shortcut/%','admin/config/user-interface/shortcut/%','Edit shortcuts','a:0:{}','system',0,0,1,0,0,5,0,1,8,61,210,215,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',216,211,'admin/config/search/path/list','admin/config/search/path/list','List','a:0:{}','system',-1,0,0,0,-10,5,0,1,8,53,211,216,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',217,215,'admin/config/user-interface/shortcut/%/add-link','admin/config/user-interface/shortcut/%/add-link','Add shortcut','a:0:{}','system',-1,0,0,0,0,6,0,1,8,61,210,215,217,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',218,211,'admin/config/search/path/delete/%','admin/config/search/path/delete/%','Delete alias','a:0:{}','system',0,0,0,0,0,5,0,1,8,53,211,218,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',219,215,'admin/config/user-interface/shortcut/%/delete','admin/config/user-interface/shortcut/%/delete','Delete shortcut set','a:0:{}','system',0,0,0,0,0,6,0,1,8,61,210,215,219,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',220,211,'admin/config/search/path/edit/%','admin/config/search/path/edit/%','Edit alias','a:0:{}','system',0,0,0,0,0,5,0,1,8,53,211,220,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',221,215,'admin/config/user-interface/shortcut/%/edit','admin/config/user-interface/shortcut/%/edit','Edit set name','a:0:{}','system',-1,0,0,0,10,6,0,1,8,61,210,215,221,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',222,210,'admin/config/user-interface/shortcut/link/%','admin/config/user-interface/shortcut/link/%','Edit shortcut','a:0:{}','system',0,0,1,0,0,5,0,1,8,61,210,222,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',223,215,'admin/config/user-interface/shortcut/%/links','admin/config/user-interface/shortcut/%/links','List links','a:0:{}','system',-1,0,0,0,0,6,0,1,8,61,210,215,223,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',224,222,'admin/config/user-interface/shortcut/link/%/delete','admin/config/user-interface/shortcut/link/%/delete','Delete shortcut','a:0:{}','system',0,0,0,0,0,6,0,1,8,61,210,222,224,0,0,0,0);
INSERT INTO `menu_links` VALUES ('shortcut-set-1',225,0,'node/add','node/add','Add content','a:0:{}','menu',0,0,0,0,-20,1,0,225,0,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('shortcut-set-1',226,0,'admin/content','admin/content','Find content','a:0:{}','menu',0,0,0,0,-19,1,0,226,0,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('main-menu',227,0,'<front>','','Home','a:0:{}','menu',0,1,0,0,0,1,0,227,0,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',228,6,'node/add/article','node/add/article','Article','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:89:\"Use <em>articles</em> for time-sensitive content like news, press releases or blog posts.\";}}','system',0,0,0,0,0,2,0,6,228,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',229,6,'node/add/page','node/add/page','Basic page','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:77:\"Use <em>basic pages</em> for your static content, such as an \'About us\' page.\";}}','system',0,0,0,0,0,2,0,6,229,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',230,12,'admin/help/toolbar','admin/help/toolbar','toolbar','a:0:{}','system',-1,0,0,0,0,3,0,1,12,230,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',231,127,'admin/structure/taxonomy/%/display','admin/structure/taxonomy/%/display','Manage display','a:0:{}','system',-1,0,0,0,2,5,0,1,21,57,127,231,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',232,89,'admin/config/people/accounts/display','admin/config/people/accounts/display','Manage display','a:0:{}','system',-1,0,0,0,2,5,0,1,8,48,89,232,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',233,127,'admin/structure/taxonomy/%/fields','admin/structure/taxonomy/%/fields','Manage fields','a:0:{}','system',-1,0,1,0,1,5,0,1,21,57,127,233,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',234,89,'admin/config/people/accounts/fields','admin/config/people/accounts/fields','Manage fields','a:0:{}','system',-1,0,1,0,1,5,0,1,8,48,89,234,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',235,231,'admin/structure/taxonomy/%/display/default','admin/structure/taxonomy/%/display/default','Default','a:0:{}','system',-1,0,0,0,-10,6,0,1,21,57,127,231,235,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',236,232,'admin/config/people/accounts/display/default','admin/config/people/accounts/display/default','Default','a:0:{}','system',-1,0,0,0,-10,6,0,1,8,48,89,232,236,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',237,138,'admin/structure/types/manage/%/display','admin/structure/types/manage/%/display','Manage display','a:0:{}','system',-1,0,0,0,2,5,0,1,21,36,138,237,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',238,138,'admin/structure/types/manage/%/fields','admin/structure/types/manage/%/fields','Manage fields','a:0:{}','system',-1,0,1,0,1,5,0,1,21,36,138,238,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',239,231,'admin/structure/taxonomy/%/display/full','admin/structure/taxonomy/%/display/full','Taxonomy term page','a:0:{}','system',-1,0,0,0,0,6,0,1,21,57,127,231,239,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',240,232,'admin/config/people/accounts/display/full','admin/config/people/accounts/display/full','User account','a:0:{}','system',-1,0,0,0,0,6,0,1,8,48,89,232,240,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',241,233,'admin/structure/taxonomy/%/fields/%','admin/structure/taxonomy/%/fields/%','','a:0:{}','system',0,0,0,0,0,6,0,1,21,57,127,233,241,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',242,234,'admin/config/people/accounts/fields/%','admin/config/people/accounts/fields/%','','a:0:{}','system',0,0,0,0,0,6,0,1,8,48,89,234,242,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',243,237,'admin/structure/types/manage/%/display/default','admin/structure/types/manage/%/display/default','Default','a:0:{}','system',-1,0,0,0,-10,6,0,1,21,36,138,237,243,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',244,237,'admin/structure/types/manage/%/display/full','admin/structure/types/manage/%/display/full','Full content','a:0:{}','system',-1,0,0,0,0,6,0,1,21,36,138,237,244,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',245,237,'admin/structure/types/manage/%/display/rss','admin/structure/types/manage/%/display/rss','RSS','a:0:{}','system',-1,0,0,0,2,6,0,1,21,36,138,237,245,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',246,237,'admin/structure/types/manage/%/display/search_index','admin/structure/types/manage/%/display/search_index','Search index','a:0:{}','system',-1,0,0,0,3,6,0,1,21,36,138,237,246,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',247,237,'admin/structure/types/manage/%/display/search_result','admin/structure/types/manage/%/display/search_result','Search result','a:0:{}','system',-1,0,0,0,4,6,0,1,21,36,138,237,247,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',248,237,'admin/structure/types/manage/%/display/teaser','admin/structure/types/manage/%/display/teaser','Teaser','a:0:{}','system',-1,0,0,0,1,6,0,1,21,36,138,237,248,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',249,238,'admin/structure/types/manage/%/fields/%','admin/structure/types/manage/%/fields/%','','a:0:{}','system',0,0,0,0,0,6,0,1,21,36,138,238,249,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',250,241,'admin/structure/taxonomy/%/fields/%/delete','admin/structure/taxonomy/%/fields/%/delete','Delete','a:0:{}','system',-1,0,0,0,10,7,0,1,21,57,127,233,241,250,0,0,0);
INSERT INTO `menu_links` VALUES ('management',251,241,'admin/structure/taxonomy/%/fields/%/edit','admin/structure/taxonomy/%/fields/%/edit','Edit','a:0:{}','system',-1,0,0,0,0,7,0,1,21,57,127,233,241,251,0,0,0);
INSERT INTO `menu_links` VALUES ('management',252,241,'admin/structure/taxonomy/%/fields/%/field-settings','admin/structure/taxonomy/%/fields/%/field-settings','Field settings','a:0:{}','system',-1,0,0,0,0,7,0,1,21,57,127,233,241,252,0,0,0);
INSERT INTO `menu_links` VALUES ('management',253,241,'admin/structure/taxonomy/%/fields/%/widget-type','admin/structure/taxonomy/%/fields/%/widget-type','Widget type','a:0:{}','system',-1,0,0,0,0,7,0,1,21,57,127,233,241,253,0,0,0);
INSERT INTO `menu_links` VALUES ('management',254,242,'admin/config/people/accounts/fields/%/delete','admin/config/people/accounts/fields/%/delete','Delete','a:0:{}','system',-1,0,0,0,10,7,0,1,8,48,89,234,242,254,0,0,0);
INSERT INTO `menu_links` VALUES ('management',255,242,'admin/config/people/accounts/fields/%/edit','admin/config/people/accounts/fields/%/edit','Edit','a:0:{}','system',-1,0,0,0,0,7,0,1,8,48,89,234,242,255,0,0,0);
INSERT INTO `menu_links` VALUES ('management',256,242,'admin/config/people/accounts/fields/%/field-settings','admin/config/people/accounts/fields/%/field-settings','Field settings','a:0:{}','system',-1,0,0,0,0,7,0,1,8,48,89,234,242,256,0,0,0);
INSERT INTO `menu_links` VALUES ('management',257,242,'admin/config/people/accounts/fields/%/widget-type','admin/config/people/accounts/fields/%/widget-type','Widget type','a:0:{}','system',-1,0,0,0,0,7,0,1,8,48,89,234,242,257,0,0,0);
INSERT INTO `menu_links` VALUES ('management',258,182,'admin/structure/types/manage/%/comment/display/default','admin/structure/types/manage/%/comment/display/default','Default','a:0:{}','system',-1,0,0,0,-10,6,0,1,21,36,138,182,258,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',259,182,'admin/structure/types/manage/%/comment/display/full','admin/structure/types/manage/%/comment/display/full','Full comment','a:0:{}','system',-1,0,0,0,0,6,0,1,21,36,138,182,259,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',260,183,'admin/structure/types/manage/%/comment/fields/%','admin/structure/types/manage/%/comment/fields/%','','a:0:{}','system',0,0,0,0,0,6,0,1,21,36,138,183,260,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',261,249,'admin/structure/types/manage/%/fields/%/delete','admin/structure/types/manage/%/fields/%/delete','Delete','a:0:{}','system',-1,0,0,0,10,7,0,1,21,36,138,238,249,261,0,0,0);
INSERT INTO `menu_links` VALUES ('management',262,249,'admin/structure/types/manage/%/fields/%/edit','admin/structure/types/manage/%/fields/%/edit','Edit','a:0:{}','system',-1,0,0,0,0,7,0,1,21,36,138,238,249,262,0,0,0);
INSERT INTO `menu_links` VALUES ('management',263,249,'admin/structure/types/manage/%/fields/%/field-settings','admin/structure/types/manage/%/fields/%/field-settings','Field settings','a:0:{}','system',-1,0,0,0,0,7,0,1,21,36,138,238,249,263,0,0,0);
INSERT INTO `menu_links` VALUES ('management',264,249,'admin/structure/types/manage/%/fields/%/widget-type','admin/structure/types/manage/%/fields/%/widget-type','Widget type','a:0:{}','system',-1,0,0,0,0,7,0,1,21,36,138,238,249,264,0,0,0);
INSERT INTO `menu_links` VALUES ('management',265,260,'admin/structure/types/manage/%/comment/fields/%/delete','admin/structure/types/manage/%/comment/fields/%/delete','Delete','a:0:{}','system',-1,0,0,0,10,7,0,1,21,36,138,183,260,265,0,0,0);
INSERT INTO `menu_links` VALUES ('management',266,260,'admin/structure/types/manage/%/comment/fields/%/edit','admin/structure/types/manage/%/comment/fields/%/edit','Edit','a:0:{}','system',-1,0,0,0,0,7,0,1,21,36,138,183,260,266,0,0,0);
INSERT INTO `menu_links` VALUES ('management',267,260,'admin/structure/types/manage/%/comment/fields/%/field-settings','admin/structure/types/manage/%/comment/fields/%/field-settings','Field settings','a:0:{}','system',-1,0,0,0,0,7,0,1,21,36,138,183,260,267,0,0,0);
INSERT INTO `menu_links` VALUES ('management',268,260,'admin/structure/types/manage/%/comment/fields/%/widget-type','admin/structure/types/manage/%/comment/fields/%/widget-type','Widget type','a:0:{}','system',-1,0,0,0,0,7,0,1,21,36,138,183,260,268,0,0,0);
/*!40000 ALTER TABLE `menu_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_router`
--

DROP TABLE IF EXISTS `menu_router`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu_router` (
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: the Drupal path this entry describes',
  `load_functions` blob NOT NULL COMMENT 'A serialized array of function names (like node_load) to be called to load an object corresponding to a part of the current path.',
  `to_arg_functions` blob NOT NULL COMMENT 'A serialized array of function names (like user_uid_optional_to_arg) to be called to replace a part of the router path with another string.',
  `access_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The callback which determines the access to this router path. Defaults to user_access.',
  `access_arguments` blob COMMENT 'A serialized array of arguments for the access callback.',
  `page_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the function that renders the page.',
  `page_arguments` blob COMMENT 'A serialized array of arguments for the page callback.',
  `delivery_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the function that sends the result of the page_callback function to the browser.',
  `fit` int(11) NOT NULL DEFAULT '0' COMMENT 'A numeric representation of how specific the path is.',
  `number_parts` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Number of parts in this router path.',
  `context` int(11) NOT NULL DEFAULT '0' COMMENT 'Only for local tasks (tabs) - the context of a local task to control its placement.',
  `tab_parent` varchar(255) NOT NULL DEFAULT '' COMMENT 'Only for local tasks (tabs) - the router path of the parent page (which may also be a local task).',
  `tab_root` varchar(255) NOT NULL DEFAULT '' COMMENT 'Router path of the closest non-tab parent page. For pages that are not local tasks, this will be the same as the path.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title for the current page, or the title for the tab if this is a local task.',
  `title_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'A function which will alter the title. Defaults to t()',
  `title_arguments` varchar(255) NOT NULL DEFAULT '' COMMENT 'A serialized array of arguments for the title callback. If empty, the title will be used as the sole argument for the title callback.',
  `theme_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'A function which returns the name of the theme that will be used to render this page. If left empty, the default theme will be used.',
  `theme_arguments` varchar(255) NOT NULL DEFAULT '' COMMENT 'A serialized array of arguments for the theme callback.',
  `type` int(11) NOT NULL DEFAULT '0' COMMENT 'Numeric representation of the type of the menu item, like MENU_LOCAL_TASK.',
  `description` text NOT NULL COMMENT 'A description of this item.',
  `position` varchar(255) NOT NULL DEFAULT '' COMMENT 'The position of the block (left or right) on the system administration page for this item.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Weight of the element. Lighter weights are higher up, heavier weights go down.',
  `include_file` mediumtext COMMENT 'The file to include for this element, usually the page callback function lives in this file.',
  PRIMARY KEY (`path`),
  KEY `fit` (`fit`),
  KEY `tab_parent` (`tab_parent`(64),`weight`,`title`),
  KEY `tab_root_weight_title` (`tab_root`(64),`weight`,`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maps paths to various callbacks (access, page and title)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_router`
--

LOCK TABLES `menu_router` WRITE;
/*!40000 ALTER TABLE `menu_router` DISABLE KEYS */;
INSERT INTO `menu_router` VALUES ('admin','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_menu_block_page','a:0:{}','',1,1,0,'','admin','Administration','t','','','a:0:{}',6,'','',9,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/appearance','','','user_access','a:1:{i:0;s:17:\"administer themes\";}','system_themes_page','a:0:{}','',3,2,0,'','admin/appearance','Appearance','t','','','a:0:{}',6,'Select and configure your themes.','left',-6,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/appearance/default','','','user_access','a:1:{i:0;s:17:\"administer themes\";}','system_theme_default','a:0:{}','',7,3,0,'','admin/appearance/default','Set default theme','t','','','a:0:{}',0,'','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/appearance/disable','','','user_access','a:1:{i:0;s:17:\"administer themes\";}','system_theme_disable','a:0:{}','',7,3,0,'','admin/appearance/disable','Disable theme','t','','','a:0:{}',0,'','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/appearance/enable','','','user_access','a:1:{i:0;s:17:\"administer themes\";}','system_theme_enable','a:0:{}','',7,3,0,'','admin/appearance/enable','Enable theme','t','','','a:0:{}',0,'','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/appearance/list','','','user_access','a:1:{i:0;s:17:\"administer themes\";}','system_themes_page','a:0:{}','',7,3,1,'admin/appearance','admin/appearance','List','t','','','a:0:{}',140,'Select and configure your theme','',-1,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/appearance/settings','','','user_access','a:1:{i:0;s:17:\"administer themes\";}','drupal_get_form','a:1:{i:0;s:21:\"system_theme_settings\";}','',7,3,1,'admin/appearance','admin/appearance','Settings','t','','','a:0:{}',132,'Configure default and theme specific settings.','',20,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/appearance/settings/bartik','','','_system_themes_access','a:1:{i:0;O:8:\"stdClass\":11:{s:8:\"filename\";s:25:\"themes/bartik/bartik.info\";s:4:\"name\";s:6:\"bartik\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:18:{s:4:\"name\";s:6:\"Bartik\";s:11:\"description\";s:48:\"A flexible, recolorable theme with many regions.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:3:{s:14:\"css/layout.css\";s:28:\"themes/bartik/css/layout.css\";s:13:\"css/style.css\";s:27:\"themes/bartik/css/style.css\";s:14:\"css/colors.css\";s:28:\"themes/bartik/css/colors.css\";}s:5:\"print\";a:1:{s:13:\"css/print.css\";s:27:\"themes/bartik/css/print.css\";}}s:7:\"regions\";a:20:{s:6:\"header\";s:6:\"Header\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:11:\"highlighted\";s:11:\"Highlighted\";s:8:\"featured\";s:8:\"Featured\";s:7:\"content\";s:7:\"Content\";s:13:\"sidebar_first\";s:13:\"Sidebar first\";s:14:\"sidebar_second\";s:14:\"Sidebar second\";s:14:\"triptych_first\";s:14:\"Triptych first\";s:15:\"triptych_middle\";s:15:\"Triptych middle\";s:13:\"triptych_last\";s:13:\"Triptych last\";s:18:\"footer_firstcolumn\";s:19:\"Footer first column\";s:19:\"footer_secondcolumn\";s:20:\"Footer second column\";s:18:\"footer_thirdcolumn\";s:19:\"Footer third column\";s:19:\"footer_fourthcolumn\";s:20:\"Footer fourth column\";s:6:\"footer\";s:6:\"Footer\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"settings\";a:1:{s:20:\"shortcut_module_link\";s:1:\"0\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:6:\"engine\";s:11:\"phptemplate\";s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:28:\"themes/bartik/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:11:\"stylesheets\";a:2:{s:3:\"all\";a:3:{s:14:\"css/layout.css\";s:28:\"themes/bartik/css/layout.css\";s:13:\"css/style.css\";s:27:\"themes/bartik/css/style.css\";s:14:\"css/colors.css\";s:28:\"themes/bartik/css/colors.css\";}s:5:\"print\";a:1:{s:13:\"css/print.css\";s:27:\"themes/bartik/css/print.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}','drupal_get_form','a:2:{i:0;s:21:\"system_theme_settings\";i:1;s:6:\"bartik\";}','',15,4,1,'admin/appearance/settings','admin/appearance','Bartik','t','','','a:0:{}',132,'','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/appearance/settings/garland','','','_system_themes_access','a:1:{i:0;O:8:\"stdClass\":11:{s:8:\"filename\";s:27:\"themes/garland/garland.info\";s:4:\"name\";s:7:\"garland\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"0\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:18:{s:4:\"name\";s:7:\"Garland\";s:11:\"description\";s:111:\"A multi-column theme which can be configured to modify colors and switch between fixed and fluid width layouts.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:1:{s:9:\"style.css\";s:24:\"themes/garland/style.css\";}s:5:\"print\";a:1:{s:9:\"print.css\";s:24:\"themes/garland/print.css\";}}s:8:\"settings\";a:1:{s:13:\"garland_width\";s:5:\"fluid\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:29:\"themes/garland/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:11:\"stylesheets\";a:2:{s:3:\"all\";a:1:{s:9:\"style.css\";s:24:\"themes/garland/style.css\";}s:5:\"print\";a:1:{s:9:\"print.css\";s:24:\"themes/garland/print.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}','drupal_get_form','a:2:{i:0;s:21:\"system_theme_settings\";i:1;s:7:\"garland\";}','',15,4,1,'admin/appearance/settings','admin/appearance','Garland','t','','','a:0:{}',132,'','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/appearance/settings/global','','','user_access','a:1:{i:0;s:17:\"administer themes\";}','drupal_get_form','a:1:{i:0;s:21:\"system_theme_settings\";}','',15,4,1,'admin/appearance/settings','admin/appearance','Global settings','t','','','a:0:{}',140,'','',-1,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/appearance/settings/seven','','','_system_themes_access','a:1:{i:0;O:8:\"stdClass\":11:{s:8:\"filename\";s:23:\"themes/seven/seven.info\";s:4:\"name\";s:5:\"seven\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:18:{s:4:\"name\";s:5:\"Seven\";s:11:\"description\";s:65:\"A simple one-column, tableless, fluid width administration theme.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:1:{s:6:\"screen\";a:2:{s:9:\"reset.css\";s:22:\"themes/seven/reset.css\";s:9:\"style.css\";s:22:\"themes/seven/style.css\";}}s:8:\"settings\";a:1:{s:20:\"shortcut_module_link\";s:1:\"1\";}s:7:\"regions\";a:8:{s:7:\"content\";s:7:\"Content\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:13:\"sidebar_first\";s:13:\"First sidebar\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:14:\"regions_hidden\";a:3:{i:0;s:13:\"sidebar_first\";i:1;s:8:\"page_top\";i:2;s:11:\"page_bottom\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:6:\"engine\";s:11:\"phptemplate\";s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:27:\"themes/seven/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:11:\"stylesheets\";a:1:{s:6:\"screen\";a:2:{s:9:\"reset.css\";s:22:\"themes/seven/reset.css\";s:9:\"style.css\";s:22:\"themes/seven/style.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}','drupal_get_form','a:2:{i:0;s:21:\"system_theme_settings\";i:1;s:5:\"seven\";}','',15,4,1,'admin/appearance/settings','admin/appearance','Seven','t','','','a:0:{}',132,'','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/appearance/settings/stark','','','_system_themes_access','a:1:{i:0;O:8:\"stdClass\":11:{s:8:\"filename\";s:23:\"themes/stark/stark.info\";s:4:\"name\";s:5:\"stark\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"0\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:17:{s:4:\"name\";s:5:\"Stark\";s:11:\"description\";s:208:\"This theme demonstrates Drupal\'s default HTML markup and CSS styles. To learn how to build your own theme and override Drupal\'s default code, see the <a href=\"http://drupal.org/theme-guide\">Theming Guide</a>.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:10:\"layout.css\";s:23:\"themes/stark/layout.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:27:\"themes/stark/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:10:\"layout.css\";s:23:\"themes/stark/layout.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}','drupal_get_form','a:2:{i:0;s:21:\"system_theme_settings\";i:1;s:5:\"stark\";}','',15,4,1,'admin/appearance/settings','admin/appearance','Stark','t','','','a:0:{}',132,'','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/appearance/settings/test_theme','','','_system_themes_access','a:1:{i:0;O:8:\"stdClass\":11:{s:8:\"filename\";s:39:\"themes/tests/test_theme/test_theme.info\";s:4:\"name\";s:10:\"test_theme\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"0\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:17:{s:4:\"name\";s:10:\"Test theme\";s:11:\"description\";s:34:\"Theme for testing the theme system\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:15:\"system.base.css\";s:39:\"themes/tests/test_theme/system.base.css\";}}s:7:\"version\";s:3:\"7.8\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:38:\"themes/tests/test_theme/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:15:\"system.base.css\";s:39:\"themes/tests/test_theme/system.base.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}','drupal_get_form','a:2:{i:0;s:21:\"system_theme_settings\";i:1;s:10:\"test_theme\";}','',15,4,1,'admin/appearance/settings','admin/appearance','Test theme','t','','','a:0:{}',132,'','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/appearance/settings/update_test_basetheme','','','_system_themes_access','a:1:{i:0;O:8:\"stdClass\":10:{s:8:\"filename\";s:61:\"themes/tests/update_test_basetheme/update_test_basetheme.info\";s:4:\"name\";s:21:\"update_test_basetheme\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"0\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:17:{s:4:\"name\";s:22:\"Update test base theme\";s:11:\"description\";s:63:\"Test theme which acts as a base theme for other test subthemes.\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"version\";s:3:\"7.8\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:49:\"themes/tests/update_test_basetheme/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:11:\"stylesheets\";a:0:{}s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:6:\"engine\";s:11:\"phptemplate\";}}','drupal_get_form','a:2:{i:0;s:21:\"system_theme_settings\";i:1;s:21:\"update_test_basetheme\";}','',15,4,1,'admin/appearance/settings','admin/appearance','Update test base theme','t','','','a:0:{}',132,'','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/appearance/settings/update_test_subtheme','','','_system_themes_access','a:1:{i:0;O:8:\"stdClass\":11:{s:8:\"filename\";s:59:\"themes/tests/update_test_subtheme/update_test_subtheme.info\";s:4:\"name\";s:20:\"update_test_subtheme\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"0\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:18:{s:4:\"name\";s:20:\"Update test subtheme\";s:11:\"description\";s:62:\"Test theme which uses update_test_basetheme as the base theme.\";s:4:\"core\";s:3:\"7.x\";s:10:\"base theme\";s:21:\"update_test_basetheme\";s:6:\"hidden\";b:1;s:7:\"version\";s:3:\"7.8\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:48:\"themes/tests/update_test_subtheme/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:11:\"stylesheets\";a:0:{}s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:6:\"engine\";s:11:\"phptemplate\";s:10:\"base_theme\";s:21:\"update_test_basetheme\";}}','drupal_get_form','a:2:{i:0;s:21:\"system_theme_settings\";i:1;s:20:\"update_test_subtheme\";}','',15,4,1,'admin/appearance/settings','admin/appearance','Update test subtheme','t','','','a:0:{}',132,'','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/compact','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_compact_page','a:0:{}','',3,2,0,'','admin/compact','Compact mode','t','','','a:0:{}',0,'','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_config_page','a:0:{}','',3,2,0,'','admin/config','Configuration','t','','','a:0:{}',6,'Administer settings.','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/content','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_menu_block_page','a:0:{}','',7,3,0,'','admin/config/content','Content authoring','t','','','a:0:{}',6,'Settings related to formatting and authoring content.','left',-15,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/content/formats','','','user_access','a:1:{i:0;s:18:\"administer filters\";}','drupal_get_form','a:1:{i:0;s:21:\"filter_admin_overview\";}','',15,4,0,'','admin/config/content/formats','Text formats','t','','','a:0:{}',6,'Configure how content input by users is filtered, including allowed HTML tags. Also allows enabling of module-provided filters.','',0,'modules/filter/filter.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/content/formats/%','a:1:{i:4;s:18:\"filter_format_load\";}','','user_access','a:1:{i:0;s:18:\"administer filters\";}','filter_admin_format_page','a:1:{i:0;i:4;}','',30,5,0,'','admin/config/content/formats/%','','filter_admin_format_title','a:1:{i:0;i:4;}','','a:0:{}',6,'','',0,'modules/filter/filter.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/content/formats/%/disable','a:1:{i:4;s:18:\"filter_format_load\";}','','_filter_disable_format_access','a:1:{i:0;i:4;}','drupal_get_form','a:2:{i:0;s:20:\"filter_admin_disable\";i:1;i:4;}','',61,6,0,'','admin/config/content/formats/%/disable','Disable text format','t','','','a:0:{}',6,'','',0,'modules/filter/filter.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/content/formats/add','','','user_access','a:1:{i:0;s:18:\"administer filters\";}','filter_admin_format_page','a:0:{}','',31,5,1,'admin/config/content/formats','admin/config/content/formats','Add text format','t','','','a:0:{}',388,'','',1,'modules/filter/filter.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/content/formats/list','','','user_access','a:1:{i:0;s:18:\"administer filters\";}','drupal_get_form','a:1:{i:0;s:21:\"filter_admin_overview\";}','',31,5,1,'admin/config/content/formats','admin/config/content/formats','List','t','','','a:0:{}',140,'','',0,'modules/filter/filter.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/development','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_menu_block_page','a:0:{}','',7,3,0,'','admin/config/development','Development','t','','','a:0:{}',6,'Development tools.','right',-10,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/development/logging','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:1:{i:0;s:23:\"system_logging_settings\";}','',15,4,0,'','admin/config/development/logging','Logging and errors','t','','','a:0:{}',6,'Settings for logging and alerts modules. Various modules can route Drupal\'s system events to different destinations, such as syslog, database, email, etc.','',-15,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/development/maintenance','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:1:{i:0;s:28:\"system_site_maintenance_mode\";}','',15,4,0,'','admin/config/development/maintenance','Maintenance mode','t','','','a:0:{}',6,'Take the site offline for maintenance or bring it back online.','',-10,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/development/performance','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:1:{i:0;s:27:\"system_performance_settings\";}','',15,4,0,'','admin/config/development/performance','Performance','t','','','a:0:{}',6,'Enable or disable page caching for anonymous users and set CSS and JS bandwidth optimization options.','',-20,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/media','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_menu_block_page','a:0:{}','',7,3,0,'','admin/config/media','Media','t','','','a:0:{}',6,'Media tools.','left',-10,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/media/file-system','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:1:{i:0;s:27:\"system_file_system_settings\";}','',15,4,0,'','admin/config/media/file-system','File system','t','','','a:0:{}',6,'Tell Drupal where to store uploaded files and how they are accessed.','',-10,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/media/image-styles','','','user_access','a:1:{i:0;s:23:\"administer image styles\";}','image_style_list','a:0:{}','',15,4,0,'','admin/config/media/image-styles','Image styles','t','','','a:0:{}',6,'Configure styles that can be used for resizing or adjusting images on display.','',0,'modules/image/image.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/media/image-styles/add','','','user_access','a:1:{i:0;s:23:\"administer image styles\";}','drupal_get_form','a:1:{i:0;s:20:\"image_style_add_form\";}','',31,5,1,'admin/config/media/image-styles','admin/config/media/image-styles','Add style','t','','','a:0:{}',388,'Add a new image style.','',2,'modules/image/image.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/media/image-styles/delete/%','a:1:{i:5;a:1:{s:16:\"image_style_load\";a:2:{i:0;N;i:1;s:1:\"1\";}}}','','user_access','a:1:{i:0;s:23:\"administer image styles\";}','drupal_get_form','a:2:{i:0;s:23:\"image_style_delete_form\";i:1;i:5;}','',62,6,0,'','admin/config/media/image-styles/delete/%','Delete style','t','','','a:0:{}',6,'Delete an image style.','',0,'modules/image/image.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/media/image-styles/edit/%','a:1:{i:5;s:16:\"image_style_load\";}','','user_access','a:1:{i:0;s:23:\"administer image styles\";}','drupal_get_form','a:2:{i:0;s:16:\"image_style_form\";i:1;i:5;}','',62,6,0,'','admin/config/media/image-styles/edit/%','Edit style','t','','','a:0:{}',6,'Configure an image style.','',0,'modules/image/image.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/media/image-styles/edit/%/add/%','a:2:{i:5;a:1:{s:16:\"image_style_load\";a:1:{i:0;i:5;}}i:7;a:1:{s:28:\"image_effect_definition_load\";a:1:{i:0;i:5;}}}','','user_access','a:1:{i:0;s:23:\"administer image styles\";}','drupal_get_form','a:3:{i:0;s:17:\"image_effect_form\";i:1;i:5;i:2;i:7;}','',250,8,0,'','admin/config/media/image-styles/edit/%/add/%','Add image effect','t','','','a:0:{}',6,'Add a new effect to a style.','',0,'modules/image/image.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/media/image-styles/edit/%/effects/%','a:2:{i:5;a:1:{s:16:\"image_style_load\";a:2:{i:0;i:5;i:1;s:1:\"3\";}}i:7;a:1:{s:17:\"image_effect_load\";a:2:{i:0;i:5;i:1;s:1:\"3\";}}}','','user_access','a:1:{i:0;s:23:\"administer image styles\";}','drupal_get_form','a:3:{i:0;s:17:\"image_effect_form\";i:1;i:5;i:2;i:7;}','',250,8,0,'','admin/config/media/image-styles/edit/%/effects/%','Edit image effect','t','','','a:0:{}',6,'Edit an existing effect within a style.','',0,'modules/image/image.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/media/image-styles/edit/%/effects/%/delete','a:2:{i:5;a:1:{s:16:\"image_style_load\";a:2:{i:0;i:5;i:1;s:1:\"3\";}}i:7;a:1:{s:17:\"image_effect_load\";a:2:{i:0;i:5;i:1;s:1:\"3\";}}}','','user_access','a:1:{i:0;s:23:\"administer image styles\";}','drupal_get_form','a:3:{i:0;s:24:\"image_effect_delete_form\";i:1;i:5;i:2;i:7;}','',501,9,0,'','admin/config/media/image-styles/edit/%/effects/%/delete','Delete image effect','t','','','a:0:{}',6,'Delete an existing effect from a style.','',0,'modules/image/image.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/media/image-styles/list','','','user_access','a:1:{i:0;s:23:\"administer image styles\";}','image_style_list','a:0:{}','',31,5,1,'admin/config/media/image-styles','admin/config/media/image-styles','List','t','','','a:0:{}',140,'List the current image styles on the site.','',1,'modules/image/image.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/media/image-styles/revert/%','a:1:{i:5;a:1:{s:16:\"image_style_load\";a:2:{i:0;N;i:1;s:1:\"2\";}}}','','user_access','a:1:{i:0;s:23:\"administer image styles\";}','drupal_get_form','a:2:{i:0;s:23:\"image_style_revert_form\";i:1;i:5;}','',62,6,0,'','admin/config/media/image-styles/revert/%','Revert style','t','','','a:0:{}',6,'Revert an image style.','',0,'modules/image/image.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/media/image-toolkit','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:1:{i:0;s:29:\"system_image_toolkit_settings\";}','',15,4,0,'','admin/config/media/image-toolkit','Image toolkit','t','','','a:0:{}',6,'Choose which image toolkit to use if you have installed optional toolkits.','',20,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/people','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_menu_block_page','a:0:{}','',7,3,0,'','admin/config/people','People','t','','','a:0:{}',6,'Configure user accounts.','left',-20,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/people/accounts','','','user_access','a:1:{i:0;s:16:\"administer users\";}','drupal_get_form','a:1:{i:0;s:19:\"user_admin_settings\";}','',15,4,0,'','admin/config/people/accounts','Account settings','t','','','a:0:{}',6,'Configure default behavior of users, including registration requirements, e-mails, fields, and user pictures.','',-10,'modules/user/user.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/people/accounts/display','','','user_access','a:1:{i:0;s:16:\"administer users\";}','drupal_get_form','a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:4:\"user\";i:2;s:4:\"user\";i:3;s:7:\"default\";}','',31,5,1,'admin/config/people/accounts','admin/config/people/accounts','Manage display','t','','','a:0:{}',132,'','',2,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/people/accounts/display/default','','','_field_ui_view_mode_menu_access','a:5:{i:0;s:4:\"user\";i:1;s:4:\"user\";i:2;s:7:\"default\";i:3;s:11:\"user_access\";i:4;s:16:\"administer users\";}','drupal_get_form','a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:4:\"user\";i:2;s:4:\"user\";i:3;s:7:\"default\";}','',63,6,1,'admin/config/people/accounts/display','admin/config/people/accounts','Default','t','','','a:0:{}',140,'','',-10,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/people/accounts/display/full','','','_field_ui_view_mode_menu_access','a:5:{i:0;s:4:\"user\";i:1;s:4:\"user\";i:2;s:4:\"full\";i:3;s:11:\"user_access\";i:4;s:16:\"administer users\";}','drupal_get_form','a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:4:\"user\";i:2;s:4:\"user\";i:3;s:4:\"full\";}','',63,6,1,'admin/config/people/accounts/display','admin/config/people/accounts','User account','t','','','a:0:{}',132,'','',0,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/people/accounts/fields','','','user_access','a:1:{i:0;s:16:\"administer users\";}','drupal_get_form','a:3:{i:0;s:28:\"field_ui_field_overview_form\";i:1;s:4:\"user\";i:2;s:4:\"user\";}','',31,5,1,'admin/config/people/accounts','admin/config/people/accounts','Manage fields','t','','','a:0:{}',132,'','',1,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/people/accounts/fields/%','a:1:{i:5;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:4:\"user\";i:1;s:4:\"user\";i:2;s:1:\"0\";i:3;s:4:\"%map\";}}}','','user_access','a:1:{i:0;s:16:\"administer users\";}','drupal_get_form','a:2:{i:0;s:24:\"field_ui_field_edit_form\";i:1;i:5;}','',62,6,0,'','admin/config/people/accounts/fields/%','','field_ui_menu_title','a:1:{i:0;i:5;}','','a:0:{}',6,'','',0,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/people/accounts/fields/%/delete','a:1:{i:5;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:4:\"user\";i:1;s:4:\"user\";i:2;s:1:\"0\";i:3;s:4:\"%map\";}}}','','user_access','a:1:{i:0;s:16:\"administer users\";}','drupal_get_form','a:2:{i:0;s:26:\"field_ui_field_delete_form\";i:1;i:5;}','',125,7,1,'admin/config/people/accounts/fields/%','admin/config/people/accounts/fields/%','Delete','t','','','a:0:{}',132,'','',10,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/people/accounts/fields/%/edit','a:1:{i:5;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:4:\"user\";i:1;s:4:\"user\";i:2;s:1:\"0\";i:3;s:4:\"%map\";}}}','','user_access','a:1:{i:0;s:16:\"administer users\";}','drupal_get_form','a:2:{i:0;s:24:\"field_ui_field_edit_form\";i:1;i:5;}','',125,7,1,'admin/config/people/accounts/fields/%','admin/config/people/accounts/fields/%','Edit','t','','','a:0:{}',140,'','',0,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/people/accounts/fields/%/field-settings','a:1:{i:5;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:4:\"user\";i:1;s:4:\"user\";i:2;s:1:\"0\";i:3;s:4:\"%map\";}}}','','user_access','a:1:{i:0;s:16:\"administer users\";}','drupal_get_form','a:2:{i:0;s:28:\"field_ui_field_settings_form\";i:1;i:5;}','',125,7,1,'admin/config/people/accounts/fields/%','admin/config/people/accounts/fields/%','Field settings','t','','','a:0:{}',132,'','',0,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/people/accounts/fields/%/widget-type','a:1:{i:5;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:4:\"user\";i:1;s:4:\"user\";i:2;s:1:\"0\";i:3;s:4:\"%map\";}}}','','user_access','a:1:{i:0;s:16:\"administer users\";}','drupal_get_form','a:2:{i:0;s:25:\"field_ui_widget_type_form\";i:1;i:5;}','',125,7,1,'admin/config/people/accounts/fields/%','admin/config/people/accounts/fields/%','Widget type','t','','','a:0:{}',132,'','',0,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/people/accounts/settings','','','user_access','a:1:{i:0;s:16:\"administer users\";}','drupal_get_form','a:1:{i:0;s:19:\"user_admin_settings\";}','',31,5,1,'admin/config/people/accounts','admin/config/people/accounts','Settings','t','','','a:0:{}',140,'','',-10,'modules/user/user.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/people/ip-blocking','','','user_access','a:1:{i:0;s:18:\"block IP addresses\";}','system_ip_blocking','a:0:{}','',15,4,0,'','admin/config/people/ip-blocking','IP address blocking','t','','','a:0:{}',6,'Manage blocked IP addresses.','',10,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/people/ip-blocking/delete/%','a:1:{i:5;s:15:\"blocked_ip_load\";}','','user_access','a:1:{i:0;s:18:\"block IP addresses\";}','drupal_get_form','a:2:{i:0;s:25:\"system_ip_blocking_delete\";i:1;i:5;}','',62,6,0,'','admin/config/people/ip-blocking/delete/%','Delete IP address','t','','','a:0:{}',6,'','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/regional','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_menu_block_page','a:0:{}','',7,3,0,'','admin/config/regional','Regional and language','t','','','a:0:{}',6,'Regional settings, localization and translation.','left',-5,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/regional/date-time','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:1:{i:0;s:25:\"system_date_time_settings\";}','',15,4,0,'','admin/config/regional/date-time','Date and time','t','','','a:0:{}',6,'Configure display formats for date and time.','',-15,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/regional/date-time/formats','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','system_date_time_formats','a:0:{}','',31,5,1,'admin/config/regional/date-time','admin/config/regional/date-time','Formats','t','','','a:0:{}',132,'Configure display format strings for date and time.','',-9,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/regional/date-time/formats/%/delete','a:1:{i:5;N;}','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:2:{i:0;s:30:\"system_date_delete_format_form\";i:1;i:5;}','',125,7,0,'','admin/config/regional/date-time/formats/%/delete','Delete date format','t','','','a:0:{}',6,'Allow users to delete a configured date format.','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/regional/date-time/formats/%/edit','a:1:{i:5;N;}','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:2:{i:0;s:34:\"system_configure_date_formats_form\";i:1;i:5;}','',125,7,0,'','admin/config/regional/date-time/formats/%/edit','Edit date format','t','','','a:0:{}',6,'Allow users to edit a configured date format.','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/regional/date-time/formats/add','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:1:{i:0;s:34:\"system_configure_date_formats_form\";}','',63,6,1,'admin/config/regional/date-time/formats','admin/config/regional/date-time','Add format','t','','','a:0:{}',388,'Allow users to add additional date formats.','',-10,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/regional/date-time/formats/lookup','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','system_date_time_lookup','a:0:{}','',63,6,0,'','admin/config/regional/date-time/formats/lookup','Date and time lookup','t','','','a:0:{}',0,'','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/regional/date-time/types','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:1:{i:0;s:25:\"system_date_time_settings\";}','',31,5,1,'admin/config/regional/date-time','admin/config/regional/date-time','Types','t','','','a:0:{}',140,'Configure display formats for date and time.','',-10,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/regional/date-time/types/%/delete','a:1:{i:5;N;}','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:2:{i:0;s:35:\"system_delete_date_format_type_form\";i:1;i:5;}','',125,7,0,'','admin/config/regional/date-time/types/%/delete','Delete date type','t','','','a:0:{}',6,'Allow users to delete a configured date type.','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/regional/date-time/types/add','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:1:{i:0;s:32:\"system_add_date_format_type_form\";}','',63,6,1,'admin/config/regional/date-time/types','admin/config/regional/date-time','Add date type','t','','','a:0:{}',388,'Add new date type.','',-10,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/regional/settings','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:1:{i:0;s:24:\"system_regional_settings\";}','',15,4,0,'','admin/config/regional/settings','Regional settings','t','','','a:0:{}',6,'Settings for the site\'s default time zone and country.','',-20,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/search','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_menu_block_page','a:0:{}','',7,3,0,'','admin/config/search','Search and metadata','t','','','a:0:{}',6,'Local site search, metadata and SEO.','left',-10,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/search/clean-urls','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:1:{i:0;s:25:\"system_clean_url_settings\";}','',15,4,0,'','admin/config/search/clean-urls','Clean URLs','t','','','a:0:{}',6,'Enable or disable clean URLs for your site.','',5,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/search/clean-urls/check','','','1','a:0:{}','drupal_json_output','a:1:{i:0;a:1:{s:6:\"status\";b:1;}}','',31,5,0,'','admin/config/search/clean-urls/check','Clean URL check','t','','','a:0:{}',0,'','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/search/path','','','user_access','a:1:{i:0;s:22:\"administer url aliases\";}','path_admin_overview','a:0:{}','',15,4,0,'','admin/config/search/path','URL aliases','t','','','a:0:{}',6,'Change your site\'s URL paths by aliasing them.','',-5,'modules/path/path.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/search/path/add','','','user_access','a:1:{i:0;s:22:\"administer url aliases\";}','path_admin_edit','a:0:{}','',31,5,1,'admin/config/search/path','admin/config/search/path','Add alias','t','','','a:0:{}',388,'','',0,'modules/path/path.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/search/path/delete/%','a:1:{i:5;s:9:\"path_load\";}','','user_access','a:1:{i:0;s:22:\"administer url aliases\";}','drupal_get_form','a:2:{i:0;s:25:\"path_admin_delete_confirm\";i:1;i:5;}','',62,6,0,'','admin/config/search/path/delete/%','Delete alias','t','','','a:0:{}',6,'','',0,'modules/path/path.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/search/path/edit/%','a:1:{i:5;s:9:\"path_load\";}','','user_access','a:1:{i:0;s:22:\"administer url aliases\";}','path_admin_edit','a:1:{i:0;i:5;}','',62,6,0,'','admin/config/search/path/edit/%','Edit alias','t','','','a:0:{}',6,'','',0,'modules/path/path.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/search/path/list','','','user_access','a:1:{i:0;s:22:\"administer url aliases\";}','path_admin_overview','a:0:{}','',31,5,1,'admin/config/search/path','admin/config/search/path','List','t','','','a:0:{}',140,'','',-10,'modules/path/path.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/search/settings','','','user_access','a:1:{i:0;s:17:\"administer search\";}','drupal_get_form','a:1:{i:0;s:21:\"search_admin_settings\";}','',15,4,0,'','admin/config/search/settings','Search settings','t','','','a:0:{}',6,'Configure relevance settings for search and other indexing options.','',-10,'modules/search/search.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/search/settings/reindex','','','user_access','a:1:{i:0;s:17:\"administer search\";}','drupal_get_form','a:1:{i:0;s:22:\"search_reindex_confirm\";}','',31,5,0,'','admin/config/search/settings/reindex','Clear index','t','','','a:0:{}',4,'','',0,'modules/search/search.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/services','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_menu_block_page','a:0:{}','',7,3,0,'','admin/config/services','Web services','t','','','a:0:{}',6,'Tools related to web services.','right',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/services/rss-publishing','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:1:{i:0;s:25:\"system_rss_feeds_settings\";}','',15,4,0,'','admin/config/services/rss-publishing','RSS publishing','t','','','a:0:{}',6,'Configure the site description, the number of items per feed and whether feeds should be titles/teasers/full-text.','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/system','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_menu_block_page','a:0:{}','',7,3,0,'','admin/config/system','System','t','','','a:0:{}',6,'General system related configuration.','right',-20,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/system/actions','','','user_access','a:1:{i:0;s:18:\"administer actions\";}','system_actions_manage','a:0:{}','',15,4,0,'','admin/config/system/actions','Actions','t','','','a:0:{}',6,'Manage the actions defined for your site.','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/system/actions/configure','','','user_access','a:1:{i:0;s:18:\"administer actions\";}','drupal_get_form','a:1:{i:0;s:24:\"system_actions_configure\";}','',31,5,0,'','admin/config/system/actions/configure','Configure an advanced action','t','','','a:0:{}',4,'','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/system/actions/delete/%','a:1:{i:5;s:12:\"actions_load\";}','','user_access','a:1:{i:0;s:18:\"administer actions\";}','drupal_get_form','a:2:{i:0;s:26:\"system_actions_delete_form\";i:1;i:5;}','',62,6,0,'','admin/config/system/actions/delete/%','Delete action','t','','','a:0:{}',6,'Delete an action.','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/system/actions/manage','','','user_access','a:1:{i:0;s:18:\"administer actions\";}','system_actions_manage','a:0:{}','',31,5,1,'admin/config/system/actions','admin/config/system/actions','Manage actions','t','','','a:0:{}',140,'Manage the actions defined for your site.','',-2,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/system/actions/orphan','','','user_access','a:1:{i:0;s:18:\"administer actions\";}','system_actions_remove_orphans','a:0:{}','',31,5,0,'','admin/config/system/actions/orphan','Remove orphans','t','','','a:0:{}',0,'','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/system/cron','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:1:{i:0;s:20:\"system_cron_settings\";}','',15,4,0,'','admin/config/system/cron','Cron','t','','','a:0:{}',6,'Manage automatic site maintenance tasks.','',20,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/system/site-information','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:1:{i:0;s:32:\"system_site_information_settings\";}','',15,4,0,'','admin/config/system/site-information','Site information','t','','','a:0:{}',6,'Change site name, e-mail address, slogan, default front page, and number of posts per page, error pages.','',-20,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/user-interface','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_menu_block_page','a:0:{}','',7,3,0,'','admin/config/user-interface','User interface','t','','','a:0:{}',6,'Tools that enhance the user interface.','right',-15,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/user-interface/shortcut','','','user_access','a:1:{i:0;s:20:\"administer shortcuts\";}','shortcut_set_admin','a:0:{}','',15,4,0,'','admin/config/user-interface/shortcut','Shortcuts','t','','','a:0:{}',6,'Add and modify shortcut sets.','',0,'modules/shortcut/shortcut.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/user-interface/shortcut/%','a:1:{i:4;s:17:\"shortcut_set_load\";}','','shortcut_set_edit_access','a:1:{i:0;i:4;}','drupal_get_form','a:2:{i:0;s:22:\"shortcut_set_customize\";i:1;i:4;}','',30,5,0,'','admin/config/user-interface/shortcut/%','Edit shortcuts','shortcut_set_title','a:1:{i:0;i:4;}','','a:0:{}',6,'','',0,'modules/shortcut/shortcut.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/user-interface/shortcut/%/add-link','a:1:{i:4;s:17:\"shortcut_set_load\";}','','shortcut_set_edit_access','a:1:{i:0;i:4;}','drupal_get_form','a:2:{i:0;s:17:\"shortcut_link_add\";i:1;i:4;}','',61,6,1,'admin/config/user-interface/shortcut/%','admin/config/user-interface/shortcut/%','Add shortcut','t','','','a:0:{}',388,'','',0,'modules/shortcut/shortcut.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/user-interface/shortcut/%/add-link-inline','a:1:{i:4;s:17:\"shortcut_set_load\";}','','shortcut_set_edit_access','a:1:{i:0;i:4;}','shortcut_link_add_inline','a:1:{i:0;i:4;}','',61,6,0,'','admin/config/user-interface/shortcut/%/add-link-inline','Add shortcut','t','','','a:0:{}',0,'','',0,'modules/shortcut/shortcut.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/user-interface/shortcut/%/delete','a:1:{i:4;s:17:\"shortcut_set_load\";}','','shortcut_set_delete_access','a:1:{i:0;i:4;}','drupal_get_form','a:2:{i:0;s:24:\"shortcut_set_delete_form\";i:1;i:4;}','',61,6,0,'','admin/config/user-interface/shortcut/%/delete','Delete shortcut set','t','','','a:0:{}',6,'','',0,'modules/shortcut/shortcut.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/user-interface/shortcut/%/edit','a:1:{i:4;s:17:\"shortcut_set_load\";}','','shortcut_set_edit_access','a:1:{i:0;i:4;}','drupal_get_form','a:2:{i:0;s:22:\"shortcut_set_edit_form\";i:1;i:4;}','',61,6,1,'admin/config/user-interface/shortcut/%','admin/config/user-interface/shortcut/%','Edit set name','t','','','a:0:{}',132,'','',10,'modules/shortcut/shortcut.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/user-interface/shortcut/%/links','a:1:{i:4;s:17:\"shortcut_set_load\";}','','shortcut_set_edit_access','a:1:{i:0;i:4;}','drupal_get_form','a:2:{i:0;s:22:\"shortcut_set_customize\";i:1;i:4;}','',61,6,1,'admin/config/user-interface/shortcut/%','admin/config/user-interface/shortcut/%','List links','t','','','a:0:{}',140,'','',0,'modules/shortcut/shortcut.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/user-interface/shortcut/add-set','','','user_access','a:1:{i:0;s:20:\"administer shortcuts\";}','drupal_get_form','a:1:{i:0;s:21:\"shortcut_set_add_form\";}','',31,5,1,'admin/config/user-interface/shortcut','admin/config/user-interface/shortcut','Add shortcut set','t','','','a:0:{}',388,'','',0,'modules/shortcut/shortcut.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/user-interface/shortcut/link/%','a:1:{i:5;s:14:\"menu_link_load\";}','','shortcut_link_access','a:1:{i:0;i:5;}','drupal_get_form','a:2:{i:0;s:18:\"shortcut_link_edit\";i:1;i:5;}','',62,6,0,'','admin/config/user-interface/shortcut/link/%','Edit shortcut','t','','','a:0:{}',6,'','',0,'modules/shortcut/shortcut.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/user-interface/shortcut/link/%/delete','a:1:{i:5;s:14:\"menu_link_load\";}','','shortcut_link_access','a:1:{i:0;i:5;}','drupal_get_form','a:2:{i:0;s:20:\"shortcut_link_delete\";i:1;i:5;}','',125,7,0,'','admin/config/user-interface/shortcut/link/%/delete','Delete shortcut','t','','','a:0:{}',6,'','',0,'modules/shortcut/shortcut.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/workflow','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_menu_block_page','a:0:{}','',7,3,0,'','admin/config/workflow','Workflow','t','','','a:0:{}',6,'Content workflow, editorial workflow tools.','right',5,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/content','','','user_access','a:1:{i:0;s:23:\"access content overview\";}','drupal_get_form','a:1:{i:0;s:18:\"node_admin_content\";}','',3,2,0,'','admin/content','Content','t','','','a:0:{}',6,'Administer content and comments.','',-10,'modules/node/node.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/content/comment','','','user_access','a:1:{i:0;s:19:\"administer comments\";}','comment_admin','a:0:{}','',7,3,1,'admin/content','admin/content','Comments','t','','','a:0:{}',134,'List and edit site comments and the comment approval queue.','',0,'modules/comment/comment.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/content/comment/approval','','','user_access','a:1:{i:0;s:19:\"administer comments\";}','comment_admin','a:1:{i:0;s:8:\"approval\";}','',15,4,1,'admin/content/comment','admin/content','Unapproved comments','comment_count_unpublished','','','a:0:{}',132,'','',0,'modules/comment/comment.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/content/comment/new','','','user_access','a:1:{i:0;s:19:\"administer comments\";}','comment_admin','a:0:{}','',15,4,1,'admin/content/comment','admin/content','Published comments','t','','','a:0:{}',140,'','',-10,'modules/comment/comment.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/content/node','','','user_access','a:1:{i:0;s:23:\"access content overview\";}','drupal_get_form','a:1:{i:0;s:18:\"node_admin_content\";}','',7,3,1,'admin/content','admin/content','Content','t','','','a:0:{}',140,'','',-10,'modules/node/node.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/dashboard','','','user_access','a:1:{i:0;s:16:\"access dashboard\";}','dashboard_admin','a:0:{}','',3,2,0,'','admin/dashboard','Dashboard','t','','','a:0:{}',6,'View and customize your dashboard.','',-15,'');
INSERT INTO `menu_router` VALUES ('admin/dashboard/block-content/%/%','a:2:{i:3;N;i:4;N;}','','user_access','a:1:{i:0;s:17:\"administer blocks\";}','dashboard_show_block_content','a:2:{i:0;i:3;i:1;i:4;}','',28,5,0,'','admin/dashboard/block-content/%/%','','t','','','a:0:{}',0,'','',0,'');
INSERT INTO `menu_router` VALUES ('admin/dashboard/configure','','','user_access','a:1:{i:0;s:17:\"administer blocks\";}','dashboard_admin_blocks','a:0:{}','',7,3,0,'','admin/dashboard/configure','Configure available dashboard blocks','t','','','a:0:{}',4,'Configure which blocks can be shown on the dashboard.','',0,'');
INSERT INTO `menu_router` VALUES ('admin/dashboard/customize','','','user_access','a:1:{i:0;s:16:\"access dashboard\";}','dashboard_admin','a:1:{i:0;b:1;}','',7,3,0,'','admin/dashboard/customize','Customize dashboard','t','','','a:0:{}',4,'Customize your dashboard.','',0,'');
INSERT INTO `menu_router` VALUES ('admin/dashboard/drawer','','','user_access','a:1:{i:0;s:17:\"administer blocks\";}','dashboard_show_disabled','a:0:{}','',7,3,0,'','admin/dashboard/drawer','','t','','','a:0:{}',0,'','',0,'');
INSERT INTO `menu_router` VALUES ('admin/dashboard/update','','','user_access','a:1:{i:0;s:17:\"administer blocks\";}','dashboard_update','a:0:{}','',7,3,0,'','admin/dashboard/update','','t','','','a:0:{}',0,'','',0,'');
INSERT INTO `menu_router` VALUES ('admin/help','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_main','a:0:{}','',3,2,0,'','admin/help','Help','t','','','a:0:{}',6,'Reference for usage, configuration, and modules.','',9,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/block','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/block','block','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/color','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/color','color','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/comment','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/comment','comment','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/contextual','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/contextual','contextual','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/dashboard','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/dashboard','dashboard','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/dblog','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/dblog','dblog','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/field','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/field','field','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/field_sql_storage','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/field_sql_storage','field_sql_storage','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/field_ui','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/field_ui','field_ui','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/file','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/file','file','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/filter','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/filter','filter','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/help','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/help','help','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/image','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/image','image','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/list','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/list','list','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/menu','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/menu','menu','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/node','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/node','node','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/number','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/number','number','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/options','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/options','options','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/overlay','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/overlay','overlay','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/path','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/path','path','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/rdf','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/rdf','rdf','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/search','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/search','search','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/shortcut','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/shortcut','shortcut','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/system','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/system','system','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/taxonomy','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/taxonomy','taxonomy','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/text','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/text','text','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/toolbar','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/toolbar','toolbar','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/user','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/user','user','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/index','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_index','a:0:{}','',3,2,1,'admin','admin','Index','t','','','a:0:{}',132,'','',-18,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/modules','','','user_access','a:1:{i:0;s:18:\"administer modules\";}','drupal_get_form','a:1:{i:0;s:14:\"system_modules\";}','',3,2,0,'','admin/modules','Modules','t','','','a:0:{}',6,'Extend site functionality.','',-2,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/modules/list','','','user_access','a:1:{i:0;s:18:\"administer modules\";}','drupal_get_form','a:1:{i:0;s:14:\"system_modules\";}','',7,3,1,'admin/modules','admin/modules','List','t','','','a:0:{}',140,'','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/modules/list/confirm','','','user_access','a:1:{i:0;s:18:\"administer modules\";}','drupal_get_form','a:1:{i:0;s:14:\"system_modules\";}','',15,4,0,'','admin/modules/list/confirm','List','t','','','a:0:{}',4,'','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/modules/uninstall','','','user_access','a:1:{i:0;s:18:\"administer modules\";}','drupal_get_form','a:1:{i:0;s:24:\"system_modules_uninstall\";}','',7,3,1,'admin/modules','admin/modules','Uninstall','t','','','a:0:{}',132,'','',20,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/modules/uninstall/confirm','','','user_access','a:1:{i:0;s:18:\"administer modules\";}','drupal_get_form','a:1:{i:0;s:24:\"system_modules_uninstall\";}','',15,4,0,'','admin/modules/uninstall/confirm','Uninstall','t','','','a:0:{}',4,'','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/people','','','user_access','a:1:{i:0;s:16:\"administer users\";}','user_admin','a:1:{i:0;s:4:\"list\";}','',3,2,0,'','admin/people','People','t','','','a:0:{}',6,'Manage user accounts, roles, and permissions.','left',-4,'modules/user/user.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/people/create','','','user_access','a:1:{i:0;s:16:\"administer users\";}','user_admin','a:1:{i:0;s:6:\"create\";}','',7,3,1,'admin/people','admin/people','Add user','t','','','a:0:{}',388,'','',0,'modules/user/user.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/people/people','','','user_access','a:1:{i:0;s:16:\"administer users\";}','user_admin','a:1:{i:0;s:4:\"list\";}','',7,3,1,'admin/people','admin/people','List','t','','','a:0:{}',140,'Find and manage people interacting with your site.','',-10,'modules/user/user.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/people/permissions','','','user_access','a:1:{i:0;s:22:\"administer permissions\";}','drupal_get_form','a:1:{i:0;s:22:\"user_admin_permissions\";}','',7,3,1,'admin/people','admin/people','Permissions','t','','','a:0:{}',132,'Determine access to features by selecting permissions for roles.','',0,'modules/user/user.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/people/permissions/list','','','user_access','a:1:{i:0;s:22:\"administer permissions\";}','drupal_get_form','a:1:{i:0;s:22:\"user_admin_permissions\";}','',15,4,1,'admin/people/permissions','admin/people','Permissions','t','','','a:0:{}',140,'Determine access to features by selecting permissions for roles.','',-8,'modules/user/user.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/people/permissions/roles','','','user_access','a:1:{i:0;s:22:\"administer permissions\";}','drupal_get_form','a:1:{i:0;s:16:\"user_admin_roles\";}','',15,4,1,'admin/people/permissions','admin/people','Roles','t','','','a:0:{}',132,'List, edit, or add user roles.','',-5,'modules/user/user.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/people/permissions/roles/delete/%','a:1:{i:5;s:14:\"user_role_load\";}','','user_role_edit_access','a:1:{i:0;i:5;}','drupal_get_form','a:2:{i:0;s:30:\"user_admin_role_delete_confirm\";i:1;i:5;}','',62,6,0,'','admin/people/permissions/roles/delete/%','Delete role','t','','','a:0:{}',6,'','',0,'modules/user/user.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/people/permissions/roles/edit/%','a:1:{i:5;s:14:\"user_role_load\";}','','user_role_edit_access','a:1:{i:0;i:5;}','drupal_get_form','a:2:{i:0;s:15:\"user_admin_role\";i:1;i:5;}','',62,6,0,'','admin/people/permissions/roles/edit/%','Edit role','t','','','a:0:{}',6,'','',0,'modules/user/user.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/reports','','','user_access','a:1:{i:0;s:19:\"access site reports\";}','system_admin_menu_block_page','a:0:{}','',3,2,0,'','admin/reports','Reports','t','','','a:0:{}',6,'View reports, updates, and errors.','left',5,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/reports/access-denied','','','user_access','a:1:{i:0;s:19:\"access site reports\";}','dblog_top','a:1:{i:0;s:13:\"access denied\";}','',7,3,0,'','admin/reports/access-denied','Top \'access denied\' errors','t','','','a:0:{}',6,'View \'access denied\' errors (403s).','',0,'modules/dblog/dblog.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/reports/dblog','','','user_access','a:1:{i:0;s:19:\"access site reports\";}','dblog_overview','a:0:{}','',7,3,0,'','admin/reports/dblog','Recent log messages','t','','','a:0:{}',6,'View events that have recently been logged.','',-1,'modules/dblog/dblog.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/reports/event/%','a:1:{i:3;N;}','','user_access','a:1:{i:0;s:19:\"access site reports\";}','dblog_event','a:1:{i:0;i:3;}','',14,4,0,'','admin/reports/event/%','Details','t','','','a:0:{}',6,'','',0,'modules/dblog/dblog.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/reports/fields','','','user_access','a:1:{i:0;s:24:\"administer content types\";}','field_ui_fields_list','a:0:{}','',7,3,0,'','admin/reports/fields','Field list','t','','','a:0:{}',6,'Overview of fields on all entity types.','',0,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/reports/page-not-found','','','user_access','a:1:{i:0;s:19:\"access site reports\";}','dblog_top','a:1:{i:0;s:14:\"page not found\";}','',7,3,0,'','admin/reports/page-not-found','Top \'page not found\' errors','t','','','a:0:{}',6,'View \'page not found\' errors (404s).','',0,'modules/dblog/dblog.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/reports/search','','','user_access','a:1:{i:0;s:19:\"access site reports\";}','dblog_top','a:1:{i:0;s:6:\"search\";}','',7,3,0,'','admin/reports/search','Top search phrases','t','','','a:0:{}',6,'View most popular search phrases.','',0,'modules/dblog/dblog.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/reports/status','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','system_status','a:0:{}','',7,3,0,'','admin/reports/status','Status report','t','','','a:0:{}',6,'Get a status report about your site\'s operation and any detected problems.','',-60,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/reports/status/php','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','system_php','a:0:{}','',15,4,0,'','admin/reports/status/php','PHP','t','','','a:0:{}',0,'','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/reports/status/rebuild','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','drupal_get_form','a:1:{i:0;s:30:\"node_configure_rebuild_confirm\";}','',15,4,0,'','admin/reports/status/rebuild','Rebuild permissions','t','','','a:0:{}',0,'','',0,'modules/node/node.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/reports/status/run-cron','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','system_run_cron','a:0:{}','',15,4,0,'','admin/reports/status/run-cron','Run cron','t','','','a:0:{}',0,'','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_menu_block_page','a:0:{}','',3,2,0,'','admin/structure','Structure','t','','','a:0:{}',6,'Administer blocks, content types, menus, etc.','right',-8,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block','','','user_access','a:1:{i:0;s:17:\"administer blocks\";}','block_admin_display','a:1:{i:0;s:6:\"bartik\";}','',7,3,0,'','admin/structure/block','Blocks','t','','','a:0:{}',6,'Configure what block content appears in your site\'s sidebars and other regions.','',0,'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/add','','','user_access','a:1:{i:0;s:17:\"administer blocks\";}','drupal_get_form','a:1:{i:0;s:20:\"block_add_block_form\";}','',15,4,1,'admin/structure/block','admin/structure/block','Add block','t','','','a:0:{}',388,'','',0,'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/demo/bartik','','','_block_themes_access','a:1:{i:0;O:8:\"stdClass\":11:{s:8:\"filename\";s:25:\"themes/bartik/bartik.info\";s:4:\"name\";s:6:\"bartik\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:18:{s:4:\"name\";s:6:\"Bartik\";s:11:\"description\";s:48:\"A flexible, recolorable theme with many regions.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:3:{s:14:\"css/layout.css\";s:28:\"themes/bartik/css/layout.css\";s:13:\"css/style.css\";s:27:\"themes/bartik/css/style.css\";s:14:\"css/colors.css\";s:28:\"themes/bartik/css/colors.css\";}s:5:\"print\";a:1:{s:13:\"css/print.css\";s:27:\"themes/bartik/css/print.css\";}}s:7:\"regions\";a:20:{s:6:\"header\";s:6:\"Header\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:11:\"highlighted\";s:11:\"Highlighted\";s:8:\"featured\";s:8:\"Featured\";s:7:\"content\";s:7:\"Content\";s:13:\"sidebar_first\";s:13:\"Sidebar first\";s:14:\"sidebar_second\";s:14:\"Sidebar second\";s:14:\"triptych_first\";s:14:\"Triptych first\";s:15:\"triptych_middle\";s:15:\"Triptych middle\";s:13:\"triptych_last\";s:13:\"Triptych last\";s:18:\"footer_firstcolumn\";s:19:\"Footer first column\";s:19:\"footer_secondcolumn\";s:20:\"Footer second column\";s:18:\"footer_thirdcolumn\";s:19:\"Footer third column\";s:19:\"footer_fourthcolumn\";s:20:\"Footer fourth column\";s:6:\"footer\";s:6:\"Footer\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"settings\";a:1:{s:20:\"shortcut_module_link\";s:1:\"0\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:6:\"engine\";s:11:\"phptemplate\";s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:28:\"themes/bartik/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:11:\"stylesheets\";a:2:{s:3:\"all\";a:3:{s:14:\"css/layout.css\";s:28:\"themes/bartik/css/layout.css\";s:13:\"css/style.css\";s:27:\"themes/bartik/css/style.css\";s:14:\"css/colors.css\";s:28:\"themes/bartik/css/colors.css\";}s:5:\"print\";a:1:{s:13:\"css/print.css\";s:27:\"themes/bartik/css/print.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}','block_admin_demo','a:1:{i:0;s:6:\"bartik\";}','',31,5,0,'','admin/structure/block/demo/bartik','Bartik','t','','_block_custom_theme','a:1:{i:0;s:6:\"bartik\";}',0,'','',0,'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/demo/garland','','','_block_themes_access','a:1:{i:0;O:8:\"stdClass\":11:{s:8:\"filename\";s:27:\"themes/garland/garland.info\";s:4:\"name\";s:7:\"garland\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"0\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:18:{s:4:\"name\";s:7:\"Garland\";s:11:\"description\";s:111:\"A multi-column theme which can be configured to modify colors and switch between fixed and fluid width layouts.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:1:{s:9:\"style.css\";s:24:\"themes/garland/style.css\";}s:5:\"print\";a:1:{s:9:\"print.css\";s:24:\"themes/garland/print.css\";}}s:8:\"settings\";a:1:{s:13:\"garland_width\";s:5:\"fluid\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:29:\"themes/garland/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:11:\"stylesheets\";a:2:{s:3:\"all\";a:1:{s:9:\"style.css\";s:24:\"themes/garland/style.css\";}s:5:\"print\";a:1:{s:9:\"print.css\";s:24:\"themes/garland/print.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}','block_admin_demo','a:1:{i:0;s:7:\"garland\";}','',31,5,0,'','admin/structure/block/demo/garland','Garland','t','','_block_custom_theme','a:1:{i:0;s:7:\"garland\";}',0,'','',0,'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/demo/seven','','','_block_themes_access','a:1:{i:0;O:8:\"stdClass\":11:{s:8:\"filename\";s:23:\"themes/seven/seven.info\";s:4:\"name\";s:5:\"seven\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:18:{s:4:\"name\";s:5:\"Seven\";s:11:\"description\";s:65:\"A simple one-column, tableless, fluid width administration theme.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:1:{s:6:\"screen\";a:2:{s:9:\"reset.css\";s:22:\"themes/seven/reset.css\";s:9:\"style.css\";s:22:\"themes/seven/style.css\";}}s:8:\"settings\";a:1:{s:20:\"shortcut_module_link\";s:1:\"1\";}s:7:\"regions\";a:8:{s:7:\"content\";s:7:\"Content\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:13:\"sidebar_first\";s:13:\"First sidebar\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:14:\"regions_hidden\";a:3:{i:0;s:13:\"sidebar_first\";i:1;s:8:\"page_top\";i:2;s:11:\"page_bottom\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:6:\"engine\";s:11:\"phptemplate\";s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:27:\"themes/seven/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:11:\"stylesheets\";a:1:{s:6:\"screen\";a:2:{s:9:\"reset.css\";s:22:\"themes/seven/reset.css\";s:9:\"style.css\";s:22:\"themes/seven/style.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}','block_admin_demo','a:1:{i:0;s:5:\"seven\";}','',31,5,0,'','admin/structure/block/demo/seven','Seven','t','','_block_custom_theme','a:1:{i:0;s:5:\"seven\";}',0,'','',0,'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/demo/stark','','','_block_themes_access','a:1:{i:0;O:8:\"stdClass\":11:{s:8:\"filename\";s:23:\"themes/stark/stark.info\";s:4:\"name\";s:5:\"stark\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"0\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:17:{s:4:\"name\";s:5:\"Stark\";s:11:\"description\";s:208:\"This theme demonstrates Drupal\'s default HTML markup and CSS styles. To learn how to build your own theme and override Drupal\'s default code, see the <a href=\"http://drupal.org/theme-guide\">Theming Guide</a>.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:10:\"layout.css\";s:23:\"themes/stark/layout.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:27:\"themes/stark/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:10:\"layout.css\";s:23:\"themes/stark/layout.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}','block_admin_demo','a:1:{i:0;s:5:\"stark\";}','',31,5,0,'','admin/structure/block/demo/stark','Stark','t','','_block_custom_theme','a:1:{i:0;s:5:\"stark\";}',0,'','',0,'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/demo/test_theme','','','_block_themes_access','a:1:{i:0;O:8:\"stdClass\":11:{s:8:\"filename\";s:39:\"themes/tests/test_theme/test_theme.info\";s:4:\"name\";s:10:\"test_theme\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"0\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:17:{s:4:\"name\";s:10:\"Test theme\";s:11:\"description\";s:34:\"Theme for testing the theme system\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:15:\"system.base.css\";s:39:\"themes/tests/test_theme/system.base.css\";}}s:7:\"version\";s:3:\"7.8\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:38:\"themes/tests/test_theme/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:15:\"system.base.css\";s:39:\"themes/tests/test_theme/system.base.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}','block_admin_demo','a:1:{i:0;s:10:\"test_theme\";}','',31,5,0,'','admin/structure/block/demo/test_theme','Test theme','t','','_block_custom_theme','a:1:{i:0;s:10:\"test_theme\";}',0,'','',0,'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/demo/update_test_basetheme','','','_block_themes_access','a:1:{i:0;O:8:\"stdClass\":10:{s:8:\"filename\";s:61:\"themes/tests/update_test_basetheme/update_test_basetheme.info\";s:4:\"name\";s:21:\"update_test_basetheme\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"0\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:17:{s:4:\"name\";s:22:\"Update test base theme\";s:11:\"description\";s:63:\"Test theme which acts as a base theme for other test subthemes.\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"version\";s:3:\"7.8\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:49:\"themes/tests/update_test_basetheme/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:11:\"stylesheets\";a:0:{}s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:6:\"engine\";s:11:\"phptemplate\";}}','block_admin_demo','a:1:{i:0;s:21:\"update_test_basetheme\";}','',31,5,0,'','admin/structure/block/demo/update_test_basetheme','Update test base theme','t','','_block_custom_theme','a:1:{i:0;s:21:\"update_test_basetheme\";}',0,'','',0,'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/demo/update_test_subtheme','','','_block_themes_access','a:1:{i:0;O:8:\"stdClass\":11:{s:8:\"filename\";s:59:\"themes/tests/update_test_subtheme/update_test_subtheme.info\";s:4:\"name\";s:20:\"update_test_subtheme\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"0\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:18:{s:4:\"name\";s:20:\"Update test subtheme\";s:11:\"description\";s:62:\"Test theme which uses update_test_basetheme as the base theme.\";s:4:\"core\";s:3:\"7.x\";s:10:\"base theme\";s:21:\"update_test_basetheme\";s:6:\"hidden\";b:1;s:7:\"version\";s:3:\"7.8\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:48:\"themes/tests/update_test_subtheme/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:11:\"stylesheets\";a:0:{}s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:6:\"engine\";s:11:\"phptemplate\";s:10:\"base_theme\";s:21:\"update_test_basetheme\";}}','block_admin_demo','a:1:{i:0;s:20:\"update_test_subtheme\";}','',31,5,0,'','admin/structure/block/demo/update_test_subtheme','Update test subtheme','t','','_block_custom_theme','a:1:{i:0;s:20:\"update_test_subtheme\";}',0,'','',0,'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/list/bartik','','','_block_themes_access','a:1:{i:0;O:8:\"stdClass\":11:{s:8:\"filename\";s:25:\"themes/bartik/bartik.info\";s:4:\"name\";s:6:\"bartik\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:18:{s:4:\"name\";s:6:\"Bartik\";s:11:\"description\";s:48:\"A flexible, recolorable theme with many regions.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:3:{s:14:\"css/layout.css\";s:28:\"themes/bartik/css/layout.css\";s:13:\"css/style.css\";s:27:\"themes/bartik/css/style.css\";s:14:\"css/colors.css\";s:28:\"themes/bartik/css/colors.css\";}s:5:\"print\";a:1:{s:13:\"css/print.css\";s:27:\"themes/bartik/css/print.css\";}}s:7:\"regions\";a:20:{s:6:\"header\";s:6:\"Header\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:11:\"highlighted\";s:11:\"Highlighted\";s:8:\"featured\";s:8:\"Featured\";s:7:\"content\";s:7:\"Content\";s:13:\"sidebar_first\";s:13:\"Sidebar first\";s:14:\"sidebar_second\";s:14:\"Sidebar second\";s:14:\"triptych_first\";s:14:\"Triptych first\";s:15:\"triptych_middle\";s:15:\"Triptych middle\";s:13:\"triptych_last\";s:13:\"Triptych last\";s:18:\"footer_firstcolumn\";s:19:\"Footer first column\";s:19:\"footer_secondcolumn\";s:20:\"Footer second column\";s:18:\"footer_thirdcolumn\";s:19:\"Footer third column\";s:19:\"footer_fourthcolumn\";s:20:\"Footer fourth column\";s:6:\"footer\";s:6:\"Footer\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"settings\";a:1:{s:20:\"shortcut_module_link\";s:1:\"0\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:6:\"engine\";s:11:\"phptemplate\";s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:28:\"themes/bartik/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:11:\"stylesheets\";a:2:{s:3:\"all\";a:3:{s:14:\"css/layout.css\";s:28:\"themes/bartik/css/layout.css\";s:13:\"css/style.css\";s:27:\"themes/bartik/css/style.css\";s:14:\"css/colors.css\";s:28:\"themes/bartik/css/colors.css\";}s:5:\"print\";a:1:{s:13:\"css/print.css\";s:27:\"themes/bartik/css/print.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}','block_admin_display','a:1:{i:0;s:6:\"bartik\";}','',31,5,1,'admin/structure/block','admin/structure/block','Bartik','t','','','a:0:{}',140,'','',-10,'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/list/garland','','','_block_themes_access','a:1:{i:0;O:8:\"stdClass\":11:{s:8:\"filename\";s:27:\"themes/garland/garland.info\";s:4:\"name\";s:7:\"garland\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"0\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:18:{s:4:\"name\";s:7:\"Garland\";s:11:\"description\";s:111:\"A multi-column theme which can be configured to modify colors and switch between fixed and fluid width layouts.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:1:{s:9:\"style.css\";s:24:\"themes/garland/style.css\";}s:5:\"print\";a:1:{s:9:\"print.css\";s:24:\"themes/garland/print.css\";}}s:8:\"settings\";a:1:{s:13:\"garland_width\";s:5:\"fluid\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:29:\"themes/garland/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:11:\"stylesheets\";a:2:{s:3:\"all\";a:1:{s:9:\"style.css\";s:24:\"themes/garland/style.css\";}s:5:\"print\";a:1:{s:9:\"print.css\";s:24:\"themes/garland/print.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}','block_admin_display','a:1:{i:0;s:7:\"garland\";}','',31,5,1,'admin/structure/block','admin/structure/block','Garland','t','','','a:0:{}',132,'','',0,'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/list/garland/add','','','user_access','a:1:{i:0;s:17:\"administer blocks\";}','drupal_get_form','a:1:{i:0;s:20:\"block_add_block_form\";}','',63,6,1,'admin/structure/block/list/garland','admin/structure/block','Add block','t','','','a:0:{}',388,'','',0,'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/list/seven','','','_block_themes_access','a:1:{i:0;O:8:\"stdClass\":11:{s:8:\"filename\";s:23:\"themes/seven/seven.info\";s:4:\"name\";s:5:\"seven\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:18:{s:4:\"name\";s:5:\"Seven\";s:11:\"description\";s:65:\"A simple one-column, tableless, fluid width administration theme.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:1:{s:6:\"screen\";a:2:{s:9:\"reset.css\";s:22:\"themes/seven/reset.css\";s:9:\"style.css\";s:22:\"themes/seven/style.css\";}}s:8:\"settings\";a:1:{s:20:\"shortcut_module_link\";s:1:\"1\";}s:7:\"regions\";a:8:{s:7:\"content\";s:7:\"Content\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:13:\"sidebar_first\";s:13:\"First sidebar\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:14:\"regions_hidden\";a:3:{i:0;s:13:\"sidebar_first\";i:1;s:8:\"page_top\";i:2;s:11:\"page_bottom\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:6:\"engine\";s:11:\"phptemplate\";s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:27:\"themes/seven/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:11:\"stylesheets\";a:1:{s:6:\"screen\";a:2:{s:9:\"reset.css\";s:22:\"themes/seven/reset.css\";s:9:\"style.css\";s:22:\"themes/seven/style.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}','block_admin_display','a:1:{i:0;s:5:\"seven\";}','',31,5,1,'admin/structure/block','admin/structure/block','Seven','t','','','a:0:{}',132,'','',0,'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/list/seven/add','','','user_access','a:1:{i:0;s:17:\"administer blocks\";}','drupal_get_form','a:1:{i:0;s:20:\"block_add_block_form\";}','',63,6,1,'admin/structure/block/list/seven','admin/structure/block','Add block','t','','','a:0:{}',388,'','',0,'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/list/stark','','','_block_themes_access','a:1:{i:0;O:8:\"stdClass\":11:{s:8:\"filename\";s:23:\"themes/stark/stark.info\";s:4:\"name\";s:5:\"stark\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"0\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:17:{s:4:\"name\";s:5:\"Stark\";s:11:\"description\";s:208:\"This theme demonstrates Drupal\'s default HTML markup and CSS styles. To learn how to build your own theme and override Drupal\'s default code, see the <a href=\"http://drupal.org/theme-guide\">Theming Guide</a>.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:10:\"layout.css\";s:23:\"themes/stark/layout.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:27:\"themes/stark/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:10:\"layout.css\";s:23:\"themes/stark/layout.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}','block_admin_display','a:1:{i:0;s:5:\"stark\";}','',31,5,1,'admin/structure/block','admin/structure/block','Stark','t','','','a:0:{}',132,'','',0,'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/list/stark/add','','','user_access','a:1:{i:0;s:17:\"administer blocks\";}','drupal_get_form','a:1:{i:0;s:20:\"block_add_block_form\";}','',63,6,1,'admin/structure/block/list/stark','admin/structure/block','Add block','t','','','a:0:{}',388,'','',0,'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/list/test_theme','','','_block_themes_access','a:1:{i:0;O:8:\"stdClass\":11:{s:8:\"filename\";s:39:\"themes/tests/test_theme/test_theme.info\";s:4:\"name\";s:10:\"test_theme\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"0\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:17:{s:4:\"name\";s:10:\"Test theme\";s:11:\"description\";s:34:\"Theme for testing the theme system\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:15:\"system.base.css\";s:39:\"themes/tests/test_theme/system.base.css\";}}s:7:\"version\";s:3:\"7.8\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:38:\"themes/tests/test_theme/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:15:\"system.base.css\";s:39:\"themes/tests/test_theme/system.base.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}','block_admin_display','a:1:{i:0;s:10:\"test_theme\";}','',31,5,1,'admin/structure/block','admin/structure/block','Test theme','t','','','a:0:{}',132,'','',0,'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/list/test_theme/add','','','user_access','a:1:{i:0;s:17:\"administer blocks\";}','drupal_get_form','a:1:{i:0;s:20:\"block_add_block_form\";}','',63,6,1,'admin/structure/block/list/test_theme','admin/structure/block','Add block','t','','','a:0:{}',388,'','',0,'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/list/update_test_basetheme','','','_block_themes_access','a:1:{i:0;O:8:\"stdClass\":10:{s:8:\"filename\";s:61:\"themes/tests/update_test_basetheme/update_test_basetheme.info\";s:4:\"name\";s:21:\"update_test_basetheme\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"0\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:17:{s:4:\"name\";s:22:\"Update test base theme\";s:11:\"description\";s:63:\"Test theme which acts as a base theme for other test subthemes.\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"version\";s:3:\"7.8\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:49:\"themes/tests/update_test_basetheme/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:11:\"stylesheets\";a:0:{}s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:6:\"engine\";s:11:\"phptemplate\";}}','block_admin_display','a:1:{i:0;s:21:\"update_test_basetheme\";}','',31,5,1,'admin/structure/block','admin/structure/block','Update test base theme','t','','','a:0:{}',132,'','',0,'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/list/update_test_basetheme/add','','','user_access','a:1:{i:0;s:17:\"administer blocks\";}','drupal_get_form','a:1:{i:0;s:20:\"block_add_block_form\";}','',63,6,1,'admin/structure/block/list/update_test_basetheme','admin/structure/block','Add block','t','','','a:0:{}',388,'','',0,'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/list/update_test_subtheme','','','_block_themes_access','a:1:{i:0;O:8:\"stdClass\":11:{s:8:\"filename\";s:59:\"themes/tests/update_test_subtheme/update_test_subtheme.info\";s:4:\"name\";s:20:\"update_test_subtheme\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"0\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:18:{s:4:\"name\";s:20:\"Update test subtheme\";s:11:\"description\";s:62:\"Test theme which uses update_test_basetheme as the base theme.\";s:4:\"core\";s:3:\"7.x\";s:10:\"base theme\";s:21:\"update_test_basetheme\";s:6:\"hidden\";b:1;s:7:\"version\";s:3:\"7.8\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:48:\"themes/tests/update_test_subtheme/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:11:\"stylesheets\";a:0:{}s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:6:\"engine\";s:11:\"phptemplate\";s:10:\"base_theme\";s:21:\"update_test_basetheme\";}}','block_admin_display','a:1:{i:0;s:20:\"update_test_subtheme\";}','',31,5,1,'admin/structure/block','admin/structure/block','Update test subtheme','t','','','a:0:{}',132,'','',0,'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/list/update_test_subtheme/add','','','user_access','a:1:{i:0;s:17:\"administer blocks\";}','drupal_get_form','a:1:{i:0;s:20:\"block_add_block_form\";}','',63,6,1,'admin/structure/block/list/update_test_subtheme','admin/structure/block','Add block','t','','','a:0:{}',388,'','',0,'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/manage/%/%','a:2:{i:4;N;i:5;N;}','','user_access','a:1:{i:0;s:17:\"administer blocks\";}','drupal_get_form','a:3:{i:0;s:21:\"block_admin_configure\";i:1;i:4;i:2;i:5;}','',60,6,0,'','admin/structure/block/manage/%/%','Configure block','t','','','a:0:{}',6,'','',0,'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/manage/%/%/configure','a:2:{i:4;N;i:5;N;}','','user_access','a:1:{i:0;s:17:\"administer blocks\";}','drupal_get_form','a:3:{i:0;s:21:\"block_admin_configure\";i:1;i:4;i:2;i:5;}','',121,7,2,'admin/structure/block/manage/%/%','admin/structure/block/manage/%/%','Configure block','t','','','a:0:{}',140,'','',0,'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/manage/%/%/delete','a:2:{i:4;N;i:5;N;}','','user_access','a:1:{i:0;s:17:\"administer blocks\";}','drupal_get_form','a:3:{i:0;s:25:\"block_custom_block_delete\";i:1;i:4;i:2;i:5;}','',121,7,0,'admin/structure/block/manage/%/%','admin/structure/block/manage/%/%','Delete block','t','','','a:0:{}',132,'','',0,'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/menu','','','user_access','a:1:{i:0;s:15:\"administer menu\";}','menu_overview_page','a:0:{}','',7,3,0,'','admin/structure/menu','Menus','t','','','a:0:{}',6,'Add new menus to your site, edit existing menus, and rename and reorganize menu links.','',0,'modules/menu/menu.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/menu/add','','','user_access','a:1:{i:0;s:15:\"administer menu\";}','drupal_get_form','a:2:{i:0;s:14:\"menu_edit_menu\";i:1;s:3:\"add\";}','',15,4,1,'admin/structure/menu','admin/structure/menu','Add menu','t','','','a:0:{}',388,'','',0,'modules/menu/menu.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/menu/item/%/delete','a:1:{i:4;s:14:\"menu_link_load\";}','','user_access','a:1:{i:0;s:15:\"administer menu\";}','menu_item_delete_page','a:1:{i:0;i:4;}','',61,6,0,'','admin/structure/menu/item/%/delete','Delete menu link','t','','','a:0:{}',6,'','',0,'modules/menu/menu.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/menu/item/%/edit','a:1:{i:4;s:14:\"menu_link_load\";}','','user_access','a:1:{i:0;s:15:\"administer menu\";}','drupal_get_form','a:4:{i:0;s:14:\"menu_edit_item\";i:1;s:4:\"edit\";i:2;i:4;i:3;N;}','',61,6,0,'','admin/structure/menu/item/%/edit','Edit menu link','t','','','a:0:{}',6,'','',0,'modules/menu/menu.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/menu/item/%/reset','a:1:{i:4;s:14:\"menu_link_load\";}','','user_access','a:1:{i:0;s:15:\"administer menu\";}','drupal_get_form','a:2:{i:0;s:23:\"menu_reset_item_confirm\";i:1;i:4;}','',61,6,0,'','admin/structure/menu/item/%/reset','Reset menu link','t','','','a:0:{}',6,'','',0,'modules/menu/menu.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/menu/list','','','user_access','a:1:{i:0;s:15:\"administer menu\";}','menu_overview_page','a:0:{}','',15,4,1,'admin/structure/menu','admin/structure/menu','List menus','t','','','a:0:{}',140,'','',-10,'modules/menu/menu.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/menu/manage/%','a:1:{i:4;s:9:\"menu_load\";}','','user_access','a:1:{i:0;s:15:\"administer menu\";}','drupal_get_form','a:2:{i:0;s:18:\"menu_overview_form\";i:1;i:4;}','',30,5,0,'','admin/structure/menu/manage/%','Customize menu','menu_overview_title','a:1:{i:0;i:4;}','','a:0:{}',6,'','',0,'modules/menu/menu.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/menu/manage/%/add','a:1:{i:4;s:9:\"menu_load\";}','','user_access','a:1:{i:0;s:15:\"administer menu\";}','drupal_get_form','a:4:{i:0;s:14:\"menu_edit_item\";i:1;s:3:\"add\";i:2;N;i:3;i:4;}','',61,6,1,'admin/structure/menu/manage/%','admin/structure/menu/manage/%','Add link','t','','','a:0:{}',388,'','',0,'modules/menu/menu.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/menu/manage/%/delete','a:1:{i:4;s:9:\"menu_load\";}','','user_access','a:1:{i:0;s:15:\"administer menu\";}','menu_delete_menu_page','a:1:{i:0;i:4;}','',61,6,0,'','admin/structure/menu/manage/%/delete','Delete menu','t','','','a:0:{}',6,'','',0,'modules/menu/menu.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/menu/manage/%/edit','a:1:{i:4;s:9:\"menu_load\";}','','user_access','a:1:{i:0;s:15:\"administer menu\";}','drupal_get_form','a:3:{i:0;s:14:\"menu_edit_menu\";i:1;s:4:\"edit\";i:2;i:4;}','',61,6,3,'admin/structure/menu/manage/%','admin/structure/menu/manage/%','Edit menu','t','','','a:0:{}',132,'','',0,'modules/menu/menu.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/menu/manage/%/list','a:1:{i:4;s:9:\"menu_load\";}','','user_access','a:1:{i:0;s:15:\"administer menu\";}','drupal_get_form','a:2:{i:0;s:18:\"menu_overview_form\";i:1;i:4;}','',61,6,3,'admin/structure/menu/manage/%','admin/structure/menu/manage/%','List links','t','','','a:0:{}',140,'','',-10,'modules/menu/menu.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/menu/parents','','','user_access','a:1:{i:0;b:1;}','menu_parent_options_js','a:0:{}','',15,4,0,'','admin/structure/menu/parents','Parent menu items','t','','','a:0:{}',0,'','',0,'');
INSERT INTO `menu_router` VALUES ('admin/structure/menu/settings','','','user_access','a:1:{i:0;s:15:\"administer menu\";}','drupal_get_form','a:1:{i:0;s:14:\"menu_configure\";}','',15,4,1,'admin/structure/menu','admin/structure/menu','Settings','t','','','a:0:{}',132,'','',5,'modules/menu/menu.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy','','','user_access','a:1:{i:0;s:19:\"administer taxonomy\";}','drupal_get_form','a:1:{i:0;s:30:\"taxonomy_overview_vocabularies\";}','',7,3,0,'','admin/structure/taxonomy','Taxonomy','t','','','a:0:{}',6,'Manage tagging, categorization, and classification of your content.','',0,'modules/taxonomy/taxonomy.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy/%','a:1:{i:3;s:37:\"taxonomy_vocabulary_machine_name_load\";}','','user_access','a:1:{i:0;s:19:\"administer taxonomy\";}','drupal_get_form','a:2:{i:0;s:23:\"taxonomy_overview_terms\";i:1;i:3;}','',14,4,0,'','admin/structure/taxonomy/%','','taxonomy_admin_vocabulary_title_callback','a:1:{i:0;i:3;}','','a:0:{}',6,'','',0,'modules/taxonomy/taxonomy.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy/%/add','a:1:{i:3;s:37:\"taxonomy_vocabulary_machine_name_load\";}','','user_access','a:1:{i:0;s:19:\"administer taxonomy\";}','drupal_get_form','a:3:{i:0;s:18:\"taxonomy_form_term\";i:1;a:0:{}i:2;i:3;}','',29,5,1,'admin/structure/taxonomy/%','admin/structure/taxonomy/%','Add term','t','','','a:0:{}',388,'','',0,'modules/taxonomy/taxonomy.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy/%/display','a:1:{i:3;s:37:\"taxonomy_vocabulary_machine_name_load\";}','','user_access','a:1:{i:0;s:19:\"administer taxonomy\";}','drupal_get_form','a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:13:\"taxonomy_term\";i:2;i:3;i:3;s:7:\"default\";}','',29,5,1,'admin/structure/taxonomy/%','admin/structure/taxonomy/%','Manage display','t','','','a:0:{}',132,'','',2,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy/%/display/default','a:1:{i:3;s:37:\"taxonomy_vocabulary_machine_name_load\";}','','_field_ui_view_mode_menu_access','a:5:{i:0;s:13:\"taxonomy_term\";i:1;i:3;i:2;s:7:\"default\";i:3;s:11:\"user_access\";i:4;s:19:\"administer taxonomy\";}','drupal_get_form','a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:13:\"taxonomy_term\";i:2;i:3;i:3;s:7:\"default\";}','',59,6,1,'admin/structure/taxonomy/%/display','admin/structure/taxonomy/%','Default','t','','','a:0:{}',140,'','',-10,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy/%/display/full','a:1:{i:3;s:37:\"taxonomy_vocabulary_machine_name_load\";}','','_field_ui_view_mode_menu_access','a:5:{i:0;s:13:\"taxonomy_term\";i:1;i:3;i:2;s:4:\"full\";i:3;s:11:\"user_access\";i:4;s:19:\"administer taxonomy\";}','drupal_get_form','a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:13:\"taxonomy_term\";i:2;i:3;i:3;s:4:\"full\";}','',59,6,1,'admin/structure/taxonomy/%/display','admin/structure/taxonomy/%','Taxonomy term page','t','','','a:0:{}',132,'','',0,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy/%/edit','a:1:{i:3;s:37:\"taxonomy_vocabulary_machine_name_load\";}','','user_access','a:1:{i:0;s:19:\"administer taxonomy\";}','drupal_get_form','a:2:{i:0;s:24:\"taxonomy_form_vocabulary\";i:1;i:3;}','',29,5,1,'admin/structure/taxonomy/%','admin/structure/taxonomy/%','Edit','t','','','a:0:{}',132,'','',-10,'modules/taxonomy/taxonomy.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy/%/fields','a:1:{i:3;s:37:\"taxonomy_vocabulary_machine_name_load\";}','','user_access','a:1:{i:0;s:19:\"administer taxonomy\";}','drupal_get_form','a:3:{i:0;s:28:\"field_ui_field_overview_form\";i:1;s:13:\"taxonomy_term\";i:2;i:3;}','',29,5,1,'admin/structure/taxonomy/%','admin/structure/taxonomy/%','Manage fields','t','','','a:0:{}',132,'','',1,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy/%/fields/%','a:2:{i:3;a:1:{s:37:\"taxonomy_vocabulary_machine_name_load\";a:4:{i:0;s:13:\"taxonomy_term\";i:1;i:3;i:2;s:1:\"3\";i:3;s:4:\"%map\";}}i:5;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:13:\"taxonomy_term\";i:1;i:3;i:2;s:1:\"3\";i:3;s:4:\"%map\";}}}','','user_access','a:1:{i:0;s:19:\"administer taxonomy\";}','drupal_get_form','a:2:{i:0;s:24:\"field_ui_field_edit_form\";i:1;i:5;}','',58,6,0,'','admin/structure/taxonomy/%/fields/%','','field_ui_menu_title','a:1:{i:0;i:5;}','','a:0:{}',6,'','',0,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy/%/fields/%/delete','a:2:{i:3;a:1:{s:37:\"taxonomy_vocabulary_machine_name_load\";a:4:{i:0;s:13:\"taxonomy_term\";i:1;i:3;i:2;s:1:\"3\";i:3;s:4:\"%map\";}}i:5;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:13:\"taxonomy_term\";i:1;i:3;i:2;s:1:\"3\";i:3;s:4:\"%map\";}}}','','user_access','a:1:{i:0;s:19:\"administer taxonomy\";}','drupal_get_form','a:2:{i:0;s:26:\"field_ui_field_delete_form\";i:1;i:5;}','',117,7,1,'admin/structure/taxonomy/%/fields/%','admin/structure/taxonomy/%/fields/%','Delete','t','','','a:0:{}',132,'','',10,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy/%/fields/%/edit','a:2:{i:3;a:1:{s:37:\"taxonomy_vocabulary_machine_name_load\";a:4:{i:0;s:13:\"taxonomy_term\";i:1;i:3;i:2;s:1:\"3\";i:3;s:4:\"%map\";}}i:5;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:13:\"taxonomy_term\";i:1;i:3;i:2;s:1:\"3\";i:3;s:4:\"%map\";}}}','','user_access','a:1:{i:0;s:19:\"administer taxonomy\";}','drupal_get_form','a:2:{i:0;s:24:\"field_ui_field_edit_form\";i:1;i:5;}','',117,7,1,'admin/structure/taxonomy/%/fields/%','admin/structure/taxonomy/%/fields/%','Edit','t','','','a:0:{}',140,'','',0,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy/%/fields/%/field-settings','a:2:{i:3;a:1:{s:37:\"taxonomy_vocabulary_machine_name_load\";a:4:{i:0;s:13:\"taxonomy_term\";i:1;i:3;i:2;s:1:\"3\";i:3;s:4:\"%map\";}}i:5;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:13:\"taxonomy_term\";i:1;i:3;i:2;s:1:\"3\";i:3;s:4:\"%map\";}}}','','user_access','a:1:{i:0;s:19:\"administer taxonomy\";}','drupal_get_form','a:2:{i:0;s:28:\"field_ui_field_settings_form\";i:1;i:5;}','',117,7,1,'admin/structure/taxonomy/%/fields/%','admin/structure/taxonomy/%/fields/%','Field settings','t','','','a:0:{}',132,'','',0,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy/%/fields/%/widget-type','a:2:{i:3;a:1:{s:37:\"taxonomy_vocabulary_machine_name_load\";a:4:{i:0;s:13:\"taxonomy_term\";i:1;i:3;i:2;s:1:\"3\";i:3;s:4:\"%map\";}}i:5;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:13:\"taxonomy_term\";i:1;i:3;i:2;s:1:\"3\";i:3;s:4:\"%map\";}}}','','user_access','a:1:{i:0;s:19:\"administer taxonomy\";}','drupal_get_form','a:2:{i:0;s:25:\"field_ui_widget_type_form\";i:1;i:5;}','',117,7,1,'admin/structure/taxonomy/%/fields/%','admin/structure/taxonomy/%/fields/%','Widget type','t','','','a:0:{}',132,'','',0,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy/%/list','a:1:{i:3;s:37:\"taxonomy_vocabulary_machine_name_load\";}','','user_access','a:1:{i:0;s:19:\"administer taxonomy\";}','drupal_get_form','a:2:{i:0;s:23:\"taxonomy_overview_terms\";i:1;i:3;}','',29,5,1,'admin/structure/taxonomy/%','admin/structure/taxonomy/%','List','t','','','a:0:{}',140,'','',-20,'modules/taxonomy/taxonomy.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy/add','','','user_access','a:1:{i:0;s:19:\"administer taxonomy\";}','drupal_get_form','a:1:{i:0;s:24:\"taxonomy_form_vocabulary\";}','',15,4,1,'admin/structure/taxonomy','admin/structure/taxonomy','Add vocabulary','t','','','a:0:{}',388,'','',0,'modules/taxonomy/taxonomy.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy/list','','','user_access','a:1:{i:0;s:19:\"administer taxonomy\";}','drupal_get_form','a:1:{i:0;s:30:\"taxonomy_overview_vocabularies\";}','',15,4,1,'admin/structure/taxonomy','admin/structure/taxonomy','List','t','','','a:0:{}',140,'','',-10,'modules/taxonomy/taxonomy.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types','','','user_access','a:1:{i:0;s:24:\"administer content types\";}','node_overview_types','a:0:{}','',7,3,0,'','admin/structure/types','Content types','t','','','a:0:{}',6,'Manage content types, including default status, front page promotion, comment settings, etc.','',0,'modules/node/content_types.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/add','','','user_access','a:1:{i:0;s:24:\"administer content types\";}','drupal_get_form','a:1:{i:0;s:14:\"node_type_form\";}','',15,4,1,'admin/structure/types','admin/structure/types','Add content type','t','','','a:0:{}',388,'','',0,'modules/node/content_types.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/list','','','user_access','a:1:{i:0;s:24:\"administer content types\";}','node_overview_types','a:0:{}','',15,4,1,'admin/structure/types','admin/structure/types','List','t','','','a:0:{}',140,'','',-10,'modules/node/content_types.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%','a:1:{i:4;s:14:\"node_type_load\";}','','user_access','a:1:{i:0;s:24:\"administer content types\";}','drupal_get_form','a:2:{i:0;s:14:\"node_type_form\";i:1;i:4;}','',30,5,0,'','admin/structure/types/manage/%','Edit content type','node_type_page_title','a:1:{i:0;i:4;}','','a:0:{}',6,'','',0,'modules/node/content_types.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/comment/display','a:1:{i:4;s:22:\"comment_node_type_load\";}','','user_access','a:1:{i:0;s:24:\"administer content types\";}','drupal_get_form','a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:7:\"comment\";i:2;i:4;i:3;s:7:\"default\";}','',123,7,1,'admin/structure/types/manage/%','admin/structure/types/manage/%','Comment display','t','','','a:0:{}',132,'','',4,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/comment/display/default','a:1:{i:4;s:22:\"comment_node_type_load\";}','','_field_ui_view_mode_menu_access','a:5:{i:0;s:7:\"comment\";i:1;i:4;i:2;s:7:\"default\";i:3;s:11:\"user_access\";i:4;s:24:\"administer content types\";}','drupal_get_form','a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:7:\"comment\";i:2;i:4;i:3;s:7:\"default\";}','',247,8,1,'admin/structure/types/manage/%/comment/display','admin/structure/types/manage/%','Default','t','','','a:0:{}',140,'','',-10,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/comment/display/full','a:1:{i:4;s:22:\"comment_node_type_load\";}','','_field_ui_view_mode_menu_access','a:5:{i:0;s:7:\"comment\";i:1;i:4;i:2;s:4:\"full\";i:3;s:11:\"user_access\";i:4;s:24:\"administer content types\";}','drupal_get_form','a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:7:\"comment\";i:2;i:4;i:3;s:4:\"full\";}','',247,8,1,'admin/structure/types/manage/%/comment/display','admin/structure/types/manage/%','Full comment','t','','','a:0:{}',132,'','',0,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/comment/fields','a:1:{i:4;s:22:\"comment_node_type_load\";}','','user_access','a:1:{i:0;s:24:\"administer content types\";}','drupal_get_form','a:3:{i:0;s:28:\"field_ui_field_overview_form\";i:1;s:7:\"comment\";i:2;i:4;}','',123,7,1,'admin/structure/types/manage/%','admin/structure/types/manage/%','Comment fields','t','','','a:0:{}',132,'','',3,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/comment/fields/%','a:2:{i:4;a:1:{s:22:\"comment_node_type_load\";a:4:{i:0;s:7:\"comment\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}i:7;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:7:\"comment\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}}','','user_access','a:1:{i:0;s:24:\"administer content types\";}','drupal_get_form','a:2:{i:0;s:24:\"field_ui_field_edit_form\";i:1;i:7;}','',246,8,0,'','admin/structure/types/manage/%/comment/fields/%','','field_ui_menu_title','a:1:{i:0;i:7;}','','a:0:{}',6,'','',0,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/comment/fields/%/delete','a:2:{i:4;a:1:{s:22:\"comment_node_type_load\";a:4:{i:0;s:7:\"comment\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}i:7;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:7:\"comment\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}}','','user_access','a:1:{i:0;s:24:\"administer content types\";}','drupal_get_form','a:2:{i:0;s:26:\"field_ui_field_delete_form\";i:1;i:7;}','',493,9,1,'admin/structure/types/manage/%/comment/fields/%','admin/structure/types/manage/%/comment/fields/%','Delete','t','','','a:0:{}',132,'','',10,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/comment/fields/%/edit','a:2:{i:4;a:1:{s:22:\"comment_node_type_load\";a:4:{i:0;s:7:\"comment\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}i:7;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:7:\"comment\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}}','','user_access','a:1:{i:0;s:24:\"administer content types\";}','drupal_get_form','a:2:{i:0;s:24:\"field_ui_field_edit_form\";i:1;i:7;}','',493,9,1,'admin/structure/types/manage/%/comment/fields/%','admin/structure/types/manage/%/comment/fields/%','Edit','t','','','a:0:{}',140,'','',0,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/comment/fields/%/field-settings','a:2:{i:4;a:1:{s:22:\"comment_node_type_load\";a:4:{i:0;s:7:\"comment\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}i:7;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:7:\"comment\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}}','','user_access','a:1:{i:0;s:24:\"administer content types\";}','drupal_get_form','a:2:{i:0;s:28:\"field_ui_field_settings_form\";i:1;i:7;}','',493,9,1,'admin/structure/types/manage/%/comment/fields/%','admin/structure/types/manage/%/comment/fields/%','Field settings','t','','','a:0:{}',132,'','',0,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/comment/fields/%/widget-type','a:2:{i:4;a:1:{s:22:\"comment_node_type_load\";a:4:{i:0;s:7:\"comment\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}i:7;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:7:\"comment\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}}','','user_access','a:1:{i:0;s:24:\"administer content types\";}','drupal_get_form','a:2:{i:0;s:25:\"field_ui_widget_type_form\";i:1;i:7;}','',493,9,1,'admin/structure/types/manage/%/comment/fields/%','admin/structure/types/manage/%/comment/fields/%','Widget type','t','','','a:0:{}',132,'','',0,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/delete','a:1:{i:4;s:14:\"node_type_load\";}','','user_access','a:1:{i:0;s:24:\"administer content types\";}','drupal_get_form','a:2:{i:0;s:24:\"node_type_delete_confirm\";i:1;i:4;}','',61,6,0,'','admin/structure/types/manage/%/delete','Delete','t','','','a:0:{}',6,'','',0,'modules/node/content_types.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/display','a:1:{i:4;s:14:\"node_type_load\";}','','user_access','a:1:{i:0;s:24:\"administer content types\";}','drupal_get_form','a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:4:\"node\";i:2;i:4;i:3;s:7:\"default\";}','',61,6,1,'admin/structure/types/manage/%','admin/structure/types/manage/%','Manage display','t','','','a:0:{}',132,'','',2,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/display/default','a:1:{i:4;s:14:\"node_type_load\";}','','_field_ui_view_mode_menu_access','a:5:{i:0;s:4:\"node\";i:1;i:4;i:2;s:7:\"default\";i:3;s:11:\"user_access\";i:4;s:24:\"administer content types\";}','drupal_get_form','a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:4:\"node\";i:2;i:4;i:3;s:7:\"default\";}','',123,7,1,'admin/structure/types/manage/%/display','admin/structure/types/manage/%','Default','t','','','a:0:{}',140,'','',-10,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/display/full','a:1:{i:4;s:14:\"node_type_load\";}','','_field_ui_view_mode_menu_access','a:5:{i:0;s:4:\"node\";i:1;i:4;i:2;s:4:\"full\";i:3;s:11:\"user_access\";i:4;s:24:\"administer content types\";}','drupal_get_form','a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:4:\"node\";i:2;i:4;i:3;s:4:\"full\";}','',123,7,1,'admin/structure/types/manage/%/display','admin/structure/types/manage/%','Full content','t','','','a:0:{}',132,'','',0,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/display/rss','a:1:{i:4;s:14:\"node_type_load\";}','','_field_ui_view_mode_menu_access','a:5:{i:0;s:4:\"node\";i:1;i:4;i:2;s:3:\"rss\";i:3;s:11:\"user_access\";i:4;s:24:\"administer content types\";}','drupal_get_form','a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:4:\"node\";i:2;i:4;i:3;s:3:\"rss\";}','',123,7,1,'admin/structure/types/manage/%/display','admin/structure/types/manage/%','RSS','t','','','a:0:{}',132,'','',2,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/display/search_index','a:1:{i:4;s:14:\"node_type_load\";}','','_field_ui_view_mode_menu_access','a:5:{i:0;s:4:\"node\";i:1;i:4;i:2;s:12:\"search_index\";i:3;s:11:\"user_access\";i:4;s:24:\"administer content types\";}','drupal_get_form','a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:4:\"node\";i:2;i:4;i:3;s:12:\"search_index\";}','',123,7,1,'admin/structure/types/manage/%/display','admin/structure/types/manage/%','Search index','t','','','a:0:{}',132,'','',3,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/display/search_result','a:1:{i:4;s:14:\"node_type_load\";}','','_field_ui_view_mode_menu_access','a:5:{i:0;s:4:\"node\";i:1;i:4;i:2;s:13:\"search_result\";i:3;s:11:\"user_access\";i:4;s:24:\"administer content types\";}','drupal_get_form','a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:4:\"node\";i:2;i:4;i:3;s:13:\"search_result\";}','',123,7,1,'admin/structure/types/manage/%/display','admin/structure/types/manage/%','Search result','t','','','a:0:{}',132,'','',4,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/display/teaser','a:1:{i:4;s:14:\"node_type_load\";}','','_field_ui_view_mode_menu_access','a:5:{i:0;s:4:\"node\";i:1;i:4;i:2;s:6:\"teaser\";i:3;s:11:\"user_access\";i:4;s:24:\"administer content types\";}','drupal_get_form','a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:4:\"node\";i:2;i:4;i:3;s:6:\"teaser\";}','',123,7,1,'admin/structure/types/manage/%/display','admin/structure/types/manage/%','Teaser','t','','','a:0:{}',132,'','',1,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/edit','a:1:{i:4;s:14:\"node_type_load\";}','','user_access','a:1:{i:0;s:24:\"administer content types\";}','drupal_get_form','a:2:{i:0;s:14:\"node_type_form\";i:1;i:4;}','',61,6,1,'admin/structure/types/manage/%','admin/structure/types/manage/%','Edit','t','','','a:0:{}',140,'','',0,'modules/node/content_types.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/fields','a:1:{i:4;s:14:\"node_type_load\";}','','user_access','a:1:{i:0;s:24:\"administer content types\";}','drupal_get_form','a:3:{i:0;s:28:\"field_ui_field_overview_form\";i:1;s:4:\"node\";i:2;i:4;}','',61,6,1,'admin/structure/types/manage/%','admin/structure/types/manage/%','Manage fields','t','','','a:0:{}',132,'','',1,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/fields/%','a:2:{i:4;a:1:{s:14:\"node_type_load\";a:4:{i:0;s:4:\"node\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}i:6;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:4:\"node\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}}','','user_access','a:1:{i:0;s:24:\"administer content types\";}','drupal_get_form','a:2:{i:0;s:24:\"field_ui_field_edit_form\";i:1;i:6;}','',122,7,0,'','admin/structure/types/manage/%/fields/%','','field_ui_menu_title','a:1:{i:0;i:6;}','','a:0:{}',6,'','',0,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/fields/%/delete','a:2:{i:4;a:1:{s:14:\"node_type_load\";a:4:{i:0;s:4:\"node\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}i:6;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:4:\"node\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}}','','user_access','a:1:{i:0;s:24:\"administer content types\";}','drupal_get_form','a:2:{i:0;s:26:\"field_ui_field_delete_form\";i:1;i:6;}','',245,8,1,'admin/structure/types/manage/%/fields/%','admin/structure/types/manage/%/fields/%','Delete','t','','','a:0:{}',132,'','',10,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/fields/%/edit','a:2:{i:4;a:1:{s:14:\"node_type_load\";a:4:{i:0;s:4:\"node\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}i:6;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:4:\"node\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}}','','user_access','a:1:{i:0;s:24:\"administer content types\";}','drupal_get_form','a:2:{i:0;s:24:\"field_ui_field_edit_form\";i:1;i:6;}','',245,8,1,'admin/structure/types/manage/%/fields/%','admin/structure/types/manage/%/fields/%','Edit','t','','','a:0:{}',140,'','',0,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/fields/%/field-settings','a:2:{i:4;a:1:{s:14:\"node_type_load\";a:4:{i:0;s:4:\"node\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}i:6;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:4:\"node\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}}','','user_access','a:1:{i:0;s:24:\"administer content types\";}','drupal_get_form','a:2:{i:0;s:28:\"field_ui_field_settings_form\";i:1;i:6;}','',245,8,1,'admin/structure/types/manage/%/fields/%','admin/structure/types/manage/%/fields/%','Field settings','t','','','a:0:{}',132,'','',0,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/fields/%/widget-type','a:2:{i:4;a:1:{s:14:\"node_type_load\";a:4:{i:0;s:4:\"node\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}i:6;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:4:\"node\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}}','','user_access','a:1:{i:0;s:24:\"administer content types\";}','drupal_get_form','a:2:{i:0;s:25:\"field_ui_widget_type_form\";i:1;i:6;}','',245,8,1,'admin/structure/types/manage/%/fields/%','admin/structure/types/manage/%/fields/%','Widget type','t','','','a:0:{}',132,'','',0,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/tasks','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_menu_block_page','a:0:{}','',3,2,1,'admin','admin','Tasks','t','','','a:0:{}',140,'','',-20,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('batch','','','1','a:0:{}','system_batch_page','a:0:{}','',1,1,0,'','batch','','t','','_system_batch_theme','a:0:{}',0,'','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('comment/%','a:1:{i:1;N;}','','user_access','a:1:{i:0;s:15:\"access comments\";}','comment_permalink','a:1:{i:0;i:1;}','',2,2,0,'','comment/%','Comment permalink','t','','','a:0:{}',6,'','',0,'');
INSERT INTO `menu_router` VALUES ('comment/%/approve','a:1:{i:1;N;}','','user_access','a:1:{i:0;s:19:\"administer comments\";}','comment_approve','a:1:{i:0;i:1;}','',5,3,0,'','comment/%/approve','Approve','t','','','a:0:{}',6,'','',1,'modules/comment/comment.pages.inc');
INSERT INTO `menu_router` VALUES ('comment/%/delete','a:1:{i:1;N;}','','user_access','a:1:{i:0;s:19:\"administer comments\";}','comment_confirm_delete_page','a:1:{i:0;i:1;}','',5,3,1,'comment/%','comment/%','Delete','t','','','a:0:{}',132,'','',2,'modules/comment/comment.admin.inc');
INSERT INTO `menu_router` VALUES ('comment/%/edit','a:1:{i:1;s:12:\"comment_load\";}','','comment_access','a:2:{i:0;s:4:\"edit\";i:1;i:1;}','comment_edit_page','a:1:{i:0;i:1;}','',5,3,1,'comment/%','comment/%','Edit','t','','','a:0:{}',132,'','',0,'');
INSERT INTO `menu_router` VALUES ('comment/%/view','a:1:{i:1;N;}','','user_access','a:1:{i:0;s:15:\"access comments\";}','comment_permalink','a:1:{i:0;i:1;}','',5,3,1,'comment/%','comment/%','View comment','t','','','a:0:{}',140,'','',-10,'');
INSERT INTO `menu_router` VALUES ('comment/reply/%','a:1:{i:2;s:9:\"node_load\";}','','node_access','a:2:{i:0;s:4:\"view\";i:1;i:2;}','comment_reply','a:1:{i:0;i:2;}','',6,3,0,'','comment/reply/%','Add new comment','t','','','a:0:{}',6,'','',0,'modules/comment/comment.pages.inc');
INSERT INTO `menu_router` VALUES ('file/ajax','','','user_access','a:1:{i:0;s:14:\"access content\";}','file_ajax_upload','a:0:{}','ajax_deliver',3,2,0,'','file/ajax','','t','','ajax_base_page_theme','a:0:{}',0,'','',0,'');
INSERT INTO `menu_router` VALUES ('file/progress','','','user_access','a:1:{i:0;s:14:\"access content\";}','file_ajax_progress','a:0:{}','ajax_deliver',3,2,0,'','file/progress','','t','','ajax_base_page_theme','a:0:{}',0,'','',0,'');
INSERT INTO `menu_router` VALUES ('filter/tips','','','1','a:0:{}','filter_tips_long','a:0:{}','',3,2,0,'','filter/tips','Compose tips','t','','','a:0:{}',20,'','',0,'modules/filter/filter.pages.inc');
INSERT INTO `menu_router` VALUES ('node','','','user_access','a:1:{i:0;s:14:\"access content\";}','node_page_default','a:0:{}','',1,1,0,'','node','','t','','','a:0:{}',0,'','',0,'');
INSERT INTO `menu_router` VALUES ('node/%','a:1:{i:1;s:9:\"node_load\";}','','node_access','a:2:{i:0;s:4:\"view\";i:1;i:1;}','node_page_view','a:1:{i:0;i:1;}','',2,2,0,'','node/%','','node_page_title','a:1:{i:0;i:1;}','','a:0:{}',6,'','',0,'');
INSERT INTO `menu_router` VALUES ('node/%/delete','a:1:{i:1;s:9:\"node_load\";}','','node_access','a:2:{i:0;s:6:\"delete\";i:1;i:1;}','drupal_get_form','a:2:{i:0;s:19:\"node_delete_confirm\";i:1;i:1;}','',5,3,2,'node/%','node/%','Delete','t','','','a:0:{}',132,'','',1,'modules/node/node.pages.inc');
INSERT INTO `menu_router` VALUES ('node/%/edit','a:1:{i:1;s:9:\"node_load\";}','','node_access','a:2:{i:0;s:6:\"update\";i:1;i:1;}','node_page_edit','a:1:{i:0;i:1;}','',5,3,3,'node/%','node/%','Edit','t','','','a:0:{}',132,'','',0,'modules/node/node.pages.inc');
INSERT INTO `menu_router` VALUES ('node/%/revisions','a:1:{i:1;s:9:\"node_load\";}','','_node_revision_access','a:1:{i:0;i:1;}','node_revision_overview','a:1:{i:0;i:1;}','',5,3,1,'node/%','node/%','Revisions','t','','','a:0:{}',132,'','',2,'modules/node/node.pages.inc');
INSERT INTO `menu_router` VALUES ('node/%/revisions/%/delete','a:2:{i:1;a:1:{s:9:\"node_load\";a:1:{i:0;i:3;}}i:3;N;}','','_node_revision_access','a:2:{i:0;i:1;i:1;s:6:\"delete\";}','drupal_get_form','a:2:{i:0;s:28:\"node_revision_delete_confirm\";i:1;i:1;}','',21,5,0,'','node/%/revisions/%/delete','Delete earlier revision','t','','','a:0:{}',6,'','',0,'modules/node/node.pages.inc');
INSERT INTO `menu_router` VALUES ('node/%/revisions/%/revert','a:2:{i:1;a:1:{s:9:\"node_load\";a:1:{i:0;i:3;}}i:3;N;}','','_node_revision_access','a:2:{i:0;i:1;i:1;s:6:\"update\";}','drupal_get_form','a:2:{i:0;s:28:\"node_revision_revert_confirm\";i:1;i:1;}','',21,5,0,'','node/%/revisions/%/revert','Revert to earlier revision','t','','','a:0:{}',6,'','',0,'modules/node/node.pages.inc');
INSERT INTO `menu_router` VALUES ('node/%/revisions/%/view','a:2:{i:1;a:1:{s:9:\"node_load\";a:1:{i:0;i:3;}}i:3;N;}','','_node_revision_access','a:1:{i:0;i:1;}','node_show','a:2:{i:0;i:1;i:1;b:1;}','',21,5,0,'','node/%/revisions/%/view','Revisions','t','','','a:0:{}',6,'','',0,'');
INSERT INTO `menu_router` VALUES ('node/%/view','a:1:{i:1;s:9:\"node_load\";}','','node_access','a:2:{i:0;s:4:\"view\";i:1;i:1;}','node_page_view','a:1:{i:0;i:1;}','',5,3,1,'node/%','node/%','View','t','','','a:0:{}',140,'','',-10,'');
INSERT INTO `menu_router` VALUES ('node/add','','','_node_add_access','a:0:{}','node_add_page','a:0:{}','',3,2,0,'','node/add','Add content','t','','','a:0:{}',6,'','',0,'modules/node/node.pages.inc');
INSERT INTO `menu_router` VALUES ('node/add/article','','','node_access','a:2:{i:0;s:6:\"create\";i:1;s:7:\"article\";}','node_add','a:1:{i:0;s:7:\"article\";}','',7,3,0,'','node/add/article','Article','check_plain','','','a:0:{}',6,'Use <em>articles</em> for time-sensitive content like news, press releases or blog posts.','',0,'modules/node/node.pages.inc');
INSERT INTO `menu_router` VALUES ('node/add/page','','','node_access','a:2:{i:0;s:6:\"create\";i:1;s:4:\"page\";}','node_add','a:1:{i:0;s:4:\"page\";}','',7,3,0,'','node/add/page','Basic page','check_plain','','','a:0:{}',6,'Use <em>basic pages</em> for your static content, such as an \'About us\' page.','',0,'modules/node/node.pages.inc');
INSERT INTO `menu_router` VALUES ('overlay-ajax/%','a:1:{i:1;N;}','','user_access','a:1:{i:0;s:14:\"access overlay\";}','overlay_ajax_render_region','a:1:{i:0;i:1;}','',2,2,0,'','overlay-ajax/%','','t','','','a:0:{}',0,'','',0,'');
INSERT INTO `menu_router` VALUES ('overlay/dismiss-message','','','user_access','a:1:{i:0;s:14:\"access overlay\";}','overlay_user_dismiss_message','a:0:{}','',3,2,0,'','overlay/dismiss-message','','t','','','a:0:{}',0,'','',0,'');
INSERT INTO `menu_router` VALUES ('rss.xml','','','user_access','a:1:{i:0;s:14:\"access content\";}','node_feed','a:0:{}','',1,1,0,'','rss.xml','RSS feed','t','','','a:0:{}',0,'','',0,'');
INSERT INTO `menu_router` VALUES ('search','','','search_is_active','a:0:{}','search_view','a:0:{}','',1,1,0,'','search','Search','t','','','a:0:{}',20,'','',0,'modules/search/search.pages.inc');
INSERT INTO `menu_router` VALUES ('search/node','','','_search_menu_access','a:1:{i:0;s:4:\"node\";}','search_view','a:2:{i:0;s:4:\"node\";i:1;s:0:\"\";}','',3,2,1,'search','search','Content','t','','','a:0:{}',132,'','',-10,'modules/search/search.pages.inc');
INSERT INTO `menu_router` VALUES ('search/node/%','a:1:{i:2;a:1:{s:14:\"menu_tail_load\";a:2:{i:0;s:4:\"%map\";i:1;s:6:\"%index\";}}}','a:1:{i:2;s:16:\"menu_tail_to_arg\";}','_search_menu_access','a:1:{i:0;s:4:\"node\";}','search_view','a:2:{i:0;s:4:\"node\";i:1;i:2;}','',6,3,1,'search/node','search/node/%','Content','t','','','a:0:{}',132,'','',0,'modules/search/search.pages.inc');
INSERT INTO `menu_router` VALUES ('search/user','','','_search_menu_access','a:1:{i:0;s:4:\"user\";}','search_view','a:2:{i:0;s:4:\"user\";i:1;s:0:\"\";}','',3,2,1,'search','search','Users','t','','','a:0:{}',132,'','',0,'modules/search/search.pages.inc');
INSERT INTO `menu_router` VALUES ('search/user/%','a:1:{i:2;a:1:{s:14:\"menu_tail_load\";a:2:{i:0;s:4:\"%map\";i:1;s:6:\"%index\";}}}','a:1:{i:2;s:16:\"menu_tail_to_arg\";}','_search_menu_access','a:1:{i:0;s:4:\"user\";}','search_view','a:2:{i:0;s:4:\"user\";i:1;i:2;}','',6,3,1,'search/node','search/node/%','Users','t','','','a:0:{}',132,'','',0,'modules/search/search.pages.inc');
INSERT INTO `menu_router` VALUES ('sites/default/files/styles/%','a:1:{i:4;s:16:\"image_style_load\";}','','1','a:0:{}','image_style_deliver','a:1:{i:0;i:4;}','',30,5,0,'','sites/default/files/styles/%','Generate image style','t','','','a:0:{}',0,'','',0,'');
INSERT INTO `menu_router` VALUES ('system/ajax','','','1','a:0:{}','ajax_form_callback','a:0:{}','ajax_deliver',3,2,0,'','system/ajax','AHAH callback','t','','ajax_base_page_theme','a:0:{}',0,'','',0,'includes/form.inc');
INSERT INTO `menu_router` VALUES ('system/files','','','1','a:0:{}','file_download','a:1:{i:0;s:7:\"private\";}','',3,2,0,'','system/files','File download','t','','','a:0:{}',0,'','',0,'');
INSERT INTO `menu_router` VALUES ('system/files/styles/%','a:1:{i:3;s:16:\"image_style_load\";}','','1','a:0:{}','image_style_deliver','a:1:{i:0;i:3;}','',14,4,0,'','system/files/styles/%','Generate image style','t','','','a:0:{}',0,'','',0,'');
INSERT INTO `menu_router` VALUES ('system/temporary','','','1','a:0:{}','file_download','a:1:{i:0;s:9:\"temporary\";}','',3,2,0,'','system/temporary','Temporary files','t','','','a:0:{}',0,'','',0,'');
INSERT INTO `menu_router` VALUES ('system/timezone','','','1','a:0:{}','system_timezone','a:0:{}','',3,2,0,'','system/timezone','Time zone','t','','','a:0:{}',0,'','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('taxonomy/autocomplete','','','user_access','a:1:{i:0;s:14:\"access content\";}','taxonomy_autocomplete','a:0:{}','',3,2,0,'','taxonomy/autocomplete','Autocomplete taxonomy','t','','','a:0:{}',0,'','',0,'modules/taxonomy/taxonomy.pages.inc');
INSERT INTO `menu_router` VALUES ('taxonomy/term/%','a:1:{i:2;s:18:\"taxonomy_term_load\";}','','user_access','a:1:{i:0;s:14:\"access content\";}','taxonomy_term_page','a:1:{i:0;i:2;}','',6,3,0,'','taxonomy/term/%','Taxonomy term','taxonomy_term_title','a:1:{i:0;i:2;}','','a:0:{}',6,'','',0,'modules/taxonomy/taxonomy.pages.inc');
INSERT INTO `menu_router` VALUES ('taxonomy/term/%/edit','a:1:{i:2;s:18:\"taxonomy_term_load\";}','','taxonomy_term_edit_access','a:1:{i:0;i:2;}','drupal_get_form','a:2:{i:0;s:18:\"taxonomy_form_term\";i:1;i:2;}','',13,4,1,'taxonomy/term/%','taxonomy/term/%','Edit','t','','','a:0:{}',132,'','',10,'modules/taxonomy/taxonomy.admin.inc');
INSERT INTO `menu_router` VALUES ('taxonomy/term/%/feed','a:1:{i:2;s:18:\"taxonomy_term_load\";}','','user_access','a:1:{i:0;s:14:\"access content\";}','taxonomy_term_feed','a:1:{i:0;i:2;}','',13,4,0,'','taxonomy/term/%/feed','Taxonomy term','taxonomy_term_title','a:1:{i:0;i:2;}','','a:0:{}',0,'','',0,'modules/taxonomy/taxonomy.pages.inc');
INSERT INTO `menu_router` VALUES ('taxonomy/term/%/view','a:1:{i:2;s:18:\"taxonomy_term_load\";}','','user_access','a:1:{i:0;s:14:\"access content\";}','taxonomy_term_page','a:1:{i:0;i:2;}','',13,4,1,'taxonomy/term/%','taxonomy/term/%','View','t','','','a:0:{}',140,'','',0,'modules/taxonomy/taxonomy.pages.inc');
INSERT INTO `menu_router` VALUES ('toolbar/toggle','','','user_access','a:1:{i:0;s:14:\"access toolbar\";}','toolbar_toggle_page','a:0:{}','',3,2,0,'','toolbar/toggle','Toggle drawer visibility','t','','','a:0:{}',0,'','',0,'');
INSERT INTO `menu_router` VALUES ('user','','','1','a:0:{}','user_page','a:0:{}','',1,1,0,'','user','User account','user_menu_title','','','a:0:{}',6,'','',-10,'modules/user/user.pages.inc');
INSERT INTO `menu_router` VALUES ('user/%','a:1:{i:1;s:9:\"user_load\";}','','user_view_access','a:1:{i:0;i:1;}','user_view_page','a:1:{i:0;i:1;}','',2,2,0,'','user/%','My account','user_page_title','a:1:{i:0;i:1;}','','a:0:{}',6,'','',0,'');
INSERT INTO `menu_router` VALUES ('user/%/cancel','a:1:{i:1;s:9:\"user_load\";}','','user_cancel_access','a:1:{i:0;i:1;}','drupal_get_form','a:2:{i:0;s:24:\"user_cancel_confirm_form\";i:1;i:1;}','',5,3,0,'','user/%/cancel','Cancel account','t','','','a:0:{}',6,'','',0,'modules/user/user.pages.inc');
INSERT INTO `menu_router` VALUES ('user/%/cancel/confirm/%/%','a:3:{i:1;s:9:\"user_load\";i:4;N;i:5;N;}','','user_cancel_access','a:1:{i:0;i:1;}','user_cancel_confirm','a:3:{i:0;i:1;i:1;i:4;i:2;i:5;}','',44,6,0,'','user/%/cancel/confirm/%/%','Confirm account cancellation','t','','','a:0:{}',6,'','',0,'modules/user/user.pages.inc');
INSERT INTO `menu_router` VALUES ('user/%/edit','a:1:{i:1;s:9:\"user_load\";}','','user_edit_access','a:1:{i:0;i:1;}','drupal_get_form','a:2:{i:0;s:17:\"user_profile_form\";i:1;i:1;}','',5,3,1,'user/%','user/%','Edit','t','','','a:0:{}',132,'','',0,'modules/user/user.pages.inc');
INSERT INTO `menu_router` VALUES ('user/%/edit/account','a:1:{i:1;a:1:{s:18:\"user_category_load\";a:2:{i:0;s:4:\"%map\";i:1;s:6:\"%index\";}}}','','user_edit_access','a:1:{i:0;i:1;}','drupal_get_form','a:2:{i:0;s:17:\"user_profile_form\";i:1;i:1;}','',11,4,1,'user/%/edit','user/%','Account','t','','','a:0:{}',140,'','',0,'modules/user/user.pages.inc');
INSERT INTO `menu_router` VALUES ('user/%/shortcuts','a:1:{i:1;s:9:\"user_load\";}','','shortcut_set_switch_access','a:1:{i:0;i:1;}','drupal_get_form','a:2:{i:0;s:19:\"shortcut_set_switch\";i:1;i:1;}','',5,3,1,'user/%','user/%','Shortcuts','t','','','a:0:{}',132,'','',0,'modules/shortcut/shortcut.admin.inc');
INSERT INTO `menu_router` VALUES ('user/%/view','a:1:{i:1;s:9:\"user_load\";}','','user_view_access','a:1:{i:0;i:1;}','user_view_page','a:1:{i:0;i:1;}','',5,3,1,'user/%','user/%','View','t','','','a:0:{}',140,'','',-10,'');
INSERT INTO `menu_router` VALUES ('user/autocomplete','','','user_access','a:1:{i:0;s:20:\"access user profiles\";}','user_autocomplete','a:0:{}','',3,2,0,'','user/autocomplete','User autocomplete','t','','','a:0:{}',0,'','',0,'modules/user/user.pages.inc');
INSERT INTO `menu_router` VALUES ('user/login','','','user_is_anonymous','a:0:{}','user_page','a:0:{}','',3,2,1,'user','user','Log in','t','','','a:0:{}',140,'','',0,'modules/user/user.pages.inc');
INSERT INTO `menu_router` VALUES ('user/logout','','','user_is_logged_in','a:0:{}','user_logout','a:0:{}','',3,2,0,'','user/logout','Log out','t','','','a:0:{}',6,'','',10,'modules/user/user.pages.inc');
INSERT INTO `menu_router` VALUES ('user/password','','','1','a:0:{}','drupal_get_form','a:1:{i:0;s:9:\"user_pass\";}','',3,2,1,'user','user','Request new password','t','','','a:0:{}',132,'','',0,'modules/user/user.pages.inc');
INSERT INTO `menu_router` VALUES ('user/register','','','user_register_access','a:0:{}','drupal_get_form','a:1:{i:0;s:18:\"user_register_form\";}','',3,2,1,'user','user','Create new account','t','','','a:0:{}',132,'','',0,'');
INSERT INTO `menu_router` VALUES ('user/reset/%/%/%','a:3:{i:2;N;i:3;N;i:4;N;}','','1','a:0:{}','drupal_get_form','a:4:{i:0;s:15:\"user_pass_reset\";i:1;i:2;i:2;i:3;i:3;i:4;}','',24,5,0,'','user/reset/%/%/%','Reset password','t','','','a:0:{}',0,'','',0,'modules/user/user.pages.inc');
/*!40000 ALTER TABLE `menu_router` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `node`
--

DROP TABLE IF EXISTS `node`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `node` (
  `nid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a node.',
  `vid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The current node_revision.vid version identifier.',
  `type` varchar(32) NOT NULL DEFAULT '' COMMENT 'The node_type.type of this node.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The languages.language of this node.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of this node, always treated as non-markup plain text.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that owns this node; initially, this is the user that created it.',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT 'Boolean indicating whether the node is published (visible to non-administrators).',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the node was created.',
  `changed` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the node was most recently saved.',
  `comment` int(11) NOT NULL DEFAULT '0' COMMENT 'Whether comments are allowed on this node: 0 = no, 1 = closed (read only), 2 = open (read/write).',
  `promote` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node should be displayed on the front page.',
  `sticky` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node should be displayed at the top of lists in which it appears.',
  `tnid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The translation set id for this node, which equals the node id of the source post in each set.',
  `translate` int(11) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this translation page needs to be updated.',
  PRIMARY KEY (`nid`),
  UNIQUE KEY `vid` (`vid`),
  KEY `node_changed` (`changed`),
  KEY `node_created` (`created`),
  KEY `node_frontpage` (`promote`,`status`,`sticky`,`created`),
  KEY `node_status_type` (`status`,`type`,`nid`),
  KEY `node_title_type` (`title`,`type`(4)),
  KEY `node_type` (`type`(4)),
  KEY `uid` (`uid`),
  KEY `tnid` (`tnid`),
  KEY `translate` (`translate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The base table for nodes.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `node`
--

LOCK TABLES `node` WRITE;
/*!40000 ALTER TABLE `node` DISABLE KEYS */;
/*!40000 ALTER TABLE `node` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `node_access`
--

DROP TABLE IF EXISTS `node_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `node_access` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node.nid this record affects.',
  `gid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The grant ID a user must possess in the specified realm to gain this row’s privileges on the node.',
  `realm` varchar(255) NOT NULL DEFAULT '' COMMENT 'The realm in which the user must possess the grant ID. Each node access node can define one or more realms.',
  `grant_view` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can view this node.',
  `grant_update` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can edit this node.',
  `grant_delete` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can delete this node.',
  PRIMARY KEY (`nid`,`gid`,`realm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Identifies which realm/grant pairs a user must possess in...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `node_access`
--

LOCK TABLES `node_access` WRITE;
/*!40000 ALTER TABLE `node_access` DISABLE KEYS */;
INSERT INTO `node_access` VALUES (0,0,'all',1,0,0);
/*!40000 ALTER TABLE `node_access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `node_comment_statistics`
--

DROP TABLE IF EXISTS `node_comment_statistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `node_comment_statistics` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node.nid for which the statistics are compiled.',
  `cid` int(11) NOT NULL DEFAULT '0' COMMENT 'The comment.cid of the last comment.',
  `last_comment_timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp of the last comment that was posted within this node, from comment.timestamp.',
  `last_comment_name` varchar(60) DEFAULT NULL COMMENT 'The name of the latest author to post a comment on this node, from comment.name.',
  `last_comment_uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The user ID of the latest author to post a comment on this node, from comment.uid.',
  `comment_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The total number of comments on this node.',
  PRIMARY KEY (`nid`),
  KEY `node_comment_timestamp` (`last_comment_timestamp`),
  KEY `comment_count` (`comment_count`),
  KEY `last_comment_uid` (`last_comment_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maintains statistics of node and comments posts to show ...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `node_comment_statistics`
--

LOCK TABLES `node_comment_statistics` WRITE;
/*!40000 ALTER TABLE `node_comment_statistics` DISABLE KEYS */;
/*!40000 ALTER TABLE `node_comment_statistics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `node_revision`
--

DROP TABLE IF EXISTS `node_revision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `node_revision` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node this version belongs to.',
  `vid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for this version.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that created this version.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of this version.',
  `log` longtext NOT NULL COMMENT 'The log entry explaining the changes in this version.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when this version was created.',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT 'Boolean indicating whether the node (at the time of this revision) is published (visible to non-administrators).',
  `comment` int(11) NOT NULL DEFAULT '0' COMMENT 'Whether comments are allowed on this node (at the time of this revision): 0 = no, 1 = closed (read only), 2 = open (read/write).',
  `promote` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node (at the time of this revision) should be displayed on the front page.',
  `sticky` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node (at the time of this revision) should be displayed at the top of lists in which it appears.',
  PRIMARY KEY (`vid`),
  KEY `nid` (`nid`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about each saved version of a node.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `node_revision`
--

LOCK TABLES `node_revision` WRITE;
/*!40000 ALTER TABLE `node_revision` DISABLE KEYS */;
/*!40000 ALTER TABLE `node_revision` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `node_type`
--

DROP TABLE IF EXISTS `node_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `node_type` (
  `type` varchar(32) NOT NULL COMMENT 'The machine-readable name of this type.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The human-readable name of this type.',
  `base` varchar(255) NOT NULL COMMENT 'The base string used to construct callbacks corresponding to this node type.',
  `module` varchar(255) NOT NULL COMMENT 'The module defining this node type.',
  `description` mediumtext NOT NULL COMMENT 'A brief description of this type.',
  `help` mediumtext NOT NULL COMMENT 'Help information shown to the user when creating a node of this type.',
  `has_title` tinyint(3) unsigned NOT NULL COMMENT 'Boolean indicating whether this type uses the node.title field.',
  `title_label` varchar(255) NOT NULL DEFAULT '' COMMENT 'The label displayed for the title field on the edit form.',
  `custom` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this type is defined by a module (FALSE) or by a user via Add content type (TRUE).',
  `modified` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this type has been modified by an administrator; currently not used in any way.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether the administrator can change the machine name of this type.',
  `disabled` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether the node type is disabled.',
  `orig_type` varchar(255) NOT NULL DEFAULT '' COMMENT 'The original machine-readable name of this node type. This may be different from the current type name if the locked field is 0.',
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about all defined node types.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `node_type`
--

LOCK TABLES `node_type` WRITE;
/*!40000 ALTER TABLE `node_type` DISABLE KEYS */;
INSERT INTO `node_type` VALUES ('article','Article','node_content','node','Use <em>articles</em> for time-sensitive content like news, press releases or blog posts.','',1,'Title',1,1,0,0,'article');
INSERT INTO `node_type` VALUES ('page','Basic page','node_content','node','Use <em>basic pages</em> for your static content, such as an \'About us\' page.','',1,'Title',1,1,0,0,'page');
/*!40000 ALTER TABLE `node_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `queue`
--

DROP TABLE IF EXISTS `queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queue` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique item ID.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The queue name.',
  `data` longblob COMMENT 'The arbitrary data for the item.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp when the claim lease expires on the item.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp when the item was created.',
  PRIMARY KEY (`item_id`),
  KEY `name_created` (`name`,`created`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 COMMENT='Stores items in queues.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `queue`
--

LOCK TABLES `queue` WRITE;
/*!40000 ALTER TABLE `queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rdf_mapping`
--

DROP TABLE IF EXISTS `rdf_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rdf_mapping` (
  `type` varchar(128) NOT NULL COMMENT 'The name of the entity type a mapping applies to (node, user, comment, etc.).',
  `bundle` varchar(128) NOT NULL COMMENT 'The name of the bundle a mapping applies to.',
  `mapping` longblob COMMENT 'The serialized mapping of the bundle type and fields to RDF terms.',
  PRIMARY KEY (`type`,`bundle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores custom RDF mappings for user defined content types...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rdf_mapping`
--

LOCK TABLES `rdf_mapping` WRITE;
/*!40000 ALTER TABLE `rdf_mapping` DISABLE KEYS */;
INSERT INTO `rdf_mapping` VALUES ('node','article','a:11:{s:11:\"field_image\";a:2:{s:10:\"predicates\";a:2:{i:0;s:8:\"og:image\";i:1;s:12:\"rdfs:seeAlso\";}s:4:\"type\";s:3:\"rel\";}s:10:\"field_tags\";a:2:{s:10:\"predicates\";a:1:{i:0;s:10:\"dc:subject\";}s:4:\"type\";s:3:\"rel\";}s:7:\"rdftype\";a:2:{i:0;s:9:\"sioc:Item\";i:1;s:13:\"foaf:Document\";}s:5:\"title\";a:1:{s:10:\"predicates\";a:1:{i:0;s:8:\"dc:title\";}}s:7:\"created\";a:3:{s:10:\"predicates\";a:2:{i:0;s:7:\"dc:date\";i:1;s:10:\"dc:created\";}s:8:\"datatype\";s:12:\"xsd:dateTime\";s:8:\"callback\";s:12:\"date_iso8601\";}s:7:\"changed\";a:3:{s:10:\"predicates\";a:1:{i:0;s:11:\"dc:modified\";}s:8:\"datatype\";s:12:\"xsd:dateTime\";s:8:\"callback\";s:12:\"date_iso8601\";}s:4:\"body\";a:1:{s:10:\"predicates\";a:1:{i:0;s:15:\"content:encoded\";}}s:3:\"uid\";a:2:{s:10:\"predicates\";a:1:{i:0;s:16:\"sioc:has_creator\";}s:4:\"type\";s:3:\"rel\";}s:4:\"name\";a:1:{s:10:\"predicates\";a:1:{i:0;s:9:\"foaf:name\";}}s:13:\"comment_count\";a:2:{s:10:\"predicates\";a:1:{i:0;s:16:\"sioc:num_replies\";}s:8:\"datatype\";s:11:\"xsd:integer\";}s:13:\"last_activity\";a:3:{s:10:\"predicates\";a:1:{i:0;s:23:\"sioc:last_activity_date\";}s:8:\"datatype\";s:12:\"xsd:dateTime\";s:8:\"callback\";s:12:\"date_iso8601\";}}');
INSERT INTO `rdf_mapping` VALUES ('node','page','a:9:{s:7:\"rdftype\";a:1:{i:0;s:13:\"foaf:Document\";}s:5:\"title\";a:1:{s:10:\"predicates\";a:1:{i:0;s:8:\"dc:title\";}}s:7:\"created\";a:3:{s:10:\"predicates\";a:2:{i:0;s:7:\"dc:date\";i:1;s:10:\"dc:created\";}s:8:\"datatype\";s:12:\"xsd:dateTime\";s:8:\"callback\";s:12:\"date_iso8601\";}s:7:\"changed\";a:3:{s:10:\"predicates\";a:1:{i:0;s:11:\"dc:modified\";}s:8:\"datatype\";s:12:\"xsd:dateTime\";s:8:\"callback\";s:12:\"date_iso8601\";}s:4:\"body\";a:1:{s:10:\"predicates\";a:1:{i:0;s:15:\"content:encoded\";}}s:3:\"uid\";a:2:{s:10:\"predicates\";a:1:{i:0;s:16:\"sioc:has_creator\";}s:4:\"type\";s:3:\"rel\";}s:4:\"name\";a:1:{s:10:\"predicates\";a:1:{i:0;s:9:\"foaf:name\";}}s:13:\"comment_count\";a:2:{s:10:\"predicates\";a:1:{i:0;s:16:\"sioc:num_replies\";}s:8:\"datatype\";s:11:\"xsd:integer\";}s:13:\"last_activity\";a:3:{s:10:\"predicates\";a:1:{i:0;s:23:\"sioc:last_activity_date\";}s:8:\"datatype\";s:12:\"xsd:dateTime\";s:8:\"callback\";s:12:\"date_iso8601\";}}');
/*!40000 ALTER TABLE `rdf_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registry`
--

DROP TABLE IF EXISTS `registry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registry` (
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the function, class, or interface.',
  `type` varchar(9) NOT NULL DEFAULT '' COMMENT 'Either function or class or interface.',
  `filename` varchar(255) NOT NULL COMMENT 'Name of the file.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the module the file belongs to.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The order in which this module’s hooks should be invoked relative to other modules. Equal-weighted modules are ordered by name.',
  PRIMARY KEY (`name`,`type`),
  KEY `hook` (`type`,`weight`,`module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Each record is a function, class, or interface name and...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registry`
--

LOCK TABLES `registry` WRITE;
/*!40000 ALTER TABLE `registry` DISABLE KEYS */;
INSERT INTO `registry` VALUES ('AccessDeniedTestCase','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('AdminMetaTagTestCase','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('ArchiverInterface','interface','includes/archiver.inc','',0);
INSERT INTO `registry` VALUES ('ArchiverTar','class','modules/system/system.archiver.inc','system',0);
INSERT INTO `registry` VALUES ('ArchiverZip','class','modules/system/system.archiver.inc','system',0);
INSERT INTO `registry` VALUES ('Archive_Tar','class','modules/system/system.tar.inc','system',0);
INSERT INTO `registry` VALUES ('BatchMemoryQueue','class','includes/batch.queue.inc','',0);
INSERT INTO `registry` VALUES ('BatchQueue','class','includes/batch.queue.inc','',0);
INSERT INTO `registry` VALUES ('BlockAdminThemeTestCase','class','modules/block/block.test','block',0);
INSERT INTO `registry` VALUES ('BlockCacheTestCase','class','modules/block/block.test','block',0);
INSERT INTO `registry` VALUES ('BlockHTMLIdTestCase','class','modules/block/block.test','block',0);
INSERT INTO `registry` VALUES ('BlockTemplateSuggestionsUnitTest','class','modules/block/block.test','block',0);
INSERT INTO `registry` VALUES ('BlockTestCase','class','modules/block/block.test','block',0);
INSERT INTO `registry` VALUES ('ColorTestCase','class','modules/color/color.test','color',0);
INSERT INTO `registry` VALUES ('CommentActionsTestCase','class','modules/comment/comment.test','comment',0);
INSERT INTO `registry` VALUES ('CommentAnonymous','class','modules/comment/comment.test','comment',0);
INSERT INTO `registry` VALUES ('CommentApprovalTest','class','modules/comment/comment.test','comment',0);
INSERT INTO `registry` VALUES ('CommentBlockFunctionalTest','class','modules/comment/comment.test','comment',0);
INSERT INTO `registry` VALUES ('CommentContentRebuild','class','modules/comment/comment.test','comment',0);
INSERT INTO `registry` VALUES ('CommentController','class','modules/comment/comment.module','comment',0);
INSERT INTO `registry` VALUES ('CommentFieldsTest','class','modules/comment/comment.test','comment',0);
INSERT INTO `registry` VALUES ('CommentHelperCase','class','modules/comment/comment.test','comment',0);
INSERT INTO `registry` VALUES ('CommentInterfaceTest','class','modules/comment/comment.test','comment',0);
INSERT INTO `registry` VALUES ('CommentNodeAccessTest','class','modules/comment/comment.test','comment',0);
INSERT INTO `registry` VALUES ('CommentPagerTest','class','modules/comment/comment.test','comment',0);
INSERT INTO `registry` VALUES ('CommentPreviewTest','class','modules/comment/comment.test','comment',0);
INSERT INTO `registry` VALUES ('CommentRSSUnitTest','class','modules/comment/comment.test','comment',0);
INSERT INTO `registry` VALUES ('CommentTokenReplaceTestCase','class','modules/comment/comment.test','comment',0);
INSERT INTO `registry` VALUES ('CronRunTestCase','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('DashboardBlocksTestCase','class','modules/dashboard/dashboard.test','dashboard',0);
INSERT INTO `registry` VALUES ('Database','class','includes/database/database.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseCondition','class','includes/database/query.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseConnection','class','includes/database/database.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseConnectionNotDefinedException','class','includes/database/database.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseConnection_mysql','class','includes/database/mysql/database.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseConnection_pgsql','class','includes/database/pgsql/database.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseConnection_sqlite','class','includes/database/sqlite/database.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseDriverNotSpecifiedException','class','includes/database/database.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseLog','class','includes/database/log.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseSchema','class','includes/database/schema.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseSchemaObjectDoesNotExistException','class','includes/database/schema.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseSchemaObjectExistsException','class','includes/database/schema.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseSchema_mysql','class','includes/database/mysql/schema.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseSchema_pgsql','class','includes/database/pgsql/schema.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseSchema_sqlite','class','includes/database/sqlite/schema.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseStatementBase','class','includes/database/database.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseStatementEmpty','class','includes/database/database.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseStatementInterface','interface','includes/database/database.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseStatementPrefetch','class','includes/database/prefetch.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseStatement_sqlite','class','includes/database/sqlite/database.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseTaskException','class','includes/install.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseTasks','class','includes/install.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseTasks_mysql','class','includes/database/mysql/install.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseTasks_pgsql','class','includes/database/pgsql/install.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseTasks_sqlite','class','includes/database/sqlite/install.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseTransaction','class','includes/database/database.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseTransactionCommitFailedException','class','includes/database/database.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseTransactionExplicitCommitNotAllowedException','class','includes/database/database.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseTransactionNameNonUniqueException','class','includes/database/database.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseTransactionNoActiveException','class','includes/database/database.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseTransactionOutOfOrderException','class','includes/database/database.inc','',0);
INSERT INTO `registry` VALUES ('DateTimeFunctionalTest','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('DBLogTestCase','class','modules/dblog/dblog.test','dblog',0);
INSERT INTO `registry` VALUES ('DefaultMailSystem','class','modules/system/system.mail.inc','system',0);
INSERT INTO `registry` VALUES ('DeleteQuery','class','includes/database/query.inc','',0);
INSERT INTO `registry` VALUES ('DeleteQuery_sqlite','class','includes/database/sqlite/query.inc','',0);
INSERT INTO `registry` VALUES ('DrupalCacheArray','class','includes/bootstrap.inc','',0);
INSERT INTO `registry` VALUES ('DrupalCacheInterface','interface','includes/cache.inc','',0);
INSERT INTO `registry` VALUES ('DrupalDatabaseCache','class','includes/cache.inc','',0);
INSERT INTO `registry` VALUES ('DrupalDefaultEntityController','class','includes/entity.inc','',0);
INSERT INTO `registry` VALUES ('DrupalEntityControllerInterface','interface','includes/entity.inc','',0);
INSERT INTO `registry` VALUES ('DrupalFakeCache','class','includes/cache-install.inc','',0);
INSERT INTO `registry` VALUES ('DrupalLocalStreamWrapper','class','includes/stream_wrappers.inc','',0);
INSERT INTO `registry` VALUES ('DrupalPrivateStreamWrapper','class','includes/stream_wrappers.inc','',0);
INSERT INTO `registry` VALUES ('DrupalPublicStreamWrapper','class','includes/stream_wrappers.inc','',0);
INSERT INTO `registry` VALUES ('DrupalQueue','class','modules/system/system.queue.inc','system',0);
INSERT INTO `registry` VALUES ('DrupalQueueInterface','interface','modules/system/system.queue.inc','system',0);
INSERT INTO `registry` VALUES ('DrupalReliableQueueInterface','interface','modules/system/system.queue.inc','system',0);
INSERT INTO `registry` VALUES ('DrupalStreamWrapperInterface','interface','includes/stream_wrappers.inc','',0);
INSERT INTO `registry` VALUES ('DrupalTemporaryStreamWrapper','class','includes/stream_wrappers.inc','',0);
INSERT INTO `registry` VALUES ('DrupalUpdateException','class','includes/update.inc','',0);
INSERT INTO `registry` VALUES ('DrupalUpdaterInterface','interface','includes/updater.inc','',0);
INSERT INTO `registry` VALUES ('EnableDisableTestCase','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('EntityFieldQuery','class','includes/entity.inc','',0);
INSERT INTO `registry` VALUES ('EntityFieldQueryException','class','includes/entity.inc','',0);
INSERT INTO `registry` VALUES ('EntityMalformedException','class','includes/entity.inc','',0);
INSERT INTO `registry` VALUES ('EntityPropertiesTestCase','class','modules/field/tests/field.test','field',0);
INSERT INTO `registry` VALUES ('FieldAttachOtherTestCase','class','modules/field/tests/field.test','field',0);
INSERT INTO `registry` VALUES ('FieldAttachStorageTestCase','class','modules/field/tests/field.test','field',0);
INSERT INTO `registry` VALUES ('FieldAttachTestCase','class','modules/field/tests/field.test','field',0);
INSERT INTO `registry` VALUES ('FieldBulkDeleteTestCase','class','modules/field/tests/field.test','field',0);
INSERT INTO `registry` VALUES ('FieldCrudTestCase','class','modules/field/tests/field.test','field',0);
INSERT INTO `registry` VALUES ('FieldDisplayAPITestCase','class','modules/field/tests/field.test','field',0);
INSERT INTO `registry` VALUES ('FieldException','class','modules/field/field.module','field',0);
INSERT INTO `registry` VALUES ('FieldFormTestCase','class','modules/field/tests/field.test','field',0);
INSERT INTO `registry` VALUES ('FieldInfoTestCase','class','modules/field/tests/field.test','field',0);
INSERT INTO `registry` VALUES ('FieldInstanceCrudTestCase','class','modules/field/tests/field.test','field',0);
INSERT INTO `registry` VALUES ('FieldsOverlapException','class','includes/database/database.inc','',0);
INSERT INTO `registry` VALUES ('FieldSqlStorageTestCase','class','modules/field/modules/field_sql_storage/field_sql_storage.test','field_sql_storage',0);
INSERT INTO `registry` VALUES ('FieldTestCase','class','modules/field/tests/field.test','field',0);
INSERT INTO `registry` VALUES ('FieldTranslationsTestCase','class','modules/field/tests/field.test','field',0);
INSERT INTO `registry` VALUES ('FieldUIManageDisplayTestCase','class','modules/field_ui/field_ui.test','field_ui',0);
INSERT INTO `registry` VALUES ('FieldUIManageFieldsTestCase','class','modules/field_ui/field_ui.test','field_ui',0);
INSERT INTO `registry` VALUES ('FieldUITestCase','class','modules/field_ui/field_ui.test','field_ui',0);
INSERT INTO `registry` VALUES ('FieldUpdateForbiddenException','class','modules/field/field.module','field',0);
INSERT INTO `registry` VALUES ('FieldValidationException','class','modules/field/field.attach.inc','field',0);
INSERT INTO `registry` VALUES ('FileFieldDisplayTestCase','class','modules/file/tests/file.test','file',0);
INSERT INTO `registry` VALUES ('FileFieldPathTestCase','class','modules/file/tests/file.test','file',0);
INSERT INTO `registry` VALUES ('FileFieldRevisionTestCase','class','modules/file/tests/file.test','file',0);
INSERT INTO `registry` VALUES ('FileFieldTestCase','class','modules/file/tests/file.test','file',0);
INSERT INTO `registry` VALUES ('FileFieldValidateTestCase','class','modules/file/tests/file.test','file',0);
INSERT INTO `registry` VALUES ('FileFieldWidgetTestCase','class','modules/file/tests/file.test','file',0);
INSERT INTO `registry` VALUES ('FileManagedFileElementTestCase','class','modules/file/tests/file.test','file',0);
INSERT INTO `registry` VALUES ('FilePrivateTestCase','class','modules/file/tests/file.test','file',0);
INSERT INTO `registry` VALUES ('FileTokenReplaceTestCase','class','modules/file/tests/file.test','file',0);
INSERT INTO `registry` VALUES ('FileTransfer','class','includes/filetransfer/filetransfer.inc','',0);
INSERT INTO `registry` VALUES ('FileTransferChmodInterface','interface','includes/filetransfer/filetransfer.inc','',0);
INSERT INTO `registry` VALUES ('FileTransferException','class','includes/filetransfer/filetransfer.inc','',0);
INSERT INTO `registry` VALUES ('FileTransferFTP','class','includes/filetransfer/ftp.inc','',0);
INSERT INTO `registry` VALUES ('FileTransferFTPExtension','class','includes/filetransfer/ftp.inc','',0);
INSERT INTO `registry` VALUES ('FileTransferLocal','class','includes/filetransfer/local.inc','',0);
INSERT INTO `registry` VALUES ('FileTransferSSH','class','includes/filetransfer/ssh.inc','',0);
INSERT INTO `registry` VALUES ('FilterAdminTestCase','class','modules/filter/filter.test','filter',0);
INSERT INTO `registry` VALUES ('FilterCRUDTestCase','class','modules/filter/filter.test','filter',0);
INSERT INTO `registry` VALUES ('FilterDefaultFormatTestCase','class','modules/filter/filter.test','filter',0);
INSERT INTO `registry` VALUES ('FilterFormatAccessTestCase','class','modules/filter/filter.test','filter',0);
INSERT INTO `registry` VALUES ('FilterHooksTestCase','class','modules/filter/filter.test','filter',0);
INSERT INTO `registry` VALUES ('FilterNoFormatTestCase','class','modules/filter/filter.test','filter',0);
INSERT INTO `registry` VALUES ('FilterSecurityTestCase','class','modules/filter/filter.test','filter',0);
INSERT INTO `registry` VALUES ('FilterUnitTestCase','class','modules/filter/filter.test','filter',0);
INSERT INTO `registry` VALUES ('FloodFunctionalTest','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('FrontPageTestCase','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('HelpTestCase','class','modules/help/help.test','help',0);
INSERT INTO `registry` VALUES ('HookRequirementsTestCase','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('ImageAdminStylesUnitTest','class','modules/image/image.test','image',0);
INSERT INTO `registry` VALUES ('ImageEffectsUnitTest','class','modules/image/image.test','image',0);
INSERT INTO `registry` VALUES ('ImageFieldDisplayTestCase','class','modules/image/image.test','image',0);
INSERT INTO `registry` VALUES ('ImageFieldTestCase','class','modules/image/image.test','image',0);
INSERT INTO `registry` VALUES ('ImageFieldValidateTestCase','class','modules/image/image.test','image',0);
INSERT INTO `registry` VALUES ('ImageStylesPathAndUrlUnitTest','class','modules/image/image.test','image',0);
INSERT INTO `registry` VALUES ('InfoFileParserTestCase','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('InsertQuery','class','includes/database/query.inc','',0);
INSERT INTO `registry` VALUES ('InsertQuery_mysql','class','includes/database/mysql/query.inc','',0);
INSERT INTO `registry` VALUES ('InsertQuery_pgsql','class','includes/database/pgsql/query.inc','',0);
INSERT INTO `registry` VALUES ('InsertQuery_sqlite','class','includes/database/sqlite/query.inc','',0);
INSERT INTO `registry` VALUES ('InvalidMergeQueryException','class','includes/database/database.inc','',0);
INSERT INTO `registry` VALUES ('IPAddressBlockingTestCase','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('ListFieldTestCase','class','modules/field/modules/list/tests/list.test','list',0);
INSERT INTO `registry` VALUES ('ListFieldUITestCase','class','modules/field/modules/list/tests/list.test','list',0);
INSERT INTO `registry` VALUES ('MailSystemInterface','interface','includes/mail.inc','',0);
INSERT INTO `registry` VALUES ('MemoryQueue','class','modules/system/system.queue.inc','system',0);
INSERT INTO `registry` VALUES ('MenuNodeTestCase','class','modules/menu/menu.test','menu',0);
INSERT INTO `registry` VALUES ('MenuTestCase','class','modules/menu/menu.test','menu',0);
INSERT INTO `registry` VALUES ('MergeQuery','class','includes/database/query.inc','',0);
INSERT INTO `registry` VALUES ('ModuleDependencyTestCase','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('ModuleRequiredTestCase','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('ModuleTestCase','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('ModuleUpdater','class','modules/system/system.updater.inc','system',0);
INSERT INTO `registry` VALUES ('ModuleVersionTestCase','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('MultiStepNodeFormBasicOptionsTest','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NewDefaultThemeBlocks','class','modules/block/block.test','block',0);
INSERT INTO `registry` VALUES ('NodeAccessBaseTableTestCase','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodeAccessRebuildTestCase','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodeAccessRecordsUnitTest','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodeAccessUnitTest','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodeAdminTestCase','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodeBlockFunctionalTest','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodeBlockTestCase','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodeBuildContent','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodeController','class','modules/node/node.module','node',0);
INSERT INTO `registry` VALUES ('NodeCreationTestCase','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodeEntityFieldQueryAlter','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodeFeedTestCase','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodeLoadHooksTestCase','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodeLoadMultipleUnitTest','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodePostSettingsTestCase','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodeQueryAlter','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodeRevisionsTestCase','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodeRSSContentTestCase','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodeSaveTestCase','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodeTitleTestCase','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodeTitleXSSTestCase','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodeTokenReplaceTestCase','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodeTypePersistenceTestCase','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodeTypeTestCase','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NoFieldsException','class','includes/database/database.inc','',0);
INSERT INTO `registry` VALUES ('NoHelpTestCase','class','modules/help/help.test','help',0);
INSERT INTO `registry` VALUES ('NonDefaultBlockAdmin','class','modules/block/block.test','block',0);
INSERT INTO `registry` VALUES ('NumberFieldTestCase','class','modules/field/modules/number/number.test','number',0);
INSERT INTO `registry` VALUES ('OptionsWidgetsTestCase','class','modules/field/modules/options/options.test','options',0);
INSERT INTO `registry` VALUES ('PageEditTestCase','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('PageNotFoundTestCase','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('PagePreviewTestCase','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('PagerDefault','class','includes/pager.inc','',0);
INSERT INTO `registry` VALUES ('PageTitleFiltering','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('PageViewTestCase','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('PathLanguageTestCase','class','modules/path/path.test','path',0);
INSERT INTO `registry` VALUES ('PathLanguageUITestCase','class','modules/path/path.test','path',0);
INSERT INTO `registry` VALUES ('PathMonolingualTestCase','class','modules/path/path.test','path',0);
INSERT INTO `registry` VALUES ('PathTaxonomyTermTestCase','class','modules/path/path.test','path',0);
INSERT INTO `registry` VALUES ('PathTestCase','class','modules/path/path.test','path',0);
INSERT INTO `registry` VALUES ('Query','class','includes/database/query.inc','',0);
INSERT INTO `registry` VALUES ('QueryAlterableInterface','interface','includes/database/query.inc','',0);
INSERT INTO `registry` VALUES ('QueryConditionInterface','interface','includes/database/query.inc','',0);
INSERT INTO `registry` VALUES ('QueryExtendableInterface','interface','includes/database/select.inc','',0);
INSERT INTO `registry` VALUES ('QueryPlaceholderInterface','interface','includes/database/query.inc','',0);
INSERT INTO `registry` VALUES ('QueueTestCase','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('RdfCommentAttributesTestCase','class','modules/rdf/rdf.test','rdf',0);
INSERT INTO `registry` VALUES ('RdfCrudTestCase','class','modules/rdf/rdf.test','rdf',0);
INSERT INTO `registry` VALUES ('RdfGetRdfNamespacesTestCase','class','modules/rdf/rdf.test','rdf',0);
INSERT INTO `registry` VALUES ('RdfMappingDefinitionTestCase','class','modules/rdf/rdf.test','rdf',0);
INSERT INTO `registry` VALUES ('RdfMappingHookTestCase','class','modules/rdf/rdf.test','rdf',0);
INSERT INTO `registry` VALUES ('RdfRdfaMarkupTestCase','class','modules/rdf/rdf.test','rdf',0);
INSERT INTO `registry` VALUES ('RdfTrackerAttributesTestCase','class','modules/rdf/rdf.test','rdf',0);
INSERT INTO `registry` VALUES ('RetrieveFileTestCase','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('SchemaCache','class','includes/bootstrap.inc','',0);
INSERT INTO `registry` VALUES ('SearchAdvancedSearchForm','class','modules/search/search.test','search',0);
INSERT INTO `registry` VALUES ('SearchBlockTestCase','class','modules/search/search.test','search',0);
INSERT INTO `registry` VALUES ('SearchCommentCountToggleTestCase','class','modules/search/search.test','search',0);
INSERT INTO `registry` VALUES ('SearchCommentTestCase','class','modules/search/search.test','search',0);
INSERT INTO `registry` VALUES ('SearchConfigSettingsForm','class','modules/search/search.test','search',0);
INSERT INTO `registry` VALUES ('SearchEmbedForm','class','modules/search/search.test','search',0);
INSERT INTO `registry` VALUES ('SearchExactTestCase','class','modules/search/search.test','search',0);
INSERT INTO `registry` VALUES ('SearchExcerptTestCase','class','modules/search/search.test','search',0);
INSERT INTO `registry` VALUES ('SearchExpressionInsertExtractTestCase','class','modules/search/search.test','search',0);
INSERT INTO `registry` VALUES ('SearchKeywordsConditions','class','modules/search/search.test','search',0);
INSERT INTO `registry` VALUES ('SearchLanguageTestCase','class','modules/search/search.test','search',0);
INSERT INTO `registry` VALUES ('SearchMatchTestCase','class','modules/search/search.test','search',0);
INSERT INTO `registry` VALUES ('SearchNodeAccessTest','class','modules/search/search.test','search',0);
INSERT INTO `registry` VALUES ('SearchNumberMatchingTestCase','class','modules/search/search.test','search',0);
INSERT INTO `registry` VALUES ('SearchNumbersTestCase','class','modules/search/search.test','search',0);
INSERT INTO `registry` VALUES ('SearchPageOverride','class','modules/search/search.test','search',0);
INSERT INTO `registry` VALUES ('SearchPageText','class','modules/search/search.test','search',0);
INSERT INTO `registry` VALUES ('SearchQuery','class','modules/search/search.extender.inc','search',0);
INSERT INTO `registry` VALUES ('SearchRankingTestCase','class','modules/search/search.test','search',0);
INSERT INTO `registry` VALUES ('SearchSimplifyTestCase','class','modules/search/search.test','search',0);
INSERT INTO `registry` VALUES ('SearchTokenizerTestCase','class','modules/search/search.test','search',0);
INSERT INTO `registry` VALUES ('SelectQuery','class','includes/database/select.inc','',0);
INSERT INTO `registry` VALUES ('SelectQueryExtender','class','includes/database/select.inc','',0);
INSERT INTO `registry` VALUES ('SelectQueryInterface','interface','includes/database/select.inc','',0);
INSERT INTO `registry` VALUES ('SelectQuery_pgsql','class','includes/database/pgsql/select.inc','',0);
INSERT INTO `registry` VALUES ('SelectQuery_sqlite','class','includes/database/sqlite/select.inc','',0);
INSERT INTO `registry` VALUES ('ShortcutLinksTestCase','class','modules/shortcut/shortcut.test','shortcut',0);
INSERT INTO `registry` VALUES ('ShortcutSetsTestCase','class','modules/shortcut/shortcut.test','shortcut',0);
INSERT INTO `registry` VALUES ('ShortcutTestCase','class','modules/shortcut/shortcut.test','shortcut',0);
INSERT INTO `registry` VALUES ('ShutdownFunctionsTest','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('SiteMaintenanceTestCase','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('SkipDotsRecursiveDirectoryIterator','class','includes/filetransfer/filetransfer.inc','',0);
INSERT INTO `registry` VALUES ('StreamWrapperInterface','interface','includes/stream_wrappers.inc','',0);
INSERT INTO `registry` VALUES ('SummaryLengthTestCase','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('SystemAdminTestCase','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('SystemAuthorizeCase','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('SystemBlockTestCase','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('SystemIndexPhpTest','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('SystemInfoAlterTestCase','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('SystemMainContentFallback','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('SystemQueue','class','modules/system/system.queue.inc','system',0);
INSERT INTO `registry` VALUES ('SystemThemeFunctionalTest','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('TableSort','class','includes/tablesort.inc','',0);
INSERT INTO `registry` VALUES ('TaxonomyHooksTestCase','class','modules/taxonomy/taxonomy.test','taxonomy',0);
INSERT INTO `registry` VALUES ('TaxonomyLegacyTestCase','class','modules/taxonomy/taxonomy.test','taxonomy',0);
INSERT INTO `registry` VALUES ('TaxonomyLoadMultipleUnitTest','class','modules/taxonomy/taxonomy.test','taxonomy',0);
INSERT INTO `registry` VALUES ('TaxonomyTermController','class','modules/taxonomy/taxonomy.module','taxonomy',0);
INSERT INTO `registry` VALUES ('TaxonomyTermFieldTestCase','class','modules/taxonomy/taxonomy.test','taxonomy',0);
INSERT INTO `registry` VALUES ('TaxonomyTermTestCase','class','modules/taxonomy/taxonomy.test','taxonomy',0);
INSERT INTO `registry` VALUES ('TaxonomyTermUnitTest','class','modules/taxonomy/taxonomy.test','taxonomy',0);
INSERT INTO `registry` VALUES ('TaxonomyThemeTestCase','class','modules/taxonomy/taxonomy.test','taxonomy',0);
INSERT INTO `registry` VALUES ('TaxonomyTokenReplaceTestCase','class','modules/taxonomy/taxonomy.test','taxonomy',0);
INSERT INTO `registry` VALUES ('TaxonomyVocabularyController','class','modules/taxonomy/taxonomy.module','taxonomy',0);
INSERT INTO `registry` VALUES ('TaxonomyVocabularyFunctionalTest','class','modules/taxonomy/taxonomy.test','taxonomy',0);
INSERT INTO `registry` VALUES ('TaxonomyVocabularyUnitTest','class','modules/taxonomy/taxonomy.test','taxonomy',0);
INSERT INTO `registry` VALUES ('TaxonomyWebTestCase','class','modules/taxonomy/taxonomy.test','taxonomy',0);
INSERT INTO `registry` VALUES ('TestingMailSystem','class','modules/system/system.mail.inc','system',0);
INSERT INTO `registry` VALUES ('TextFieldTestCase','class','modules/field/modules/text/text.test','text',0);
INSERT INTO `registry` VALUES ('TextSummaryTestCase','class','modules/field/modules/text/text.test','text',0);
INSERT INTO `registry` VALUES ('TextTranslationTestCase','class','modules/field/modules/text/text.test','text',0);
INSERT INTO `registry` VALUES ('ThemeUpdater','class','modules/system/system.updater.inc','system',0);
INSERT INTO `registry` VALUES ('TokenReplaceTestCase','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('TruncateQuery','class','includes/database/query.inc','',0);
INSERT INTO `registry` VALUES ('TruncateQuery_mysql','class','includes/database/mysql/query.inc','',0);
INSERT INTO `registry` VALUES ('TruncateQuery_sqlite','class','includes/database/sqlite/query.inc','',0);
INSERT INTO `registry` VALUES ('UpdateQuery','class','includes/database/query.inc','',0);
INSERT INTO `registry` VALUES ('UpdateQuery_pgsql','class','includes/database/pgsql/query.inc','',0);
INSERT INTO `registry` VALUES ('UpdateQuery_sqlite','class','includes/database/sqlite/query.inc','',0);
INSERT INTO `registry` VALUES ('Updater','class','includes/updater.inc','',0);
INSERT INTO `registry` VALUES ('UpdaterException','class','includes/updater.inc','',0);
INSERT INTO `registry` VALUES ('UpdaterFileTransferException','class','includes/updater.inc','',0);
INSERT INTO `registry` VALUES ('UpdateScriptFunctionalTest','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('UserAccountLinksUnitTests','class','modules/user/user.test','user',0);
INSERT INTO `registry` VALUES ('UserAdminTestCase','class','modules/user/user.test','user',0);
INSERT INTO `registry` VALUES ('UserAuthmapAssignmentTestCase','class','modules/user/user.test','user',0);
INSERT INTO `registry` VALUES ('UserAutocompleteTestCase','class','modules/user/user.test','user',0);
INSERT INTO `registry` VALUES ('UserBlocksUnitTests','class','modules/user/user.test','user',0);
INSERT INTO `registry` VALUES ('UserCancelTestCase','class','modules/user/user.test','user',0);
INSERT INTO `registry` VALUES ('UserController','class','modules/user/user.module','user',0);
INSERT INTO `registry` VALUES ('UserCreateTestCase','class','modules/user/user.test','user',0);
INSERT INTO `registry` VALUES ('UserEditedOwnAccountTestCase','class','modules/user/user.test','user',0);
INSERT INTO `registry` VALUES ('UserEditTestCase','class','modules/user/user.test','user',0);
INSERT INTO `registry` VALUES ('UserLoginTestCase','class','modules/user/user.test','user',0);
INSERT INTO `registry` VALUES ('UserPermissionsTestCase','class','modules/user/user.test','user',0);
INSERT INTO `registry` VALUES ('UserPictureTestCase','class','modules/user/user.test','user',0);
INSERT INTO `registry` VALUES ('UserRegistrationTestCase','class','modules/user/user.test','user',0);
INSERT INTO `registry` VALUES ('UserRoleAdminTestCase','class','modules/user/user.test','user',0);
INSERT INTO `registry` VALUES ('UserRolesAssignmentTestCase','class','modules/user/user.test','user',0);
INSERT INTO `registry` VALUES ('UserSaveTestCase','class','modules/user/user.test','user',0);
INSERT INTO `registry` VALUES ('UserSignatureTestCase','class','modules/user/user.test','user',0);
INSERT INTO `registry` VALUES ('UserTimeZoneFunctionalTest','class','modules/user/user.test','user',0);
INSERT INTO `registry` VALUES ('UserTokenReplaceTestCase','class','modules/user/user.test','user',0);
INSERT INTO `registry` VALUES ('UserUserSearchTestCase','class','modules/user/user.test','user',0);
INSERT INTO `registry` VALUES ('UserValidateCurrentPassCustomForm','class','modules/user/user.test','user',0);
INSERT INTO `registry` VALUES ('UserValidationTestCase','class','modules/user/user.test','user',0);
/*!40000 ALTER TABLE `registry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registry_file`
--

DROP TABLE IF EXISTS `registry_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registry_file` (
  `filename` varchar(255) NOT NULL COMMENT 'Path to the file.',
  `hash` varchar(64) NOT NULL COMMENT 'sha-256 hash of the file’s contents when last parsed.',
  PRIMARY KEY (`filename`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Files parsed to build the registry.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registry_file`
--

LOCK TABLES `registry_file` WRITE;
/*!40000 ALTER TABLE `registry_file` DISABLE KEYS */;
INSERT INTO `registry_file` VALUES ('includes/actions.inc','3e1b89b7dd2465549361915ffc50b713a8f3a568baa703f034e48b24977f83c8');
INSERT INTO `registry_file` VALUES ('includes/ajax.inc','a6a0847d63032f67c4bd06c3926c639cfafc58f52c17f31f4c8c13fa5699cc6a');
INSERT INTO `registry_file` VALUES ('includes/archiver.inc','097a78f5794237e8242b540649d824b930008027362c1359773e22c2b21cd6e5');
INSERT INTO `registry_file` VALUES ('includes/authorize.inc','bd85cb5d7bec2906e85be1b7187410680190b568e433fdcff944f74b7e1c616d');
INSERT INTO `registry_file` VALUES ('includes/batch.inc','f32d52b88dc6bd0b3117fef0057d6084fbe132afb0fbf638daaa42bce7a2a3c5');
INSERT INTO `registry_file` VALUES ('includes/batch.queue.inc','34face1f61857ec26e414712c647b06acbd5ec4437a71abf090e83cbdf691794');
INSERT INTO `registry_file` VALUES ('includes/bootstrap.inc','faeef91dec3a689471b90199da366756459f70ff9084bb78f94b755cb3b04dd4');
INSERT INTO `registry_file` VALUES ('includes/cache-install.inc','2d223093cf3740d190746d1c348607694a8475c0da91ffd2386454995a17995e');
INSERT INTO `registry_file` VALUES ('includes/cache.inc','5239bd1707257d0abdd5396d6febd34bea08dd6ceb318265f3c9b7b21b38f23f');
INSERT INTO `registry_file` VALUES ('includes/common.inc','3e60fff0c30dea3c0739e52d0cc1f30070b60f2406edcde31e71006139b40bff');
INSERT INTO `registry_file` VALUES ('includes/database/database.inc','6e508386cce4f1f26dba5e897fc99dd7a4b5cbf12f4076e979ff2a6c98137357');
INSERT INTO `registry_file` VALUES ('includes/database/log.inc','4ecbdf9022d8c612310b41af575f10b0d4c041c0fbc41c6dc7e1f2ab6eacce6b');
INSERT INTO `registry_file` VALUES ('includes/database/mysql/database.inc','b0f19ed69d68e1a43f46e10a5a3bfbf97ce72cf936379c1519ceccfa3b359584');
INSERT INTO `registry_file` VALUES ('includes/database/mysql/install.inc','6ae316941f771732fbbabed7e1d6b4cbb41b1f429dd097d04b3345aa15e461a0');
INSERT INTO `registry_file` VALUES ('includes/database/mysql/query.inc','e2a5457ec40a8f88f6a822bdc77f74865e4c02206fc733c2945c8897f46093de');
INSERT INTO `registry_file` VALUES ('includes/database/mysql/schema.inc','f71af9dda287f0f37e7bd0077b801a6d3f38c951a9c2c6ea3b71dff1b69077d3');
INSERT INTO `registry_file` VALUES ('includes/database/pgsql/database.inc','c2bf3fa2d03583f3a6c6df76dc5ee204f7d44d5c2ee451af500583d4775877e0');
INSERT INTO `registry_file` VALUES ('includes/database/pgsql/install.inc','585b80c5bbd6f134bff60d06397f15154657a577d4da8d1b181858905f09dea5');
INSERT INTO `registry_file` VALUES ('includes/database/pgsql/query.inc','cb4c84f8f1ffc73098ed71137248dcd078a505a7530e60d979d74b3a3cdaa658');
INSERT INTO `registry_file` VALUES ('includes/database/pgsql/schema.inc','1442123ab5040a55797126cfa1cf9103f7a9df22b3c23b5055c9c27e4f12d262');
INSERT INTO `registry_file` VALUES ('includes/database/pgsql/select.inc','ce06c4353d4322e519e1c90ca863e6666edc370fb3c12568fedf466334b2e2be');
INSERT INTO `registry_file` VALUES ('includes/database/prefetch.inc','8d39658800c5b648b8aafc253cd36162c22ba54febe543ad14fc50016b02ba93');
INSERT INTO `registry_file` VALUES ('includes/database/query.inc','5c7c960209b84c874e9e6bafdcdc59eeb45651b6969e7f8ba17a460294fa2256');
INSERT INTO `registry_file` VALUES ('includes/database/schema.inc','1996c5e11a984348f29baa6f19e9a995280828bdbbaa3e8c5d747dd28e93d7a2');
INSERT INTO `registry_file` VALUES ('includes/database/select.inc','f623cc9572f87b76716389d7188884f78a0aa110006e48374151c1aef31b29f0');
INSERT INTO `registry_file` VALUES ('includes/database/sqlite/database.inc','644fe9e0b31303b46b080cbc41fe4c2b3fc972071dcb34f754d7f83f0ce79083');
INSERT INTO `registry_file` VALUES ('includes/database/sqlite/install.inc','381f3db8c59837d961978ba3097bb6443534ed1659fd713aa563963fa0c42cc5');
INSERT INTO `registry_file` VALUES ('includes/database/sqlite/query.inc','61e0459c0c9252ca465b86c475d88e09ea34c8cdb28220eb37a7d44357f5474f');
INSERT INTO `registry_file` VALUES ('includes/database/sqlite/schema.inc','b43202cce5e8a637432b0d83c90b6250822b722ee033e1b6f7b3d76b92ffc9a7');
INSERT INTO `registry_file` VALUES ('includes/database/sqlite/select.inc','4ecb9d21d2f07237f7603e925519886dde0b8da82f96999b865ff0803438744e');
INSERT INTO `registry_file` VALUES ('includes/date.inc','32124baa81a1411631de23ade5615be0d81bc7c7169ea60d22f9badd333cf284');
INSERT INTO `registry_file` VALUES ('includes/entity.inc','0d3e537e907e9465ef3affe63adaf3a22889673c0618789998c09b831807e8b1');
INSERT INTO `registry_file` VALUES ('includes/errors.inc','2bb3582fbee23850aa480f9a13bf11f886cf81de3fa02545aba64a407facd982');
INSERT INTO `registry_file` VALUES ('includes/file.inc','cf898bf744766b0ee006da7a5745a8487305ffc777bacbb2cea10bf7ed788a14');
INSERT INTO `registry_file` VALUES ('includes/file.mimetypes.inc','c6078a196ca29acb4b62a3a3c336e822d2a74cbc2c9df630e539790cb8bcbbbc');
INSERT INTO `registry_file` VALUES ('includes/filetransfer/filetransfer.inc','ee9393beddc7190f7a161f5563953d1b58e355026fcc2392443a9e6b4c600531');
INSERT INTO `registry_file` VALUES ('includes/filetransfer/ftp.inc','589ebf4b8bd4a2973aa56a156ac1fa83b6c73e703391361fb573167670e0d832');
INSERT INTO `registry_file` VALUES ('includes/filetransfer/local.inc','7cbfdb46abbdf539640db27e66fb30e5265128f31002bd0dfc3af16ae01a9492');
INSERT INTO `registry_file` VALUES ('includes/filetransfer/ssh.inc','002e24a24cac133d12728bd3843868ce378681237d7fad420761af84e6efe5ad');
INSERT INTO `registry_file` VALUES ('includes/form.inc','88d2f1e41bd84dced516a392b2b0428de0e1214d6d4ddee143f473e9c57ff013');
INSERT INTO `registry_file` VALUES ('includes/graph.inc','577a50594521edecd7139fcecd6af3a941e456ea0e0577e38ee14b785422aabb');
INSERT INTO `registry_file` VALUES ('includes/image.inc','2fefbd7e73eb51eece8acd7b374b23bf77a717c1553ad83b321a7be194c9e531');
INSERT INTO `registry_file` VALUES ('includes/install.core.inc','b230ede834f21c75dc736d5f583b41b02f3c88eef37b1ee9036d294c7f9dbba2');
INSERT INTO `registry_file` VALUES ('includes/install.inc','2dda96a9169cd82e5f49c08c311a1be9decd6c259a385c57b370284072078ec5');
INSERT INTO `registry_file` VALUES ('includes/iso.inc','379c2bd8332ce03a3772787b004e9b1a4468fd23f18d1b9397902fd6d9dbf2d8');
INSERT INTO `registry_file` VALUES ('includes/language.inc','5e0595c6def071694fa500b4636d15d482dafddb612a977201b5406b813be7a6');
INSERT INTO `registry_file` VALUES ('includes/locale.inc','5e6890eaaab5acd3bda2f2d2dc6e3faa9a4a77649ca2cae4225b9d0f24b50fda');
INSERT INTO `registry_file` VALUES ('includes/lock.inc','daa62e95528f6b986b85680b600a896452bf2ce6f38921242857dcc5a3460a1b');
INSERT INTO `registry_file` VALUES ('includes/mail.inc','673b413f445966854954699ceccd0deae860c1359e2334c3bbe93e31a52dd9b0');
INSERT INTO `registry_file` VALUES ('includes/menu.inc','d9460911178cc73d72a414f5a048d5b51f754d4f2e987ee97d474dc2102f2671');
INSERT INTO `registry_file` VALUES ('includes/module.inc','ac27386cf8bfb02192580b8f51ca354a7ea30e444084203d02f2ce9285e85b60');
INSERT INTO `registry_file` VALUES ('includes/pager.inc','48733f9985fd5879b964b91b69215edb63efc30d24a222df0893d35e0096b9e6');
INSERT INTO `registry_file` VALUES ('includes/password.inc','c3fc2fef03822dfe9981bab502a37893f8865ff529ad34cf9be9a17e86add510');
INSERT INTO `registry_file` VALUES ('includes/path.inc','992d563dbd6e67f58e358176be09eb1fb75f95510a93cb45bf463ce798670bff');
INSERT INTO `registry_file` VALUES ('includes/registry.inc','ce22f7715c8037095e6b7dfb86594d3f5ca0908e0614862cc60334852ce3b971');
INSERT INTO `registry_file` VALUES ('includes/session.inc','2a904d6eb8f561b5c6b08c6e7528b76b2b8d7f1de34e9738cebe69a1a0b922b2');
INSERT INTO `registry_file` VALUES ('includes/stream_wrappers.inc','2942d0e700d46b8eae25dd72ede0e355de3b3b2ff309447fb6cbe89543370d2e');
INSERT INTO `registry_file` VALUES ('includes/tablesort.inc','3f3cb2820920f7edc0c3d046ffba4fc4e3b73a699a2492780371141cf501aa50');
INSERT INTO `registry_file` VALUES ('includes/theme.inc','b82fd541fc6b375ebc833f87eb4ee8eef4b31ee51f7fe5c5321ae831df0a73ee');
INSERT INTO `registry_file` VALUES ('includes/theme.maintenance.inc','d110314b4d943c3e965fcefe452f6873b53cd6a8844154467dfcbb2b6142dc82');
INSERT INTO `registry_file` VALUES ('includes/token.inc','015328d6573ceece0a0712fcbad890719cff8d65a37839ece36bc64e97d63466');
INSERT INTO `registry_file` VALUES ('includes/unicode.entities.inc','2b858138596d961fbaa4c6e3986e409921df7f76b6ee1b109c4af5970f1e0f54');
INSERT INTO `registry_file` VALUES ('includes/unicode.inc','5409227091e55cef4c1b0bb9c159720aecaa07e7bf2683fe7c242691aa1036cc');
INSERT INTO `registry_file` VALUES ('includes/update.inc','11b276443e4eb4515453c47608f0e019a9f90e4354f2f157502eb9258636b4e5');
INSERT INTO `registry_file` VALUES ('includes/updater.inc','1715fbda750de86ecde8abd71d61886423367d3c9a17c31138638361b1c27e51');
INSERT INTO `registry_file` VALUES ('includes/utility.inc','04865d2c973e3df62f673b68631a880dbf39fdc5e22a5935e2e6b86576fa9030');
INSERT INTO `registry_file` VALUES ('includes/xmlrpc.inc','1176a9e5b5990f8219b48c49bb858a2a980f95428aa519acea19282109e27e83');
INSERT INTO `registry_file` VALUES ('includes/xmlrpcs.inc','2df450cf2153959a4581d8e61867c587f61fcdea5dd2653e36c6a6028fc1b395');
INSERT INTO `registry_file` VALUES ('modules/block/block.test','910abf2e1b7d31e5e5330f34cf21d04e8b8d55f24cfdd7ee3e82e38bf572267e');
INSERT INTO `registry_file` VALUES ('modules/color/color.test','5cc2a668dba0b8905ca360a7bfa04e9e501b61b7a8ac88b51ecca688dda1a21e');
INSERT INTO `registry_file` VALUES ('modules/comment/comment.module','9f9d5a7b5e654276c81d3cbe0089bb990f085823e892dc26b90f825aef8faab7');
INSERT INTO `registry_file` VALUES ('modules/comment/comment.test','262c7f7982e3c3d6dea3646ad5bacc6f0611dffaeb2043675b789edc31bb19ec');
INSERT INTO `registry_file` VALUES ('modules/dashboard/dashboard.test','0472cfe50d7f5f90ba6e55003bbb6a79d8cf4791f3d39740e2f1f3df65743d79');
INSERT INTO `registry_file` VALUES ('modules/dblog/dblog.test','8538535f68ac410003a9d0776915b4ca42e61f9fec848b4d65a79dc28a43d49c');
INSERT INTO `registry_file` VALUES ('modules/field/field.attach.inc','65b6f010e3f9d1868098d771963113307b63fd6e6454c01f0086cd4c0de71414');
INSERT INTO `registry_file` VALUES ('modules/field/field.module','e4b0bab77e29904d0a95077aa3425e54bf15d8d1185bee26969bf5c59ac68698');
INSERT INTO `registry_file` VALUES ('modules/field/modules/field_sql_storage/field_sql_storage.test','fa8f69ac79f4190a612faa6d1df3075be39571da2e897265c13e219dccf65b1c');
INSERT INTO `registry_file` VALUES ('modules/field/modules/list/tests/list.test','13e32f6e649512897f4e277d88aa0dbead2a605346f581321396464ab8ad0b0c');
INSERT INTO `registry_file` VALUES ('modules/field/modules/number/number.test','fd05e554b3ec30431d11dadea24e476f1d534cbd0c2d06bb64f003adb8fbff89');
INSERT INTO `registry_file` VALUES ('modules/field/modules/options/options.test','2f2e15ab5e6da04033933af77663df220db3da30d0546327ef757968d628e43a');
INSERT INTO `registry_file` VALUES ('modules/field/modules/text/text.test','9d74c6d039f55dd7d6447a59186da8d48bf20617bfe58424612798f649797586');
INSERT INTO `registry_file` VALUES ('modules/field/tests/field.test','1b8d334223ca9e8b5cf7ebfc0727baf5552e303ee01040986e82c852bda1741a');
INSERT INTO `registry_file` VALUES ('modules/field_ui/field_ui.test','58c6515fd7b3bf1d48dbf7a8f5f414df8e74b6e525af5d3ccc852060e245526a');
INSERT INTO `registry_file` VALUES ('modules/file/tests/file.test','651e17859b7ba69958a72fa5a3b5bbca40dc53c79a7b512eb83076c81da0960d');
INSERT INTO `registry_file` VALUES ('modules/filter/filter.test','d1c4f5c10917aa93b6cc1dab58a7f3a86fe4530d21d6c8e63a8fe58a7bd7487f');
INSERT INTO `registry_file` VALUES ('modules/help/help.test','ff6d9f5fc415451951c21a07b125ff749a7cefba879c27e14bb42eb621c58f9d');
INSERT INTO `registry_file` VALUES ('modules/image/image.test','610f7e9f46a18761d53566c14e34d669d5a29b5d0380c89b6c549dec694cfe56');
INSERT INTO `registry_file` VALUES ('modules/menu/menu.test','5d584ef0191c39c11dda474a6a8f6223f6bc82cdbc41ee5742c8fe28f300949a');
INSERT INTO `registry_file` VALUES ('modules/node/node.module','cc290bd3cf407046025f88feb8d4e353e579128b101713abdb2e2c63ee637f14');
INSERT INTO `registry_file` VALUES ('modules/node/node.test','e37213792452a8f98cd0cca66396d9de27464dcc53c50c9032d1225fd794f356');
INSERT INTO `registry_file` VALUES ('modules/path/path.test','bf6a774f0d9b92a48d752eaa270f430ea21ce35e0c09da423442939ac56f9473');
INSERT INTO `registry_file` VALUES ('modules/rdf/rdf.test','358e2ae2069a15c6ba828f3428ab979632ece7aa0ba33a6a5bdbc1d065961373');
INSERT INTO `registry_file` VALUES ('modules/search/search.extender.inc','a8c42b2cac7863835f7f632c7fbfd77b6fe936d465b3bbff73b1645a99c0c9d3');
INSERT INTO `registry_file` VALUES ('modules/search/search.test','2a7af7339aae041f1ddf3916fefc58635c3101b9397ea865cf712a87034aa963');
INSERT INTO `registry_file` VALUES ('modules/shortcut/shortcut.test','0bbc6b16348442ce0aa5cd610feed80ac2b2b3887c709fc457ba0a913ae01f3b');
INSERT INTO `registry_file` VALUES ('modules/system/system.archiver.inc','faa849f3e646a910ab82fd6c8bbf0a4e6b8c60725d7ba81ec0556bd716616cd1');
INSERT INTO `registry_file` VALUES ('modules/system/system.mail.inc','b7ee9ea80059788d8b53823a91db015dfa6c2a66589a6eca6f97b99340e12d6f');
INSERT INTO `registry_file` VALUES ('modules/system/system.queue.inc','4bfc1845db9c888f3df0937a9ff6d783de77880e6301431db9eb2268b9fe572d');
INSERT INTO `registry_file` VALUES ('modules/system/system.tar.inc','743529eab763be74e8169c945e875381fd77d71e336c6d77b7d28e2dfd023a21');
INSERT INTO `registry_file` VALUES ('modules/system/system.test','1bbebd6438335e2b1b6bf4758b6a02c642a2cbe4180bb03fb7dcce2782c3f0cf');
INSERT INTO `registry_file` VALUES ('modules/system/system.updater.inc','e2eeed65b833a6215f807b113f6fb4cc3cc487e93efcb1402ed87c536d2c9ea6');
INSERT INTO `registry_file` VALUES ('modules/taxonomy/taxonomy.module','aab96a917f887d5cd09c517316ca3253d94b08b141a0946449f0a40683411401');
INSERT INTO `registry_file` VALUES ('modules/taxonomy/taxonomy.test','bf998b97d53e036d6f5a0af8a26dc78b0afa1ae37d2f4aefd4aae087a9351f08');
INSERT INTO `registry_file` VALUES ('modules/user/user.module','d4466cdad9273944d42b059607586bc155d52ca2a6b898523295159e2c5b0aa0');
INSERT INTO `registry_file` VALUES ('modules/user/user.test','9b6cc136d3a267ad039069ac040f9ec33481ef43fd1fb888929750a076302c7c');
INSERT INTO `registry_file` VALUES ('profiles/standard/standard.profile','7237f80e54061c9611c6dc4fcf6225951eedba0704694f4d801673693ba11a05');
/*!40000 ALTER TABLE `registry_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `rid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique role ID.',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT 'Unique role name.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of this role in listings and the user interface.',
  PRIMARY KEY (`rid`),
  UNIQUE KEY `name` (`name`),
  KEY `name_weight` (`name`,`weight`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Stores user roles.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (3,'administrator',2);
INSERT INTO `role` VALUES (1,'anonymous user',0);
INSERT INTO `role` VALUES (2,'authenticated user',1);
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_permission`
--

DROP TABLE IF EXISTS `role_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_permission` (
  `rid` int(10) unsigned NOT NULL COMMENT 'Foreign Key: role.rid.',
  `permission` varchar(128) NOT NULL DEFAULT '' COMMENT 'A single permission granted to the role identified by rid.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The module declaring the permission.',
  PRIMARY KEY (`rid`,`permission`),
  KEY `permission` (`permission`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the permissions assigned to user roles.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_permission`
--

LOCK TABLES `role_permission` WRITE;
/*!40000 ALTER TABLE `role_permission` DISABLE KEYS */;
INSERT INTO `role_permission` VALUES (1,'access comments','comment');
INSERT INTO `role_permission` VALUES (1,'access content','node');
INSERT INTO `role_permission` VALUES (1,'use text format filtered_html','filter');
INSERT INTO `role_permission` VALUES (2,'access comments','comment');
INSERT INTO `role_permission` VALUES (2,'access content','node');
INSERT INTO `role_permission` VALUES (2,'post comments','comment');
INSERT INTO `role_permission` VALUES (2,'skip comment approval','comment');
INSERT INTO `role_permission` VALUES (2,'use text format filtered_html','filter');
INSERT INTO `role_permission` VALUES (3,'access administration pages','system');
INSERT INTO `role_permission` VALUES (3,'access comments','comment');
INSERT INTO `role_permission` VALUES (3,'access content','node');
INSERT INTO `role_permission` VALUES (3,'access content overview','node');
INSERT INTO `role_permission` VALUES (3,'access contextual links','contextual');
INSERT INTO `role_permission` VALUES (3,'access dashboard','dashboard');
INSERT INTO `role_permission` VALUES (3,'access overlay','overlay');
INSERT INTO `role_permission` VALUES (3,'access site in maintenance mode','system');
INSERT INTO `role_permission` VALUES (3,'access site reports','system');
INSERT INTO `role_permission` VALUES (3,'access toolbar','toolbar');
INSERT INTO `role_permission` VALUES (3,'access user profiles','user');
INSERT INTO `role_permission` VALUES (3,'administer actions','system');
INSERT INTO `role_permission` VALUES (3,'administer blocks','block');
INSERT INTO `role_permission` VALUES (3,'administer comments','comment');
INSERT INTO `role_permission` VALUES (3,'administer content types','node');
INSERT INTO `role_permission` VALUES (3,'administer filters','filter');
INSERT INTO `role_permission` VALUES (3,'administer image styles','image');
INSERT INTO `role_permission` VALUES (3,'administer menu','menu');
INSERT INTO `role_permission` VALUES (3,'administer modules','system');
INSERT INTO `role_permission` VALUES (3,'administer nodes','node');
INSERT INTO `role_permission` VALUES (3,'administer permissions','user');
INSERT INTO `role_permission` VALUES (3,'administer search','search');
INSERT INTO `role_permission` VALUES (3,'administer shortcuts','shortcut');
INSERT INTO `role_permission` VALUES (3,'administer site configuration','system');
INSERT INTO `role_permission` VALUES (3,'administer software updates','system');
INSERT INTO `role_permission` VALUES (3,'administer taxonomy','taxonomy');
INSERT INTO `role_permission` VALUES (3,'administer themes','system');
INSERT INTO `role_permission` VALUES (3,'administer url aliases','path');
INSERT INTO `role_permission` VALUES (3,'administer users','user');
INSERT INTO `role_permission` VALUES (3,'block IP addresses','system');
INSERT INTO `role_permission` VALUES (3,'bypass node access','node');
INSERT INTO `role_permission` VALUES (3,'cancel account','user');
INSERT INTO `role_permission` VALUES (3,'change own username','user');
INSERT INTO `role_permission` VALUES (3,'create article content','node');
INSERT INTO `role_permission` VALUES (3,'create page content','node');
INSERT INTO `role_permission` VALUES (3,'create url aliases','path');
INSERT INTO `role_permission` VALUES (3,'customize shortcut links','shortcut');
INSERT INTO `role_permission` VALUES (3,'delete any article content','node');
INSERT INTO `role_permission` VALUES (3,'delete any page content','node');
INSERT INTO `role_permission` VALUES (3,'delete own article content','node');
INSERT INTO `role_permission` VALUES (3,'delete own page content','node');
INSERT INTO `role_permission` VALUES (3,'delete revisions','node');
INSERT INTO `role_permission` VALUES (3,'delete terms in 1','taxonomy');
INSERT INTO `role_permission` VALUES (3,'edit any article content','node');
INSERT INTO `role_permission` VALUES (3,'edit any page content','node');
INSERT INTO `role_permission` VALUES (3,'edit own article content','node');
INSERT INTO `role_permission` VALUES (3,'edit own comments','comment');
INSERT INTO `role_permission` VALUES (3,'edit own page content','node');
INSERT INTO `role_permission` VALUES (3,'edit terms in 1','taxonomy');
INSERT INTO `role_permission` VALUES (3,'post comments','comment');
INSERT INTO `role_permission` VALUES (3,'revert revisions','node');
INSERT INTO `role_permission` VALUES (3,'search content','search');
INSERT INTO `role_permission` VALUES (3,'select account cancellation method','user');
INSERT INTO `role_permission` VALUES (3,'skip comment approval','comment');
INSERT INTO `role_permission` VALUES (3,'switch shortcut sets','shortcut');
INSERT INTO `role_permission` VALUES (3,'use advanced search','search');
INSERT INTO `role_permission` VALUES (3,'use text format filtered_html','filter');
INSERT INTO `role_permission` VALUES (3,'use text format full_html','filter');
INSERT INTO `role_permission` VALUES (3,'view own unpublished content','node');
INSERT INTO `role_permission` VALUES (3,'view revisions','node');
INSERT INTO `role_permission` VALUES (3,'view the administration theme','system');
/*!40000 ALTER TABLE `role_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `search_dataset`
--

DROP TABLE IF EXISTS `search_dataset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `search_dataset` (
  `sid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Search item ID, e.g. node ID for nodes.',
  `type` varchar(16) NOT NULL COMMENT 'Type of item, e.g. node.',
  `data` longtext NOT NULL COMMENT 'List of space-separated words from the item.',
  `reindex` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Set to force node reindexing.',
  PRIMARY KEY (`sid`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores items that will be searched.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `search_dataset`
--

LOCK TABLES `search_dataset` WRITE;
/*!40000 ALTER TABLE `search_dataset` DISABLE KEYS */;
/*!40000 ALTER TABLE `search_dataset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `search_index`
--

DROP TABLE IF EXISTS `search_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `search_index` (
  `word` varchar(50) NOT NULL DEFAULT '' COMMENT 'The search_total.word that is associated with the search item.',
  `sid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The search_dataset.sid of the searchable item to which the word belongs.',
  `type` varchar(16) NOT NULL COMMENT 'The search_dataset.type of the searchable item to which the word belongs.',
  `score` float DEFAULT NULL COMMENT 'The numeric score of the word, higher being more important.',
  PRIMARY KEY (`word`,`sid`,`type`),
  KEY `sid_type` (`sid`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the search index, associating words, items and...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `search_index`
--

LOCK TABLES `search_index` WRITE;
/*!40000 ALTER TABLE `search_index` DISABLE KEYS */;
/*!40000 ALTER TABLE `search_index` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `search_node_links`
--

DROP TABLE IF EXISTS `search_node_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `search_node_links` (
  `sid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The search_dataset.sid of the searchable item containing the link to the node.',
  `type` varchar(16) NOT NULL DEFAULT '' COMMENT 'The search_dataset.type of the searchable item containing the link to the node.',
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node.nid that this item links to.',
  `caption` longtext COMMENT 'The text used to link to the node.nid.',
  PRIMARY KEY (`sid`,`type`,`nid`),
  KEY `nid` (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores items (like nodes) that link to other nodes, used...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `search_node_links`
--

LOCK TABLES `search_node_links` WRITE;
/*!40000 ALTER TABLE `search_node_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `search_node_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `search_total`
--

DROP TABLE IF EXISTS `search_total`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `search_total` (
  `word` varchar(50) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique word in the search index.',
  `count` float DEFAULT NULL COMMENT 'The count of the word in the index using Zipf’s law to equalize the probability distribution.',
  PRIMARY KEY (`word`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores search totals for words.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `search_total`
--

LOCK TABLES `search_total` WRITE;
/*!40000 ALTER TABLE `search_total` DISABLE KEYS */;
/*!40000 ALTER TABLE `search_total` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `semaphore`
--

DROP TABLE IF EXISTS `semaphore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `semaphore` (
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique name.',
  `value` varchar(255) NOT NULL DEFAULT '' COMMENT 'A value for the semaphore.',
  `expire` double NOT NULL COMMENT 'A Unix timestamp with microseconds indicating when the semaphore should expire.',
  PRIMARY KEY (`name`),
  KEY `value` (`value`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table for holding semaphores, locks, flags, etc. that...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `semaphore`
--

LOCK TABLES `semaphore` WRITE;
/*!40000 ALTER TABLE `semaphore` DISABLE KEYS */;
/*!40000 ALTER TABLE `semaphore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sequences`
--

DROP TABLE IF EXISTS `sequences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sequences` (
  `value` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The value of the sequence.',
  PRIMARY KEY (`value`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Stores IDs.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sequences`
--

LOCK TABLES `sequences` WRITE;
/*!40000 ALTER TABLE `sequences` DISABLE KEYS */;
INSERT INTO `sequences` VALUES (1);
/*!40000 ALTER TABLE `sequences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `uid` int(10) unsigned NOT NULL COMMENT 'The users.uid corresponding to a session, or 0 for anonymous user.',
  `sid` varchar(128) NOT NULL COMMENT 'A session ID. The value is generated by Drupal’s session handlers.',
  `ssid` varchar(128) NOT NULL DEFAULT '' COMMENT 'Secure session ID. The value is generated by Drupal’s session handlers.',
  `hostname` varchar(128) NOT NULL DEFAULT '' COMMENT 'The IP address that last used this session ID (sid).',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when this session last requested a page. Old records are purged by PHP automatically.',
  `cache` int(11) NOT NULL DEFAULT '0' COMMENT 'The time of this user’s last post. This is used when the site has specified a minimum_cache_lifetime. See cache_get().',
  `session` longblob COMMENT 'The serialized contents of $_SESSION, an array of name/value pairs that persists across page requests by this session ID. Drupal loads $_SESSION from here at the start of each request and saves it at the end.',
  PRIMARY KEY (`sid`,`ssid`),
  KEY `timestamp` (`timestamp`),
  KEY `uid` (`uid`),
  KEY `ssid` (`ssid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Drupal’s session handlers read and write into the...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES (0,'c5wmFSK0TIxxAqIpLv3sUzzZFGlTUfx7iyAmF_UuRJo','','127.0.0.1',1317181134,0,'batches|a:1:{i:1;b:1;}');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shortcut_set`
--

DROP TABLE IF EXISTS `shortcut_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shortcut_set` (
  `set_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'Primary Key: The menu_links.menu_name under which the set’s links are stored.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of the set.',
  PRIMARY KEY (`set_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about sets of shortcuts links.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shortcut_set`
--

LOCK TABLES `shortcut_set` WRITE;
/*!40000 ALTER TABLE `shortcut_set` DISABLE KEYS */;
INSERT INTO `shortcut_set` VALUES ('shortcut-set-1','Default');
/*!40000 ALTER TABLE `shortcut_set` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shortcut_set_users`
--

DROP TABLE IF EXISTS `shortcut_set_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shortcut_set_users` (
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The users.uid for this set.',
  `set_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'The shortcut_set.set_name that will be displayed for this user.',
  PRIMARY KEY (`uid`),
  KEY `set_name` (`set_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maps users to shortcut sets.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shortcut_set_users`
--

LOCK TABLES `shortcut_set_users` WRITE;
/*!40000 ALTER TABLE `shortcut_set_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `shortcut_set_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system`
--

DROP TABLE IF EXISTS `system`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system` (
  `filename` varchar(255) NOT NULL DEFAULT '' COMMENT 'The path of the primary file for this item, relative to the Drupal root; e.g. modules/node/node.module.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the item; e.g. node.',
  `type` varchar(12) NOT NULL DEFAULT '' COMMENT 'The type of the item, either module, theme, or theme_engine.',
  `owner` varchar(255) NOT NULL DEFAULT '' COMMENT 'A theme’s ’parent’ . Can be either a theme or an engine.',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether or not this item is enabled.',
  `bootstrap` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether this module is loaded during Drupal’s early bootstrapping phase (e.g. even before the page cache is consulted).',
  `schema_version` smallint(6) NOT NULL DEFAULT '-1' COMMENT 'The module’s database schema version number. -1 if the module is not installed (its tables do not exist); 0 or the largest N of the module’s hook_update_N() function that has either been run or existed when the module was first installed.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The order in which this module’s hooks should be invoked relative to other modules. Equal-weighted modules are ordered by name.',
  `info` blob COMMENT 'A serialized array containing information from the module’s .info file; keys can include name, description, package, version, core, dependencies, and php.',
  PRIMARY KEY (`filename`),
  KEY `system_list` (`status`,`bootstrap`,`type`,`weight`,`name`),
  KEY `type_name` (`type`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A list of all modules, themes, and theme engines that are...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system`
--

LOCK TABLES `system` WRITE;
/*!40000 ALTER TABLE `system` DISABLE KEYS */;
INSERT INTO `system` VALUES ('modules/aggregator/aggregator.module','aggregator','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:10:\"Aggregator\";s:11:\"description\";s:57:\"Aggregates syndicated content (RSS, RDF, and Atom feeds).\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:15:\"aggregator.test\";}s:9:\"configure\";s:41:\"admin/config/services/aggregator/settings\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:14:\"aggregator.css\";s:33:\"modules/aggregator/aggregator.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/aggregator/tests/aggregator_test.module','aggregator_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:23:\"Aggregator module tests\";s:11:\"description\";s:46:\"Support module for aggregator related testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/block/block.module','block','module','',1,0,7008,-5,'a:12:{s:4:\"name\";s:5:\"Block\";s:11:\"description\";s:140:\"Controls the visual building blocks a page is constructed with. Blocks are boxes of content rendered into an area, or region, of a web page.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:10:\"block.test\";}s:9:\"configure\";s:21:\"admin/structure/block\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/block/tests/block_test.module','block_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:10:\"Block test\";s:11:\"description\";s:21:\"Provides test blocks.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/blog/blog.module','blog','module','',0,0,-1,0,'a:11:{s:4:\"name\";s:4:\"Blog\";s:11:\"description\";s:25:\"Enables multi-user blogs.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:9:\"blog.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/book/book.module','book','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:4:\"Book\";s:11:\"description\";s:66:\"Allows users to create and organize related content in an outline.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:9:\"book.test\";}s:9:\"configure\";s:27:\"admin/content/book/settings\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:8:\"book.css\";s:21:\"modules/book/book.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/color/color.module','color','module','',1,0,7001,0,'a:11:{s:4:\"name\";s:5:\"Color\";s:11:\"description\";s:70:\"Allows administrators to change the color scheme of compatible themes.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:10:\"color.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/comment/comment.module','comment','module','',1,0,7008,0,'a:13:{s:4:\"name\";s:7:\"Comment\";s:11:\"description\";s:57:\"Allows users to comment on and discuss published content.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:4:\"text\";}s:5:\"files\";a:2:{i:0;s:14:\"comment.module\";i:1;s:12:\"comment.test\";}s:9:\"configure\";s:21:\"admin/content/comment\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:11:\"comment.css\";s:27:\"modules/comment/comment.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/contact/contact.module','contact','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:7:\"Contact\";s:11:\"description\";s:61:\"Enables the use of both personal and site-wide contact forms.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:12:\"contact.test\";}s:9:\"configure\";s:23:\"admin/structure/contact\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/contextual/contextual.module','contextual','module','',1,0,0,0,'a:11:{s:4:\"name\";s:16:\"Contextual links\";s:11:\"description\";s:75:\"Provides contextual links to perform actions related to elements on a page.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/dashboard/dashboard.module','dashboard','module','',1,0,0,0,'a:12:{s:4:\"name\";s:9:\"Dashboard\";s:11:\"description\";s:136:\"Provides a dashboard page in the administrative interface for organizing administrative tasks and tracking information within your site.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:5:\"files\";a:1:{i:0;s:14:\"dashboard.test\";}s:12:\"dependencies\";a:1:{i:0;s:5:\"block\";}s:9:\"configure\";s:25:\"admin/dashboard/customize\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/dblog/dblog.module','dblog','module','',1,1,7001,0,'a:11:{s:4:\"name\";s:16:\"Database logging\";s:11:\"description\";s:47:\"Logs and records system events to the database.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:10:\"dblog.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/field/field.module','field','module','',1,0,7001,0,'a:13:{s:4:\"name\";s:5:\"Field\";s:11:\"description\";s:57:\"Field API to add fields to entities like nodes and users.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:3:{i:0;s:12:\"field.module\";i:1;s:16:\"field.attach.inc\";i:2;s:16:\"tests/field.test\";}s:12:\"dependencies\";a:1:{i:0;s:17:\"field_sql_storage\";}s:8:\"required\";b:1;s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:15:\"theme/field.css\";s:29:\"modules/field/theme/field.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/field/modules/field_sql_storage/field_sql_storage.module','field_sql_storage','module','',1,0,7002,0,'a:12:{s:4:\"name\";s:17:\"Field SQL storage\";s:11:\"description\";s:37:\"Stores field data in an SQL database.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:5:\"field\";}s:5:\"files\";a:1:{i:0;s:22:\"field_sql_storage.test\";}s:8:\"required\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/field/modules/list/list.module','list','module','',1,0,7002,0,'a:11:{s:4:\"name\";s:4:\"List\";s:11:\"description\";s:69:\"Defines list field types. Use with Options to create selection lists.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:2:{i:0;s:5:\"field\";i:1;s:7:\"options\";}s:5:\"files\";a:1:{i:0;s:15:\"tests/list.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/field/modules/list/tests/list_test.module','list_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:9:\"List test\";s:11:\"description\";s:41:\"Support module for the List module tests.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:3:\"7.8\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/field/modules/number/number.module','number','module','',1,0,0,0,'a:11:{s:4:\"name\";s:6:\"Number\";s:11:\"description\";s:28:\"Defines numeric field types.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:5:\"field\";}s:5:\"files\";a:1:{i:0;s:11:\"number.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/field/modules/options/options.module','options','module','',1,0,0,0,'a:11:{s:4:\"name\";s:7:\"Options\";s:11:\"description\";s:82:\"Defines selection, check box and radio button widgets for text and numeric fields.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:5:\"field\";}s:5:\"files\";a:1:{i:0;s:12:\"options.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/field/modules/text/text.module','text','module','',1,0,7000,0,'a:13:{s:4:\"name\";s:4:\"Text\";s:11:\"description\";s:32:\"Defines simple text field types.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:5:\"field\";}s:5:\"files\";a:1:{i:0;s:9:\"text.test\";}s:8:\"required\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;s:11:\"explanation\";s:76:\"Field type(s) in use - see <a href=\"/?q=admin/reports/fields\">Field list</a>\";}');
INSERT INTO `system` VALUES ('modules/field/tests/field_test.module','field_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:14:\"Field API Test\";s:11:\"description\";s:39:\"Support module for the Field API tests.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:7:\"Testing\";s:5:\"files\";a:1:{i:0;s:21:\"field_test.entity.inc\";}s:7:\"version\";s:3:\"7.8\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/field_ui/field_ui.module','field_ui','module','',1,0,0,0,'a:11:{s:4:\"name\";s:8:\"Field UI\";s:11:\"description\";s:33:\"User interface for the Field API.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:5:\"field\";}s:5:\"files\";a:1:{i:0;s:13:\"field_ui.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/file/file.module','file','module','',1,0,0,0,'a:11:{s:4:\"name\";s:4:\"File\";s:11:\"description\";s:26:\"Defines a file field type.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:5:\"field\";}s:5:\"files\";a:1:{i:0;s:15:\"tests/file.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/file/tests/file_module_test.module','file_module_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:9:\"File test\";s:11:\"description\";s:53:\"Provides hooks for testing File module functionality.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/filter/filter.module','filter','module','',1,0,7010,0,'a:13:{s:4:\"name\";s:6:\"Filter\";s:11:\"description\";s:43:\"Filters content in preparation for display.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:11:\"filter.test\";}s:8:\"required\";b:1;s:9:\"configure\";s:28:\"admin/config/content/formats\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/forum/forum.module','forum','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:5:\"Forum\";s:11:\"description\";s:27:\"Provides discussion forums.\";s:12:\"dependencies\";a:2:{i:0;s:8:\"taxonomy\";i:1;s:7:\"comment\";}s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:10:\"forum.test\";}s:9:\"configure\";s:21:\"admin/structure/forum\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:9:\"forum.css\";s:23:\"modules/forum/forum.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/help/help.module','help','module','',1,0,0,0,'a:11:{s:4:\"name\";s:4:\"Help\";s:11:\"description\";s:35:\"Manages the display of online help.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:9:\"help.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/image/image.module','image','module','',1,0,7001,0,'a:14:{s:4:\"name\";s:5:\"Image\";s:11:\"description\";s:34:\"Provides image manipulation tools.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:4:\"file\";}s:5:\"files\";a:1:{i:0;s:10:\"image.test\";}s:9:\"configure\";s:31:\"admin/config/media/image-styles\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;s:8:\"required\";b:1;s:11:\"explanation\";s:76:\"Field type(s) in use - see <a href=\"/?q=admin/reports/fields\">Field list</a>\";}');
INSERT INTO `system` VALUES ('modules/image/tests/image_module_test.module','image_module_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:10:\"Image test\";s:11:\"description\";s:69:\"Provides hook implementations for testing Image module functionality.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:24:\"image_module_test.module\";}s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/locale/locale.module','locale','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:6:\"Locale\";s:11:\"description\";s:119:\"Adds language handling functionality and enables the translation of the user interface to languages other than English.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:11:\"locale.test\";}s:9:\"configure\";s:30:\"admin/config/regional/language\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/locale/tests/locale_test.module','locale_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:11:\"Locale Test\";s:11:\"description\";s:42:\"Support module for the locale layer tests.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:3:\"7.8\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/menu/menu.module','menu','module','',1,0,7002,0,'a:12:{s:4:\"name\";s:4:\"Menu\";s:11:\"description\";s:60:\"Allows administrators to customize the site navigation menu.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:9:\"menu.test\";}s:9:\"configure\";s:20:\"admin/structure/menu\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/node/node.module','node','module','',1,0,7012,0,'a:14:{s:4:\"name\";s:4:\"Node\";s:11:\"description\";s:66:\"Allows content to be submitted to the site and displayed on pages.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:2:{i:0;s:11:\"node.module\";i:1;s:9:\"node.test\";}s:8:\"required\";b:1;s:9:\"configure\";s:21:\"admin/structure/types\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:8:\"node.css\";s:21:\"modules/node/node.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/node/tests/node_access_test.module','node_access_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:24:\"Node module access tests\";s:11:\"description\";s:43:\"Support module for node permission testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/node/tests/node_test.module','node_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:17:\"Node module tests\";s:11:\"description\";s:40:\"Support module for node related testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/node/tests/node_test_exception.module','node_test_exception','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:27:\"Node module exception tests\";s:11:\"description\";s:50:\"Support module for node related exception testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/openid/openid.module','openid','module','',0,0,-1,0,'a:11:{s:4:\"name\";s:6:\"OpenID\";s:11:\"description\";s:48:\"Allows users to log into your site using OpenID.\";s:7:\"version\";s:3:\"7.8\";s:7:\"package\";s:4:\"Core\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:11:\"openid.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/openid/tests/openid_test.module','openid_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:21:\"OpenID dummy provider\";s:11:\"description\";s:33:\"OpenID provider used for testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:6:\"openid\";}s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/overlay/overlay.module','overlay','module','',1,1,0,0,'a:11:{s:4:\"name\";s:7:\"Overlay\";s:11:\"description\";s:59:\"Displays the Drupal administration interface in an overlay.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/path/path.module','path','module','',1,0,0,0,'a:12:{s:4:\"name\";s:4:\"Path\";s:11:\"description\";s:28:\"Allows users to rename URLs.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:9:\"path.test\";}s:9:\"configure\";s:24:\"admin/config/search/path\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/php/php.module','php','module','',0,0,-1,0,'a:11:{s:4:\"name\";s:10:\"PHP filter\";s:11:\"description\";s:50:\"Allows embedded PHP code/snippets to be evaluated.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:8:\"php.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/poll/poll.module','poll','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:4:\"Poll\";s:11:\"description\";s:95:\"Allows your site to capture votes on different topics in the form of multiple choice questions.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:9:\"poll.test\";}s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:8:\"poll.css\";s:21:\"modules/poll/poll.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/profile/profile.module','profile','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:7:\"Profile\";s:11:\"description\";s:36:\"Supports configurable user profiles.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:12:\"profile.test\";}s:9:\"configure\";s:27:\"admin/config/people/profile\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/rdf/rdf.module','rdf','module','',1,0,0,0,'a:11:{s:4:\"name\";s:3:\"RDF\";s:11:\"description\";s:148:\"Enriches your content with metadata to let other applications (e.g. search engines, aggregators) better understand its relationships and attributes.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:8:\"rdf.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/rdf/tests/rdf_test.module','rdf_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:16:\"RDF module tests\";s:11:\"description\";s:38:\"Support module for RDF module testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/search/search.module','search','module','',1,0,7000,0,'a:13:{s:4:\"name\";s:6:\"Search\";s:11:\"description\";s:36:\"Enables site-wide keyword searching.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:2:{i:0;s:19:\"search.extender.inc\";i:1;s:11:\"search.test\";}s:9:\"configure\";s:28:\"admin/config/search/settings\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:10:\"search.css\";s:25:\"modules/search/search.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/search/tests/search_embedded_form.module','search_embedded_form','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:20:\"Search embedded form\";s:11:\"description\";s:59:\"Support module for search module testing of embedded forms.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/search/tests/search_extra_type.module','search_extra_type','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:16:\"Test search type\";s:11:\"description\";s:41:\"Support module for search module testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/shortcut/shortcut.module','shortcut','module','',1,0,0,0,'a:12:{s:4:\"name\";s:8:\"Shortcut\";s:11:\"description\";s:60:\"Allows users to manage customizable lists of shortcut links.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:13:\"shortcut.test\";}s:9:\"configure\";s:36:\"admin/config/user-interface/shortcut\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/simpletest.module','simpletest','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:7:\"Testing\";s:11:\"description\";s:53:\"Provides a framework for unit and functional testing.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:42:{i:0;s:15:\"simpletest.test\";i:1;s:24:\"drupal_web_test_case.php\";i:2;s:18:\"tests/actions.test\";i:3;s:15:\"tests/ajax.test\";i:4;s:16:\"tests/batch.test\";i:5;s:20:\"tests/bootstrap.test\";i:6;s:16:\"tests/cache.test\";i:7;s:17:\"tests/common.test\";i:8;s:24:\"tests/database_test.test\";i:9;s:32:\"tests/entity_crud_hook_test.test\";i:10;s:23:\"tests/entity_query.test\";i:11;s:16:\"tests/error.test\";i:12;s:15:\"tests/file.test\";i:13;s:23:\"tests/filetransfer.test\";i:14;s:15:\"tests/form.test\";i:15;s:16:\"tests/graph.test\";i:16;s:16:\"tests/image.test\";i:17;s:15:\"tests/lock.test\";i:18;s:15:\"tests/mail.test\";i:19;s:15:\"tests/menu.test\";i:20;s:17:\"tests/module.test\";i:21;s:19:\"tests/password.test\";i:22;s:15:\"tests/path.test\";i:23;s:19:\"tests/registry.test\";i:24;s:17:\"tests/schema.test\";i:25;s:18:\"tests/session.test\";i:26;s:20:\"tests/tablesort.test\";i:27;s:16:\"tests/theme.test\";i:28;s:18:\"tests/unicode.test\";i:29;s:17:\"tests/update.test\";i:30;s:17:\"tests/xmlrpc.test\";i:31;s:26:\"tests/upgrade/upgrade.test\";i:32;s:34:\"tests/upgrade/upgrade.comment.test\";i:33;s:33:\"tests/upgrade/upgrade.filter.test\";i:34;s:32:\"tests/upgrade/upgrade.forum.test\";i:35;s:33:\"tests/upgrade/upgrade.locale.test\";i:36;s:31:\"tests/upgrade/upgrade.menu.test\";i:37;s:31:\"tests/upgrade/upgrade.node.test\";i:38;s:35:\"tests/upgrade/upgrade.taxonomy.test\";i:39;s:39:\"tests/upgrade/upgrade.translatable.test\";i:40;s:33:\"tests/upgrade/upgrade.upload.test\";i:41;s:31:\"tests/upgrade/upgrade.user.test\";}s:9:\"configure\";s:41:\"admin/config/development/testing/settings\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/actions_loop_test.module','actions_loop_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:17:\"Actions loop test\";s:11:\"description\";s:39:\"Support module for action loop testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/ajax_forms_test.module','ajax_forms_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:26:\"AJAX form test mock module\";s:11:\"description\";s:25:\"Test for AJAX form calls.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:3:\"7.8\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/ajax_test.module','ajax_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:9:\"AJAX Test\";s:11:\"description\";s:40:\"Support module for AJAX framework tests.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/batch_test.module','batch_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:14:\"Batch API test\";s:11:\"description\";s:35:\"Support module for Batch API tests.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/common_test.module','common_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:11:\"Common Test\";s:11:\"description\";s:32:\"Support module for Common tests.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:1:{s:15:\"common_test.css\";s:40:\"modules/simpletest/tests/common_test.css\";}s:5:\"print\";a:1:{s:21:\"common_test.print.css\";s:46:\"modules/simpletest/tests/common_test.print.css\";}}s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/common_test_cron_helper.module','common_test_cron_helper','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:23:\"Common Test Cron Helper\";s:11:\"description\";s:56:\"Helper module for CronRunTestCase::testCronExceptions().\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/database_test.module','database_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:13:\"Database Test\";s:11:\"description\";s:40:\"Support module for Database layer tests.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:3:\"7.8\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/drupal_system_listing_compatible_test/drupal_system_listing_compatible_test.module','drupal_system_listing_compatible_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:37:\"Drupal system listing compatible test\";s:11:\"description\";s:62:\"Support module for testing the drupal_system_listing function.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/drupal_system_listing_incompatible_test/drupal_system_listing_incompatible_test.module','drupal_system_listing_incompatible_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:39:\"Drupal system listing incompatible test\";s:11:\"description\";s:62:\"Support module for testing the drupal_system_listing function.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/entity_cache_test.module','entity_cache_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:17:\"Entity cache test\";s:11:\"description\";s:40:\"Support module for testing entity cache.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:28:\"entity_cache_test_dependency\";}s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/entity_cache_test_dependency.module','entity_cache_test_dependency','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:28:\"Entity cache test dependency\";s:11:\"description\";s:51:\"Support dependency module for testing entity cache.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/entity_crud_hook_test.module','entity_crud_hook_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:22:\"Entity CRUD Hooks Test\";s:11:\"description\";s:35:\"Support module for CRUD hook tests.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:3:\"7.8\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/error_test.module','error_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:10:\"Error test\";s:11:\"description\";s:47:\"Support module for error and exception testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/file_test.module','file_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:9:\"File test\";s:11:\"description\";s:39:\"Support module for file handling tests.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:16:\"file_test.module\";}s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/filter_test.module','filter_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:18:\"Filter test module\";s:11:\"description\";s:33:\"Tests filter hooks and functions.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/form_test.module','form_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:12:\"FormAPI Test\";s:11:\"description\";s:34:\"Support module for Form API tests.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/image_test.module','image_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:10:\"Image test\";s:11:\"description\";s:39:\"Support module for image toolkit tests.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/menu_test.module','menu_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:15:\"Hook menu tests\";s:11:\"description\";s:37:\"Support module for menu hook testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/module_test.module','module_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:11:\"Module test\";s:11:\"description\";s:41:\"Support module for module system testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/requirements1_test.module','requirements1_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:19:\"Requirements 1 Test\";s:11:\"description\";s:80:\"Tests that a module is not installed when it fails hook_requirements(\'install\').\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/requirements2_test.module','requirements2_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:19:\"Requirements 2 Test\";s:11:\"description\";s:98:\"Tests that a module is not installed when the one it depends on fails hook_requirements(\'install).\";s:12:\"dependencies\";a:2:{i:0;s:18:\"requirements1_test\";i:1;s:7:\"comment\";}s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/session_test.module','session_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:12:\"Session test\";s:11:\"description\";s:40:\"Support module for session data testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/system_dependencies_test.module','system_dependencies_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:22:\"System dependency test\";s:11:\"description\";s:47:\"Support module for testing system dependencies.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:12:\"dependencies\";a:1:{i:0;s:19:\"_missing_dependency\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/system_test.module','system_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:11:\"System test\";s:11:\"description\";s:34:\"Support module for system testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:18:\"system_test.module\";}s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/taxonomy_test.module','taxonomy_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:20:\"Taxonomy test module\";s:11:\"description\";s:45:\"\"Tests functions and hooks not used in core\".\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:12:\"dependencies\";a:1:{i:0;s:8:\"taxonomy\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/theme_test.module','theme_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:10:\"Theme test\";s:11:\"description\";s:40:\"Support module for theme system testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/update_test_1.module','update_test_1','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:11:\"Update test\";s:11:\"description\";s:34:\"Support module for update testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/update_test_2.module','update_test_2','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:11:\"Update test\";s:11:\"description\";s:34:\"Support module for update testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/update_test_3.module','update_test_3','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:11:\"Update test\";s:11:\"description\";s:34:\"Support module for update testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/url_alter_test.module','url_alter_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:15:\"Url_alter tests\";s:11:\"description\";s:45:\"A support modules for url_alter hook testing.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:3:\"7.8\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/xmlrpc_test.module','xmlrpc_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:12:\"XML-RPC Test\";s:11:\"description\";s:75:\"Support module for XML-RPC tests according to the validator1 specification.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/statistics/statistics.module','statistics','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:10:\"Statistics\";s:11:\"description\";s:37:\"Logs access statistics for your site.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:15:\"statistics.test\";}s:9:\"configure\";s:30:\"admin/config/system/statistics\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/syslog/syslog.module','syslog','module','',0,0,-1,0,'a:11:{s:4:\"name\";s:6:\"Syslog\";s:11:\"description\";s:41:\"Logs and records system events to syslog.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:11:\"syslog.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/system/system.module','system','module','',1,0,7071,0,'a:13:{s:4:\"name\";s:6:\"System\";s:11:\"description\";s:54:\"Handles general site configuration for administrators.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:6:{i:0;s:19:\"system.archiver.inc\";i:1;s:15:\"system.mail.inc\";i:2;s:16:\"system.queue.inc\";i:3;s:14:\"system.tar.inc\";i:4;s:18:\"system.updater.inc\";i:5;s:11:\"system.test\";}s:8:\"required\";b:1;s:9:\"configure\";s:19:\"admin/config/system\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/taxonomy/taxonomy.module','taxonomy','module','',1,0,7010,0,'a:14:{s:4:\"name\";s:8:\"Taxonomy\";s:11:\"description\";s:38:\"Enables the categorization of content.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:7:\"options\";}s:5:\"files\";a:2:{i:0;s:15:\"taxonomy.module\";i:1;s:13:\"taxonomy.test\";}s:9:\"configure\";s:24:\"admin/structure/taxonomy\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;s:8:\"required\";b:1;s:11:\"explanation\";s:76:\"Field type(s) in use - see <a href=\"/?q=admin/reports/fields\">Field list</a>\";}');
INSERT INTO `system` VALUES ('modules/toolbar/toolbar.module','toolbar','module','',1,0,0,0,'a:11:{s:4:\"name\";s:7:\"Toolbar\";s:11:\"description\";s:99:\"Provides a toolbar that shows the top-level administration menu items and links from other modules.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/tracker/tracker.module','tracker','module','',0,0,-1,0,'a:11:{s:4:\"name\";s:7:\"Tracker\";s:11:\"description\";s:45:\"Enables tracking of recent content for users.\";s:12:\"dependencies\";a:1:{i:0;s:7:\"comment\";}s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:12:\"tracker.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/translation/tests/translation_test.module','translation_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:24:\"Content Translation Test\";s:11:\"description\";s:49:\"Support module for the content translation tests.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:3:\"7.8\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/translation/translation.module','translation','module','',0,0,-1,0,'a:11:{s:4:\"name\";s:19:\"Content translation\";s:11:\"description\";s:57:\"Allows content to be translated into different languages.\";s:12:\"dependencies\";a:1:{i:0;s:6:\"locale\";}s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:16:\"translation.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/trigger/tests/trigger_test.module','trigger_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:12:\"Trigger Test\";s:11:\"description\";s:33:\"Support module for Trigger tests.\";s:7:\"package\";s:7:\"Testing\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"version\";s:3:\"7.8\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/trigger/trigger.module','trigger','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:7:\"Trigger\";s:11:\"description\";s:90:\"Enables actions to be fired on certain system events, such as when new content is created.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:12:\"trigger.test\";}s:9:\"configure\";s:23:\"admin/structure/trigger\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/update/tests/aaa_update_test.module','aaa_update_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:15:\"AAA Update test\";s:11:\"description\";s:41:\"Support module for update module testing.\";s:7:\"package\";s:7:\"Testing\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"version\";s:3:\"7.8\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/update/tests/bbb_update_test.module','bbb_update_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:15:\"BBB Update test\";s:11:\"description\";s:41:\"Support module for update module testing.\";s:7:\"package\";s:7:\"Testing\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"version\";s:3:\"7.8\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/update/tests/ccc_update_test.module','ccc_update_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:15:\"CCC Update test\";s:11:\"description\";s:41:\"Support module for update module testing.\";s:7:\"package\";s:7:\"Testing\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"version\";s:3:\"7.8\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/update/tests/update_test.module','update_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:11:\"Update test\";s:11:\"description\";s:41:\"Support module for update module testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/update/update.module','update','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:14:\"Update manager\";s:11:\"description\";s:104:\"Checks for available updates, and can securely install or update modules and themes via a web interface.\";s:7:\"version\";s:3:\"7.8\";s:7:\"package\";s:4:\"Core\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:11:\"update.test\";}s:9:\"configure\";s:30:\"admin/reports/updates/settings\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/user/tests/user_form_test.module','user_form_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:22:\"User module form tests\";s:11:\"description\";s:37:\"Support module for user form testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/user/user.module','user','module','',1,0,7017,0,'a:14:{s:4:\"name\";s:4:\"User\";s:11:\"description\";s:47:\"Manages the user registration and login system.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:2:{i:0;s:11:\"user.module\";i:1;s:9:\"user.test\";}s:8:\"required\";b:1;s:9:\"configure\";s:19:\"admin/config/people\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:8:\"user.css\";s:21:\"modules/user/user.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('profiles/standard/standard.profile','standard','module','',1,0,0,1000,'a:14:{s:4:\"name\";s:8:\"Standard\";s:11:\"description\";s:51:\"Install with commonly used features pre-configured.\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:21:{i:0;s:5:\"block\";i:1;s:5:\"color\";i:2;s:7:\"comment\";i:3;s:10:\"contextual\";i:4;s:9:\"dashboard\";i:5;s:4:\"help\";i:6;s:5:\"image\";i:7;s:4:\"list\";i:8;s:4:\"menu\";i:9;s:6:\"number\";i:10;s:7:\"options\";i:11;s:4:\"path\";i:12;s:8:\"taxonomy\";i:13;s:5:\"dblog\";i:14;s:6:\"search\";i:15;s:8:\"shortcut\";i:16;s:7:\"toolbar\";i:17;s:7:\"overlay\";i:18;s:8:\"field_ui\";i:19;s:4:\"file\";i:20;s:3:\"rdf\";}s:5:\"files\";a:1:{i:0;s:16:\"standard.profile\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:7:\"package\";s:5:\"Other\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;s:6:\"hidden\";b:1;s:8:\"required\";b:1;s:17:\"distribution_name\";s:6:\"Drupal\";}');
INSERT INTO `system` VALUES ('themes/bartik/bartik.info','bartik','theme','themes/engines/phptemplate/phptemplate.engine',1,0,-1,0,'a:18:{s:4:\"name\";s:6:\"Bartik\";s:11:\"description\";s:48:\"A flexible, recolorable theme with many regions.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:3:{s:14:\"css/layout.css\";s:28:\"themes/bartik/css/layout.css\";s:13:\"css/style.css\";s:27:\"themes/bartik/css/style.css\";s:14:\"css/colors.css\";s:28:\"themes/bartik/css/colors.css\";}s:5:\"print\";a:1:{s:13:\"css/print.css\";s:27:\"themes/bartik/css/print.css\";}}s:7:\"regions\";a:20:{s:6:\"header\";s:6:\"Header\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:11:\"highlighted\";s:11:\"Highlighted\";s:8:\"featured\";s:8:\"Featured\";s:7:\"content\";s:7:\"Content\";s:13:\"sidebar_first\";s:13:\"Sidebar first\";s:14:\"sidebar_second\";s:14:\"Sidebar second\";s:14:\"triptych_first\";s:14:\"Triptych first\";s:15:\"triptych_middle\";s:15:\"Triptych middle\";s:13:\"triptych_last\";s:13:\"Triptych last\";s:18:\"footer_firstcolumn\";s:19:\"Footer first column\";s:19:\"footer_secondcolumn\";s:20:\"Footer second column\";s:18:\"footer_thirdcolumn\";s:19:\"Footer third column\";s:19:\"footer_fourthcolumn\";s:20:\"Footer fourth column\";s:6:\"footer\";s:6:\"Footer\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"settings\";a:1:{s:20:\"shortcut_module_link\";s:1:\"0\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:6:\"engine\";s:11:\"phptemplate\";s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:28:\"themes/bartik/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}');
INSERT INTO `system` VALUES ('themes/garland/garland.info','garland','theme','themes/engines/phptemplate/phptemplate.engine',0,0,-1,0,'a:18:{s:4:\"name\";s:7:\"Garland\";s:11:\"description\";s:111:\"A multi-column theme which can be configured to modify colors and switch between fixed and fluid width layouts.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:1:{s:9:\"style.css\";s:24:\"themes/garland/style.css\";}s:5:\"print\";a:1:{s:9:\"print.css\";s:24:\"themes/garland/print.css\";}}s:8:\"settings\";a:1:{s:13:\"garland_width\";s:5:\"fluid\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:29:\"themes/garland/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}');
INSERT INTO `system` VALUES ('themes/seven/seven.info','seven','theme','themes/engines/phptemplate/phptemplate.engine',1,0,-1,0,'a:18:{s:4:\"name\";s:5:\"Seven\";s:11:\"description\";s:65:\"A simple one-column, tableless, fluid width administration theme.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:1:{s:6:\"screen\";a:2:{s:9:\"reset.css\";s:22:\"themes/seven/reset.css\";s:9:\"style.css\";s:22:\"themes/seven/style.css\";}}s:8:\"settings\";a:1:{s:20:\"shortcut_module_link\";s:1:\"1\";}s:7:\"regions\";a:8:{s:7:\"content\";s:7:\"Content\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:13:\"sidebar_first\";s:13:\"First sidebar\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:14:\"regions_hidden\";a:3:{i:0;s:13:\"sidebar_first\";i:1;s:8:\"page_top\";i:2;s:11:\"page_bottom\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:6:\"engine\";s:11:\"phptemplate\";s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:27:\"themes/seven/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}');
INSERT INTO `system` VALUES ('themes/stark/stark.info','stark','theme','themes/engines/phptemplate/phptemplate.engine',0,0,-1,0,'a:17:{s:4:\"name\";s:5:\"Stark\";s:11:\"description\";s:208:\"This theme demonstrates Drupal\'s default HTML markup and CSS styles. To learn how to build your own theme and override Drupal\'s default code, see the <a href=\"http://drupal.org/theme-guide\">Theming Guide</a>.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:3:\"7.8\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:10:\"layout.css\";s:23:\"themes/stark/layout.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:27:\"themes/stark/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}');
INSERT INTO `system` VALUES ('themes/tests/test_theme/test_theme.info','test_theme','theme','themes/engines/phptemplate/phptemplate.engine',0,0,-1,0,'a:17:{s:4:\"name\";s:10:\"Test theme\";s:11:\"description\";s:34:\"Theme for testing the theme system\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:15:\"system.base.css\";s:39:\"themes/tests/test_theme/system.base.css\";}}s:7:\"version\";s:3:\"7.8\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:38:\"themes/tests/test_theme/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}');
INSERT INTO `system` VALUES ('themes/tests/update_test_basetheme/update_test_basetheme.info','update_test_basetheme','theme','themes/engines/phptemplate/phptemplate.engine',0,0,-1,0,'a:17:{s:4:\"name\";s:22:\"Update test base theme\";s:11:\"description\";s:63:\"Test theme which acts as a base theme for other test subthemes.\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"version\";s:3:\"7.8\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:49:\"themes/tests/update_test_basetheme/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:11:\"stylesheets\";a:0:{}s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}');
INSERT INTO `system` VALUES ('themes/tests/update_test_subtheme/update_test_subtheme.info','update_test_subtheme','theme','themes/engines/phptemplate/phptemplate.engine',0,0,-1,0,'a:18:{s:4:\"name\";s:20:\"Update test subtheme\";s:11:\"description\";s:62:\"Test theme which uses update_test_basetheme as the base theme.\";s:4:\"core\";s:3:\"7.x\";s:10:\"base theme\";s:21:\"update_test_basetheme\";s:6:\"hidden\";b:1;s:7:\"version\";s:3:\"7.8\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1314817616\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:48:\"themes/tests/update_test_subtheme/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:11:\"stylesheets\";a:0:{}s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}');
/*!40000 ALTER TABLE `system` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taxonomy_index`
--

DROP TABLE IF EXISTS `taxonomy_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taxonomy_index` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node.nid this record tracks.',
  `tid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The term ID.',
  `sticky` tinyint(4) DEFAULT '0' COMMENT 'Boolean indicating whether the node is sticky.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the node was created.',
  KEY `term_node` (`tid`,`sticky`,`created`),
  KEY `nid` (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maintains denormalized information about node/term...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taxonomy_index`
--

LOCK TABLES `taxonomy_index` WRITE;
/*!40000 ALTER TABLE `taxonomy_index` DISABLE KEYS */;
/*!40000 ALTER TABLE `taxonomy_index` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taxonomy_term_data`
--

DROP TABLE IF EXISTS `taxonomy_term_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taxonomy_term_data` (
  `tid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique term ID.',
  `vid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The taxonomy_vocabulary.vid of the vocabulary to which the term is assigned.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The term name.',
  `description` longtext COMMENT 'A description of the term.',
  `format` varchar(255) DEFAULT NULL COMMENT 'The filter_format.format of the description.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of this term in relation to other terms.',
  PRIMARY KEY (`tid`),
  KEY `taxonomy_tree` (`vid`,`weight`,`name`),
  KEY `vid_name` (`vid`,`name`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores term information.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taxonomy_term_data`
--

LOCK TABLES `taxonomy_term_data` WRITE;
/*!40000 ALTER TABLE `taxonomy_term_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `taxonomy_term_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taxonomy_term_hierarchy`
--

DROP TABLE IF EXISTS `taxonomy_term_hierarchy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taxonomy_term_hierarchy` (
  `tid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: The taxonomy_term_data.tid of the term.',
  `parent` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: The taxonomy_term_data.tid of the term’s parent. 0 indicates no parent.',
  PRIMARY KEY (`tid`,`parent`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the hierarchical relationship between terms.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taxonomy_term_hierarchy`
--

LOCK TABLES `taxonomy_term_hierarchy` WRITE;
/*!40000 ALTER TABLE `taxonomy_term_hierarchy` DISABLE KEYS */;
/*!40000 ALTER TABLE `taxonomy_term_hierarchy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taxonomy_vocabulary`
--

DROP TABLE IF EXISTS `taxonomy_vocabulary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taxonomy_vocabulary` (
  `vid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique vocabulary ID.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the vocabulary.',
  `machine_name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The vocabulary machine name.',
  `description` longtext COMMENT 'Description of the vocabulary.',
  `hierarchy` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The type of hierarchy allowed within the vocabulary. (0 = disabled, 1 = single, 2 = multiple)',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The module which created the vocabulary.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of this vocabulary in relation to other vocabularies.',
  PRIMARY KEY (`vid`),
  UNIQUE KEY `machine_name` (`machine_name`),
  KEY `list` (`weight`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Stores vocabulary information.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taxonomy_vocabulary`
--

LOCK TABLES `taxonomy_vocabulary` WRITE;
/*!40000 ALTER TABLE `taxonomy_vocabulary` DISABLE KEYS */;
INSERT INTO `taxonomy_vocabulary` VALUES (1,'Tags','tags','Use tags to group articles on similar topics into categories.',0,'taxonomy',0);
/*!40000 ALTER TABLE `taxonomy_vocabulary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `url_alias`
--

DROP TABLE IF EXISTS `url_alias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `url_alias` (
  `pid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'A unique path alias identifier.',
  `source` varchar(255) NOT NULL DEFAULT '' COMMENT 'The Drupal path this alias is for; e.g. node/12.',
  `alias` varchar(255) NOT NULL DEFAULT '' COMMENT 'The alias for this path; e.g. title-of-the-story.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The language this alias is for; if ’und’, the alias will be used for unknown languages. Each Drupal path can have an alias for each supported language.',
  PRIMARY KEY (`pid`),
  KEY `alias_language_pid` (`alias`,`language`,`pid`),
  KEY `source_language_pid` (`source`,`language`,`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A list of URL aliases for Drupal paths; a user may visit...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `url_alias`
--

LOCK TABLES `url_alias` WRITE;
/*!40000 ALTER TABLE `url_alias` DISABLE KEYS */;
/*!40000 ALTER TABLE `url_alias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: Unique user ID.',
  `name` varchar(60) NOT NULL DEFAULT '' COMMENT 'Unique user name.',
  `pass` varchar(128) NOT NULL DEFAULT '' COMMENT 'User’s password (hashed).',
  `mail` varchar(254) DEFAULT '' COMMENT 'User’s e-mail address.',
  `theme` varchar(255) NOT NULL DEFAULT '' COMMENT 'User’s default theme.',
  `signature` varchar(255) NOT NULL DEFAULT '' COMMENT 'User’s signature.',
  `signature_format` varchar(255) DEFAULT NULL COMMENT 'The filter_format.format of the signature.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp for when user was created.',
  `access` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp for previous time user accessed the site.',
  `login` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp for user’s last login.',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Whether the user is active(1) or blocked(0).',
  `timezone` varchar(32) DEFAULT NULL COMMENT 'User’s time zone.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'User’s default language.',
  `picture` int(11) NOT NULL DEFAULT '0' COMMENT 'Foreign key: file_managed.fid of user’s picture.',
  `init` varchar(254) DEFAULT '' COMMENT 'E-mail address used for initial account creation.',
  `data` longblob COMMENT 'A serialized array of name value pairs that are related to the user. Any form values posted during user edit are stored and are loaded into the $user object during user_load(). Use of this field is discouraged and it will likely disappear in a future...',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `name` (`name`),
  KEY `access` (`access`),
  KEY `created` (`created`),
  KEY `mail` (`mail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores user data.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (0,'','','','','',NULL,0,0,0,0,NULL,'',0,'',NULL);
INSERT INTO `users` VALUES (1,'placeholder-for-uid-1','','placeholder-for-uid-1','','',NULL,1317181134,0,0,1,NULL,'',0,'',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_roles`
--

DROP TABLE IF EXISTS `users_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_roles` (
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: users.uid for user.',
  `rid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: role.rid for role.',
  PRIMARY KEY (`uid`,`rid`),
  KEY `rid` (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maps users to roles.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_roles`
--

LOCK TABLES `users_roles` WRITE;
/*!40000 ALTER TABLE `users_roles` DISABLE KEYS */;
INSERT INTO `users_roles` VALUES (1,3);
/*!40000 ALTER TABLE `users_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `variable`
--

DROP TABLE IF EXISTS `variable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `variable` (
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT 'The name of the variable.',
  `value` longblob NOT NULL COMMENT 'The value of the variable.',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Named variable/value pairs created by Drupal core or any...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `variable`
--

LOCK TABLES `variable` WRITE;
/*!40000 ALTER TABLE `variable` DISABLE KEYS */;
INSERT INTO `variable` VALUES ('admin_theme','s:5:\"seven\";');
INSERT INTO `variable` VALUES ('comment_page','i:0;');
INSERT INTO `variable` VALUES ('cron_key','s:43:\"BFZcTbhF4gFM4RaOvTJZ1kYUrn6XrlwpyjuEjozt0-c\";');
INSERT INTO `variable` VALUES ('css_js_query_string','s:6:\"ls7rhi\";');
INSERT INTO `variable` VALUES ('drupal_private_key','s:43:\"kBP4FdIS3UTfVXgo3ZGdpwnB9uogHlwJTQAJfzvpXVM\";');
INSERT INTO `variable` VALUES ('filter_fallback_format','s:10:\"plain_text\";');
INSERT INTO `variable` VALUES ('install_task','s:23:\"install_profile_modules\";');
INSERT INTO `variable` VALUES ('menu_expanded','a:0:{}');
INSERT INTO `variable` VALUES ('menu_masks','a:34:{i:0;i:501;i:1;i:493;i:2;i:250;i:3;i:247;i:4;i:246;i:5;i:245;i:6;i:125;i:7;i:123;i:8;i:122;i:9;i:121;i:10;i:117;i:11;i:63;i:12;i:62;i:13;i:61;i:14;i:60;i:15;i:59;i:16;i:58;i:17;i:44;i:18;i:31;i:19;i:30;i:20;i:29;i:21;i:28;i:22;i:24;i:23;i:21;i:24;i:15;i:25;i:14;i:26;i:13;i:27;i:11;i:28;i:7;i:29;i:6;i:30;i:5;i:31;i:3;i:32;i:2;i:33;i:1;}');
INSERT INTO `variable` VALUES ('node_admin_theme','s:1:\"1\";');
INSERT INTO `variable` VALUES ('node_options_page','a:1:{i:0;s:6:\"status\";}');
INSERT INTO `variable` VALUES ('node_submitted_page','b:0;');
INSERT INTO `variable` VALUES ('path_alias_whitelist','a:0:{}');
INSERT INTO `variable` VALUES ('theme_default','s:6:\"bartik\";');
INSERT INTO `variable` VALUES ('user_admin_role','s:1:\"3\";');
INSERT INTO `variable` VALUES ('user_pictures','s:1:\"1\";');
INSERT INTO `variable` VALUES ('user_picture_dimensions','s:9:\"1024x1024\";');
INSERT INTO `variable` VALUES ('user_picture_file_size','s:3:\"800\";');
INSERT INTO `variable` VALUES ('user_picture_style','s:9:\"thumbnail\";');
INSERT INTO `variable` VALUES ('user_register','i:2;');
/*!40000 ALTER TABLE `variable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `watchdog`
--

DROP TABLE IF EXISTS `watchdog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `watchdog` (
  `wid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique watchdog event ID.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid of the user who triggered the event.',
  `type` varchar(64) NOT NULL DEFAULT '' COMMENT 'Type of log message, for example "user" or "page not found."',
  `message` longtext NOT NULL COMMENT 'Text of log message to be passed into the t() function.',
  `variables` longblob NOT NULL COMMENT 'Serialized array of variables that match the message string and that is passed into the t() function.',
  `severity` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The severity level of the event; ranges from 0 (Emergency) to 7 (Debug)',
  `link` varchar(255) DEFAULT '' COMMENT 'Link to view the result of the event.',
  `location` text NOT NULL COMMENT 'URL of the origin of the event.',
  `referer` text COMMENT 'URL of referring page.',
  `hostname` varchar(128) NOT NULL DEFAULT '' COMMENT 'Hostname of the user who triggered the event.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'Unix timestamp of when event occurred.',
  PRIMARY KEY (`wid`),
  KEY `type` (`type`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8 COMMENT='Table that contains logs of all system events.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `watchdog`
--

LOCK TABLES `watchdog` WRITE;
/*!40000 ALTER TABLE `watchdog` DISABLE KEYS */;
INSERT INTO `watchdog` VALUES (1,0,'system','%module module installed.','a:1:{s:7:\"%module\";s:5:\"dblog\";}',6,'','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&id=1&op=do','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&op=start&id=1','127.0.0.1',1317181144);
INSERT INTO `watchdog` VALUES (2,0,'system','%module module enabled.','a:1:{s:7:\"%module\";s:5:\"dblog\";}',6,'','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&id=1&op=do','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&op=start&id=1','127.0.0.1',1317181144);
INSERT INTO `watchdog` VALUES (3,0,'system','%module module installed.','a:1:{s:7:\"%module\";s:8:\"field_ui\";}',6,'','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&id=1&op=do','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&op=start&id=1','127.0.0.1',1317181146);
INSERT INTO `watchdog` VALUES (4,0,'system','%module module enabled.','a:1:{s:7:\"%module\";s:8:\"field_ui\";}',6,'','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&id=1&op=do','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&op=start&id=1','127.0.0.1',1317181146);
INSERT INTO `watchdog` VALUES (5,0,'system','%module module installed.','a:1:{s:7:\"%module\";s:4:\"file\";}',6,'','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&id=1&op=do','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&op=start&id=1','127.0.0.1',1317181146);
INSERT INTO `watchdog` VALUES (6,0,'system','%module module enabled.','a:1:{s:7:\"%module\";s:4:\"file\";}',6,'','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&id=1&op=do','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&op=start&id=1','127.0.0.1',1317181146);
INSERT INTO `watchdog` VALUES (7,0,'system','%module module installed.','a:1:{s:7:\"%module\";s:7:\"options\";}',6,'','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&id=1&op=do','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&op=start&id=1','127.0.0.1',1317181146);
INSERT INTO `watchdog` VALUES (8,0,'system','%module module enabled.','a:1:{s:7:\"%module\";s:7:\"options\";}',6,'','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&id=1&op=do','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&op=start&id=1','127.0.0.1',1317181146);
INSERT INTO `watchdog` VALUES (9,0,'system','%module module installed.','a:1:{s:7:\"%module\";s:8:\"taxonomy\";}',6,'','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&id=1&op=do','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&op=start&id=1','127.0.0.1',1317181146);
INSERT INTO `watchdog` VALUES (10,0,'system','%module module enabled.','a:1:{s:7:\"%module\";s:8:\"taxonomy\";}',6,'','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&id=1&op=do','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&op=start&id=1','127.0.0.1',1317181146);
INSERT INTO `watchdog` VALUES (11,0,'system','%module module installed.','a:1:{s:7:\"%module\";s:4:\"help\";}',6,'','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&id=1&op=do','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&op=start&id=1','127.0.0.1',1317181147);
INSERT INTO `watchdog` VALUES (12,0,'system','%module module enabled.','a:1:{s:7:\"%module\";s:4:\"help\";}',6,'','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&id=1&op=do','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&op=start&id=1','127.0.0.1',1317181147);
INSERT INTO `watchdog` VALUES (13,0,'system','%module module installed.','a:1:{s:7:\"%module\";s:5:\"image\";}',6,'','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&id=1&op=do','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&op=start&id=1','127.0.0.1',1317181147);
INSERT INTO `watchdog` VALUES (14,0,'system','%module module enabled.','a:1:{s:7:\"%module\";s:5:\"image\";}',6,'','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&id=1&op=do','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&op=start&id=1','127.0.0.1',1317181147);
INSERT INTO `watchdog` VALUES (15,0,'system','%module module installed.','a:1:{s:7:\"%module\";s:4:\"list\";}',6,'','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&id=1&op=do','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&op=start&id=1','127.0.0.1',1317181147);
INSERT INTO `watchdog` VALUES (16,0,'system','%module module enabled.','a:1:{s:7:\"%module\";s:4:\"list\";}',6,'','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&id=1&op=do','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&op=start&id=1','127.0.0.1',1317181147);
INSERT INTO `watchdog` VALUES (17,0,'system','%module module installed.','a:1:{s:7:\"%module\";s:4:\"menu\";}',6,'','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&id=1&op=do','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&op=start&id=1','127.0.0.1',1317181147);
INSERT INTO `watchdog` VALUES (18,0,'system','%module module enabled.','a:1:{s:7:\"%module\";s:4:\"menu\";}',6,'','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&id=1&op=do','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&op=start&id=1','127.0.0.1',1317181147);
INSERT INTO `watchdog` VALUES (19,0,'system','%module module installed.','a:1:{s:7:\"%module\";s:6:\"number\";}',6,'','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&id=1&op=do','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&op=start&id=1','127.0.0.1',1317181151);
INSERT INTO `watchdog` VALUES (20,0,'system','%module module enabled.','a:1:{s:7:\"%module\";s:6:\"number\";}',6,'','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&id=1&op=do','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&op=start&id=1','127.0.0.1',1317181151);
INSERT INTO `watchdog` VALUES (21,0,'system','%module module installed.','a:1:{s:7:\"%module\";s:7:\"overlay\";}',6,'','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&id=1&op=do','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&op=start&id=1','127.0.0.1',1317181151);
INSERT INTO `watchdog` VALUES (22,0,'system','%module module enabled.','a:1:{s:7:\"%module\";s:7:\"overlay\";}',6,'','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&id=1&op=do','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&op=start&id=1','127.0.0.1',1317181151);
INSERT INTO `watchdog` VALUES (23,0,'system','%module module installed.','a:1:{s:7:\"%module\";s:4:\"path\";}',6,'','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&id=1&op=do','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&op=start&id=1','127.0.0.1',1317181151);
INSERT INTO `watchdog` VALUES (24,0,'system','%module module enabled.','a:1:{s:7:\"%module\";s:4:\"path\";}',6,'','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&id=1&op=do','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&op=start&id=1','127.0.0.1',1317181151);
INSERT INTO `watchdog` VALUES (25,0,'system','%module module installed.','a:1:{s:7:\"%module\";s:3:\"rdf\";}',6,'','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&id=1&op=do','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&op=start&id=1','127.0.0.1',1317181151);
INSERT INTO `watchdog` VALUES (26,0,'system','%module module enabled.','a:1:{s:7:\"%module\";s:3:\"rdf\";}',6,'','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&id=1&op=do','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&op=start&id=1','127.0.0.1',1317181151);
INSERT INTO `watchdog` VALUES (27,0,'system','%module module installed.','a:1:{s:7:\"%module\";s:6:\"search\";}',6,'','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&id=1&op=do','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&op=start&id=1','127.0.0.1',1317181151);
INSERT INTO `watchdog` VALUES (28,0,'system','%module module enabled.','a:1:{s:7:\"%module\";s:6:\"search\";}',6,'','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&id=1&op=do','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&op=start&id=1','127.0.0.1',1317181151);
INSERT INTO `watchdog` VALUES (29,0,'system','%module module installed.','a:1:{s:7:\"%module\";s:8:\"shortcut\";}',6,'','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&id=1&op=do','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&op=start&id=1','127.0.0.1',1317181153);
INSERT INTO `watchdog` VALUES (30,0,'system','%module module enabled.','a:1:{s:7:\"%module\";s:8:\"shortcut\";}',6,'','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&id=1&op=do','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&op=start&id=1','127.0.0.1',1317181153);
INSERT INTO `watchdog` VALUES (31,0,'system','%module module installed.','a:1:{s:7:\"%module\";s:7:\"toolbar\";}',6,'','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&id=1&op=do','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&op=start&id=1','127.0.0.1',1317181154);
INSERT INTO `watchdog` VALUES (32,0,'system','%module module enabled.','a:1:{s:7:\"%module\";s:7:\"toolbar\";}',6,'','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&id=1&op=do','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&op=start&id=1','127.0.0.1',1317181154);
INSERT INTO `watchdog` VALUES (33,0,'system','%module module installed.','a:1:{s:7:\"%module\";s:8:\"standard\";}',6,'','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&id=1&op=do','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&op=start&id=1','127.0.0.1',1317181154);
INSERT INTO `watchdog` VALUES (34,0,'system','%module module enabled.','a:1:{s:7:\"%module\";s:8:\"standard\";}',6,'','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&id=1&op=do','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&op=start&id=1','127.0.0.1',1317181154);
INSERT INTO `watchdog` VALUES (35,0,'actions','Action \'%action\' added.','a:1:{s:7:\"%action\";s:15:\"Publish comment\";}',5,'','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&id=1&op=finished','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&op=start&id=1','127.0.0.1',1317181158);
INSERT INTO `watchdog` VALUES (36,0,'actions','Action \'%action\' added.','a:1:{s:7:\"%action\";s:17:\"Unpublish comment\";}',5,'','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&id=1&op=finished','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&op=start&id=1','127.0.0.1',1317181158);
INSERT INTO `watchdog` VALUES (37,0,'actions','Action \'%action\' added.','a:1:{s:7:\"%action\";s:12:\"Save comment\";}',5,'','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&id=1&op=finished','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&op=start&id=1','127.0.0.1',1317181158);
INSERT INTO `watchdog` VALUES (38,0,'actions','Action \'%action\' added.','a:1:{s:7:\"%action\";s:15:\"Publish content\";}',5,'','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&id=1&op=finished','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&op=start&id=1','127.0.0.1',1317181158);
INSERT INTO `watchdog` VALUES (39,0,'actions','Action \'%action\' added.','a:1:{s:7:\"%action\";s:17:\"Unpublish content\";}',5,'','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&id=1&op=finished','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&op=start&id=1','127.0.0.1',1317181158);
INSERT INTO `watchdog` VALUES (40,0,'actions','Action \'%action\' added.','a:1:{s:7:\"%action\";s:19:\"Make content sticky\";}',5,'','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&id=1&op=finished','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&op=start&id=1','127.0.0.1',1317181158);
INSERT INTO `watchdog` VALUES (41,0,'actions','Action \'%action\' added.','a:1:{s:7:\"%action\";s:21:\"Make content unsticky\";}',5,'','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&id=1&op=finished','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&op=start&id=1','127.0.0.1',1317181158);
INSERT INTO `watchdog` VALUES (42,0,'actions','Action \'%action\' added.','a:1:{s:7:\"%action\";s:29:\"Promote content to front page\";}',5,'','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&id=1&op=finished','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&op=start&id=1','127.0.0.1',1317181158);
INSERT INTO `watchdog` VALUES (43,0,'actions','Action \'%action\' added.','a:1:{s:7:\"%action\";s:30:\"Remove content from front page\";}',5,'','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&id=1&op=finished','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&op=start&id=1','127.0.0.1',1317181158);
INSERT INTO `watchdog` VALUES (44,0,'actions','Action \'%action\' added.','a:1:{s:7:\"%action\";s:12:\"Save content\";}',5,'','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&id=1&op=finished','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&op=start&id=1','127.0.0.1',1317181158);
INSERT INTO `watchdog` VALUES (45,0,'actions','Action \'%action\' added.','a:1:{s:7:\"%action\";s:30:\"Ban IP address of current user\";}',5,'','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&id=1&op=finished','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&op=start&id=1','127.0.0.1',1317181158);
INSERT INTO `watchdog` VALUES (46,0,'actions','Action \'%action\' added.','a:1:{s:7:\"%action\";s:18:\"Block current user\";}',5,'','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&id=1&op=finished','http://loc.beautifulforms.com/install.php?profile=standard&locale=en&op=start&id=1','127.0.0.1',1317181158);
/*!40000 ALTER TABLE `watchdog` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2011-09-27 21:51:45