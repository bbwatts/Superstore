USE [Superstore]
GO
/****** Object:  StoredProcedure [dbo].[GetAllCategories]    Script Date: 5/14/2026 2:46:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: BLAKE WATTS		
-- Create date: 5/14/26
-- Updated date: 
-- Description:	Get all Countries
-- EXEC GetAllCountries
-- =============================================
CREATE PROCEDURE [dbo].[GetAllCountries]
AS
BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
		-- RETURN THE TOP 100 ACTIVE CUSTOMERS WUTH THEIR SEGMENT INFO
		SELECT CountryID, Country
		FROM dbo.Country
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() AS ErrorMessage;
	END CATCH;


		-- Insert statements for procedure here
END