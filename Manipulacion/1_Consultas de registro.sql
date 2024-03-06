
# PARA VER LISTA DE EMPLEADOS
SELECT id_empleado AS 'ID Empleado', nombre_e AS 'Nombre', nombre_gen AS 'Genero', nombre_doc AS 'Documento',
	   num_doc_e AS 'N° Documento', telefono_e AS 'Telefono', direccion_e AS 'Domicilio', email_e AS 'Email'
FROM empleados
INNER JOIN generos ON empleados.id_genero = generos.id_genero
INNER JOIN documentos ON empleados.id_documento = documentos.id_documento;

# PARA VER LISTA DE CLIENTES
SELECT id_cliente AS 'ID Cliente', nombre_c AS 'Nombre', nombre_gen AS 'Genero', nombre_doc AS 'Documento',
	   num_doc_c AS 'N° Documento', telefono_c AS 'Telefono', email_c AS 'Email'
FROM clientes
INNER JOIN generos ON clientes.id_genero = generos.id_genero
INNER JOIN documentos ON clientes.id_documento = documentos.id_documento;

# PARA VER LA LISTA DE PRODUCTOS
SELECT id_producto AS 'ID Producto', nombre_p AS 'Nombre', descrip_p AS 'Descripcion', talla AS 'Talla',
	   nombre_cate AS 'Categoria', nombre_condi AS 'Condicion', precio_p AS 'Precio', stock_p AS 'Stock'
FROM productos
INNER JOIN categorias ON productos.id_categoria = categorias.id_categoria
INNER JOIN condiciones ON productos.id_condicion = condiciones.id_condicion