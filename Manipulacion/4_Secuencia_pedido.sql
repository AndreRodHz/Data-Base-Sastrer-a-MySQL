use sastreria

# =======================================================================================================================================
# CREACION DEL IDENTIFICADOR **TRANSACCION**
# =======================================================================================================================================
DECLARE transac_code VARCHAR(15);

CALL ultimo_codigo_transaccion(transac_code);

INSERT INTO transaccion VALUES
    (transac_code, 'Pedido', NOW());
    
# =======================================================================================================================================
# INSERCION DE DATOS PARA LA TABLA **PEDIDO** - GENERACION DEL PEDIDO
# =======================================================================================================================================
DECLARE pedido_code VARCHAR(15);

CALL ultimo_codigo_pedido(pedido_code);

INSERT INTO pedido VALUES
    (pedido_code, (SELECT id_transac FROM transaccion ORDER BY fecha_t DESC LIMIT 1),
    'CLI-2', 'EMP-1', NOW(), 'Para niño de 10 años', 0, 0, 0);
    
# =======================================================================================================================================
# INSERCION EN LA TABLA **DETALLE PEDIDO**
# =======================================================================================================================================
INSERT INTO detalle_pedido VALUES
    (pedido_code, 'PRP-1', 'TLA-3', 1.1, 100),
    (pedido_code, 'PRP-2', 'TLA-2', 1.4, 265),
    (pedido_code, 'PRP-3', 'TLA-1', 1, 130);
    
# =======================================================================================================================================
# ACTUALIZACION DE LA TABLA **PEDIDO** CON PRECIOS DEL DETALLE PEDIDO
# =======================================================================================================================================
UPDATE pedido
    SET precio_base_p =
    (
        SELECT SUM(precio_d_pp)
        FROM detalle_pedido
        WHERE detalle_pedido.id_pedido = pedido.id_pedido
    )
WHERE pedido.id_pedido = pedido_code;

UPDATE pedido
    SET impuesto_p = (SELECT precio_base_p FROM pedido WHERE id_pedido = pedido_code) * 0.18,
        total_p = (SELECT precio_base_p FROM pedido WHERE id_pedido = pedido_code) +
                  (SELECT precio_base_p FROM pedido WHERE id_pedido = pedido_code) * 0.18
    WHERE pedido.id_pedido = pedido_code;
    
# =======================================================================================================================================
# INSERCION EN LA TABLA **RECIBO**
# =======================================================================================================================================
DECLARE recibo_code VARCHAR(15);
DECLARE id_compro VARCHAR(15);

CALL ultimo_codigo_recibo(recibo_code);
SET id_compro = 'CMP-1';

INSERT INTO RECIBO VALUES
(
    recibo_code, (SELECT id_transac FROM transaccion ORDER BY fecha_t DESC LIMIT 1),
    id_compro, (SELECT generar_serie_comprobante(id_compro)), NOW(),
    (SELECT precio_base_p FROM pedido WHERE id_pedido = (SELECT id_pedido FROM pedido ORDER BY fecha_p DESC LIMIT 1)),
    (SELECT impuesto_p FROM pedido WHERE id_pedido = (SELECT id_pedido FROM pedido ORDER BY fecha_p DESC LIMIT 1)),
    (SELECT total_p FROM pedido WHERE id_pedido = (SELECT id_pedido FROM pedido ORDER BY fecha_p DESC LIMIT 1)), 'Pagado'
);

# =======================================================================================================================================
# ACTUALIZACION DE METRAJE EN LA TABLA **TELA**
# =======================================================================================================================================
UPDATE tela
JOIN detalle_pedido ON tela.id_tela = detalle_pedido.id_tela
SET largo = largo - detalle_pedido.largo_tela
WHERE detalle_pedido.id_pedido = pedido_code;

# =======================================================================================================================================
# SELECT para obtener la matriz de cara al usuario
# =======================================================================================================================================
SELECT pedido.id_pedido AS 'ID Pedido', id_recibo AS 'ID Recibo',  pedido.id_transac AS 'ID Transaccion', id_empleado AS 'ID Empleado',
       pedido.id_cliente AS 'ID Cliente', num_doc_c AS 'N° Documento Cliente', nombre_c AS 'Cliente', nombre_com AS 'Comprobante',
       num_comprobante AS 'N° Comprobante', fecha_p AS 'Fecha', DESCrip AS 'Descripcion', precio_base_p AS 'Precio Base',
       impuesto_p AS 'Impuesto', total_p AS 'Total'
FROM pedido
JOIN cliente ON pedido.id_cliente = cliente.id_cliente
JOIN recibo ON pedido.id_transac = recibo.id_transac
JOIN comprobante ON recibo.id_comprobante = comprobante.id_comprobante
ORDER BY CONVERT(SUBSTRING(pedido.id_pedido, 3), SIGNED) DESC;
# =======================================================================================================================================
# =======================================================================================================================================
SELECT * FROM transaccion ORDER BY fecha_t DESC;
SELECT * FROM pedido ORDER BY fecha_p DESC;
SELECT * FROM detalle_pedido WHERE id_pedido = pedido_code;
SELECT * FROM tela;
SELECT * FROM recibo ORDER BY fecha_recibo DESC;
