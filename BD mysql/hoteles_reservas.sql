/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : hoteles_reservas

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2023-10-24 17:34:17
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `cupo`
-- ----------------------------
DROP TABLE IF EXISTS `cupo`;
CREATE TABLE `cupo` (
  `id_cupo` int(11) NOT NULL AUTO_INCREMENT,
  `catidad_personas` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_cupo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cupo
-- ----------------------------
INSERT INTO `cupo` VALUES ('1', '4');
INSERT INTO `cupo` VALUES ('2', '6');
INSERT INTO `cupo` VALUES ('3', '8');

-- ----------------------------
-- Table structure for `habitaciones`
-- ----------------------------
DROP TABLE IF EXISTS `habitaciones`;
CREATE TABLE `habitaciones` (
  `id_habitaciones` int(11) NOT NULL AUTO_INCREMENT,
  `catidad` int(11) DEFAULT NULL,
  `cupo_id_cupo` int(11) NOT NULL,
  `tipo_id_tipo` int(11) NOT NULL,
  PRIMARY KEY (`id_habitaciones`),
  KEY `fk_habitacion_cupo_idx` (`cupo_id_cupo`),
  KEY `fk_habitacion_tipo1_idx` (`tipo_id_tipo`),
  CONSTRAINT `fk_habitacion_cupo` FOREIGN KEY (`cupo_id_cupo`) REFERENCES `cupo` (`id_cupo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_habitacion_tipo1` FOREIGN KEY (`tipo_id_tipo`) REFERENCES `tipo` (`id_tipo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of habitaciones
-- ----------------------------
INSERT INTO `habitaciones` VALUES ('1', '30', '1', '1');
INSERT INTO `habitaciones` VALUES ('2', '3', '1', '2');
INSERT INTO `habitaciones` VALUES ('3', '20', '2', '2');
INSERT INTO `habitaciones` VALUES ('4', '2', '2', '3');
INSERT INTO `habitaciones` VALUES ('5', '10', '3', '1');
INSERT INTO `habitaciones` VALUES ('6', '1', '3', '2');
INSERT INTO `habitaciones` VALUES ('7', '20', '2', '1');
INSERT INTO `habitaciones` VALUES ('8', '20', '2', '2');
INSERT INTO `habitaciones` VALUES ('9', '2', '2', '3');

-- ----------------------------
-- Table structure for `sedes_hotel`
-- ----------------------------
DROP TABLE IF EXISTS `sedes_hotel`;
CREATE TABLE `sedes_hotel` (
  `id_sede_hotel` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_sede_hotel`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sedes_hotel
-- ----------------------------
INSERT INTO `sedes_hotel` VALUES ('1', 'Barranquilla');
INSERT INTO `sedes_hotel` VALUES ('2', 'Cali');
INSERT INTO `sedes_hotel` VALUES ('3', 'Cartagena');
INSERT INTO `sedes_hotel` VALUES ('4', 'Bogota');

-- ----------------------------
-- Table structure for `sedes_hotel_habitacion`
-- ----------------------------
DROP TABLE IF EXISTS `sedes_hotel_habitacion`;
CREATE TABLE `sedes_hotel_habitacion` (
  `id_sede_habitacion` varchar(45) NOT NULL,
  `id_sede_hotel` int(11) NOT NULL,
  `id_habitaciones` int(11) NOT NULL,
  PRIMARY KEY (`id_sede_habitacion`,`id_sede_hotel`,`id_habitaciones`),
  KEY `fk_sedes_hotel_has_habitacion_habitacion1_idx` (`id_habitaciones`),
  KEY `fk_sedes_hotel_has_habitacion_sedes_hotel1_idx` (`id_sede_hotel`),
  CONSTRAINT `fk_sedes_hotel_has_habitacion_habitacion1` FOREIGN KEY (`id_habitaciones`) REFERENCES `habitaciones` (`id_habitaciones`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_sedes_hotel_has_habitacion_sedes_hotel1` FOREIGN KEY (`id_sede_hotel`) REFERENCES `sedes_hotel` (`id_sede_hotel`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sedes_hotel_habitacion
-- ----------------------------
INSERT INTO `sedes_hotel_habitacion` VALUES ('1', '1', '1');
INSERT INTO `sedes_hotel_habitacion` VALUES ('2', '1', '2');
INSERT INTO `sedes_hotel_habitacion` VALUES ('3', '2', '3');
INSERT INTO `sedes_hotel_habitacion` VALUES ('4', '2', '4');
INSERT INTO `sedes_hotel_habitacion` VALUES ('5', '3', '5');
INSERT INTO `sedes_hotel_habitacion` VALUES ('6', '3', '6');
INSERT INTO `sedes_hotel_habitacion` VALUES ('7', '4', '7');
INSERT INTO `sedes_hotel_habitacion` VALUES ('8', '4', '8');
INSERT INTO `sedes_hotel_habitacion` VALUES ('9', '4', '9');

-- ----------------------------
-- Table structure for `tipo`
-- ----------------------------
DROP TABLE IF EXISTS `tipo`;
CREATE TABLE `tipo` (
  `id_tipo` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_tipo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tipo
-- ----------------------------
INSERT INTO `tipo` VALUES ('1', 'Estandar');
INSERT INTO `tipo` VALUES ('2', 'Premium');
INSERT INTO `tipo` VALUES ('3', 'VIP');
