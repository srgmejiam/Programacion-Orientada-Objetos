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
@NombreCompleto VARCHAR(200),
@Correo VARCHAR(200),
@UserName VARCHAR(50),
@Password VARBINARY(MAX),
@IdRol INT,
@IdUsuarioRegistra INT
AS
BEGIN
	BEGIN TRANSACTION Insertar
	BEGIN TRY
		INSERT INTO Usuarios (NombreCompleto, Correo, UserName, Password, Bloqueado, IntentosFallidos, IdRol, Activo, IdUsuarioRegistra, FechaRegistro)
			VALUES (@NombreCompleto, @Correo, @UserName, @Password, 0, 0, @IdRol, 1, @IdUsuarioRegistra, GETDATE());
		SELECT
			SCOPE_IDENTITY() AS IdUsuario
		COMMIT TRANSACTION Insertar
	END TRY
	BEGIN CATCH
		SELECT
			0 AS Error
		ROLLBACK TRANSACTION Insertar
	END CATCH
END
GO
CREATE PROC ActualizarUsuario @IdUsuario INT,
@NombreCompleto VARCHAR(200),
@Correo VARCHAR(200),
@UserName VARCHAR(50),
@IdRol INT,
@IdUsuarioActualiza INT
AS
BEGIN
	BEGIN TRANSACTION Actualizar
	BEGIN TRY
		UPDATE Usuarios
		SET NombreCompleto = @NombreCompleto
		   ,Correo = @Correo
		   ,UserName = @UserName
		   ,IdRol = @IdRol
		   ,IdUsuarioActualiza = @IdUsuarioActualiza
		   ,FechaActualizacion = GETDATE()
		WHERE IdUsuario = @IdUsuario;
		SELECT
			@IdUsuario AS IdUsuario
		COMMIT TRANSACTION Actualizar
	END TRY
	BEGIN CATCH
		SELECT
			0 AS Error
		ROLLBACK TRANSACTION Actualizar
	END CATCH
END
GO
CREATE PROC ActualizarPassword @IdUsuario INT,
@IdUsuarioActualiza INT,
@Password VARBINARY(MAX)
AS
BEGIN
	BEGIN TRANSACTION Actualizar
	BEGIN TRY
		UPDATE Usuarios
		SET Password = @Password
		   ,IdUsuarioActualiza = @IdUsuarioActualiza
		   ,FechaActualizacion = GETDATE()
		WHERE IdUsuario = @IdUsuario;
		SELECT
			@IdUsuario AS IdUsuario
		COMMIT TRANSACTION Actualizar
	END TRY
	BEGIN CATCH
		SELECT
			0 AS Error
		ROLLBACK TRANSACTION Actualizar
	END CATCH
END
GO
CREATE PROC SumarIntentoFallido @IdUsuario INT
AS
BEGIN
	BEGIN TRANSACTION Actualizar
	BEGIN TRY
		DECLARE @IntentosFallidos SMALLINT;
		SET @IntentosFallidos = (SELECT
				u.IntentosFallidos
			FROM Usuarios u
			WHERE u.IdUsuario = @IdUsuario)
		UPDATE Usuarios
		SET IntentosFallidos = @IntentosFallidos + 1
		WHERE IdUsuario = @IdUsuario;
		SELECT
			@IdUsuario AS IdUsuario
		COMMIT TRANSACTION Actualizar
	END TRY
	BEGIN CATCH
		SELECT
			0 AS Error
		ROLLBACK TRANSACTION Actualizar
	END CATCH
END
GO
CREATE PROC BloquearUsuario @IdUsuario INT
AS
BEGIN
	BEGIN TRANSACTION Actualizar
	BEGIN TRY
		UPDATE Usuarios
		SET Bloqueado = 1
		WHERE IdUsuario = @IdUsuario;
		SELECT
			@IdUsuario AS IdUsuario
		COMMIT TRANSACTION Actualizar
	END TRY
	BEGIN CATCH
		SELECT
			0 AS Error
		ROLLBACK TRANSACTION Actualizar
	END CATCH
END
GO
CREATE PROC AnularUsuario @IdUsuario INT,
@IdUsuarioActualiza INT
AS
BEGIN
	BEGIN TRANSACTION Actualizar
	BEGIN TRY
		UPDATE Usuarios
		SET Activo = 0
		   ,IdUsuarioActualiza = @IdUsuarioActualiza
		   ,FechaActualizacion = GETDATE()
		WHERE IdUsuario = @IdUsuario;
		SELECT
			@IdUsuario AS IdUsuario
		COMMIT TRANSACTION Actualizar
	END TRY
	BEGIN CATCH
		SELECT
			0 AS Error
		ROLLBACK TRANSACTION Actualizar
	END CATCH
END
GO
CREATE PROC SelectUsuario @IdUsuario INT = 0
AS
BEGIN
	IF @IdUsuario > 0
	BEGIN
		SELECT
			u.IdUsuario
		   ,u.NombreCompleto
		   ,u.Correo
		   ,u.UserName
		   ,u.Bloqueado
		   ,u.IntentosFallidos
		   ,u.IdRol
		   ,r.Rol
		   ,u.Activo
		FROM Usuarios u
		INNER JOIN Roles r
			ON u.IdRol = r.IdRol
		WHERE u.IdUsuario = @IdUsuario
	END
	ELSE
	BEGIN
		SELECT
			u.IdUsuario
		   ,u.NombreCompleto
		   ,u.Correo
		   ,u.UserName
		   ,u.Bloqueado
		   ,u.IntentosFallidos
		   ,u.IdRol
		   ,r.Rol
		   ,u.Activo
		FROM Usuarios u
		INNER JOIN Roles r
			ON u.IdRol = r.IdRol
		WHERE u.Activo = 1
	END
END
GO
EXEC InsertarUsuario
					@NombreCompleto = ''
					,@Correo = ''
					,@UserName = ''
					,@Password = NULL
					,@IdRol = 0
					,@IdUsuarioRegistra = 0

				GO 
			