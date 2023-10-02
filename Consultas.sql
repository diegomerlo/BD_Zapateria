/*------------------Operadores Lógicos------------------*/
  
SELECT p.nombre AS Nombre FROM producto p WHERE p.precio_venta BETWEEN 2000 AND 5000;

SELECT c.nombre FROM cliente c WHERE c.nombre LIKE 'F%';

/*------------------Operadores de Fecha------------------*/

SELECT p.fecha_pedido, p.fecha_entregado FROM pedido p WHERE MONTH(p.fecha_envioEstimado) = 10;

SELECT p.fecha_pedido, p.fecha_entregado, DATEDIFF(p.fecha_envioEstimado,p.fecha_pedido) AS "Dias para la entrega"
FROM pedido p WHERE p.fecha_envioEstimado IS NOT NULL AND DATEDIFF(p.fecha_envioEstimado,p.fecha_pedido) > 15;

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

SELECT COUNT(*) FROM cliente C WHERE C.codigo_sucursal=3;

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

SELECT CONCAT(e.apellido1,' ',e.apellido2,', ',e.nombre) AS Nombre,e.puesto AS Puesto 
  FROM empleado e 
  WHERE e.codigo_empleado IN (SELECT codigo_empleado FROM pedido);
