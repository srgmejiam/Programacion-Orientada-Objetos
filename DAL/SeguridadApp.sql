USE master
CREATE DATABASE POO
GO
USE POO
GO
CREATE TABLE Roles (
	IdRol INT PRIMARY KEY IDENTITY (1, 1)
   ,Rol VARCHAR(50) NOT NULL
   ,Activo BIT DEFAULT (1)
   ,IdUsuarioRegistra INT NOT NULL
   ,FechaRegistro DATETIME NOT NULL
   ,IdUsuarioActualiza INT NULL
   ,FechaActualizacion DATETIME NULL
)
GO
CREATE TABLE Usuarios (
	IdUsuario INT PRIMARY KEY IDENTITY (1, 1)
   ,NombreCompleto VARCHAR(200) NOT NULL
   ,Correo VARCHAR(200) NOT NULL
   ,UserName VARCHAR(50) NOT NULL
   ,Password VARBINARY(MAX) NOT NULL
   ,Bloqueado BIT NOT NULL
   ,IntentosFallidos SMALLINT NOT NULL DEFAULT (0)
   ,IdRol INT FOREIGN KEY REFERENCES Roles (IdRol)
   ,Activo BIT DEFAULT (1)
   ,IdUsuarioRegistra INT NOT NULL
   ,FechaRegistro DATETIME NOT NULL
   ,IdUsuarioActualiza INT NULL
   ,FechaActualizacion DATETIME NULL
)
GO
CREATE TABLE Formularios (
	IdFormulario INT PRIMARY KEY IDENTITY (1, 1)
   ,Formulario VARCHAR(50) NOT NULL
   ,Activo BIT DEFAULT (1)
   ,IdUsuarioRegistra INT NOT NULL
   ,FechaRegistro DATETIME NOT NULL
   ,IdUsuarioActualiza INT NULL
   ,FechaActualizacion DATETIME NULL
)
GO
CREATE TABLE Permisos (
	IdPermiso INT PRIMARY KEY IDENTITY (1, 1)
   ,Permiso VARCHAR(50) NOT NULL
   ,Activo BIT DEFAULT (1)
   ,IdUsuarioRegistra INT NOT NULL
   ,FechaRegistro DATETIME NOT NULL
   ,IdUsuarioActualiza INT NULL
   ,FechaActualizacion DATETIME NULL
)
CREATE TABLE RolFormularios (
	IdRolFormulario INT PRIMARY KEY IDENTITY (1, 1)
   ,IdRol INT FOREIGN KEY REFERENCES Roles (IdRol)
   ,IdFormulario INT FOREIGN KEY REFERENCES Formularios (IdFormulario)
   ,Activo BIT DEFAULT (1)
   ,IdUsuarioRegistra INT NOT NULL
   ,FechaRegistro DATETIME NOT NULL
   ,IdUsuarioActualiza INT NULL
   ,FechaActualizacion DATETIME NULL
)
GO
CREATE TABLE RolPermisos (
	IdRolPermiso INT PRIMARY KEY IDENTITY (1, 1)
   ,IdRol INT FOREIGN KEY REFERENCES Roles (IdRol)
   ,IdPermiso INT FOREIGN KEY REFERENCES Permisos (IdPermiso)
   ,Activo BIT DEFAULT (1)
   ,IdUsuarioRegistra INT NOT NULL
   ,FechaRegistro DATETIME NOT NULL
   ,IdUsuarioActualiza INT NULL
   ,FechaActualizacion DATETIME NULL
)
GO
CREATE PROC InsertarUsuario
@NombreCompleto Varchar (200),
@Correo Varchar (200),
@UserName varchar (50),
@Password varbinary (MAX),
@IdRol int,
@IdUsuarioRegistra int
AS
BEGIN
	BEGIN TRANSACTION Insertar
	BEGIN TRY
		INSERT INTO Usuarios (NombreCompleto,Correo,UserName,Password,Bloqueado,IntentosFallidos,IdRol,Activo,IdUsuarioRegistra,FechaRegistro)
		Values (@NombreCompleto,@UserName,@Correo,@Password,0,0,@IdRol,1,@IdUsuarioRegistra,GETDATE());
		SELECT SCOPE_IDENTITY() AS IdUsuario
		commit transaction Insertar
	END TRY
	BEGIN CATCH
		SELECT 0 AS Error
		ROLLBACK TRANSACTION Insertar
	END CATCH
