#DROP PROCEDURE obtener_nuevo_id_tela
DELIMITER //
CREATE PROCEDURE obtener_nuevo_id_tela(OUT nuevo_id VARCHAR(15))
BEGIN
    DECLARE salida VARCHAR(15);
    DECLARE ultimo_num INT;

    DECLARE EXIT HANDLER FOR NOT FOUND
    BEGIN
        SET salida = 'TLA-1';
    END;

    IF EXISTS (SELECT 1 FROM telas) THEN
        SELECT CONVERT(SUBSTRING(id_tela, 5, LENGTH(id_tela)), SIGNED) INTO ultimo_num
        FROM telas
        ORDER BY CONVERT(SUBSTRING(id_tela, 5, LENGTH(id_tela)), SIGNED) DESC
        LIMIT 1;

        SET salida = CONCAT('TLA-', ultimo_num + 1);
    ELSE
        SET salida = 'TLA-1';
    END IF;

    SET nuevo_id = salida;
END //
DELIMITER ;

SET @nuevo_id = NULL;
CALL obtener_nuevo_id_tela(@nuevo_id);
SELECT @nuevo_id;