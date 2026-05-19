USE Superstore
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: BLAKE WATTS		
-- Create date: 4/14/26
-- Updated date: 
-- Description:	Create a Customer
-- EXEC CreateCustomer @FirstName = 'blake', @LastName = 'watts', @SegmentID = 2
-- =============================================
CREATE PROCEDURE [dbo].[CreateCustomer]
	@FirstName nvarchar(50), 
	@LastName nvarchar(50), 
	@SegmentID INT
AS
BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
		INSERT INTO dbo.Customer (FirstName, LastName, SegmentID)
		VALUES (@FirstName, @LastName, @SegmentID);
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() AS ErrorMessage;
	END CATCH;
END
GO