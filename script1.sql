CREATE SCHEMA IF NOT EXISTS new_tienda DEFAULT CHARACTER SET utf8 ;
USE new_tienda ;

-- -----------------------------------------------------
-- Table  proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS proveedor (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table  producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS producto (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  proveedor_id INT NOT NULL,
  PRIMARY KEY (id),
  INDEX fk_producto_proveedor1_idx (proveedor_id ASC) VISIBLE,
  CONSTRAINT fk_producto_proveedor1
    FOREIGN KEY (proveedor_id)
    REFERENCES proveedor (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table cliente
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS cliente (
  id INT NOT NULL AUTO_INCREMENT,
  tipo_documento VARCHAR(45) NOT NULL,
  documento VARCHAR(45) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX tipo_documento_UNIQUE (tipo_documento ASC, documento ASC) INVISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table factura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS factura (
  id INT NOT NULL AUTO_INCREMENT,
  cliente_id INT NOT NULL,
  fecha_venta DATETIME NOT NULL,
  estado VARCHAR(15),
  PRIMARY KEY (id),
  INDEX fk_factura_cliente1_idx (cliente_id ASC) VISIBLE,
  CONSTRAINT fk_factura_cliente1
    FOREIGN KEY (cliente_id)
    REFERENCES cliente (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table detalle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS detalle(
  id INT NOT NULL AUTO_INCREMENT,
  producto_id INT NOT NULL,
  factura_id INT NOT NULL,
  PRIMARY KEY (id),
  INDEX fk_detalle_producto1_idx (producto_id ASC) VISIBLE,
  INDEX fk_detalle_factura1_idx (factura_id ASC) VISIBLE,
  CONSTRAINT fk_detalle_producto1
    FOREIGN KEY (producto_id)
    REFERENCES producto (id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_detalle_factura1
    FOREIGN KEY (factura_id)
    REFERENCES factura (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------
-- LLENADO DE INFORMACION
-- -----------------------------------------

INSERT INTO proveedor(nombre)
VALUES  ('LA 14'),
        ('ALKOSTO'),
        ('EXITO');

-- AGREGAR PRODUCTOS CON EL RESPECTIVO ID DEL PROVEEDOR
INSERT INTO producto (nombre, proveedor_id)
VALUES ('menta', 1), ('balon', 2), ('guantes', 3), ('cuadernos', 1),
       ('lapiceros', 1), ('mesa', 2), ('sillas', 3), ('botellas', 1),
       ('libros', 1), ('cascos', 2);

-- CREAR 3 CLIENTES
INSERT INTO cliente(tipo_documento, documento)
VALUES  ('CC', '1.143.222'),
        ('TI', '12.827.911'),
        ('CC', '6.273.383');

-- FACTURA # 1 - CON SU DETALLE
INSERT INTO factura(cliente_id, fecha_venta, estado)
VALUES (1, NOW(), 'activo');
INSERT INTO detalle (producto_id, factura_id)
VALUES  (10,1), (1, 1);

-- FACTURA # 2 - CON SU DETALLE
INSERT INTO factura(cliente_id, fecha_venta, estado)
VALUES (3, NOW(), 'activo');
INSERT INTO detalle (producto_id, factura_id)
VALUES  (2,2), (9,2);

-- FACTURA # 3 - CON SU DETALLE
INSERT INTO factura(cliente_id, fecha_venta, estado)
VALUES (2, NOW(), 'activo');
INSERT INTO detalle (producto_id, factura_id)
VALUES  (4,3), (5,3);

-- FACTURA # 4 -- CON SU DETALLE
INSERT INTO factura(cliente_id, fecha_venta, estado)
VALUES (1, NOW(), 'activo');
INSERT INTO detalle (producto_id, factura_id)
VALUES  (6,4), (2,4);

-- FACTURA # 5 -- CON SU DETALLE
INSERT INTO factura(cliente_id, fecha_venta, estado)
VALUES (3, NOW(), 'activo');
INSERT INTO detalle (producto_id, factura_id)
VALUES  (18,5), (17,5), (11,5), (14,5);

-- 2 BORRADOS FISICOS
DELETE FROM factura
WHERE id = 1;
DELETE FROM factura
WHERE id = 3;

-- 2 BORRADOS LOGICOS
UPDATE factura
SET estado = 'INACTIVO'
WHERE id = 2;
UPDATE factura
SET estado = 'INACTIVO'
WHERE id = 4;

-- MOSTRAR DATOS ACTIVOS
SELECT id FROM factura
WHERE estado = 'ACTIVO';

-- MODIFICAR 3 PRODUCTOS EN SU NOMBRE Y PROVEEDOR
UPDATE producto
SET nombre = 'bananos'
WHERE id = 11;
UPDATE producto
SET proveedor_id = 3
WHERE id = 11;

UPDATE producto
SET nombre = 'manzanas', proveedor_id = 3
WHERE id = 12;

UPDATE producto
SET nombre = 'guanabanas', proveedor_id = 3
WHERE id = 14;

