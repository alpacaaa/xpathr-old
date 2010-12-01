-- MySQL dump 10.13  Distrib 5.1.49, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: ninja
-- ------------------------------------------------------
-- Server version	5.1.49-1ubuntu8.1

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
-- Current Database: `ninja`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `ninja` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `ninja`;

--
-- Table structure for table `sym_authors`
--

DROP TABLE IF EXISTS `sym_authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sym_authors` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `password` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `first_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_seen` datetime DEFAULT '0000-00-00 00:00:00',
  `user_type` enum('author','developer') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'author',
  `primary` enum('yes','no') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'no',
  `default_section` int(11) NOT NULL,
  `auth_token_active` enum('yes','no') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'no',
  `language` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sym_authors`
--

LOCK TABLES `sym_authors` WRITE;
/*!40000 ALTER TABLE `sym_authors` DISABLE KEYS */;
INSERT INTO `sym_authors` VALUES (1,'admin','4ecb9d2b21439d3e2d139b23358140cfa6f14203','Marco','Sampellegrini','m@rcosa.mp','2010-12-01 14:33:25','developer','yes',6,'no',NULL);
/*!40000 ALTER TABLE `sym_authors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sym_cache`
--

DROP TABLE IF EXISTS `sym_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sym_cache` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `hash` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `creation` int(14) NOT NULL DEFAULT '0',
  `expiry` int(14) unsigned DEFAULT NULL,
  `data` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creation` (`creation`),
  KEY `hash` (`hash`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sym_cache`
--

LOCK TABLES `sym_cache` WRITE;
/*!40000 ALTER TABLE `sym_cache` DISABLE KEYS */;
INSERT INTO `sym_cache` VALUES (1,'_session_config',1290769756,NULL,'eJwzBAAAMgAy'),(2,'c76d509f97fa13698c3b93d2b47b75ba',1290769757,NULL,'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');
/*!40000 ALTER TABLE `sym_cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sym_entries`
--

DROP TABLE IF EXISTS `sym_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sym_entries` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `section_id` int(11) unsigned NOT NULL,
  `author_id` int(11) unsigned NOT NULL,
  `creation_date` datetime NOT NULL,
  `creation_date_gmt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `section_id` (`section_id`),
  KEY `author_id` (`author_id`),
  KEY `creation_date` (`creation_date`),
  KEY `creation_date_gmt` (`creation_date_gmt`)
) ENGINE=MyISAM AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sym_entries`
--

LOCK TABLES `sym_entries` WRITE;
/*!40000 ALTER TABLE `sym_entries` DISABLE KEYS */;
INSERT INTO `sym_entries` VALUES (8,1,1,'2010-10-17 12:30:25','2010-10-17 10:30:25'),(24,1,1,'2010-11-25 15:32:34','2010-11-25 14:32:34'),(23,1,1,'2010-11-25 15:32:07','2010-11-25 14:32:07'),(22,1,1,'2010-11-25 14:48:57','2010-11-25 13:48:57'),(19,1,1,'2010-11-17 10:28:28','2010-11-17 09:28:28'),(21,1,1,'2010-11-25 12:09:57','2010-11-25 11:09:57'),(25,1,1,'2010-11-26 10:26:56','2010-11-26 09:26:56'),(26,1,1,'2010-11-26 10:45:56','2010-11-26 09:45:56'),(28,1,1,'2010-11-29 11:35:32','2010-11-29 10:35:32'),(29,2,1,'2010-11-29 14:34:28','2010-11-29 13:34:28'),(30,1,1,'2010-11-30 11:04:40','2010-11-30 10:04:40'),(31,1,1,'2010-11-30 11:06:43','2010-11-30 10:06:43'),(32,1,1,'2010-11-30 11:20:27','2010-11-30 10:20:27'),(33,1,1,'2010-11-30 11:34:13','2010-11-30 10:34:13'),(34,3,1,'2010-11-30 12:01:59','2010-11-30 11:01:59'),(35,3,1,'2010-11-30 12:05:07','2010-11-30 11:05:07'),(36,3,1,'2010-11-30 12:12:24','2010-11-30 11:12:24'),(37,3,1,'2010-11-30 12:18:34','2010-11-30 11:18:34'),(38,3,1,'2010-11-30 16:02:27','2010-11-30 15:02:27'),(39,3,1,'2010-11-30 16:04:24','2010-11-30 15:04:24'),(40,3,1,'2010-11-30 16:09:24','2010-11-30 15:09:24'),(41,3,1,'2010-12-01 10:32:07','2010-12-01 09:32:07'),(42,1,1,'2010-12-01 11:25:19','2010-12-01 10:25:19');
/*!40000 ALTER TABLE `sym_entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sym_entries_data_1`
--

DROP TABLE IF EXISTS `sym_entries_data_1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sym_entries_data_1` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  KEY `value` (`value`)
) ENGINE=MyISAM AUTO_INCREMENT=529 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sym_entries_data_1`
--

