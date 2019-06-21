-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 21, 2019 at 11:26 AM
-- Server version: 10.3.15-MariaDB
-- PHP Version: 7.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `login`
--

-- --------------------------------------------------------

--
-- Table structure for table `cost`
--

CREATE TABLE `cost` (
  `Cost_ID` int(11) NOT NULL,
  `RS_ID` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `current location`
--

CREATE TABLE `current location` (
  `CI_id` int(11) NOT NULL,
  `Riders_ID` int(11) DEFAULT NULL,
  `coordinate` double DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `destination`
--

CREATE TABLE `destination` (
  `destination_ID` int(11) NOT NULL,
  `location` varchar(255) DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `riders`
--

CREATE TABLE `riders` (
  `Riders_ID` int(11) NOT NULL,
  `First_name` varchar(255) DEFAULT NULL,
  `Last_name` varchar(255) DEFAULT NULL,
  `gmail` varchar(255) DEFAULT NULL,
  `Password` varchar(255) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `Riders_Phone_Number` int(11) DEFAULT NULL,
  `Gender` varchar(255) DEFAULT NULL,
  `Detail` varchar(255) DEFAULT NULL,
  `start_at` time DEFAULT NULL,
  `end_at` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ride_service`
--

CREATE TABLE `ride_service` (
  `RS_ID` int(11) NOT NULL,
  `Customer_ID` int(11) DEFAULT NULL,
  `Riders_ID` int(11) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `total ride service`
--

CREATE TABLE `total ride service` (
  `TRS_ID` int(11) NOT NULL,
  `Riders_ID` int(11) DEFAULT NULL,
  `Customer_ID` int(11) DEFAULT NULL,
  `RS_ID` int(11) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `price` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `Customer_ID` int(11) NOT NULL,
  `First_name` varchar(255) DEFAULT NULL,
  `Last_name` varchar(255) DEFAULT NULL,
  `gmail` varchar(255) DEFAULT NULL,
  `Password` varchar(255) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `User_Phone_Number` int(255) DEFAULT NULL,
  `Gender` varchar(255) DEFAULT NULL,
  `Detail` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cost`
--
ALTER TABLE `cost`
  ADD PRIMARY KEY (`Cost_ID`),
  ADD UNIQUE KEY `price` (`price`),
  ADD KEY `FK` (`RS_ID`);

--
-- Indexes for table `current location`
--
ALTER TABLE `current location`
  ADD PRIMARY KEY (`CI_id`),
  ADD KEY `FK` (`Riders_ID`);

--
-- Indexes for table `destination`
--
ALTER TABLE `destination`
  ADD PRIMARY KEY (`destination_ID`),
  ADD KEY `FK` (`location`);

--
-- Indexes for table `riders`
--
ALTER TABLE `riders`
  ADD PRIMARY KEY (`Riders_ID`);

--
-- Indexes for table `ride_service`
--
ALTER TABLE `ride_service`
  ADD PRIMARY KEY (`RS_ID`),
  ADD UNIQUE KEY `location_2` (`location`),
  ADD KEY `FK` (`Customer_ID`,`Riders_ID`),
  ADD KEY `Riders_ID` (`Riders_ID`),
  ADD KEY `location` (`location`);

--
-- Indexes for table `total ride service`
--
ALTER TABLE `total ride service`
  ADD PRIMARY KEY (`TRS_ID`),
  ADD KEY `FK` (`Riders_ID`,`Customer_ID`,`RS_ID`,`location`,`price`),
  ADD KEY `Customer_ID` (`Customer_ID`),
  ADD KEY `RS_ID` (`RS_ID`),
  ADD KEY `location` (`location`),
  ADD KEY `price` (`price`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`Customer_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `destination`
--
ALTER TABLE `destination`
  MODIFY `destination_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `riders`
--
ALTER TABLE `riders`
  MODIFY `Riders_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `Customer_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `current location`
--
ALTER TABLE `current location`
  ADD CONSTRAINT `current location_ibfk_1` FOREIGN KEY (`Riders_ID`) REFERENCES `riders` (`Riders_ID`);

--
-- Constraints for table `ride_service`
--
ALTER TABLE `ride_service`
  ADD CONSTRAINT `ride_service_ibfk_1` FOREIGN KEY (`Customer_ID`) REFERENCES `users` (`Customer_ID`),
  ADD CONSTRAINT `ride_service_ibfk_2` FOREIGN KEY (`Riders_ID`) REFERENCES `riders` (`Riders_ID`),
  ADD CONSTRAINT `ride_service_ibfk_3` FOREIGN KEY (`location`) REFERENCES `destination` (`location`);

--
-- Constraints for table `total ride service`
--
ALTER TABLE `total ride service`
  ADD CONSTRAINT `total ride service_ibfk_1` FOREIGN KEY (`Customer_ID`) REFERENCES `users` (`Customer_ID`),
  ADD CONSTRAINT `total ride service_ibfk_2` FOREIGN KEY (`Riders_ID`) REFERENCES `riders` (`Riders_ID`),
  ADD CONSTRAINT `total ride service_ibfk_3` FOREIGN KEY (`RS_ID`) REFERENCES `ride_service` (`RS_ID`),
  ADD CONSTRAINT `total ride service_ibfk_4` FOREIGN KEY (`location`) REFERENCES `destination` (`location`),
  ADD CONSTRAINT `total ride service_ibfk_5` FOREIGN KEY (`price`) REFERENCES `cost` (`price`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
