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
        (20230920,NULL,'Sin apuro',20231015,7,7,1,'EFE'),
	(20230925,NULL,'Sin apuro',20231002,7,7,1,'EFE'),
	(20230926,NULL,'Sin apuro',20231010,7,7,1,'EFE'),
	(20230930,NULL,'Sin apuro',20231020,7,7,1,'EFE');
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
