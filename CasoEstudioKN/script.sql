CREATE DATABASE CasoEstudioKN
USE [CasoEstudioKN]
GO
/****** Object:  Table [dbo].[CasasSistema]    Script Date: 16/4/2025 00:04:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CasasSistema](
	[IdCasa] [bigint] IDENTITY(1,1) NOT NULL,
	[DescripcionCasa] [varchar](30) NOT NULL,
	[PrecioCasa] [decimal](10, 2) NOT NULL,
	[UsuarioAlquiler] [varchar](30) NULL,
	[FechaAlquiler] [datetime] NULL,
 CONSTRAINT [PK_CasasSistema] PRIMARY KEY CLUSTERED 
(
	[IdCasa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[CasasSistema] ON 

INSERT [dbo].[CasasSistema] ([IdCasa], [DescripcionCasa], [PrecioCasa], [UsuarioAlquiler], [FechaAlquiler]) VALUES (1, N'Casa en San José', CAST(190000.00 AS Decimal(10, 2)), NULL, NULL)
INSERT [dbo].[CasasSistema] ([IdCasa], [DescripcionCasa], [PrecioCasa], [UsuarioAlquiler], [FechaAlquiler]) VALUES (2, N'Casa en Alajuela', CAST(145000.00 AS Decimal(10, 2)), NULL, NULL)
INSERT [dbo].[CasasSistema] ([IdCasa], [DescripcionCasa], [PrecioCasa], [UsuarioAlquiler], [FechaAlquiler]) VALUES (3, N'Casa en Cartago', CAST(115000.00 AS Decimal(10, 2)), NULL, NULL)
INSERT [dbo].[CasasSistema] ([IdCasa], [DescripcionCasa], [PrecioCasa], [UsuarioAlquiler], [FechaAlquiler]) VALUES (4, N'Casa en Heredia', CAST(122000.00 AS Decimal(10, 2)), NULL, NULL)
INSERT [dbo].[CasasSistema] ([IdCasa], [DescripcionCasa], [PrecioCasa], [UsuarioAlquiler], [FechaAlquiler]) VALUES (5, N'Casa en Guanacaste', CAST(105000.00 AS Decimal(10, 2)), NULL, NULL)
SET IDENTITY_INSERT [dbo].[CasasSistema] OFF
GO
/****** Object:  StoredProcedure [dbo].[SP_AlquilarCasa]    Script Date: 16/4/2025 00:04:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_AlquilarCasa]
	@IdCasa BIGINT,
	@UsuarioAlquiler VARCHAR(30)
AS
BEGIN
	IF EXISTS(
		SELECT 1
		FROM CasasSistema
		WHERE IdCasa = @IdCasa AND UsuarioAlquiler IS NULL
	)
	BEGIN
		UPDATE CasasSistema 
		SET UsuarioAlquiler = @UsuarioAlquiler,
			FechaAlquiler = GETDATE()
		WHERE IdCasa = @IdCasa 
	END
END
GO
/****** Object:  StoredProcedure [dbo].[SP_ListarCasas]    Script Date: 16/4/2025 00:04:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ListarCasas]
AS
BEGIN
	SELECT IdCasa,
		   DescripcionCasa
	FROM CasasSistema
	WHERE UsuarioAlquiler IS NULL
END
GO

ALTER PROCEDURE [dbo].[SP_ListarCasas]
AS
BEGIN
	SELECT IdCasa,
	       DescripcionCasa,
	       PrecioCasa
	FROM CasasSistema
	WHERE UsuarioAlquiler IS NULL
END
GO
/****** Object:  StoredProcedure [dbo].[SP_ObtenerCasasFiltradas]    Script Date: 16/4/2025 00:04:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ObtenerCasasFiltradas]
AS
BEGIN
	SELECT DescripcionCasa,
		   PrecioCasa,
		   UsuarioAlquiler,
		   CASE
				WHEN UsuarioAlquiler IS NULL THEN 'Disponible'
				ELSE 'Reservada'
		   END AS Estado,
		   FORMAT(FechaAlquiler, 'dd/MM/yyyy') AS Fecha
	FROM CasasSistema
	WHERE PrecioCasa >= 115000 AND PrecioCasa <= 180000
	ORDER BY 
			CASE
				WHEN UsuarioAlquiler IS NULL THEN 0
				ELSE 1
			END;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_ObtenerTodasCasas]    Script Date: 16/4/2025 00:04:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ObtenerTodasCasas]
AS
BEGIN
	SELECT DescripcionCasa,
		   PrecioCasa,
		   UsuarioAlquiler,
		   CASE
				WHEN UsuarioAlquiler IS NULL THEN 'Disponible'
				ELSE 'Reservada'
		   END AS Estado,
		   FORMAT(FechaAlquiler, 'dd/MM/yyyy') AS Fecha
	FROM CasasSistema
END
GO

ALTER PROCEDURE [dbo].[SP_ObtenerCasasFiltradas]
AS
BEGIN
	SELECT 
		DescripcionCasa,
		PrecioCasa,
		UsuarioAlquiler,
		FechaAlquiler,
		CASE
			WHEN UsuarioAlquiler IS NULL THEN 'Disponible'
			ELSE 'Reservada'
		END AS Estado
	FROM CasasSistema
	WHERE PrecioCasa >= 115000 AND PrecioCasa <= 180000
	ORDER BY 
		CASE
			WHEN UsuarioAlquiler IS NULL THEN 0
			ELSE 1
		END;
END
go