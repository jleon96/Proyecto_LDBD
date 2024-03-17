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
----------------------------------------------------------
----------------------------------------------------------