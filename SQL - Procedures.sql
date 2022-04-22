CREATE DATABASE [ Actividad #10 -  Jarrison Cano y Bryan Muñoz]
GO

USE  [ Actividad #10 -  Jarrison Cano y Bryan Muñoz]
GO

CREATE TABLE carrera(
	id_carrera int primary key,
	nombre varchar(30) not null,
	n_creditos int not null,
	costo decimal(8, 0) not null
)
GO

CREATE TABLE estudiante(
	id_estudiante int primary key,
	nombre varchar(20) not null,
	apellido varchar(20) not null,
	fecha_ingreso date not null,
	edad int not null,
	genero char not null,
	cod_carrera int foreign key references carrera(id_carrera)
)
GO

CREATE TABLE asignaturas (
	id_asignatura int primary key,
	nombre varchar(30) not null,
	intensidad int not null,
	aula varchar(5) not null,
	cod_carrera int foreign key references carrera(id_carrera)
)
GO

INSERT INTO carrera VALUES
(1 , 'Ciencias Sociales' , 8 , 4105776),
(2 , 'Ciencias Ambientales' , 12 , 8567000),
(3 , 'Diseño Grafico' , 6 , 875300),
(4 , 'Desarrollo Web' , 8 , 1500735),
(5 , 'Periodismo' , 5 , 605000),
(6 , 'Psicologia' , 10 , 3835000),
(7 , 'Ingenieria en Sistemas' , 12 , 6807000),
(8 , 'Arqueologia' , 8 , 5005258)
GO

INSERT INTO estudiante VALUES
(101 , 'Juan' , 'Perez' , '2019/05/12' , 20 , 'M' , 7),
(102 , 'Estefania' , 'Vasquez' , '2016/03/20' , 24 , 'F' , 2),
(103 , 'Rosa' , 'Llorente' , '2015/08/27' , 28 , 'F' , 5),
(104 , 'Pedro' , 'Ortiz' , '2020/02/05' , 31 ,'M' , 5),
(105 , 'Thomas' , 'Gallardo' , '2018/11/27' , 25 , 'M' , 8),
(106 , 'Yolanda' , 'Gomez' , '2021/06/01' , 19 , 'F' , 1),
(107 , 'Rodolfo' , 'Pardo' , '2016/07/19' , 26 ,'M' , 4),
(108 , 'Dolores' , 'Valverde' , '2020/03/28' , 20 , 'F' , 7),
(109 , 'Eduardo' , 'Martinez' , '2017/08/09' , 26 ,'M' , 6),
(110 , 'Ana' , 'Botero' , '2015/08/21' , 27 , 'F' , 3)
GO

INSERT INTO asignaturas VALUES
( 1001 , 'Calculo Diferencial', 2 , 'A205', 7 ),
( 1002 , 'Diseño de Interiores', 4 , 'B401', 3 ),
( 1003 , 'Marketing', 5 , 'B208', 3 ),
( 1004 , 'Historia', 3 , 'A103', 1 ),
( 1005 , 'Multimedia', 4 , 'C105', 4 ),
( 1006 , 'Publicidad', 2 , 'D301', 5 ),
( 1007 , 'Arquitectura de Software', 4 , 'B302', 7 ),
( 1008 , 'Disdrometros', 5 , 'B502', 2 ),
( 1009 , 'Trastornos Mentales', 4 , 'A303', 6 ),
( 1010 , 'Fisiologia', 3 , 'D202', 8 )
GO


--EJERCICIO #1

CREATE OR ALTER PROC sp_ejercicio_1 
	@N_CARRERA VARCHAR(20) = 'PERIODISMO', @SUMA INT OUTPUT, @PROM DECIMAL(8,2) OUTPUT
AS
	SELECT E.nombre, apellido, fecha_ingreso, C.nombre 'nombre carrera' FROM estudiante E
	INNER JOIN carrera C ON C.id_carrera = E.cod_carrera
	WHERE C.nombre = @N_CARRERA

	SELECT @SUMA = SUM(costo), @PROM = AVG(costo) FROM carrera WHERE nombre = @N_CARRERA
GO

DECLARE @SUM INT, @PROM DECIMAL(8,2)
EXEC sp_ejercicio_1 DEFAULT, @SUM OUTPUT, @PROM OUTPUT

SELECT CONVERT(CHAR, @SUM) 'SUMA', CONVERT(CHAR, @PROM) 'PROMEDIO'
GO


--EJERCICIO #2

CREATE OR ALTER PROC sp_ejercicio_2
@cod_estudiante varchar(5), @intensidad decimal(8,2) output
AS
select e.nombre, e.apellido, c.nombre, a.nombre from estudiante e
inner join carrera c on c.id_carrera = e.cod_carrera
inner join asignaturas a on c.id_carrera = a.cod_carrera
where e.id_estudiante = @cod_estudiante

select @intensidad = avg(a.intensidad) from estudiante e
inner join carrera c on c.id_carrera = e.cod_carrera
inner join asignaturas a on c.id_carrera = a.cod_carrera
where e.id_estudiante = @cod_estudiante
GO

declare @resultado_intensidad decimal(8,2)
EXEC sp_ejercicio_2 101, @resultado_intensidad output
select @resultado_intensidad as 'intensidad promedio'
GO


--EJERCICIO #3

ALTER PROC sp_ejercicio_2
AS
select * from estudiante e
where e.nombre like '%AN%'
GO

EXEC  sp_ejercicio_2
GO


--EJERCICIO #4

CREATE OR ALTER PROC sp_ejercicio_4
	WITH ENCRYPTION
AS
	SELECT TOP 1 * 
	FROM carrera c
	ORDER BY c.costo DESC
GO

sp_helptext sp_ejercicio_4
EXEC sp_ejercicio_4