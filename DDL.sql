IF DB_ID('blooddonors') IS NULL
	CREATE DATABASE blooddonors
GO
USE blooddonors
GO

CREATE TABLE donors
(
	donorID INT PRIMARY KEY,
	donorName NVARCHAR(50) NOT NULL,
	donorAddress NVARCHAR(100) NOT NULL
)
GO

CREATE TABLE hospitals
(
	hospitalID INT PRIMARY KEY,
	hospitalName NVARCHAR(50) NOT NULL
)

CREATE TABLE patiants
(
	patiantID INT PRIMARY KEY,
	patiantName NVARCHAR(50) NOT NULL,
	bloodGroup NVARCHAR(20) NOT NULL,
	patiantAddress NVARCHAR(100) NOT NULL,
	payment MONEY NOT NULL,
	hospitalID INT NOT NULL REFERENCES hospitals(hospitalID)
)
GO

CREATE TABLE patiantDonors
(
	donationID INT PRIMARY KEY,
	donorID INT NOT NULL REFERENCES donors(donorID),
	patiantID INT NOT NULL REFERENCES patiants(patiantID),
	timeOfDonation DATETIME NOT NULL
)
GO

/***************PROCIDURE FOR Donors TABLE***************/

--Insert Donors Procidure
CREATE PROC spInsertDonors 
	@name NVARCHAR(50), 
	@address NVARCHAR(100)
AS
DECLARE @id INT
SELECT @id = ISNULL(MAX(donorID), 0)+1 FROM donors
BEGIN TRY
	INSERT INTO donors (donorID, donorName, donorAddress)
	VALUES (@id, @name, @address)
	RETURN @id
END TRY
BEGIN CATCH
	; 
	THROW 50001, 'Faild to insert the entity', 1
	RETURN 0
END CATCH
GO

--Update Donors Procidure
CREATE PROC spUpdateDonors 
	@id INT, 
	@name NVARCHAR(30), 
	@address NVARCHAR(100)
AS
BEGIN TRY
	UPDATE donors 
	SET donorName = @name, donorAddress = @address
	WHERE donorID = @id
END TRY
BEGIN CATCH 
	DECLARE @errmessage nvarchar(500)
	SET @errmessage = ERROR_MESSAGE()
	RAISERROR( @errmessage, 11, 1)
	RETURN 
END CATCH
GO

--Delete Donors Procidure
CREATE PROC spDeleteDonors @id INT
AS
BEGIN TRY
	DELETE donors
	WHERE donorID = @id
END TRY
BEGIN CATCH
	;
	THROW 50002, 'Faild to delete', 1
END CATCH
GO


/***************PROCIDURE FOR Hospitals TABLE***************/

--Insert Hospital Procidure
CREATE PROC spInsertHospitals
	@name NVARCHAR(50)
AS
DECLARE @id INT
SELECT @id = ISNULL(MAX(hospitalID), 0)+1 FROM hospitals
BEGIN TRY
	INSERT INTO hospitals(hospitalID, hospitalName)
	VALUES (@id, @name)
	RETURN @id
END TRY
BEGIN CATCH
	DECLARE @errmessage nvarchar(500)
	SET @errmessage = ERROR_MESSAGE()
	RAISERROR( @errmessage, 11, 1)
	RETURN 
END CATCH
GO

--Update Hospital Procidure
CREATE PROC spUpdateHospitals @id INT, @name NVARCHAR(30)
AS
BEGIN TRY
	UPDATE hospitals 
	SET hospitalName = @name
	WHERE hospitalID = @id
END TRY
BEGIN CATCH 
	;
	THROW 50001, 'Faild to update', 1
END CATCH
GO

--Delete Hospitals Procidure
CREATE PROC spDeleteHospitals @id INT
AS
BEGIN TRY
	DELETE hospitals
	WHERE hospitalID = @id
END TRY
BEGIN CATCH
 	DECLARE @errmessage nvarchar(500)
	SET @errmessage = ERROR_MESSAGE()
	RAISERROR( @errmessage, 11, 1)
	RETURN 
END CATCH
GO

/***************PROCIDURE FOR Patiants TABLE***************/

--Insert Patiants Procidure
CREATE PROC spInsertPatiants
	@name NVARCHAR(50),
	@BGroup NVARCHAR(20),
	@address NVARCHAR(100),
	@payment MONEY,
	@hospitalID INT
AS
DECLARE @id INT
SELECT @id = ISNULL(MAX(patiantID), 0)+1 FROM patiants
BEGIN TRY
	INSERT INTO patiants(patiantID, patiantName, bloodGroup, patiantAddress, payment, hospitalID)
	VALUES (@id, @name, @BGroup, @address, @payment, @hospitalID)
	RETURN @id
END TRY
BEGIN CATCH
	DECLARE @errmessage nvarchar(500)
	SET @errmessage = ERROR_MESSAGE()
	RAISERROR( @errmessage, 11, 1)
	RETURN
END CATCH
GO

--Update Patiant Procidure
CREATE PROC spUpdatePatiants 
	@id INT, 
	@name NVARCHAR(50),
	@BGroup NVARCHAR(20),
	@address NVARCHAR(100),
	@payment MONEY,
	@hospitalID INT

