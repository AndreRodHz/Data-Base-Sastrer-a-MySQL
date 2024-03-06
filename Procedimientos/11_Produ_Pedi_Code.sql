#DROP PROCEDURE obtener_nuevo_id_pro_pedi
DELIMITER //
CREATE PROCEDURE obtener_nuevo_id_pro_pedi(OUT nuevo_id VARCHAR(15))
BEGIN
    DECLARE salida VARCHAR(15);
    DECLARE ultimo_num INT;

    DECLARE EXIT HANDLER FOR NOT FOUND
    BEGIN
        SET salida = 'PRP-1';
    END;

    IF EXISTS (SELECT 1 FROM productos_pedidos) THEN
        SELECT CONVERT(SUBSTRING(id_prod_pedi, 5, LENGTH(id_prod_pedi)), SIGNED) INTO ultimo_num
        FROM productos_pedidos
        ORDER BY CONVERT(SUBSTRING(id_prod_pedi, 5, LENGTH(id_prod_pedi)), SIGNED) DESC
        LIMIT 1;

        SET salida = CONCAT('PRP-', ultimo_num + 1);
    ELSE
        SET salida = 'PRP-1';
    END IF;

    SET nuevo_id = salida;
END //
DELIMITER ;

SET @nuevo_id = NULL;
CALL obtener_nuevo_id_pro_pedi(@nuevo_id);
SELECT @nuevo_id;