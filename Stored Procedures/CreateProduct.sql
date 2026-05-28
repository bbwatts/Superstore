USE [Superstore]
GO
/****** Object:  StoredProcedure [dbo].[CreateProduct]    Script Date: 5/5/2026 1:40:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Blake watts 
-- Create date: 4/28/2026
-- Update date: 5/26/2026
-- Description:	Create a Product
-- EXEC CreateProduct @ProductName = 'New Product', @CategoryID = 1, @SubCategoryID = 1, @UnitPrice = 0.00, @Inventory = 10
-- =============================================
ALTER PROCEDURE [dbo].[CreateProduct]
	@ProductName NVARCHAR(150),
	@CategoryID INT,
	@SubCategoryID INT,
    @UnitPrice DECIMAL(18,2), 
	@Inventory INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    BEGIN TRY
		IF EXISTS (
		SELECT 1
		FROM dbo.Product
		WHERE ProductName = @ProductName
			AND CategoryID = @CategoryID
			AND SubCategoryID = @SubCategoryID
		)
		BEGIN
			DECLARE @ExistingProductID INT = (
				SELECT ProductID
				FROM dbo.Product
				WHERE ProductName = @ProductName
					AND CategoryID = @CategoryID
					AND SubCategoryID = @SubCategoryID
			);

			--Return existing Product
			EXEC GetProduct @ProductID = @ExistingProductID
			RETURN;
		END

���		INSERT INTO dbo.Product(ProductName, CategoryID, SubCategoryID, UnitPrice, Inventory)
		VALUES(@ProductName, @CategoryID, @SubCategoryID, @UnitPrice, @Inventory);

		--Return the newly created product
		DECLARE @NewProductID INT = SCOPE_IDENTITY();

		--Return the newly created product 
		EXEC GetProduct @ProductID = @NewProductID

		EXEC GetProduct @ProductID = CAST(SCOPE_IDENTITY() AS INT);
	END TRY
	BEGIN CATCH
���		SELECT ERROR_MESSAGE() AS ErrorMessage;
	END CATCH;
END