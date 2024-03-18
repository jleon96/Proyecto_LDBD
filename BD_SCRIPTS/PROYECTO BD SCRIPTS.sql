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

-- Categoria
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

-- Ingreso Mercaderia
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

-- Ventas Detalle (nueva tabla para manejar multiples productos en una venta)
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

-- Procedimiento para crear un nuevo usuario
CREATE OR REPLACE PROCEDURE CrearUsuario(
    p_id_Usuario IN NUMBER,
    p_nombre IN VARCHAR2,
    p_contrasenna IN VARCHAR2,
    p_id_Rol IN NUMBER
)
AS
BEGIN
    INSERT INTO USUARIOS (id_Usuario, nombre, contrasenna, id_Rol)
    VALUES (p_id_Usuario, p_nombre, p_contrasenna, p_id_Rol);
    COMMIT;
END CrearUsuario;


-- Procedimiento para leer un usuario por su ID
CREATE OR REPLACE PROCEDURE LeerUsuario(
    p_id_Usuario IN NUMBER,
    o_nombre OUT VARCHAR2,
    o_contrasenna OUT VARCHAR2,
    o_id_Rol OUT NUMBER
)
AS
BEGIN
    SELECT nombre, contrasenna, id_Rol
    INTO o_nombre, o_contrasenna, o_id_Rol
    FROM USUARIOS
    WHERE id_Usuario = p_id_Usuario;
END LeerUsuario;


-- Procedimiento para actualizar la informacion de un usuario
CREATE OR REPLACE PROCEDURE ActualizarUsuario(
    p_id_Usuario IN NUMBER,
    p_nombre IN VARCHAR2,
    p_contrasenna IN VARCHAR2,
    p_id_Rol IN NUMBER
)
AS
BEGIN
    UPDATE USUARIOS
    SET nombre = p_nombre,
        contrasenna = p_contrasenna,
        id_Rol = p_id_Rol
    WHERE id_Usuario = p_id_Usuario;
    COMMIT;
END ActualizarUsuario;

-- Procedimiento para eliminar un usuario por su ID
CREATE OR REPLACE PROCEDURE EliminarUsuario(
    p_id_Usuario IN NUMBER
)
AS
BEGIN
    DELETE FROM USUARIOS
    WHERE id_Usuario = p_id_Usuario;
    COMMIT;
END EliminarUsuario;

-- Procedimiento para crear un nuevo detalle de venta
CREATE OR REPLACE PROCEDURE CrearVentaDetalle(
    p_id_VentaDetalle IN NUMBER,
    p_id_Venta IN NUMBER,
    p_id_Producto IN NUMBER,
    p_cantidad IN NUMBER,
    p_precio_unitario IN NUMBER
)
AS
BEGIN
    INSERT INTO VENTAS_DETALLE (id_VentaDetalle, id_Venta, id_Producto, cantidad, precio_unitario)
    VALUES (p_id_VentaDetalle, p_id_Venta, p_id_Producto, p_cantidad, p_precio_unitario);
    COMMIT;
END CrearVentaDetalle;


-- Procedimiento para leer un detalle de venta por su ID
CREATE OR REPLACE PROCEDURE LeerVentaDetalle(
    p_id_VentaDetalle IN NUMBER,
    o_id_Venta OUT NUMBER,
    o_id_Producto OUT NUMBER,
    o_cantidad OUT NUMBER,
    o_precio_unitario OUT NUMBER
)
AS
BEGIN
    SELECT id_Venta, id_Producto, cantidad, precio_unitario
    INTO o_id_Venta, o_id_Producto, o_cantidad, o_precio_unitario
    FROM VENTAS_DETALLE
    WHERE id_VentaDetalle = p_id_VentaDetalle;
END LeerVentaDetalle;


-- Procedimiento para actualizar la informaci n de un detalle de venta
CREATE OR REPLACE PROCEDURE ActualizarVentaDetalle(
    p_id_VentaDetalle IN NUMBER,
    p_id_Venta IN NUMBER,
    p_id_Producto IN NUMBER,
    p_cantidad IN NUMBER,
    p_precio_unitario IN NUMBER
)
AS
BEGIN
    UPDATE VENTAS_DETALLE
    SET id_Venta = p_id_Venta,
        id_Producto = p_id_Producto,
        cantidad = p_cantidad,
        precio_unitario = p_precio_unitario
    WHERE id_VentaDetalle = p_id_VentaDetalle;
    COMMIT;