END
GO

CREATE PROC ActualizarUsuario
@IdUsuario int,
@NombreCompleto Varchar (200),
@Correo Varchar (200),
@UserName varchar (50),
@IdRol int,
@IdUsuarioActualiza int
AS
BEGIN
	BEGIN TRANSACTION Actualizar
	BEGIN TRY
	UPDATE Usuarios
	SET NombreCompleto = @NombreCompleto,
		Correo = @Correo,
		UserName = @UserName,
		IdRol = @IdRol,
		IdUsuarioActualiza = @IdUsuarioActualiza,
		FechaActualizacion = GETDATE()
	WHERE IdUSuario = @IdUsuario;
	select @IdUsuario AS IdUsuario	
		commit transaction Actualizar
	END TRY
	BEGIN CATCH
		SELECT 0 AS Error
		ROLLBACK TRANSACTION Actualizar
	END CATCH
END
GO

CREATE PROC AnularUsuario
@IdUsuario int,
@IdUsuarioActualiza int,
@Password varbinary(MAX)
AS
BEGIN
	BEGIN TRANSACTION Anular
	BEGIN TRY
	UPDATE Usuarios
	SET Activo = 0,
		IdUsuarioActualiza = @IdUsuarioActualiza,
		FechaActualizacion = GETDATE()
	WHERE IdUSuario = @IdUsuario;
	select @IdUsuario AS IdUsuario	
		commit transaction Actualizar
	END TRY
	BEGIN CATCH
		SELECT 0 AS Error
		ROLLBACK TRANSACTION Anular
	END CATCH
END
go

CREATE PROC BloquearUsuario
@IdUsuario int
AS
BEGIN
	BEGIN TRANSACTION Bloquear
	BEGIN TRY
	UPDATE Usuarios
	SET Bloqueado = 1
	select @IdUsuario AS IdUsuario	
		commit transaction Bloquear
	END TRY
	BEGIN CATCH
		SELECT 0 AS Error
		ROLLBACK TRANSACTION Bloquear
	END CATCH
END
GO

CREATE PROC ActualizarPassword
@IdUsuario int,
@IdUsuarioActualiza int,
@Password varbinary(MAX)
AS
BEGIN
	BEGIN TRANSACTION Actualizar
	BEGIN TRY
	UPDATE Usuarios
	SET Password = @Password,
		IdUsuarioActualiza = @IdUsuarioActualiza,
		FechaActualizacion = GETDATE()
	WHERE IdUSuario = @IdUsuario;
	select @IdUsuario AS IdUsuario	
		commit transaction Actualizar
	END TRY
	BEGIN CATCH
		SELECT 0 AS Error
		ROLLBACK TRANSACTION Actualizar
	END CATCH
END
GO

CREATE PROC SumarIntentosFallidos
@IdUsuario int
AS
BEGIN
	BEGIN TRANSACTION Actualizar
	BEGIN TRY
	DECLARE @IntentosFallidos smallint;
		SET @IntentosFallidos = (SELECT u.IntentosFallidos from Usuarios u where u.IdUsuario=@IdUsuario)
	UPDATE Usuarios
	SET @IntentosFallidos += + 1
	select @IdUsuario AS IdUsuario	
		commit transaction Actualizar
	END TRY
	BEGIN CATCH
		SELECT 0 AS Error
		ROLLBACK TRANSACTION Actualizar
	END CATCH
END
GO

CREATE PROC	SelectUsers
@IdUsuario int = 0
AS
BEGIN	
	IF @IdUsuario > 0 
