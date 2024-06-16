USE mercancia;


# -- 1 --
SELECT producto.nombre, producto.descripcion FROM relpedprod
INNER JOIN pedido on relpedprod.idPedido = pedido.idPedido
INNER JOIN producto on relpedprod.idProducto = producto.idProducto
ORDER BY demanda LIMIT 10;
