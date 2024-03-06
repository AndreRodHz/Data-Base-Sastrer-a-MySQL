#DROP PROCEDURE obtener_nuevo_id_transac
DELIMITER //
CREATE PROCEDURE obtener_nuevo_id_transac(OUT nuevo_id VARCHAR(15))
BEGIN
    DECLARE salida VARCHAR(15);
    DECLARE ultimo_num INT;

    DECLARE EXIT HANDLER FOR NOT FOUND
    BEGIN
        SET salida = 'T-1';
    END;

    IF EXISTS (SELECT 1 FROM transacciones) THEN
        SELECT CONVERT(SUBSTRING(id_transac, 3, LENGTH(id_transac)), SIGNED) INTO ultimo_num
        FROM transacciones
        ORDER BY CONVERT(SUBSTRING(id_transac, 3, LENGTH(id_transac)), SIGNED) DESC
        LIMIT 1;

        SET salida = CONCAT('T-', ultimo_num + 1);
    ELSE
        SET salida = 'T-1';
    END IF;

    SET nuevo_id = salida;
END //
DELIMITER ;

SET @nuevo_id = NULL;
CALL obtener_nuevo_id_transac(@nuevo_id);
SELECT @nuevo_id;