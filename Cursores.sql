-- Suma el precio de todos los productos y los muestra, el handler se encarga de tratar el error al finalizar la lectura del cursor a traves de un booleano
drop procedure if exists suma_productos;
DELIMITER //

CREATE PROCEDURE suma_productos(OUT preciototal INTEGER)
BEGIN
    DECLARE suma INTEGER;
    DECLARE precios INTEGER;
    DECLARE terminar INT DEFAULT 0;

    DECLARE c CURSOR FOR SELECT precio_venta FROM Producto;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET terminar = 1;

    SET suma = 0;

    OPEN c;

    read_loop: LOOP
        FETCH c INTO precios;
        IF terminar = 1 THEN
            LEAVE read_loop;
        END IF;

        SET suma = suma + precios;
    END LOOP;

    CLOSE c;

    SET preciototal = suma;
END//

DELIMITER ;





drop procedure if exists buscar_valores;
DELIMITER //

CREATE PROCEDURE buscar_valores(IN valor INTEGER)
    
    BEGIN
		DECLARE precios INTEGER;
        DECLARE terminar INT DEFAULT 0;

        DECLARE c CURSOR FOR SELECT reparacion_precio_servicio FROM detalle_pedido WHERE reparacion_precio_servicio > valor;
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET terminar = 1;
    
        CREATE TEMPORARY TABLE valores (
                valor_aux int
            );




            OPEN c;

            read_loop: LOOP
                FETCH c INTO precios;
            INSERT INTO valores (valor_aux) VALUES (precios);
                IF terminar = 1 THEN
                    LEAVE read_loop;
                END IF;
            END LOOP;

            CLOSE c;

            SELECT valor_aux AS "Precios de Venta" FROM valores;
        	
            DROP TEMPORARY TABLE valores;

    END//

DELIMITER ;

CALL buscar_valores(160);



