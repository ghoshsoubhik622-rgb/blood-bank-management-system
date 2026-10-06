-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: blood_bank_management_system
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Table structure for table `blood_groups`
--

DROP TABLE IF EXISTS `blood_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blood_groups` (
  `blood_group_id` int NOT NULL AUTO_INCREMENT,
  `blood_group` varchar(3) NOT NULL,
  PRIMARY KEY (`blood_group_id`),
  UNIQUE KEY `blood_group` (`blood_group`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blood_groups`
--

LOCK TABLES `blood_groups` WRITE;
/*!40000 ALTER TABLE `blood_groups` DISABLE KEYS */;
INSERT INTO `blood_groups` VALUES (2,'A-'),(1,'A+'),(6,'AB-'),(5,'AB+'),(4,'B-'),(3,'B+'),(8,'O-'),(7,'O+');
/*!40000 ALTER TABLE `blood_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blood_inventory`
--

DROP TABLE IF EXISTS `blood_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blood_inventory` (
  `inventory_id` int NOT NULL AUTO_INCREMENT,
  `inventory_code` varchar(10) NOT NULL,
  `donation_id` int NOT NULL,
  `blood_group_id` int NOT NULL,
  `quantity_available_ml` int NOT NULL DEFAULT '150',
  `storage_date` date NOT NULL,
  `expiry_date` date NOT NULL,
  `status` enum('Available','Issued','Expired') NOT NULL DEFAULT 'Available',
  PRIMARY KEY (`inventory_id`),
  UNIQUE KEY `inventory_code` (`inventory_code`),
  UNIQUE KEY `donation_id` (`donation_id`),
  KEY `blood_group_id` (`blood_group_id`),
  CONSTRAINT `blood_inventory_ibfk_1` FOREIGN KEY (`donation_id`) REFERENCES `donations` (`donation_id`),
  CONSTRAINT `blood_inventory_ibfk_2` FOREIGN KEY (`blood_group_id`) REFERENCES `blood_groups` (`blood_group_id`),
  CONSTRAINT `blood_inventory_chk_1` CHECK (((`quantity_available_ml` >= 0) and (`quantity_available_ml` <= 150)))
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blood_inventory`
--

LOCK TABLES `blood_inventory` WRITE;
/*!40000 ALTER TABLE `blood_inventory` DISABLE KEYS */;
INSERT INTO `blood_inventory` VALUES (1,'INV001',1,1,0,'2026-09-15','2026-10-13','Issued'),(2,'INV002',2,7,0,'2026-09-15','2026-10-13','Issued'),(3,'INV003',3,3,0,'2026-09-16','2026-10-14','Issued'),(4,'INV004',4,1,150,'2026-09-16','2026-10-14','Available'),(5,'INV005',5,8,0,'2026-09-17','2026-10-15','Issued'),(6,'INV006',6,2,0,'2026-09-17','2026-10-15','Issued'),(7,'INV007',7,4,150,'2026-09-18','2026-10-16','Available'),(8,'INV008',8,5,150,'2026-09-18','2026-10-16','Available'),(9,'INV009',9,7,150,'2026-09-19','2026-10-17','Available'),(10,'INV010',10,3,150,'2026-09-19','2026-10-17','Available'),(11,'INV011',11,1,150,'2026-09-20','2026-10-18','Available'),(12,'INV012',12,6,150,'2026-09-20','2026-10-18','Available'),(13,'INV013',13,2,150,'2026-09-21','2026-10-19','Available'),(14,'INV014',14,8,150,'2026-09-21','2026-10-19','Available'),(15,'INV015',15,5,150,'2026-09-22','2026-10-20','Available'),(16,'INV016',16,7,150,'2026-09-22','2026-10-20','Available');
/*!40000 ALTER TABLE `blood_inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `blood_issue_details`
--

DROP TABLE IF EXISTS `blood_issue_details`;
/*!50001 DROP VIEW IF EXISTS `blood_issue_details`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `blood_issue_details` AS SELECT 
 1 AS `issue_id`,
 1 AS `issue_code`,
 1 AS `patient_code`,
 1 AS `patient_name`,
 1 AS `hospital_code`,
 1 AS `hospital_name`,
 1 AS `blood_group`,
 1 AS `issue_date`,
 1 AS `quantity_issued_ml`,
 1 AS `patient_use_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `blood_issues`
--

DROP TABLE IF EXISTS `blood_issues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blood_issues` (
  `issue_id` int NOT NULL AUTO_INCREMENT,
  `issue_code` varchar(10) NOT NULL,
  `request_id` int NOT NULL,
  `patient_id` int NOT NULL,
  `hospital_id` int NOT NULL,
  `blood_group_id` int NOT NULL,
  `inventory_id` int NOT NULL,
  `issue_date` date NOT NULL,
  `quantity_issued_ml` int NOT NULL,
  `patient_use_date` date DEFAULT NULL,
  PRIMARY KEY (`issue_id`),
  UNIQUE KEY `issue_code` (`issue_code`),
  KEY `request_id` (`request_id`),
  KEY `patient_id` (`patient_id`),
  KEY `hospital_id` (`hospital_id`),
  KEY `blood_group_id` (`blood_group_id`),
  KEY `inventory_id` (`inventory_id`),
  CONSTRAINT `blood_issues_ibfk_1` FOREIGN KEY (`request_id`) REFERENCES `blood_requests` (`request_id`),
  CONSTRAINT `blood_issues_ibfk_2` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`),
  CONSTRAINT `blood_issues_ibfk_3` FOREIGN KEY (`hospital_id`) REFERENCES `hospitals` (`hospital_id`),
  CONSTRAINT `blood_issues_ibfk_4` FOREIGN KEY (`blood_group_id`) REFERENCES `blood_groups` (`blood_group_id`),
  CONSTRAINT `blood_issues_ibfk_5` FOREIGN KEY (`inventory_id`) REFERENCES `blood_inventory` (`inventory_id`),
  CONSTRAINT `blood_issues_chk_1` CHECK (((`quantity_issued_ml` > 0) and (`quantity_issued_ml` <= 150))),
  CONSTRAINT `blood_issues_chk_2` CHECK (((`patient_use_date` is null) or (`patient_use_date` >= `issue_date`)))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blood_issues`
--

LOCK TABLES `blood_issues` WRITE;
/*!40000 ALTER TABLE `blood_issues` DISABLE KEYS */;
INSERT INTO `blood_issues` VALUES (1,'ISS001',1,1,1,7,2,'2026-09-20',150,'2026-09-20'),(2,'ISS002',2,2,2,1,1,'2026-09-20',150,'2026-09-20'),(3,'ISS003',3,3,3,3,3,'2026-09-21',150,'2026-09-21'),(4,'ISS004',4,4,4,8,5,'2026-09-21',150,'2026-09-21'),(5,'ISS005',5,5,5,2,6,'2026-09-22',150,'2026-09-22');
/*!40000 ALTER TABLE `blood_issues` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_blood_issue_insert` AFTER INSERT ON `blood_issues` FOR EACH ROW BEGIN

    UPDATE blood_inventory
    SET
        quantity_available_ml = quantity_available_ml - NEW.quantity_issued_ml,
        status =
            CASE
                WHEN quantity_available_ml - NEW.quantity_issued_ml = 0
                THEN 'Issued'
                ELSE 'Available'
            END
    WHERE inventory_id = NEW.inventory_id;

    UPDATE blood_requests
    SET request_status = 'Completed'
    WHERE request_id = NEW.request_id;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `blood_requests`
--

DROP TABLE IF EXISTS `blood_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blood_requests` (
  `request_id` int NOT NULL AUTO_INCREMENT,
  `request_code` varchar(10) NOT NULL,
  `patient_id` int NOT NULL,
  `hospital_id` int NOT NULL,
  `blood_group_id` int NOT NULL,
  `request_date` date NOT NULL,
  `quantity_required_ml` int NOT NULL,
  `request_status` enum('Pending','Approved','Rejected','Completed') NOT NULL DEFAULT 'Pending',
  PRIMARY KEY (`request_id`),
  UNIQUE KEY `request_code` (`request_code`),
  KEY `patient_id` (`patient_id`),
  KEY `hospital_id` (`hospital_id`),
  KEY `blood_group_id` (`blood_group_id`),
  CONSTRAINT `blood_requests_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`),
  CONSTRAINT `blood_requests_ibfk_2` FOREIGN KEY (`hospital_id`) REFERENCES `hospitals` (`hospital_id`),
  CONSTRAINT `blood_requests_ibfk_3` FOREIGN KEY (`blood_group_id`) REFERENCES `blood_groups` (`blood_group_id`),
  CONSTRAINT `blood_requests_chk_1` CHECK (((`quantity_required_ml` > 0) and (`quantity_required_ml` <= 150)))
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blood_requests`
--

LOCK TABLES `blood_requests` WRITE;
/*!40000 ALTER TABLE `blood_requests` DISABLE KEYS */;
INSERT INTO `blood_requests` VALUES (1,'REQ001',1,1,7,'2026-09-20',150,'Approved'),(2,'REQ002',2,2,1,'2026-09-20',150,'Approved'),(3,'REQ003',3,3,3,'2026-09-21',150,'Approved'),(4,'REQ004',4,4,8,'2026-09-21',150,'Approved'),(5,'REQ005',5,5,2,'2026-09-22',150,'Approved'),(6,'REQ006',6,1,5,'2026-09-23',150,'Pending'),(7,'REQ007',7,2,4,'2026-09-23',150,'Pending'),(8,'REQ008',8,3,6,'2026-09-24',150,'Pending');
/*!40000 ALTER TABLE `blood_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `donation_details`
--

DROP TABLE IF EXISTS `donation_details`;
/*!50001 DROP VIEW IF EXISTS `donation_details`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `donation_details` AS SELECT 
 1 AS `donation_id`,
 1 AS `donation_code`,
 1 AS `donor_code`,
 1 AS `donor_name`,
 1 AS `blood_group`,
 1 AS `donation_date`,
 1 AS `quantity_ml`,
 1 AS `screening_status`,
 1 AS `expiry_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `donations`
--

DROP TABLE IF EXISTS `donations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `donations` (
  `donation_id` int NOT NULL AUTO_INCREMENT,
  `donation_code` varchar(10) NOT NULL,
  `donor_id` int NOT NULL,
  `blood_group_id` int NOT NULL,
  `donation_date` date NOT NULL,
  `quantity_ml` int NOT NULL DEFAULT '150',
  `screening_status` enum('Approved','Rejected','Pending') NOT NULL DEFAULT 'Pending',
  `expiry_date` date DEFAULT NULL,
  PRIMARY KEY (`donation_id`),
  UNIQUE KEY `donation_code` (`donation_code`),
  KEY `donor_id` (`donor_id`),
  KEY `blood_group_id` (`blood_group_id`),
  CONSTRAINT `donations_ibfk_1` FOREIGN KEY (`donor_id`) REFERENCES `donors` (`donor_id`),
  CONSTRAINT `donations_ibfk_2` FOREIGN KEY (`blood_group_id`) REFERENCES `blood_groups` (`blood_group_id`),
  CONSTRAINT `donations_chk_1` CHECK ((`quantity_ml` = 150))
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donations`
--

LOCK TABLES `donations` WRITE;
/*!40000 ALTER TABLE `donations` DISABLE KEYS */;
INSERT INTO `donations` VALUES (1,'DN001',1,1,'2026-09-15',150,'Approved','2026-10-13'),(2,'DN002',2,7,'2026-09-15',150,'Approved','2026-10-13'),(3,'DN003',3,3,'2026-09-16',150,'Approved','2026-10-14'),(4,'DN004',4,1,'2026-09-16',150,'Approved','2026-10-14'),(5,'DN005',5,8,'2026-09-17',150,'Approved','2026-10-15'),(6,'DN006',6,2,'2026-09-17',150,'Approved','2026-10-15'),(7,'DN007',7,4,'2026-09-18',150,'Approved','2026-10-16'),(8,'DN008',8,5,'2026-09-18',150,'Approved','2026-10-16'),(9,'DN009',9,7,'2026-09-19',150,'Approved','2026-10-17'),(10,'DN010',10,3,'2026-09-19',150,'Approved','2026-10-17'),(11,'DN011',11,1,'2026-09-20',150,'Approved','2026-10-18'),(12,'DN012',12,6,'2026-09-20',150,'Approved','2026-10-18'),(13,'DN013',13,2,'2026-09-21',150,'Approved','2026-10-19'),(14,'DN014',14,8,'2026-09-21',150,'Approved','2026-10-19'),(15,'DN015',15,5,'2026-09-22',150,'Approved','2026-10-20'),(16,'DN016',16,7,'2026-09-22',150,'Approved','2026-10-20');
/*!40000 ALTER TABLE `donations` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_donation_insert` BEFORE INSERT ON `donations` FOR EACH ROW BEGIN
    IF NEW.quantity_ml <> 150 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Every blood donation must be exactly 150 mL.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `donor_details`
--

DROP TABLE IF EXISTS `donor_details`;
/*!50001 DROP VIEW IF EXISTS `donor_details`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `donor_details` AS SELECT 
 1 AS `donor_id`,
 1 AS `donor_code`,
 1 AS `donor_name`,
 1 AS `age`,
 1 AS `gender`,
 1 AS `blood_group`,
 1 AS `phone`,
 1 AS `email`,
 1 AS `address`,
 1 AS `city`,
 1 AS `registration_date`,
 1 AS `eligibility_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `donors`
--

DROP TABLE IF EXISTS `donors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `donors` (
  `donor_id` int NOT NULL AUTO_INCREMENT,
  `donor_code` varchar(10) NOT NULL,
  `donor_name` varchar(100) NOT NULL,
  `age` int NOT NULL,
  `gender` enum('Male','Female','Other') NOT NULL,
  `blood_group_id` int NOT NULL,
  `phone` varchar(15) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `registration_date` date NOT NULL,
  `eligibility_status` enum('Eligible','Not Eligible') DEFAULT 'Eligible',
  PRIMARY KEY (`donor_id`),
  UNIQUE KEY `donor_code` (`donor_code`),
  UNIQUE KEY `phone` (`phone`),
  UNIQUE KEY `email` (`email`),
  KEY `blood_group_id` (`blood_group_id`),
  CONSTRAINT `donors_ibfk_1` FOREIGN KEY (`blood_group_id`) REFERENCES `blood_groups` (`blood_group_id`),
  CONSTRAINT `donors_chk_1` CHECK (((`age` >= 18) and (`age` <= 65)))
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donors`
--

LOCK TABLES `donors` WRITE;
/*!40000 ALTER TABLE `donors` DISABLE KEYS */;
INSERT INTO `donors` VALUES (1,'D001','Aarav Sharma',24,'Male',1,'9000000001','aarav.sharma01@example.com','Kondapur','Hyderabad','2026-08-01','Eligible'),(2,'D002','Priya Singh',22,'Female',7,'9000000002','priya.singh02@example.com','Gachibowli','Hyderabad','2026-08-02','Eligible'),(3,'D003','Rahul Kumar',28,'Male',3,'9000000003','rahul.kumar03@example.com','Madhapur','Hyderabad','2026-08-03','Eligible'),(4,'D004','Ananya Reddy',25,'Female',1,'9000000004','ananya.reddy04@example.com','Kukatpally','Hyderabad','2026-08-04','Eligible'),(5,'D005','Vikram Patel',31,'Male',8,'9000000005','vikram.patel05@example.com','Begumpet','Hyderabad','2026-08-05','Eligible'),(6,'D006','Sneha Das',23,'Female',2,'9000000006','sneha.das06@example.com','Ameerpet','Hyderabad','2026-08-06','Eligible'),(7,'D007','Rohan Verma',27,'Male',4,'9000000007','rohan.verma07@example.com','Miyapur','Hyderabad','2026-08-07','Eligible'),(8,'D008','Ishita Mehta',26,'Female',5,'9000000008','ishita.mehta08@example.com','Manikonda','Hyderabad','2026-08-08','Eligible'),(9,'D009','Arjun Rao',29,'Male',7,'9000000009','arjun.rao09@example.com','Hitech City','Hyderabad','2026-08-09','Eligible'),(10,'D010','Kavya Nair',21,'Female',3,'9000000010','kavya.nair10@example.com','Nallagandla','Hyderabad','2026-08-10','Eligible'),(11,'D011','Aditya Joshi',30,'Male',1,'9000000011','aditya.joshi11@example.com','Banjara Hills','Hyderabad','2026-08-11','Eligible'),(12,'D012','Meera Iyer',24,'Female',6,'9000000012','meera.iyer12@example.com','Jubilee Hills','Hyderabad','2026-08-12','Eligible'),(13,'D013','Karan Malhotra',32,'Male',2,'9000000013','karan.malhotra13@example.com','Secunderabad','Hyderabad','2026-08-13','Eligible'),(14,'D014','Pooja Shah',23,'Female',8,'9000000014','pooja.shah14@example.com','Tarnaka','Hyderabad','2026-08-14','Eligible'),(15,'D015','Siddharth Roy',27,'Male',5,'9000000015','siddharth.roy15@example.com','Uppal','Hyderabad','2026-08-15','Eligible'),(16,'D016','Neha Gupta',29,'Female',7,'9000000016','neha.gupta16@example.com','Dilsukhnagar','Hyderabad','2026-08-16','Eligible'),(17,'D017','Manish Yadav',26,'Male',4,'9000000017','manish.yadav17@example.com','LB Nagar','Hyderabad','2026-08-17','Eligible'),(18,'D018','Riya Kapoor',22,'Female',1,'9000000018','riya.kapoor18@example.com','Kothaguda','Hyderabad','2026-08-18','Eligible'),(19,'D019','Nikhil Menon',33,'Male',3,'9000000019','nikhil.menon19@example.com','Kompally','Hyderabad','2026-08-19','Eligible'),(20,'D020','Simran Kaur',25,'Female',8,'9000000020','simran.kaur20@example.com','Alwal','Hyderabad','2026-08-20','Eligible'),(21,'D021','Varun Reddy',28,'Male',2,'9000000021','varun.reddy21@example.com','KPHB','Hyderabad','2026-08-21','Eligible'),(22,'D022','Aditi Banerjee',24,'Female',5,'9000000022','aditi.banerjee22@example.com','Malkajgiri','Hyderabad','2026-08-22','Eligible'),(23,'D023','Saurabh Jain',35,'Male',7,'9000000023','saurabh.jain23@example.com','Chandanagar','Hyderabad','2026-08-23','Eligible'),(24,'D024','Tanya Bose',21,'Female',6,'9000000024','tanya.bose24@example.com','Nizampet','Hyderabad','2026-08-24','Eligible'),(25,'D025','Akash Mishra',27,'Male',1,'9000000025','akash.mishra25@example.com','Masab Tank','Hyderabad','2026-08-25','Eligible'),(26,'D026','Divya Reddy',26,'Female',3,'9000000026','divya.reddy26@example.com','Tolichowki','Hyderabad','2026-08-26','Eligible'),(27,'D027','Harsh Agarwal',30,'Male',4,'9000000027','harsh.agarwal27@example.com','Kachiguda','Hyderabad','2026-08-27','Eligible'),(28,'D028','Nandini Rao',23,'Female',8,'9000000028','nandini.rao28@example.com','Himayatnagar','Hyderabad','2026-08-28','Eligible'),(29,'D029','Yash Thakur',29,'Male',5,'9000000029','yash.thakur29@example.com','Attapur','Hyderabad','2026-08-29','Eligible'),(30,'D030','Shreya Paul',24,'Female',7,'9000000030','shreya.paul30@example.com','Srinagar Colony','Hyderabad','2026-08-30','Eligible'),(31,'D031','Mohit Sinha',31,'Male',2,'9000000031','mohit.sinha31@example.com','Moosapet','Hyderabad','2026-08-31','Eligible'),(32,'D032','Pallavi Sen',25,'Female',1,'9000000032','pallavi.sen32@example.com','Bachupally','Hyderabad','2026-09-01','Eligible'),(33,'D033','Abhishek Das',27,'Male',3,'9000000033','abhishek.das33@example.com','Kondapur','Hyderabad','2026-09-02','Eligible'),(34,'D034','Swati Agarwal',28,'Female',6,'9000000034','swati.agarwal34@example.com','Madhapur','Hyderabad','2026-09-03','Eligible'),(35,'D035','Ritesh Kumar',34,'Male',8,'9000000035','ritesh.kumar35@example.com','Gachibowli','Hyderabad','2026-09-04','Eligible'),(36,'D036','Muskan Ali',22,'Female',5,'9000000036','muskan.ali36@example.com','Mehdipatnam','Hyderabad','2026-09-05','Eligible'),(37,'D037','Dev Patel',29,'Male',7,'9000000037','dev.patel37@example.com','Begumpet','Hyderabad','2026-09-06','Eligible'),(38,'D038','Ira Chatterjee',23,'Female',4,'9000000038','ira.chatterjee38@example.com','Ameerpet','Hyderabad','2026-09-07','Eligible'),(39,'D039','Aman Khan',32,'Male',1,'9000000039','aman.khan39@example.com','Tolichowki','Hyderabad','2026-09-08','Eligible'),(40,'D040','Mitali Ghosh',26,'Female',3,'9000000040','mitali.ghosh40@example.com','Kukatpally','Hyderabad','2026-09-09','Eligible'),(41,'D041','Rajat Singh',30,'Male',8,'9000000041','rajat.singh41@example.com','Miyapur','Hyderabad','2026-09-10','Eligible'),(42,'D042','Sakshi Jain',24,'Female',2,'9000000042','sakshi.jain42@example.com','Manikonda','Hyderabad','2026-09-11','Eligible'),(43,'D043','Deepak Rao',36,'Male',5,'9000000043','deepak.rao43@example.com','Secunderabad','Hyderabad','2026-09-12','Eligible'),(44,'D044','Komal Sharma',22,'Female',7,'9000000044','komal.sharma44@example.com','Tarnaka','Hyderabad','2026-09-13','Eligible'),(45,'D045','Ankit Verma',28,'Male',4,'9000000045','ankit.verma45@example.com','Uppal','Hyderabad','2026-09-14','Eligible'),(46,'D046','Ayesha Khan',25,'Female',6,'9000000046','ayesha.khan46@example.com','Dilsukhnagar','Hyderabad','2026-09-15','Eligible'),(47,'D047','Rohit Nair',33,'Male',1,'9000000047','rohit.nair47@example.com','LB Nagar','Hyderabad','2026-09-16','Eligible'),(48,'D048','Tanvi Mehta',27,'Female',3,'9000000048','tanvi.mehta48@example.com','Hitech City','Hyderabad','2026-09-17','Eligible'),(49,'D049','Gaurav Joshi',29,'Male',8,'9000000049','gaurav.joshi49@example.com','Nallagandla','Hyderabad','2026-09-18','Eligible'),(50,'D050','Priti Roy',24,'Female',5,'9000000050','priti.roy50@example.com','Jubilee Hills','Hyderabad','2026-09-19','Eligible');
/*!40000 ALTER TABLE `donors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hospitals`
--

DROP TABLE IF EXISTS `hospitals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hospitals` (
  `hospital_id` int NOT NULL AUTO_INCREMENT,
  `hospital_code` varchar(10) NOT NULL,
  `hospital_name` varchar(150) NOT NULL,
  `address` varchar(200) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`hospital_id`),
  UNIQUE KEY `hospital_code` (`hospital_code`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hospitals`
--

LOCK TABLES `hospitals` WRITE;
/*!40000 ALTER TABLE `hospitals` DISABLE KEYS */;
INSERT INTO `hospitals` VALUES (1,'H001','Apollo Hospitals','Jubilee Hills','Hyderabad','9010000001','apollo@example.com'),(2,'H002','Yashoda Hospitals','Somajiguda','Hyderabad','9010000002','yashoda@example.com'),(3,'H003','KIMS Hospitals','Secunderabad','Hyderabad','9010000003','kims@example.com'),(4,'H004','CARE Hospitals','Banjara Hills','Hyderabad','9010000004','care@example.com'),(5,'H005','Continental Hospitals','Gachibowli','Hyderabad','9010000005','continental@example.com');
/*!40000 ALTER TABLE `hospitals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `inventory_details`
--

DROP TABLE IF EXISTS `inventory_details`;
/*!50001 DROP VIEW IF EXISTS `inventory_details`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `inventory_details` AS SELECT 
 1 AS `inventory_id`,
 1 AS `inventory_code`,
 1 AS `blood_group`,
 1 AS `quantity_available_ml`,
 1 AS `storage_date`,
 1 AS `expiry_date`,
 1 AS `status`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `patients`
--

DROP TABLE IF EXISTS `patients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patients` (
  `patient_id` int NOT NULL AUTO_INCREMENT,
  `patient_code` varchar(10) NOT NULL,
  `patient_name` varchar(100) NOT NULL,
  `age` int NOT NULL,
  `gender` enum('Male','Female','Other') NOT NULL,
  `blood_group_id` int NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `medical_condition` varchar(200) DEFAULT NULL,
  `registration_date` date NOT NULL,
  PRIMARY KEY (`patient_id`),
  UNIQUE KEY `patient_code` (`patient_code`),
  KEY `blood_group_id` (`blood_group_id`),
  CONSTRAINT `patients_ibfk_1` FOREIGN KEY (`blood_group_id`) REFERENCES `blood_groups` (`blood_group_id`),
  CONSTRAINT `patients_chk_1` CHECK (((`age` >= 0) and (`age` <= 120)))
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patients`
--

LOCK TABLES `patients` WRITE;
/*!40000 ALTER TABLE `patients` DISABLE KEYS */;
INSERT INTO `patients` VALUES (1,'P001','Rohan Verma',35,'Male',7,'9020000001','Kukatpally','Accident blood loss','2026-09-20'),(2,'P002','Neha Sharma',42,'Female',1,'9020000002','Madhapur','Surgery','2026-09-20'),(3,'P003','Arjun Rao',19,'Male',3,'9020000003','Uppal','Anaemia','2026-09-21'),(4,'P004','Kavya Reddy',28,'Female',8,'9020000004','Gachibowli','Emergency transfusion','2026-09-21'),(5,'P005','Manoj Singh',51,'Male',2,'9020000005','Ameerpet','Surgery','2026-09-22'),(6,'P006','Isha Patel',31,'Female',5,'9020000006','Banjara Hills','Medical treatment','2026-09-22'),(7,'P007','Rahul Das',46,'Male',4,'9020000007','Secunderabad','Accident blood loss','2026-09-23'),(8,'P008','Anjali Nair',24,'Female',6,'9020000008','Miyapur','Surgery','2026-09-23');
/*!40000 ALTER TABLE `patients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `request_details`
--

DROP TABLE IF EXISTS `request_details`;
/*!50001 DROP VIEW IF EXISTS `request_details`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `request_details` AS SELECT 
 1 AS `request_id`,
 1 AS `request_code`,
 1 AS `patient_code`,
 1 AS `patient_name`,
 1 AS `hospital_code`,
 1 AS `hospital_name`,
 1 AS `blood_group`,
 1 AS `request_date`,
 1 AS `quantity_required_ml`,
 1 AS `request_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `blood_issue_details`
--

/*!50001 DROP VIEW IF EXISTS `blood_issue_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `blood_issue_details` AS select `bi`.`issue_id` AS `issue_id`,`bi`.`issue_code` AS `issue_code`,`p`.`patient_code` AS `patient_code`,`p`.`patient_name` AS `patient_name`,`h`.`hospital_code` AS `hospital_code`,`h`.`hospital_name` AS `hospital_name`,`bg`.`blood_group` AS `blood_group`,`bi`.`issue_date` AS `issue_date`,`bi`.`quantity_issued_ml` AS `quantity_issued_ml`,`bi`.`patient_use_date` AS `patient_use_date` from (((`blood_issues` `bi` join `patients` `p` on((`bi`.`patient_id` = `p`.`patient_id`))) join `hospitals` `h` on((`bi`.`hospital_id` = `h`.`hospital_id`))) join `blood_groups` `bg` on((`bi`.`blood_group_id` = `bg`.`blood_group_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `donation_details`
--

/*!50001 DROP VIEW IF EXISTS `donation_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `donation_details` AS select `dn`.`donation_id` AS `donation_id`,`dn`.`donation_code` AS `donation_code`,`d`.`donor_code` AS `donor_code`,`d`.`donor_name` AS `donor_name`,`bg`.`blood_group` AS `blood_group`,`dn`.`donation_date` AS `donation_date`,`dn`.`quantity_ml` AS `quantity_ml`,`dn`.`screening_status` AS `screening_status`,`dn`.`expiry_date` AS `expiry_date` from ((`donations` `dn` join `donors` `d` on((`dn`.`donor_id` = `d`.`donor_id`))) join `blood_groups` `bg` on((`dn`.`blood_group_id` = `bg`.`blood_group_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `donor_details`
--

/*!50001 DROP VIEW IF EXISTS `donor_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `donor_details` AS select `d`.`donor_id` AS `donor_id`,`d`.`donor_code` AS `donor_code`,`d`.`donor_name` AS `donor_name`,`d`.`age` AS `age`,`d`.`gender` AS `gender`,`bg`.`blood_group` AS `blood_group`,`d`.`phone` AS `phone`,`d`.`email` AS `email`,`d`.`address` AS `address`,`d`.`city` AS `city`,`d`.`registration_date` AS `registration_date`,`d`.`eligibility_status` AS `eligibility_status` from (`donors` `d` join `blood_groups` `bg` on((`d`.`blood_group_id` = `bg`.`blood_group_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `inventory_details`
--

/*!50001 DROP VIEW IF EXISTS `inventory_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `inventory_details` AS select `bi`.`inventory_id` AS `inventory_id`,`bi`.`inventory_code` AS `inventory_code`,`bg`.`blood_group` AS `blood_group`,`bi`.`quantity_available_ml` AS `quantity_available_ml`,`bi`.`storage_date` AS `storage_date`,`bi`.`expiry_date` AS `expiry_date`,`bi`.`status` AS `status` from (`blood_inventory` `bi` join `blood_groups` `bg` on((`bi`.`blood_group_id` = `bg`.`blood_group_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `request_details`
--

/*!50001 DROP VIEW IF EXISTS `request_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `request_details` AS select `br`.`request_id` AS `request_id`,`br`.`request_code` AS `request_code`,`p`.`patient_code` AS `patient_code`,`p`.`patient_name` AS `patient_name`,`h`.`hospital_code` AS `hospital_code`,`h`.`hospital_name` AS `hospital_name`,`bg`.`blood_group` AS `blood_group`,`br`.`request_date` AS `request_date`,`br`.`quantity_required_ml` AS `quantity_required_ml`,`br`.`request_status` AS `request_status` from (((`blood_requests` `br` join `patients` `p` on((`br`.`patient_id` = `p`.`patient_id`))) join `hospitals` `h` on((`br`.`hospital_id` = `h`.`hospital_id`))) join `blood_groups` `bg` on((`br`.`blood_group_id` = `bg`.`blood_group_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-06 10:00:51
