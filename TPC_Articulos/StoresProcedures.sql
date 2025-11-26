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

ALTER PROCEDURE SP_Ventas_Agregar
    @NumeroFactura VARCHAR(20),
    @IdUsuario INT,
    @Total DECIMAL(18,2)
AS
BEGIN
    INSERT INTO Ventas (NumeroFactura, IdUsuario, Total)
    VALUES (@NumeroFactura, @IdUsuario, @Total);

    SELECT CAST(SCOPE_IDENTITY() AS INT) AS IdVenta;
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

-- AGREGAR ARTICULO

CREATE PROCEDURE sp_AgregarArticulo
(
	@Codigo VARCHAR(50),
	@Nombre VARCHAR(50),
	@Descripcion VARCHAR(200),
	@IdMarca INT,
	@IdCategoria INT,
	@ImagenUrl VARCHAR(500),
	@PrecioCompra DECIMAL(18,2),
	@PorcentajeGanancia DECIMAL(5,2),
	@StockActual INT,
	@StockMinimo INT
)
AS
BEGIN
	INSERT INTO Articulos 
	(Codigo, Nombre, Descripcion, IdMarca, IdCategoria, ImagenUrl,
	 PrecioCompra, PorcentajeGanancia, StockActual, StockMinimo)
	VALUES
	(@Codigo, @Nombre, @Descripcion, @IdMarca, @IdCategoria, @ImagenUrl,
	 @PrecioCompra, @PorcentajeGanancia, @StockActual, @StockMinimo);
END
GO

-- MODIFICAR ARTICULO

CREATE PROCEDURE sp_ModificarArticulo
(
	@Id INT,
	@Codigo VARCHAR(50),
	@Nombre VARCHAR(50),
	@Descripcion VARCHAR(200),
	@IdMarca INT,
	@IdCategoria INT,
	@ImagenUrl VARCHAR(500),
	@PrecioCompra DECIMAL(18,2),
	@PorcentajeGanancia DECIMAL(5,2),
	@StockActual INT,
	@StockMinimo INT
)
AS
BEGIN
	UPDATE Articulos SET
		Codigo = @Codigo,
		Nombre = @Nombre,
		Descripcion = @Descripcion,
		IdMarca = @IdMarca,
		IdCategoria = @IdCategoria,
		ImagenUrl = @ImagenUrl,
		PrecioCompra = @PrecioCompra,
		PorcentajeGanancia = @PorcentajeGanancia,
		StockActual = @StockActual,
		StockMinimo = @StockMinimo
	WHERE Id = @Id;
END
GO

-- ELIMINAR BAJA LÓGICA 

ALTER TABLE Articulos ADD Estado BIT NOT NULL DEFAULT 1;


CREATE PROCEDURE sp_EliminarArticulo
(
	@Id INT
)
AS
BEGIN
	UPDATE Articulos SET Estado = 0 WHERE Id = @Id;
END



UPDATE Articulos 
SET ImagenUrl = 'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-14-blue-select-202209?wid=940&hei=1112&fmt=png-alpha&.v=1663703840764'
WHERE Codigo = 'A001';

UPDATE Articulos 
SET ImagenUrl = 'https://m.media-amazon.com/images/I/81iQIDWHv+L._AC_SL1500_.jpg'
WHERE Codigo = 'A002';

UPDATE Articulos 
SET ImagenUrl = 'https://storelaplata.com.ar/img/Public/1098-producto-312018a9f87ad715223aa7930de1-7448.jpg'
WHERE Codigo = 'A003';


	   create procedure sp_ExisteUsuario
	      @UsNombre varchar(100)
	as
	begin
	   select count(*) as Existe
	   from Usuarios
	   where NombreUsuario = @UsNombre and Estado = 1
	end
-----------------------------------------------

	create procedure sp_AgregarUsuario
	(   @UsNombre varchar(100),
        @Clave varchar(100),
		@EsAdmin bit
     )
	 as
	 begin
	   insert into Usuarios (NombreUsuario,Pass,EsAdmin)
	   values (@UsNombre, @Clave, @EsAdmin);
	end
------------------------------------------------------
   
   create procedure sp_login
   (   
         @UsNombre varchar(100),
		 @Pass varchar(100)
   )
   as
   begin
      select Id, NombreUsuario, EsAdmin
	  from Usuarios
	  where NombreUsuario = @UsNombre
	  and Pass = @Pass
	  and Estado = 1;
    end