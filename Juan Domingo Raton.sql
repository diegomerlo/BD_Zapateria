-- ____________________________________________________________________________________________
-- CREACIÓN DE LA BASE DE DATOS
DROP DATABASE IF EXISTS Zapateria;
CREATE DATABASE Zapateria;
USE Zapateria;
-- ____________________________________________________________________________________________
-- CREACIÓN DE TABLAS
CREATE TABLE Sucursal (
	codigo_sucursal int NOT NULL AUTO_INCREMENT,
	Localidad varchar(50),
	Ciudad varchar(50),
	codigo_postal varchar(5),																										
	telefono int,
	numero_direccion int,
	calle_direccion varchar(50),	
	PRIMARY KEY (codigo_sucursal) 
);


CREATE TABLE Gama (
	gama varchar(20) NOT NULL ,
	Descripcion varchar(100) ,
    PRIMARY KEY (gama) 
);


CREATE TABLE Area (
	area char(3) NOT NULL ,
	Descripcion varchar(100) ,
	PRIMARY KEY (Area) 
);


CREATE TABLE Producto (
	codigo_producto int NOT NULL AUTO_INCREMENT,
	nombre varchar(20),
	proveedor varchar(20),
	descripcion varchar(100),
	cantidad_en_stock int,
	precio_venta decimal(7,2), 
	precio_proveedor decimal(7,2), 
	gama varchar (20) NOT NULL ,
	PRIMARY KEY (codigo_producto),
	FOREIGN KEY (gama) REFERENCES Gama(gama) on update cascade on delete cascade 
);


CREATE TABLE Reparacion (
	codigo_reparacion int NOT NULL AUTO_INCREMENT,
	precio_servicio int,
	descripcion varchar(100),
	area char (3) NOT NULL ,
	PRIMARY KEY (codigo_reparacion),
	FOREIGN KEY (area) REFERENCES Area(area) on update cascade on delete cascade 
);


CREATE TABLE Estado_Pedido(
	codigo_estado int NOT NULL AUTO_INCREMENT,
	descripcion varchar(100) not null,
	PRIMARY KEY (codigo_estado)
);


CREATE TABLE Medios_de_pago(
	codigo_medio_de_pago char(3) NOT NULL ,
	descripcion varchar(100),
	PRIMARY KEY (codigo_medio_de_pago)
);


CREATE TABLE Cliente (
	codigo_cliente INT AUTO_INCREMENT,
	nombre varchar(20),
	apellido1 varchar(20),
	apellido2 varchar(20),
	email varchar(50) CHECK (email LIKE '%@%'), /*Si tira error aca, ponerlo abajo de todo, junto con las pk y fk o buscar otra syntax 													aca: https://www.w3schools.com/sql/sql_check.asp*/
	telefono varchar(30),
	codigo_sucursal int NOT NULL,
	PRIMARY KEY (codigo_cliente),
	FOREIGN KEY (codigo_sucursal) REFERENCES Sucursal(codigo_sucursal) ON UPDATE CASCADE ON DELETE CASCADE 
);


CREATE TABLE Empleado (
	codigo_empleado INT AUTO_INCREMENT,
	nombre varchar(20) NOT NULL,
	apellido1 varchar(20) NOT NULL,
	apellido2 varchar(20),
	telefono varchar(30),
	email varchar(50) CHECK (email like '%@%'),
	puesto varchar (20) NOT NULL,
	fecha_Alta date NOT NULL, 
	fecha_Baja date DEFAULT NULL,
	calle_direccion varchar(50),
	numero_direccion int,	
	piso int,
	letra char(1),
	codigo_jefe int DEFAULT NULL,
	codigo_sucursal int NOT NULL,
	PRIMARY KEY (codigo_empleado),
	FOREIGN KEY (codigo_jefe) REFERENCES Empleado(codigo_empleado) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (codigo_sucursal) REFERENCES Sucursal(codigo_sucursal) ON UPDATE CASCADE ON DELETE CASCADE 
);


