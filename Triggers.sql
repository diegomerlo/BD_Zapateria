-- Trigger que valida que los datos ingresados a la tabla Gama para que no puedan ser ingresados como NULL
DELIMITER //
CREATE TRIGGER ValidacionPreviaGama
BEFORE INSERT ON Gama
FOR EACH ROW
BEGIN
      IF NEW.gama IS NULL THEN
        SIGNAL SQLSTATE '45000' -- “unhandled user-defined exception.” 
        SET MESSAGE_TEXT = 'La columna no puede ser nula';
    END IF;
END;
//
DELIMITER ;



-- Trigger que registra que usuario actualiza la tabla Sucursal. En la tabla Registro_De_Usuarios se guarda la información relacionada al usuario
-- que realizó una actualización en la tabla Sucursal. Se guarda el nombre, la fecha en la que se realizó el UPDATE , que fila modificó y el nuevo codigo_sucursal
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


