-- MySQL dump 10.13  Distrib 5.7.20, for Linux (x86_64)
--
-- Host: localhost    Database: oai_db
-- ------------------------------------------------------
-- Server version	5.7.20-0ubuntu0.16.04.1

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
-- Table structure for table `apn`
--

DROP TABLE IF EXISTS `apn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `apn` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `apn-name` varchar(60) NOT NULL,
  `pdn-type` enum('IPv4','IPv6','IPv4v6','IPv4_or_IPv6') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `apn-name` (`apn-name`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `apn`
--

LOCK TABLES `apn` WRITE;
/*!40000 ALTER TABLE `apn` DISABLE KEYS */;
INSERT INTO `apn` VALUES (17,'default','IPv4');
/*!40000 ALTER TABLE `apn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mmeidentity`
--

DROP TABLE IF EXISTS `mmeidentity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mmeidentity` (
  `idmmeidentity` int(11) NOT NULL AUTO_INCREMENT,
  `mmehost` varchar(255) DEFAULT NULL,
  `mmerealm` varchar(200) DEFAULT NULL,
  `UE-Reachability` tinyint(1) NOT NULL COMMENT 'Indicates whether the MME supports UE Reachability Notifcation',
  PRIMARY KEY (`idmmeidentity`)
) ENGINE=MyISAM AUTO_INCREMENT=43 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mmeidentity`
--

