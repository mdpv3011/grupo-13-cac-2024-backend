-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: mysql-grupo13.alwaysdata.net
-- Generation Time: Jul 03, 2024 at 02:22 AM
-- Server version: 10.11.8-MariaDB
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `grupo13_gamesite`
--

-- --------------------------------------------------------

--
-- Table structure for table `games`
--

CREATE TABLE `games` (
  `id` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `genero` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `autor` varchar(30) NOT NULL,
  `imagen` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `id_categoria` int(11) NOT NULL,
  `fecha_lanzamiento` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `games`
--

INSERT INTO `games` (`id`, `nombre`, `genero`, `autor`, `imagen`, `id_categoria`, `fecha_lanzamiento`) VALUES
(1, 'LeagueOFLegends', 'Moba', 'RiotGames', '', 2, '2024-07-02 22:40:03'),
(2, 'GuildWarsII', 'MMORPG', 'ArenaNet', '1719958414621.jpg', 3, '2024-07-03 00:13:34'),
(3, 'PUBG', 'BattleRoyale', 'Crafton', '1719958699386.jpg', 4, '2024-07-03 00:18:19'),
(5, 'Dota', 'Moba', 'Valve Corporation', '1719961090540.jpg', 2, '2024-07-03 00:58:10'),
(6, 'Minecraft', 'Survival', 'Mojang', '1719963544174.jpg', 8, '2024-07-03 01:00:22');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `games`
--
ALTER TABLE `games`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `games`
--
ALTER TABLE `games`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
