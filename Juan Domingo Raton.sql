/*Para los precios, podemos pensar en utilizar numeric que es mas preciso*/

-- CREACIÓN DE LA BASE DE DATOS
DROP DATABASE IF EXISTS Zapateria;
CREATE DATABASE Zapateria;

use Zapateria;

-- CREACIÓN DE TABLAS
CREATE TABLE Sucursal (
codigo_sucursal int NOT NULL ,
Localidad varchar(50),
Ciudad varchar(50),
codigo_postal varchar(5),
telefono int,
numero_direccion int,
calle_direccion varchar(50),	
PRIMARY KEY (codigo_sucursal) 
);





create table Gama (
gama varchar (20) NOT NULL ,
Descripcion varchar(100) ,
PRIMARY KEY (gama) 
);



create table Area (
area char (3) NOT NULL ,
Descripcion varchar(100) ,
PRIMARY KEY (Area) 
);



create table Producto (
codigo_producto int NOT NULL ,
nombre varchar(20),
proveedor varchar(20),
descripcion varchar(100),
cantidad_en_stock int,
precio_venta decimal(7,2), 
precio_proveedor decimal(7,2), 
gama varchar (20) NOT NULL ,
PRIMARY KEY (codigo_producto),
FOREIGN KEY (gama) references
Gama(gama));



create table Reparacion (
codigo_reparacion int NOT NULL ,
precio_servicio int,
descripcion varchar(100),
area char (3) NOT NULL ,
	PRIMARY KEY (codigo_reparacion),
	FOREIGN KEY (area) references
Area(area));




create table Estado_Pedido(
codigo_estado int NOT NULL ,
	descripcion varchar(100) not null,
	PRIMARY KEY (codigo_estado)
);




create table Medios_de_pago(
codigo_medio_de_pago int NOT NULL ,
	descripcion varchar(100),
	PRIMARY KEY (codigo_medio_de_pago)
);






create table Cliente (
codigo_cliente int NOT NULL ,
nombre varchar(20),
apellido1 varchar(20),
apellido2 varchar(20),
email varchar(50) check (email like '%@%'), /*Si tira error aca, ponerlo abajo de todo, junto con las pk y fk o buscar otra syntax aca: https://www.w3schools.com/sql/sql_check.asp*/
telefono int,
codigo_sucursal int NOT NULL ,
	PRIMARY KEY (codigo_cliente),
	FOREIGN KEY (codigo_sucursal) references
Sucursal(codigo_sucursal));

create table Empleado (
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
	FOREIGN KEY (codigo_jefe) references
Empleado(codigo_empleado),
FOREIGN KEY (codigo_sucursal) references
Sucursal(codigo_sucursal)
);




create table Pedido (
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
	foreign key (codigo_cliente) references Cliente (codigo_cliente),	
	foreign key (codigo_empleado) references Empleado (codigo_empleado),	
	foreign key (codigo_estado) references Estado_Pedido (codigo_estado),	
	foreign key (codigo_medio_de_pago) references Medios_de_pago (codigo_medio_de_pago));
	
	

	
	
	create table Detalle_Pedido (
	codigo_producto int NOT NULL ,
	codigo_reparacion int NOT NULL ,
	codigo_pedido int NOT NULL ,
	cantidad int, 
	producto_precio_unidad decimal(7,2),
	reparacion_precio_servicio decimal(7,2),
	foreign key (codigo_producto) references Producto (codigo_producto),	
	foreign key (codigo_reparacion) references Reparacion (codigo_reparacion),	
	foreign key (codigo_pedido) references Pedido (codigo_pedido));
	
-- Inserts





insert into Sucursal values (1,"Monte Castro","Ciudad Autonoma de Buenos Aires","C1407",2857463857,2299,"Marcos Paz");
insert into Sucursal values (2,"Boedo","Ciudad Autonoma de Buenos Aires","C1250 ",1123678954,1101,"Castro");
insert into Sucursal values (3,"San Cristóbal","Ciudad Autonoma de Buenos Aires","C1253,",9800175643,1099,"Pasco");





--
insert into Gama values ("","",);





insert into Area values ("","",);





insert into Producto values (,"","","",,,,"");








insert into Reparacion values (,,"","");












insert into Estado_Pedido values (,"");






insert into Medios_de_pago values (,"");









insert into Cliente values (,"","","","",,);













insert into Empleado values (,"","","",,"","",'','',"",,,"",,);









insert into Pedido values (,'','',"",'',,,,);







insert into Detalle_Pedido values (,,,,,);
