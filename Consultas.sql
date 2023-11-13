/*------------------Operadores Lógicos------------------*/

#Devuelve el nombre de los productos cuyo precio de venta al público se encuentre entre los $2000 y los $5000
SELECT p.nombre AS Nombre FROM producto p WHERE p.precio_venta BETWEEN 2000 AND 5000;

#Devuelve el nombre de los clientes cuyo nombre empiece con 'F'
SELECT c.nombre FROM cliente c WHERE c.nombre LIKE 'F%';

/*------------------Operadores de Fecha------------------*/

#Devuelve las fechas de los pedidos cuya estimación de envío sea enmarcada en el mes de octubre (mes 10)
SELECT p.fecha_pedido, p.fecha_entregado FROM pedido p WHERE MONTH(p.fecha_envioEstimado) = 10;

#Devuelve las fechas de los pedidos que sí o sí tengan 'fecha de envioEstimado' y que además,
#cuya diferencia entre la fecha en la que se hizo el pedido y la fecha en la que se estima que el envío llegue, supere los 15 días
SELECT p.fecha_pedido, p.fecha_entregado, DATEDIFF(p.fecha_envioEstimado,p.fecha_pedido) AS "Dias para la entrega"
FROM pedido p WHERE p.fecha_envioEstimado IS NOT NULL AND DATEDIFF(p.fecha_envioEstimado,p.fecha_pedido) > 15;

#Devuelve las fechas de los pedidos que sí o sí tengan 'fecha de envíoEstimado' y que además,
#cuya diferencia entre la fecha en la que se hizo el pedido y la fecha en la que se estima que el envío llegue, sea menor a los 15 días
SELECT p.fecha_pedido, p.fecha_entregado, DATEDIFF(p.fecha_envioEstimado,p.fecha_pedido) AS "Dias para la entrega"
FROM pedido p WHERE p.fecha_envioEstimado IS NOT NULL AND DATEDIFF(p.fecha_envioEstimado,p.fecha_pedido) < 15;

/*------------------Agrupación------------------*/
#Devuelve la cantidad de veces de los métodos de pago que hayan sido usados menos de 5 veces
SELECT COUNT(*) 'cantidad de veces', p.codigo_medio_de_pago
FROM pedido p
GROUP BY p.codigo_medio_de_pago
HAVING COUNT(p.codigo_medio_de_pago) < 5;

#Devuelve los empleados cuyas ventas sumen menos de 25000 
SELECT SUM(d.producto_precio_unidad) 'dinero total de productos vendidos',e.* FROM empleado e
INNER JOIN sucursal s ON e.codigo_sucursal=s.codigo_sucursal
INNER JOIN pedido p ON e.codigo_empleado=p.codigo_empleado
INNER JOIN detalle_pedido d ON p.codigo_pedido=d.codigo_pedido
GROUP BY e.codigo_empleado
HAVING SUM(d.producto_precio_unidad)<25000;


/*------------------Campos calculados (Count, Sum, Max, Min, Avg)------------------*/

#Devuelve la cantidad de clientes que hayan comprado en la sucursal 3
SELECT COUNT(*) FROM cliente C WHERE C.codigo_sucursal=3;

#Devuelve el promedio total de la plata obtenida tanto en los productos vendidos como en las reparaciones
SELECT AVG(D.producto_precio_unidad) Producto_avg, AVG(D.reparacion_precio_servicio) Servicio_avg FROM detalle_pedido D;

/*------------------Inner Join------------------*/

#Devuelve los clientes que hayan comprado un producto clasificado en la gama 'M' (mocasín)
SELECT c.* FROM cliente c
INNER JOIN pedido p ON c.codigo_cliente=p.codigo_cliente
INNER JOIN detalle_pedido d ON p.codigo_pedido=d.codigo_pedido
INNER JOIN producto pro ON d.codigo_producto=pro.codigo_producto
INNER JOIN gama g ON pro.gama=g.gama
WHERE g.gama='M';

#Devuelve las sucursales en las que se haya pagado con 'MEP' (MercadoPago)
SELECT s.* FROM sucursal s
INNER JOIN cliente c ON s.codigo_sucursal=c.codigo_sucursal
INNER JOIN pedido p ON c.codigo_cliente=p.codigo_cliente
INNER JOIN medios_de_pago m ON p.codigo_medio_de_pago=m.codigo_medio_de_pago
WHERE m.codigo_medio_de_pago='MEP';

/*------------------Order By------------------*/

SELECT dp.codigo_producto AS Codigo,dp.producto_precio_unidad AS Precio FROM detalle_pedido dp ORDER BY dp.producto_precio_unidad ASC;

SELECT e.nombre, e.fecha_Alta FROM empleado e ORDER BY e.fecha_Alta ASC;

/*------------------SubConsultas------------------*/

#Devuelve los empleados que hayan vendido pedidos
SELECT CONCAT(e.apellido1,' ',e.apellido2,', ',e.nombre) AS Nombre,e.puesto AS Puesto 
FROM empleado e 
WHERE e.codigo_empleado IN (SELECT codigo_empleado FROM pedido);


#Devuelve las sucursales cuyos pedidos facturados contengan servicios de reparación con un costo menor a $100
SELECT *
FROM sucursal s
WHERE s.codigo_sucursal IN (SELECT c.codigo_sucursal 
                           FROM cliente c
                           WHERE c.codigo_cliente IN (SELECT p.codigo_cliente
                                                     FROM pedido p
                                                     WHERE p.codigo_pedido IN (SELECT d.codigo_pedido
                                                                              FROM detalle_pedido d
                                                                              WHERE d.reparacion_precio_servicio<100)));

/*------------------Vistas y sus posibles usos------------------*/
#Vista que devuelve todos los pedidos que hayan sido pagados con el método mercado pago
CREATE OR REPLACE VIEW mercado_pago AS
	SELECT * 
    FROM pedido p
    WHERE p.codigo_medio_de_pago='MEP';
SELECT * FROM mercado_pago;

#Vista que muestra todos los empleados que siguen trabajando, todavía no han sido despedidos
CREATE OR REPLACE VIEW empleados_actuales AS
	SELECT * 
    FROM empleado e
    WHERE e.fecha_Baja IS NULL;
SELECT * FROM empleados_actuales;

#Vista que devuelve todos los clientes que hayan comprado en la sucursal de monte castro
CREATE OR REPLACE VIEW Monte_Castro AS
	SELECT * 
    FROM cliente c
    WHERE c.codigo_sucursal=1;
SELECT * FROM Monte_Castro;
