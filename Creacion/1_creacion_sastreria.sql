USE Sastreria;

DROP TABLE detalles_recibos; #si pero diferente
DROP TABLE recibos; #si pero diferente
DROP TABLE detalles_ventas; #si pero diferente
DROP TABLE detalles_alquileres; #si pero diferente
DROP TABLE alquileres; #si
DROP TABLE ventas; #si
DROP TABLE detalles_pedidos; #si pero diferente
DROP TABLE productos_pedidos; #si pero diferente
DROP TABLE inferiores; #si
DROP TABLE superiores; #si
DROP TABLE pedidos; #si
DROP TABLE transacciones; #si pero diferente
DROP TABLE comprobantes; #no
DROP TABLE empleados; #si
DROP TABLE roles; #no
DROP TABLE clientes; #si
DROP TABLE documentos; #no
DROP TABLE generos; #no
DROP TABLE productos; #si
DROP TABLE condiciones; #no
DROP TABLE categorias; #si
DROP TABLE proveedores; #si

# Creación de la tabla proveedores
CREATE TABLE proveedores(
    id_proveedor VARCHAR(15) PRIMARY KEY,
    razon_social VARCHAR(50) NOT NULL,
    ruc_prov VARCHAR(15) NOT NULL,
    dir_prov VARCHAR(255),
    telef_prov VARCHAR(10),
    contacto VARCHAR(50),
    correo_prov VARCHAR(255),
    fecha DATETIME NOT NULL,
    UNIQUE (ruc_prov)
);

# Creación de la tabla categorias
CREATE TABLE categorias(
    id_categoria VARCHAR(15) PRIMARY KEY,
    nombre_cate VARCHAR(50) NOT NULL,
    descrip_cate VARCHAR(255)
);

# Creación de la tabla condiciones
CREATE TABLE condiciones(	
    id_condicion VARCHAR(15) PRIMARY KEY,
    nombre_condi VARCHAR(50) NOT NULL,
    descrip_condi VARCHAR(255)
);

# Creación de la tabla productos
CREATE TABLE productos(
    id_producto VARCHAR(15) PRIMARY KEY,
    id_proveedor VARCHAR(15) NOT NULL,
    nombre_p VARCHAR(50) NOT NULL,
    descrip_p VARCHAR(255),
    talla VARCHAR(15) NOT NULL,
    id_categoria VARCHAR(15) NOT NULL,
    id_condicion VARCHAR(15) NOT NULL,
    precio_p NUMERIC(18,2) NOT NULL,
    stock_p INT NOT NULL,
    fecha DATETIME NOT NULL,
    FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor),
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria),
    FOREIGN KEY (id_condicion) REFERENCES condiciones(id_condicion),
    CHECK (precio_p >= 0),
    CHECK (stock_p >= 0)
);

# Creación de la tabla generos
CREATE TABLE generos(
    id_genero VARCHAR(15) PRIMARY KEY,
    nombre_gen VARCHAR(50) NOT NULL
);

# Creación de la tabla documentos
CREATE TABLE documentos(
    id_documento VARCHAR(15) PRIMARY KEY,
    nombre_doc VARCHAR(50) NOT NULL
);

# Creación de la tabla clientes
CREATE TABLE clientes(
    id_cliente VARCHAR(15) PRIMARY KEY,
    nombre_c VARCHAR(50) NOT NULL,
    id_genero VARCHAR(15) NOT NULL,
    id_documento VARCHAR(15) NOT NULL,
    num_doc_c VARCHAR(20) NOT NULL,
    telefono_c VARCHAR(15),
    email_c VARCHAR(255),
    fecha DATETIME NOT NULL,
    FOREIGN KEY (id_genero) REFERENCES generos(id_genero),
    FOREIGN KEY (id_documento) REFERENCES documentos(id_documento),
    UNIQUE (num_doc_c)
);

CREATE TABLE roles(
	id_rol VARCHAR(10) PRIMARY KEY,
    nombre_rol VARCHAR(30) NOT NULL
);

# Creación de la tabla empleados
CREATE TABLE empleados(
    id_empleado VARCHAR(15) PRIMARY KEY,
    id_rol VARCHAR(10) NOT NULL,
    nombre_e VARCHAR(50) NOT NULL,
    id_genero VARCHAR(15) NOT NULL,
    id_documento VARCHAR(15) NOT NULL,
    num_doc_e VARCHAR(20) NOT NULL,
    telefono_e VARCHAR(15) NOT NULL,
    direccion_e VARCHAR(255),
    email_e VARCHAR(255) NOT NULL,
    password_e VARCHAR(255) NOT NULL,
    fecha DATETIME NOT NULL,
    FOREIGN KEY (id_rol) REFERENCES roles(id_rol),
    FOREIGN KEY (id_genero) REFERENCES generos(id_genero),
    FOREIGN KEY (id_documento) REFERENCES documentos(id_documento),
    UNIQUE (num_doc_e),
    UNIQUE (email_e)
);

# Creación de la tabla comprobantes
CREATE TABLE comprobantes(
    id_comprobante VARCHAR(15) PRIMARY KEY,
    nombre_com VARCHAR(50)
);

# Creación de la tabla productos_pedidos
CREATE TABLE productos_pedidos(
    id_prod_pedi VARCHAR(15) PRIMARY KEY,
    nombre_pp VARCHAR(50) NOT NULL,
    descripcion_pp VARCHAR(255)
);