END ActualizarVentaDetalle;


-- Procedimiento para eliminar un detalle de venta por su ID
CREATE OR REPLACE PROCEDURE EliminarVentaDetalle(
    p_id_VentaDetalle IN NUMBER
)
AS
BEGIN
    DELETE FROM VENTAS_DETALLE
    WHERE id_VentaDetalle = p_id_VentaDetalle;
    COMMIT;
END EliminarVentaDetalle;

/*Procedimientos almacenados para clientes (CRUD)*/

--INSERTAR
CREATE OR REPLACE PROCEDURE sp_insertar_cliente(
  p_id_cliente IN CLIENTES.id_Cliente%TYPE,
  p_nombre IN CLIENTES.nombre%TYPE,
  p_apellido1 IN CLIENTES.apellido1%TYPE,
  p_apellido2 IN CLIENTES.apellido2%TYPE,
  p_correo IN CLIENTES.correo%TYPE,
  p_telefono IN CLIENTES.telefono%TYPE)
IS
BEGIN
  INSERT INTO CLIENTES(id_Cliente, nombre, apellido1, apellido2, correo, telefono)
  VALUES (p_id_cliente, p_nombre, p_apellido1, p_apellido2, p_correo, p_telefono);
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE;
END sp_insert_cliente;

--LEER
CREATE OR REPLACE PROCEDURE sp_leer_cliente(
  p_id_cliente IN CLIENTES.id_Cliente%TYPE,
  o_nombre OUT CLIENTES.nombre%TYPE,
  o_apellido1 OUT CLIENTES.apellido1%TYPE,
  o_apellido2 OUT CLIENTES.apellido2%TYPE,
  o_correo OUT CLIENTES.correo%TYPE,
  o_telefono OUT CLIENTES.telefono%TYPE)
IS
BEGIN
  SELECT nombre, apellido1, apellido2, correo, telefono
  INTO o_nombre, o_apellido1, o_apellido2, o_correo, o_telefono
  FROM CLIENTES
  WHERE id_Cliente = p_id_cliente;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    o_nombre := NULL;
    o_apellido1 := NULL;
    o_apellido2 := NULL;
    o_correo := NULL;
    o_telefono := NULL;
  WHEN OTHERS THEN
    RAISE;
END sp_read_cliente;

--ACTUALIZAR
CREATE OR REPLACE PROCEDURE sp_actualizar_cliente(
  p_id_cliente IN CLIENTES.id_Cliente%TYPE,
  p_nombre IN CLIENTES.nombre%TYPE,
  p_apellido1 IN CLIENTES.apellido1%TYPE,
  p_apellido2 IN CLIENTES.apellido2%TYPE,
  p_correo IN CLIENTES.correo%TYPE,
  p_telefono IN CLIENTES.telefono%TYPE)
IS
BEGIN
  UPDATE CLIENTES
  SET nombre = p_nombre,
      apellido1 = p_apellido1,
      apellido2 = p_apellido2,
      correo = p_correo,
      telefono = p_telefono
  WHERE id_Cliente = p_id_cliente;
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE;
END sp_update_cliente;

--BORRAR
CREATE OR REPLACE PROCEDURE sp_borrar_cliente(
  p_id_cliente IN CLIENTES.id_Cliente%TYPE)
IS
BEGIN
  DELETE FROM CLIENTES
  WHERE id_Cliente = p_id_cliente;
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE;
END sp_delete_cliente;
--------------------------------------------------------------
--------------------------------------------------------------
--------------------------------------------------------------
--------------------------------------------------------------

-- Vistas.

CREATE OR REPLACE VIEW VISTA_PROVEEDORES_SUMINISTRO AS
SELECT P.id_Proveedor, P.nombre AS nombre_proveedor, P.direccion AS direccion_proveedor, P.telefono AS telefono_proveedor,
       COUNT(IM.id_Ingreso) AS cantidad_ingresos
FROM PROVEEDORES P
LEFT JOIN INGRESO_MERCADERIA IM ON P.id_Proveedor = IM.id_Proveedor
GROUP BY P.id_Proveedor, P.nombre, P.direccion, P.telefono;

