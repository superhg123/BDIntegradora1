DROP DATABASE IF EXISTS mercancia;
CREATE DATABASE mercancia;
USE mercancia;

CREATE TABLE Cliente (
    idCte INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50),
    paterno VARCHAR(50),
    materno VARCHAR(50),
    fechNac DATE,
    estadoCivil VARCHAR(30),
    CURP VARCHAR(18)
);

INSERT INTO cliente (nombre, paterno, materno, fechNac, estadoCivil, CURP) VALUES
    ('Asier', 'De la Vega', 'Cano', '2024-04-24', 'Soltero', 'TQJC930912HDFVSN08'),
    ('Dylan', 'Guadarrama', 'Barbero', '1957-02-19', 'Casado', 'BYRK060728HDFGRR09'),
    ('Xochitl', 'De la Cruz', 'Estrada', '1938-11-08', 'Casada', 'BYRK060728HDFGRR09'),
    ('Juan', 'López', 'García', '1990-05-15', 'Soltero', 'LOPG900515CCLCRD03'),
    ('María', 'Hernández', 'Martínez', '1985-08-25', 'Casada', 'HEMA850825MMCMSR06'),
    ('José', 'González', 'Rodríguez', '1993-02-10', 'Soltero', 'GORJ930210GRMDCN05'),
    ('Ana', 'Martínez', 'López', '1988-11-30', 'Divorciada', 'MALA881130GRMRTN07'),
    ('Carlos', 'Pérez', 'Sánchez', '1980-04-20', 'Casado', 'PESC800420HDFPRS08'),
    ('Laura', 'Gómez', 'Ramírez', '1995-09-05', 'Soltera', 'GORL950905CMCMRL08');

CREATE TABLE Promocion (
    codigoPromo INT PRIMARY KEY,
    descPromo VARCHAR(50)
);

INSERT INTO promocion VALUES (1111, 'Dos por uno'), (1112, '50% de descuento'), (1113, 'Tercer articulo a mitad de precio');

CREATE TABLE RelPromoCte (
    idRelPromoCte INT PRIMARY KEY AUTO_INCREMENT,
    idCteEmisor INT,
    idCteReceptor INT,
    codigoPromo INT,
    FOREIGN KEY (idCteEmisor) REFERENCES Cliente(idcte),
    FOREIGN KEY (idCteReceptor) REFERENCES  Cliente(idCte),
    FOREIGN KEY (codigoPromo) REFERENCES Promocion(codigoPromo)
);

INSERT INTO relpromocte (idCteEmisor, idCteReceptor, codigoPromo) VALUES
                                                                  (1,2,1111), (2,3,1111), (1,3,1112), (3,2,1113);

CREATE TABLE Tarjetas (
    idTarjeta INT PRIMARY KEY AUTO_INCREMENT,
    numTarjeta BIGINT,
    exp DATE,
    cvv INT
);

INSERT INTO tarjetas (numTarjeta, exp, cvv) VALUES (5576025296020308,'2027-12-01', 314),
                                                   (5576029128184902, '2025-06-01', 496),
                                                   (5576023180412343, '2026-02-01', 788);


CREATE TABLE RelCteTarjeta(
    idRelCteTar INT PRIMARY KEY AUTO_INCREMENT,
    idCte INT,
    idTarjeta INT,
    FOREIGN KEY (idCte) REFERENCES Cliente(idCte),
    FOREIGN KEY (idTarjeta) REFERENCES Tarjetas(idTarjeta)
);

INSERT INTO relctetarjeta(idCte, idTarjeta) VALUES (1,1), (1,1), (2,2), (2,3);

CREATE TABLE Zona (
    idZona INT PRIMARY KEY AUTO_INCREMENT,
    municipio VARCHAR(60),
    estado VARCHAR(60)
);

INSERT INTO Zona (municipio, estado) VALUES
('Gustavo A. Madero', 'Ciudad de México'),
('Ecatepec de Morelos', 'Estado de México'),
('Guadalajara', 'Jalisco'),
('Culiacán', 'Sinaloa');