CREATE TABLE Pedido (
	codigo_pedido int AUTO_INCREMENT,
	fecha_pedido date, 
	fecha_entregado date default null,
	observaciones varchar (100),
	fecha_envioEstimado date,
	codigo_cliente int NOT NULL,
	codigo_empleado	int NOT NULL,
	codigo_estado int NOT NULL,
	codigo_medio_de_pago char (3) NOT NULL,
	PRIMARY KEY (codigo_pedido),
	FOREIGN KEY (codigo_cliente) REFERENCES Cliente (codigo_cliente) ON UPDATE CASCADE ON DELETE CASCADE,	
	FOREIGN KEY (codigo_empleado) REFERENCES Empleado (codigo_empleado) ON UPDATE CASCADE ON DELETE CASCADE,	
	FOREIGN KEY (codigo_estado) REFERENCES Estado_Pedido (codigo_estado) ON UPDATE CASCADE ON DELETE CASCADE,	
	FOREIGN KEY (codigo_medio_de_pago) REFERENCES Medios_de_pago (codigo_medio_de_pago) ON UPDATE CASCADE ON DELETE CASCADE 
);


CREATE TABLE Detalle_Pedido (
	codigo_producto int NOT NULL,
	codigo_reparacion int NOT NULL,
	codigo_pedido int NOT NULL,
	cantidad int, 
	producto_precio_unidad decimal(7,2),
	reparacion_precio_servicio decimal(7,2),
	foreign key (codigo_producto) references Producto (codigo_producto) ON UPDATE CASCADE ON DELETE CASCADE,	
	foreign key (codigo_reparacion) references Reparacion (codigo_reparacion) ON UPDATE CASCADE ON DELETE CASCADE,
	foreign key (codigo_pedido) references Pedido (codigo_pedido) ON UPDATE CASCADE ON DELETE CASCADE
);

-- ____________________________________________________________________________________________
-- ____________________________________________________________________________________________
-- INSERTS

-- ------------------------------------------------------------------------------------------
#Sucursal
INSERT INTO Sucursal(Localidad, Ciudad, codigo_postal, telefono, numero_direccion, calle_direccion)
VALUES	("Monte Castro","Ciudad Autonoma de Buenos Aires","C1407",2857463857,2299,"Marcos Paz"),
		("Boedo","Ciudad Autonoma de Buenos Aires","C1250 ",1123678954,1101,"Castro"),
		("San Cristóbal","Ciudad Autonoma de Buenos Aires","C1253,",9800175643,1099,"Pasco");
-- ------------------------------------------------------------------------------------------
# Gama
INSERT INTO Gama
VALUES	("ID","Infante deportivo"),
		("NoD","Niño Deportivo"),
		("NaD","Niña Deportiva"),
		("AD","Adulto Deportivo"),
		("HD","Hombre Deportivo"),
		("MD","Mujer Deportiva"),
		("ZV","Zapatos de vestir"),
		("M", "Mocasín"),
		("B", "Borcegos"),
		("B.A.", "Botas Australianas"),
        ("T", "Tacones");
-- ------------------------------------------------------------------------------------------
# Area
INSERT INTO Area
VALUES 	("MAR","Marroquineria"),
		("VAL","Valijero"),
		("ZAP","Zapatero");
-- ------------------------------------------------------------------------------------------
# Producto
INSERT INTO Producto(nombre, proveedor, descripcion, cantidad_en_stock, precio_venta, precio_proveedor, gama)
VALUES	("Air Jordan Low Homage","Nike","Tremendas zapas",100,5000,2000,"AD"),
		("Air Huarache Moov","Nike","Comodas y perfectas para el gimnasio",40,3000,1500,"AD"),
		("Borcego Holden","Briganti","Minimalistas",10,20000,400,"B"),
		("Australian Boots","Tascani","Rosa y afelpadas",50,19000,2000,"B.A."),
		("Mocasin Marrón","Tascani","Elegantes",1,500,200,"M"),
		("Mocasin Brito","Tascani","Elegantes",20,5000,2000,"M"),
		("Tacones High","Gucci","Finos",600,1950000,20000000,"T"),
		("Tacones Deihm","Gucci","Finos",15,40000,2000,"T"),
		("Zapatos Negros","Prada","Simples y humildes",1,100,40,"ZV"),
		("Zapatos Jaine","Prada","Simples y humildes",100,50,12,"ZV");
