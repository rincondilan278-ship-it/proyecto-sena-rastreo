-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 19-06-2026 a las 07:16:06
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `rastreo_ambiental`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administrador`
--

CREATE TABLE `administrador` (
  `id_administrador` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `nivel_acceso` enum('basico','medio','super') DEFAULT 'basico'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `camion`
--

CREATE TABLE `camion` (
  `id_camion` int(11) NOT NULL,
  `placa` varchar(10) NOT NULL,
  `modelo` varchar(50) DEFAULT NULL,
  `estado` enum('activo','inactivo','mantenimiento') DEFAULT 'activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `camion_conductor`
--

CREATE TABLE `camion_conductor` (
  `id_asignacion` int(11) NOT NULL,
  `id_camion` int(11) NOT NULL,
  `id_conductor` int(11) NOT NULL,
  `fecha_asignacion` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ciudadano`
--

CREATE TABLE `ciudadano` (
  `id_ciudadano` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `conductor`
--

CREATE TABLE `conductor` (
  `id_conductor` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `num_documento` varchar(20) NOT NULL,
  `licencia` varchar(30) NOT NULL,
  `vehiculo_asignado` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `consulta_ruta`
--

CREATE TABLE `consulta_ruta` (
  `id_consulta_ruta` int(11) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `id_ruta` int(11) DEFAULT NULL,
  `fecha_consulta` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `funcionario`
--

CREATE TABLE `funcionario` (
  `id_funcionario` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `cargo` varchar(100) DEFAULT NULL,
  `dependencia` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `geocerca`
--

CREATE TABLE `geocerca` (
  `id_geocerca` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `area` polygon NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `incidente`
--

CREATE TABLE `incidente` (
  `id_incidente` int(11) NOT NULL,
  `descripcion` text NOT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  `barrio` varchar(100) DEFAULT NULL,
  `zona` varchar(100) DEFAULT NULL,
  `latitud` decimal(10,8) DEFAULT NULL,
  `longitud` decimal(11,8) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificacion`
--

CREATE TABLE `notificacion` (
  `id_notificacion` int(11) NOT NULL,
  `mensaje` text NOT NULL,
  `fecha_envio` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `novedad`
--

CREATE TABLE `novedad` (
  `id_novedad` int(11) NOT NULL,
  `titulo` varchar(200) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `categoria` varchar(100) DEFAULT NULL,
  `imagen` varchar(255) DEFAULT NULL,
  `fecha_publicacion` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `punto_reciclaje`
--

CREATE TABLE `punto_reciclaje` (
  `id_punto` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `materiales_aceptados` text DEFAULT NULL,
  `horario` varchar(100) DEFAULT NULL,
  `latitud` decimal(10,8) DEFAULT NULL,
  `longitud` decimal(11,8) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ruta`
--

CREATE TABLE `ruta` (
  `id_ruta` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `hora_inicio` time DEFAULT NULL,
  `hora_fin` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ruta_punto_reciclaje`
--

CREATE TABLE `ruta_punto_reciclaje` (
  `id_ruta_punto` int(11) NOT NULL,
  `id_ruta` int(11) NOT NULL,
  `id_punto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ruta_zona`
--

CREATE TABLE `ruta_zona` (
  `id_ruta_zona` int(11) NOT NULL,
  `id_ruta` int(11) NOT NULL,
  `id_zona` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ubicacion_camion`
--

CREATE TABLE `ubicacion_camion` (
  `id_ubicacion` int(11) NOT NULL,
  `id_camion` int(11) NOT NULL,
  `latitud` decimal(10,8) NOT NULL,
  `longitud` decimal(11,8) NOT NULL,
  `velocidad` decimal(5,2) DEFAULT NULL,
  `fecha_registro` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) DEFAULT NULL,
  `correo` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `tipo_usuario` enum('ciudadano','funcionario','administrador','conductor') NOT NULL,
  `fecha_registro` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_novedad`
--

CREATE TABLE `usuario_novedad` (
  `id_novedad_usuario` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_novedad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `zona`
--

CREATE TABLE `zona` (
  `id_zona` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `latitud` decimal(10,8) DEFAULT NULL,
  `longitud` decimal(11,8) DEFAULT NULL,
  `poligono` polygon NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `administrador`
--
ALTER TABLE `administrador`
  ADD PRIMARY KEY (`id_administrador`),
  ADD UNIQUE KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `camion`
--
ALTER TABLE `camion`
  ADD PRIMARY KEY (`id_camion`),
  ADD UNIQUE KEY `placa` (`placa`);

--
-- Indices de la tabla `camion_conductor`
--
ALTER TABLE `camion_conductor`
  ADD PRIMARY KEY (`id_asignacion`),
  ADD KEY `id_camion` (`id_camion`),
  ADD KEY `id_conductor` (`id_conductor`);

--
-- Indices de la tabla `ciudadano`
--
ALTER TABLE `ciudadano`
  ADD PRIMARY KEY (`id_ciudadano`),
  ADD UNIQUE KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `conductor`
--
ALTER TABLE `conductor`
  ADD PRIMARY KEY (`id_conductor`),
  ADD UNIQUE KEY `id_usuario` (`id_usuario`),
  ADD UNIQUE KEY `num_documento` (`num_documento`);

--
-- Indices de la tabla `consulta_ruta`
--
ALTER TABLE `consulta_ruta`
  ADD PRIMARY KEY (`id_consulta_ruta`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_ruta` (`id_ruta`);

--
-- Indices de la tabla `funcionario`
--
ALTER TABLE `funcionario`
  ADD PRIMARY KEY (`id_funcionario`),
  ADD UNIQUE KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `geocerca`
--
ALTER TABLE `geocerca`
  ADD PRIMARY KEY (`id_geocerca`);

--
-- Indices de la tabla `incidente`
--
ALTER TABLE `incidente`
  ADD PRIMARY KEY (`id_incidente`);

--
-- Indices de la tabla `notificacion`
--
ALTER TABLE `notificacion`
  ADD PRIMARY KEY (`id_notificacion`);

--
-- Indices de la tabla `novedad`
--
ALTER TABLE `novedad`
  ADD PRIMARY KEY (`id_novedad`);

--
-- Indices de la tabla `punto_reciclaje`
--
ALTER TABLE `punto_reciclaje`
  ADD PRIMARY KEY (`id_punto`);

--
-- Indices de la tabla `ruta`
--
ALTER TABLE `ruta`
  ADD PRIMARY KEY (`id_ruta`);

--
-- Indices de la tabla `ruta_punto_reciclaje`
--
ALTER TABLE `ruta_punto_reciclaje`
  ADD PRIMARY KEY (`id_ruta_punto`),
  ADD KEY `id_ruta` (`id_ruta`),
  ADD KEY `id_punto` (`id_punto`);

--
-- Indices de la tabla `ruta_zona`
--
ALTER TABLE `ruta_zona`
  ADD PRIMARY KEY (`id_ruta_zona`),
  ADD KEY `id_ruta` (`id_ruta`),
  ADD KEY `id_zona` (`id_zona`);

--
-- Indices de la tabla `ubicacion_camion`
--
ALTER TABLE `ubicacion_camion`
  ADD PRIMARY KEY (`id_ubicacion`),
  ADD KEY `id_camion` (`id_camion`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- Indices de la tabla `usuario_novedad`
--
ALTER TABLE `usuario_novedad`
  ADD PRIMARY KEY (`id_novedad_usuario`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_novedad` (`id_novedad`);

--
-- Indices de la tabla `zona`
--
ALTER TABLE `zona`
  ADD PRIMARY KEY (`id_zona`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `administrador`
--
ALTER TABLE `administrador`
  MODIFY `id_administrador` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `camion`
--
ALTER TABLE `camion`
  MODIFY `id_camion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `camion_conductor`
--
ALTER TABLE `camion_conductor`
  MODIFY `id_asignacion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ciudadano`
--
ALTER TABLE `ciudadano`
  MODIFY `id_ciudadano` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `conductor`
--
ALTER TABLE `conductor`
  MODIFY `id_conductor` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `consulta_ruta`
--
ALTER TABLE `consulta_ruta`
  MODIFY `id_consulta_ruta` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `funcionario`
--
ALTER TABLE `funcionario`
  MODIFY `id_funcionario` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `geocerca`
--
ALTER TABLE `geocerca`
  MODIFY `id_geocerca` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `incidente`
--
ALTER TABLE `incidente`
  MODIFY `id_incidente` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `notificacion`
--
ALTER TABLE `notificacion`
  MODIFY `id_notificacion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `novedad`
--
ALTER TABLE `novedad`
  MODIFY `id_novedad` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `punto_reciclaje`
--
ALTER TABLE `punto_reciclaje`
  MODIFY `id_punto` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ruta`
--
ALTER TABLE `ruta`
  MODIFY `id_ruta` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ruta_punto_reciclaje`
--
ALTER TABLE `ruta_punto_reciclaje`
  MODIFY `id_ruta_punto` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ruta_zona`
--
ALTER TABLE `ruta_zona`
  MODIFY `id_ruta_zona` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ubicacion_camion`
--
ALTER TABLE `ubicacion_camion`
  MODIFY `id_ubicacion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuario_novedad`
--
ALTER TABLE `usuario_novedad`
  MODIFY `id_novedad_usuario` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `zona`
--
ALTER TABLE `zona`
  MODIFY `id_zona` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `administrador`
--
ALTER TABLE `administrador`
  ADD CONSTRAINT `administrador_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE;

--
-- Filtros para la tabla `camion_conductor`
--
ALTER TABLE `camion_conductor`
  ADD CONSTRAINT `camion_conductor_ibfk_1` FOREIGN KEY (`id_camion`) REFERENCES `camion` (`id_camion`) ON DELETE CASCADE,
  ADD CONSTRAINT `camion_conductor_ibfk_2` FOREIGN KEY (`id_conductor`) REFERENCES `conductor` (`id_conductor`) ON DELETE CASCADE;

--
-- Filtros para la tabla `ciudadano`
--
ALTER TABLE `ciudadano`
  ADD CONSTRAINT `ciudadano_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE;

--
-- Filtros para la tabla `conductor`
--
ALTER TABLE `conductor`
  ADD CONSTRAINT `conductor_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE;

--
-- Filtros para la tabla `consulta_ruta`
--
ALTER TABLE `consulta_ruta`
  ADD CONSTRAINT `consulta_ruta_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE SET NULL,
  ADD CONSTRAINT `consulta_ruta_ibfk_2` FOREIGN KEY (`id_ruta`) REFERENCES `ruta` (`id_ruta`) ON DELETE SET NULL;

--
-- Filtros para la tabla `funcionario`
--
ALTER TABLE `funcionario`
  ADD CONSTRAINT `funcionario_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE;

--
-- Filtros para la tabla `ruta_punto_reciclaje`
--
ALTER TABLE `ruta_punto_reciclaje`
  ADD CONSTRAINT `ruta_punto_reciclaje_ibfk_1` FOREIGN KEY (`id_ruta`) REFERENCES `ruta` (`id_ruta`) ON DELETE CASCADE,
  ADD CONSTRAINT `ruta_punto_reciclaje_ibfk_2` FOREIGN KEY (`id_punto`) REFERENCES `punto_reciclaje` (`id_punto`) ON DELETE CASCADE;

--
-- Filtros para la tabla `ruta_zona`
--
ALTER TABLE `ruta_zona`
  ADD CONSTRAINT `ruta_zona_ibfk_1` FOREIGN KEY (`id_ruta`) REFERENCES `ruta` (`id_ruta`) ON DELETE CASCADE,
  ADD CONSTRAINT `ruta_zona_ibfk_2` FOREIGN KEY (`id_zona`) REFERENCES `zona` (`id_zona`) ON DELETE CASCADE;

--
-- Filtros para la tabla `ubicacion_camion`
--
ALTER TABLE `ubicacion_camion`
  ADD CONSTRAINT `ubicacion_camion_ibfk_1` FOREIGN KEY (`id_camion`) REFERENCES `camion` (`id_camion`) ON DELETE CASCADE;

--
-- Filtros para la tabla `usuario_novedad`
--
ALTER TABLE `usuario_novedad`
  ADD CONSTRAINT `usuario_novedad_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE,
  ADD CONSTRAINT `usuario_novedad_ibfk_2` FOREIGN KEY (`id_novedad`) REFERENCES `novedad` (`id_novedad`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
