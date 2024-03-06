USE Sastreria;

#Insercion de datos para la tabla proveedor
INSERT INTO proveedores VALUES
	('PRV-1', 'Telas Diluna', '74926483', 'La Victoria', '987127366', 'Rocio', 'rocio@diluna.com', '2023-10-01 00:00:00.0'),
	('PRV-2', 'Telas Lafayette Lima', '67926371', 'Surquillo', '947420958', 'Javier', 'javier@lafayette.com', '2023-10-02 00:00:00.0'),
	('PRV-3', 'Camisa Rey', '98026590', 'Santiago de Surco', '949217304', 'Ricardo', 'ricardo@camisa.com', '2023-10-03 00:00:00.0'),
	('PRV-4', 'Del Cuero', '12354729', 'Lurin', '849217666', 'Jose', 'jose@delcuero.com', '2023-10-04 00:00:00.0'),
	('PRV-5', 'Viste Bien', '38364900', 'San Juan', '200023947', 'Ana', 'ana@vistebien.com', '2023-10-05 00:00:00.0');

#Insercion de datos para la tabla documento
INSERT INTO documentos VALUES
	('DOC-1', 'DNI'),
	('DOC-2', 'Carnet de Extranjeria');

#Insercion de datos para la tabla genero
INSERT INTO generos VALUES
	('GEN-1', 'Masculino'),
	('GEN-2', 'Femenino'),
	('GEN-3', 'Otro');

#Insercion de datos para la tabla condicion
INSERT INTO condiciones VALUES 
	('CDN-1', 'Nuevo', 'Producto estreno'),
	('CDN-2', 'Usado', 'Producto para alquiler');

#Insercion de datos para la tabla categoria
INSERT INTO categorias VALUES
	('CTG-1', 'Terno Conjunto', 'Producto que se vende con el conjunto completo'),
	('CTG-2', 'Saco de Terno', 'Producto que se vende solo el saco'),
	('CTG-3', 'Camisa', 'Producto de camisa unica'),
	('CTG-4', 'Corbata', 'Producto de corbata unica'),
    ('CTG-5', 'Blazer', 'Saco elegante'),
    ('CTG-6', 'Calzado', 'Zapatos'),
    ('CTG-7', 'Chaleco', 'Formal'),
    ('CTG-8', 'Correa', 'Formal');

INSERT INTO roles VALUES
	('ROL-1', 'Administrador'),
    ('ROL-2', 'Usuario');

#Insercion de datos para la tabla empleado
INSERT INTO empleados VALUES
	('EMP-1', 'ROL-1','Andre Rodriguez', 'GEN-1', 'DOC-1', '00000001', '999999999', 'Av. Los Alamos 437', 'andre601@outlook.es', 'kiro01', '2023-10-01 00:00:00.0'),
	('EMP-2', 'ROL-2','Christian Angeles', 'GEN-1', 'DOC-1', '00000002', '888888888', 'Av. Alamos 437', 'andre520sif@outlook.es', 'benito01', '2023-10-02 00:00:00.0'),
    ('EMP-3', 'ROL-2','Carlos Gebran', 'GEN-1', 'DOC-1', '00000003', '777777777', 'Av. Alamos 437', 'carlos@outlook.es', 'carlos', '2023-10-03 00:00:00.0'),
    ('EMP-4', 'ROL-2','Susana Torres', 'GEN-2', 'DOC-1', '00000004', '666666666', 'Av. Alamos 437', 'susana@outlook.es', 'susana', '2023-10-04 00:00:00.0'),
    ('EMP-5', 'ROL-2','Samantha Peña', 'GEN-2', 'DOC-1', '00000005', '555555555', 'Av. Alamos 437', 'samantha@outlook.es', 'samantha', '2023-10-05 00:00:00.0');
    
