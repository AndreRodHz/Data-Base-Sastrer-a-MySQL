#DROP PROCEDURE obtener_nuevo_id_genero
DELIMITER //
CREATE PROCEDURE obtener_nuevo_id_genero(OUT nuevo_id VARCHAR(15))
BEGIN
    DECLARE salida VARCHAR(15);
    DECLARE ultimo_num INT;

    DECLARE EXIT HANDLER FOR NOT FOUND
    BEGIN
        SET salida = 'GEN-1';
    END;

    IF EXISTS (SELECT 1 FROM generos) THEN
        SELECT CONVERT(SUBSTRING(id_genero, 5, LENGTH(id_genero)), SIGNED) INTO ultimo_num
        FROM generos
        ORDER BY CONVERT(SUBSTRING(id_genero, 5, LENGTH(id_genero)), SIGNED) DESC
        LIMIT 1;

        SET salida = CONCAT('GEN-', ultimo_num + 1);
    ELSE
        SET salida = 'GEN-1';
    END IF;

    SET nuevo_id = salida;
END //
DELIMITER ;

SET @nuevo_id = NULL;
CALL obtener_nuevo_id_genero(@nuevo_id);
SELECT @nuevo_id;