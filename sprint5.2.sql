#Sprint Modulo 5 MySQL:
#Grupo 1: Alberto Briones, Liliana Garmendia, Diego González

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Sprint5
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Sprint5
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Sprint5` DEFAULT CHARACTER SET utf8 ;
USE `Sprint5` ;

-- -----------------------------------------------------
-- Table `Sprint5`.`Proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sprint5`.`Proveedor` (
  `Id_proveedor` INT NOT NULL AUTO_INCREMENT,
  `Representante_legal` VARCHAR(20) NOT NULL,
  `Nombre_corporativo` VARCHAR(45) NOT NULL,
  `Telefono_1` VARCHAR(45) NOT NULL,
  `Telefono_2` VARCHAR(45) NOT NULL,
  `Correo_electronico` VARCHAR(45) NOT NULL,
  `Categoria` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id_proveedor`, `Categoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sprint5`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sprint5`.`Cliente` (
  `idCliente` INT NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  `Apellido` VARCHAR(45) NOT NULL,
  `Direccion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Sprint5`.`Productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sprint5`.`Productos` (
  `Id_producto` INT NOT NULL,
  `Nombre`VARCHAR(45) NOT NULL,
  `Stock` INT NOT NULL,
  `Precio` INT NOT NULL,
  `Color` VARCHAR(45) NOT NULL,
  `Categoria` VARCHAR(45) NOT NULL,
  `Proveedor` INT NOT NULL,
  PRIMARY KEY (`Id_producto`),
  CONSTRAINT fk_productoidprov
  FOREIGN KEY(`Proveedor`, `Categoria`) REFERENCES proveedor(`Id_proveedor`, `Categoria`)ON DELETE CASCADE ON UPDATE CASCADE)
ENGINE = InnoDB;

#Creación de usuario con privilegios.
CREATE USER 'Grupo1' IDENTIFIED BY 'sprint5';

GRANT SELECT, INSERT, TRIGGER ON TABLE `Sprint5`.* TO 'Grupo1';
GRANT SELECT ON TABLE `Sprint5`.* TO 'Grupo1';
GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE `Sprint5`.* TO 'Grupo1';
GRANT ALL ON `Sprint5`.* TO 'Grupo1';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

#Seleccion de la base de datos
Use sprint5;

#Agregar los datos de 5 clientes a la tabla cliente
INSERT INTO cliente(idCliente, Nombre, Apellido, Direccion)
       VALUES(1, "Arturo", "Chacón", "Av.Independencia 400, Los Andes"),
			 (2, "Michelle", "Cuevas","Colón 1125, Valparaíso"),
			 (3, "Rodrigo", "Tello","Quillota 650, Vina del Mar"),
             (4, "Guillermo", "Benítez","Arlegui 698, Vina del Mar"),
             (5, "Andrea", "Barrera", "10 de Julio 142, San Felipe");

#Ver los registros cargados a la tabla cliente             
SELECT * FROM cliente;

#Agregar 5 proveedores a la tabla proveedor
INSERT INTO proveedor(id_proveedor, Representante_legal, Nombre_corporativo, Telefono_1, Telefono_2, Correo_electronico, Categoria)
          VALUES(1, "Miguel Castro", "Lenovo", "Ana Soto: +56224023025", "Rosa Castro: +56224023026", "mcastro@lenovo.com", "Computación"),
				(2, "Maria Guzmán","Phillips", "Sara Ceballos: +56224023041", "Camila Diaz: +56224023042", "mguz@phillips.com", "Audio"),
			    (3, "Rodrigo Cid","LG", "Mario Fica: +56224023083", "Lorena Midea: +56224023084", "rcid@lg.com", "Televisión"),
                (4, "Guillermo Ahumada", "Mademsa", "Manuel Vilches: +56224023095", "Mario Gatica: +56224023096", "gah@mademsa.cl", "Electrodomésticos"),
                (5, "Andrea Flores","Samsung", "Valeria Puga: +56224023071", "Luis Saa: +56224023072", "afl@samsung.com", "Celulares");

#Ver los registros cargados a la tabla proveedor
SELECT * FROM proveedor;

#Agregar 10 productos a la tabla productos
INSERT INTO productos(Id_producto, Nombre, Stock, Precio, Color, Categoria, Proveedor)
         VALUES(1, "Laptop Ideapad 4", 5, 490000, "negro", "Computación", 1),
			   (2, "Audifonos bluetooh",25,29990,"blanco", "Audio", 2),
			   (3, "Smart TV LG 29 pulg",15,219990,"plateado", "Televisión", 3),
               (4,"Laptop yoga 7",10, 650000,"negro", "Computación", 1),
               (5,"Audifonos overear", 25, 10000, "blanco", "Audio", 2),
			   (6, "Laptop Ideapad 3",5, 299990,"negro", "Computación", 1),
			   (7, "Smart TV LG 50 pulg",15,329990,"plateado", "Televisión", 3),
               (8, "Horno electrico 60Lts",28, 79990,"negro", "Electrodomésticos", 4),
               (9, "Smartphone A31",15,220000, "azul", "Celulares", 5),
               (10,"Smathphone A11", 12,150000, "rosado", "Celulares", 5);

#Ver los registros cargados a la tabla
SELECT * FROM productos;
               
#Cuál es la categoría de productos que más se repite.
SELECT categoria as categoria_mas_repetida, count(categoria) as veces_repetida FROM productos GROUP BY categoria_mas_repetida ORDER BY veces_repetida DESC limit 1; 

#Cuáles son los productos con mayor stock(Top 3 de productos con mayor stock)
SELECT nombre as Productos_mayor_stock,stock FROM productos GROUP BY Productos_mayor_stock ORDER BY stock DESC limit 3;

#Qué color de producto es más común en nuestra tienda.
SELECT color as color_mas_comun, count(color)as veces_repetido FROM productos GROUP BY color_mas_comun ORDER BY veces_repetido DESC limit 1;

#Cuál o cuales son los proveedores con menor stock de productos.
SELECT Proveedor as proveedor_menor_stock, Sum(stock) as total_stock_productos FROM productos GROUP BY proveedor_menor_stock ORDER BY total_stock_productos ASC limit 1;

#Por último:

#Cambien la categoría de productos más popular por ‘Electrónica y computación’.

START transaction;
SET AUTOCOMMIT=0;
SET SQL_SAFE_UPDATES=0;

#Ver las tablas antes de la actualización
SELECT * FROM productos;
SELECT * FROM proveedor;

#Actualización de la categoría más popular
UPDATE proveedor SET categoria = "Electrónica y computación" 
where id_proveedor=1;

#Ver los cambios aplicados a la tabla
SELECT * FROM productos;
SELECT * FROM proveedor;

#Deshacer los cambios si no funciona.
ROLLBACK;
#Si la actualización fue exitosa, confirmar el cambio.
SET autocommit=1;