CREATE OR REPLACE VIEW VISTA_PRODUCTOS_PRECIOS AS
SELECT P.id_Producto, P.nombre AS nombre_producto, P.cantidad, P.costo, C.descripcion AS categoria, T.ubicacion_Tienda AS ubicacion_tienda
FROM PRODUCTOS P
LEFT JOIN CATEGORIA C ON P.id_Categoria = C.id_Categoria
LEFT JOIN TIENDA T ON P.id_Tienda = T.id_Tienda;

CREATE VIEW Detalles_Ventas AS
SELECT V.id_Venta, 
       C.nombre AS nombre_cliente,
       C.apellido1 AS apellido_cliente,
       P.nombre AS nombre_producto,
       T.ubicacion_Tienda AS ubicacion_tienda,
       V.cantidad,
       V.total_Pagado
FROM VENTAS V
JOIN CLIENTES C ON V.id_Cliente = C.id_Cliente
JOIN PRODUCTOS P ON V.id_Producto = P.id_Producto
JOIN TIENDA T ON V.id_Tienda = T.id_Tienda;

CREATE VIEW Inventario_Productos AS
SELECT P.id_Producto,
       P.nombre,
       P.cantidad AS cantidad_disponible,
       IM.fecha AS fecha_ingreso
FROM PRODUCTOS P
JOIN (
    SELECT id_Producto, MAX(fecha) AS fecha
    FROM INGRESO_MERCADERIA
    GROUP BY id_Producto
) IM ON P.id_Producto = IM.id_Producto;

CREATE VIEW Devoluciones AS
SELECT D.id_Devolucion,
       D.producto,
       D.motivo,
       V.id_Venta
FROM DEVOLUCIONES D
JOIN VENTAS V ON D.id_Venta = V.id_Venta;

--------------------------------------------------------------
--------------------------------------------------------------
--------------------------------------------------------------
--------------------------------------------------------------
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

