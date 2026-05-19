﻿USE [Superstore]
GO
/****** Object:  StoredProcedure [dbo].[GetCustomer]    Script Date: 4/16/2026 1:12:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Milton Cruz	
-- Create date: 4/14/2024
-- Update date: 
-- Description:	Get all Customers
-- EXEC GetCustomer @CustomerID = 1
-- =============================================
CREATE PROCEDURE [dbo].[GetCustomer]
	@CustomerID INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    BEGIN TRY
   		-- Return the top 1 active customer with their segment information based on the provided CustomerID
		SELECT TOP 1 c.CustomerID, c.FirstName, c.LastName, s.Segment
		FROM dbo.Customer AS c
		JOIN dbo.Segment AS s 
		ON c.SegmentID = s.SegmentID
		WHERE c.CustomerID = @CustomerID AND IsActive = 1;
	END TRY
	BEGIN CATCH
   		SELECT ERROR_MESSAGE() AS ErrorMessage;
	END CATCH;
END