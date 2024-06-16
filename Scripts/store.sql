USE mercancia;
desc proveedor;
SELECT ('08' LIKE SUBSTRING('2007-08-03',6,2));
DELIMITER //
CREATE PROCEDURE sp_insertar_proveedor(IN newRFC VARCHAR(13), IN newNombre VARCHAR(50), IN newPaterno VARCHAR(50), IN newMaterno VARCHAR(50), IN newFechNac DATE)
BEGIN
    DECLARE valido BOOL;
    DECLARE resultado VARCHAR(50);
    IF substring(newRFC, 1,2) LIKE substring(newPaterno,1,2)
        AND substring(newRFC, 3,1) LIKE SUBSTRING(newMaterno,1,1)
        AND substring(newRFC,4,1) LIKE SUBSTRING(newNombre,1,1)
        AND substring(newRFC,5,2) LIKE substring(year(newFechNac),3,2)
        AND substring(newRFC,7,2) LIKE substring(newFechNac,6,2)
        AND substring(newRFC, 9,2) LIKE substring(newFechNac,9,2)
    THEN
        IF (SELECT proveedor.RFC FROM proveedor WHERE RFC = newRFC) IS NULL THEN
            INSERT INTO proveedor (RFC, nombre, paterno, materno, fechNac) VALUES (newRFC, newNombre, newPaterno, newMaterno, newFechNac);
            SET resultado = 'Proveedor registrado con exito';
        ELSE
            SET resultado = 'Proveedor ya existe';
        end if;
    ELSE
        SET resultado = 'RFC invalida';
    end if ;
    SELECT resultado;
END;
// DELIMITER ;


DELIMITER //
CREATE PROCEDURE sp_actualizar_proveedor(IN oldRFC VARCHAR(13), IN newRFC VARCHAR(13), IN newNombre VARCHAR(50), IN newPaterno VARCHAR(50), IN newMaterno VARCHAR(50), IN newFechNac DATE)
BEGIN
    DECLARE resultado VARCHAR(50);
    IF substring(newRFC, 1,2) LIKE substring(newPaterno,1,2)
        AND substring(newRFC, 3,1) LIKE SUBSTRING(newMaterno,1,1)
        AND substring(newRFC,4,1) LIKE SUBSTRING(newNombre,1,1)
        AND substring(newRFC,5,2) LIKE substring(year(newFechNac),3,2)
        AND substring(newRFC,7,2) LIKE substring(newFechNac,6,2)
        AND substring(newRFC, 9,2) LIKE substring(newFechNac,9,2)
    THEN
        IF (SELECT proveedor.RFC FROM proveedor WHERE RFC = oldRFC) IS NULL THEN
            SET resultado = 'Proveedor no existe';
        ELSE
            UPDATE proveedor SET RFC = newRFC, nombre = newNombre, paterno = newPaterno, materno = newMaterno, fechNac = newFechNac WHERE RFC = oldRFC;
            SET resultado = 'Proveedor actualizado';
        end if;
    ELSE
        SET resultado = 'RFC invalida';
    end if ;
    SELECT resultado;
END;
// DELIMITER ;
SELECT * FROM proveedor;

DELIMITER //
CREATE PROCEDURE sp_insertar_cliente(IN idCliente INT, IN newCurp VARCHAR(18), IN newNombre VARCHAR(50), IN newPaterno VARCHAR(50), IN newMaterno VARCHAR(50), IN newFechNac DATE, IN newEstadoC VARCHAR(30))
BEGIN
    DECLARE resultado VARCHAR(50);
    IF substring(newCurp, 1,2) LIKE substring(newPaterno,1,2)
        AND substring(newCurp, 3,1) LIKE SUBSTRING(newMaterno,1,1)
        AND substring(newCurp,4,1) LIKE SUBSTRING(newNombre,1,1)
        AND substring(newCurp,5,2) LIKE substring(year(newFechNac),3,2)
        AND substring(newCurp,7,2) LIKE substring(newFechNac,6,2)
        AND substring(newCurp, 9,2) LIKE substring(newFechNac,9,2)
    THEN
        IF (SELECT cliente.idCte FROM cliente WHERE idCte = idCliente) IS NULL THEN
            INSERT INTO cliente (nombre, paterno, materno, fechNac, estadoCivil, CURP) VALUES (newNombre, newPaterno, newMaterno, newFechNac, newEstadoC, newCurp);
            SET resultado = 'Cliente registrado con exito';
        ELSE
            SET resultado = 'Cliente ya existe';
        end if;
    ELSE
        SET resultado = 'CURP invalida';
    end if ;
    SELECT resultado;
END;
// DELIMITER ;


DELIMITER //
CREATE PROCEDURE sp_insertar_cliente(IN idCliente INT, IN newCurp VARCHAR(18), IN newNombre VARCHAR(50), IN newPaterno VARCHAR(50), IN newMaterno VARCHAR(50), IN newFechNac DATE, IN newEstadoC VARCHAR(30))
BEGIN
    DECLARE resultado VARCHAR(50);
    IF substring(newCurp, 1,2) LIKE substring(newPaterno,1,2)
        AND substring(newCurp, 3,1) LIKE SUBSTRING(newMaterno,1,1)
        AND substring(newCurp,4,1) LIKE SUBSTRING(newNombre,1,1)
        AND substring(newCurp,5,2) LIKE substring(year(newFechNac),3,2)
        AND substring(newCurp,7,2) LIKE substring(newFechNac,6,2)
        AND substring(newCurp, 9,2) LIKE substring(newFechNac,9,2)
    THEN
        IF (SELECT cliente.idCte FROM cliente WHERE idCte = idCliente) IS NULL THEN
            INSERT INTO cliente (nombre, paterno, materno, fechNac, estadoCivil, CURP) VALUES (newNombre, newPaterno, newMaterno, newFechNac, newEstadoC, newCurp);
            SET resultado = 'Cliente registrado con exito';
        ELSE
            SET resultado = 'Cliente ya existe';
        end if;
    ELSE
        SET resultado = 'CURP invalida';
    end if ;
    SELECT resultado;
END;
// DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_actulizar_cliente(IN idCliente INT, IN newCurp VARCHAR(18), IN newNombre VARCHAR(50), IN newPaterno VARCHAR(50), IN newMaterno VARCHAR(50), IN newFechNac DATE, IN newEstadoC VARCHAR(30))
BEGIN
    DECLARE resultado VARCHAR(50);
    IF substring(newCurp, 1,2) LIKE substring(newPaterno,1,2)
        AND substring(newCurp, 3,1) LIKE SUBSTRING(newMaterno,1,1)
        AND substring(newCurp,4,1) LIKE SUBSTRING(newNombre,1,1)
        AND substring(newCurp,5,2) LIKE substring(year(newFechNac),3,2)
        AND substring(newCurp,7,2) LIKE substring(newFechNac,6,2)
        AND substring(newCurp, 9,2) LIKE substring(newFechNac,9,2)
    THEN
        IF (SELECT cliente.idCte FROM cliente WHERE idCte = idCliente) IS NULL THEN
            SET resultado = 'El cliente seleccionado no existe';
        ELSE
            UPDATE cliente SET nombre = newNombre,
                               paterno = newPaterno,
                               materno = newMaterno,
                               fechNac =newFechNac,
                               estadoCivil = newEstadoC,
                               CURP = newCurp WHERE idCte = idCliente;
            SET resultado = 'Cliente actualizado con exito';
        end if;
    ELSE
        SET resultado = 'CURP invalida';
    end if ;
    SELECT resultado;
END;
// DELIMITER ;