CREATE TABLE Direccion (
    idDir INT PRIMARY KEY AUTO_INCREMENT,
    idZona INT,
    calle VARCHAR(100),
    colonia VARCHAR(60),
    nExt INT,
    nInt INT,
    FOREIGN KEY (idZona) REFERENCES Zona(idZona)
);
INSERT INTO Direccion (idZona, calle, colonia, nExt, nInt) VALUES
(1, 'Calle Victoria', 'Colonia Lindavista', 100, 0),
(1, 'Avenida Montevideo', 'Colonia Lindavista', 200, 1),
(1, 'Calle Riobamba', 'Colonia Lindavista', 300, 2),
(1, 'Avenida de los Insurgentes Norte', 'Colonia Guadalupe Tepeyac', 150, 0),
(2, 'Calle San Juan de Aragón', 'Colonia Nueva Atzacoalco', 120, 0),
(2, 'Avenida Gran Canal', 'Colonia Nueva Atzacoalco', 220, 1),
(2, 'Calle León de los Aldama', 'Colonia Nueva Atzacoalco', 320, 2),
(2, 'Avenida Río de los Remedios', 'Colonia Villa de Aragón', 130, 0),
(3, 'Avenida Ceylán', 'Colonia Vallejo', 110, 0),
(3, 'Calle Doctor Lavista', 'Colonia Vallejo', 210, 1),
(3, 'Calle Norte 45', 'Colonia Vallejo', 310, 2),
(3, 'Calle 9', 'Colonia I', 140, 0),
(4, 'Calle Alfonso G. Calderón', 'Colonia Centro', 130, 0),
(4, 'Av. Álvaro Obregón', 'Colonia Guadalupe Victoria', 230, 1),
(4, 'Calle Melchor Ocampo', 'Colonia Miguel Hidalgo', 330, 2),
(4, 'Blvd. Dr. Mora', 'Colonia Jorge Almada', 430, 0);

SELECT * FROM direccion;
CREATE TABLE TipoContacto (
    idTipoCto INT PRIMARY KEY AUTO_INCREMENT,
    tipoCto VARCHAR(50)
);

INSERT INTO TipoContacto (tipoCto) VALUES ('Email'), ('Telefono'), ('Blog'), ('Skype'), ('Discord');

CREATE TABLE ContactoCte (
    idCtoCte INT PRIMARY KEY AUTO_INCREMENT,
    idTipoCto INT,
    idCte INT,
    descripcion VARCHAR(50),
    FOREIGN KEY (idTipoCto) REFERENCES TipoContacto(idTipoCto),
    FOREIGN KEY (idCte) REFERENCES cliente(idCte)
);

INSERT INTO contactocte (idTipoCto, idCte, descripcion) VALUES (1, 1, 'asievega@gmail.com'), (2,1,'123123123'), (4,1, 'Asi.Cano'),
                                                               (3, 2, 'DyGuad#1231'), (4,2, 'Dybarber12'), (1,2,'Dylarrama@gmail.com'),
                                                               (5, 3, 'Chochil1213'), (1,3,'xoch.estr@gmail.com'), (3,3,'xochco12'),
                                                               (1, 4, 'juan.lopez@example.com'), (2, 4, '555-123-4567'), (5, 4, 'JuanLopez#1234'),
                                                               (1, 5, 'maria.hernandez@example.com'), (2, 5, '555-987-6543'), (4, 5, 'maria.hernandez.skype'),
                                                               (1, 6, 'jose.gonzalez@example.com'), (3, 6, 'josegonzalez.blog.com'), (5, 6, 'JoseGonzalez#5678'),
                                                               (1, 7, 'ana.martinez@example.com'), (2, 7, '555-222-3333'), (4, 7, 'ana.martinez.skype'),
                                                               (1, 8, 'carlos.perez@example.com'), (3, 8, 'carlosperez.blog.com'), (5, 8, 'CarlosPerez#9012'),
                                                                (1, 9, 'laura.gomez@example.com'), (2, 9, '555-333-4444'), (4, 9, 'laura.gomez.skype');

CREATE TABLE relDirCte(
    idRelDirCte INT PRIMARY KEY AUTO_INCREMENT,
    idDir INT,
    idCte INT,
    descripcion VARCHAR(50),
    FOREIGN KEY (idDir) REFERENCES Direccion(idDir),
    FOREIGN KEY (idCte) REFERENCES Cliente(idCte)
);

INSERT INTO relDirCte (idDir, idCte, descripcion) VALUES
(1, 1, 'Dirección principal de Asier'),
(2, 2, 'Dirección secundaria de Dylan'),
(3, 3, 'Dirección principal de Xochitl'),
(4, 1, 'Dirección secundaria de Asier'),
(5, 2, 'Dirección alternativa de Dylan');


CREATE TABLE Repartidor (
    idRepartidor INT PRIMARY KEY AUTO_INCREMENT,
    RFC VARCHAR(13),
    nombre VARCHAR(50),
    paterno VARCHAR(50),
    materno VARCHAR(50),
    fechNac DATE,
    estadoCivil VARCHAR(20),
    zonaActual INT,
    fechaZona DATE,
    FOREIGN KEY (zonaActual) REFERENCES Zona(idZona)
);

