-- MySQL dump 10.13  Distrib 8.4.7, for Win64 (x86_64)
--
-- Host: localhost    Database: banking_management_system
-- ------------------------------------------------------
-- Server version	8.4.7

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
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts` (
  `AccountID` int NOT NULL AUTO_INCREMENT,
  `CustomerID` int NOT NULL,
  `Balance` decimal(15,2) NOT NULL DEFAULT '0.00',
  `OpenDate` date NOT NULL,
  PRIMARY KEY (`AccountID`),
  KEY `idx_accounts_customer` (`CustomerID`),
  CONSTRAINT `fk_accounts_customers` FOREIGN KEY (`CustomerID`) REFERENCES `customers` (`CustomerID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chk_balance` CHECK ((`Balance` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES (1,1,14200000.00,'2024-01-15'),(2,2,174000000.00,'2024-02-10'),(3,3,8000000.00,'2024-03-05'),(4,4,50000000.00,'2024-04-20'),(5,5,12000000.00,'2024-05-12');
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `branches`
--

DROP TABLE IF EXISTS `branches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `branches` (
  `BranchID` int NOT NULL AUTO_INCREMENT,
  `BranchName` varchar(100) NOT NULL,
  `Address` varchar(255) NOT NULL,
  PRIMARY KEY (`BranchID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branches`
--

LOCK TABLES `branches` WRITE;
/*!40000 ALTER TABLE `branches` DISABLE KEYS */;
INSERT INTO `branches` VALUES (1,'NEU Bank Hanoi Branch','207 Giai Phong, Hanoi'),(2,'NEU Bank Hai Phong Branch','Le Chan, Hai Phong'),(3,'NEU Bank Da Nang Branch','Hai Chau, Da Nang'),(4,'NEU Bank HCM Branch','District 1, Ho Chi Minh City'),(5,'NEU Bank Can Tho Branch','Ninh Kieu, Can Tho');
/*!40000 ALTER TABLE `branches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `customerbalanceview`
--

DROP TABLE IF EXISTS `customerbalanceview`;
/*!50001 DROP VIEW IF EXISTS `customerbalanceview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `customerbalanceview` AS SELECT 
 1 AS `CustomerID`,
 1 AS `CustomerName`,
 1 AS `PhoneNumber`,
 1 AS `Address`,
 1 AS `AccountID`,
 1 AS `Balance`,
 1 AS `OpenDate`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `CustomerID` int NOT NULL AUTO_INCREMENT,
  `CustomerName` varchar(100) NOT NULL,
  `PhoneNumber` varchar(20) NOT NULL,
  `Address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`CustomerID`),
  UNIQUE KEY `PhoneNumber` (`PhoneNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'Nguyen Van An','0901000001','Hanoi'),(2,'Tran Thi Binh','0901000002','Hai Phong'),(3,'Le Minh Chau','0901000003','Da Nang'),(4,'Pham Quoc Dung','0901000004','Ho Chi Minh City'),(5,'Hoang Thu Ha','0901000005','Can Tho');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `EmployeeID` int NOT NULL AUTO_INCREMENT,
  `EmployeeName` varchar(100) NOT NULL,
  `Position` varchar(50) NOT NULL,
  `BranchID` int NOT NULL,
  PRIMARY KEY (`EmployeeID`),
  KEY `fk_employees_branches` (`BranchID`),
  CONSTRAINT `fk_employees_branches` FOREIGN KEY (`BranchID`) REFERENCES `branches` (`BranchID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,'Dang Tuan Anh','Manager',1),(2,'Nguyen Mai Linh','Teller',1),(3,'Tran Hoang Nam','Auditor',2),(4,'Pham Minh Duc','Teller',3),(5,'Le Thu Trang','Manager',4);
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suspiciouslogs`
--

DROP TABLE IF EXISTS `suspiciouslogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `suspiciouslogs` (
  `LogID` int NOT NULL AUTO_INCREMENT,
  `AccountID` int DEFAULT NULL,
  `Amount` decimal(15,2) DEFAULT NULL,
  `LogDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `Message` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`LogID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suspiciouslogs`
--

LOCK TABLES `suspiciouslogs` WRITE;
/*!40000 ALTER TABLE `suspiciouslogs` DISABLE KEYS */;
INSERT INTO `suspiciouslogs` VALUES (1,2,150000000.00,'2026-04-28 22:23:15','Suspicious high-value transaction detected');
/*!40000 ALTER TABLE `suspiciouslogs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `TransactionID` int NOT NULL AUTO_INCREMENT,
  `AccountID` int NOT NULL,
  `TransactionDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Amount` decimal(15,2) NOT NULL,
  `TransactionType` varchar(20) NOT NULL,
  PRIMARY KEY (`TransactionID`),
  KEY `idx_transactions_account` (`AccountID`),
  KEY `idx_transactions_date` (`TransactionDate`),
  CONSTRAINT `fk_transactions_accounts` FOREIGN KEY (`AccountID`) REFERENCES `accounts` (`AccountID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chk_transaction_amount` CHECK ((`Amount` > 0)),
  CONSTRAINT `chk_transaction_type` CHECK ((`TransactionType` in (_utf8mb4'Deposit',_utf8mb4'Withdrawal',_utf8mb4'Transfer')))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` VALUES (1,1,'2024-06-01 09:30:00',2000000.00,'Deposit'),(2,1,'2024-06-02 10:15:00',1000000.00,'Withdrawal'),(3,2,'2024-06-03 11:00:00',5000000.00,'Deposit'),(4,3,'2024-06-04 13:45:00',1500000.00,'Withdrawal'),(5,4,'2024-06-05 15:20:00',10000000.00,'Transfer'),(6,1,'2026-04-28 22:15:16',500000.00,'Deposit'),(7,1,'2026-04-28 22:17:01',300000.00,'Withdrawal'),(8,1,'2026-04-28 22:19:06',1000000.00,'Transfer'),(9,2,'2026-04-28 22:19:06',1000000.00,'Transfer'),(10,2,'2026-04-28 22:23:15',150000000.00,'Deposit');
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_suspicious_transaction` AFTER INSERT ON `transactions` FOR EACH ROW BEGIN
    IF NEW.Amount >= 100000000 THEN
        INSERT INTO SuspiciousLogs(AccountID, Amount, Message)
        VALUES(
            NEW.AccountID,
            NEW.Amount,
            'Suspicious high-value transaction detected'
        );
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `transactionsummaryview`
--

DROP TABLE IF EXISTS `transactionsummaryview`;
/*!50001 DROP VIEW IF EXISTS `transactionsummaryview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `transactionsummaryview` AS SELECT 
 1 AS `AccountID`,
 1 AS `CustomerName`,
 1 AS `TotalTransactions`,
 1 AS `TotalTransactionAmount`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `customerbalanceview`
--

/*!50001 DROP VIEW IF EXISTS `customerbalanceview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `customerbalanceview` AS select `c`.`CustomerID` AS `CustomerID`,`c`.`CustomerName` AS `CustomerName`,`c`.`PhoneNumber` AS `PhoneNumber`,`c`.`Address` AS `Address`,`a`.`AccountID` AS `AccountID`,`a`.`Balance` AS `Balance`,`a`.`OpenDate` AS `OpenDate` from (`customers` `c` join `accounts` `a` on((`c`.`CustomerID` = `a`.`CustomerID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `transactionsummaryview`
--

/*!50001 DROP VIEW IF EXISTS `transactionsummaryview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `transactionsummaryview` AS select `a`.`AccountID` AS `AccountID`,`c`.`CustomerName` AS `CustomerName`,count(`t`.`TransactionID`) AS `TotalTransactions`,ifnull(sum(`t`.`Amount`),0) AS `TotalTransactionAmount` from ((`accounts` `a` join `customers` `c` on((`a`.`CustomerID` = `c`.`CustomerID`))) left join `transactions` `t` on((`a`.`AccountID` = `t`.`AccountID`))) group by `a`.`AccountID`,`c`.`CustomerName` */;
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

-- Dump completed on 2026-04-28 22:55:03
