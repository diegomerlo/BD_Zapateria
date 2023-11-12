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
