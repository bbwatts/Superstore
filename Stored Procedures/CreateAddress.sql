﻿USE [Superstore]
GO
/****** Object:  StoredProcedure [dbo].[CreateAddress]    Script Date: 4/21/2026 1:54:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Blake Watts	
-- Create date: 5/12/2026
-- Update date: 
-- Description:	Create an Address for Customer
-- EXEC CreateAddress @AddressLine1 = '123 Main St', @AddressLine2 = 'Apt 4', @City = 'Anytown', @StateID = 1, CountryID = 1, @PostalCode = 12345, @RegionID = 1, @AddressTypeID = 1, @CustomerID = 1, @CustomerID = 1
-- =============================================
CREATE PROCEDURE [dbo].[CreateAddress]
	@AddressLine1 NVARCHAR(25),
	@AddressLine2 NVARCHAR(25),
	@City NVARCHAR(50),
	@StateID INT,
	@CountryID INT,
    @PostalCode INT,
    @RegionID INT,
    @AddressTypeID INT,
    @CustomerID  INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    BEGIN TRY
   		INSERT INTO dbo.Address(AddressLine1, AddressLine2, City, StateID, CountryID, 
			PostalCode, RegionID, AddressTypeID, CustomerID)
		VALUES(@AddressLine1, @AddressLine2, @City, @StateID, @CountryID, 
			@PostalCode, @RegionID, @AddressTypeID, @CustomerID);
	END TRY
	BEGIN CATCH
   		SELECT ERROR_MESSAGE() AS ErrorMessage;
	END CATCH;
END