AS
BEGIN TRY
	UPDATE patiants 
	SET patiantName = @name,
		bloodGroup = @BGroup,
		patiantAddress = @address,
		payment = @payment,
		hospitalID = @hospitalID
	WHERE patiantID = @id
END TRY
BEGIN CATCH 
	;
	THROW 50001, 'Faild to update', 1
END CATCH
GO

--Delete Patiant Procidure
CREATE PROC spDeletePatiants @id INT
AS
BEGIN TRY
	DELETE patiants
	WHERE patiantID = @id
END TRY
BEGIN CATCH
	DECLARE @errmessage nvarchar(500)
	SET @errmessage = ERROR_MESSAGE()
	RAISERROR( @errmessage, 11, 1)
	RETURN
END CATCH
GO


/***************PROCIDURE FOR PatiantDonors TABLE***************/

--Insert PatiantDonors Procidure
CREATE PROC spInsertPatiantDonors
	@donorID INT,
	@patiantID INT,
	@timeOfDonation DATETIME
AS
	DECLARE @id INT
	SELECT @id = ISNULL(MAX(donationID), 0)+1 FROM patiantDonors
BEGIN TRY
	INSERT INTO patiantDonors (donationID, donorID, patiantID, timeOfDonation)
	VALUES (@id, @donorID, @patiantID, @timeOfDonation)
	RETURN @id
END TRY
BEGIN CATCH
	DECLARE @errmessage nvarchar(500)
	SET @errmessage = ERROR_MESSAGE()
	RAISERROR( @errmessage, 11, 1)
	RETURN
END CATCH
GO
--Update PatiantDonors Procidure
CREATE PROC spUpdatePatiantDonors
	@id INT, 
	@donorID INT,
	@patiantID INT,
	@timeOfDonation DATETIME

AS
BEGIN TRY
	UPDATE patiantDonors
	SET donorID = @donorID,
		patiantID = @patiantID,
		timeOfDonation = @timeOfDonation
	WHERE donationID = @id
END TRY
BEGIN CATCH 
	DECLARE @errmessage nvarchar(500)
	SET @errmessage = ERROR_MESSAGE()
	RAISERROR( @errmessage, 11, 1)
	RETURN
END CATCH
GO

--DELETE PatiantDonors Procidure
CREATE PROC spDeletePatiantDonors @id INT
AS
BEGIN TRY
	DELETE patiantDonors
	WHERE donationID = @id
END TRY
BEGIN CATCH
	;
	THROW 50002, 'Faild to delete', 1
END CATCH
GO

--VIEW for patiant with details

CREATE VIEW vPatiantDetails
WITH ENCRYPTION
AS
SELECT H.hospitalName, P.patiantName, P.patiantAddress, D.donorName, D.donorAddress, PD.timeOfDonation
FROM patiants P
INNER JOIN hospitals H ON H.hospitalID = P.hospitalID
INNER JOIN patiantDonors PD ON P.patiantID = PD.patiantID
INNER JOIN donors D ON D.donorID = PD.donorID
GO

--VIEW for Donors with details
CREATE VIEW vAvailableDonors
WITH ENCRYPTION
AS
(
	SELECT D.donorName, CAST(PD.timeOfDonation AS DATE) AS 'donation date', D.donorAddress
	FROM donors D
	INNER JOIN patiantDonors PD ON PD.donorID = D.donorID
	WHERE DATEDIFF(MONTH, PD.timeOfDonation, GETDATE()) > 3
)
GO

--udf

CREATE FUNCTION fnDonationDetails (@MONTH INT) RETURNS TABLE
AS
RETURN
(
	SELECT D.donorName, CAST(PD.timeOfDonation AS DATE) AS 'donationDate', P.patiantName, P.payment
	FROM donors d
	INNER JOIN patiantDonors PD ON PD.donorID = D.donorID
	INNER JOIN patiants P ON P.patiantID = PD.patiantID
	WHERE @MONTH = MONTH(PD.timeOfDonation) AND YEAR(PD.timeOfDonation) = YEAR(GETDATE())
)
GO

--Scalar 
CREATE FUNCTION fnPatiants (@bloodGroup NVARCHAR(15)) RETURNS INT
AS
BEGIN
	DECLARE @total INT
	SELECT @total = COUNT(*) FROM patiants
	WHERE @bloodGroup = bloodGroup
	RETURN @total
END
GO

-----Trigger------

CREATE TRIGGER trDonorDelete
ON donors
AFTER DELETE
AS
BEGIN
	 DECLARE @id INT
	 SELECT @id = donorID FROM deleted
	 DELETE FROM patiantDonors 
	 WHERE @id = donorID
END
GO
CREATE trigger trInsertDonation
ON patiantDonors
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @d_id INT , @cd DATE, @ld DATE
	SELECT @d_id = donorID, @cd = timeOfDonation from inserted
	SELECT max(timeOfDonation) from patiantDonors where donorID=@d_id
	IF DATEDIFF(day, @ld, @cd) <90
	BEGIN
		RAISERROR('Cannot donate in 90 days', 16, 1)
		RETURN
	END
	INSERT INTO patiantDonors
	SELECT * FROM inserted
END
GO
--USE master
--GO

--DROP db1264783
--GO