BEGIN
	SELECT
	U.IdUsuario,
	U.NombreCompleto,
	U.Correo,
	U.UserName,
	U.Bloqueado,
	U.IntentosFallidos,
	U.IdRol,
	R.Rol,
	U.Activo 
FROM Usuarios as U INNER JOIN Roles AS R ON U.IdRol = R.IdRol
WHERE U.IdUsuario = @IdUsuario
END
ELSE
BEGIN
	SELECT 
	U.IdUsuario,
	U.NombreCompleto,
	U.Correo,
	U.UserName,
	U.Bloqueado,
	U.IntentosFallidos,
	U.IdRol,
	R.Rol,
	U.Activo 
	FROM Usuarios as U INNER JOIN Roles AS R ON U.IdRol = R.IdRol
	WHERE U.Activo = 1
END
END
GO

Create proc InsertarRoles
@Rol VARCHAR(200),
@IdUsuarioRegistro INT
AS
BEGIN
	INSERT INTO Roles (Rol, IdUsuarioRegistra, FechaRegistro, Activo)
		VALUES (@Rol, @IdUsuarioRegistro, GETDATE(), 1);
	SELECT
	SCOPE_IDENTITY();
END
GO

CREATE PROC ActualizarRoles
@IdRol int,
@Rol VARCHAR(200),
@IdUsuarioActualiza INT
AS
BEGIN
	BEGIN TRANSACTION Actualizar
	BEGIN TRY
	UPDATE Roles
	SET Rol = @Rol
	   ,IdUsuarioActualiza = @IdUsuarioActualiza
	   ,FechaActualizacion = GETDATE()
	WHERE IdRol = @IdRol;
	select @IdRol AS IdRol	
		commit transaction Actualizar
	END TRY
	BEGIN CATCH
		SELECT 0 AS Error
		ROLLBACK TRANSACTION Actualizar
	END CATCH

END
GO

CREATE PROC AnularRoles
@IdRol INT,
@IdUsuarioActualiza INT
AS
BEGIN
	BEGIN TRANSACTION Anular
	BEGIN TRY
	UPDATE Roles
	SET Activo = 0
	   ,IdUsuarioActualiza = @IdUsuarioActualiza
	   ,FechaActualizacion = GETDATE()
	WHERE IdRol = @IdRol;
	select @IdRol AS IdRol	
		commit transaction Anular
	END TRY
	BEGIN CATCH
		SELECT 0 AS Error
		ROLLBACK TRANSACTION Anular
	END CATCH
END
GO

Create Proc ListarRoles
@Todos BIT,
@IdRol INT = 0
AS
BEGIN
	IF (@Todos = 1)
	BEGIN
		SELECT
			IdRol
		   ,IdRol AS Rol
		FROM Roles
		WHERE Activo = 1
	END
	ELSE
	BEGIN
		SELECT
			IdRol
		   ,IdRol AS Rol
		FROM Roles
		WHERE IdRol = @IdRol AND Activo = 1
	END
END
GO

Create proc InsertarFormularios
@Formulario varchar(50),
@IdUsuarioRegistra int
AS
BEGIN
 BEGIN TRANSACTION Insertar
 BEGIN TRY
  INSERT INTO Formularios (Formulario, IdUsuarioRegistra, FechaRegistro)
   VALUES (@Formulario, @IdUsuarioRegistra, GETDATE());
    SELECT SCOPE_IDENTITY() AS IdFormulario
	COMMIT TRANSACTION Insertar
 END TRY
 BEGIN CATCH
	SELECT 0 AS ERROR
	ROLLBACK TRANSACTION Insertar
 END CATCH
END
GO

CREATE PROC	ActualizarFormulario
@IdFormulario INT,
@Formulario VARCHAR(50),
@IdUsuarioActualiza INT
AS
BEGIN
 BEGIN TRANSACTION Actualizar
 BEGIN TRY
  UPDATE Formularios
  SET 
	Formulario = @Formulario,
	IdUsuarioActualiza = @IdUsuarioActualiza,
	FechaActualizacion = GETDATE()
	WHERE IdFormulario = @IdFormulario;
