#DROP PROCEDURE obtener_nuevo_id_categoria
DELIMITER //
CREATE PROCEDURE obtener_nuevo_id_categoria(OUT nuevo_id VARCHAR(15))
BEGIN
    DECLARE salida VARCHAR(15);
    DECLARE ultimo_num INT;

    DECLARE EXIT HANDLER FOR NOT FOUND
    BEGIN
        SET salida = 'CTG-1';
    END;

    IF EXISTS (SELECT 1 FROM categorias) THEN
        SELECT CONVERT(SUBSTRING(id_categoria, 5, LENGTH(id_categoria)), SIGNED) INTO ultimo_num
        FROM categorias
        ORDER BY CONVERT(SUBSTRING(id_categoria, 5, LENGTH(id_categoria)), SIGNED) DESC
        LIMIT 1;

        SET salida = CONCAT('CTG-', ultimo_num + 1);
    ELSE
        SET salida = 'CTG-1';
    END IF;

    SET nuevo_id = salida;
END //
DELIMITER ;

SET @nuevo_id = NULL;
CALL obtener_nuevo_id_categoria(@nuevo_id);
SELECT @nuevo_id;