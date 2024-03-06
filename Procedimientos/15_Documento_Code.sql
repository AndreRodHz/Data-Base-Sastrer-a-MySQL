#DROP PROCEDURE obtener_nuevo_id_documento
DELIMITER //
CREATE PROCEDURE obtener_nuevo_id_documento(OUT nuevo_id VARCHAR(15))
BEGIN
    DECLARE salida VARCHAR(15);
    DECLARE ultimo_num INT;

    DECLARE EXIT HANDLER FOR NOT FOUND
    BEGIN
        SET salida = 'DOC-1';
    END;

    IF EXISTS (SELECT 1 FROM documentos) THEN
        SELECT CONVERT(SUBSTRING(id_documento, 5, LENGTH(id_documento)), SIGNED) INTO ultimo_num
        FROM documentos
        ORDER BY CONVERT(SUBSTRING(id_documento, 5, LENGTH(id_documento)), SIGNED) DESC
        LIMIT 1;

        SET salida = CONCAT('DOC-', ultimo_num + 1);
    ELSE
        SET salida = 'DOC-1';
    END IF;

    SET nuevo_id = salida;
END //
DELIMITER ;

SET @nuevo_id = NULL;
CALL obtener_nuevo_id_documento(@nuevo_id);
SELECT @nuevo_id;