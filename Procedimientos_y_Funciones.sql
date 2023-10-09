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
