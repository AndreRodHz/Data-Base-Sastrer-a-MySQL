DELIMITER //
CREATE TRIGGER alquiler_verificacion_id_transaccion
BEFORE INSERT ON alquileres
FOR EACH ROW
BEGIN
    DECLARE recibo_count INT;

    SELECT COUNT(*) INTO recibo_count
    FROM recibos R
    WHERE R.id_transac = NEW.id_transac;

    IF recibo_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se permite ingresar un id_transaccion que ya existe en la tabla Recibo.';
    END IF;
END //
DELIMITER ;
