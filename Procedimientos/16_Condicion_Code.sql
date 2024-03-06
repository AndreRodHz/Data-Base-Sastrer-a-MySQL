#DROP PROCEDURE obtener_nuevo_id_condicion
DELIMITER //
CREATE PROCEDURE obtener_nuevo_id_condicion(OUT nuevo_id VARCHAR(15))
BEGIN
    DECLARE salida VARCHAR(15);
    DECLARE ultimo_num INT;

    DECLARE EXIT HANDLER FOR NOT FOUND
    BEGIN
        SET salida = 'CDN-1';
    END;

    IF EXISTS (SELECT 1 FROM condiciones) THEN
        SELECT CONVERT(SUBSTRING(id_condicion, 5, LENGTH(id_condicion)), SIGNED) INTO ultimo_num
        FROM condiciones
        ORDER BY CONVERT(SUBSTRING(id_condicion, 5, LENGTH(id_condicion)), SIGNED) DESC
        LIMIT 1;

        SET salida = CONCAT('CDN-', ultimo_num + 1);
    ELSE
        SET salida = 'CDN-1';
    END IF;

    SET nuevo_id = salida;
END //
DELIMITER ;

SET @nuevo_id = NULL;
CALL obtener_nuevo_id_condicion(@nuevo_id);
SELECT @nuevo_id;