SELECT @IdFormulario AS IdFormulario
	COMMIT TRANSACTION Actualizar
 END TRY
 BEGIN CATCH
	SELECT 0 AS ERROR
	ROLLBACK TRANSACTION Actualizar
 END CATCH
END
GO

CREATE PROC	AnularFormulario
@IdFormulario INT,
@IdUsuarioActualiza INT
AS
BEGIN
 BEGIN TRANSACTION Anular
 BEGIN TRY
  UPDATE Formularios 
  SET 
	Activo = 0,
	IdUsuarioActualiza = @IdUsuarioActualiza,
	FechaActualizacion = GETDATE()
	WHERE IdFormulario = @IdFormulario;
SELECT @IdFormulario AS IdFormulario
	COMMIT TRANSACTION Anular
 END TRY
 BEGIN CATCH
	SELECT 0 AS ERROR
	ROLLBACK TRANSACTION Anular
 END CATCH
END
GO

CREATE PROC	InsertarRolFormulario
@IdRolFormulario INT,
@IdRol INT,
@IdFormulario INT,
@IdUsuarioRegistra INT
AS
BEGIN
 BEGIN TRANSACTION Insertar
 BEGIN TRY
  INSERT INTO RolFormularios(IdRol, IdFormulario, IdUsuarioRegistra, FechaRegistro)
   VALUES (@IdRol, @IdFormulario,@IdUsuarioRegistra, GETDATE());
    SELECT SCOPE_IDENTITY() AS IdRolFormulario
	COMMIT TRANSACTION Insertar
 END TRY
 BEGIN CATCH
	SELECT 0 AS ERROR
	ROLLBACK TRANSACTION Insertar
 END CATCH
END
GO

CREATE PROC	ActualizarRolFormurio
@IdRolFormulario INT,
@IdRol INT,
@Idformulario INT,
@IdUsuarioActualiza INT
AS
BEGIN
 BEGIN TRANSACTION Actualizar
 BEGIN TRY
  UPDATE RolFormularios
  SET 
	IdRol = @IdRol,
	IdFormulario = @Idformulario,
	IdUsuarioActualiza = @IdUsuarioActualiza,
	FechaActualizacion = GETDATE()
	WHERE IdRolFormulario = @IdRolFormulario;
SELECT @IdRolFormulario AS IdRolFormulario
	COMMIT TRANSACTION Actualizar
 END TRY
 BEGIN CATCH
	SELECT 0 AS ERROR
	ROLLBACK TRANSACTION Actualizar
 END CATCH
END
GO

CREATE PROC	AnularRolFormulario
@IdRolFormulario INT,
@IdUsuarioActualiza INT
AS
BEGIN
 BEGIN TRANSACTION Anular
 BEGIN TRY
  UPDATE RolFormularios
  SET 
	Activo = 0,
	IdUsuarioActualiza = @IdUsuarioActualiza,
	FechaActualizacion = GETDATE()
	WHERE IdRolFormulario = @IdRolFormulario;
SELECT @IdRolFormulario AS IdRolFormulario
	COMMIT TRANSACTION Anular
 END TRY
 BEGIN CATCH
	SELECT 0 AS ERROR
	ROLLBACK TRANSACTION Anular
 END CATCH
END
GO

CREATE PROC	InsertarPermisos
@Permiso VARCHAR(50),
@IdUsuarioRegistra INT
AS
BEGIN
 BEGIN TRANSACTION Insertar
 BEGIN TRY
  INSERT INTO Permisos(Permiso, IdUsuarioRegistra, FechaRegistro)
   VALUES (@Permiso, @IdUsuarioRegistra, GETDATE());
    SELECT SCOPE_IDENTITY() AS IdPermiso
	COMMIT TRANSACTION Insertar
 END TRY
 BEGIN CATCH
	SELECT 0 AS ERROR
	ROLLBACK TRANSACTION Insertar
 END CATCH
