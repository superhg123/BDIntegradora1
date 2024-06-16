/*1. Obtener del top 10 de productos más solicitados, la cantidad de productossolicitados y la última fecha de solicitud de cada uno de ellos.*/
SELECT producto.nombre, producto.descripcion FROM relpedprod
INNER JOIN pedido on relpedprod.idPedido = pedido.idPedido
INNER JOIN producto on relpedprod.idProducto = producto.idProducto
ORDER BY demanda LIMIT 10;

/*2. Ver todos los clientes que tienen más de 3 pedidos registrados durante el último año.*/
SELECT c.nombre, c.paterno, c.materno, COUNT(rp.idPedido) AS num_pedidos
FROM Cliente c
JOIN RelCtePedido rp ON c.idCte = rp.idCte
JOIN Pedido p ON rp.idPedido = p.idPedido
WHERE p.fechaRegistro >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY c.idCte
HAVING COUNT(rp.idPedido) > 3;

/*3. Obtener el producto más solicitado de cada categoría.*/
SELECT c.nombre AS categoria, p.nombre AS producto_mas_solicitado, p.demanda AS demanda
FROM Categoria c JOIN Producto p ON c.idCategoria = p.idCategoria
WHERE p.demanda = (SELECT MAX(demanda) FROM Producto p2 WHERE p2.idCategoria = p.idCategoria);


SELECT
    idCategoria,
    nombre_categoria AS categoria,
    idProducto,
    nombre_producto AS producto,
    total_pedidos
FROM
    ProductosOrdenados
WHERE
    rn = 1;


/*4. Obtener todos los pedidos registrados del mes de MARZO DE 2024 al mes de ABRIL DE 2024.*/
SELECT p.idPedido, p.idRepartidor, p.costoTotal, p.conRepartidor, p.tiempoEntrega, p.fechaRegistro FROM pedido p
WHERE p.fechaRegistro >= '2024-03-01 00:00:00' AND p.fechaRegistro <= '2024-04-30 23:59:59';

/*5. Obtener todos los clientes que tengan más de 60 años, a partir de su fecha de Nacimiento y obtener su nombre completo ordenado por la fecha de nacimiento.*/
SELECT c.nombre as nombre, c.paterno, c.materno, c.fechNac from cliente c where DATEDIFF(CURDATE(), fechNac) / 365.25 > 60 ORDER BY fechNac ASC;

/*6. Obtener el total de clientes que se tiene en las diferentes zonas del país*/
SELECT z.municipio, z.estado, COUNT(c.idCte) AS totalclientes
FROM Cliente c
INNER JOIN relDirCte rdc ON c.idCte = rdc.idCte
INNER JOIN Direccion d ON rdc.idDir = d.idDir
INNER JOIN Zona z ON d.idZona = z.idZona
GROUP BY z.municipio, z.estado;
select * from zona;

SELECT z.municipio, z.estado, COUNT(c.idCte) AS total_clientes
FROM Zona z
LEFT JOIN Direccion d ON z.idZona = d.idZona
LEFT JOIN relDirCte rdc ON d.idDir = rdc.idDir
LEFT JOIN Cliente c ON rdc.idCte = c.idCte
GROUP BY z.municipio, z.estado;

/*7. Obtener el total de clientes que se tiene en las diferentes zonas del país.*/
/*IGUAL AL 6*/

/*8. Obtener el total de repartidores que se tiene en las diferentes zonas del país.*/
SELECT z.municipio, z.estado, COUNT(r.idRepartidor) AS totalRepartidores
FROM Repartidor r
INNER JOIN Zona z ON r.zonaActual = z.idZona
GROUP BY z.municipio, z.estado;

/*9. Obtener el total de pedidos realizados de cada cliente que se tiene, así como los datos del cliente (Nombre, dirección entrega y tel móvil).*/
SELECT c.idCte, c.nombre, c.paterno, c.materno, d.calle, d.colonia, d.nExt, d.nInt, z.municipio, z.estado,
    (SELECT cc.descripcion FROM ContactoCte cc
     WHERE cc.idCte = c.idCte AND cc.idTipoCto = (SELECT idTipoCto FROM TipoContacto WHERE tipoCto = 'Telefono')
     LIMIT 1) AS telefono, COUNT(rcp.idPedido) AS total_pedidos
FROM Cliente c
JOIN RelCtePedido rcp ON c.idCte = rcp.idCte
JOIN RelDirCte rdc ON c.idCte = rdc.idCte
JOIN Direccion d ON rdc.idDir = d.idDir
JOIN Zona z ON d.idZona = z.idZona
GROUP BY c.idCte, c.nombre, c.paterno, c.materno, d.calle, d.colonia, d.nExt, d.nInt, z.municipio, z.estado
ORDER BY c.idCte;


/*10. Obtener el promedio de pedidos enviados de cada repartidor. */
SELECT r.idRepartidor, r.nombre, r.zonaActual, COUNT(p.idPedido) AS total_pedidos, AVG(COUNT(p.idPedido)) OVER () AS promedioPedidos
FROM Repartidor r JOIN Pedido p ON r.idRepartidor = p.idRepartidor
GROUP BY r.idRepartidor, r.nombre, r.zonaActual
ORDER BY r.idRepartidor;

