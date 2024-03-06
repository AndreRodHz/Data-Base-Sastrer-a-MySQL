#DROP PROCEDURE obtener_nuevo_id_pedido
DELIMITER //
CREATE PROCEDURE obtener_nuevo_id_pedido(OUT nuevo_id VARCHAR(15))
BEGIN
    DECLARE salida VARCHAR(15);
    DECLARE ultimo_num INT;

    DECLARE EXIT HANDLER FOR NOT FOUND
    BEGIN
        SET salida = 'P-1';
    END;

    IF EXISTS (SELECT 1 FROM pedidos) THEN
        SELECT CONVERT(SUBSTRING(id_pedido, 3, LENGTH(id_pedido)), SIGNED) INTO ultimo_num
        FROM pedidos
        ORDER BY CONVERT(SUBSTRING(id_pedido, 3, LENGTH(id_pedido)), SIGNED) DESC
        LIMIT 1;

        SET salida = CONCAT('P-', ultimo_num + 1);
    ELSE
        SET salida = 'P-1';
    END IF;

    SET nuevo_id = salida;
END //
DELIMITER ;

SET @nuevo_id = NULL;
CALL obtener_nuevo_id_pedido(@nuevo_id);
SELECT @nuevo_id;