USE [Superstore]
GO
/****** Object:  StoredProcedure [dbo].[DeleteCustomer]    Script Date: 5/14/2026 1:07:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: BLAKE WATTS		
-- Create date: 4/16/26
-- Updated date: 5/14/2026
-- Description:	Delete the history of the product purchased 
-- EXEC DeleteOrderDetail @OrderID = 1
-- =============================================
CREATE PROCEDURE [dbo].[DeleteOrderDetail]
	@OrderID INT
AS
BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
		BEGIN
			DELETE FROM dbo.OrderDetail
			WHERE OrderID = @OrderID;
		END
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() AS ErrorMessage;
	END CATCH;
END