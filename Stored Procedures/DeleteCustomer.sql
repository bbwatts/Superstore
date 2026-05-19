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
-- Description:	Delete a Customer
-- EXEC DeleteCustomer @CustomerID = 1
-- EXEC DeleteCustomer @CustomerID = 1, Delete = 1 
-- =============================================
ALTER PROCEDURE [dbo].[DeleteCustomer]
	@CustomerID INT,
	@Delete BIT
AS
BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
		IF  @Delete = 1
			BEGIN

			--delete 
			EXEC DeleteAddress @CustomerID = @CustomerID, @Delete = 1

			DELETE FROM dbo.Customer
			WHERE CustomerID = @CustomerID;
		END 
	ELSE
		BEGIN
			UPDATE dbo.Customer
			SET IsActive = 0, DateUpdated = GETDATE()
			WHERE CustomerID = @CustomerID;
		END
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() AS ErrorMessage;
	END CATCH;
END
