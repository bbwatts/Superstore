?USE [Superstore]
GO
/****** Object:  StoredProcedure [dbo].[GetAddress]    Script Date: 4/21/2026 1:54:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Blake Watts
-- Create date: 4/21/2026
-- Update date: 5/12/2026
-- Description:	Get a Address
-- EXEC GetAddress @AddressID = 1 
-- =============================================
CREATE PROCEDURE [dbo].[GetAddress]
	@AddressID INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    BEGIN TRY
   		
		SELECT TOP 1 a.AddressID, a.AddressLine1, a.AddressLine2, a.City, 
		s.State, c.Country, r.Region, at.AddressType, a.CustomerID, p.Postalcode
		FROM dbo.Address AS a
		JOIN dbo.AddressType AS at 
		ON a.AddressTypeID = at.AddressTypeID
		JOIN dbo.Country AS c
		ON a.CountryID = c.CountryID
		JOIN dbo.Region AS r
		ON a.RegionID = r.RegionID
		JOIN dbo.State AS s
		ON a.StateID = s.StateID
		
		WHERE IsActive = 1 AND AddressID = @AddressID;
	END TRY
	BEGIN CATCH
   		SELECT ERROR_MESSAGE() AS ErrorMessage;
	END CATCH;
END