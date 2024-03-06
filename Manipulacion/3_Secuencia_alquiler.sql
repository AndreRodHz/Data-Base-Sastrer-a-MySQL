use sastreria

# =======================================================================================================================================
# CREACION DEL IDENTIFICADOR **TRANSACCION**
# =======================================================================================================================================

# Variables para almacenar los resultados
DECLARE can_proceed INT;

# Comprobar si todas las cantidades son mayores o iguales a la cantidad disponible
SET can_proceed = (
    SELECT COUNT(*) 
    FROM detalle_alquiler da
    JOIN producto p ON da.id_producto_a = p.id_producto
    WHERE da.cantidad_alquiler_a > p.stock_p
);

# Si todas las cantidades son mayores o iguales, iniciar la secuencia de alquiler
IF can_proceed = 0 THEN
    # =======================================================================================================================================
    # CREACION DEL IDENTIFICADOR **TRANSACCION**
    # =======================================================================================================================================
    DECLARE transac_code VARCHAR(15);
    
    CALL ultimo_codigo_transaccion(transac_code);
    
    INSERT INTO transaccion VALUES
        (transac_code, 'Alquiler', NOW());
    
    # =======================================================================================================================================
    # INSERCION DE DATOS PARA LA TABLA **ALQUILER** - GENERACION DEL ALQUILER
    # =======================================================================================================================================
    DECLARE alqui_code VARCHAR(15);
    
    CALL ultimo_codigo_alquiler(alqui_code);
    
    INSERT INTO alquiler VALUES
        (alqui_code, (SELECT id_transac FROM transaccion ORDER BY fecha_t DESC LIMIT 1),
        'CLI-2', 'EMP-2', NOW(), 0, 0, 0);
    
    # =======================================================================================================================================
    # INSERCION EN LA TABLA **DETALLE ALQUILER**
    # ======================================================================================================================================= 
    INSERT INTO detalle_alquiler VALUES
        (alqui_code, 'PRO-1', (SELECT precio_p FROM producto WHERE id_producto = 'PRO-1'), 2),
        (alqui_code, 'PRO-2', (SELECT precio_p FROM producto WHERE id_producto = 'PRO-2'), 1);
    
    # =======================================================================================================================================
    # ACTUALIZACION DE LA TABLA **ALQUILER** CON PRECIOS DEL DETALLE ALQUILER
    # ======================================================================================================================================= 
    UPDATE alquiler
        SET precio_base_a =
            (
            SELECT SUM(precio_u * cantidad_alquiler)
            FROM detalle_alquiler
            WHERE detalle_alquiler.id_alquiler = alquiler.id_alquiler
            )
        WHERE alquiler.id_alquiler = alqui_code;
    
    UPDATE alquiler
        SET impuesto_a = (SELECT precio_base_a FROM alquiler WHERE id_alquiler = alqui_code) * 0.18,
            total_a = (SELECT precio_base_a FROM alquiler WHERE id_alquiler = alqui_code) +
                      (SELECT precio_base_a FROM alquiler WHERE id_alquiler = alqui_code) * 0.18
        WHERE alquiler.id_alquiler = alqui_code;
    
    # =======================================================================================================================================
    # INSERCION EN LA TABLA **RECIBO**
    # ======================================================================================================================================= 
    DECLARE recibo_code VARCHAR(15);
    DECLARE id_compro VARCHAR(15);
    
    CALL ultimo_codigo_recibo(recibo_code);
    SET id_compro = 'CMP-2';
    
    INSERT INTO RECIBO VALUES
        (recibo_code, (SELECT id_transac FROM transaccion ORDER BY fecha_t DESC LIMIT 1), id_compro,
        (SELECT generar_serie_comprobante(id_compro)), NOW(),
        (SELECT precio_base_a FROM alquiler WHERE id_alquiler = (SELECT id_alquiler FROM alquiler ORDER BY fecha_a DESC LIMIT 1)),
        (SELECT impuesto_a FROM alquiler WHERE id_alquiler = (SELECT id_alquiler FROM alquiler ORDER BY fecha_a DESC LIMIT 1)),
        (SELECT total_a FROM alquiler WHERE id_alquiler = (SELECT id_alquiler FROM alquiler ORDER BY fecha_a DESC LIMIT 1)), 'Pagado');
    
    # =======================================================================================================================================
    # ACTUALIZACION DE PRODUCTOS EN LA TABLA **PRODUCTO**
    # ======================================================================================================================================= 
    UPDATE producto
        SET stock_p = stock_p - detalle_alquiler.cantidad_alquiler_a
        FROM producto
        JOIN detalle_alquiler ON producto.id_producto = detalle_alquiler.id_producto_a
        WHERE detalle_alquiler.id_alquiler = alqui_code;
ELSE
    # Si todas las cantidades NO son mayores o iguales, forzamos el error
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se pueden alquilar productos con cantidades insuficientes.';
END IF;
# =======================================================================================================================================
# =======================================================================================================================================
# =======================================================================================================================================
# Reposicion de stock del producto alquilado
# =======================================================================================================================================
DECLARE alquiler_repuesto varchar(15);
SET alquiler_repuesto = 'A-1';
UPDATE producto
    SET stock_p = stock_p + detalle_alquiler.cantidad_alquiler_a
    FROM producto
    JOIN detalle_alquiler ON producto.id_producto = detalle_alquiler.id_producto_a
    WHERE detalle_alquiler.id_alquiler = alquiler_repuesto;
# =======================================================================================================================================
# =======================================================================================================================================
# =======================================================================================================================================
# SELECT para obtener la matriz de cara al usuario
# =======================================================================================================================================
SELECT alquiler.id_alquiler AS 'ID Alquiler', id_recibo AS 'ID Recibo', alquiler.id_transac AS 'ID Transaccion',
       id_empleado AS 'ID Empleado', alquiler.id_cliente AS 'ID Cliente', num_doc_c AS 'N° Documento Cliente',
       nombre_c AS 'Cliente', nombre_com AS 'Comprobante',  num_comprobante AS 'N° Comprobante',fecha_a AS 'Fecha',
       precio_base_a AS 'Precio Base', impuesto_a AS 'Impuesto', total_a AS 'Total'
FROM alquiler
JOIN cliente ON alquiler.id_cliente = cliente.id_cliente
JOIN recibo ON alquiler.id_transac = recibo.id_transac
JOIN comprobante ON recibo.id_comprobante = comprobante.id_comprobante
ORDER BY CONVERT(id_alquiler, SIGNED) DESC;
# =======================================================================================================================================
# =======================================================================================================================================
SELECT * FROM transaccion ORDER BY fecha_t DESC;
SELECT * FROM alquiler ORDER BY fecha_a DESC;
SELECT * FROM detalle_alquiler;
SELECT * FROM producto;
SELECT * FROM recibo ORDER BY fecha_recibo DESC;
