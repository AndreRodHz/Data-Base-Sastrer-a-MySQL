DELIMITER //
#DROP TRIGGER entrada_empleado
CREATE TRIGGER entrada_empleado
AFTER INSERT ON empleados
FOR EACH ROW
BEGIN
    DECLARE password_hash VARBINARY(255);
    SET password_hash = NEW.password_e;

    UPDATE empleados
    SET
        nombre_e = capitalizador(NEW.nombre_e),
        password_e = SHA2(password_hash, 512),
        email_e =
            CASE 
                WHEN NEW.email_e IS NOT NULL AND LOCATE('@', NEW.email_e) > 0 THEN
                    CONCAT(
                        SUBSTRING_INDEX(NEW.email_e, '@', 1),
                        '@',
                        LOWER(SUBSTRING_INDEX(NEW.email_e, '@', -1))
                    )
                ELSE
                    NEW.email_e
            END
    WHERE id_empleado = NEW.id_empleado;
END //
DELIMITER ;
