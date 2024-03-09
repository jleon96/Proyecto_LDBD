/*
Creacion de las tablas de la base de datos proyecto
Grupo #7
*/

create table CLIENTES
(
id_Cliente number primary key not null,
nombre varchar2 (20) not null,
apellido1 varchar2(20) not null,
apellido2 varchar2(20) not null,
correo varchar2(35),
telefono number
);

create table TIENDA
(
id_Tienda number primary key not null,
ubicacion_Tienda varchar2 (50) not null
);

create table CATEGORIA
(
id_Categoria number primary key not null,
descripcion varchar2(20) not null
);

create table PRODUCTOS
(
id_Producto number primary key not null,
nombre varchar2(35) not null,
cantidad number,
costo number not null,
estado number not null 
);

create table DEVOLUCIONES
(
id_Devolucion number primary key not null,
producto varchar2(20) not null,
motivo varchar2 (50) not null
);

create table PROVEEDORES
(
id_Proveedor number primary key not null,
nomber varchar2 (20) not null,
direccion varchar2 (25),
telefono number not null
);

create table INGRESO_MERCADERIA
(
id_Ingreso number primary key not null,
fecha date,
descripcion varchar2(30) not null

);

create table USER_ROLES -- esta va como FK en la tabla usuarios
(
id_Rol number primary key not null,
descripcion varchar2 (20) not null
);

create table USUARIOS --esta tabla es para los login 
(
id_Usuario number primary key not null,
nombre varchar2 (15) not null,
contrasenna varchar2 (15) not null
);

create table VENTAS 
(
id_Venta number primary key not null,
--id_cliente
--id_Producto
--id_Tienda
cantidad
total_Pagado float not null
);
