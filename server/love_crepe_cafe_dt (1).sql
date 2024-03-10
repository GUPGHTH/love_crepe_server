-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 10, 2024 at 05:21 AM
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
  `OptionID` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  `KR_Description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menulist`
--

INSERT INTO `menulist` (`MenuID`, `Price`, `Status`, `Type`, `EN_Name`, `CN_Name`, `TH_Name`, `KR_Name`, `EN_Description`, `CN_Description`, `TH_Description`, `KR_Description`) VALUES
(1, 999999, 0, 1, 'Test', '測試', 'ทดสอบ', '시험', 'test_des', '測試', 'ทดสอบ', '시험');

-- --------------------------------------------------------

--
-- Table structure for table `optionaltable`
--

CREATE TABLE `optionaltable` (
  `OptionID` int(11) NOT NULL,
  `Description` text NOT NULL,
  `MenuID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ordertable`
--

CREATE TABLE `ordertable` (
  `OrderID` int(11) NOT NULL,
  `OrderTable` int(11) NOT NULL,
  `Status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ordertable`
--

INSERT INTO `ordertable` (`OrderID`, `OrderTable`, `Status`) VALUES
(1, 99, 0);

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
  ADD KEY `OrderID` (`OrderID`);

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
  ADD PRIMARY KEY (`OrderID`);

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
  MODIFY `CartID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `menulist`
--
ALTER TABLE `menulist`
  MODIFY `MenuID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `optionaltable`
--
ALTER TABLE `optionaltable`
  MODIFY `OptionID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ordertable`
--
ALTER TABLE `ordertable`
  MODIFY `OrderID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`OrderID`) REFERENCES `ordertable` (`OrderID`);

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
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
