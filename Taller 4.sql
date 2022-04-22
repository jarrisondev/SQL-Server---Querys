create database [taller 4]
go

use [taller 4];
go

--tabla cliente
create table CLIENTE (
	Codigo_Cliente varchar(20) not null check(isnumeric(Codigo_Cliente)=1),

	Nombre varchar(250) not null,
	Apellidos varchar(250),
	Empresa varchar(50),
	Puesto varchar (50),
	Direccion varchar(50),
	Poblacion varchar(25) default 'Medellín',
	Codigo_Postal varchar(5) default '0500',
	Provincia varchar(25) default 'Antioquia',
	Telefono varchar(10),
	Fecha_Nacimiento datetime not null,

	constraint pk_cliente primary key (Codigo_Cliente)
);
go

--tabla articulo
create table ARTICULO(
	Codigo_Articulo varchar(4) not null,

	Nombre varchar(100) not null,
	Descripcion varchar(250) not null,
	precio money not null check(precio >= 0),
	Unidades_Stock int check(Unidades_stock>=0),
	Stock_Seguridad int check(Stock_Seguridad >= 2) default 2,
	Imagen binary(50)

	constraint pk_articulo primary key (Codigo_Articulo)
);
go

--tabla compra
create table COMPRA (
	Codigo_Cliente varchar(20) not null check(isnumeric(Codigo_Cliente)=1),
	Codigo_Articulo varchar(4) not null,

	Fecha datetime default getdate(),
	Unidades int check(Unidades >= 1)

	constraint fk_cliente foreign key (Codigo_Cliente) references CLIENTE(Codigo_Cliente),
	constraint fk_articulo foreign key (Codigo_Articulo) references ARTICULO(Codigo_Articulo),
	constraint pk_compra primary key (Codigo_Cliente,Codigo_Articulo, Fecha)
);
go

--insert cliente
insert into CLIENTE values('1','José', 'Fernandez Ruiz', 'Estudio Cero', 'Gerente', 'Cervantes, 13', 'Écija', '41400', 'Sevilla', '656789043', '13/06/1968')
insert into CLIENTE values('2','Luis', 'Fernandez Chacón', 'Beep', 'Dependiente', 'Aurora, 4', 'Écija', '41400', 'Sevilla', '675894566', '24/05/1982')
insert into CLIENTE values('3','Antonio', 'Ruiz Gómez', 'Comar', 'Dependiente', 'Osuna, 23', 'Écija', '41400', 'Sevilla', '654345544', '06/08/1989')
insert into CLIENTE values('4','Andrea', 'Romero Vázquez', 'Estudio Cero', 'Dependiente', 'Cervantes, 25', 'Écija', '41400', 'Sevilla', '646765657', '23/11/1974')
insert into CLIENTE values('5','José', 'Pérez Pérez', 'Beep', 'Gerente', 'Córdoba, 10', 'Écija', '41400', 'Sevilla', '645345543', '10/04/1978')
go
--insert articulo
insert into ARTICULO values('1', 'NETGEAR switchprosafe','Switch 8 puertos GigabitEthernet', 125, 3, 2, null)
insert into ARTICULO values('2', 'Switch SRW224G4-EUde Linksys', 'CISCO switch 24 puertos 10/100', 202.43, 2, 2, null)
insert into ARTICULO values('3', 'Switch D-link', 'D-Link smart switch 16 puertos', 149.90, 7, 4, null)
insert into ARTICULO values('4', 'Switch D-link ', 'D-Link smart switch 48 puertos', 489, 4, 2, null)
go
--insert compra
insert into COMPRA values('1', '1', '13/5/2020', 2)
insert into COMPRA values('1', '2', '13/5/2020', 1)
insert into COMPRA values('2', '3', '15/5/2020', 1)
insert into COMPRA values('2', '4', '15/5/2020', 1)
insert into COMPRA values('3', '1', '15/10/2020', 2)
insert into COMPRA values('4', '2', '15/10/2020', 1)
insert into COMPRA values('5', '3', '15/10/2020', 3)
insert into COMPRA values('1', '4', '16/10/2020', 1)
insert into COMPRA values('1', '1', '16/10/2020', 2)
insert into COMPRA values('2', '2', '17/10/2020', 1)
insert into COMPRA values('3', '3', '18/10/2020', 4)
insert into COMPRA values('4', '4', '19/10/2020', 2)
insert into COMPRA values('5', '1', '19/10/2020', 1)
go

-- update 3 clientes
update CLIENTE set Nombre = 'Jarrison', Apellidos='Cano Misas', Empresa =null, Puesto=null where Nombre = 'luis'
update CLIENTE set Nombre = 'Elizabeth', Apellidos='Ceballos', Empresa ='Ilogica', Puesto='Analista', Fecha_Nacimiento='28/01/2003' where Nombre = 'José'and Apellidos='Fernandez Ruiz'
update CLIENTE set Codigo_Postal=default, Provincia=default, Poblacion=default where Codigo_Cliente='3'
go

--delete un articulo
delete from COMPRA where Codigo_Articulo ='4' -- primero era necesario eliminar las compras que involucraran al articulo
delete from ARTICULO where Codigo_Articulo ='4'
go

--select (a)
select COMPRA.Codigo_Cliente, (CLIENTE.Nombre + ' ' + CLIENTE.Apellidos) [Nombre Completo], COMPRA.Codigo_Articulo, ARTICULO.Nombre [Nombre Articulo], COMPRA.Unidades, (ARTICULO.Precio * COMPRA.Unidades) [Total Por Unidad] from COMPRA
inner join CLIENTE on CLIENTE.Codigo_Cliente = COMPRA.Codigo_Cliente
inner join ARTICULO on ARTICULO.Codigo_Articulo = COMPRA.Codigo_Articulo
go

-- select (b)
select * from CLIENTE 
where year(Fecha_Nacimiento) between '1970' and  '1980'
go

-- select (c)
select Precio, Unidades_Stock from ARTICULO
where 
Descripcion like '%link%' /*Solo me muestra uno ya que anteriormente se pidio un delete de la tabla articulo y borre un registro que cumplia esta igualdad */
or
Stock_Seguridad > 10
go


--NORTHWIND----------------------------------------------

use [Northwind];
go

--select (a) 
select C.CustomerID [ID Cliente], C.CompanyName [Nombre Cliente], count(OD.Quantity) [Total Productos Pedidos] from [Order Details] OD
inner join Orders on Orders.OrderID = OD.OrderID
inner join Customers C on C.CustomerID = Orders.CustomerID
group by C.CustomerID, C.CompanyName
order by C.CustomerID asc
go

--select (b)
select min(UnitsInStock) [Min in Stock], max(UnitsInStock) [Max in Stock], avg(UnitPrice) [Promedio] from Products
where ProductName like 'a%' /*<-- La variable 'a' se cambia por la letra deseada*/
go

--select (c)
select (em.FirstName + ' ' + em.LastName) [Nombre Empleado], c.CompanyName, sum(od.UnitPrice) total from Orders o
inner join Employees em on o.employeeID = em.EmployeeID
inner join [Order Details] od on od.OrderID = o.OrderID
inner join Customers c on c.CustomerID = o.CustomerID
where em.EmployeeID = 7 /*<-- Se indica el empleado que se desea por medio de su id*/
group by  (em.FirstName + ' ' + em.LastName), c.CompanyName
go