LOCK TABLES `mmeidentity` WRITE;
/*!40000 ALTER TABLE `mmeidentity` DISABLE KEYS */;
INSERT INTO `mmeidentity` VALUES (1,'oai-epc.3gppnetwork.org','3gppnetwork.org',0);
/*!40000 ALTER TABLE `mmeidentity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pdn`
--

DROP TABLE IF EXISTS `pdn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pdn` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `apn` varchar(60) NOT NULL,
  `pdn_type` enum('IPv4','IPv6','IPv4v6','IPv4_or_IPv6') NOT NULL DEFAULT 'IPv4',
  `pdn_ipv4` varchar(15) DEFAULT '0.0.0.0',
  `pdn_ipv6` varchar(45) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT '0:0:0:0:0:0:0:0',
  `aggregate_ambr_ul` int(10) unsigned DEFAULT '50000000',
  `aggregate_ambr_dl` int(10) unsigned DEFAULT '100000000',
  `pgw_id` int(11) NOT NULL,
  `users_imsi` varchar(15) NOT NULL,
  `qci` tinyint(3) unsigned NOT NULL DEFAULT '9',
  `priority_level` tinyint(3) unsigned NOT NULL DEFAULT '15',
  `pre_emp_cap` enum('ENABLED','DISABLED') DEFAULT 'DISABLED',
  `pre_emp_vul` enum('ENABLED','DISABLED') DEFAULT 'DISABLED',
  `LIPA-Permissions` enum('LIPA-prohibited','LIPA-only','LIPA-conditional') NOT NULL DEFAULT 'LIPA-only',
  PRIMARY KEY (`id`,`pgw_id`,`users_imsi`),
  KEY `fk_pdn_pgw1_idx` (`pgw_id`),
  KEY `fk_pdn_users1_idx` (`users_imsi`)
) ENGINE=MyISAM AUTO_INCREMENT=36 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pdn`
--

LOCK TABLES `pdn` WRITE;
/*!40000 ALTER TABLE `pdn` DISABLE KEYS */;
INSERT INTO `pdn` VALUES (8,'oai.ipv4','IPv4','0.0.0.0','0:0:0:0:0:0:0:0',50000000,100000000,3,'208930000000008',9,15,'DISABLED','ENABLED','LIPA-only'),(9,'oai.ipv4','IPv4','0.0.0.0','0:0:0:0:0:0:0:0',50000000,100000000,3,'208930000000009',9,15,'DISABLED','ENABLED','LIPA-only'),(11,'oai.ipv4','IPv4','0.0.0.0','0:0:0:0:0:0:0:0',50000000,100000000,3,'208930000000053',9,15,'DISABLED','ENABLED','LIPA-only'),(12,'oai.ipv4','IPv4','0.0.0.0','0:0:0:0:0:0:0:0',50000000,100000000,3,'208930000000055',9,15,'DISABLED','ENABLED','LIPA-only'),(16,'oai.ipv4','IPv4','0.0.0.0','0:0:0:0:0:0:0:0',50000000,100000000,3,'208930000000054',9,15,'DISABLED','ENABLED','LIPA-only'),(17,'default','IPv4','192.168.4.10','0:0:0:0:0:0:0:0',50000000,100000000,3,'208931234567890',9,15,'DISABLED','ENABLED','LIPA-only'),(18,'default','IPv4','192.168.4.10','0:0:0:0:0:0:0:0',50000000,100000000,3,'111011234567890',9,15,'DISABLED','ENABLED','LIPA-only'),(17,'default','IPv4','192.168.4.10','0:0:0:0:0:0:0:0',50000000,100000000,3,'111011234567891',9,15,'DISABLED','ENABLED','LIPA-only');
/*!40000 ALTER TABLE `pdn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pgw`
--

DROP TABLE IF EXISTS `pgw`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pgw` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ipv4` varchar(15) NOT NULL,
  `ipv6` varchar(39) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ipv4` (`ipv4`),
  UNIQUE KEY `ipv6` (`ipv6`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pgw`
--

LOCK TABLES `pgw` WRITE;
/*!40000 ALTER TABLE `pgw` DISABLE KEYS */;
INSERT INTO `pgw` VALUES (1,'127.0.0.1','0:0:0:0:0:0:0:1'),(2,'192.168.56.101',''),(3,'10.0.0.2','0');
/*!40000 ALTER TABLE `pgw` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `terminal-info`
--

DROP TABLE IF EXISTS `terminal-info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `terminal-info` (
  `imei` varchar(15) NOT NULL,
  `sv` varchar(2) NOT NULL,
  UNIQUE KEY `imei` (`imei`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `terminal-info`
--

LOCK TABLES `terminal-info` WRITE;
/*!40000 ALTER TABLE `terminal-info` DISABLE KEYS */;
/*!40000 ALTER TABLE `terminal-info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `imsi` varchar(15) NOT NULL COMMENT 'IMSI is the main reference key.',
  `msisdn` varchar(46) DEFAULT NULL COMMENT 'The basic MSISDN of the UE (Presence of MSISDN is optional).',
  `imei` varchar(15) DEFAULT NULL COMMENT 'International Mobile Equipment Identity',
  `imei_sv` varchar(2) DEFAULT NULL COMMENT 'International Mobile Equipment Identity Software Version Number',
  `ms_ps_status` enum('PURGED','NOT_PURGED') DEFAULT 'PURGED' COMMENT 'Indicates that ESM and EMM status are purged from MME',
  `rau_tau_timer` int(10) unsigned DEFAULT '120',
  `ue_ambr_ul` bigint(20) unsigned DEFAULT '50000000' COMMENT 'The Maximum Aggregated uplink MBRs to be shared across all Non-GBR bearers according to the subscription of the user.',
  `ue_ambr_dl` bigint(20) unsigned DEFAULT '100000000' COMMENT 'The Maximum Aggregated downlink MBRs to be shared across all Non-GBR bearers according to the subscription of the user.',
  `access_restriction` int(10) unsigned DEFAULT '60' COMMENT 'Indicates the access restriction subscription information. 3GPP TS.29272 #7.3.31',
  `mme_cap` int(10) unsigned zerofill DEFAULT NULL COMMENT 'Indicates the capabilities of the MME with respect to core functionality e.g. regional access restrictions.',
  `mmeidentity_idmmeidentity` int(11) NOT NULL DEFAULT '0',
  `key` varbinary(16) NOT NULL DEFAULT '0' COMMENT 'UE security key',
  `RFSP-Index` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'An index to specific RRM configuration in the E-UTRAN. Possible values from 1 to 256',
  `urrp_mme` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'UE Reachability Request Parameter indicating that UE activity notification from MME has been requested by the HSS.',
  `sqn` bigint(20) unsigned zerofill NOT NULL,
  `rand` varbinary(16) NOT NULL,
  `OPc` varbinary(16) DEFAULT NULL COMMENT 'Can be computed by HSS',
  PRIMARY KEY (`imsi`,`mmeidentity_idmmeidentity`),
  KEY `fk_users_mmeidentity_idx1` (`mmeidentity_idmmeidentity`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('208930000000008','33638060008',NULL,NULL,'PURGED',120,40000000,100000000,47,0000000000,2,'��G?/�Д\�',1,0,00000000004294969388,'��I�j�\�','ӃU�Bwe#j��%�,�\Z'),('208930000000009','33638060009',NULL,NULL,'PURGED',120,40000000,100000000,47,0000000000,2,'��G?/�ДWd',1,0,00000000000000033361,'\ZM{�h��#\�','o+y\"0\nb��'),('208930000000053','33638060053','35611302209415',NULL,'PURGED',120,40000000,100000000,47,0000000000,2,'��G?/�Д6\�',1,0,00000000004294972622,'o.�q@�#�\0\�','KA\��&o��R\�E�;z\0Q'),('208930000000055','33638060055',NULL,NULL,'PURGED',120,40000000,100000000,47,0000000000,2,'��G?/�ДM',1,0,00000000004294969388,'��I�j�\�','(>�Dh���\�\�!^4'),('208930000000054','33638060054',NULL,NULL,'PURGED',120,40000000,100000000,47,0000000000,2,'��G?/�ДM',1,0,00000000000000039820,'B@W�شJUٰTo','(>�Dh���\�\�!^4'),('111011234567891','11234567891',NULL,NULL,'NOT_PURGED',120,40000000,100000000,47,0000000000,1,'1234567890123456',1,0,00000000000000054380,'�\�9%c�EU�\�/��KJ','DN�8\�j�\�\�\�\�\�\�56'),('111011234567890','11234567890',NULL,NULL,'NOT_PURGED',120,40000000,100000000,47,0000000000,1,'1234567890123456',1,0,00000000000000054348,'ܵfq�\"X\�&)s�#','DN�8\�j�\�\�\�\�\�\�56');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-10-26 23:28:54
