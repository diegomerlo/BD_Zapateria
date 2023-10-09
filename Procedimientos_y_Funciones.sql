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

