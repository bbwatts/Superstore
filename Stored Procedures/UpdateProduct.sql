USE [Superstore]
GO
/****** Object:  StoredProcedure [dbo].[UpdateProduct]    Script Date: 5/5/2026 1:43:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Blake Watts 
-- Create date: 4/28/2026
-- Update date: 5/26/2026
-- Description:	Update a Product
-- EXEC UpdateProduct @ProductID = 1, @ProductName = 'New Product'
-- EXEC UpdateProduct @ProductID = 1, @ProductName = 'New Product', @CategoryID = 1,
-- EXEC UpdateProduct @ProductID = 1, @ProductName = 'New Product', @CategoryID = 1, @SubCategoryID = 1, @UnitPrice = 0.00, @Inventory = 10
-- =============================================
ALTER PROCEDURE [dbo].[UpdateProduct]
	@ProductID INT,
	@ProductName NVARCHAR(150) = NULL,
	@CategoryID INT = NULL,
	@SubCategoryID INT = NULL,
    @UnitPrice DECIMAL(18,2) = NULL,
	@Inventory INT = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    BEGIN TRY
   		UPDATE dbo.Product
       	SET ProductName = COALESCE(@ProductName, ProductName),
            CategoryID = COALESCE(@CategoryID, CategoryID),
            SubCategoryID = COALESCE(@SubCategoryID, SubCategoryID),
            UnitPrice = COALESCE(@UnitPrice, UnitPrice),
			Inventory = COALESCE(@Inventory, Inventory)
        WHERE ProductID = @ProductID;
	END TRY
	BEGIN CATCH
   		SELECT ERROR_MESSAGE() AS ErrorMessage;
	END CATCH;
END