#Insercion de datos para la tabla cliente
INSERT INTO clientes VALUES
	('CLI-1', 'Jair Lopez', 'GEN-1', 'DOC-1', '00000006', '99999999', 'lopez@gmail.com', '2023-10-01 00:00:00.0'),
	('CLI-2', 'Mercedes Pesantes', 'GEN-2', 'DOC-1', '00000007', '88888888', 'mercedes@gmail.com', '2023-10-02 00:00:00.0'),
	('CLI-3', 'Anjali Angeles', 'GEN-2', 'DOC-1', '00000008', '99977999', 'lopez626@gmail.com', '2023-10-03 00:00:00.0'),
    ('CLI-4', 'Javier Rengifo', 'GEN-1', 'DOC-1', '00000009', '99999999', 'Javier@gmail.com', '2023-10-04 00:00:00.0'),
	('CLI-5', 'Jose Caral', 'GEN-1', 'DOC-1', '00000010', '88809998', 'Jose@gmail.com', '2023-10-05 00:00:00.0'),
	('CLI-6', 'Jadira Lucre', 'GEN-2', 'DOC-1', '00000011', '29977990', 'Jadira@gmail.com', '2023-10-06 00:00:00.0'),
    ('CLI-7', 'Jairo Mar', 'GEN-1', 'DOC-1', '00000012', '99999999', 'Jairo@gmail.com', '2023-10-07 00:00:00.0'),
	('CLI-8', 'Nayeli Peña', 'GEN-2', 'DOC-1', '00000013', '888834888', 'Nayeli@gmail.com', '2023-10-08 00:00:00.0'),
	('CLI-9', 'Javier Solar', 'GEN-1', 'DOC-1', '00000014', '99557999', 'Javier@gmail.com', '2023-10-09 00:00:00.0'),
    ('CLI-10', 'Marco Damian', 'GEN-1', 'DOC-1', '00000015', '98889999', 'Marco@gmail.com', '2023-10-10 00:00:00.0');

INSERT INTO clientes VALUES
	('CLI-11', 'Fisher', 'GEN-1', 'DOC-1', 'F1', '090999', 'fisher@gmail.com', NOW());

#Insercion de datos para la tabla producto
INSERT INTO productos VALUES
	('PRO-1', 'PRV-5','Corbata blanca', '', 'N','CTG-4', 'CDN-1', 50, 10, '2023-10-01 00:00:00.0'),
	('PRO-2', 'PRV-4', 'Corbata doble cara', '', 'N','CTG-4', 'CDN-1', 60, 10, '2023-10-02 00:00:00.0'),
	('PRO-3', 'PRV-2', 'Corbata dorada', '', 'N','CTG-4', 'CDN-1', 55, 10, '2023-10-03 00:00:00.0'),
	('PRO-4', 'PRV-3', 'Camisa flat negra', '', 'S','CTG-3', 'CDN-1', 90, 10, '2023-10-04 00:00:00.0'),
    ('PRO-5', 'PRV-4', 'Camisa flat doble cuello', '', 'L','CTG-3', 'CDN-1', 93, 10, '2023-10-05 00:00:00.0'),
	('PRO-6', 'PRV-5', 'Camisa entallada azul', '', 'M','CTG-3', 'CDN-1', 102, 10, '2023-10-06 00:00:00.0'),
	('PRO-7', 'PRV-4', 'Blazer negro', '', 'XS','CTG-5', 'CDN-1', 170, 10, '2023-10-07 00:00:00.0'),
	('PRO-8', 'PRV-3', 'Blazer doble color', '', 'M','CTG-5', 'CDN-2', 230, 7, '2023-10-08 00:00:00.0'),
    ('PRO-9', 'PRV-2', 'Terno completo negro', '', 'S','CTG-1', 'CDN-1', 600, 3, '2023-10-09 00:00:00.0'),
	('PRO-10', 'PRV-5', 'Terno completo azul', '', 'L','CTG-1', 'CDN-2', 600, 2, '2023-10-10 00:00:00.0'),
	('PRO-11', 'PRV-3', 'Chaleco rojo', '', 'M','CTG-7', 'CDN-1', 100, 10, '2023-10-1 00:00:00.0'),
	('PRO-12', 'PRV-3', 'Chaleco azul', '', 'M','CTG-7', 'CDN-2', 105, 10, '2023-10-12 00:00:00.0'),
    ('PRO-13', 'PRV-1', 'Chaleco blanco', '', 'S','CTG-7', 'CDN-2', 110, 10, '2023-10-13 00:00:00.0'),
	('PRO-14', 'PRV-5', 'Correa cuero negra', '', 'N','CTG-8', 'CDN-1', 20, 10, '2023-10-14 00:00:00.0'),
	('PRO-15', 'PRV-3', 'Correa cuero marron', '', 'N','CTG-8', 'CDN-1', 20, 10, '2023-10-15 00:00:00.0'),
	('PRO-16', 'PRV-1', 'Correa delgada', '', 'N','CTG-8', 'CDN-1', 15, 15, '2023-10-16 00:00:00.0'),
    ('PRO-17', 'PRV-1', 'Zapato marron', '', '40','CTG-6', 'CDN-1', 110, 6, '2023-10-17 00:00:00.0'),
	('PRO-18', 'PRV-5', 'Zapato bersh', '', '41','CTG-6', 'CDN-1', 100, 6, '2023-10-18 00:00:00.0'),
	('PRO-19', 'PRV-4', 'Zapato negro', '', '42','CTG-6', 'CDN-1', 98, 6, '2023-10-19 00:00:00.0'),
	('PRO-20', 'PRV-1', 'Zapatilla blanca', '', '40','CTG-6', 'CDN-1', 130, 6, '2023-10-20 00:00:00.0');

