-- MySQL dump 10.13  Distrib 9.0.1, for macos15.0 (arm64)
--
-- Host: localhost    Database: cas
-- ------------------------------------------------------
-- Server version	9.1.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `app`
--

DROP TABLE IF EXISTS `app`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uid` int NOT NULL,
  `amid` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `client_id` text NOT NULL,
  `secret` text NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `amid` (`amid`),
  CONSTRAINT `app_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user_data` (`id`),
  CONSTRAINT `app_ibfk_2` FOREIGN KEY (`amid`) REFERENCES `auth_method` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app`
--

LOCK TABLES `app` WRITE;
/*!40000 ALTER TABLE `app` DISABLE KEYS */;
INSERT INTO `app` VALUES (2,12,2,'sample','1fd9ef05-3623-4911-ae02-c79cc79edf41','e4b526c464b3c4f500e5b0c8c03579f45f70dec7f3d3e1ccf5f89528293fc4ae','2024-11-16 03:05:32','2024-11-16 03:05:32'),(3,12,2,'sample2','04e8207b-a970-459f-99d5-7bcc749f3bc3','8607225690527a20433b633c62f34cc9f77769c60467038bf6a7aabf43abbdb1','2024-11-16 03:34:24','2024-11-16 03:34:24'),(4,12,2,'sample3','1ddd7924-4ab5-4aa9-a87c-666e7d4b17b3','7af037cb4570c717c2ebed5b98ddb933e9e90d0e6a47a541746b8614fd596dff','2024-11-16 03:35:36','2024-11-16 03:35:36'),(5,12,2,'samplev','2bfaf4f7-aadc-400e-8808-372da010885a','ce7cd9918ca6a30a67ceec240d5029ef8d9dcc24f5856ee338db813db8dd8147','2024-11-16 03:36:05','2024-11-16 03:36:05'),(6,12,2,'samplev1','dc0454a6-3170-4f8d-b6d7-0b1a48a3292f','34e461fdaa57d971498fe139a37fedf96efb80c81bfc48cfddc4fc7c2668fc77','2024-11-16 03:39:00','2024-11-16 03:39:00'),(7,12,2,'samplev2','f6a3a953-fd4b-46b8-9abe-2aef8d6da133','2dcbaa0cfe2a9046ea634c9c931134cbe046a03df1e00ac0a1bc892c743b3384','2024-11-16 03:39:37','2024-11-16 03:39:37'),(8,12,2,'samplev3','75da104a-7090-44a8-a16d-68e2dd52cdfe','fd0ea2794e894cff74dd29b749386a6aac94502776c745f4441d6d82e898ffea','2024-11-16 03:40:06','2024-11-16 03:40:06'),(9,12,2,'samplev4','3ae8a099-abe2-4b33-b216-87dc4a25f674','453a307c399a527dfd17923de0801fe5f4f0ef860eb31663b78ab394429e0bef','2024-11-16 03:54:28','2024-11-16 03:54:28'),(10,12,2,'samplev5','0d349d5d-3f63-458b-9c9d-dbe7e0c0deb5','0313c6def6dac53a005a707776f6f05c8a0bdd44fe6943ce64b9ebb86000258d','2024-11-16 04:36:02','2024-11-16 04:36:02'),(11,21,2,'SAMPLE0838ed','d2f97d56-8adb-445e-9112-1479b7c5be82','7ca0ea2ad52076884db068900f9d0d3c4b4ee89dc0ca73f1380ec08f3e87dfe6','2024-11-16 04:41:11','2024-11-16 04:41:11'),(12,21,2,'SAMPLEe08fe7','b2d98459-1400-40da-9963-9daa4e03469b','eb93b59f77f9248567b11091968fd30eca89d221dad7a5ae4c10a00b24ea7f9f','2024-11-16 04:42:12','2024-11-16 04:42:12'),(13,21,2,'SAMPLEbc91e8','de672f87-567c-4781-ad53-4a074feb9b6b','319df2aede5b2c29944b13d5a12781b59286924955309421a1187bceeb1d9759','2024-11-16 04:43:17','2024-11-16 04:43:17'),(14,21,2,'SAMPLE377394','8367d81d-87d8-42fb-b6dc-b91a069e782d','b886c152339e295d29e1c9f3113d8b763d239dc1b5d178ca9733f1adb0bf304e','2024-11-16 04:43:35','2024-11-16 04:43:35'),(15,21,2,'SAMPLE180dda','969a8403-5309-4e9e-bca8-038936017ddd','abd2c3e12391c4ec2e6a27cec6d4f58f8811d28ba8e0ce29ef4176b9b8b694d9','2024-11-16 04:46:33','2024-11-16 04:46:33'),(16,21,2,'SAMPLE9185a2','c9857865-4ba5-41eb-b843-bfeb506f42ea','b2d19c40e12b6cea87892809a7ff830b521df9d99838a4914f7c0006d2f78068','2024-11-16 04:46:48','2024-11-16 04:46:48'),(17,21,2,'SAMPLEe95efb','bcaae65e-074c-4531-89d2-20bf28ef0f54','0cf50a487c1cb1d059c12d39d4dc219cd4bbe61e5589d4c4a766b8fe25a3228b','2024-11-16 04:50:18','2024-11-16 04:50:18'),(18,21,2,'SAMPLEb274fc','15923eed-5176-4c6f-baf9-8f18bdc7772b','fd832be460854a6796de8da9a6e462da3dd5b24be47414f8e8eb288657f5f63b','2024-11-16 04:52:01','2024-11-16 04:52:01'),(19,21,2,'SAMPLE4d5c61','16fe348d-587a-4a83-bd58-ac1674d8379d','8fa6222f84cc1ad2b7cde447d51a56ae91be5e315cd7e1b0f2d5e1253bd9f66a','2024-11-16 04:54:55','2024-11-16 04:54:55'),(20,21,2,'SAMPLEcfcd05','ce1e768e-0ef1-4bc0-901f-315b7c77e299','14a2f1b49e0737dd8fd2fe111774b12e4733bdff449d029c258aa05212d7896c','2024-11-16 04:58:13','2024-11-16 04:58:13'),(21,21,2,'SAMPLE572748','2b3ee6be-7f09-4da4-9e7c-0c149b1ee9cf','2969c750bdc752cc109cf9fc14c23941b494bc93d2612c898fcc7bcea1adbaee','2024-11-16 04:59:47','2024-11-16 04:59:47'),(22,21,2,'SAMPLE87153b','a7ccc890-4b2f-4c1d-923b-91ccbc5399f1','5cdea1825ca8f00c6d8799e3e84d337289252057c8d97f21bb3837c8bf8d1182','2024-11-16 05:00:50','2024-11-16 05:00:50'),(23,21,2,'SAMPLE90cb9f','c3fdbde5-345c-4af6-b92a-b05af612e768','cb84a0ed3a7c82ee47d3744203937dd18a18179f4cc5e7f83b757c9868ed711d','2024-11-16 05:01:53','2024-11-16 05:01:53'),(24,21,2,'SAMPLE3c3609','4f51d571-d01a-4b76-99cb-c84b0f444def','b8b8c90b0a19e02bc5c3aa12e3368c5ffeff1c2d10e78d8b620255f29c998900','2024-11-16 05:02:21','2024-11-16 05:02:21'),(25,21,2,'SAMPLEc9e4c2','ae700b25-3b79-47a0-89f9-55422ab83640','31c0e06035eee061431bd3ec0e1d502c04463c5d34f87565c6b82eea0bc97935','2024-11-16 05:03:06','2024-11-16 05:03:06'),(26,21,2,'SAMPLE4aac28','ab15d0f7-63e5-4d85-acf0-207491c368c8','fcb58c545602eaf1a46901251a88e494e41147d70f57d4f4d665e995e09d5c6e','2024-11-16 05:07:38','2024-11-16 05:07:38'),(27,21,2,'SAMPLEe09b49','8c695da6-6985-41b6-ae09-904b2d17757e','740f6bb2302e5aeca8aca9e9966e4273287d32b70bb5332f378257e6b2982e1d','2024-11-16 05:08:54','2024-11-16 05:08:54'),(28,21,2,'SAMPLE767a00','166c40b2-453d-422e-9217-04ec51561d41','c0c308fb0e387771b4101df3801f7a18815e25cf7cdae0998f10d42cb521c244','2024-11-16 05:09:32','2024-11-16 05:09:32'),(29,21,2,'SAMPLEab8f95','3577a10d-be32-42a4-95cd-0a26625931b9','5a577733e85dc1759f4bec1bb2300e149490e4d3ab0671c8aec88b6f3035621a','2024-11-16 05:10:03','2024-11-16 05:10:03'),(30,21,2,'SAMPLE6a9ed5','4f03014f-f978-4259-af14-e194ef292872','953d2b30a2d7fe4563ec16b2e699f17e626eca227edbc827194b5e7ee1cd5b2c','2024-11-16 05:11:28','2024-11-16 05:11:28'),(31,21,2,'SAMPLE872fb0','2a58e6c5-640e-4cae-970f-ce3de2c23b31','25a8cbac08668cda08f8d23df9bf18ca264a242f0861dc0552ea71d70f9f8473','2024-11-16 05:12:06','2024-11-16 05:12:06'),(32,21,2,'SAMPLEe9b56d','d0e5f1f6-7979-4dc8-a2b9-56e9a19ef026','66eabb0cd4fb233187326cf4aedda34f27fcf92506f91fcb5d0bbe411419ca6d','2024-11-16 05:13:41','2024-11-16 05:13:41');
/*!40000 ALTER TABLE `app` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_config`
--

DROP TABLE IF EXISTS `app_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_config` (
  `id` int NOT NULL AUTO_INCREMENT,
  `aid` int NOT NULL,
  `metadata` text NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `aid` (`aid`),
  CONSTRAINT `app_config_ibfk_1` FOREIGN KEY (`aid`) REFERENCES `app` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_config`
--

LOCK TABLES `app_config` WRITE;
/*!40000 ALTER TABLE `app_config` DISABLE KEYS */;
INSERT INTO `app_config` VALUES (1,8,'{\"meta\": \"data\"}','2024-11-16 03:40:06','2024-11-16 03:40:06'),(2,9,'{\"meta\": \"data\"}','2024-11-16 03:54:28','2024-11-16 03:54:28'),(3,10,'{\"meta\": \"data\"}','2024-11-16 04:36:02','2024-11-16 04:36:02');
/*!40000 ALTER TABLE `app_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_method`
--

DROP TABLE IF EXISTS `auth_method`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_method` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` enum('plain','plain-jwt','google') NOT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_method`
--

LOCK TABLES `auth_method` WRITE;
/*!40000 ALTER TABLE `auth_method` DISABLE KEYS */;
INSERT INTO `auth_method` VALUES (1,'plain','2024-11-16 01:13:00'),(2,'plain-jwt','2024-11-16 01:13:09');
/*!40000 ALTER TABLE `auth_method` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_token`
--

DROP TABLE IF EXISTS `auth_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_token` (
  `id` int NOT NULL AUTO_INCREMENT,
  `auid` int NOT NULL,
  `token` text NOT NULL,
  `expiry` timestamp NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `auid` (`auid`),
  CONSTRAINT `auth_token_ibfk_1` FOREIGN KEY (`auid`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_token`
--

LOCK TABLES `auth_token` WRITE;
/*!40000 ALTER TABLE `auth_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_trail`
--

DROP TABLE IF EXISTS `auth_trail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_trail` (
  `aid` int NOT NULL,
  `auid` int NOT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`aid`,`auid`),
  KEY `auid` (`auid`),
  CONSTRAINT `auth_trail_ibfk_1` FOREIGN KEY (`aid`) REFERENCES `app` (`id`),
  CONSTRAINT `auth_trail_ibfk_2` FOREIGN KEY (`auid`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_trail`
--

LOCK TABLES `auth_trail` WRITE;
/*!40000 ALTER TABLE `auth_trail` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_trail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `aid` int NOT NULL,
  `amid` int NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` text,
  `is_blocked` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `aid` (`aid`),
  KEY `amid` (`amid`),
  CONSTRAINT `auth_user_ibfk_1` FOREIGN KEY (`aid`) REFERENCES `app` (`id`),
  CONSTRAINT `auth_user_ibfk_2` FOREIGN KEY (`amid`) REFERENCES `auth_method` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (2,2,1,'hahahaahahhaah','$2b$12$3ZllNxN7C3XuMZsxieC03eGnvZobBNqembhitJL3gi5t3dNkmHYsi',0,'2024-11-16 04:19:40','2024-11-16 04:19:40'),(3,2,1,'hahahaahahhaah1','$2b$12$9n7TMr5hA53GwHceqP.Tbug4Osquka4ha83v2Wd62QEi61//s/3kS',0,'2024-11-16 04:53:49','2024-11-16 04:53:49'),(4,2,1,'hahahaahahhaah21','$2b$12$TboSqYGuhyYEHT/HkYPm8ulLKObD3NKqCHLa1IFfm/tTkoqUThekK',0,'2024-11-16 04:59:02','2024-11-16 04:59:02'),(5,11,1,'SAMPLE0c0792','$2b$12$Cf.z7sbg26tdLtDZtf2WTuHAyDM2yYsuJum8YkbPukzEBiy5NjXbu',0,'2024-11-16 05:02:26','2024-11-16 05:02:26'),(6,11,1,'SAMPLEc2f36a','$2b$12$LwCCaJMsaNgeE3iErRdi.uYJKVmC8RRi9C03R.Fq6xIbHEBlvnRW6',0,'2024-11-16 05:03:11','2024-11-16 05:03:11'),(7,11,1,'SAMPLEcbe3d2','$2b$12$hSnutPP.7ZQi2W6phuRznO8f69LwV7Xxxse3Omt3O3dbtvrhUQJ.i',0,'2024-11-16 05:07:43','2024-11-16 05:07:43'),(8,11,1,'SAMPLE68427d','$2b$12$LTOf1.rntdPXwWFlR7k1Z.VQ1AKLKXYpJYoDkcrzY1Dy7QNv3o8YG',0,'2024-11-16 05:08:58','2024-11-16 05:08:58'),(9,11,1,'SAMPLEb9b54d','$2b$12$Bd8kYU78sy2RRYBsKKX8Zuedu/f7N5acGUTAFvT/J8EMonZSVjFdu',0,'2024-11-16 05:09:37','2024-11-16 05:09:37'),(10,11,1,'SAMPLEcb0f08','$2b$12$piRJF4SfCf3D0lI3e/FNReukprG.sGC6OPYR5wqY.UfyjP0jAn.9W',0,'2024-11-16 05:10:08','2024-11-16 05:10:08'),(11,11,1,'SAMPLE200381','$2b$12$GGjzKZq39tobKkUFYWj5QOTMfEnGAUpfEDcEp7KcaEVy6xP0fNoPy',0,'2024-11-16 05:11:33','2024-11-16 05:11:33'),(12,11,1,'SAMPLE130108','$2b$12$AXxNFmQXhpe1Jm5UzmAgwOpS9wfsjw9waH5DasISTkAuQdOjTtsN2',0,'2024-11-16 05:12:11','2024-11-16 05:12:11'),(13,11,1,'SAMPLE384f0a','$2b$12$rB2z76j4l8MkQ9CnjoSK2e0bxiz.nR3XanJJ3MQJYMgzyBzRh5a1O',0,'2024-11-16 05:13:46','2024-11-16 05:13:46');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_data`
--

DROP TABLE IF EXISTS `user_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_data` (
  `id` int NOT NULL AUTO_INCREMENT,
  `rid` int NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` text,
  `source` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `rid` (`rid`),
  CONSTRAINT `user_data_ibfk_1` FOREIGN KEY (`rid`) REFERENCES `user_role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_data`
--

LOCK TABLES `user_data` WRITE;
/*!40000 ALTER TABLE `user_data` DISABLE KEYS */;
INSERT INTO `user_data` VALUES (6,2,'nkasd','$2b$12$CCFxrHQKjdbGNxYvpSBozehH9VwMmCG952Q.pBm.RGWdbu7PUwVZW','api','2024-11-11 11:40:40','2024-11-11 11:40:40'),(8,2,'nidhip4@gmail.com','$2b$12$IHP3FPIqudubyQf1YJwG2OZLXM1lRcCsjxTQM5RseUiJxNlMfPOwu','api','2024-11-15 16:50:59','2024-11-15 16:50:59'),(9,2,'nidhipc80595@gmail.com','$2b$12$CoooS27Ve8qVb.CL8oPH0.ga1USDULQGMhK8IM2V.osRSvCe8xGZS','api','2024-11-15 16:54:32','2024-11-15 16:54:32'),(10,2,'nidhip35cb95@gmail.com','$2b$12$otn03f/umdUeAV/6VFTkP.BH5YWinmXqPNV1TeEihHlz6zFEo6OgS','api','2024-11-15 16:55:57','2024-11-15 16:55:57'),(11,2,'nidhip73c899@gmail.com','$2b$12$zQEb28SOexqXajSem32qWesGXa87UFu00sboOjLdYBVAaDQ3cdiCO','api','2024-11-15 16:56:14','2024-11-15 16:56:14'),(12,2,'nidhip@gmail.com','$2b$12$FHB7foqHVHl0VgQqJ92PyORwKZX8NWi8kjafZIvxmFLMb9ho7aILC','api','2024-11-15 23:57:40','2024-11-15 23:57:40'),(13,2,'nidhip3160fd@gmail.com','$2b$12$3zvCMtmfC2Zy0t.4Oy87C.xd7ekDR5dPwrqxeFDHpcb.gfRamoIdm','api','2024-11-16 01:15:39','2024-11-16 01:15:39'),(14,2,'nidhipa9118b@gmail.com','$2b$12$9.0f212HQx3uByAwWqyNseonJ3pH.if3b7tICzCWTBpPbbhMLpjAq','api','2024-11-16 01:16:13','2024-11-16 01:16:13'),(15,2,'nidhip55b0d3@gmail.com','$2b$12$SiWJwT/V3Hp.MlUQDUc31OQINVDI2Cz.JM88sdsquRVOXsHF/XiJ2','api','2024-11-16 01:17:51','2024-11-16 01:17:51'),(16,2,'nidhip75e4a0@gmail.com','$2b$12$D8V3VlKqXTXXpS/8S0hbMOIuXDISyil1fu7DM/.99XEJcByDu42lu','api','2024-11-16 01:20:31','2024-11-16 01:20:31'),(17,2,'nidhip9049c9@gmail.com','$2b$12$rwQWRTM/m.tsitwCuqFRzurcK/.k0VMrZxu3lI0mRzqU3KN.GMjmW','api','2024-11-16 01:22:18','2024-11-16 01:22:18'),(18,2,'nidhip582c04@gmail.com','$2b$12$IUzhBBiYOy0GD1HWJ6dti.JOuhgVonk/TVZy3wmeF5OBG5KaIsmme','api','2024-11-16 01:48:32','2024-11-16 01:48:32'),(19,2,'nidhip7ab24d@gmail.com','$2b$12$Ddjn1k8dTR2FdwYKD7obsOTI2g1z8rauQqJGVi1TYEg2HRFnrZiqy','api','2024-11-16 02:01:11','2024-11-16 02:01:11'),(20,2,'nidhip3feab8@gmail.com','$2b$12$3vDdTT6bHQHxvCTabwQSWOWtqe8uNgjmzQ3Wd3vl0UN2IQjsts2rW','api','2024-11-16 04:31:43','2024-11-16 04:31:43'),(21,2,'admin@gmail.com','$2b$12$iP.eIKIDW8NGwZmBrc.D6e.ekFhy.I8kVCi.EykRDCxFMU7dJBctG','api','2024-11-16 04:35:09','2024-11-16 04:35:09'),(22,2,'nidhipefc317@gmail.com','$2b$12$50k7Dds2ORFMfBw2JUQTUuRSnNzn9DunuukoaTscqVFKxxnx9q3Eq','api','2024-11-16 04:37:42','2024-11-16 04:37:42'),(23,2,'nidhip0f93b0@gmail.com','$2b$12$g7n4WWvJyiV5hc8aufMvFenUBfes2vpVG0d0XPnG6vmmLlUP3TZAe','api','2024-11-16 04:39:09','2024-11-16 04:39:09'),(24,2,'nidhip09a064@gmail.com','$2b$12$qvcny6cniRqypkIaKWHMMeEUk4ShNJe1mZNMjkifrDwE12VYtQPVi','api','2024-11-16 04:39:48','2024-11-16 04:39:48'),(25,2,'nidhipa9092c@gmail.com','$2b$12$Vda/UWUAlZ9lvnLryvXGzO.AgUa7JkwG2ndFA1cWhp3G10IutaUZm','api','2024-11-16 04:40:04','2024-11-16 04:40:04'),(26,2,'nidhipdf491b@gmail.com','$2b$12$X7I0jFV6rVDUyvbKgVFKiOm8yUfzZ3zKlFvV2JGvb45kAwiu0m0UC','api','2024-11-16 04:41:11','2024-11-16 04:41:11'),(27,2,'nidhip71e9e2@gmail.com','$2b$12$HPSMITtxAPeIY42nP/vHAOPzhUPWr2U.RfyZ.PCYFNk9VcMhsWuqO','api','2024-11-16 04:42:13','2024-11-16 04:42:13'),(28,2,'nidhip2adc93@gmail.com','$2b$12$AzIPyVVCHv969q5ca7dhhOKejm0HVzJBzaDmicFb7qnwxA1zPJ1ta','api','2024-11-16 04:43:18','2024-11-16 04:43:18'),(29,2,'nidhip384f40@gmail.com','$2b$12$w.X71MNWcHdWhaeDvYqlaOzPZz3eZuyesLjXTfY4r8jPMAI0YPqZi','api','2024-11-16 04:43:36','2024-11-16 04:43:36'),(30,2,'nidhip28bc6d@gmail.com','$2b$12$sNLuSWunDiKbXy/uNbZux.B7wacc/Nr8gZQvLiM2E.htwceVgjRsO','api','2024-11-16 04:46:35','2024-11-16 04:46:35'),(31,2,'nidhip2ddd60@gmail.com','$2b$12$CQ1tehlfMNHcJjFujG8cEe575UrlrtbowZnZNn8zSQcCkjexMYpae','api','2024-11-16 04:46:49','2024-11-16 04:46:49'),(32,2,'nidhip808d34@gmail.com','$2b$12$jmaxkmVUOkPHzG/mXqyWHOChQPbCr1.xdEz.2h/7iyk7JpVRKpfc.','api','2024-11-16 04:50:20','2024-11-16 04:50:20'),(33,2,'nidhipb85e63@gmail.com','$2b$12$6yHBRR.pA.5T6uQP472PlOPGvSoE/DNEMMjscVrrOgphwxrc.xBhS','api','2024-11-16 04:52:02','2024-11-16 04:52:02'),(34,2,'nidhipe1eb9d@gmail.com','$2b$12$c5aA1XPHdwQt7xmUHztDLeEyg0wvoPJN3afmAZ0mEcOKxWlqChrqa','api','2024-11-16 04:54:56','2024-11-16 04:54:56'),(35,2,'nidhip5fdc77@gmail.com','$2b$12$sJcx1iJK0YaAlyYboqPNe.kuK8eeVx7/dqkoke5PZaEVd5lIefcMS','api','2024-11-16 04:58:14','2024-11-16 04:58:14'),(36,2,'nidhipc6be01@gmail.com','$2b$12$LP04vwUhPUpGkf9zlgxTouO/5j.Kz.zzv81szGXlueGZCUm5TputK','api','2024-11-16 04:59:48','2024-11-16 04:59:48'),(37,2,'nidhip726222@gmail.com','$2b$12$bb0yX2Ec/UdRcGugxnWn2OBPZJkVxqsMkYFaMQN.4uTpbFEoyibF.','api','2024-11-16 05:00:51','2024-11-16 05:00:51'),(38,2,'nidhip2e7b85@gmail.com','$2b$12$p1M31gCAHfsT4pemFdwDpumX1kjfB4iIn9zjj2bFhlUJq/nRv2XRy','api','2024-11-16 05:01:55','2024-11-16 05:01:55'),(39,2,'nidhipaf674f@gmail.com','$2b$12$JU3OZrBGb8HpYCF1iMXfw.9TMCI4v7p.ogjzsqhFGmzJuScWV5Qzi','api','2024-11-16 05:02:22','2024-11-16 05:02:22'),(40,2,'nidhip013985@gmail.com','$2b$12$bAuri/27iVrckWE24oDTiORibqcUV7VUGd6QT4avyJYw9bw/rzuXi','api','2024-11-16 05:03:07','2024-11-16 05:03:07'),(41,2,'nidhipec492f@gmail.com','$2b$12$cjbmzv/8Fys50WGIho53L.pdYL.1bjXtHMpEbXreSAFSOGKn1uHLu','api','2024-11-16 05:07:39','2024-11-16 05:07:39'),(42,2,'nidhip07a0a9@gmail.com','$2b$12$2WKj545dlgvyteGhD/A9IuXuQVyPZQq5eWYc0dPWx.MvHXyDkP6vW','api','2024-11-16 05:08:55','2024-11-16 05:08:55'),(43,2,'nidhip135aec@gmail.com','$2b$12$beenXPalqCPor7afKNap9u7hq5XRqhbSNsWZvXE5iOIQt3hN4ahwW','api','2024-11-16 05:09:33','2024-11-16 05:09:33'),(44,2,'nidhip4c86fe@gmail.com','$2b$12$TCXCcaYLCwqWuc5DPkAauOMUs9CJjimH05pvQwqHBlqRMo1V3TzV2','api','2024-11-16 05:10:04','2024-11-16 05:10:04'),(45,2,'nidhipf131e2@gmail.com','$2b$12$laug1PZh/tLjTBES2RWsseXiHHwzlzGmYvP5T8t0EleAQs0k/6Baa','api','2024-11-16 05:11:29','2024-11-16 05:11:29'),(46,2,'nidhipf13e02@gmail.com','$2b$12$rpdQctnk0izXNJ0aZZ02eekLYQLUDbF46RQH.WowZwbEIvw1SXPCO','api','2024-11-16 05:12:07','2024-11-16 05:12:07'),(47,2,'nidhip1b78b0@gmail.com','$2b$12$9cSBJmiGjkgBACU3nVBVzuQgEHSS/qvn4NGJMdkH3MkseM5gOeadi','api','2024-11-16 05:13:43','2024-11-16 05:13:43');
/*!40000 ALTER TABLE `user_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cur_uk_name_type` (`name`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` VALUES (1,'admin','company','2024-11-11 11:40:03'),(2,'user','normal','2024-11-11 11:40:27');
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-16 11:22:10