# Creación de la tabla transacciones
CREATE TABLE transacciones(
    id_transac VARCHAR(15) PRIMARY KEY,
    tipo_transac VARCHAR(25) NOT NULL,
    fecha_t DATETIME NOT NULL,
    monto NUMERIC(18,2) NOT NULL,
    id_operacion VARCHAR(15) NOT NULL,
    UNIQUE (id_operacion)
);

# Creación de la tabla pedidos
CREATE TABLE pedidos(
    id_pedido VARCHAR(15) PRIMARY KEY,
    id_transac VARCHAR(15) NOT NULL,
    id_cliente VARCHAR(15) NOT NULL,
    id_empleado VARCHAR(15) NOT NULL,
    fecha_p DATETIME NOT NULL,
    descrip VARCHAR(255),
    total_p NUMERIC(18,2) NOT NULL,
    FOREIGN KEY (id_transac) REFERENCES transacciones(id_transac),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
    UNIQUE (id_transac)
);

# Creación de la tabla detalles_pedidos
CREATE TABLE detalles_pedidos(
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido VARCHAR(15) NOT NULL,
    id_prod_pedi VARCHAR(15) NOT NULL,
    descrip_d_pp VARCHAR(255),
    precio_d_pp NUMERIC(18,3) NOT NULL,
    cantidad_d_pp INT NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_prod_pedi) REFERENCES productos_pedidos(id_prod_pedi)
);

# Creación de la tabla superiores
CREATE TABLE superiores(
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido VARCHAR(15),
    cuello NUMERIC(18,2),
    longitud NUMERIC(18,2),
    hombros NUMERIC(18,2),
    sisa NUMERIC(18,2),
    biceps NUMERIC(18,2),
    pecho NUMERIC(18,2),
    brazos NUMERIC(18,2),
    largo_cha NUMERIC(18,2),
    largo_abri NUMERIC(18,2),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    UNIQUE (id_pedido)
);

# Creación de la tabla inferiores
CREATE TABLE inferiores(
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido VARCHAR(15),
    caderas NUMERIC(18,2),
    largo NUMERIC(18,2),
    tiro NUMERIC(18,2),
    posicion NUMERIC(18,2),
    muslos NUMERIC(18,2),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    UNIQUE (id_pedido)
);

# Creación de la tabla ventas
CREATE TABLE ventas(
    id_venta VARCHAR(15) PRIMARY KEY,
    id_transac VARCHAR(15) NOT NULL,
    id_cliente VARCHAR(15) NOT NULL,
    id_empleado VARCHAR(15) NOT NULL,
    fecha_v DATETIME NOT NULL,
    total_v NUMERIC(18,2) NOT NULL,
    FOREIGN KEY (id_transac) REFERENCES transacciones(id_transac),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
    UNIQUE (id_transac)
);

# Creación de la tabla detalles_ventas
CREATE TABLE detalles_ventas(
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_venta VARCHAR(15) NOT NULL,
    id_producto VARCHAR(15) NOT NULL,
    precio_u NUMERIC(18,2) NOT NULL,
    cantidad_venta INT NOT NULL,
    FOREIGN KEY (id_venta) REFERENCES ventas(id_venta),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

# Creación de la tabla alquileres
CREATE TABLE alquileres(
    id_alquiler VARCHAR(15) PRIMARY KEY,
    id_transac VARCHAR(15) NOT NULL,
    id_cliente VARCHAR(15) NOT NULL,
    id_empleado VARCHAR(15) NOT NULL,
    estado VARCHAR(15) NOT NULL,
    fecha_a DATETIME NOT NULL,
    total_a NUMERIC(18,2) NOT NULL,
    FOREIGN KEY (id_transac) REFERENCES transacciones(id_transac),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
    UNIQUE (id_transac)
);

CREATE TABLE detalles_alquileres(
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_alquiler VARCHAR(15) NOT NULL,
    id_producto VARCHAR(15) NOT NULL,
	precio_u NUMERIC(18,2) NOT NULL,
    cantidad_alquiler INT NOT NULL,
    FOREIGN KEY (id_alquiler) REFERENCES alquileres(id_alquiler),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

#ADICIONAL-------------------------------
# Creación de la tabla recibos
CREATE TABLE recibos(
    id_recibo VARCHAR(15) PRIMARY KEY,
    id_cliente VARCHAR(15) NOT NULL,
    id_comprobante VARCHAR(15) NOT NULL,
    num_comprobante VARCHAR(20) NOT NULL,
    fecha_recibo DATETIME NOT NULL,
    base_rec NUMERIC(18,2) NOT NULL,
    impuesto_rec NUMERIC(18,2) NOT NULL,
    total_rec NUMERIC(18,2) NOT NULL,
    estado varchar(20) NOT NULL,
    id_empleado VARCHAR(15) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_comprobante) REFERENCES comprobantes(id_comprobante),
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
    UNIQUE (num_comprobante)
);

CREATE TABLE detalles_recibos(
	id INT AUTO_INCREMENT PRIMARY KEY,
    id_recibo VARCHAR(15) NOT NULL,
    id_transac VARCHAR(15) NOT NULL,
    monto NUMERIC(18,2) NOT NULL,
    FOREIGN KEY (id_recibo) REFERENCES recibos(id_recibo),
    FOREIGN KEY (id_transac) REFERENCES transacciones(id_transac),
    UNIQUE (id_transac)
);