#Insercion de datos para la tabla comprobante
INSERT INTO comprobantes VALUES
	('CMP-1', 'Boleta'),
	('CMP-2', 'Factura');

#Insercion de datos para la tabla transaccion
INSERT INTO transacciones VALUES
	('T-1', 'Venta', NOW(), 110, 'V-1');

#Insercion de datos para la tabla venta
INSERT INTO ventas VALUES
	('V-1', 'T-1','CLI-1', 'EMP-1', NOW(), 110);

#Insercion de datos para la tabla detalle_venta
INSERT INTO detalles_ventas (id_venta, id_producto, precio_u, cantidad_venta)
	VALUES
	('V-1', 'PRO-2', '60', 1),
    ('V-1', 'PRO-3', '50', 2);

#Insercion de datos para la tabla transaccion
INSERT INTO transacciones VALUES
	('T-2', 'Alquiler', NOW(), 10, 'A-1');

#Insercion de datos para la tabla alquiler
INSERT INTO alquileres VALUES
	('A-1', 'T-2','CLI-3', 'EMP-1', 'Pendiente' ,NOW(), 10);

#Insercion de datos para la tabla detalle_alquiler
INSERT INTO detalles_alquileres (id_alquiler, id_producto, precio_u, cantidad_alquiler)
	VALUES
	('A-1', 'PRO-1', '60', 1),
	('A-1', 'PRO-2', '60', 1),
	('A-1', 'PRO-4', '60', 1);

INSERT INTO transacciones VALUES
	('T-3', 'Alquiler', NOW(), 10, 'A-2');

INSERT INTO alquileres VALUES
	('A-2', 'T-3','CLI-2', 'EMP-2', 'Cerrado' ,NOW(), 10);
    
INSERT INTO detalles_alquileres (id_alquiler, id_producto, precio_u, cantidad_alquiler)
	VALUES
	('A-2', 'PRO-4', '10', 1),
	('A-2', 'PRO-2', '90', 2);

#Insercion de datos para la tabla transaccion
INSERT INTO transacciones VALUES
	('T-4', 'Pedido', NOW(), 600,  'P-1');

#Insercion de tipos de productos para la tabla producto_pedido
INSERT INTO productos_pedidos VALUES
	('PRP-1', 'Chaleco', 'Prenda para torso'),
	('PRP-2', 'Blazer', 'Prenda estilo abrigo formal'),
	('PRP-3', 'Pantalon', 'Prenda formal para el inferior');

#Insercion de datos para la tabla pedido
INSERT INTO pedidos VALUES
	('P-1', 'T-4','CLI-3', 'EMP-2', NOW(), 'Para niño de 10 años', 180);

#Insercion de datos para la tabla detalle_pedido
INSERT INTO detalles_pedidos (id_pedido, id_prod_pedi, descrip_d_pp, precio_d_pp, cantidad_d_pp)
	VALUES
	('P-1', 'PRP-1', 'saca wea', 90, 1),
	('P-1', 'PRP-1', 'sasasa', 90, 1);

#Insercion de datos para la tabla superior
INSERT INTO superiores (id_pedido, cuello, longitud, hombros, sisa, biceps, pecho, brazos, largo_cha, largo_abri)
	VALUES
	('P-1', 10, 60, 35, 19, 15, 60, 90, 100, 120);

#Insercion de datos para la tabla inferior
INSERT INTO inferiores (id_pedido, caderas, largo, tiro, posicion, muslos)
	VALUES 
	('P-1', 80, 80, 30, 30, 40);

#Insercion de datos para la tabla recibo después de pedido
INSERT INTO recibos VALUES
	('R-1', 'CLI-1','CMP-1', 'B001-00000001', NOW(), 720, 129.6, 849.6, 'Pagado', 'EMP-1');
    
INSERT INTO detalles_recibos (id_recibo, id_transac, monto) VALUES
	('R-1', 'T-1', 110),
    ('R-1', 'T-2', 10),
    ('R-1', 'T-3', 600)