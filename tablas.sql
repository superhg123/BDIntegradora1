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


CREATE TABLE Promocion (
    codigoPromo INT PRIMARY KEY,
    descPromo VARCHAR(50)
);

CREATE TABLE RelPromoCte (
    idRelPromoCte INT PRIMARY KEY AUTO_INCREMENT,
    idCteEmisor INT,
    idCteReceptor INT,
    codigoPromo INT,
    FOREIGN KEY (idCteEmisor) REFERENCES Cliente(idcte),
    FOREIGN KEY (idCteReceptor) REFERENCES  Cliente(idCte),
    FOREIGN KEY (codigoPromo) REFERENCES Promocion(codigoPromo)
);

CREATE TABLE Tarjetas (
    idTarjeta INT PRIMARY KEY AUTO_INCREMENT,
    numTarjeta BIGINT,
    exp DATE,
    cvv INT
);

CREATE TABLE RelCteTarjeta(
    idRelCteTar INT PRIMARY KEY AUTO_INCREMENT,
    idCte INT,
    idTarjeta INT,
    FOREIGN KEY (idCte) REFERENCES Cliente(idCte),
    FOREIGN KEY (idTarjeta) REFERENCES Tarjetas(idTarjeta)
);

CREATE TABLE Direccion (
    idDir INT PRIMARY KEY AUTO_INCREMENT,
    calle VARCHAR(100),
    colonia VARCHAR(60),
    municipio VARCHAR(60),
    estado VARCHAR(60),
    nExt INT,
    nInt INT
);

CREATE TABLE TipoContacto (
    idTipoCto INT PRIMARY KEY AUTO_INCREMENT,
    tipoCto VARCHAR(50)
);

CREATE TABLE ContactoCte (
    idCtoCte INT PRIMARY KEY AUTO_INCREMENT,
    idTipoCto INT,
    idCte INT,
    descripcion VARCHAR(50),
    FOREIGN KEY (idTipoCto) REFERENCES TipoContacto(idTipoCto),
    FOREIGN KEY (idCte) REFERENCES cliente(idCte)
);

CREATE TABLE relDirCte(
    idRelDirCte INT PRIMARY KEY AUTO_INCREMENT,
    idDir INT,
    idCte INT,
    descripcion VARCHAR(50),
    FOREIGN KEY (idDir) REFERENCES Direccion(idDir),
    FOREIGN KEY (idCte) REFERENCES Cliente(idCte)
);

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
    tiempoEntrega VARCHAR(6)
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