END
GO

CREATE PROC	ActualizarPermiso
@IdPermiso INT,
@Permiso VARCHAR(50),
@IdUsuarioActualiza INT
AS
BEGIN
 BEGIN TRANSACTION Actualizar
 BEGIN TRY
  UPDATE Permisos
  SET 
	Permiso = @Permiso,
	IdUsuarioActualiza = @IdUsuarioActualiza,
	FechaActualizacion = GETDATE()
	WHERE IdPermiso = @IdPermiso;
SELECT @IdPermiso AS IdPermiso
	COMMIT TRANSACTION Actualizar
 END TRY
 BEGIN CATCH
	SELECT 0 AS ERROR
	ROLLBACK TRANSACTION Actualizar
 END CATCH
END
GO

CREATE PROC	AnularPermiso
@IdPermiso INT,
@IdUsuarioActualiza INT
AS
BEGIN
 BEGIN TRANSACTION Anular
 BEGIN TRY
  UPDATE Permisos 
  SET 
	Activo = 0,
	IdUsuarioActualiza = @IdUsuarioActualiza,
	FechaActualizacion = GETDATE()
	WHERE IdPermiso = @IdPermiso;
SELECT @IdPermiso AS IdPermiso
	COMMIT TRANSACTION Anular
 END TRY
 BEGIN CATCH
	SELECT 0 AS ERROR
	ROLLBACK TRANSACTION Anular
 END CATCH
END
GO

CREATE PROC	InsertarRolPermiso
@IdRolPermiso INT,
@IdRol INT,
@IdPermiso INT,
@IdUsuarioRegistra INT
AS
BEGIN
 BEGIN TRANSACTION Insertar
 BEGIN TRY
  INSERT INTO RolPermisos(IdRol, IdPermiso, IdUsuarioRegistra, FechaRegistro)
   VALUES (@IdRol, @IdPermiso, @IdUsuarioRegistra, GETDATE());
    SELECT SCOPE_IDENTITY() AS IdRolPermiso
	COMMIT TRANSACTION Insertar
 END TRY
 BEGIN CATCH
	SELECT 0 AS ERROR
	ROLLBACK TRANSACTION Insertar
 END CATCH
END
GO

CREATE PROC	ActualizarRolPermiso
@IdRolPermiso INT,
@IdRol INT,
@IdPermiso INT,
@IdUsuarioActualiza INT
AS
BEGIN
 BEGIN TRANSACTION Actualizar
 BEGIN TRY
  UPDATE RolPermisos
  SET 
	IdRol = @IdRol,
	IdPermiso = @IdPermiso,
	IdUsuarioActualiza = @IdUsuarioActualiza,
	FechaActualizacion = GETDATE()
	WHERE IdRolPermiso = @IdRolPermiso;
SELECT @IdRolPermiso AS IdRolPermiso
	COMMIT TRANSACTION Actualizar
 END TRY
 BEGIN CATCH
	SELECT 0 AS ERROR
	ROLLBACK TRANSACTION Actualizar
 END CATCH
END
GO

CREATE PROC	AnularRolPermiso
@IdRolPermiso INT,
@IdUsuarioActualiza INT
AS
BEGIN
 BEGIN TRANSACTION Anular
 BEGIN TRY
  UPDATE RolPermisos
  SET 
	Activo = 0,
	IdUsuarioActualiza = @IdUsuarioActualiza,
	FechaActualizacion = GETDATE()
	WHERE IdRolPermiso = @IdRolPermiso;
SELECT @IdRolPermiso AS IdRolPermiso
	COMMIT TRANSACTION Anular
 END TRY
 BEGIN CATCH
	SELECT 0 AS ERROR
	ROLLBACK TRANSACTION Anular
 END CATCH
END