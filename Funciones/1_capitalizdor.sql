DELIMITER $$

CREATE FUNCTION capitalizador (inputString VARCHAR(255))
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE outputString VARCHAR(255) DEFAULT '';
    DECLARE capitalizeNext BOOLEAN DEFAULT TRUE;
    DECLARE charPos INT DEFAULT 1;
    DECLARE charLen INT;

    SET inputString = CONCAT(LOWER(TRIM(inputString)), ' ');
    SET charLen = LENGTH(inputString);

    WHILE charPos <= charLen DO
        SET @char = SUBSTRING(inputString, charPos, 1);

        IF capitalizeNext AND @char REGEXP '[a-z]' THEN
            SET outputString = CONCAT(outputString, UPPER(@char));
            SET capitalizeNext = FALSE;
        ELSEIF @char = ' ' THEN
            SET outputString = CONCAT(outputString, ' ');
            SET capitalizeNext = TRUE;
        ELSE
            SET outputString = CONCAT(outputString, @char);
        END IF;

        SET charPos = charPos + 1;
    END WHILE;

    RETURN outputString;
END$$
DELIMITER ;

#SELECT capitalizador('DOFJSDFJ ndjdha8 HSH');