CREATE OR REPLACE PROCEDURE cursor_promedio_costos_productos(
    resultado_cursor OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN resultado_cursor FOR
        SELECT C.descripcion AS categoria, AVG(P.costo) AS promedio_costo
        FROM PRODUCTOS P
        JOIN CATEGORIA C ON P.id_Categoria = C.id_Categoria
        GROUP BY C.descripcion;
END cursor_promedio_costos_productos;

CREATE OR REPLACE PROCEDURE cursor_contar_productos_tienda(
    resultado_cursor OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN resultado_cursor FOR
        SELECT T.ubicacion_Tienda AS ubicacion_tienda, COUNT(*) AS cantidad_productos
        FROM PRODUCTOS P
        JOIN TIENDA T ON P.id_Tienda = T.id_Tienda
        GROUP BY T.ubicacion_Tienda;
END cursor_contar_productos_tienda;

--------------------------------------------------------------
--------------------------------------------------------------
--------------------------------------------------------------
--------------------------------------------------------------

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

CREATE OR REPLACE FUNCTION obtener_promedio_costos_categoria
RETURN SYS_REFCURSOR
AS
  resultado_cursor SYS_REFCURSOR;
BEGIN
  cursor_promedio_costos_productos(resultado_cursor);
  RETURN resultado_cursor;
END obtener_promedio_costos_categoria;

CREATE OR REPLACE FUNCTION contar_productos_tienda
RETURN SYS_REFCURSOR
AS
  resultado_cursor SYS_REFCURSOR;
BEGIN
  cursor_contar_productos_tienda(resultado_cursor);
  RETURN resultado_cursor;
END contar_productos_tienda;

CREATE OR REPLACE FUNCTION Reporte_Ventas_Mensual (mes INT, año INT)
RETURN VARCHAR2
AS
    reporte VARCHAR2(4000);
BEGIN
    -- Inicializamos el reporte
    reporte := 'Informe de Ventas para ' || TO_CHAR(mes, 'FM00') || '/' || TO_CHAR(año) || ':' || CHR(10);

    -- Loop a través de cada día del mes
    FOR dia IN 1..31 LOOP
        -- Obtenemos el total de ventas para el día actual
        SELECT SUM(total_Pagado)
        INTO total_ventas
        FROM VENTAS
        WHERE EXTRACT(MONTH FROM fecha) = mes
        AND EXTRACT(YEAR FROM fecha) = año
        AND EXTRACT(DAY FROM fecha) = dia;

        -- Agregamos el total de ventas al reporte
        IF total_ventas IS NOT NULL THEN
            reporte := reporte || TO_CHAR(dia, 'FM00') || '/' || TO_CHAR(mes, 'FM00') || '/' || TO_CHAR(año) || ': ' || total_ventas || CHR(10);
        END IF;
    END LOOP;

    RETURN reporte;
END;

CREATE OR REPLACE FUNCTION Promedio_Ventas_Diarias (mes INT, año INT)
RETURN NUMBER
AS
    total_ventas NUMBER;
    dias_mes NUMBER;
    promedio NUMBER;
BEGIN
    -- Calculamos el total de ventas para el mes
    SELECT SUM(total_Pagado)
    INTO total_ventas
    FROM VENTAS
    WHERE EXTRACT(MONTH FROM fecha) = mes
    AND EXTRACT(YEAR FROM fecha) = año;

    -- Calculamos el número de días en el mes
    dias_mes := EXTRACT(DAY FROM LAST_DAY(TO_DATE(mes || '-' || año, 'MM-YYYY')));

    -- Calculamos el promedio de ventas diarias
    IF total_ventas IS NOT NULL AND dias_mes <> 0 THEN
        promedio := total_ventas / dias_mes;
    ELSE
        promedio := 0;
    END IF;

    RETURN promedio;
END;

/*Funcion para obtener el correo de un cliente por medio de su ID*/

CREATE OR REPLACE FUNCTION fn_get_cliente_email(p_id_Cliente IN CLIENTES.id_Cliente%TYPE)
RETURN CLIENTES.correo%TYPE
AS
  v_correo CLIENTES.correo%TYPE;
BEGIN
  SELECT correo INTO v_correo
  FROM CLIENTES
  WHERE id_Cliente = p_id_Cliente;

  RETURN v_correo;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN NULL;
END;

/*Funcion para verificar la existencia de un proveedor*/

CREATE OR REPLACE FUNCTION fn_existe_proveedor(p_id_Proveedor IN PROVEEDORES.id_Proveedor%TYPE)
RETURN NUMBER
AS
  v_existe NUMBER(1);
BEGIN
  SELECT COUNT(*)
  INTO v_existe
  FROM PROVEEDORES
  WHERE id_Proveedor = p_id_Proveedor;

  IF v_existe > 0 THEN
  DBMS_OUTPUT.PUT_LINE('Proveedor si existe en la base de datos');
    RETURN 1; -- Proveedor existe
    
  ELSE
  DBMS_OUTPUT.PUT_LINE('Proveedor no existe en la base de datos');
    RETURN 0; -- Proveedor no existe
    
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    -- En caso de error, se podr�a retornar un valor espec�fico o lanzar la excepci�n
    RAISE;
END fn_existe_proveedor;


--------------------------------------------------------------
--------------------------------------------------------------
--------------------------------------------------------------
--------------------------------------------------------------

-- Triggers

CREATE OR REPLACE TRIGGER actualizar_stock_venta
AFTER INSERT ON VENTAS_DETALLE
FOR EACH ROW
BEGIN
    UPDATE PRODUCTOS
    SET cantidad = cantidad - :NEW.cantidad
    WHERE id_Producto = :NEW.id_Producto;
END;

CREATE OR REPLACE TRIGGER actualizar_total_pagado
AFTER INSERT OR DELETE ON VENTAS_DETALLE
FOR EACH ROW
BEGIN
    UPDATE VENTAS
    SET total_Pagado = (SELECT SUM(cantidad * precio_unitario) FROM VENTAS_DETALLE WHERE id_Venta = :NEW.id_Venta)
    WHERE id_Venta = :NEW.id_Venta;
END;


CREATE OR REPLACE TRIGGER evitar_eliminacion_proveedores
BEFORE DELETE ON PROVEEDORES
FOR EACH ROW
DECLARE
    cantidad_ingresos NUMBER;
BEGIN
    SELECT COUNT(*) INTO cantidad_ingresos FROM INGRESO_MERCADERIA WHERE id_Proveedor = :OLD.id_Proveedor;
    IF cantidad_ingresos > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'No se puede eliminar este proveedor porque tiene ingresos de mercader a asociados.');
    END IF;
END;

----------------------------------------------------------
----------------------------------------------------------