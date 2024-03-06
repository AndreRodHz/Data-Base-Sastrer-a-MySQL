#DROP PROCEDURE obtener_nuevo_id_producto
DELIMITER //
CREATE PROCEDURE obtener_nuevo_id_producto(OUT nuevo_id VARCHAR(15))
BEGIN
    DECLARE salida VARCHAR(15);
    DECLARE ultimo_num INT;

    DECLARE EXIT HANDLER FOR NOT FOUND
    BEGIN
        SET salida = 'PRO-1';
    END;

    IF EXISTS (SELECT 1 FROM productos) THEN
        SELECT CONVERT(SUBSTRING(id_producto, 5, LENGTH(id_producto)), SIGNED) INTO ultimo_num
        FROM productos
        ORDER BY CONVERT(SUBSTRING(id_producto, 5, LENGTH(id_producto)), SIGNED) DESC
        LIMIT 1;

        SET salida = CONCAT('PRO-', ultimo_num + 1);
    ELSE
        SET salida = 'PRO-1';
    END IF;

    SET nuevo_id = salida;
END //
DELIMITER ;

SET @nuevo_id = NULL;
CALL obtener_nuevo_id_producto(@nuevo_id);
SELECT @nuevo_id;