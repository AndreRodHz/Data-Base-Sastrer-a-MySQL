DELIMITER //
CREATE FUNCTION generar_serie_comprobante (input_id_com VARCHAR(15))
RETURNS VARCHAR(20)
DETERMINISTIC
NO SQL
BEGIN
    DECLARE salida VARCHAR(20);

    IF input_id_com LIKE 'CMP-1' THEN
        IF (SELECT MAX(num_comprobante) FROM recibos WHERE num_comprobante LIKE '%B%') IS NOT NULL THEN
            SET salida = num_comprobante('B');
        ELSE
            SET salida = 'B001-00000001';
        END IF;
    ELSEIF input_id_com LIKE 'CMP-2' THEN
        IF (SELECT MAX(num_comprobante) FROM recibos WHERE num_comprobante LIKE '%F%') IS NOT NULL THEN
            SET salida = num_comprobante('F');
        ELSE
            SET salida = 'F001-00000001';
        END IF;
    END IF;

    RETURN salida;
END //
DELIMITER ;

#SELECT generar_serie_comprobante('CMP-2');
