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

