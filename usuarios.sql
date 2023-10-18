#Crear usuario Gerente, que puede realizar modificaciones solamente en la tabla de las sucursales
CREATE USER IF NOT EXISTS 'Gerente'@'localhost' IDENTIFIED BY 'contrasena';
GRANT SELECT, INSERT, UPDATE, DELETE ON zapateria.sucursal TO 'Gerente'@'localhost';