-- ------------------------------------------------------------------------------------------
# Reparación
INSERT INTO Reparacion(precio_servicio, descripcion, area)
VALUES 	(2000, "Costura Black", "ZAP"),
		(150, "Parche", "ZAP"),
		(1000, "Cambio de base", "ZAP"),
		(50000, "Cambio de taco", "ZAP"),
		(15000, "Cambio de cierre", "MAR"),
		(10, "Ajuste de cintura", "MAR"),
		(80, "Cambio de velcro", "MAR");              
-- ------------------------------------------------------------------------------------------
# Cliente
INSERT INTO Cliente(nombre, apellido1, apellido2, email, telefono, codigo_sucursal)
VALUES	("Agustín", "Salgueiro", "", "buchitosalgueiro@gmail.com", "11 7702-4004", 1),
		("Mikel", "Taberna", "", "mikeltaberna05@gmail.com", "11 63516146", 1),
		("Diego", "Merlo", "", "diego.e.merlo@gmail.com", "44445555", 1),
		("Filiberto", "Lopez", "", "FiliElGanador@gmail.com", "11 54671823", 2),
		("Florencia", "Diaz", "", "Flor03@gmail.com", "11 43567689", 2),
		("Guadalupe", "Perez", "", "Guada123@gmail.com", "11 22990234", 2),
		("Jimena", "Alvarez", "", "Jime420@gmail.com", "11 34674389", 3),
		("Roberto", "Iglesias", "", "RoberI@gmail.com", "11 99558822", 3),
		("Pedro", "Piedra", "", "PedroPicaPiedra@gmail.com", "11 85723948", 3),
		("Norma", "Rene", "Elena", "Normi060@gmail.com", "11 4356 9384", 3);

-- ------------------------------------------------------------------------------------------
# Empleado
INSERT INTO Empleado(nombre, apellido1, apellido2, telefono, email, puesto, fecha_Alta, fecha_Baja, calle_direccion, 
                     numero_direccion, piso, letra, codigo_jefe, codigo_sucursal)
VALUES	("Jorge", "Pagani", "Jáuregui", "2 5611-1380", "pagani.high2012@gmail.com", "Jefe Sucursal", "2015-12-17", NULL, "Av. Remedios de Escalada de San Martín", 2486, 7, "A", NULL, 1),
		("Juan", "Gonzalez", "", "8850 9636", "juancho.gonzalez@gmail.com", "Empleado", "2019-12-20", NULL, "Caracas", 639, 0, "", NULL, 1),
		("Clara", "Garcia", "", "9922 1243", "claru@gmail.com", "Empleado", "2018-4-19", NULL, "Joaquín V. González", 1111, 2, "B", NULL, 1),
		("Martiniano", "Mollo", "", "1188 2288", "mollitooogd.gonzalez@gmail.com", "Jefe Sucursal", "2019-12-18", NULL, "Luis Viale", 2239, 2, "A", NULL, 2),
		("Lucas", "Trigo", "", "9485 1827", "HarinaDeTrigo@gmail.com", "Empleado", "2019-07-17", NULL, "Juan Agustín García", 999, 1, "B", NULL, 2),
		("Leandro", "Disotteo", "", "1166 6666", "Leaan@gmail.com", "Jefe Sucursal", "2019-01-19", NULL, "Segurola", 2678, 3, "B", NULL, 3),
        ("Ruben", "Hernandez", "", "8877 9933", "Ruben@gmail.com", "Empleado", "2015-06-23", NULL, "Irigoyen", 500, 1, "A", NULL, 3);
	


                   