LOCK TABLES `sym_entries_data_1` WRITE;
/*!40000 ALTER TABLE `sym_entries_data_1` DISABLE KEYS */;
INSERT INTO `sym_entries_data_1` VALUES (490,8,'ebf38sjf73','ebf38sjf73'),(494,22,'9da3fec78e','9da3fec78e'),(493,23,'def331f5f2','def331f5f2'),(523,24,'dca3f47559','dca3f47559'),(491,19,'62d73f4e90','62d73f4e90'),(492,21,'a8ababd7a9','a8ababd7a9'),(496,25,'34322c14fd','34322c14fd'),(511,26,'1a53ba5d92','1a53ba5d92'),(481,28,'500abf96c8','500abf96c8'),(501,30,'ada259dc28','ada259dc28'),(512,31,'df7debc84b','df7debc84b'),(499,32,'15cf4f4fe1','15cf4f4fe1'),(521,33,'6bbb7e4b44','6bbb7e4b44'),(528,42,'85c3a7bf93','85c3a7bf93');
/*!40000 ALTER TABLE `sym_entries_data_1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sym_entries_data_10`
--

DROP TABLE IF EXISTS `sym_entries_data_10`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sym_entries_data_10` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  KEY `value` (`value`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sym_entries_data_10`
--

LOCK TABLES `sym_entries_data_10` WRITE;
/*!40000 ALTER TABLE `sym_entries_data_10` DISABLE KEYS */;
INSERT INTO `sym_entries_data_10` VALUES (6,34,'which-version-of-xslt-is-supported','Which version of XSLT is supported?'),(2,35,'are-there-any-extensions-enabled','Are there any extensions enabled?'),(3,36,'what-is-a-main-resource','What is a Main Resource?'),(5,37,'why-would-i-create-multiple-files','Why would I create multiple files?'),(8,38,'wtf-are-genin-chunin-and-junin','WTF are genin, chunin and junin?'),(9,39,'for-how-long-i-will-be-able-to-edit-my-snippets','For how long I will be able to edit my snippets?'),(10,40,'will-i-be-able-to-create-snippets-as-a-user','Will I be able to create snippets as a user?'),(12,41,'whos-the-author-of-the-image-in-homepage','Who\'s the author of the image in Homepage?');
/*!40000 ALTER TABLE `sym_entries_data_10` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sym_entries_data_11`
--

DROP TABLE IF EXISTS `sym_entries_data_11`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sym_entries_data_11` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `value` text,
  `value_formatted` text,
  PRIMARY KEY (`id`),
  KEY `entry_id` (`entry_id`),
  FULLTEXT KEY `value` (`value`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sym_entries_data_11`
--

LOCK TABLES `sym_entries_data_11` WRITE;
/*!40000 ALTER TABLE `sym_entries_data_11` DISABLE KEYS */;
INSERT INTO `sym_entries_data_11` VALUES (6,34,'It\'s currently supported <a href=\"http://www.w3.org/TR/xslt\">XSLT 1.0</a>.',NULL),(2,35,'Yes, <a href=\"http://www.exslt.org/\">exslt</a> extensions are enabled.',NULL),(3,36,'If you used xslt before, you\'ll know the engine needs both an xml and an xsl document in order to generate a result.\r\nI decided to call those documents Main Resources. They are the <em>entry point</em> of your snippet.',NULL),(5,37,'Along with Main Resources, you can add to your snippet other files. It is possible to use <a href=\"http://www.w3schools.com/Xsl/el_import.asp\">&lt;xsl:import&gt;</a> to import additional xsl files and <a href=\"http://www.w3schools.com/Xsl/func_document.asp\">document()</a> works too.',NULL),(8,38,'Have a look at wikipedia article about <a href=\"http://en.wikipedia.org/wiki/Ninja#Development\">Ninja development</a> :)',NULL),(9,39,'Currently, for two weeks, unless you don\'t clear your cookies.',NULL),(10,40,'Yes. You\'ll be able to login and edit you snippets anywhere and anytime.',NULL),(12,41,'It\'s <a href=\"http://aznjoker2.deviantart.com/\">~AznJoker2</a>. The <a href=\"http://aznjoker2.deviantart.com/art/Stupid-Ninja-147093256\">original image</a> is far way better. I just wanted to have some fun with inkscape :)',NULL);
/*!40000 ALTER TABLE `sym_entries_data_11` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sym_entries_data_12`
--

DROP TABLE IF EXISTS `sym_entries_data_12`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sym_entries_data_12` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `value` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `value` (`value`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sym_entries_data_12`
--

LOCK TABLES `sym_entries_data_12` WRITE;
/*!40000 ALTER TABLE `sym_entries_data_12` DISABLE KEYS */;
INSERT INTO `sym_entries_data_12` VALUES (1,35,2),(2,34,1),(3,36,3),(4,37,4),(6,38,5),(7,39,6),(8,40,7),(10,41,8);
/*!40000 ALTER TABLE `sym_entries_data_12` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sym_entries_data_2`
--

DROP TABLE IF EXISTS `sym_entries_data_2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sym_entries_data_2` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  KEY `value` (`value`)
) ENGINE=MyISAM AUTO_INCREMENT=529 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sym_entries_data_2`
--

LOCK TABLES `sym_entries_data_2` WRITE;
/*!40000 ALTER TABLE `sym_entries_data_2` DISABLE KEYS */;
INSERT INTO `sym_entries_data_2` VALUES (490,8,'test','Test'),(494,22,'test','Test'),(493,23,'yet-another-snippet','Yet another snippet'),(523,24,'buashfasdufhasfsafgadsfasdfasdfasdfsdf','Buashfasdufhasfsafgadsfasdfasdfasdfsdf'),(496,25,'yet-another-snippet','Yet another snippet'),(491,19,'yet-another-snippet','Yet another snippet'),(492,21,'teeeeeeeest','TEeeeeeeest'),(511,26,'test','Test'),(481,28,'yet-another-snippet','Yet another snippet'),(501,30,'yet-another-snippet','Yet another snippet'),(512,31,'wa-wa-wawaa','wa wa wawaa'),(499,32,'yet-another-snippet','Yet another snippet'),(521,33,'yet-another-snippet','Yet another snippet'),(528,42,'yet-another-snippet','Yet another snippet');
/*!40000 ALTER TABLE `sym_entries_data_2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sym_entries_data_3`
--

DROP TABLE IF EXISTS `sym_entries_data_3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sym_entries_data_3` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `value` text,
  `value_formatted` text,
  PRIMARY KEY (`id`),
  KEY `entry_id` (`entry_id`),
  FULLTEXT KEY `value` (`value`)
) ENGINE=MyISAM AUTO_INCREMENT=529 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sym_entries_data_3`
--

LOCK TABLES `sym_entries_data_3` WRITE;
/*!40000 ALTER TABLE `sym_entries_data_3` DISABLE KEYS */;
INSERT INTO `sym_entries_data_3` VALUES (490,8,'A way too cool descon.\r\nJesus, two rows! of goodness!!!!\r\nA way too cool descon.\r\nJesus, two rows! of goodness!!!!',NULL),(492,21,'a small description',NULL),(491,19,'brand newaaaaaa!\r\nse prendi un parafango e\r\nci metti davanti un\'anatrass',NULL),(494,22,'A way too cool descon.\r\nJesus, two rows! of goodness!!!!\r\nA way too cool descon.\r\nJesus, two rows! of goodness!!!! (fork)',NULL),(493,23,'No description yet...',NULL),(496,25,'asdrubale',NULL),(511,26,'A way too cool descon.\r\nJesus, two rows! of goodness!!!!\r\nA way too cool descon.\r\nJesus, two rows! of goodness!!!! (fork)',NULL),(481,28,'a small description asdfdf',NULL),(501,30,'asdrubale (fork)',NULL),(512,31,'asdfasdf',NULL),(499,32,NULL,NULL),(521,33,'asdfaeagreg\r\n\r\nagsargaergaisfhsdifh',NULL),(523,24,'una piccola descrizione di sto snippettttuna piccola descrizione di sto snippettttuna piccola descrizione di sto snippettttuna piccola descrizione di sto snippettttuna piccola descrizione di sto snippettttuna piccola descrizione di sto snippettttuna piccola descrizione di sto snippettttuna piccola descrizione di sto snippettttuna piccola descrizione di sto snippettttuna piccola descrizione di sto snippettttuna piccola descrizione di sto snippettt',NULL),(528,42,'sdfasg',NULL);
/*!40000 ALTER TABLE `sym_entries_data_3` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sym_entries_data_4`
--

DROP TABLE IF EXISTS `sym_entries_data_4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sym_entries_data_4` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  KEY `value` (`value`)
) ENGINE=MyISAM AUTO_INCREMENT=490 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sym_entries_data_4`
--

LOCK TABLES `sym_entries_data_4` WRITE;
/*!40000 ALTER TABLE `sym_entries_data_4` DISABLE KEYS */;
INSERT INTO `sym_entries_data_4` VALUES (451,8,'stronzoxml','stronzo.xml'),(455,22,'stronzoxml','stronzo.xml'),(454,23,'sourcexml','source.xml'),(484,24,'sourcexml','source.xml'),(452,19,'souracexml','sourace.xml'),(453,21,'souracexml','sourace.xml'),(457,25,'sourcexml','source.xml'),(472,26,'stronzoxml','stronzo.xml'),(442,28,'sourcexml','source.xml'),(462,30,'sourcexml','source.xml'),(473,31,'sourcexml','source.xml'),(460,32,'sourcexml','source.xml'),(482,33,'sourcexml','source.xml'),(489,42,'sourcexml','source.xml');
/*!40000 ALTER TABLE `sym_entries_data_4` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sym_entries_data_5`
--

DROP TABLE IF EXISTS `sym_entries_data_5`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sym_entries_data_5` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  KEY `value` (`value`)
) ENGINE=MyISAM AUTO_INCREMENT=514 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sym_entries_data_5`
--

LOCK TABLES `sym_entries_data_5` WRITE;
/*!40000 ALTER TABLE `sym_entries_data_5` DISABLE KEYS */;
INSERT INTO `sym_entries_data_5` VALUES (475,8,'piustronzoxsl','piustronzo.xsl'),(479,22,'piustronzoxsl','piustronzo.xsl'),(478,23,'masterxsl','master.xsl'),(508,24,'masterxsl','master.xsl'),(476,19,'masterxsl','master.xsl'),(477,21,'masterxsl','master.xsl'),(481,25,'maasterxsl','maaster.xsl'),(496,26,'piustronzoxsl','piustronzo.xsl'),(466,28,'masterxsl','master.xsl'),(486,30,'maasterxsl','maaster.xsl'),(497,31,'mastaerxsl','mastaer.xsl'),(484,32,'masterxsl','master.xsl'),(506,33,'masterxsl','master.xsl'),(513,42,'masterxsl','master.xsl');
/*!40000 ALTER TABLE `sym_entries_data_5` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sym_entries_data_6`
--

DROP TABLE IF EXISTS `sym_entries_data_6`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sym_entries_data_6` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  KEY `value` (`value`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sym_entries_data_6`
--

LOCK TABLES `sym_entries_data_6` WRITE;
/*!40000 ALTER TABLE `sym_entries_data_6` DISABLE KEYS */;
INSERT INTO `sym_entries_data_6` VALUES (1,29,'all','All');
/*!40000 ALTER TABLE `sym_entries_data_6` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sym_entries_data_7`
--

DROP TABLE IF EXISTS `sym_entries_data_7`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sym_entries_data_7` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  KEY `value` (`value`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sym_entries_data_7`
--

LOCK TABLES `sym_entries_data_7` WRITE;
/*!40000 ALTER TABLE `sym_entries_data_7` DISABLE KEYS */;
INSERT INTO `sym_entries_data_7` VALUES (1,29,'0','0');
/*!40000 ALTER TABLE `sym_entries_data_7` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sym_entries_data_8`
--

DROP TABLE IF EXISTS `sym_entries_data_8`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sym_entries_data_8` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `relation_id` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `relation_id` (`relation_id`)
) ENGINE=MyISAM AUTO_INCREMENT=386 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sym_entries_data_8`
--

LOCK TABLES `sym_entries_data_8` WRITE;
/*!40000 ALTER TABLE `sym_entries_data_8` DISABLE KEYS */;
INSERT INTO `sym_entries_data_8` VALUES (347,8,29),(351,22,29),(350,23,29),(380,24,29),(348,19,29),(349,21,29),(353,25,29),(368,26,29),(338,28,29),(358,30,29),(369,31,29),(356,32,29),(378,33,29),(385,42,29);
/*!40000 ALTER TABLE `sym_entries_data_8` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sym_entries_data_9`
--

DROP TABLE IF EXISTS `sym_entries_data_9`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sym_entries_data_9` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `value` varchar(80) DEFAULT NULL,
  `local` int(11) DEFAULT NULL,
  `gmt` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `value` (`value`)
) ENGINE=MyISAM AUTO_INCREMENT=51 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sym_entries_data_9`
--

LOCK TABLES `sym_entries_data_9` WRITE;
/*!40000 ALTER TABLE `sym_entries_data_9` DISABLE KEYS */;
INSERT INTO `sym_entries_data_9` VALUES (3,28,'2010-11-30T11:04:00+01:00',1291111440,1291111440),(23,30,'2010-11-30T11:04:00+01:00',1291111440,1291111440),(34,31,'2010-12-01T10:19:00+01:00',1291195140,1291195140),(15,23,'2010-11-30T11:13:00+01:00',1291111980,1291111980),(12,8,'2010-11-30T11:13:00+01:00',1291111980,1291111980),(13,19,'2010-11-30T11:13:00+01:00',1291111980,1291111980),(14,21,'2010-11-30T11:14:00+01:00',1291112040,1291112040),(16,22,'2010-11-30T11:14:00+01:00',1291112040,1291112040),(45,24,'2010-12-01T10:47:00+01:00',1291196820,1291196820),(18,25,'2010-11-30T11:14:00+01:00',1291112040,1291112040),(33,26,'2010-12-01T10:07:00+01:00',1291194420,1291194420),(21,32,'2010-11-30T11:20:00+01:00',1291112400,1291112400),(43,33,'2010-12-01T10:43:00+01:00',1291196580,1291196580),(50,42,'2010-12-01T11:28:00+01:00',1291199280,1291199280);
/*!40000 ALTER TABLE `sym_entries_data_9` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sym_extensions`
--

DROP TABLE IF EXISTS `sym_extensions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sym_extensions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `status` enum('enabled','disabled') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'enabled',
  `version` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sym_extensions`
--

LOCK TABLES `sym_extensions` WRITE;
/*!40000 ALTER TABLE `sym_extensions` DISABLE KEYS */;
INSERT INTO `sym_extensions` VALUES (11,'openid_auth','enabled','0.1'),(2,'debugdevkit','enabled','1.0.8'),(4,'symquery','enabled','0.1.0'),(5,'profiledevkit','enabled','1.0.4'),(13,'ninja','enabled','1.0'),(12,'selectbox_link_field','enabled','1.18'),(14,'order_entries','enabled','1.8');
/*!40000 ALTER TABLE `sym_extensions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sym_extensions_delegates`
--

DROP TABLE IF EXISTS `sym_extensions_delegates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sym_extensions_delegates` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `extension_id` int(11) NOT NULL,
  `page` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `delegate` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `callback` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `extension_id` (`extension_id`),
  KEY `page` (`page`),
  KEY `delegate` (`delegate`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sym_extensions_delegates`
--

LOCK TABLES `sym_extensions_delegates` WRITE;
/*!40000 ALTER TABLE `sym_extensions_delegates` DISABLE KEYS */;
INSERT INTO `sym_extensions_delegates` VALUES (1,2,'/frontend/','FrontendDevKitResolve','frontendDevKitResolve'),(2,2,'/frontend/','ManipulateDevKitNavigation','manipulateDevKitNavigation'),(3,5,'/frontend/','FrontendDevKitResolve','frontendDevKitResolve'),(4,5,'/frontend/','ManipulateDevKitNavigation','manipulateDevKitNavigation'),(5,5,'/frontend/','FrontendOutputPostGenerate','FrontendOutputPostGenerate'),(10,11,'/frontend/','openidAuthComplete','authenticationComplete'),(11,13,'/frontend/','FrontendParamsResolve','FrontendParamsResolve'),(12,14,'/backend/','InitaliseAdminPageHead','appendScriptToHead'),(13,14,'/backend/','AppendElementBelowView','appendOrderFieldId');
/*!40000 ALTER TABLE `sym_extensions_delegates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sym_fields`
--

DROP TABLE IF EXISTS `sym_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sym_fields` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `label` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `element_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `parent_section` int(11) NOT NULL DEFAULT '0',
  `required` enum('yes','no') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'yes',
  `sortorder` int(11) NOT NULL DEFAULT '1',
  `location` enum('main','sidebar') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'main',
  `show_column` enum('yes','no') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'no',
  PRIMARY KEY (`id`),
  KEY `index` (`element_name`,`type`,`parent_section`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sym_fields`
--

LOCK TABLES `sym_fields` WRITE;
/*!40000 ALTER TABLE `sym_fields` DISABLE KEYS */;
INSERT INTO `sym_fields` VALUES (1,'uniq-id','uniq-id','input',1,'yes',0,'main','yes'),(2,'Title','title','input',1,'no',1,'main','yes'),(3,'Description','description','textarea',1,'no',2,'main','no'),(4,'Main XML file','main-xml-file','input',1,'no',3,'main','yes'),(5,'Main XSL file','main-xsl-file','input',1,'no',4,'main','yes'),(6,'Name','name','input',2,'yes',0,'main','yes'),(7,'OpenID','openid','input',2,'yes',1,'main','yes'),(8,'User','user','selectbox_link',1,'no',5,'main','yes'),(9,'Last update','last-update','date',1,'no',6,'main','yes'),(10,'Question','question','input',3,'no',0,'main','yes'),(11,'Answer','answer','textarea',3,'no',1,'main','no'),(12,'Order','order','order_entries',3,'no',2,'main','yes');
/*!40000 ALTER TABLE `sym_fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sym_fields_author`
--

DROP TABLE IF EXISTS `sym_fields_author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sym_fields_author` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `field_id` int(11) unsigned NOT NULL,
  `allow_author_change` enum('yes','no') COLLATE utf8_unicode_ci NOT NULL,
  `allow_multiple_selection` enum('yes','no') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'no',
  `default_to_current_user` enum('yes','no') COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `field_id` (`field_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sym_fields_author`
--

LOCK TABLES `sym_fields_author` WRITE;
/*!40000 ALTER TABLE `sym_fields_author` DISABLE KEYS */;
/*!40000 ALTER TABLE `sym_fields_author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sym_fields_checkbox`
--

DROP TABLE IF EXISTS `sym_fields_checkbox`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sym_fields_checkbox` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `field_id` int(11) unsigned NOT NULL,
  `default_state` enum('on','off') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'on',
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `field_id` (`field_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sym_fields_checkbox`
--

LOCK TABLES `sym_fields_checkbox` WRITE;
/*!40000 ALTER TABLE `sym_fields_checkbox` DISABLE KEYS */;
/*!40000 ALTER TABLE `sym_fields_checkbox` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sym_fields_date`
--

DROP TABLE IF EXISTS `sym_fields_date`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sym_fields_date` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `field_id` int(11) unsigned NOT NULL,
  `pre_populate` enum('yes','no') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'no',
  PRIMARY KEY (`id`),
  KEY `field_id` (`field_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sym_fields_date`
--

LOCK TABLES `sym_fields_date` WRITE;
/*!40000 ALTER TABLE `sym_fields_date` DISABLE KEYS */;
INSERT INTO `sym_fields_date` VALUES (1,9,'yes');
/*!40000 ALTER TABLE `sym_fields_date` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sym_fields_input`
--

DROP TABLE IF EXISTS `sym_fields_input`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sym_fields_input` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `field_id` int(11) unsigned NOT NULL,
  `validator` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `field_id` (`field_id`)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sym_fields_input`
--

LOCK TABLES `sym_fields_input` WRITE;
/*!40000 ALTER TABLE `sym_fields_input` DISABLE KEYS */;
INSERT INTO `sym_fields_input` VALUES (17,1,NULL),(18,2,NULL),(19,4,NULL),(20,5,NULL),(11,6,NULL),(12,7,NULL),(22,10,NULL);
/*!40000 ALTER TABLE `sym_fields_input` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sym_fields_order_entries`
--

DROP TABLE IF EXISTS `sym_fields_order_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sym_fields_order_entries` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `field_id` int(11) unsigned NOT NULL,
  `force_sort` enum('yes','no') DEFAULT 'no',
  `hide` enum('yes','no') DEFAULT 'no',
  PRIMARY KEY (`id`),
  UNIQUE KEY `field_id` (`field_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sym_fields_order_entries`
--

LOCK TABLES `sym_fields_order_entries` WRITE;
/*!40000 ALTER TABLE `sym_fields_order_entries` DISABLE KEYS */;
INSERT INTO `sym_fields_order_entries` VALUES (1,12,NULL,'yes');
/*!40000 ALTER TABLE `sym_fields_order_entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sym_fields_select`
--

DROP TABLE IF EXISTS `sym_fields_select`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sym_fields_select` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `field_id` int(11) unsigned NOT NULL,
  `allow_multiple_selection` enum('yes','no') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'no',
  `static_options` text COLLATE utf8_unicode_ci,
  `dynamic_options` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `field_id` (`field_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sym_fields_select`
--

LOCK TABLES `sym_fields_select` WRITE;
/*!40000 ALTER TABLE `sym_fields_select` DISABLE KEYS */;
/*!40000 ALTER TABLE `sym_fields_select` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sym_fields_selectbox_link`
--

DROP TABLE IF EXISTS `sym_fields_selectbox_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sym_fields_selectbox_link` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `field_id` int(11) unsigned NOT NULL,
  `allow_multiple_selection` enum('yes','no') NOT NULL DEFAULT 'no',
  `related_field_id` varchar(255) NOT NULL,
  `limit` int(4) unsigned NOT NULL DEFAULT '20',
  PRIMARY KEY (`id`),
  KEY `field_id` (`field_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sym_fields_selectbox_link`
--

LOCK TABLES `sym_fields_selectbox_link` WRITE;
/*!40000 ALTER TABLE `sym_fields_selectbox_link` DISABLE KEYS */;
INSERT INTO `sym_fields_selectbox_link` VALUES (2,8,'no','6',20);
/*!40000 ALTER TABLE `sym_fields_selectbox_link` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sym_fields_taglist`
--

DROP TABLE IF EXISTS `sym_fields_taglist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sym_fields_taglist` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `field_id` int(11) unsigned NOT NULL,
  `validator` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pre_populate_source` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `field_id` (`field_id`),
  KEY `pre_populate_source` (`pre_populate_source`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sym_fields_taglist`
--

LOCK TABLES `sym_fields_taglist` WRITE;
/*!40000 ALTER TABLE `sym_fields_taglist` DISABLE KEYS */;
/*!40000 ALTER TABLE `sym_fields_taglist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sym_fields_textarea`
--

DROP TABLE IF EXISTS `sym_fields_textarea`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sym_fields_textarea` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `field_id` int(11) unsigned NOT NULL,
  `formatter` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `size` int(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `field_id` (`field_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sym_fields_textarea`
--

LOCK TABLES `sym_fields_textarea` WRITE;
/*!40000 ALTER TABLE `sym_fields_textarea` DISABLE KEYS */;
INSERT INTO `sym_fields_textarea` VALUES (5,3,NULL,7),(7,11,NULL,10);
/*!40000 ALTER TABLE `sym_fields_textarea` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sym_fields_upload`
--

DROP TABLE IF EXISTS `sym_fields_upload`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sym_fields_upload` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `field_id` int(11) unsigned NOT NULL,
  `destination` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `validator` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `field_id` (`field_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sym_fields_upload`
--

LOCK TABLES `sym_fields_upload` WRITE;
/*!40000 ALTER TABLE `sym_fields_upload` DISABLE KEYS */;
/*!40000 ALTER TABLE `sym_fields_upload` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sym_forgotpass`
--

DROP TABLE IF EXISTS `sym_forgotpass`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sym_forgotpass` (
  `author_id` int(11) NOT NULL DEFAULT '0',
  `token` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `expiry` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`author_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sym_forgotpass`
--

LOCK TABLES `sym_forgotpass` WRITE;
/*!40000 ALTER TABLE `sym_forgotpass` DISABLE KEYS */;
/*!40000 ALTER TABLE `sym_forgotpass` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sym_pages`
--

DROP TABLE IF EXISTS `sym_pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sym_pages` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `parent` int(11) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `handle` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `params` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data_sources` text COLLATE utf8_unicode_ci,
  `events` text COLLATE utf8_unicode_ci,
  `sortorder` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `parent` (`parent`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sym_pages`
--

LOCK TABLES `sym_pages` WRITE;
/*!40000 ALTER TABLE `sym_pages` DISABLE KEYS */;
INSERT INTO `sym_pages` VALUES (1,NULL,'Home','index',NULL,NULL,'footer_help_notes,footer_snippet_list,user_snippets','new_snippet',8),(16,NULL,'Help','help',NULL,NULL,'all_help_notes,footer_help_notes,footer_snippet_list',NULL,16),(11,NULL,'Snippet','snippet',NULL,'user/snip-id','footer_help_notes,footer_snippet_list,resources_list,snippet_information,snippet_main_resources,user_flash','delete_resource,fork_snippet,new_snippet,save_snippet_information',11),(12,11,'Resource','resource','snippet','user/snip-id/resource','footer_help_notes,footer_snippet_list,resources_list,snippet_information,snippet_resource,user_flash','delete_resource,fork_snippet,new_snippet,save_resource,save_snippet_information',12),(13,11,'Process','process','snippet','user/snip-id','footer_help_notes,footer_snippet_list,resources_list,snippet_information,snippet_result','fork_snippet,new_snippet,save_snippet_information',13),(14,11,'Add Resource','add-resource','snippet','user/snip-id','footer_help_notes,footer_snippet_list,resources_list,snippet_information','add_resource,new_snippet,save_snippet_information',14),(17,NULL,'My Snippets','my-snippets',NULL,NULL,'footer_help_notes,footer_snippet_list,snippet_list_by_user,user_snippets','new_snippet',17),(15,NULL,'Snippets list','snippets',NULL,'user','footer_help_notes,footer_snippet_list,snippet_list_by_user',NULL,15);
/*!40000 ALTER TABLE `sym_pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sym_pages_types`
--

DROP TABLE IF EXISTS `sym_pages_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sym_pages_types` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `page_id` int(11) unsigned NOT NULL,
  `type` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `page_id` (`page_id`,`type`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sym_pages_types`
--

LOCK TABLES `sym_pages_types` WRITE;
/*!40000 ALTER TABLE `sym_pages_types` DISABLE KEYS */;
INSERT INTO `sym_pages_types` VALUES (11,1,'index');
/*!40000 ALTER TABLE `sym_pages_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sym_sections`
--

DROP TABLE IF EXISTS `sym_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sym_sections` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `handle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sortorder` int(11) NOT NULL DEFAULT '0',
  `entry_order` varchar(7) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entry_order_direction` enum('asc','desc') COLLATE utf8_unicode_ci DEFAULT 'asc',
  `hidden` enum('yes','no') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'no',
  `navigation_group` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Content',
  PRIMARY KEY (`id`),
  UNIQUE KEY `handle` (`handle`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sym_sections`
--

LOCK TABLES `sym_sections` WRITE;
/*!40000 ALTER TABLE `sym_sections` DISABLE KEYS */;
INSERT INTO `sym_sections` VALUES (1,'Snippets','snippets',1,NULL,'asc','no','Content'),(2,'Users','users',2,NULL,'asc','no','Content'),(3,'Help','help',3,'12','asc','no','Content');
/*!40000 ALTER TABLE `sym_sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sym_sections_association`
--

DROP TABLE IF EXISTS `sym_sections_association`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sym_sections_association` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `parent_section_id` int(11) unsigned NOT NULL,
  `parent_section_field_id` int(11) unsigned DEFAULT NULL,
  `child_section_id` int(11) unsigned NOT NULL,
  `child_section_field_id` int(11) unsigned NOT NULL,
  `cascading_deletion` enum('yes','no') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'no',
  PRIMARY KEY (`id`),
  KEY `parent_section_id` (`parent_section_id`,`child_section_id`,`child_section_field_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sym_sections_association`
--

LOCK TABLES `sym_sections_association` WRITE;
/*!40000 ALTER TABLE `sym_sections_association` DISABLE KEYS */;
INSERT INTO `sym_sections_association` VALUES (2,2,6,1,8,'no');
/*!40000 ALTER TABLE `sym_sections_association` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sym_sessions`
--

DROP TABLE IF EXISTS `sym_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sym_sessions` (
  `session` varchar(255) NOT NULL,
  `session_expires` int(10) unsigned NOT NULL DEFAULT '0',
  `session_data` text,
  PRIMARY KEY (`session`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sym_sessions`
--

LOCK TABLES `sym_sessions` WRITE;
/*!40000 ALTER TABLE `sym_sessions` DISABLE KEYS */;
INSERT INTO `sym_sessions` VALUES ('scfls48mmnv4emjtbeaqlits47',1291210405,'sym-|a:2:{s:8:\"username\";s:5:\"admin\";s:4:\"pass\";s:40:\"4ecb9d2b21439d3e2d139b23358140cfa6f14203\";}ninja-user|a:2:{s:8:\"snippets\";a:13:{i:0;s:10:\"62d73f4e90\";i:1;s:10:\"a8ababd7a9\";i:2;s:10:\"9da3fec78e\";i:3;s:10:\"def331f5f2\";i:4;s:10:\"dca3f47559\";i:5;s:10:\"1a53ba5d92\";i:6;s:10:\"3c63ac1d9a\";i:7;s:10:\"500abf96c8\";i:8;s:10:\"ada259dc28\";i:9;s:10:\"df7debc84b\";i:10;s:10:\"15cf4f4fe1\";i:11;s:10:\"6bbb7e4b44\";i:12;s:10:\"85c3a7bf93\";}s:5:\"flash\";a:0:{}}'),('des0l4cseu3vhch2ijopp8nrk6',1290590318,'sym-|a:2:{s:8:\"username\";s:5:\"admin\";s:4:\"pass\";s:40:\"4ecb9d2b21439d3e2d139b23358140cfa6f14203\";}ninja-user|a:1:{s:8:\"snippets\";a:2:{i:0;s:10:\"62d73f4e90\";i:1;s:11:\"3_e759f35b9\";}}'),('3cq458h8dvn2etj2e9ld1dgkh7',1291128675,'sym-|a:0:{}ninja-user|a:2:{s:8:\"snippets\";a:1:{i:0;s:10:\"34322c14fd\";}s:5:\"flash\";a:0:{}}');
/*!40000 ALTER TABLE `sym_sessions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2010-12-01 14:33:39
