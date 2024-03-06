use sastreria
# =======================================================================================================================================
# CREACION DEL VERIFICADOR CON RESPECTO AL STOCK DE LOS PRODUCTOS
# =======================================================================================================================================

# Variables para almacenar los resultados
DECLARE can_proceed INT;

# Comprobar si todas las cantidades son mayores o iguales a la cantidad disponible
SET can_proceed = (
    SELECT COUNT(*) 
    FROM detalle_venta dv
    JOIN producto p ON dv.id_producto_v = p.id_producto
    WHERE dv.cantidad_venta_v > p.stock_p
);

# Si todas las cantidades son mayores o iguales, iniciar la secuencia de venta
IF can_proceed = 0 THEN
    # =======================================================================================================================================
    # CREACION DEL IDENTIFICADOR **TRANSACCION**
    # =======================================================================================================================================
    DECLARE transac_code VARCHAR(15);
    
    CALL ultimo_codigo_transaccion(transac_code);
    
    INSERT INTO transaccion VALUES
        (transac_code, 'Venta', NOW());
    
    # =======================================================================================================================================
    # INSERCION DE DATOS PARA LA TABLA **VENTA** - GENERACION DE LA VENTA
    # =======================================================================================================================================
    DECLARE venta_code VARCHAR(15);
    
    CALL ultimo_codigo_venta(venta_code);
    
    INSERT INTO venta VALUES
        (venta_code, (SELECT id_transac FROM transaccion ORDER BY fecha_t DESC LIMIT 1),
        'CLI-2', 'EMP-2', NOW(), 0, 0, 0);
    
    # =======================================================================================================================================
    # INSERCION EN LA DE LOS PRODCTOS DE VENTA **DETALLE VENTA**
    # ======================================================================================================================================= 
    INSERT INTO detalle_venta VALUES
        (venta_code, 'PRO-1', (SELECT precio_p FROM producto WHERE id_producto = 'PRO-1'), 3),
        (venta_code, 'PRO-4', (SELECT precio_p FROM producto WHERE id_producto = 'PRO-4'), 4);
    
    # =======================================================================================================================================
    # ACTUALIZACION DE LA TABLA **VENTA** CON PRECIOS DEL DETALLE VENTA
    # ======================================================================================================================================= 
    UPDATE venta
        SET precio_base_v =
            (
            SELECT SUM(precio_u * cantidad_venta)
            FROM detalle_venta
            WHERE detalle_venta.id_venta = venta.id_venta
            )
        WHERE venta.id_venta = venta_code;
    
    UPDATE venta
        SET impuesto_v = (SELECT precio_base_v FROM venta WHERE id_venta = venta_code) * 0.18,
            total_v = (SELECT precio_base_v FROM venta WHERE id_venta = venta_code) +
                      (SELECT precio_base_v FROM venta WHERE id_venta = venta_code) * 0.18
        WHERE venta.id_venta = venta_code;
    
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
        (SELECT precio_base_v FROM venta WHERE id_venta = (SELECT id_venta FROM venta ORDER BY fecha_v DESC LIMIT 1)), 
        (SELECT impuesto_v FROM venta WHERE id_venta = (SELECT id_venta FROM venta ORDER BY fecha_v DESC LIMIT 1)), 
        (SELECT total_v FROM venta WHERE id_venta = (SELECT id_venta FROM venta ORDER BY fecha_v DESC LIMIT 1)), 'Pagado');
    
    # =======================================================================================================================================
    # ACTUALIZACION DE PRODUCTOS EN LA TABLA **PRODUCTO**
    # ======================================================================================================================================= 
    UPDATE producto
        SET stock_p = stock_p - detalle_venta.cantidad_venta_v
        FROM producto
        JOIN detalle_venta ON producto.id_producto = detalle_venta.id_producto_v
        WHERE detalle_venta.id_venta = venta_code;
ELSE
    # Si todas las cantidades NO son mayores o iguales, forzamos el error
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se pueden vender productos con cantidades insuficientes.';
END IF;
# =======================================================================================================================================
# =======================================================================================================================================
SELECT venta.id_venta AS 'ID Venta', id_recibo AS 'ID Recibo', venta.id_transac AS 'ID Transaccion',
       id_empleado AS 'ID Empleado', venta.id_cliente AS 'ID Cliente', num_doc_c AS 'N° Documento Cliente',
       nombre_c AS 'Cliente', nombre_com AS 'Comprobante', num_comprobante AS 'N° Comprobante',fecha_v AS 'Fecha',
       precio_base_v AS 'Precio BASe', impuesto_v AS 'Impuesto', total_v AS 'Total'
FROM venta
JOIN cliente ON venta.id_cliente = cliente.id_cliente
JOIN recibo ON venta.id_transac = recibo.id_transac
JOIN comprobante ON recibo.id_comprobante = comprobante.id_comprobante
ORDER BY CONVERT(id_venta, SIGNED) DESC;
# =======================================================================================================================================
# =======================================================================================================================================
SELECT * FROM transaccion ORDER BY fecha_t DESC;
SELECT * FROM venta ORDER BY fecha_v DESC;
SELECT * FROM detalle_venta;
SELECT * FROM producto;
SELECT * FROM recibo ORDER BY fecha_recibo DESC;
