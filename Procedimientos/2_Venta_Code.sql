#DROP PROCEDURE obtener_nuevo_id_venta
DELIMITER //
CREATE PROCEDURE obtener_nuevo_id_venta(OUT nuevo_id VARCHAR(15))
BEGIN
    DECLARE salida VARCHAR(15);
    DECLARE ultimo_num INT;

    DECLARE EXIT HANDLER FOR NOT FOUND
    BEGIN
        SET salida = 'V-1';
    END;

    IF EXISTS (SELECT 1 FROM ventas) THEN
        SELECT CONVERT(SUBSTRING(id_venta, 3, LENGTH(id_venta)), SIGNED) INTO ultimo_num
        FROM ventas
        ORDER BY CONVERT(SUBSTRING(id_venta, 3, LENGTH(id_venta)), SIGNED) DESC
        LIMIT 1;

        SET salida = CONCAT('V-', ultimo_num + 1);
    ELSE
        SET salida = 'V-1';
    END IF;

    SET nuevo_id = salida;
END //
DELIMITER ;

SET @nuevo_id = NULL;
CALL obtener_nuevo_id_venta(@nuevo_id);
SELECT @nuevo_id;