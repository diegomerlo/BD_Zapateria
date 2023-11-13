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

		CREATE TEMPORARY TABLE valores (
        columna1 tipo_dato1,
        columna2 tipo_dato2
        -- Puedes agregar más columnas según sea necesario
    );

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

