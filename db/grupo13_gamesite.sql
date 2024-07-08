-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: mysql-grupo13.alwaysdata.net
-- Generation Time: Jul 03, 2024 at 11:17 AM
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
-- Table structure for table `categoria`
--

CREATE TABLE `categoria` (
  `id` int(11) NOT NULL,
  `nombre_categoria` varchar(30) NOT NULL,
  `descripcion` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categoria`
--

INSERT INTO `categoria` (`id`, `nombre_categoria`, `descripcion`) VALUES
(1, 'Survivor', 'juego de sobrevivencia'),
(2, 'Shooter', 'accion con armas de fuego'),
(3, 'Moba', 'competitivo estrategico'),
(4, 'Battle Royale', 'sobrevivir en mundo abierto durante una cantidad de tiempo'),
(5, 'MMORPG', 'descubriendo mundo abierto y desarrollando habilidades');

-- --------------------------------------------------------

--
-- Table structure for table `games`
--

CREATE TABLE `games` (
  `id` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `autor` varchar(30) NOT NULL,
  `imagen` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `id_categoria` int(11) NOT NULL,
  `fecha_lanzamiento` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `games`
--

INSERT INTO `games` (`id`, `nombre`, `autor`, `imagen`, `id_categoria`, `fecha_lanzamiento`) VALUES
(1, 'Minecraft', 'Mojang Studios', '1719994542770.jpg', 1, '2024-07-03 10:15:42'),
(2, 'League of Legends', 'Riot', '', 3, '2024-07-03 10:38:13'),
(3, 'Dota', 'Valve Corporation', '1719996048960.jpg', 3, '2024-07-03 10:40:49'),
(4, 'Guild Wars II', 'ArenaNet', '1719996376158.jpg', 5, '2024-07-03 10:46:16');

-- --------------------------------------------------------

--
-- Table structure for table `region`
--

CREATE TABLE `region` (
  `id_region` int(11) NOT NULL,
  `nombre_region` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `region`
--

INSERT INTO `region` (`id_region`, `nombre_region`) VALUES
(1, 'LAN'),
(2, 'LAS'),
(3, 'North America'),
(4, 'Europe'),
(5, 'Asia');

-- --------------------------------------------------------

--
-- Table structure for table `usuario`
--

CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `nick` varchar(30) NOT NULL,
  `categoria_favorita` int(11) NOT NULL,
  `id_region` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `usuario`
--

INSERT INTO `usuario` (`id_usuario`, `nombre`, `nick`, `categoria_favorita`, `id_region`) VALUES
(1, 'Juan', 'JuanValles95', 3, 1),
(2, 'Andres', 'Andr_Mag', 1, 2),
(3, 'Maria', 'MariaAle', 2, 4),
(4, 'Chyng', 'Chinese', 5, 5),
(5, 'Michael', 'MichMad_89', 3, 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `games`
--
ALTER TABLE `games`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_categoria` (`id_categoria`);

--
-- Indexes for table `region`
--
ALTER TABLE `region`
  ADD PRIMARY KEY (`id_region`);

--
-- Indexes for table `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_usuario`),
  ADD KEY `id_region` (`id_region`),
  ADD KEY `categoria_favorita` (`categoria_favorita`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `games`
--
ALTER TABLE `games`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `region`
--
ALTER TABLE `region`
  MODIFY `id_region` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `games`
--
ALTER TABLE `games`
  ADD CONSTRAINT `games_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id`);

--
-- Constraints for table `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`id_region`) REFERENCES `region` (`id_region`),
  ADD CONSTRAINT `usuario_ibfk_2` FOREIGN KEY (`categoria_favorita`) REFERENCES `categoria` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
