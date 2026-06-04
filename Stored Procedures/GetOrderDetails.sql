USE [Superstore]
GO
/****** Object:  StoredProcedure [dbo].[GetAllCustomers]    Script Date: 5/28/2026 1:10:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: BLAKE WATTS		
-- Create date: 5/28/26
-- Updated date: 
-- Description:	Get Order Details in JSON form
-- EXEC GetOrderDetails @OrderID = 1198
-- =============================================
CREATE PROCEDURE [dbo].[GetOrderDetails]
	@OrderID INT
AS
BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
		SELECT 
		JSON_QUERY(
			(SELECT OrderID, OrderDate, c.FirstName, c.LastName, SalesPrice, Quantity, Discount, Profit, s.Shipmode, ShipDate
			FROM dbo.[Order] AS o
			JOIN dbo.Customer as c
			ON o.CustomerID = c.CustomerID
			JOIN dbo.ShipMode AS s
			ON o.ShipModeID = s.ShipModeID

			WHERE OrderID = @OrderID AND o.IsActive = 1
			FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
			)
		) AS [Order],
			JSON_QUERY(
			(
				SELECT p.ProductID,
					   ProductName,
					   p.CategoryID,
					   cg.Category,
					   p.SubCategoryID,
					   sc.SubCategory,  -- Comma here
					   UnitPrice,       -- Comma here
					   Inventory        -- No trailing comma before FROM
           
				FROM dbo.OrderDetail od
				JOIN dbo.Product p
					ON od.ProductID = p.ProductID
				JOIN dbo.Category As cg
					ON p.CategoryID = cg.CategoryID
				JOIN dbo.SubCategory AS sc
					ON p.SubCategoryID = sc.SubCategoryID
				WHERE od.OrderID = @OrderID
				FOR JSON PATH
			)
			) AS [Products]
		FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() AS ErrorMessage;
	END CATCH;


		-- Insert statements for procedure here
END
