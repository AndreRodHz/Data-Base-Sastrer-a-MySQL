DELIMITER //
#DROP TRIGGER entrada_cliente
CREATE TRIGGER entrada_cliente
AFTER INSERT ON clientes
FOR EACH ROW
BEGIN
    UPDATE clientes
    SET
        nombre_c = capitalizador(NEW.nombre_c),
        email_c =
            CASE 
                WHEN NEW.email_c IS NOT NULL AND LOCATE('@', NEW.email_c) > 0 THEN
                    CONCAT(
                        SUBSTRING_INDEX(NEW.email_c, '@', 1),
                        '@',
                        LOWER(SUBSTRING_INDEX(NEW.email_c, '@', -1))
                    )
                ELSE
                    NEW.email_c
            END
    WHERE id_cliente = NEW.id_cliente;
END //
DELIMITER ;
