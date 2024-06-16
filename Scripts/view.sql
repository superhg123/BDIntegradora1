CREATE VIEW  telefonosCliente AS
(SELECT cliente.idCte, descripcion FROM cliente LEFT JOIN  (SELECT c.idCte, idTipoCto, descripcion FROM contactocte LEFT JOIN mercancia.cliente c on c.idCte = contactocte.idCte WHERE idTipoCto = 2) as telefonos ON cliente.idCte = telefonos.idCte);
DROP VIEW IF EXISTS pedidodetallado;

CREATE VIEW productosPorPedido AS
SELECT idPedido, sum(cantProd.cantidad) AS productos FROM relpedprod
INNER JOIN (SELECT idProducto, count(cantidad) AS cantidad FROM relpedprod GROUP BY idProducto) AS cantProd ON relpedprod.idProducto = cantProd.idProducto
GROUP BY idPedido;

DROP VIEW IF EXISTS pedidoDetallado;

CREATE VIEW pedidoDetallado AS
SELECT DISTINCT cuenta.idPedido AS pedido,
       CONCAT(cliente.nombre, ' ', cliente.paterno, ' ', cliente.materno) AS Cliente,
       CONCAT(direccion.calle, ' ', direccion.colonia) AS Direccion,
       horaSolicitud,
       fechaEntrega,
       tc.descripcion AS telefono,
       pPp.productos
FROM relpedprod
INNER JOIN (SELECT idPedido, count(idProducto) AS `Cantidad` FROM relpedprod GROUP BY idPedido) AS cuenta ON relpedprod.idPedido = cuenta.idPedido
INNER JOIN relctepedido ON relpedprod.idPedido = relctepedido.idPedido
INNER JOIN cliente ON relctepedido.idCte = cliente.idCte
INNER JOIN pedido ON relpedprod.idPedido = pedido.idPedido
INNER JOIN direccion ON pedido.idDireccion = direccion.idDir
LEFT JOIN telefonosCliente tC on cliente.idCte = tC.idCte
INNER JOIN productosPorPedido pPP on pedido.idPedido = pPP.idPedido
ORDER BY horaSolicitud;

SELECT * FROM relctepedido;

DROP VIEW IF EXISTS pedidos;
CREATE VIEW pedidos AS
SELECT pedido.idPedido AS Folio, pedido.costoTotal, productos AS productos, CONCAT(estado, '/', municipio) AS Zona, resenapedido AS Reseña FROM pedido
INNER JOIN productosPorPedido pPP on pedido.idPedido = pPP.idPedido
INNER JOIN relctepedido ON pedido.idPedido = relctepedido.idPedido
INNER JOIN mercancia.direccion d on pedido.idDireccion = d.idDir
INNER JOIN mercancia.zona z on d.idZona = z.idZona;

SELECT * FROM pedidos;
