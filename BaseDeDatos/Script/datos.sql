-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 11-04-2025 a las 22:49:44
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `datos`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `atletas`
--

CREATE TABLE `atletas` (
  `IdAtleta` int(11) NOT NULL,
  `Nombre` varchar(100) NOT NULL,
  `Apellido` varchar(100) NOT NULL,
  `Sexo` char(1) DEFAULT NULL CHECK (`Sexo` in ('F','M')),
  `Fecha_Reg` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `atletas`
--

INSERT INTO `atletas` (`IdAtleta`, `Nombre`, `Apellido`, `Sexo`, `Fecha_Reg`) VALUES
(101, 'Carlos', 'Sainz', 'M', '1990-05-15'),
(102, 'Maria', 'Gomez', 'F', '1995-08-22'),
(103, 'Luis', 'Fernandez', 'M', '1988-03-10'),
(104, 'Ana ', 'Martinez', 'F', '1992-11-05'),
(105, 'Morochito', 'Hernandez', 'M', '1990-01-10');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `disciplinas`
--

CREATE TABLE `disciplinas` (
  `IdDisciplina` int(11) NOT NULL,
  `Descripcion` varchar(100) NOT NULL,
  `Estatus` char(1) DEFAULT NULL CHECK (`Estatus` in ('A','E','S'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `disciplinas`
--

INSERT INTO `disciplinas` (`IdDisciplina`, `Descripcion`, `Estatus`) VALUES
(1, 'Atletismo', 'A'),
(2, 'Natacion', 'A'),
(3, 'Ciclismo', 'A'),
(4, 'Gimnasia', 'E'),
(5, 'Boxeo', 'S');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `juegos`
--

CREATE TABLE `juegos` (
  `IdJuego` int(11) NOT NULL,
  `J.IdAtleta` int(11) DEFAULT NULL,
  `J.IdDisciplina` int(11) DEFAULT NULL,
  `Lugar` varchar(100) DEFAULT NULL,
  `J.Fecha` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `juegos`
--

INSERT INTO `juegos` (`IdJuego`, `J.IdAtleta`, `J.IdDisciplina`, `Lugar`, `J.Fecha`) VALUES
(10, 101, 1, 'Estadio Olimpico, Madrid', '2023-06-10'),
(20, 102, 2, 'Piscina Municipal, CDMX', '2023-06-15'),
(30, 103, 3, 'Velodromo Nacional, Buenos Aires', '2023-06-20'),
(40, 104, 4, 'Estadio Anastasio Girardort, Medellin', '2023-06-25'),
(50, 105, 5, 'Gimnasio Vertical Box Club, Caracas', '2023-07-30');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `atletas`
--
ALTER TABLE `atletas`
  ADD PRIMARY KEY (`IdAtleta`);

--
-- Indices de la tabla `disciplinas`
--
ALTER TABLE `disciplinas`
  ADD PRIMARY KEY (`IdDisciplina`),
  ADD UNIQUE KEY `Descripcion` (`Descripcion`);

--
-- Indices de la tabla `juegos`
--
ALTER TABLE `juegos`
  ADD PRIMARY KEY (`IdJuego`),
  ADD KEY `IdAtleta` (`J.IdAtleta`),
  ADD KEY `IdDisciplina` (`J.IdDisciplina`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `juegos`
--
ALTER TABLE `juegos`
  ADD CONSTRAINT `juegos_ibfk_1` FOREIGN KEY (`J.IdAtleta`) REFERENCES `atletas` (`IdAtleta`),
  ADD CONSTRAINT `juegos_ibfk_2` FOREIGN KEY (`J.IdDisciplina`) REFERENCES `disciplinas` (`IdDisciplina`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;


-- Totalizacion de Disciplinas Realizadas 

select Fecha, count(distinct IdDisciplina) as CantidadDisciplinas from DATOS.Juegos group by Fecha Order By Fecha;