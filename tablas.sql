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
    RFC VARCHAR(13)
);

INSERT INTO cliente (nombre, paterno, materno, fechNac, estadoCivil, RFC) VALUES
    ('Asier', 'De la Vega', 'Cano', '2024-04-24', 'Soltero', 'TQJC930912VB9'),
    ('Dylan', 'Guadarrama', 'Barbero', '1957-02-19', 'Casado', 'BYRK060728PW6'),
    ('Xochitl', 'De la Cruz', 'Estrada', '1938-11-08', 'Casada', 'BYRK060728PW6'),
    ('Juan', 'López', 'García', '1990-05-15', 'Soltero', 'LOPG900515123'),
    ('María', 'Hernández', 'Martínez', '1985-08-25', 'Casada', 'HEMA850825123'),
    ('José', 'González', 'Rodríguez', '1993-02-10', 'Soltero', 'GORJ930210123'),
    ('Ana', 'Martínez', 'López', '1988-11-30', 'Divorciada', 'MALA881130123'),
    ('Carlos', 'Pérez', 'Sánchez', '1980-04-20', 'Casado', 'PESC800420123'),
    ('Laura', 'Gómez', 'Ramírez', '1995-09-05', 'Soltera', 'GORL950905123');;

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

CREATE TABLE Direccion (
    idDir INT PRIMARY KEY AUTO_INCREMENT,
    calle VARCHAR(100),
    colonia VARCHAR(60),
    municipio VARCHAR(60),
    estado VARCHAR(60),
    nExt INT,
    nInt INT
);

INSERT INTO direccion (calle, colonia, municipio, estado, nExt, nInt) VALUES ('Puerta Alfredo Mojica', 'Huatabambo', 'Homonimo', 'Sonora', 969, 0),
                                                                             ('Guillermina', 'Hopelchen','Santa Rita', 'Campeche', 3, 294),
                                                                             ('Rambla Glaciela Alcala', 'San Benito', 'Hermosillo', 'Sonora', 130, 12),
                                                                             ('Arrabal Dorotea' , 'Morelos','Saltillo', 'Coahuila', 93, 239),
                                                                             ('Quiroga', 'Los mangos', 'Tepalcatepec', 'Michoacan', 100, 0),
                                                                             ('Calle Nayarit', 'Aviacion', 'Compostela', 'Nayarit', 45, 305),
                                                                             ('Avenida Insurgentes Sur', 'Condesa', 'Cuauhtémoc', 'Ciudad de México', 123, 0),
                                                                             ('Calle Reforma', 'Juárez', 'Cuauhtémoc', 'Ciudad de México', 456, 101),
                                                                             ('Calle López Mateos', 'Chapultepec', 'Guadalajara', 'Jalisco', 789, 202),
                                                                             ('Avenida Patria', 'Santa Tere', 'Guadalajara', 'Jalisco', 321, 0),
                                                                             ('Boulevard Díaz Ordaz', 'Los Arcos', 'Monterrey', 'Nuevo León', 654, 303),
                                                                             ('Avenida Juárez', 'Centro', 'Puebla', 'Puebla', 987, 404),
                                                                             ('Calle 5 de Mayo', 'Centro', 'Querétaro', 'Querétaro', 432, 0),
                                                                             ('Avenida Universidad', 'Jardines', 'Mérida', 'Yucatán', 876, 505),
                                                                             ('Calle Francisco Villa', 'La Esperanza', 'León', 'Guanajuato', 543, 606),
                                                                             ('Boulevard Belisario Domínguez', 'Zona Dorada', 'Tuxtla Gutiérrez', 'Chiapas', 210, 707);

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
    fechaZona DATE
);



CREATE TABLE pedido (
    idPedido INT PRIMARY KEY AUTO_INCREMENT,
    idRepartidor INT,
    costoTotal FLOAT,
    conRepartidor BOOL,
    tiempoEntrega VARCHAR(6),
    fechaRegistro DATE
);

CREATE TABLE RelCtePedido (
    idRelCtePedido INT PRIMARY KEY AUTO_INCREMENT,
    idCte INT,
    idPedido INT,
    concepto VARCHAR(30),
    resenapedido FLOAT
);

CREATE TABLE ContactoRep (
    idCtoRep INT PRIMARY KEY AUTO_INCREMENT,
    idRepartidor INT,
    idTipoCto INT,
    descripcion VARCHAR(50),
    FOREIGN KEY (idTipoCto) REFERENCES TipoContacto(idTipoCto),
    FOREIGN KEY (idRepartidor) REFERENCES Repartidor(idRepartidor)
);

CREATE TABLE RelDirRep (
    idRelDirRep INT PRIMARY KEY AUTO_INCREMENT,
    idDir INT,
    idRepartidor INT,
    descripcion VARCHAR(50),
    FOREIGN KEY (idDir) REFERENCES Direccion(idDir),
    FOREIGN KEY (idRepartidor) REFERENCES Repartidor(idRepartidor)
);

CREATE TABLE Ruta (
    idRuta INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50)
);

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

CREATE TABLE Producto (
    idProducto INT PRIMARY KEY AUTO_INCREMENT,
    idProveedor INT,
    idCategoria INT,
    nombre VARCHAR(60),
    descripcion VARCHAR(100),
    costoUnitario FLOAT,
    marca VARCHAR(30),
    demanda INT,
    FOREIGN KEY (idCategoria) REFERENCES Categoria(idCategoria)
);

CREATE TABLE Proveedor (
    idProv INT PRIMARY KEY AUTO_INCREMENT,
    RFC VARCHAR(13),
    nombre VARCHAR(50),
    paterno VARCHAR(50),
    materno VARCHAR(50)
);

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

CREATE TABLE RelPedProd (
    idRelPedProd INT PRIMARY KEY AUTO_INCREMENT,
    idPedido INT,
    idProducto INT,
    reseniaEntrega FLOAT,
    reseniaCalidad FLOAT,
    FOREIGN KEY (idPedido) REFERENCES pedido(idPedido),
    FOREIGN KEY (idProducto) REFERENCES producto(idProducto)
);

CREATE TABLE RelRutaRepartidor (
    idRelRutRep INT PRIMARY KEY AUTO_INCREMENT,
    idRuta INT,
    idRepartidor INT,
    FOREIGN KEY (idRuta) REFERENCES ruta(idRuta),
    FOREIGN KEY (idRepartidor) REFERENCES repartidor(idRepartidor)
)