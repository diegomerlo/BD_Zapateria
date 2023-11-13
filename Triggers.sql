-- Trigger que valida que los datos ingresados a la tabla Gama no puedan ser ingresados como NULL
DELIMITER //
CREATE TRIGGER ValidacionPreviaGama
BEFORE INSERT ON Gama
FOR EACH ROW
BEGIN
      IF NEW.gama IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La columna no puede ser nula';
    END IF;
END;
//
DELIMITER ;



-- Trigger que registra que usuario actualiza la tabla Sucursal
CREATE TABLE Registro_De_Usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario VARCHAR(255),
    fecha TIMESTAMP,
    accion VARCHAR(50),
    detalles TEXT
);



DELIMITER //
CREATE TRIGGER AfterNombreUsuario
AFTER UPDATE ON Sucursal 
FOR EACH ROW
BEGIN
    INSERT INTO auditoria (usuario, fecha, accion, detalles)
    VALUES (USER(), NOW(), 'UPDATE', CONCAT('Se actualizó la fila con ID ', NEW.codigo_sucursal));
END;
//
DELIMITER ;


