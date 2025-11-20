

CREATE DATABASE TPC_ARTICULOS_DB;
GO
USE TPC_ARTICULOS_DB;
GO

-- TABLA CATEGORIAS
CREATE TABLE Categorias (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Descripcion VARCHAR(50) NOT NULL
);

-- TABLA MARCAS
CREATE TABLE Marcas (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Descripcion VARCHAR(50) NOT NULL
);

-- TABLA ARTICULOS
CREATE TABLE Articulos (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Codigo VARCHAR(50) NOT NULL,
    Nombre VARCHAR(50) NOT NULL,
    Descripcion VARCHAR(200),
    IdMarca INT NOT NULL,
    IdCategoria INT NOT NULL,
    ImagenUrl VARCHAR(500),

    PrecioCompra DECIMAL(18,2) NOT NULL,
    PorcentajeGanancia DECIMAL(5,2) NOT NULL,
    StockActual INT NOT NULL,
    StockMinimo INT NOT NULL,

    PrecioVenta AS (PrecioCompra + (PrecioCompra * PorcentajeGanancia / 100)) PERSISTED,

    FOREIGN KEY (IdMarca) REFERENCES Marcas(Id),
    FOREIGN KEY (IdCategoria) REFERENCES Categorias(Id)
);
GO

--------------------------
-- INSERTS DE PRUEBA
--------------------------

INSERT INTO Categorias (Descripcion) VALUES 
('Telefonía'), 
('Electrodomésticos'), 
('Informática');

INSERT INTO Marcas (Descripcion) VALUES 
('Samsung'), 
('Apple'), 
('Sony'), 
('Logitech');

INSERT INTO Articulos (Codigo, Nombre, Descripcion, IdMarca, IdCategoria, ImagenUrl,
    PrecioCompra, PorcentajeGanancia, StockActual, StockMinimo)
VALUES
('A001', 'iPhone 14', 'Smartphone alta gama', 2, 1, '', 800, 40, 10, 3),
('A002', 'Televisor 55"', 'TV Sony 4K', 3, 2, '', 600, 50, 8, 2),
('A003', 'Mouse Logitech G203', 'Mouse gamer', 4, 3, '', 15, 100, 25, 5);
GO

--------------------------
-- STORED PROCEDURES
--------------------------

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

-- ELIMINAR BAJA LÓGICA (opcional)

ALTER TABLE Articulos ADD Estado BIT NOT NULL DEFAULT 1;
GO

CREATE PROCEDURE sp_EliminarArticulo
(
	@Id INT
)
AS
BEGIN
	UPDATE Articulos SET Estado = 0 WHERE Id = @Id;
END
GO


UPDATE Articulos 
SET ImagenUrl = 'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-14-blue-select-202209?wid=940&hei=1112&fmt=png-alpha&.v=1663703840764'
WHERE Codigo = 'A001';

UPDATE Articulos 
SET ImagenUrl = 'https://m.media-amazon.com/images/I/81iQIDWHv+L._AC_SL1500_.jpg'
WHERE Codigo = 'A002';

UPDATE Articulos 
SET ImagenUrl = 'https://storelaplata.com.ar/img/Public/1098-producto-312018a9f87ad715223aa7930de1-7448.jpg'
WHERE Codigo = 'A003';