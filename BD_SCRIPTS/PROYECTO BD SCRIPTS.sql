/*
Creacion de las tablas de la base de datos inventario 
Proyecto Grupo #7
*/

-- Clientes
CREATE TABLE CLIENTES
(
  id_Cliente NUMBER PRIMARY KEY NOT NULL,
  nombre VARCHAR2(20) NOT NULL,
  apellido1 VARCHAR2(20) NOT NULL,
  apellido2 VARCHAR2(20) NOT NULL,
  correo VARCHAR2(35),
  telefono NUMBER
);

-- Tienda
CREATE TABLE TIENDA
(
  id_Tienda NUMBER PRIMARY KEY NOT NULL,
  ubicacion_Tienda VARCHAR2(50) NOT NULL
);

-- Categoría
CREATE TABLE CATEGORIA
(
  id_Categoria NUMBER PRIMARY KEY NOT NULL,
  descripcion VARCHAR2(20) NOT NULL
);

-- Productos
CREATE TABLE PRODUCTOS
(
  id_Producto NUMBER PRIMARY KEY NOT NULL,
  nombre VARCHAR2(35) NOT NULL,
  cantidad NUMBER,
  costo NUMBER NOT NULL,
  estado NUMBER NOT NULL,
  id_Categoria NUMBER,
  id_Tienda NUMBER,
  FOREIGN KEY (id_Categoria) REFERENCES CATEGORIA(id_Categoria),
  FOREIGN KEY (id_Tienda) REFERENCES TIENDA(id_Tienda)
);

-- Devoluciones
CREATE TABLE DEVOLUCIONES
(
  id_Devolucion NUMBER PRIMARY KEY NOT NULL,
  id_Producto NUMBER NOT NULL,
  motivo VARCHAR2(50) NOT NULL,
  FOREIGN KEY (id_Producto) REFERENCES PRODUCTOS(id_Producto)
);

-- Proveedores
CREATE TABLE PROVEEDORES
(
  id_Proveedor NUMBER PRIMARY KEY NOT NULL,
  nombre VARCHAR2(20) NOT NULL,
  direccion VARCHAR2(25),
  telefono NUMBER NOT NULL
);

-- Ingreso Mercadería
CREATE TABLE INGRESO_MERCADERIA
(
  id_Ingreso NUMBER PRIMARY KEY NOT NULL,
  id_Proveedor NUMBER NOT NULL,
  fecha DATE,
  descripcion VARCHAR2(30) NOT NULL,
  FOREIGN KEY (id_Proveedor) REFERENCES PROVEEDORES(id_Proveedor)
);

-- User Roles
CREATE TABLE USER_ROLES
(
  id_Rol NUMBER PRIMARY KEY NOT NULL,
  descripcion VARCHAR2(20) NOT NULL
);

-- Usuarios
CREATE TABLE USUARIOS
(
  id_Usuario NUMBER PRIMARY KEY NOT NULL,
  nombre VARCHAR2(15) NOT NULL,
  contrasenna VARCHAR2(15) NOT NULL,
  id_Rol NUMBER,
  FOREIGN KEY (id_Rol) REFERENCES USER_ROLES(id_Rol)
);

-- Ventas
CREATE TABLE VENTAS
(
  id_Venta NUMBER PRIMARY KEY NOT NULL,
  id_Cliente NUMBER NOT NULL,
  total_Pagado FLOAT NOT NULL,
  FOREIGN KEY (id_Cliente) REFERENCES CLIENTES(id_Cliente)
);

-- Ventas Detalle (nueva tabla para manejar múltiples productos en una venta)
CREATE TABLE VENTAS_DETALLE
(
  id_VentaDetalle NUMBER PRIMARY KEY NOT NULL,
  id_Venta NUMBER NOT NULL,
  id_Producto NUMBER NOT NULL,
  cantidad NUMBER NOT NULL,
  precio_unitario NUMBER NOT NULL,
  FOREIGN KEY (id_Venta) REFERENCES VENTAS(id_Venta),
  FOREIGN KEY (id_Producto) REFERENCES PRODUCTOS(id_Producto)
);

----------------------------------------------------------
----------------------------------------------------------
/*
Poner desde aca todos los procedimientos almacenados,
funciones, vistas, triggers, etc.
*/
-- Procedimientos almacenados.

-- Proveedor.

-- Crear proveedor

CREATE OR REPLACE PROCEDURE crear_proveedor(
    p_id_proveedor IN NUMBER,
    p_nombre IN VARCHAR2,
    p_direccion IN VARCHAR2,
    p_telefono IN NUMBER
)
AS
BEGIN
    INSERT INTO PROVEEDORES (id_proveedor, nombre, direccion, telefono)
    VALUES (p_id_proveedor, p_nombre, p_direccion, p_telefono);
    COMMIT;
END crear_proveedor;

-- Leer proveedor.

CREATE OR REPLACE PROCEDURE leer_proveedor(
    p_id_proveedor IN NUMBER,
    o_nombre OUT VARCHAR2,
    o_direccion OUT VARCHAR2,
    o_telefono OUT NUMBER
)
AS
BEGIN
    SELECT nombre, direccion, telefono
    INTO o_nombre, o_direccion, o_telefono
    FROM PROVEEDORES
    WHERE id_proveedor = p_id_proveedor;
END leer_proveedor;

