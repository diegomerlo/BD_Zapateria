#Crear usuario Gerente, que puede realizar modificaciones solamente en la tabla de las sucursales
CREATE USER IF NOT EXISTS 'Gerente'@'localhost' IDENTIFIED BY 'contrasena';
GRANT SELECT, INSERT, UPDATE, DELETE ON zapateria.sucursal TO 'Gerente'@'localhost';

#Crear usuario Contador, que puede realizar modificaciones solamente en la vista de determinador pagos hechos con mercado pago
CREATE USER IF NOT EXISTS 'Contador'@'localhost' IDENTIFIED BY '0000';
GRANT SELECT, UPDATE ON zapateria.mercado_pago TO 'Contador'@'localhost';

#Crear usuario Jefe, que puede revisar la vista que solamente tiene a los empleados que no han sido dados de baja (que no han sido echados)
CREATE USER IF NOT EXISTS 'Jefe'@'localhost' IDENTIFIED BY 'JEFE';
GRANT SELECT ON zapateria.empleados_actuales TO 'Jefe'@'localhost';

#Demostracion de usuarios: 
#mysql -u Gerente -p contrasena
#mysql -u Contador -p 0000
#mysql -u Jefe -p JEFE
#SHOW DATABASES;
#USE zapateria;
#SHOW TABLES;
#SELECT * FROM empleado;
