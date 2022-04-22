CREATE DATABASE [ Actividad #15 - Jarrison Cano y Bryan Muñoz]
GO

USE  [ Actividad #15 - Jarrison Cano y Bryan Muñoz]
GO


-- PUNTO 2
CREATE TABLE punto_2
(
    NOMBRE XML,
    EDAD XML
)
GO

	--PROCEDIMIENTO PARA ALMACENAR LOS DATOS
CREATE OR ALTER PROC sp_2
AS
	DECLARE @XML XML
	SET @XML = '
	<usuarios>
		<usuario userid="1" nombre="jarrison">
			<nombreusuario>Jarrison</nombreusuario>
			<apellidousuario>Cano</apellidousuario>
			<edadusuario>18</edadusuario>
		</usuario>
		 <usuario userid="2" nombre="Bryan">
			<nombreusuario>Bryan</nombreusuario>
			<apellidousuario>Muñoz</apellidousuario>
			<edadusuario>18</edadusuario>
		</usuario>
	</usuarios>
'
	--inserta los datos
	INSERT INTO punto_2
	VALUES
		(
			@XML.query('/usuarios/usuario/nombreusuario')
	,
			@XML.query('/usuarios/usuario/edadusuario')
	)
GO

EXEC sp_2
GO

--PUNTO 3
SELECT *
FROM punto_2
GO

--PUNTO 4
CREATE TABLE punto_4

(
    nombre VARCHAR(20),
    apellido VARCHAR(20),
    edad INT
)
GO

CREATE OR ALTER PROC sp_4
AS
	DECLARE @XML XML
	SET @XML = '
	<usuarios>
		<usuario userid="1" nombre="jarrison">
			<nombreusuario>Jarrison</nombreusuario>
			<apellidousuario>Cano</apellidousuario>
			<edadusuario>18</edadusuario>
		</usuario>
		 <usuario userid="2" nombre="Bryan">
			<nombreusuario>Bryan</nombreusuario>
			<apellidousuario>Muñoz</apellidousuario>
			<edadusuario>18</edadusuario>
		</usuario>
	</usuarios>
'
	INSERT INTO punto_4
	VALUES
		(
			@XML.value('(/usuarios/usuario/nombreusuario)[1]', 'VARCHAR(20)' ),
			@XML.value('(/usuarios/usuario/apellidousuario)[1]', 'VARCHAR(20)' ),
			@XML.value('(/usuarios/usuario/edadusuario)[1]', 'INT')

	),

		(
			@XML.value('(/usuarios/usuario/nombreusuario)[2]', 'VARCHAR(20)' ),
			@XML.value('(/usuarios/usuario/apellidousuario)[2]', 'VARCHAR(20)' ),
			@XML.value('(/usuarios/usuario/edadusuario)[2]', 'INT')
	)
GO

EXEC sp_4
GO

SELECT *
FROM punto_4
GO