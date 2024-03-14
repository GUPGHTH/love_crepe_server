-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 14, 2024 at 03:10 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `love_crepe_cafe_dt`
--

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `CartID` int(11) NOT NULL,
  `OrderID` int(11) NOT NULL DEFAULT 1,
  `MenuID` int(11) NOT NULL,
  `OptionID` text NOT NULL,
  `TableID` int(11) NOT NULL,
  `Amount` int(11) NOT NULL DEFAULT 1,
  `status` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`CartID`, `OrderID`, `MenuID`, `OptionID`, `TableID`, `Amount`, `status`) VALUES
(1, 13, 1, '1,2,3', 10, 1, 3),
(2, 13, 2, '1,2', 10, 1, 1),
(3, 13, 1, '1,2', 10, 1, 2),
(5, 14, 2, '1', 11, 2, 1),
(6, 16, 1, '1', 15, 2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `menulist`
--

CREATE TABLE `menulist` (
  `MenuID` int(11) NOT NULL,
  `Price` float NOT NULL,
  `Status` int(11) NOT NULL DEFAULT 0,
  `Type` int(11) NOT NULL DEFAULT 0,
  `EN_Name` text NOT NULL,
  `CN_Name` text NOT NULL,
  `TH_Name` text NOT NULL,
  `KR_Name` text NOT NULL,
  `EN_Description` text NOT NULL,
  `CN_Description` text NOT NULL,
  `TH_Description` text NOT NULL,
  `KR_Description` text NOT NULL,
  `img` text NOT NULL DEFAULT 'default.png'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menulist`
--

INSERT INTO `menulist` (`MenuID`, `Price`, `Status`, `Type`, `EN_Name`, `CN_Name`, `TH_Name`, `KR_Name`, `EN_Description`, `CN_Description`, `TH_Description`, `KR_Description`, `img`) VALUES
(1, 999999, 0, 1, 'Test', '測試', 'ทดสอบ', '시험', 'test_des', '測試', 'ทดสอบ', '시험', 'default.jpg'),
(2, 999999, 0, 2, 'Drink_EN', 'Drink_CN', 'Drink_TH', 'Drink_KR', 'Drink_test_EN', 'Drink_test_CN', 'Drink_test_TH', 'Drink_test_KR', 'default.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `optionaltable`
--

CREATE TABLE `optionaltable` (
  `OptionID` int(11) NOT NULL,
  `Description_EN` text NOT NULL,
  `Description_KR` text NOT NULL,
  `Description_TH` text NOT NULL,
  `Description_CN` text NOT NULL,
  `MenuID` int(11) NOT NULL,
  `Status` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `optionaltable`
--

INSERT INTO `optionaltable` (`OptionID`, `Description_EN`, `Description_KR`, `Description_TH`, `Description_CN`, `MenuID`, `Status`) VALUES
(1, 'Test_1_EN', 'test_1_KR', 'TEST_1_TH', 'TEST_1_CN', 1, 0),
(2, 'Test_2_EN', 'Test_2_KR', 'Test_2_TH', 'Test_2_CN', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `ordertable`
--

CREATE TABLE `ordertable` (
  `OrderID` int(11) NOT NULL,
  `OrderTable` int(11) NOT NULL,
  `Status` int(11) NOT NULL DEFAULT 1,
  `Time_payment` date NOT NULL DEFAULT '1111-11-01'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ordertable`
--

INSERT INTO `ordertable` (`OrderID`, `OrderTable`, `Status`, `Time_payment`) VALUES
(1, 99, 0, '1111-11-01'),
(13, 10, 1, '1111-11-01'),
(14, 11, 1, '1111-11-01'),
(16, 15, 1, '1111-11-01');

-- --------------------------------------------------------

--
-- Table structure for table `status_cart`
--

CREATE TABLE `status_cart` (
  `status` int(11) NOT NULL,
  `Description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `status_cart`
--

INSERT INTO `status_cart` (`status`, `Description`) VALUES
(0, 'In cart'),
(1, 'process'),
(2, 'wait to serve'),
(3, 'finish'),
(99, 'delete');

-- --------------------------------------------------------

--
-- Table structure for table `status_order`
--

CREATE TABLE `status_order` (
  `status` int(11) NOT NULL,
  `Description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `status_order`
--

INSERT INTO `status_order` (`status`, `Description`) VALUES
(0, 'etc'),
(1, 'process'),
(2, 'finish');

-- --------------------------------------------------------

--
-- Table structure for table `typemenu`
--

CREATE TABLE `typemenu` (
  `TypeID` int(11) NOT NULL,
  `Description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `typemenu`
--

INSERT INTO `typemenu` (`TypeID`, `Description`) VALUES
(1, 'Crepe'),
(2, 'Drink'),
(3, 'Food');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`CartID`),
  ADD KEY `MenuID` (`MenuID`),
  ADD KEY `OrderID` (`OrderID`),
  ADD KEY `status` (`status`);

--
-- Indexes for table `menulist`
--
ALTER TABLE `menulist`
  ADD PRIMARY KEY (`MenuID`),
  ADD KEY `Type` (`Type`);

--
-- Indexes for table `optionaltable`
--
ALTER TABLE `optionaltable`
  ADD PRIMARY KEY (`OptionID`),
  ADD KEY `MenuID` (`MenuID`);

--
-- Indexes for table `ordertable`
--
ALTER TABLE `ordertable`
  ADD PRIMARY KEY (`OrderID`),
  ADD KEY `Status` (`Status`);

--
-- Indexes for table `status_cart`
--
ALTER TABLE `status_cart`
  ADD PRIMARY KEY (`status`);

--
-- Indexes for table `status_order`
--
ALTER TABLE `status_order`
  ADD PRIMARY KEY (`status`);

--
-- Indexes for table `typemenu`
--
ALTER TABLE `typemenu`
  ADD PRIMARY KEY (`TypeID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `CartID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `menulist`
--
ALTER TABLE `menulist`
  MODIFY `MenuID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `optionaltable`
--
ALTER TABLE `optionaltable`
  MODIFY `OptionID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `ordertable`
--
ALTER TABLE `ordertable`
  MODIFY `OrderID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `typemenu`
--
ALTER TABLE `typemenu`
  MODIFY `TypeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`MenuID`) REFERENCES `menulist` (`MenuID`),
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`OrderID`) REFERENCES `ordertable` (`OrderID`),
  ADD CONSTRAINT `cart_ibfk_3` FOREIGN KEY (`status`) REFERENCES `status_cart` (`status`);

--
-- Constraints for table `menulist`
--
ALTER TABLE `menulist`
  ADD CONSTRAINT `menulist_ibfk_1` FOREIGN KEY (`Type`) REFERENCES `typemenu` (`TypeID`);

--
-- Constraints for table `optionaltable`
--
ALTER TABLE `optionaltable`
  ADD CONSTRAINT `optionaltable_ibfk_1` FOREIGN KEY (`MenuID`) REFERENCES `menulist` (`MenuID`);

--
-- Constraints for table `ordertable`
--
ALTER TABLE `ordertable`
  ADD CONSTRAINT `ordertable_ibfk_1` FOREIGN KEY (`Status`) REFERENCES `status_order` (`status`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
