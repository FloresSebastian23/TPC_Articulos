
------------------------------------------------------------
--   TABLAS PARA COMPRAS
------------------------------------------------------------


    CREATE TABLE Clientes (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        Nombre NVARCHAR(50) NOT NULL,
        Apellido NVARCHAR(50) NOT NULL,
        Email NVARCHAR(100) NULL,
        Telefono NVARCHAR(50) NULL,
        Estado BIT NOT NULL DEFAULT 1
    );
END
GO

-- 2) Inserts de prueba
INSERT INTO Clientes (Nombre, Apellido, Email, Telefono)
VALUES
('Juan', 'Pérez', 'juan.perez@mail.com', '1155550000'),
('María', 'Gómez', 'maria.gomez@mail.com', '1166660000');
GO




CREATE TABLE Compras (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    IdProveedor INT NOT NULL,
    Fecha DATETIME NOT NULL DEFAULT GETDATE(),
    Total DECIMAL(18,2) NOT NULL,

    FOREIGN KEY (IdProveedor) REFERENCES Proveedores(Id)
);

CREATE TABLE CompraDetalle (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    IdCompra INT NOT NULL,
    IdArticulo INT NOT NULL,
    Cantidad INT NOT NULL,
    PrecioUnitario DECIMAL(18,2) NOT NULL,
    Subtotal DECIMAL(18,2) NOT NULL,

    FOREIGN KEY (IdCompra) REFERENCES Compras(Id),
    FOREIGN KEY (IdArticulo) REFERENCES Articulos(Id)
);

------------------------------------------------------------
--   TABLAS PARA VENTAS
------------------------------------------------------------

CREATE TABLE Ventas (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    NumeroFactura VARCHAR(20) NOT NULL UNIQUE,
    IdUsuario INT NOT NULL,
    Fecha DATETIME NOT NULL DEFAULT GETDATE(),
    Total DECIMAL(18,2) NOT NULL,

    FOREIGN KEY (IdUsuario) REFERENCES Usuarios(Id)
);

CREATE TABLE VentaDetalle (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    IdVenta INT NOT NULL,
    IdArticulo INT NOT NULL,
    Cantidad INT NOT NULL,
    PrecioUnitario DECIMAL(18,2) NOT NULL,
    Subtotal DECIMAL(18,2) NOT NULL,

    FOREIGN KEY (IdVenta) REFERENCES Ventas(Id),
    FOREIGN KEY (IdArticulo) REFERENCES Articulos(Id)
);

--------------------------
-- STORED PROCEDURES
--------------------------

CREATE PROCEDURE SP_Compras_Agregar
    @IdProveedor INT,
    @Total DECIMAL(18,2)
AS
BEGIN
    INSERT INTO Compras (IdProveedor, Total)
    VALUES (@IdProveedor, @Total);

    SELECT SCOPE_IDENTITY();
END


CREATE PROCEDURE SP_CompraDetalle_Agregar
    @IdCompra INT,
    @IdArticulo INT,
    @Cantidad INT,
    @PrecioUnitario DECIMAL(18,2),
    @Subtotal DECIMAL(18,2)
AS
BEGIN
    INSERT INTO CompraDetalle (IdCompra, IdArticulo, Cantidad, PrecioUnitario, Subtotal)
    VALUES (@IdCompra, @IdArticulo, @Cantidad, @PrecioUnitario, @Subtotal);

    UPDATE Articulos SET StockActual = StockActual + @Cantidad
    WHERE Id = @IdArticulo;
END


CREATE PROCEDURE SP_Ventas_Agregar
    @NumeroFactura VARCHAR(20),
    @IdUsuario INT,
    @Total DECIMAL(18,2)
AS
BEGIN
    INSERT INTO Ventas (NumeroFactura, IdUsuario, Total)
    VALUES (@NumeroFactura, @IdUsuario, @Total);

    SELECT SCOPE_IDENTITY();
END


CREATE PROCEDURE SP_VentaDetalle_Agregar
    @IdVenta INT,
    @IdArticulo INT,
    @Cantidad INT,
    @PrecioUnitario DECIMAL(18,2),
    @Subtotal DECIMAL(18,2)
AS
BEGIN
    INSERT INTO VentaDetalle (IdVenta, IdArticulo, Cantidad, PrecioUnitario, Subtotal)
    VALUES (@IdVenta, @IdArticulo, @Cantidad, @PrecioUnitario, @Subtotal);

    UPDATE Articulos SET StockActual = StockActual - @Cantidad
    WHERE Id = @IdArticulo;
END

------------------------------------------------------

CREATE PROCEDURE SP_ListarClientes
AS
BEGIN
    SELECT Id, Nombre, Apellido, Email
    FROM Clientes
END
GO

CREATE PROCEDURE SP_AgregarCliente
    @Nombre NVARCHAR(50),
    @Apellido NVARCHAR(50),
    @Email NVARCHAR(100)
AS
BEGIN
    INSERT INTO Clientes (Nombre, Apellido, Email)
    VALUES (@Nombre, @Apellido, @Email)
END
GO

CREATE PROCEDURE SP_ModificarCliente
    @Id INT,
    @Nombre NVARCHAR(50),
    @Apellido NVARCHAR(50),
    @Email NVARCHAR(100)
AS
BEGIN
    UPDATE Clientes
    SET Nombre = @Nombre,
        Apellido = @Apellido,
        Email = @Email
    WHERE Id = @Id
END
GO

CREATE PROCEDURE SP_EliminarCliente
    @Id INT
AS
BEGIN
    DELETE FROM Clientes WHERE Id = @Id
END
GO

-- Listar clientes activos
IF OBJECT_ID('SP_ListarClientes','P') IS NOT NULL
    DROP PROCEDURE SP_ListarClientes;
GO
CREATE PROCEDURE SP_ListarClientes
AS
BEGIN
    SET NOCOUNT ON;
    SELECT Id, Nombre, Apellido, Email, Telefono
    FROM Clientes
    WHERE Estado = 1;
END
GO

-- Agregar cliente
IF OBJECT_ID('SP_AgregarCliente','P') IS NOT NULL
    DROP PROCEDURE SP_AgregarCliente;
GO
CREATE PROCEDURE SP_AgregarCliente
    @Nombre NVARCHAR(50),
    @Apellido NVARCHAR(50),
    @Email NVARCHAR(100),
    @Telefono NVARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO Clientes (Nombre, Apellido, Email, Telefono)
    VALUES (@Nombre, @Apellido, @Email, @Telefono);
END
GO

-- Modificar cliente
IF OBJECT_ID('SP_ModificarCliente','P') IS NOT NULL
    DROP PROCEDURE SP_ModificarCliente;
GO
CREATE PROCEDURE SP_ModificarCliente
    @Id INT,
    @Nombre NVARCHAR(50),
    @Apellido NVARCHAR(50),
    @Email NVARCHAR(100),
    @Telefono NVARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE Clientes
    SET Nombre = @Nombre,
        Apellido = @Apellido,
        Email = @Email,
        Telefono = @Telefono
    WHERE Id = @Id;
END
GO

-- Eliminar cliente (lógica: pone Estado = 0)
IF OBJECT_ID('SP_EliminarCliente','P') IS NOT NULL
    DROP PROCEDURE SP_EliminarCliente;
GO
CREATE PROCEDURE SP_EliminarCliente
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE Clientes
    SET Estado = 0
    WHERE Id = @Id;
END
GO