#DROP PROCEDURE obtener_nuevo_id_alquiler
DELIMITER //
CREATE PROCEDURE obtener_nuevo_id_alquiler(OUT nuevo_id VARCHAR(15))
BEGIN
    DECLARE salida VARCHAR(15);
    DECLARE ultimo_num INT;

    DECLARE EXIT HANDLER FOR NOT FOUND
    BEGIN
        SET salida = 'A-1';
    END;

    IF EXISTS (SELECT 1 FROM alquileres) THEN
        SELECT CONVERT(SUBSTRING(id_alquiler, 3, LENGTH(id_alquiler)), SIGNED) INTO ultimo_num
        FROM alquileres
        ORDER BY CONVERT(SUBSTRING(id_alquiler, 3, LENGTH(id_alquiler)), SIGNED) DESC
        LIMIT 1;

        SET salida = CONCAT('A-', ultimo_num + 1);
    ELSE
        SET salida = 'A-1';
    END IF;

    SET nuevo_id = salida;
END //
DELIMITER ;

SET @nuevo_id = NULL;
CALL obtener_nuevo_id_alquiler(@nuevo_id);
SELECT @nuevo_id;