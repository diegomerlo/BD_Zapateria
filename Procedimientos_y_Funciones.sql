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
	#(HAY QUE SOLUCIONAR UN ERROR)
DROP PROCEDURE IF EXISTS modificarStock;
DELIMITER //
CREATE OR REPLACE PROCEDURE modificarStock(idProducto INT, cantidadCambio INT, accion VARCHAR(50))
BEGIN
	DECLARE oldStock INT;
    DECLARE newStock INT;
    
    SET oldStock=(SELECT cantidad_en_stock FROM producto WHERE codigo_producto=idProducto);
    
    IF accion IS IN("mas", "+", "sumar", "aumentar", "llenar", "rellenar", "poner") THEN
    	SET newStock = oldStock + cantidadCambio;
	ELSEIF accion IS IN("menos", "-", "restar", "disminuir", "vaciar", "sacar") THEN         
		SET newStock = oldStock - cantidadCambio;
	END IF;
    
    SELECT newStock;
END//
DELIMITER ;

CALL modificarStock(1, 10, "mas");


