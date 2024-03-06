#DROP PROCEDURE obtener_nuevo_id_proveedor
DELIMITER //
CREATE PROCEDURE obtener_nuevo_id_proveedor(OUT nuevo_id VARCHAR(15))
BEGIN
    DECLARE salida VARCHAR(15);
    DECLARE ultimo_num INT;

    DECLARE EXIT HANDLER FOR NOT FOUND
    BEGIN
        SET salida = 'PRV-1';
    END;

    IF EXISTS (SELECT 1 FROM proveedores) THEN
        SELECT CONVERT(SUBSTRING(id_proveedor, 5, LENGTH(id_proveedor)), SIGNED) INTO ultimo_num
        FROM proveedores
        ORDER BY CONVERT(SUBSTRING(id_proveedor, 5, LENGTH(id_proveedor)), SIGNED) DESC
        LIMIT 1;

        SET salida = CONCAT('PRV-', ultimo_num + 1);
    ELSE
        SET salida = 'PRV-1';
    END IF;

    SET nuevo_id = salida;
END //
DELIMITER ;

SET @nuevo_id = NULL;
CALL obtener_nuevo_id_proveedor(@nuevo_id);
SELECT @nuevo_id;