-- Actualizar proveedor.

CREATE OR REPLACE PROCEDURE actualizar_proveedor(
    p_id_proveedor IN NUMBER,
    p_nombre IN VARCHAR2,
    p_direccion IN VARCHAR2,
    p_telefono IN NUMBER
)
AS
BEGIN
    UPDATE PROVEEDORES
    SET nombre = p_nombre,
        direccion = p_direccion,
        telefono = p_telefono
    WHERE id_proveedor = p_id_proveedor;
    COMMIT;
END actualizar_proveedor;

-- Eliminar proveedor.

CREATE OR REPLACE PROCEDURE eliminar_proveedor(
    p_id_proveedor IN NUMBER
)
AS
BEGIN
    DELETE FROM PROVEEDORES
    WHERE id_proveedor = p_id_proveedor;
    COMMIT;
END eliminar_proveedor;

-- Ventas.

-- Crear venta.

CREATE OR REPLACE PROCEDURE crear_venta(
    p_id_venta IN NUMBER,
    p_id_cliente IN NUMBER,
    p_total_pagado IN FLOAT
)
AS
BEGIN
    INSERT INTO VENTAS (id_venta, id_cliente, total_pagado)
    VALUES (p_id_venta, p_id_cliente, p_total_pagado);
    COMMIT;
END crear_venta;

-- Leer venta.

CREATE OR REPLACE PROCEDURE leer_venta(
    p_id_venta IN NUMBER,
    o_id_cliente OUT NUMBER,
    o_total_pagado OUT FLOAT
)
AS
BEGIN
    SELECT id_cliente, total_pagado
    INTO o_id_cliente, o_total_pagado
    FROM VENTAS
    WHERE id_venta = p_id_venta;
END leer_venta;

-- Actualizar venta.

CREATE OR REPLACE PROCEDURE actualizar_venta(
    p_id_venta IN NUMBER,
    p_id_cliente IN NUMBER,
    p_total_pagado IN FLOAT
)
AS
BEGIN
    UPDATE VENTAS
    SET id_cliente = p_id_cliente,
        total_pagado = p_total_pagado
    WHERE id_venta = p_id_venta;
    COMMIT;
END actualizar_venta;

-- Eliminar venta.

CREATE OR REPLACE PROCEDURE eliminar_venta(
    p_id_venta IN NUMBER
)
AS
BEGIN
    DELETE FROM VENTAS
    WHERE id_venta = p_id_venta;
    COMMIT;
END eliminar_venta;

-- Vistas.

CREATE OR REPLACE VIEW VISTA_PROVEEDORES_SUMINISTRO AS
SELECT P.id_Proveedor, P.nombre AS nombre_proveedor, P.direccion AS direccion_proveedor, P.telefono AS telefono_proveedor,
       COUNT(IM.id_Ingreso) AS cantidad_ingresos
FROM PROVEEDORES P
LEFT JOIN INGRESO_MERCADERIA IM ON P.id_Proveedor = IM.id_Proveedor
GROUP BY P.id_Proveedor, P.nombre, P.direccion, P.telefono;


-- Cursores.

CREATE OR REPLACE PROCEDURE cursor_total_ventas_cliente(
    p_id_cliente IN NUMBER,
    resultado_cursor OUT NUMBER
)
AS
BEGIN
    SELECT SUM(total_Pagado) INTO resultado_cursor
    FROM VENTAS
    WHERE id_Cliente = p_id_cliente;
END cursor_total_ventas_cliente;

CREATE OR REPLACE PROCEDURE cursor_devoluciones_por_motivo(
    motivo IN VARCHAR2,
    resultado_cursor OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN resultado_cursor FOR
        SELECT id_Devolucion, id_Producto
        FROM DEVOLUCIONES
        WHERE motivo = motivo;
END cursor_devoluciones_por_motivo;



-- Funciones.

CREATE OR REPLACE FUNCTION calcular_total_ventas_cliente(
    p_id_cliente IN NUMBER
)
RETURN NUMBER
AS
  total_ventas NUMBER;
BEGIN
  SELECT SUM(total_Pagado) INTO total_ventas
  FROM VENTAS
  WHERE id_Cliente = p_id_cliente;
  RETURN total_ventas;
END calcular_total_ventas_cliente;

CREATE OR REPLACE FUNCTION calcular_total_devoluciones_por_motivo(
    motivo IN VARCHAR2
)
RETURN NUMBER
AS
    total_devoluciones NUMBER := 0;
    devolucion_rec DEVOLUCIONES%ROWTYPE;
    detalle_cursor SYS_REFCURSOR;
BEGIN
    OPEN detalle_cursor FOR
        SELECT COUNT(*) AS total
        FROM DEVOLUCIONES
        WHERE motivo = motivo;
    
    FETCH detalle_cursor INTO total_devoluciones;
    CLOSE detalle_cursor;
    
    RETURN total_devoluciones;
END calcular_total_devoluciones_por_motivo;

-- Triggers

CREATE OR REPLACE TRIGGER actualizar_stock_venta
AFTER INSERT ON VENTAS_DETALLE
FOR EACH ROW
BEGIN
    UPDATE PRODUCTOS
    SET cantidad = cantidad - :NEW.cantidad
    WHERE id_Producto = :NEW.id_Producto;
END;
----------------------------------------------------------
----------------------------------------------------------