INSERT INTO repartidor (rfc, nombre, paterno, materno, fechnac, estadocivil, zonaactual, fechazona) VALUES
('REPA123456789', 'Juan', 'González', 'López', '1990-03-15', 'Soltero', 1, '2023-01-15'),
('REPA987654321', 'María', 'Martínez', 'Hernández', '1985-07-25', 'Casada', 2, '2023-02-20'),
('REPA567890123', 'Pedro', 'Sánchez', 'Gómez', '1993-11-10', 'Soltero', 3, '2023-03-10'),
('REPA456789012', 'Laura', 'Pérez', 'Ramírez', '1988-09-30', 'Divorciada', 1, '2023-04-05'),
('REPA234567890', 'Carlos', 'López', 'Rodríguez', '1980-05-20', 'Casado', 2, '2023-05-15');



CREATE TABLE pedido (
    idPedido INT PRIMARY KEY AUTO_INCREMENT,
    idRepartidor INT,
    costoTotal FLOAT DEFAULT 0,
    conRepartidor BOOL DEFAULT FALSE,
    tiempoEntrega VARCHAR(6),
    fechaRegistro DATE DEFAULT (curdate()),
    fechaEntrega DATE,
    FOREIGN KEY (idRepartidor) REFERENCES repartidor(idRepartidor)
);

INSERT INTO pedido (idRepartidor, tiempoEntrega, fechaRegistro, fechaEntrega) VALUES (1, '2 días', '2023-05-10', null),
(1, '1 día', '2024-06-08', '2024-10-20'),
(1, '3 días', '2024-07-12', '2024-08-08'),
(2, '2 días', '2024-05-09', NULL),
(2, '1 día', '2024-06-11', null),
(3, '2 días', '2024-04-07', null),
(3, '1 día', '2024-07-13', null),
(3, '3 días', '2024-08-10', null),
(4, '2 días', '2024-06-06', null),
(4, '1 día', '2024-09-14', null),
(5, '2 días', '2024-08-05', null),
(5, '1 día', '2024-10-15', null),
(5, '3 días', '2024-11-09', null);

CREATE TABLE RelCtePedido (
    idRelCtePedido INT PRIMARY KEY AUTO_INCREMENT,
    idCte INT,
    idPedido INT,
    concepto VARCHAR(30),
    resenapedido FLOAT
);

INSERT INTO relctepedido (idCte, idPedido, concepto, resenapedido) VALUES
(1, 1, 'Pedido 1', 3),
(1, 2, 'Pedido 2', 4),
(1, 3, 'Pedido 3', 2),
(2, 4, 'Pedido 4', 1),
(2, 5, 'Pedido 5', 5),
(3, 6, 'Pedido 6', 3),
(3, 7, 'Pedido 7', 0),
(3, 8, 'Pedido 8', 4),
(4, 9, 'Pedido 9', 2),
(4, 10, 'Pedido 10', 5),
(5, 11, 'Pedido 11', 1),
(5, 12, 'Pedido 12', 3);



CREATE TABLE ContactoRep (
    idCtoRep INT PRIMARY KEY AUTO_INCREMENT,
    idRepartidor INT,
    idTipoCto INT,
    descripcion VARCHAR(50),
    FOREIGN KEY (idTipoCto) REFERENCES TipoContacto(idTipoCto),
    FOREIGN KEY (idRepartidor) REFERENCES Repartidor(idRepartidor)
);

INSERT INTO ContactoRep (idRepartidor, idTipoCto, descripcion) VALUES
(1, 1, 'asier.repartidor@example.com'),
(1, 2, '555-1234'),
(1, 3, 'https://www.asierblog.com'),
(1, 4, 'asier.skype'),
(1, 5, 'asier#1234');


INSERT INTO ContactoRep (idRepartidor, idTipoCto, descripcion) VALUES
(2, 1, 'dylan.repartidor@example.com'),
(2, 2, '555-5678'),
(2, 3, 'https://www.dylanblog.com'),
(2, 4, 'dylan.skype'),
(2, 5, 'dylan#5678');

-- Para el repartidor 3
INSERT INTO ContactoRep (idRepartidor, idTipoCto, descripcion) VALUES
(3, 1, 'xochitl.repartidor@example.com'),
(3, 2, '555-9012'),
(3, 3, 'https://www.xochitlblog.com'),
(3, 4, 'xochitl.skype'),
(3, 5, 'xochitl#9012');

