#DROP PROCEDURE obtener_nuevo_id_comprobante
DELIMITER //
CREATE PROCEDURE obtener_nuevo_id_comprobante(OUT nuevo_id VARCHAR(15))
BEGIN
    DECLARE salida VARCHAR(15);
    DECLARE ultimo_num INT;

    DECLARE EXIT HANDLER FOR NOT FOUND
    BEGIN
        SET salida = 'CMP-1';
    END;

    IF EXISTS (SELECT 1 FROM comprobantes) THEN
        SELECT CONVERT(SUBSTRING(id_comprobante, 5, LENGTH(id_comprobante)), SIGNED) INTO ultimo_num
        FROM comprobantes
        ORDER BY CONVERT(SUBSTRING(id_comprobante, 5, LENGTH(id_comprobante)), SIGNED) DESC
        LIMIT 1;

        SET salida = CONCAT('CMP-', ultimo_num + 1);
    ELSE
        SET salida = 'CMP-1';
    END IF;

    SET nuevo_id = salida;
END //
DELIMITER ;

SET @nuevo_id = NULL;
CALL obtener_nuevo_id_comprobante(@nuevo_id);
SELECT @nuevo_id;