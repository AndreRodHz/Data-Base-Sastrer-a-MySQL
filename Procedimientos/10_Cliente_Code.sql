#DROP PROCEDURE obtener_nuevo_id_cliente
DELIMITER //
CREATE PROCEDURE obtener_nuevo_id_cliente(OUT nuevo_id VARCHAR(15))
BEGIN
    DECLARE salida VARCHAR(15);
    DECLARE ultimo_num INT;

    DECLARE EXIT HANDLER FOR NOT FOUND
    BEGIN
        SET salida = 'CLI-1';
    END;

    IF EXISTS (SELECT 1 FROM clientes) THEN
        SELECT CONVERT(SUBSTRING(id_cliente, 5, LENGTH(id_cliente)), SIGNED) INTO ultimo_num
        FROM clientes
        ORDER BY CONVERT(SUBSTRING(id_cliente, 5, LENGTH(id_cliente)), SIGNED) DESC
        LIMIT 1;

        SET salida = CONCAT('CLI-', ultimo_num + 1);
    ELSE
        SET salida = 'CLI-1';
    END IF;

    SET nuevo_id = salida;
END //
DELIMITER ;

SET @nuevo_id = NULL;
CALL obtener_nuevo_id_cliente(@nuevo_id);
SELECT @nuevo_id;