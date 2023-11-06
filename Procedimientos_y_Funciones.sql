#Función que devuelve el precio de la reparación indicando su codigo id;
DELIMITER //
CREATE OR REPLACE FUNCTION precio(id INT)
RETURNS INT
BEGIN
	RETURN (SELECT precio_servicio 
            FROM reparacion r
            WHERE r.codigo_reparacion=id);
END//
DELIMITER ;
#_________________________________________________________________________________________________________________________________
#Funcion que devuelve el precio de un producto con un porcentaje de descuento aplicado
DELIMITER //
CREATE OR REPLACE FUNCTION descuento(id INT, porcentaje INT)
RETURNS INT
BEGIN
	DECLARE descuento INT;
    DECLARE precio INT;
    SET precio = (SELECT precio_servicio 
            	  FROM reparacion r
            	  WHERE r.codigo_reparacion=id);
	SET descuento = (porcentaje/100) * precio;
    
	RETURN (precio - descuento);
END//
DELIMITER ;

SELECT r.*, descuento(r.codigo_reparacion,50) FROM reparacion r;
#_________________________________________________________________________________________________________________________________
#Procedimiento que cambia el stock de un producto especifico 
	#Se indica el ID del producto y la cantidad que se sumará o restará al stock.
	#Mediante el 3er parámetro se indica si se está llenando o vaciando el stock, así es reutilizable el PROCEDURE.
	#En caso de que se quiera restar una cantidad mayor de la cual hay en el stock, se omite la operación y se mantiene el antiguo stock
DROP PROCEDURE IF EXISTS modificarStock;
DELIMITER //
CREATE OR REPLACE PROCEDURE modificarStock(idProducto INT, cantidadCambio INT, accion VARCHAR(50))
BEGIN
	DECLARE oldStock INT;
    DECLARE newStock INT;
    
    SET oldStock=(SELECT cantidad_en_stock FROM producto WHERE codigo_producto=idProducto);
    
    IF accion IN("mas", "+", "sumar", "aumentar", "llenar", "rellenar", "poner") THEN
    	SET newStock = oldStock + cantidadCambio;
	ELSEIF accion IN("menos", "-", "restar", "disminuir", "vaciar", "sacar") THEN
    	IF oldStock>=cantidadCambio THEN
			SET newStock = oldStock - cantidadCambio;
        ELSE
        	SET newStock = oldStock;
        END IF;    
	END IF;
    
    
    UPDATE producto p SET p.cantidad_en_stock = newStock WHERE codigo_producto=idProducto;
    SELECT * FROM producto;
END//
DELIMITER ;

CALL modificarStock(2, 465, "mas");
#_________________________________________________________________________________________________________________________________
#Procedimiento que inserta registros en la tabla Detalle_Pedido respetando la integridad referencial que tiene con las tablas con las cuales esta conectada
DROP PROCEDURE IF EXISTS insertsDetalle_Pedido;
DELIMITER //
CREATE PROCEDURE insertsDetalle_Pedido()
BEGIN
    DECLARE contaidor INT;
    DECLARE cantidad_registros INT;
    DECLARE cantidad_de_productos INT;
    DECLARE cantidad_de_reparaciones INT;
    DECLARE cantidad_de_pedidos INT;

    SET contaidor = 1;
    SET cantidad_registros = 5;

    SET cantidad_de_productos = (SELECT COUNT(*) FROM Producto);
    SET cantidad_de_reparaciones = (SELECT COUNT(*) FROM Reparacion);
    SET cantidad_de_pedidos = (SELECT COUNT(*) FROM Pedido);

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

    WHILE contaidor <= cantidad_registros DO
        INSERT INTO Detalle_Pedido (codigo_producto, codigo_reparacion, codigo_pedido, cantidad, producto_precio_unidad,
            reparacion_precio_servicio)
        VALUES (contaidor, contaidor, contaidor, (contaidor * 2), (SELECT precio_venta FROM Producto WHERE codigo_producto = contaidor),
            (SELECT precio_servicio FROM Reparacion WHERE codigo_reparacion = contaidor));
        SET contaidor = contaidor + 1;
    END WHILE;
END //
DELIMITER ;


