#DROP PROCEDURE obtener_nuevo_id_recibo
DELIMITER //
CREATE PROCEDURE obtener_nuevo_id_recibo(OUT nuevo_id VARCHAR(15))
BEGIN
    DECLARE salida VARCHAR(15);
    DECLARE ultimo_num INT;

    DECLARE EXIT HANDLER FOR NOT FOUND
    BEGIN
        SET salida = 'R-1';
    END;

    IF EXISTS (SELECT 1 FROM recibos) THEN
        SELECT CONVERT(SUBSTRING(id_recibo, 3, LENGTH(id_recibo)), SIGNED) INTO ultimo_num
        FROM recibos
        ORDER BY CONVERT(SUBSTRING(id_recibo, 3, LENGTH(id_recibo)), SIGNED) DESC
        LIMIT 1;

        SET salida = CONCAT('R-', ultimo_num + 1);
    ELSE
        SET salida = 'R-1';
    END IF;

    SET nuevo_id = salida;
END //
DELIMITER ;

SET @nuevo_id = NULL;
CALL obtener_nuevo_id_recibo(@nuevo_id);
SELECT @nuevo_id;