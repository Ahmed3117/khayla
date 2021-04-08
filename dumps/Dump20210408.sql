-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: bakery
-- ------------------------------------------------------
-- Server version	8.0.22

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
-- Table structure for table `aish`
--

DROP TABLE IF EXISTS `aish`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aish` (
  `khama_name` char(50) DEFAULT NULL,
  `quantity_for_one_piece` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aish`
--

LOCK TABLES `aish` WRITE;
/*!40000 ALTER TABLE `aish` DISABLE KEYS */;
INSERT INTO `aish` VALUES ('flour',100),('oil',10);
/*!40000 ALTER TABLE `aish` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `boxomad`
--

DROP TABLE IF EXISTS `boxomad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `boxomad` (
  `khama_name` char(50) DEFAULT NULL,
  `quantity_for_one_piece` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `boxomad`
--

LOCK TABLES `boxomad` WRITE;
/*!40000 ALTER TABLE `boxomad` DISABLE KEYS */;
INSERT INTO `boxomad` VALUES ('flour',70),('oil',7);
/*!40000 ALTER TABLE `boxomad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) NOT NULL,
  `one_piece_price` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `category_category_name` (`category_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'aish',1),(2,'boxomad',0),(3,'pati',3);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `daily_khama_report`
--

DROP TABLE IF EXISTS `daily_khama_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `daily_khama_report` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `out_quantity` int NOT NULL,
  `available_quantity` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daily_khama_report`
--

LOCK TABLES `daily_khama_report` WRITE;
/*!40000 ALTER TABLE `daily_khama_report` DISABLE KEYS */;
INSERT INTO `daily_khama_report` VALUES (1,'flour',300,99700),(2,'oil',30,9970),(4,'flour',210,99490),(5,'oil',21,9949),(6,'flour',490,99000),(7,'oil',49,9900),(8,'flour',300,98700),(9,'oil',30,9870),(10,'flour',130,98570),(11,'oil',30,9840),(12,'flour',500,148070),(13,'oil',50,9790);
/*!40000 ALTER TABLE `daily_khama_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `daily_sales`
--

DROP TABLE IF EXISTS `daily_sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `daily_sales` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category` varchar(255) NOT NULL,
  `quantity` varchar(255) NOT NULL,
  `price` int NOT NULL,
  `today_date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daily_sales`
--

LOCK TABLES `daily_sales` WRITE;
/*!40000 ALTER TABLE `daily_sales` DISABLE KEYS */;
INSERT INTO `daily_sales` VALUES (9,'aish','5',5,'2020-11-30');
/*!40000 ALTER TABLE `daily_sales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `khama`
--

DROP TABLE IF EXISTS `khama`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `khama` (
  `id` int NOT NULL AUTO_INCREMENT,
  `khama_name` varchar(255) NOT NULL,
  `khama_quantity_in_gm` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `khama_khama_name` (`khama_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `khama`
--

LOCK TABLES `khama` WRITE;
/*!40000 ALTER TABLE `khama` DISABLE KEYS */;
INSERT INTO `khama` VALUES (1,'flour',148070),(2,'oil',9790);
/*!40000 ALTER TABLE `khama` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pati`
--

DROP TABLE IF EXISTS `pati`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pati` (
  `khama_name` char(50) DEFAULT NULL,
  `quantity_for_one_piece` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pati`
--

LOCK TABLES `pati` WRITE;
/*!40000 ALTER TABLE `pati` DISABLE KEYS */;
INSERT INTO `pati` VALUES ('flour',65),('oil',15);
/*!40000 ALTER TABLE `pati` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `total`
--

DROP TABLE IF EXISTS `total`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `total` (
  `name` varchar(50) NOT NULL,
  `total_available` varchar(45) DEFAULT NULL,
  `modulous` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `total`
--

LOCK TABLES `total` WRITE;
/*!40000 ALTER TABLE `total` DISABLE KEYS */;
/*!40000 ALTER TABLE `total` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-08  1:00:25
