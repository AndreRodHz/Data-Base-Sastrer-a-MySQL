DELIMITER //
CREATE FUNCTION num_comprobante (inputString VARCHAR(5))
RETURNS VARCHAR(15)
DETERMINISTIC
NO SQL
BEGIN
    DECLARE input_num_comp VARCHAR(20);
    DECLARE primera VARCHAR(4);
    DECLARE segunda VARCHAR(8);
    DECLARE seg_num INT;
    DECLARE seg_salida VARCHAR(8);
    DECLARE pri_salida_pos VARCHAR(3);
    DECLARE letra VARCHAR(1);
    DECLARE pri_digito INT;
    DECLARE result VARCHAR(13);

    SET input_num_comp = (SELECT MAX(num_comprobante) FROM recibos WHERE num_comprobante LIKE CONCAT('%', inputString, '%'));
    SET primera = SUBSTRING_INDEX(input_num_comp, '-', 1);
    SET segunda = SUBSTRING_INDEX(input_num_comp, '-', -1);
    SET seg_num = CAST(segunda AS SIGNED);

    IF seg_num + 1 = 100000000 THEN
        SET letra = SUBSTRING(primera, 1, 1);
        SET pri_digito = CAST(SUBSTRING(primera, 2, 3) AS SIGNED);
        SET pri_salida_pos = LPAD(pri_digito + 1, 3, '0');
        SET seg_salida = LPAD(1, 8, '0');
        SET result = CONCAT(letra, pri_salida_pos, '-', seg_salida);
    ELSE
        SET seg_salida = LPAD(seg_num + 1, 8, '0');
        SET result = CONCAT(primera, '-', seg_salida);
    END IF;

    RETURN result;
END //
DELIMITER ;

#SELECT num_comprobante('V');
