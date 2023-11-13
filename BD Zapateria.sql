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

