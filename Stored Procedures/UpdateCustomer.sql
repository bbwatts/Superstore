USE Superstore
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: BLAKE WATTS		
-- Create date: 4/16/26
-- Updated date: 5/12/2026
-- Description:	UPDATE a Customer
-- EXEC UpdateCustomer @FirstName = 'Blake', @LastName = 'Watts', @SegmentID = 2, @CustomerID
-- =============================================
ALTER PROCEDURE [dbo].[UpdateCustomer]
	@FirstName nvarchar(50), 
	@LastName nvarchar(50), 
	@SegmentID INT,
	@CustomerID INT
AS
BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
		UPDATE dbo.Customer
		SET FirstName = COALESCE(@FirstName, FirstName),
		LastName = COALESCE(@LastName, LastName),
		SegmentID = COALESCE(@SegmentID, SegmentID),
		DateUpdated = GETDATE()
		WHERE CustomerID = @CustomerID;
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() AS ErrorMessage;
	END CATCH;
END
GO