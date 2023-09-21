/*Para los precios, podemos pensar en utilizar numeric que es mas preciso*/

-- CREACIÓN DE LA BASE DE DATOS
DROP DATABASE IF EXISTS Zapateria;
CREATE DATABASE Zapateria;
USE Zapateria;
-- ------------------------------------------------------------------------------------------
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
	gama varchar (20) NOT NULL ,
	Descripcion varchar(100) ,
    PRIMARY KEY (gama) 
);


CREATE TABLE Area (
	area char (3) NOT NULL ,
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
	codigo_cliente int NOT NULL ,
	nombre varchar(20),
	apellido1 varchar(20),
	apellido2 varchar(20),
	email varchar(50) check (email like '%@%'), /*Si tira error aca, ponerlo abajo de todo, junto con las pk y fk o buscar otra syntax 													aca: https://www.w3schools.com/sql/sql_check.asp*/
	telefono int,
	codigo_sucursal int NOT NULL ,
	PRIMARY KEY (codigo_cliente),
	FOREIGN KEY (codigo_sucursal) REFERENCES Sucursal(codigo_sucursal) on update cascade on delete cascade 
);

CREATE TABLE Empleado (
	codigo_empleado int NOT NULL,
	nombre varchar(20) not null,
	apellido1 varchar(20) not null,
	apellido2 varchar(20),
	telefono int,
	email varchar(50) check (email like '%@%'),
	puesto varchar (20) not null,
	fechaAlta date default null, 
	fechaBaja date,
	calle_direccion varchar(50),
	numero_direccion int,	
	piso int,
	letra char(1),
	codigo_jefe int default null,
	codigo_sucursal int not null ,
	PRIMARY KEY (codigo_empleado),
	FOREIGN KEY (codigo_jefe) REFERENCES Empleado(codigo_empleado) on update cascade on delete cascade ,
	FOREIGN KEY (codigo_sucursal) REFERENCES Sucursal(codigo_sucursal) on update cascade on delete cascade 
);


CREATE TABLE Pedido (
	codigo_pedido int not null,
	fecha_pedido date, 
	fecha_entregado date default null,
	observaciones varchar (100),
	fecha_envioEstimado date,
	codigo_cliente int NOT NULL ,
	codigo_empleado	int NOT NULL ,
	codigo_estado int NOT NULL ,
	codigo_medio_de_pago int NOT NULL ,
	PRIMARY KEY (codigo_pedido),
	FOREIGN KEY (codigo_cliente) REFERENCES Cliente (codigo_cliente) on update cascade on delete cascade ,	
	FOREIGN KEY (codigo_empleado) REFERENCES Empleado (codigo_empleado) on update cascade on delete cascade ,	
	FOREIGN KEY (codigo_estado) REFERENCES Estado_Pedido (codigo_estado) on update cascade on delete cascade ,	
	FOREIGN KEY (codigo_medio_de_pago) REFERENCES Medios_de_pago (codigo_medio_de_pago) on update cascade on delete cascade 
);


CREATE TABLE Detalle_Pedido (
	codigo_producto int NOT NULL ,
	codigo_reparacion int NOT NULL ,
	codigo_pedido int NOT NULL ,
	cantidad int, 
	producto_precio_unidad decimal(7,2),
	reparacion_precio_servicio decimal(7,2),
	foreign key (codigo_producto) references Producto (codigo_producto) on update cascade on delete cascade ,	
	foreign key (codigo_reparacion) references Reparacion (codigo_reparacion) on update cascade on delete cascade ,	
	foreign key (codigo_pedido) references Pedido (codigo_pedido) on update cascade on delete cascade 
);


-- ------------------------------------------------------------------------------------------
-- Inserts
INSERT INTO Sucursal(Localidad, Ciudad, codigo_postal, telefono, numero_direccion, calle_direccion) VALUES
						("Monte Castro","Ciudad Autonoma de Buenos Aires","C1407",2857463857,2299,"Marcos Paz"),
						("Boedo","Ciudad Autonoma de Buenos Aires","C1250 ",1123678954,1101,"Castro"),
						("San Cristóbal","Ciudad Autonoma de Buenos Aires","C1253,",9800175643,1099,"Pasco");


INSERT INTO Gama VALUES ("ID","Infante deportivo"),
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
                        
INSERT INTO Area VALUES ("MAR","Marroquineria"),
						("VAL","Valijero"),
                        ("ZAP","Zapatero");
                        
INSERT INTO Producto(nombre, proveedor, descripcion, cantidad_en_stock, precio_venta, precio_proveedor, gama) VALUES
						("Air Jordan Low Homage","Nike","Tremendas zapas",100,5000,2000,"AD"),
                        ("Air Huarache Moov","Nike","Comodas y perfectas para el gimnasio",40,3000,1500,"AD"),
                        ("Borcego Holden","Briganti","Minimalistas",10,20000,400,"B"),
                        ("Australian Boots","Tascani","Rosa y afelpadas",50,19000,2000,"B.A."),
                        ("Mocasin Marrón","Tascani","Elegantes",1,500,200,"M"),
                        ("Mocasin Brito","Tascani","Elegantes",20,5000,2000,"M"),
                        ("Tacones High","Gucci","Finos",600,1950000,20000000,"T"),
                        ("Tacones Deihm","Gucci","Finos",15,40000,2000,"T"),
                        ("Zapatos Negros","Prada","Simples y humildes",1,100,40,"ZV"),
                        ("Zapatos Jaine","Prada","Simples y humildes",100,50,12,"ZV");

INSERT INTO Reparacion(precio_servicio, descripcion, area) VALUES (2000, "Costura Black", "ZAP"),
																  (2000, "Parche", "ZAP"),
                                                                  (2000, "Cambio de base", "ZAP"),
                                                                  (2000, "Cambio de taco", "ZAP"),
                                                                  (2000, "Cambio de cierre", "MAR"),
                                                                  (2000, "Ajuste de cintura", "MAR"),
                                                                  (2000, "Cambio de velcro", "MAR");

                        
                        
