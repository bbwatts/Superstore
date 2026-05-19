USE Superstore
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: BLAKE WATTS		
-- Create date: 4/21/26
-- Updated date: 5/12/2026
-- Description:	Get all Addresses for customer
-- EXEC GetAllAddresses @CustomerID = 1
-- =============================================
ALTER PROCEDURE [dbo].[GetAllAddresses]
	@CustomerID INT
AS
BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
		SELECT TOP 10 a.AddressID, a.AddressLine1, a.AddressLine2, a.City,
		s.State, c.Country, r.Region, at.AddressType, a.CustomerID
		FROM dbo.Address AS a
		JOIN dbo.AddressType AS at
		ON a.AddressTypeID = at.AddressTypeID
		JOIN dbo.Country AS c
		ON a.CountryID = c.CountryID
		JOIN dbo.Region AS r
		ON a.RegionID = r.RegionID
		JOIN dbo.State AS s
		ON a.StateID = s.StateID
		WHERE IsActive = 1 AND CustomerID = @CustomerID;
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() AS ErrorMessage;
	END CATCH;
END
GO