CREATE DATABASE  IF NOT EXISTS `laptopshop` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `laptopshop`;
-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: laptopshop
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
-- Table structure for table `cart_detail`
--

DROP TABLE IF EXISTS `cart_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `price` double NOT NULL,
  `quantity` bigint NOT NULL,
  `cart_id` bigint DEFAULT NULL,
  `product_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKbql1m2v2po7hcawonqsgqex88` (`cart_id`),
  KEY `FKclb1c0wg3mofxnpgidib1t987` (`product_id`),
  CONSTRAINT `FKbql1m2v2po7hcawonqsgqex88` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`),
  CONSTRAINT `FKclb1c0wg3mofxnpgidib1t987` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_detail`
--

LOCK TABLES `cart_detail` WRITE;
/*!40000 ALTER TABLE `cart_detail` DISABLE KEYS */;
INSERT INTO `cart_detail` VALUES (1,16290000,1,1,2),(2,15790000,1,1,1);
/*!40000 ALTER TABLE `cart_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carts`
--

DROP TABLE IF EXISTS `carts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carts` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `sum` int NOT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_64t7ox312pqal3p7fg9o503c2` (`user_id`),
  CONSTRAINT `FKb5o626f86h46m4s7ms6ginnop` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `carts_chk_1` CHECK ((`sum` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carts`
--

LOCK TABLES `carts` WRITE;
/*!40000 ALTER TABLE `carts` DISABLE KEYS */;
INSERT INTO `carts` VALUES (1,2,2);
/*!40000 ALTER TABLE `carts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_detail`
--

DROP TABLE IF EXISTS `order_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `price` double NOT NULL,
  `quantity` bigint NOT NULL,
  `order_id` bigint DEFAULT NULL,
  `product_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKrws2q0si6oyd6il8gqe2aennc` (`order_id`),
  KEY `FKc7q42e9tu0hslx6w4wxgomhvn` (`product_id`),
  CONSTRAINT `FKc7q42e9tu0hslx6w4wxgomhvn` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `FKrws2q0si6oyd6il8gqe2aennc` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_detail`
--

LOCK TABLES `order_detail` WRITE;
/*!40000 ALTER TABLE `order_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `receiver_address` varchar(255) DEFAULT NULL,
  `receiver_name` varchar(255) DEFAULT NULL,
  `receiver_phone` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `total_price` double NOT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK32ql8ubntj5uh44ph9659tiih` (`user_id`),
  CONSTRAINT `FK32ql8ubntj5uh44ph9659tiih` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `detail_desc` mediumtext NOT NULL,
  `factory` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `price` double NOT NULL,
  `purpose` varchar(255) DEFAULT NULL,
  `quantity` bigint NOT NULL,
  `short_desc` varchar(255) NOT NULL,
  `sold` bigint NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `products_chk_1` CHECK ((`price` >= 10000)),
  CONSTRAINT `products_chk_2` CHECK ((`quantity` >= 1))
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Bạn đang tìm kiếm một chiếc laptop với màn hình cực lớn, chất lượng hiển thị rất cao để làm các công việc sáng tạo? Bạn cần một sản phẩm có thương hiệu, đủ bền bỉ để sử dụng lâu dài? Vậy thì hãy mạnh dạn lựa chọn Dell Inspiron 5630, mẫu máy giá phổ thông đã có màn hình độ phân giải lên tới 2.5K, kích thước 16-inch, đi kèm phần cứng đời mới của Intel xoay quanh con chip Core i5-1335U - tiết kiệm điện nhưng không kém phần mạnh mẽ.','Dell','1735554610490-in5630nt-cnb-00055rf110-sl.webp','Dell Inspiron 16 5630',15790000,'Văn phòng',10,'i5-1340p, 16GB, 512GB, FHD+',0),(2,'Dell Inspiron 5430 sở hữu thiết kế đơn giản nhưng vẫn đậm tính thẩm mỹ, với lớp sơn nhám Bạc sang trọng, các đường cắt chỉn chu cùng logo Dell sáng bóng làm điểm nhấn. Đi kèm sẽ là kích thước cực kỳ nhỏ gọn (314 x 226.6 x 15.74mm), giúp sản phẩm đủ gọn gàng, nhẹ nhàng để đồng hành cùng chúng ta đi khắp mọi nơi.','Dell','1735554734016-in5430nt-cnb-00000ff090-sl-2pc.webp','Dell Inspiron 14 5430',16290000,'Văn phòng',10,'i5-1340p, 16GB, 512GB, 2.5K',0),(3,'Sẽ không có một “cuộc đại cách mạng” về thiết kế ở phiên bản ThinkPad X1 này. Chúng ta vẫn sẽ nhận được những gì được coi là đặc trưng nhất của dòng ThinkPad. Được định hướng là dòng laptop thuần về công việc nên phong cách thiết kế trên máy thiên về sự tối giản. Tuy nhiên, đằng sau sự tối giản ấy lại toát lên vẻ chuyên nghiệp và hiện đại. Các góc cạnh của máy được làm khá vuông vức. Mặt A được làm phẳng tối giản với logo ThinkPad được khắc tinh tế ở góc phải trên cùng. Trọng lượng của máy đạt 1.12kg và kích thước lần lượt 315.6 x 222.5 x 15.36mm. Đây là những con số tương đối ấn tượng để người dùng có thể tự tin mang vác máy theo mình mọi lúc mọi nơi.','Lenovo','1735554796626-lenovo-thinkpad-x1-carbon-gen-11-thinkpro-01.webp','Lenovo ThinkPad X1 Carbon Gen 11',25990000,'Doanh nhân',10,'i7-1365U, 16GB, 256GB, FHD+ Touch',0),(4,'Mặc dù đã được ra mắt cách đây gần hai năm nhưng tính đến thời điểm hiện tại, Acer Nitro 5 Tiger vẫn được đánh giá là một trong mẫu laptop gaming quốc dân bởi máy được trang bị bộ vi xử lý Intel Core i5 12500H mạnh mẽ kết hợp với GPU cao cấp NVIDIA dòng RTX 3050 Ti đem đến hiệu năng vượt trội đáp ứng mọi tác vụ từ cơ bản đến nâng cao. Bên cạnh đó, mẫu máy này còn có mức giá vô cùng phải chăng, hợp lý phù hợp với nhiều tệp khách hàng. Và để có cái nhìn chi tiết hơn về chiếc laptop này thì hãy cùng ThinkPro tìm hiểu trong bài viết dưới đây nhé','Acer','1735554888466-acer-nitro-5-tiger-thinkpro-cI3.webp','Acer Nitro 5 Tiger',19990000,'Gaming',10,'i7-12650H, RTX4060 6GB, 16GB, 512GB, FHD 144Hz',0),(5,'Acer Predator Helios Neo 16 2024 là chiếc laptop gaming thế hệ mới nhất của nhà Acer vào năm 2024. Chiếc laptop gaming này nổi bật với thiết kế mạnh mẽ và thu hút nhờ dải ánh sáng RGB. Laptop Acer Predator mang lại hiệu suất ấn tượng nhờ vi xử lý i9 14900HX và card đồ họa RTX 4060 mạnh mẽ, đáp ứng tốt các tựa game nặng và yêu cầu đồ họa cao. Hãy cùng Thinkpro khám phá chi tiết về chiếc laptop Acer này!','Acer','1735554956439-acer-predator-helios-neo-16-2024-undefined.webp','Acer Predator Helios Neo 16 2024',35990000,'Gaming',10,'i9 14900HX, RTX 4060 8GB, 16GB, 1TB, 2.5K 240HZ',0),(6,'So với MacBook Air M2, thiết kế của MacBook Air M2 nay đã được tinh chỉnh và “đại tu” lại một cách hoành tráng. Mặc dù MacBook Air M2 không phải là một chiếc laptop siêu mỏng nhưng kích thước tổng thể của máy vẫn ổn và đủ để đảm bảo tính cơ động, bao gồm 304.1mm x 215mm x 11.3mm cùng trọng lượng 1.24kg. Các đường nét trên máy được chế tác vuông vức, tinh xảo và sáng bóng với chất liệu nhôm cao cấp, toát lên vẻ sang trọng mà vẫn đảm bảo được trọng lượng nhẹ, độ bền tốt.','Apple','1735555025321-macbook-air-starlight-gallery1-20220606.webp','MacBook Air 2022 (Apple M2)',20390000,'Mỏng nhẹ',10,'M2, 8GB, 256GB, New CPO',0);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Admin thì full quyền','Admin'),(2,'User thông thường ','User');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `address` varchar(255) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `role_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKp56c1712k691lhsyewcssf40f` (`role_id`),
  CONSTRAINT `FKp56c1712k691lhsyewcssf40f` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Hà Nội','1735554510011-huong.jpg','admin@gmail.com','Minh Hương','$2a$10$NlQVZ.zxbR9lKNR2FrrtUegDsX6jEl30MxBH93Vtqa/SGfYfd2fGK','0817423074',1),(2,'Hà Nội',NULL,'user@gmail.com','Hương Minh','$2a$10$GOXfUe0QoSTWkKEGaNaG/uB6AEgDCvYsNbmghzyDFsQZ4c33GcA3S','0817423074',2);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'laptopshop'
--

--
-- Dumping routines for database 'laptopshop'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-01-03  3:11:00