-- Para el repartidor 4
INSERT INTO ContactoRep (idRepartidor, idTipoCto, descripcion) VALUES
(4, 1, 'juan.repartidor@example.com'),
(4, 2, '555-3456'),
(4, 3, 'https://www.juanblog.com'),
(4, 4, 'juan.skype'),
(4, 5, 'juan#3456');

-- Para el repartidor 5
INSERT INTO ContactoRep (idRepartidor, idTipoCto, descripcion) VALUES
(5, 1, 'maria.repartidor@example.com'),
(5, 2, '555-7890'),
(5, 3, 'https://www.mariablog.com'),
(5, 4, 'maria.skype'),
(5, 5, 'maria#7890');


CREATE TABLE RelDirRep (
    idRelDirRep INT PRIMARY KEY AUTO_INCREMENT,
    idDir INT,
    idRepartidor INT,
    descripcion VARCHAR(50),
    FOREIGN KEY (idDir) REFERENCES Direccion(idDir),
    FOREIGN KEY (idRepartidor) REFERENCES Repartidor(idRepartidor)
);

INSERT INTO RelDirRep (idDir, idRepartidor, descripcion) VALUES
(1, 1, 'Dirección principal de Juan'), (2, 1, 'Segunda dirección de Juan'), (11, 1, 'Tercera dirección de Juan'),
(9, 2, 'Dirección principal de María'), (10, 2, 'Segunda dirección de María'), (12, 2, 'Tercera dirección de María'),
(7, 3, 'Dirección principal de Pedro'), (8, 3, 'Segunda dirección de Pedro'), (13, 3, 'Tercera dirección de Pedro'),
(1, 4, 'Dirección principal de Laura'), (3, 4, 'Segunda dirección de Laura'), (14, 4, 'Tercera dirección de Laura'),
(2, 5, 'Dirección principal de Carlos'), (4, 5, 'Segunda dirección de Carlos'), (15, 5, 'Tercera dirección de Carlos');


CREATE TABLE Ruta (
    idRuta INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50)
);

INSERT INTO Ruta (nombre) VALUES
('Ruta A'),
('Ruta B'),
('Ruta C');


CREATE TABLE RelRutaDir (
    idRelRutaDir INT PRIMARY KEY AUTO_INCREMENT,
    idRuta INT,
    idDir INT,
    FOREIGN KEY (idRuta) REFERENCES Ruta(idRuta),
    FOREIGN KEY (idDir) REFERENCES Direccion(idDir)
);

CREATE TABLE Categoria (
    idCategoria INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50),
    imagen VARCHAR(255)
);
INSERT INTO Categoria (nombre, imagen) VALUES
('Categoría 1', '/directorios/imagen1.jpg'),
('Categoría 2', '/directorios/imagen2.jpg'),
('Categoría 3', '/directorios/imagen3.jpg'),
('Categoría 4', '/directorios/imagen4.jpg');


CREATE TABLE Proveedor (
    idProv INT PRIMARY KEY AUTO_INCREMENT,
    RFC VARCHAR(13),
    nombre VARCHAR(50),
    paterno VARCHAR(50),
    materno VARCHAR(50),
    fechNac DATE
);

CREATE TABLE Producto (
    idProducto INT PRIMARY KEY AUTO_INCREMENT,
    idProveedor INT,
    idCategoria INT,
    nombre VARCHAR(60),
    descripcion VARCHAR(100),
    costoUnitario FLOAT,
    marca VARCHAR(30),
    demanda INT,
    FOREIGN KEY (idCategoria) REFERENCES Categoria(idCategoria),
    FOREIGN KEY (idProveedor) REFERENCES Proveedor(idProv)
);
SELECT * FROM proveedor;
CREATE TABLE RelPedProv (
    idRelPedProv INT PRIMARY KEY AUTO_INCREMENT,
    idProveedor INT,
    idProducto INT,
    cantidadExistente INT,
    FOREIGN KEY (idProveedor) REFERENCES Proveedor(idProv),
    FOREIGN KEY (idProducto) REFERENCES Producto(idProducto)
);

CREATE TABLE RelCatProv (
    idRelCatProv INT PRIMARY KEY AUTO_INCREMENT,
    idProv INT,
    idCategoria INT,
    proceso VARCHAR(50),
    FOREIGN KEY (idProv) REFERENCES Proveedor(idProv),
    FOREIGN KEY (idCategoria) REFERENCES Categoria(idCategoria)
);

CREATE TABLE RelDirProv (
    idRelDirProv INT PRIMARY KEY AUTO_INCREMENT,
    idDir INT,
    idProv INT,
    descripcion VARCHAR(50),
    FOREIGN KEY (idDir) REFERENCES Direccion(idDir),
    FOREIGN KEY (idProv) REFERENCES Proveedor(idProv)
);

