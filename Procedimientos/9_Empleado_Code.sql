#DROP PROCEDURE obtener_nuevo_id_empleado
DELIMITER //
CREATE PROCEDURE obtener_nuevo_id_empleado(OUT nuevo_id VARCHAR(15))
BEGIN
    DECLARE salida VARCHAR(15);
    DECLARE ultimo_num INT;

    DECLARE EXIT HANDLER FOR NOT FOUND
    BEGIN
        SET salida = 'EMP-1';
    END;

    IF EXISTS (SELECT 1 FROM empleados) THEN
        SELECT CONVERT(SUBSTRING(id_empleado, 5, LENGTH(id_empleado)), SIGNED) INTO ultimo_num
        FROM empleados
        ORDER BY CONVERT(SUBSTRING(id_empleado, 5, LENGTH(id_empleado)), SIGNED) DESC
        LIMIT 1;

        SET salida = CONCAT('EMP-', ultimo_num + 1);
    ELSE
        SET salida = 'EMP-1';
    END IF;

    SET nuevo_id = salida;
END //
DELIMITER ;

SET @nuevo_id = NULL;
CALL obtener_nuevo_id_empleado(@nuevo_id);
SELECT @nuevo_id;