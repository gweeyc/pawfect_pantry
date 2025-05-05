-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: capstone_db
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `account_emailaddress`
--

DROP TABLE IF EXISTS `account_emailaddress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_emailaddress` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(254) NOT NULL,
  `verified` tinyint(1) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_emailaddress_user_id_email_987c8728_uniq` (`user_id`,`email`),
  KEY `account_emailaddress_email_03be32b2` (`email`),
  CONSTRAINT `account_emailaddress_user_id_2c513194_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_emailaddress`
--

LOCK TABLES `account_emailaddress` WRITE;
/*!40000 ALTER TABLE `account_emailaddress` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_emailaddress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_emailconfirmation`
--

DROP TABLE IF EXISTS `account_emailconfirmation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_emailconfirmation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `sent` datetime(6) DEFAULT NULL,
  `key` varchar(64) NOT NULL,
  `email_address_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`),
  KEY `account_emailconfirm_email_address_id_5b7f8c58_fk_account_e` (`email_address_id`),
  CONSTRAINT `account_emailconfirm_email_address_id_5b7f8c58_fk_account_e` FOREIGN KEY (`email_address_id`) REFERENCES `account_emailaddress` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_emailconfirmation`
--

LOCK TABLES `account_emailconfirmation` WRITE;
/*!40000 ALTER TABLE `account_emailconfirmation` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_emailconfirmation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add order',7,'add_order'),(26,'Can change order',7,'change_order'),(27,'Can delete order',7,'delete_order'),(28,'Can view order',7,'view_order'),(29,'Can add order status history',8,'add_orderstatushistory'),(30,'Can change order status history',8,'change_orderstatushistory'),(31,'Can delete order status history',8,'delete_orderstatushistory'),(32,'Can view order status history',8,'view_orderstatushistory'),(33,'Can add product',9,'add_product'),(34,'Can change product',9,'change_product'),(35,'Can delete product',9,'delete_product'),(36,'Can view product',9,'view_product'),(37,'Can add order item',10,'add_orderitem'),(38,'Can change order item',10,'change_orderitem'),(39,'Can delete order item',10,'delete_orderitem'),(40,'Can view order item',10,'view_orderitem'),(41,'Can add feedback',11,'add_feedback'),(42,'Can change feedback',11,'change_feedback'),(43,'Can delete feedback',11,'delete_feedback'),(44,'Can view feedback',11,'view_feedback'),(45,'Can add cart item',12,'add_cartitem'),(46,'Can change cart item',12,'change_cartitem'),(47,'Can delete cart item',12,'delete_cartitem'),(48,'Can view cart item',12,'view_cartitem'),(49,'Can add user profile',13,'add_userprofile'),(50,'Can change user profile',13,'change_userprofile'),(51,'Can delete user profile',13,'delete_userprofile'),(52,'Can view user profile',13,'view_userprofile'),(53,'Can add Token',14,'add_token'),(54,'Can change Token',14,'change_token'),(55,'Can delete Token',14,'delete_token'),(56,'Can view Token',14,'view_token'),(57,'Can add Token',15,'add_tokenproxy'),(58,'Can change Token',15,'change_tokenproxy'),(59,'Can delete Token',15,'delete_tokenproxy'),(60,'Can view Token',15,'view_tokenproxy'),(61,'Can add site',16,'add_site'),(62,'Can change site',16,'change_site'),(63,'Can delete site',16,'delete_site'),(64,'Can view site',16,'view_site'),(65,'Can add email address',17,'add_emailaddress'),(66,'Can change email address',17,'change_emailaddress'),(67,'Can delete email address',17,'delete_emailaddress'),(68,'Can view email address',17,'view_emailaddress'),(69,'Can add email confirmation',18,'add_emailconfirmation'),(70,'Can change email confirmation',18,'change_emailconfirmation'),(71,'Can delete email confirmation',18,'delete_emailconfirmation'),(72,'Can view email confirmation',18,'view_emailconfirmation'),(73,'Can add social account',19,'add_socialaccount'),(74,'Can change social account',19,'change_socialaccount'),(75,'Can delete social account',19,'delete_socialaccount'),(76,'Can view social account',19,'view_socialaccount'),(77,'Can add social application',20,'add_socialapp'),(78,'Can change social application',20,'change_socialapp'),(79,'Can delete social application',20,'delete_socialapp'),(80,'Can view social application',20,'view_socialapp'),(81,'Can add social application token',21,'add_socialtoken'),(82,'Can change social application token',21,'change_socialtoken'),(83,'Can delete social application token',21,'delete_socialtoken'),(84,'Can view social application token',21,'view_socialtoken'),(85,'Can add delivery',22,'add_delivery'),(86,'Can change delivery',22,'change_delivery'),(87,'Can delete delivery',22,'delete_delivery'),(88,'Can view delivery',22,'view_delivery'),(89,'Can add vendor',23,'add_vendor'),(90,'Can change vendor',23,'change_vendor'),(91,'Can delete vendor',23,'delete_vendor'),(92,'Can view vendor',23,'view_vendor');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$870000$pl5V7DK8WL5VD4Z5pVSIpa$zv0arZS8qQ92gZLO/OqJrFRtOAGo91aUwyr9Ixu2aEM=',NULL,0,'john_doe','John','Doe','john@example.com',0,1,'2025-04-21 12:37:58.212303'),(2,'pbkdf2_sha256$870000$h9aYtLnMTvuNgJq9yTDLRB$sq8oaLWgpC1UlSXLk+KhkbILuhbSkkpzqGp5GjCuLog=',NULL,0,'jane_smith','Jane','Smith','jane@example.com',0,1,'2025-04-21 12:37:58.826177'),(3,'pbkdf2_sha256$870000$V9k9wzB4elHiRKEY09qakq$LQj2uXUFb3g5wqQvSLZkWfrnktl2AlKubIlYfqBXK0Y=',NULL,0,'michael_lee','Michael','Lee','michael@example.com',0,1,'2025-04-21 12:37:59.440894'),(4,'pbkdf2_sha256$870000$7jFkpm91jg9tqNKt6Kppfo$2oDHgdKsvbJCgoLCs092B+pj7ekwdGOhNIdX0IBwwpU=',NULL,0,'emily_white','Emily','White','emily@example.com',0,1,'2025-04-21 12:38:00.104698'),(5,'pbkdf2_sha256$870000$Q8WdPFQZg9NXL0slskFQPu$svadn1dYWCmi64HzFU513Yth9IO5EG5smGrt30nUCdg=',NULL,0,'daniel_james','Daniel','James','daniel@example.com',0,1,'2025-04-21 12:38:00.732079'),(6,'pbkdf2_sha256$870000$CHKOO1PGHpONkw3Ren9Nsv$RrvZEomVEvldTBhxQypCECjId6XxzmzYmbE8+BD6FXA=',NULL,0,'olivia_brown','Olivia','Brown','olivia@example.com',0,1,'2025-04-21 12:38:01.352950'),(7,'pbkdf2_sha256$870000$OnoHc9BNRMUrDBDBqIQshB$WrjNv+duoPgyh5LzrkyoFjuKLzehVc+n9dBWf97hRWA=',NULL,0,'william_clark','William','Clark','william@example.com',0,1,'2025-04-21 12:38:01.940899'),(8,'pbkdf2_sha256$870000$FEKWXDq0fFEt6DcioHNsVD$tHTfffe/hQgfw3HcCqZUl78Roi6gD9KyOejnvw2axWE=',NULL,0,'sophia_hill','Sophia','Hill','sophia@example.com',0,1,'2025-04-21 12:38:02.524558'),(9,'pbkdf2_sha256$870000$gDTv4MzrCRc1ko9y01QM3C$B6+fzMIvQgOC7MRdlTV5LGnG08RLCQVgocVb8ljg5yU=',NULL,0,'david_jones','David','Jones','david@example.com',0,1,'2025-04-21 12:38:03.117292'),(10,'pbkdf2_sha256$870000$WzuEeBqEmf33k4LOPna2Km$Li+4xJvZyBUP+p6fktLAuOqnb6lA4RqMISZSPDML5To=',NULL,0,'ava_miller','Ava','Miller','ava@example.com',0,1,'2025-04-21 12:38:03.703361'),(11,'pbkdf2_sha256$870000$3yNbsG5e84rvvQ7EOJRFG7$DyiY/NRmH7lQ+lc9R+ZKHaLSdwxbm2YZys/hAvS15Lk=','2025-05-01 06:29:04.107020',1,'Admin','Arthur','Siew','siewmj@gmail.com',1,1,'2025-04-21 13:46:13.439061'),(12,'pbkdf2_sha256$870000$dVmNI16yVargcAChlZXsHZ$CByeYIeHPELoN0yBM08iBWNIE7iz4taRDqpNn+iHsOw=','2025-05-01 06:28:38.556238',0,'Insectta','Kai-Ning','Chua','kaining@gmail.com',0,1,'2025-04-21 13:46:13.439061'),(13,'s8812371i','2025-04-23 01:35:10.531779',0,'PetCubes','Evans','Sin','evan@gmail.com',0,1,'2025-04-21 13:46:13.439061'),(14,'s8812371i','2025-04-23 01:35:10.531779',0,'NorthSeafood','Jan','Kaptijn','kaptijn@gmail.com',0,1,'2025-04-21 13:46:13.439061'),(15,'s8812371i','2025-04-23 01:35:10.531779',0,'PaleoFood','Hermes','Sanctorum','hermes@gmail.com',0,1,'2025-04-21 13:46:13.439061'),(16,'s8812371i','2025-04-23 01:35:10.531779',0,'HilPet','Farid','Salman','farid@gmail.com',0,1,'2025-04-21 13:46:13.439061'),(17,'s8812371i','2025-04-23 01:35:10.531779',0,'GrandmaLucy','Lucy','Thompson','lucy@gmail.com',0,1,'2025-04-21 13:46:13.439061'),(18,'s8812371i','2025-04-23 01:35:10.531779',0,'GreenPrairie','Bob','Takahashi','bob@gmail.com',0,1,'2025-04-21 13:46:13.439061'),(19,'pbkdf2_sha256$870000$f6X0pZ0AnHZTOwAcTln3zN$cZHCrVp5rTtrdc1CGcjrtMt5oT8M5T/7HgSFqLhyWow=',NULL,0,'Fiona_Tan','Fiona','Tan','fionajyt@outlook.com',0,1,'2025-04-26 03:19:59.062811'),(20,'pbkdf2_sha256$870000$1gkcE6259EPEo7GNYolded$JayTv3QlrxSAXnwcMxi3zhas5NgYBXvcsc11cV6cu8U=',NULL,0,'Arthur_Generation','Arthur','Siew','ArthurS@genstudents.org',0,1,'2025-04-26 03:21:37.115706');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authtoken_token`
--

DROP TABLE IF EXISTS `authtoken_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`key`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `authtoken_token_user_id_35299eff_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authtoken_token`
--

LOCK TABLES `authtoken_token` WRITE;
/*!40000 ALTER TABLE `authtoken_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `authtoken_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (17,'account','emailaddress'),(18,'account','emailconfirmation'),(1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(14,'authtoken','token'),(15,'authtoken','tokenproxy'),(5,'contenttypes','contenttype'),(12,'my_apps','cartitem'),(22,'my_apps','delivery'),(11,'my_apps','feedback'),(7,'my_apps','order'),(10,'my_apps','orderitem'),(8,'my_apps','orderstatushistory'),(9,'my_apps','product'),(13,'my_apps','userprofile'),(23,'my_apps','vendor'),(6,'sessions','session'),(16,'sites','site'),(19,'socialaccount','socialaccount'),(20,'socialaccount','socialapp'),(21,'socialaccount','socialtoken');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2025-04-21 12:35:07.212630'),(2,'auth','0001_initial','2025-04-21 12:35:07.671138'),(3,'account','0001_initial','2025-04-21 12:35:07.812370'),(4,'account','0002_email_max_length','2025-04-21 12:35:07.827066'),(5,'account','0003_alter_emailaddress_create_unique_verified_email','2025-04-21 12:35:07.851153'),(6,'account','0004_alter_emailaddress_drop_unique_email','2025-04-21 12:35:07.879887'),(7,'account','0005_emailaddress_idx_upper_email','2025-04-21 12:35:07.921388'),(8,'account','0006_emailaddress_lower','2025-04-21 12:35:07.929676'),(9,'account','0007_emailaddress_idx_email','2025-04-21 12:35:07.963287'),(10,'account','0008_emailaddress_unique_primary_email_fixup','2025-04-21 12:35:07.971606'),(11,'account','0009_emailaddress_unique_primary_email','2025-04-21 12:35:07.977326'),(12,'admin','0001_initial','2025-04-21 12:35:08.093219'),(13,'admin','0002_logentry_remove_auto_add','2025-04-21 12:35:08.099474'),(14,'admin','0003_logentry_add_action_flag_choices','2025-04-21 12:35:08.105496'),(15,'contenttypes','0002_remove_content_type_name','2025-04-21 12:35:08.166571'),(16,'auth','0002_alter_permission_name_max_length','2025-04-21 12:35:08.220778'),(17,'auth','0003_alter_user_email_max_length','2025-04-21 12:35:08.243228'),(18,'auth','0004_alter_user_username_opts','2025-04-21 12:35:08.252113'),(19,'auth','0005_alter_user_last_login_null','2025-04-21 12:35:08.307685'),(20,'auth','0006_require_contenttypes_0002','2025-04-21 12:35:08.310150'),(21,'auth','0007_alter_validators_add_error_messages','2025-04-21 12:35:08.316866'),(22,'auth','0008_alter_user_username_max_length','2025-04-21 12:35:08.374526'),(23,'auth','0009_alter_user_last_name_max_length','2025-04-21 12:35:08.432043'),(24,'auth','0010_alter_group_name_max_length','2025-04-21 12:35:08.449561'),(25,'auth','0011_update_proxy_permissions','2025-04-21 12:35:08.457030'),(26,'auth','0012_alter_user_first_name_max_length','2025-04-21 12:35:08.508793'),(27,'authtoken','0001_initial','2025-04-21 12:35:08.582426'),(28,'authtoken','0002_auto_20160226_1747','2025-04-21 12:35:08.601767'),(29,'authtoken','0003_tokenproxy','2025-04-21 12:35:08.604893'),(30,'authtoken','0004_alter_tokenproxy_options','2025-04-21 12:35:08.609023'),(31,'my_apps','0001_initial','2025-04-21 12:35:09.294031'),(32,'my_apps','0002_userprofile_email','2025-04-21 12:35:09.311185'),(33,'my_apps','0003_alter_product_food_type_alter_product_species_and_more','2025-04-21 12:35:09.572069'),(34,'sessions','0001_initial','2025-04-21 12:35:09.598984'),(35,'sites','0001_initial','2025-04-21 12:35:09.613777'),(36,'sites','0002_alter_domain_unique','2025-04-21 12:35:09.626819'),(37,'socialaccount','0001_initial','2025-04-21 12:35:09.955480'),(38,'socialaccount','0002_token_max_lengths','2025-04-21 12:35:10.000260'),(39,'socialaccount','0003_extra_data_default_dict','2025-04-21 12:35:10.009643'),(40,'socialaccount','0004_app_provider_id_settings','2025-04-21 12:35:10.133821'),(41,'socialaccount','0005_socialtoken_nullable_app','2025-04-21 12:35:10.243429'),(42,'socialaccount','0006_alter_socialaccount_extra_data','2025-04-21 12:35:10.301370'),(43,'my_apps','0004_alter_orderitem_order','2025-04-21 14:40:52.203605'),(44,'my_apps','0005_userprofile_role_delivery_vendor','2025-04-22 17:09:42.437258'),(45,'my_apps','0006_product_vendor','2025-04-22 18:11:59.609808'),(46,'my_apps','0007_userprofile_profile_image_vendor_brand_image','2025-04-25 14:35:43.467490'),(47,'my_apps','0008_alter_vendor_user','2025-04-25 14:39:20.452459');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('appdy8v8lnjfsj5rtmdk9x4x0lgzzxrr','.eJxVjEEOwiAQRe_C2pAOhQIu3fcMZKYDUjWQlHZlvLtt0oVu_3vvv0XAbc1ha3EJM4urABCX35FwesZyEH5guVc51bIuM8lDkSdtcqwcX7fT_TvI2PJeJ8N9RMvkh0Ep1jqRc0QGGJLrJ28SgNeaI7rd6Swo9oYtJKswEXXi8wUdKzid:1u6tD2:i0p0hiEd_RO9fDWUg7Q5iwj9_st5J3Yzum_uS1W8_lw','2025-05-05 15:37:24.547031'),('k5jvjhwpzx31ddk9yv4kxnlgdr5jv6p6','.eJxVjEEOwiAQRe_C2pAOhQIu3fcMZKYDUjWQlHZlvLtt0oVu_3vvv0XAbc1ha3EJM4urABCX35FwesZyEH5guVc51bIuM8lDkSdtcqwcX7fT_TvI2PJeJ8N9RMvkh0Ep1jqRc0QGGJLrJ28SgNeaI7rd6Swo9oYtJKswEXXi8wUdKzid:1u7p48:JPiq8KvYND1vbTKE4Gmm4_2Mf3fjPpLSz7yW7xr2tfQ','2025-05-08 05:24:04.600843'),('oof9t12k03zvs1msvtdvf31wre0mcmnm','.eJxVjDsOwjAQBe_iGln-JbEp6TmDtetd4wCypTipEHeHSCmgfTPzXiLCtpa4dV7iTOIstBGn3xEhPbjuhO5Qb02mVtdlRrkr8qBdXhvx83K4fwcFevnWAVUGAq0VGJqCdXlyafBBW9SZTSDljXIISunR-0SJR7YZh-AQk2UU7w8JJTiB:1u9DCQ:e40UBFH-610RifZqFlDK7VYVboaGIhH5FVY86nc1p_E','2025-05-12 01:22:22.744630'),('tqt0dvv4um8kxprs4trxnh1farg0zrm7','.eJxVjEEOwiAQRe_C2pAOhQIu3fcMZKYDUjWQlHZlvLtt0oVu_3vvv0XAbc1ha3EJM4urABCX35FwesZyEH5guVc51bIuM8lDkSdtcqwcX7fT_TvI2PJeJ8N9RMvkh0Ep1jqRc0QGGJLrJ28SgNeaI7rd6Swo9oYtJKswEXXi8wUdKzid:1u7yoo:2WlhHt9MTdcbxfR9-rgLLx1NTToaQKAorD-GW8SL5OY','2025-05-08 15:48:54.566107'),('zcejk2qxcyvy3b1s80nsowzfcvhwiif9','.eJxVjEEOwiAQRe_C2pAOhQIu3fcMZKYDUjWQlHZlvLtt0oVu_3vvv0XAbc1ha3EJM4urABCX35FwesZyEH5guVc51bIuM8lDkSdtcqwcX7fT_TvI2PJeJ8N9RMvkh0Ep1jqRc0QGGJLrJ28SgNeaI7rd6Swo9oYtJKswEXXi8wUdKzid:1u7P1U:2Mi8jybqc0BqvKcCSrQVtR_3pMkk155aapR-wc6WWVc','2025-05-07 01:35:36.235436');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_site`
--

DROP TABLE IF EXISTS `django_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_site` (
  `id` int NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_site_domain_a2e37b91_uniq` (`domain`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_site`
--

LOCK TABLES `django_site` WRITE;
/*!40000 ALTER TABLE `django_site` DISABLE KEYS */;
INSERT INTO `django_site` VALUES (1,'example.com','example.com');
/*!40000 ALTER TABLE `django_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_apps_cartitem`
--

DROP TABLE IF EXISTS `my_apps_cartitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `my_apps_cartitem` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `quantity` int unsigned NOT NULL,
  `user_id` int NOT NULL,
  `product_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `my_apps_cartitem_user_id_b66eab46_fk_auth_user_id` (`user_id`),
  KEY `my_apps_cartitem_product_id_911ba27c_fk_my_apps_product_id` (`product_id`),
  CONSTRAINT `my_apps_cartitem_product_id_911ba27c_fk_my_apps_product_id` FOREIGN KEY (`product_id`) REFERENCES `my_apps_product` (`id`),
  CONSTRAINT `my_apps_cartitem_user_id_b66eab46_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `my_apps_cartitem_chk_1` CHECK ((`quantity` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_apps_cartitem`
--

LOCK TABLES `my_apps_cartitem` WRITE;
/*!40000 ALTER TABLE `my_apps_cartitem` DISABLE KEYS */;
INSERT INTO `my_apps_cartitem` VALUES (3,3,11,3),(4,1,11,4),(5,1,11,2);
/*!40000 ALTER TABLE `my_apps_cartitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_apps_delivery`
--

DROP TABLE IF EXISTS `my_apps_delivery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `my_apps_delivery` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `company` varchar(20) DEFAULT NULL,
  `pick_up_time` datetime(6) NOT NULL,
  `eta` datetime(6) NOT NULL,
  `actual_delivery_time` datetime(6) NOT NULL,
  `tracking_url` varchar(200) DEFAULT NULL,
  `order_id` bigint NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `my_apps_delivery_order_id_ccd80da7_fk_my_apps_order_id` (`order_id`),
  KEY `my_apps_delivery_user_id_69c67ebe_fk_auth_user_id` (`user_id`),
  CONSTRAINT `my_apps_delivery_order_id_ccd80da7_fk_my_apps_order_id` FOREIGN KEY (`order_id`) REFERENCES `my_apps_order` (`id`),
  CONSTRAINT `my_apps_delivery_user_id_69c67ebe_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_apps_delivery`
--

LOCK TABLES `my_apps_delivery` WRITE;
/*!40000 ALTER TABLE `my_apps_delivery` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_apps_delivery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_apps_feedback`
--

DROP TABLE IF EXISTS `my_apps_feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `my_apps_feedback` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `comment` longtext NOT NULL,
  `sentiment` varchar(20) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` int NOT NULL,
  `product_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `my_apps_feedback_user_id_ddb99988_fk_auth_user_id` (`user_id`),
  KEY `my_apps_feedback_product_id_4022e7b4_fk_my_apps_product_id` (`product_id`),
  CONSTRAINT `my_apps_feedback_product_id_4022e7b4_fk_my_apps_product_id` FOREIGN KEY (`product_id`) REFERENCES `my_apps_product` (`id`),
  CONSTRAINT `my_apps_feedback_user_id_ddb99988_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_apps_feedback`
--

LOCK TABLES `my_apps_feedback` WRITE;
/*!40000 ALTER TABLE `my_apps_feedback` DISABLE KEYS */;
INSERT INTO `my_apps_feedback` VALUES (1,'Omg, my cats got high and she love it !',NULL,'2025-04-22 01:11:59.181153',11,7),(2,'My Cats absolutely love it !',NULL,'2025-04-22 05:40:07.178140',11,18),(3,'My dogs lick the food ! It really love it !',NULL,'2025-04-22 08:02:43.586154',11,21),(4,'My dogs love it',NULL,'2025-04-25 01:25:10.333516',11,6);
/*!40000 ALTER TABLE `my_apps_feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_apps_order`
--

DROP TABLE IF EXISTS `my_apps_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `my_apps_order` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `full_name` varchar(255) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `address` longtext NOT NULL,
  `note` longtext,
  `total` decimal(10,2) NOT NULL,
  `status` varchar(50) NOT NULL,
  `date` datetime(6) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `my_apps_order_user_id_d904dd8c_fk_auth_user_id` (`user_id`),
  CONSTRAINT `my_apps_order_user_id_d904dd8c_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_apps_order`
--

LOCK TABLES `my_apps_order` WRITE;
/*!40000 ALTER TABLE `my_apps_order` DISABLE KEYS */;
INSERT INTO `my_apps_order` VALUES (1,'Arthur Siew','92702017','350A Canberra Road, 08-323','',29.97,'Processing','2025-04-21 14:25:08.545254',11);
/*!40000 ALTER TABLE `my_apps_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_apps_orderitem`
--

DROP TABLE IF EXISTS `my_apps_orderitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `my_apps_orderitem` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `quantity` int unsigned NOT NULL,
  `price` decimal(8,2) DEFAULT NULL,
  `order_id` bigint NOT NULL,
  `product_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `my_apps_orderitem_order_id_ae29bb0e_fk_my_apps_order_id` (`order_id`),
  KEY `my_apps_orderitem_product_id_ef8ecd93_fk_my_apps_product_id` (`product_id`),
  CONSTRAINT `my_apps_orderitem_order_id_ae29bb0e_fk_my_apps_order_id` FOREIGN KEY (`order_id`) REFERENCES `my_apps_order` (`id`),
  CONSTRAINT `my_apps_orderitem_product_id_ef8ecd93_fk_my_apps_product_id` FOREIGN KEY (`product_id`) REFERENCES `my_apps_product` (`id`),
  CONSTRAINT `my_apps_orderitem_chk_1` CHECK ((`quantity` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_apps_orderitem`
--

LOCK TABLES `my_apps_orderitem` WRITE;
/*!40000 ALTER TABLE `my_apps_orderitem` DISABLE KEYS */;
INSERT INTO `my_apps_orderitem` VALUES (1,2,9.99,1,1),(2,1,9.99,1,2);
/*!40000 ALTER TABLE `my_apps_orderitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_apps_orderstatushistory`
--

DROP TABLE IF EXISTS `my_apps_orderstatushistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `my_apps_orderstatushistory` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `status` varchar(50) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `order_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `my_apps_orderstatushistory_order_id_90bb019c_fk_my_apps_order_id` (`order_id`),
  CONSTRAINT `my_apps_orderstatushistory_order_id_90bb019c_fk_my_apps_order_id` FOREIGN KEY (`order_id`) REFERENCES `my_apps_order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_apps_orderstatushistory`
--

LOCK TABLES `my_apps_orderstatushistory` WRITE;
/*!40000 ALTER TABLE `my_apps_orderstatushistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_apps_orderstatushistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_apps_product`
--

DROP TABLE IF EXISTS `my_apps_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `my_apps_product` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `tags` varchar(500) DEFAULT NULL,
  `description` longtext,
  `price` decimal(8,2) DEFAULT NULL,
  `stock` int DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `views` int NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `food_type` varchar(100) DEFAULT NULL,
  `species` varchar(100) DEFAULT NULL,
  `vendor_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `my_apps_product_vendor_id_ade12088_fk_my_apps_vendor_id` (`vendor_id`),
  CONSTRAINT `my_apps_product_vendor_id_ade12088_fk_my_apps_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `my_apps_vendor` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_apps_product`
--

LOCK TABLES `my_apps_product` WRITE;
/*!40000 ALTER TABLE `my_apps_product` DISABLE KEYS */;
INSERT INTO `my_apps_product` VALUES (1,'Bacon Flavour Spray','protein,healthy','Dog food dressing and flavor enhancer. Made with a natural Bacon flavoring that dogs love. Great for the picky eater! All natural ingredients, no water added. No artificial preservatives, no colorants, no thickeners and no synthetic ingredients of any kind. Only 13.3 calories per serving. Safe for diabetic dog food application. Does not contain protein, sodium or potassium. Contains Soybean Oil, Virgin Olive Oil, Canola Oil, Flax Seed Oil, Chia Seed Oil.',9.99,100,'products_images/bacon_flavour_spray.png',21,'2025-04-21 12:38:24.805084','2025-05-01 12:19:47.356405','Flavour','Carnivores',6),(2,'Frozen Quails','protein,healthy','Our proudly locally-produced quails by Uncle William ! Quail is an excellent choice for pets with allergies or food intolerances. Easy to chew through. Feathered Quail are around 120g-140g.',9.99,100,'products_images/frozen_quails.png',13,'2025-04-21 12:38:24.811504','2025-05-01 12:19:49.737138','Prey','Carnivores',4),(3,'Blood Sausage (Dogs)','protein,healthy','Natural Ingredients: Made with chicken, pork blood, and beef meal for a nutritious treat. High-Protein: Supports muscle health and activity levels.',9.99,100,'products_images/blood_sausage.png',10,'2025-04-21 12:38:24.814611','2025-04-29 12:31:46.261826','Artisinal','Dogs',6),(4,'Camel Hide Chews','protein,healthy,offals,hides','Camel Hide Chews are 100% natural, hypoallergenic, gluten-free and tough \'n\' tasty! Simply dried, with no additives and no bleaching or chemicals used, it makes them a great alternative to rawhide. Tough chewing helps clean teeth, and they are also great for dogs that suffer from food allergies and intolerances.',9.99,100,'products_images/camel_hide_chews.png',0,'2025-04-21 12:38:24.817033','2025-04-21 12:38:24.817044','Offals','Carnivores',4),(5,'Dried Herrings','protein,healthy,seafood','Dried Herring is a great source of omega-3 fatty acids, protein, and vitamin D, which are good for the heart, skin, coat, muscles, bones, and teeth. It also helps with arthritis and the immune system.',9.99,100,'products_images/dried_herrings.png',0,'2025-04-21 12:38:24.819409','2025-04-21 12:38:24.819420','Seafood','Carnivores',3),(6,'Dried Crocodile Feet','protein,healthy','Crocodile is a novel, high in protein treat great for dental health. Its a hypoallergenic meat so fantastic for dogs with allergies or going through elimination diets. The scales of this treat give some toughness to it making it perfect to clean those teeth. The nails are a great source of calcium & fibre.',9.99,100,'products_images/dried_crocodile_feet.png',9,'2025-04-21 12:38:24.821890','2025-04-29 12:37:38.898702','Bone','Carnivores',4),(7,'Catnip Biscuit','vegan,catnip,cats','These biscuits are infused with premium catnip to entice even the pickiest eaters. Watch your cat\'s eyes light up with joy! Our biscuits have the perfect crunch that cats adore. They\'re not too hard, not too soft - just right for a satisfying bite. We care about your cat\'s well-being. Our biscuits are made with high-quality, natural ingredients, and contain no artificial additives or preservatives.',9.99,100,'products_images/catnip_biscuit.png',5,'2025-04-21 12:38:24.824501','2025-04-22 01:11:59.188677','Vegan','Cats',6),(8,'King Caviar','protein,healthy','Provides a delectable boost of nutrients in your cat\'s diet as it\'s rich in Omega-3 and Vitamin D. Can be used also as a delicious topper for fussy taste buds.',9.99,100,'products_images/caviar.png',0,'2025-04-21 12:38:24.827081','2025-04-21 12:38:24.827095','Seafood','Cats',3),(9,'Cheese Flavour Spray','protein,healthy,dairy,fats,flavour','Cheese flavor spray for pets, particularly dogs, is a popular food topper that adds a palatable cheese flavor to dry kibble or other pet food. It\'s often marketed as a nutritious treat, with some products claiming to include ingredients like Omega-3 oils to benefit skin and coat health. These sprays are designed to be a convenient way to make meals more appealing, especially for picky eaters. ',9.99,100,'products_images/cheese_flavour_spray.png',0,'2025-04-21 12:38:24.829491','2025-04-21 12:38:24.829504','Flavour','Carnivores',6),(10,'Dogs Cheese Sticks','protein,healthy,dairy,fats','Bow Wow Cheese Stick is a soft and nutritious treat for your dog. It is rich in calcium and protein to help support absorption and digestion.',9.99,100,'products_images/cheese_sticks.png',0,'2025-04-21 12:38:24.831956','2025-04-21 12:38:24.831971','Dairy','Dogs',2),(11,'Dried Qual Eggs','eggs,fats,treats','Our freeze-dried egg yolk is rich in lecithin, which supports a healthy and shiny coat. It\'s also a great source of protein, vitamins, and minerals.',9.99,100,'products_images/dried_quail_eggs.png',2,'2025-04-21 14:21:34.130602','2025-04-25 01:24:41.368891','Fats','Carnivores',4),(12,'Carp-Trout Fromula','cat,salmon,formula','The \"Carp-Trout Formula\" typically refers to a pet food recipe that utilizes both carp and trout as primary ingredients. This formula is often grain-free and potato-free, and it\'s designed to provide a natural, balanced diet for pets, especially dogs. The combination of carp and trout is a source of essential omega-3 fatty acids, particularly DHA and EPA, which are beneficial for skin and coat health. ',12.99,100,'products_images/carp_trout_formula.png',0,'2025-04-21 14:21:34.177628','2025-04-21 14:21:34.177646','Seafood','Cat',5),(13,'Dried Crocodile Tail','protein,healthy,bone,offals','A hypoallergenic novel protein, crocodile is a superfood that\'s high in protein, low in fat and low in cholesterol--great for senior or overweight furkids.',12.99,100,'products_images/dried_crocodile_tail.png',0,'2025-04-21 14:21:34.177628','2025-04-21 14:21:34.177646','Bone','Carnivores',4),(14,'Alfalfa Hay','protien,healthy,hays,legume','Grown in USDA Certified Organic fields on local family farms in the Pacific Northwest, this product is safe for you and your pets. USDA organic means no GMOs, antibiotics, herbicides, or toxic chemicals are used. Our 100% Organic Alfalfa is a legume hay that is high in protein and healthy fats. This makes organic alfalfa a great nutritional choice for animals that are growing, pregnant, nursing, or enjoying their later years. This sweet-smelling hay will bring you and your beloved pets closer together at every meal.',12.99,100,'products_images/alfalfa_hay.png',0,'2025-04-21 14:21:34.177628','2025-04-21 14:21:34.177646','Forage','Herbivores',7),(15,'Hedgehog Formula','hedgehog,formula','Beaphar Hedgehog Food is a complete feed for hedgehogs. It contains real insects (dried larvae of the black soldier fly) and ingredients for a balanced combination of important nutrients. Feeding recommendations: Give daily as much food that it will be consumed within 24 hours. Any remaining food must be removed the next morning. Never give milk to hedgehogs, but provide clean, fresh water daily.',12.99,100,'products_images/hedgehog_food.png',0,'2025-04-21 14:21:34.177628','2025-04-21 14:21:34.177646','Formula','Omnivores',5),(16,'BSF Larvae','insect,protein,fats','Proudly produced in Singapore by Insectta, the live larvae of the black soldier fly (Hermetia illucens), are a naturally nutritious, protein-packed, calcium-rich treat for your pet. Please feed at less than 35% of the dog meal as it is high in fats.',12.99,100,'products_images/bsf_larvae.png',0,'2025-04-21 14:21:34.177628','2025-04-26 03:30:33.255660','Insect','Omnivores',1),(17,'Dried Apple Slices ','apples,fruits,dried','Apple chips provide a tasty and nutritious snack for small pets. They are rich in essential vitamins and minerals, including potassium, calcium, and iron, contributing to your pet’s overall well-being. High in pectin, a beneficial fibre, apple chips can also help lower cholesterol levels.',12.99,100,'products_images/apple_slices.png',0,'2025-04-21 14:21:34.177628','2025-04-21 14:21:34.177646','Fruits','Omnivores',7),(18,'Frozen Adult Mice','frozen,prey,protein,bone,offal','The mice are farm bred in ethical conditions, humanely slaughtered and frozen immediately to preserve quality and nutrition. Frozen Mice Large Pinkies are a good staple for carnivorous reptiles and birds as well as ferrets, meerkets, cats and fennec fox, providing great nutrition and part of a natural diet.',12.99,100,'products_images/frozen_mice.png',5,'2025-04-21 14:21:34.177628','2025-04-22 05:40:07.192609','Prey','Carnivores',4),(19,'Dried Kiwi Slices','kiwi,furits,dired',' Dried kiwi retains many of the nutrients of fresh kiwi, including vitamins and minerals. Dried kiwi can be a healthy and convenient treat, but it shouldn\'t make up a large portion of their diet.  It can be offered in moderation to dogs, rabbits and other omnivores and herbivores',12.99,100,'products_images/dried_kiwi.png',0,'2025-04-21 14:21:34.177628','2025-04-21 14:21:34.177646','Fruits','Omnivores',7),(20,'Dried Strawberry','strawberry,furits,dired','Momi Freeze Dried Strawberry Treats select fresh fruit as the raw material, and process with no added sugar, colour and preservatives. 100% natural dried strawberry treats are rich in Vitamin C which is good for your pets.',12.99,100,'products_images/dried_strawberry.png',0,'2025-04-21 14:21:34.177628','2025-04-21 14:21:34.177646','Fruits','Omnivores',7),(21,'Dog Ice Cream','dairy,dogs','A rich peanut butter flavour balanced with sweet 100% real bananas, it\'s truly a treat that will make our furry friend come dashing. This is strictly for dogs and please do not feed it to other species.',12.99,100,'products_images/dogs_ice_cream.png',3,'2025-04-21 14:21:34.177628','2025-04-22 08:02:43.597336','Dairy','Dogs',2),(22,'Timothy Hay','herbivores,forage,hay,guinea pigs,rabbits','It is rich in indigestible fibre to help stimulate gut motility. It helps encourage your rabbit or guinea pig to forage through the stems and leaves and have a good chew or even play. The abrasive texture helps support correct dental attrition.',12.99,100,'products_images/timothy_hay.png',2,'2025-04-21 14:21:34.177628','2025-04-25 01:24:37.577808','Forage','Herbivores',7),(23,'Dried Chicken Feet','bone,protein,poultry','The Dog Grocer Chicken Feet is freeze-dried into fully digestible crunchy bone chews that help clean plaque and tartar off teeth. Cats, Ferrets, Dogs and Fennec Fox will love it !',12.99,100,'products_images/dried_chicken_feet.png',0,'2025-04-21 14:21:34.177628','2025-04-21 14:21:34.177646','Bone','Carnivores',4),(24,'Beef Patty','artisinal,beef,protein','The Butcher\'s Dog\'s beef patties are homemade with beef chuck and infused with a hint of spice. Patties are flavourful and succulent with no artificial flavours.',12.99,100,'products_images/beef_patty.png',0,'2025-04-21 14:21:34.177628','2025-04-21 14:21:34.177646','Artisinal','Carnivores',6),(25,'Cricket','insect,protein,fats','Dried crickets offer a convenient and nutrient-rich option for pets, especially those with allergies, as they are a good source of protein and other essential nutrients. They can be a healthy and tasty treat or topper for daily meals. ',12.99,100,'products_images/dried_cricket.png',0,'2025-04-21 14:21:34.177628','2025-04-21 14:21:34.177646','Insect','Omnivores',1),(26,'Silkworm Pupae','insect,protein,fats','They are particularly rich in amino acids, crucial for muscle development and maintenance, making them an ideal option for promoting lean muscle mass in pets.',14.99,100,'products_images/silkworm_pupae.png',0,'2025-04-21 14:21:34.177628','2025-04-21 14:21:34.177646','Insect','Omnivores',1),(27,'Poultry Fats','fats,poultry','Chicken fat is ideal for supplementing our chicken muscle meat with the necessary amount of fat. It is also perfect for puppies, pregnant or nursing females, as well as for working and sporting dogs. The fat content in muscle meat should ideally range between 15 and 25% for dogs, depending on factors such as age, activity level, weight, and hormone status.',14.99,100,'products_images/chicken_fat.png',0,'2025-04-21 14:21:34.177628','2025-04-21 14:21:34.177646','Fats','Carnivores',4),(28,'Dried Kangaroo Meat','kangaroo,dried,protein','Looking for a unique and healthy protein option for your pet? Kangaroo meat is as natural as it gets, because it is harvested free-range, sustainably, from the wild. This means no added hormones and no antibiotics. It is flavourful, very lean and low in cholesterol, and low in fat, especially saturated fats. It also contains the omega-6 conjugated linoleic acid (CLA), and is rich in the vitamin Bs including niacin, riboflavin, thiamine and taurine, as well as zinc and iron.',14.99,100,'products_images/dried_kangaroo_meat.png',0,'2025-04-21 14:21:34.177628','2025-04-21 14:21:34.177646','Dried','Carnivores',4),(29,'Beef Jerky','beef, dried, jerky','The perfect dog treat that your dog will enjoy! Made from any type of beef, this canine-friendly treat is a delicious and protein-packed snack that dogs love. Perfect for training, rewarding good behavior, or just showing your dog some love. This beef jerky health in mind, free from artificial preservatives and colors. With its savory aroma and chewy texture, this treat is sure to become your dog\'s favorite go-to snack. Treat your loyal companion to the savory goodness of our Beef Jerky – because every tail deserves a tasty treat!',9.99,50,'products_images/beef_jerky.png',0,'2025-04-24 05:00:30.672723','2025-04-24 05:00:30.672751','Dried','Carnivores',4);
/*!40000 ALTER TABLE `my_apps_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_apps_userprofile`
--

DROP TABLE IF EXISTS `my_apps_userprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `my_apps_userprofile` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `phone` varchar(15) DEFAULT NULL,
  `address` longtext,
  `bio` longtext,
  `is_admin` tinyint(1) NOT NULL,
  `user_id` int NOT NULL,
  `email` varchar(254) DEFAULT NULL,
  `role` varchar(10) NOT NULL,
  `profile_image` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `my_apps_userprofile_user_id_dfe04c55_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_apps_userprofile`
--

LOCK TABLES `my_apps_userprofile` WRITE;
/*!40000 ALTER TABLE `my_apps_userprofile` DISABLE KEYS */;
INSERT INTO `my_apps_userprofile` VALUES (1,'1234567890','123 Ocean St, Miami, FL','Seafood lover',0,1,NULL,'customer',NULL),(2,'2345678901','456 Bay Rd, Tampa, FL','Loves cooking fish',0,2,NULL,'customer',NULL),(3,'3456789012','789 River Ave, Seattle, WA','Shrimp enthusiast',0,3,NULL,'customer',NULL),(4,'4567890123','321 Lake Dr, Chicago, IL','Avid griller',0,4,NULL,'customer',NULL),(5,'5678901234','654 Harbor Ln, San Diego, CA','Fresh catch fan',0,5,NULL,'customer',NULL),(6,'6789012345','987 Pier Blvd, Boston, MA','Ocean bounty chef',0,6,NULL,'customer',NULL),(7,'7890123456','159 Reef Ct, New York, NY','Barramundi lover',0,7,NULL,'customer',NULL),(8,'8901234567','753 Dock St, Houston, TX','Seafood connoisseur',0,8,NULL,'customer',NULL),(9,'9012345678','951 Marina Pl, New Orleans, LA','Crab boil king',0,9,NULL,'customer',NULL),(10,'1123456789','258 Jetty Way, Portland, OR','Fish taco master',0,10,NULL,'customer',NULL),(11,'92702017','350A Canberra Road','CEO of PawFect Pantry',1,11,NULL,'admin',NULL),(12,'97800496','77 Ayer Rajah Crescent, #02-21/26','Insect larvae breeders for the pet trade',0,12,NULL,'vendor',NULL),(13,'97800498','4 Defu South Street 1 #03-15','PetCubes is a Singapore-based brand specializing in fresh, human-grade pet food for dogs and cats. They use whole, fresh ingredients and offer both raw and gently cooked options, with a focus on nutritional balance and ease of feeding. Their products are designed to be convenient, requiring only thawing and serving. ',0,13,NULL,'vendor',NULL),(14,'98800498','43 Blackmer Street','​​With over 65 years of experience in the seafood business, we know a few things about fresh fish — most importantly, that fish is a nutritional powerhouse. Just like us, dogs and cats depend on a natural diet rich in wholesome nutrition to live a full, healthy life.',0,14,NULL,'vendor',NULL),(15,'98800499','Novena Square, B1-130','At PaleoPet Provisions, we believe pets thrive on the same wild, nutrient-dense meats that fueled their ancestors. Sourced from pristine Australian outbacks and sustainable farms, our premium proteins—kangaroo, camel, goat, quail, buffalo, and crocodile—deliver the evolutionary diet today’s dogs and cats instinctively crave.',0,15,NULL,'vendor',NULL),(16,'98800500','287 Novena East Avenue','Hill\'s Pet Nutrition, Inc., trading as Hill\'s, is an American pet food company that produces dog and cat foods. It is a subsidiary of Colgate-Palmolive.',0,16,NULL,'vendor',NULL),(17,'98800501','30432 Esperanza. Rancho Santa Margarita, California 92688','Grandma Lucy\'s is a brand of freeze-dried pet food and treats, not a specific location or person. They are headquartered in California, USA, in a family-owned plant. Their manufacturing and shipping operations are also located there. ',0,17,NULL,'vendor',NULL),(18,'98800502','210072, Twp Rd 90b, Lethbridge, AB T1J 5P1, Canada','Green Prairie International (GPI) is a respected global wholesale supplier of quality forage products. Located just east of Lethbridge, Alberta, the company has become one of Canada’s premier processors and suppliers of long-fiber timothy and alfalfa hay to valued international markets.',0,18,NULL,'vendor',NULL),(19,'','',NULL,0,19,NULL,'customer',''),(20,'','',NULL,0,20,NULL,'customer','');
/*!40000 ALTER TABLE `my_apps_userprofile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_apps_vendor`
--

DROP TABLE IF EXISTS `my_apps_vendor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `my_apps_vendor` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `business_name` varchar(20) DEFAULT NULL,
  `description` longtext,
  `user_id` int NOT NULL,
  `brand_image` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `my_apps_vendor_user_id_1ab0c946_uniq` (`user_id`),
  CONSTRAINT `my_apps_vendor_user_id_1ab0c946_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_apps_vendor`
--

LOCK TABLES `my_apps_vendor` WRITE;
/*!40000 ALTER TABLE `my_apps_vendor` DISABLE KEYS */;
INSERT INTO `my_apps_vendor` VALUES (1,'Insectta Co','Insectta is Singapore\'s first ento-powered biotech company. Our patented extraction technology produces high-value biomaterials for the pharmaceutical, organic electronics, personal wellness industries, and more. We also produce insect-based pet feed for avians, felines, canine and aquarium.',12,NULL),(2,'PetCube Co','PetCubes is a Singapore-based brand specializing in fresh, human-grade pet food for dogs and cats. They use whole, fresh ingredients and offer both raw and gently cooked options, with a focus on nutritional balance and ease of feeding. Their products are designed to be convenient, requiring only thawing and serving. ',13,NULL),(3,'North Coast Co','With over 65 years of experience in the seafood business, we know a few things about fresh fish — most importantly, that fish is a nutritional powerhouse. Just like us, dogs and cats depend on a natural diet rich in wholesome nutrition to live a full, healthy life.',14,NULL),(4,'PaleoFood Co','At PaleoPet Provisions, we believe pets thrive on the same wild, nutrient-dense meats that fueled their ancestors. Sourced from pristine Australian outbacks and sustainable farms, our premium proteins—kangaroo, camel, goat, quail, buffalo, and crocodile—deliver the evolutionary diet today’s dogs and cats instinctively crave.',15,NULL),(5,'Hill\'s Pet Nutrition','Hill\'s Pet Nutrition, Inc., trading as Hill\'s, is an American pet food company that produces dog and cat foods. It is a subsidiary of Colgate-Palmolive.',16,NULL),(6,'Grandma Lucy\'s','Grandma Lucy\'s is a brand of freeze-dried pet food and treats, not a specific location or person. They are headquartered in California, USA, in a family-owned plant. Their manufacturing and shipping operations are also located there. ',17,NULL),(7,'Green Prairie','Green Prairie International (GPI) is a respected global wholesale supplier of quality forage products. Located just east of Lethbridge, Alberta, the company has become one of Canada’s premier processors and suppliers of long-fiber timothy and alfalfa hay to valued international markets.',18,NULL);
/*!40000 ALTER TABLE `my_apps_vendor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socialaccount_socialaccount`
--

DROP TABLE IF EXISTS `socialaccount_socialaccount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `socialaccount_socialaccount` (
  `id` int NOT NULL AUTO_INCREMENT,
  `provider` varchar(200) NOT NULL,
  `uid` varchar(191) NOT NULL,
  `last_login` datetime(6) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `extra_data` json NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `socialaccount_socialaccount_provider_uid_fc810c6e_uniq` (`provider`,`uid`),
  KEY `socialaccount_socialaccount_user_id_8146e70c_fk_auth_user_id` (`user_id`),
  CONSTRAINT `socialaccount_socialaccount_user_id_8146e70c_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialaccount_socialaccount`
--

LOCK TABLES `socialaccount_socialaccount` WRITE;
/*!40000 ALTER TABLE `socialaccount_socialaccount` DISABLE KEYS */;
/*!40000 ALTER TABLE `socialaccount_socialaccount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socialaccount_socialapp`
--

DROP TABLE IF EXISTS `socialaccount_socialapp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `socialaccount_socialapp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `provider` varchar(30) NOT NULL,
  `name` varchar(40) NOT NULL,
  `client_id` varchar(191) NOT NULL,
  `secret` varchar(191) NOT NULL,
  `key` varchar(191) NOT NULL,
  `provider_id` varchar(200) NOT NULL,
  `settings` json NOT NULL DEFAULT (_utf8mb3'{}'),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialaccount_socialapp`
--

LOCK TABLES `socialaccount_socialapp` WRITE;
/*!40000 ALTER TABLE `socialaccount_socialapp` DISABLE KEYS */;
/*!40000 ALTER TABLE `socialaccount_socialapp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socialaccount_socialapp_sites`
--

DROP TABLE IF EXISTS `socialaccount_socialapp_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `socialaccount_socialapp_sites` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `socialapp_id` int NOT NULL,
  `site_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `socialaccount_socialapp_sites_socialapp_id_site_id_71a9a768_uniq` (`socialapp_id`,`site_id`),
  KEY `socialaccount_socialapp_sites_site_id_2579dee5_fk_django_site_id` (`site_id`),
  CONSTRAINT `socialaccount_social_socialapp_id_97fb6e7d_fk_socialacc` FOREIGN KEY (`socialapp_id`) REFERENCES `socialaccount_socialapp` (`id`),
  CONSTRAINT `socialaccount_socialapp_sites_site_id_2579dee5_fk_django_site_id` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialaccount_socialapp_sites`
--

LOCK TABLES `socialaccount_socialapp_sites` WRITE;
/*!40000 ALTER TABLE `socialaccount_socialapp_sites` DISABLE KEYS */;
/*!40000 ALTER TABLE `socialaccount_socialapp_sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socialaccount_socialtoken`
--

DROP TABLE IF EXISTS `socialaccount_socialtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `socialaccount_socialtoken` (
  `id` int NOT NULL AUTO_INCREMENT,
  `token` longtext NOT NULL,
  `token_secret` longtext NOT NULL,
  `expires_at` datetime(6) DEFAULT NULL,
  `account_id` int NOT NULL,
  `app_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `socialaccount_socialtoken_app_id_account_id_fca4e0ac_uniq` (`app_id`,`account_id`),
  KEY `socialaccount_social_account_id_951f210e_fk_socialacc` (`account_id`),
  CONSTRAINT `socialaccount_social_account_id_951f210e_fk_socialacc` FOREIGN KEY (`account_id`) REFERENCES `socialaccount_socialaccount` (`id`),
  CONSTRAINT `socialaccount_social_app_id_636a42d7_fk_socialacc` FOREIGN KEY (`app_id`) REFERENCES `socialaccount_socialapp` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialaccount_socialtoken`
--

LOCK TABLES `socialaccount_socialtoken` WRITE;
/*!40000 ALTER TABLE `socialaccount_socialtoken` DISABLE KEYS */;
/*!40000 ALTER TABLE `socialaccount_socialtoken` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-05  9:21:55
