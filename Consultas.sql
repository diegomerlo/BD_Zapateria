/*------------------Operadores Lógicos------------------*/
  
SELECT p.nombre AS Nombre FROM producto p WHERE p.precio_venta BETWEEN 2000 AND 5000;

SELECT c.nombre FROM cliente c WHERE c.nombre LIKE 'F%';

/*------------------Operadores de Fecha------------------*/

SELECT p.fecha_pedido, p.fecha_entregado FROM pedido p WHERE MONTH(p.fecha_envioEstimado) = 10;



/*------------------Campos calculados (Count, Sum, Max, Min, Avg)--------------------------------------*/

SELECT COUNT(*) FROM cliente C WHERE C.codigo_sucursal=3;

SELECT AVG(D.producto_precio_unidad) Producto_avg, AVG(D.reparacion_precio_servicio) Servicio_avg FROM detalle_pedido D;
