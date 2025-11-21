-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: se3309.clg40mmisdm8.us-east-1.rds.amazonaws.com    Database: FiveGuysCellular
-- ------------------------------------------------------
-- Server version	8.0.43

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '';

--
-- Table structure for table `EmployeeRole`
--

DROP TABLE IF EXISTS `EmployeeRole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EmployeeRole` (
  `roleID` char(36) NOT NULL DEFAULT (uuid()),
  `roleName` varchar(50) NOT NULL,
  `roleDescription` varchar(150) DEFAULT NULL,
  `updatedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`roleID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EmployeeRole`
--

LOCK TABLES `EmployeeRole` WRITE;
/*!40000 ALTER TABLE `EmployeeRole` DISABLE KEYS */;
INSERT INTO `EmployeeRole` VALUES ('17844629-c9a0-405c-824a-b4bcd9e79742','RSG','RSG role','2025-11-20 11:39:33'),('7b4134c4-dc4f-4b01-96da-ace8cb06c491','Sales Rep','Sales Rep role','2025-11-20 11:39:33'),('bcb6c8df-8c62-4816-a00d-006931ae9315','Support Tech','Support Tech role','2025-11-20 11:39:33'),('e1816686-7df7-4ca4-b867-47c802408ff7','Finance','Finance role','2025-11-20 11:39:33'),('e5ed1249-9a29-4032-91fa-6b046c254f59','Manager','Manager role','2025-11-20 11:39:33');
/*!40000 ALTER TABLE `EmployeeRole` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-20 21:00:25
