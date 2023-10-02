/*------------------Operadores Lógicos------------------*/
  
SELECT p.nombre AS Nombre FROM producto p WHERE p.precio_venta BETWEEN 2000 AND 5000;

SELECT c.nombre FROM cliente c WHERE c.nombre LIKE 'F%';

/*------------------Operadores de Fecha------------------*/

SELECT p.fecha_pedido, p.fecha_entregado FROM pedido p WHERE MONTH(p.fecha_envioEstimado) = 10;



/*------------------Campos calculados (Count, Sum, Max, Min, Avg)--------------------------------------*/

SELECT COUNT(*) FROM cliente C WHERE C.codigo_sucursal=3;

SELECT AVG(D.producto_precio_unidad) Producto_avg, AVG(D.reparacion_precio_servicio) Servicio_avg FROM detalle_pedido D;

/*------------------Inner Join-------------------------*/

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