-- ------------------------------------------------------------------------------------------
# Estado de Pedido:
INSERT INTO Estado_Pedido(codigo_estado, descripcion)
VALUES	("Pen", "Pendiente"),
		("Can", "Cancelado"),
		("Ent", "Entregado");
-- ------------------------------------------------------------------------------------------
# Medios de pago: 
INSERT INTO Medios_de_pago(codigo_medio_de_pago, descripcion)
VALUES	('EFE ', 'Efectivo'),
		('MEP', 'Mercado Pago'),
		('PBE', 'Pago con Banco Electrónico'),
		('VIS', 'Visa'),
		('MAS', 'Mastercard'),
		('AME', 'American Express');
-- ------------------------------------------------------------------------------------------
# Pedido: 
INSERT INTO Pedido (fecha_pedido , fecha_entregado,observaciones,fecha_envioEstimado,codigo_cliente,codigo_empleado,codigo_estado,codigo_medio_de_pago) 
VALUES 	(20230525,20230625,'Realizar Factura B',NULL,1,2,3,'MEP'),
		(20230612,20230615,'Agregar cordones de regalo',20230614,2,3,3,'EFE'),
        (20230613,20230620,NULL,20230618,3,2,3,'PBE'),
        (20230613,20230625,'Envio urgente',NULL,4,5,3,'VIS'),
        (20230615,NULL,'Realizar Factura A',NULL,5,5,2,'MEP'),
        (20230705,20230715,'Pegado Adelante',NULL,6,5,3,'EFE'),
        (20230925,NULL,'Sin apuro',20231015,7,7,1,'EFE')
        
        ,(20230925,NULL,'Sin apuro',20231015,7,7,1,'EFE'),(20230925,NULL,'Sin apuro',20231015,7,7,1,'EFE'),(20230925,NULL,'Sin apuro',20231015,7,7,1,'EFE')
        
        ;
-- ------------------------------------------------------------------------------------------
# Detalle Pedido:
DROP PROCEDURE IF EXISTS insertsDetalle_Pedido;
DELIMITER //
CREATE PROCEDURE insertsDetalle_Pedido()
BEGIN
	DECLARE cont INT;
	DECLARE cantidad_registros INT;
	DECLARE cantidad_de_productos INT;
	DECLARE cantidad_de_reparaciones INT;
	DECLARE cantidad_de_pedidos INT;

	SET cont = 1;
	SET cantidad_registros = 5;
	
	SET cantidad_de_productos = (SELECT COUNT(*) FROM Producto);
	SET cantidad_de_reparaciones = (SELECT COUNT(*) FROM Reparacion);
	SET cantidad_de_pedidos =	(SELECT COUNT(*) FROM Pedido);
        
	IF cantidad_de_productos < cantidad_de_reparaciones THEN
		IF cantidad_de_productos <= cantidad_de_pedidos THEN
	            SET cantidad_registros = cantidad_de_productos;
	        END IF;  
	ELSEIF cantidad_de_reparaciones < cantidad_de_productos THEN
	      	IF cantidad_de_reparaciones <= cantidad_de_pedidos THEN
	            SET cantidad_registros = cantidad_de_reparaciones;
	        END IF;
	ELSEIF cantidad_de_pedidos < cantidad_de_productos THEN
	    	IF cantidad_de_pedidos <= cantidad_de_reparaciones THEN
	            SET cantidad_registros = cantidad_de_pedidos;
	        END IF;  
	END IF;		       
        
    	WHILE cont <= cantidad_registros DO
    		INSERT INTO Detalle_Pedido (codigo_producto, codigo_reparacion, codigo_pedido, cantidad, producto_precio_unidad,
                                    reparacion_precio_servicio) 
		VALUES (cont, cont, cont, (cont*2), (SELECT precio_venta FROM Producto WHERE codigo_producto=cont),
                							(SELECT precio_servicio FROM Reparacion WHERE codigo_reparacion=cont));
        	SET cont = cont + 1;
	END WHILE;
	
END //
DELIMITER ;
CALL insertsDetalle_Pedido();