CREATE TABLE ContactoProv (
    idCtoProv INT PRIMARY KEY AUTO_INCREMENT,
    idTipoCto INT,
    idProv INT,
    descripcion VARCHAR(50),
    FOREIGN KEY (idTipoCto) REFERENCES TipoContacto(idTipoCto)
);

-- Proveedor 1
INSERT INTO Proveedor (RFC, nombre, paterno, materno) VALUES
('PROV123456789', 'Juan', 'Pérez', 'Gómez');

INSERT INTO RelDirProv (idDir, idProv, descripcion) VALUES
(1, 1, 'Dirección principal de Juan'),
(2, 1, 'Segunda dirección de Juan');

INSERT INTO ContactoProv (idTipoCto, idProv, descripcion) VALUES
(1, 1, 'juan.perez@email.com'),
(2, 1, '555-1234'),
(3, 1, 'juan.skype.id');

-- Proveedor 2
INSERT INTO Proveedor (RFC, nombre, paterno, materno) VALUES
('PROV987654321', 'María', 'Gómez', 'Martínez');

INSERT INTO RelDirProv (idDir, idProv, descripcion) VALUES
(3, 2, 'Dirección principal de María'),
(4, 2, 'Segunda dirección de María');

INSERT INTO ContactoProv (idTipoCto, idProv, descripcion) VALUES
(1, 2, 'maria.gomez@email.com'),
(2, 2, '555-5678'),
(3, 2, 'maria.skype.id');

-- Proveedor 3
INSERT INTO Proveedor (RFC, nombre, paterno, materno) VALUES
('PROV567890123', 'Pedro', 'López', 'Sánchez');

INSERT INTO RelDirProv (idDir, idProv, descripcion) VALUES
(1, 3, 'Dirección principal de Pedro'),
(5, 3, 'Segunda dirección de Pedro');

INSERT INTO ContactoProv (idTipoCto, idProv, descripcion) VALUES
(1, 3, 'pedro.lopez@email.com'),
(2, 3, '555-9012'),
(3, 3, 'pedro.skype.id');

INSERT INTO Producto (idProveedor, idCategoria, nombre, descripcion, costoUnitario, marca, demanda) VALUES
(1, 1, 'Producto A', 'Descripción del Producto A', 100.50, 'Marca A', 50),
(2, 2, 'Producto B', 'Descripción del Producto B', 75.25, 'Marca B', 80),
(3, 3, 'Producto C', 'Descripción del Producto C', 120.75, 'Marca C', 60),
(1, 2, 'Producto D', 'Descripción del Producto D', 90.00, 'Marca D', 45),
(2, 1, 'Producto E', 'Descripción del Producto E', 85.50, 'Marca E', 70);

-- Proveedor 1
INSERT INTO RelPedProv (idProveedor, idProducto, cantidadExistente) VALUES
(1, 1, 100),
(1, 2, 50),
(1, 3, 75);

-- Proveedor 2
INSERT INTO RelPedProv (idProveedor, idProducto, cantidadExistente) VALUES
(2, 2, 30),
(2, 4, 20),
(2, 5, 40);

-- Proveedor 3
INSERT INTO RelPedProv (idProveedor, idProducto, cantidadExistente) VALUES
(3, 1, 80),
(3, 3, 60),
(3, 5, 35);

CREATE TABLE RelPedProd (
    idRelPedProd INT PRIMARY KEY AUTO_INCREMENT,
    idPedido INT,
    idProducto INT,
    reseniaEntrega FLOAT,
    reseniaCalidad FLOAT,
    FOREIGN KEY (idPedido) REFERENCES pedido(idPedido),
    FOREIGN KEY (idProducto) REFERENCES producto(idProducto)
);

INSERT INTO RelPedProd (idPedido, idProducto)
VALUES
(1, 1), (1, 2),
(2, 1), (2, 3),
(3, 2), (3, 4),
(4, 1), (4, 5),
(5, 3),
(6, 2), (6, 4),
(7, 1),
(8, 3),
(9, 5),
(10, 1),
(11, 2),
(12, 4),
(13, 3);

CREATE TABLE RelRutaRepartidor (
    idRelRutRep INT PRIMARY KEY AUTO_INCREMENT,
    idRuta INT,
    idRepartidor INT,
    FOREIGN KEY (idRuta) REFERENCES ruta(idRuta),
    FOREIGN KEY (idRepartidor) REFERENCES repartidor(idRepartidor)
)