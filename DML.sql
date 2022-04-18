USE blooddonors
GO

SELECT *
FROM donors
GO

/***************PROCIDURE FOR Donors TABLE***************/

--Insert Donors by Insert Procidure
DECLARE @ID INT
EXEC @ID = spInsertDonors @name = 'Mr. Mostafiz', @address = 'Feni'
SELECT 'Inserted ID :' + str(@ID)
GO


--Update Donors by Update Procidure
EXEC spUpdateDonors @id = 4, @name = 'Supti', @address = 'Dhaka'
GO

--Delete Donors by Delete Procidure
EXEC spDeleteDonors @id = 2
GO

SELECT *
FROM donors
GO

SELECT *
FROM patiantDonors
go

/***************PROCIDURE FOR Hospitals TABLE***************/

--Insert Hospitals by procidure
DECLARE @ID INT
EXEC @ID = spInsertHospitals @name = 'United'
SELECT 'Inserted Hospital ID : ' + str(@ID)
GO

--Update Hospitals by procidure
EXEC spUpdateHospitals @id = 1, @name = 'Popular' 
GO

--Delete Hospital by Procidure
EXEC spDeleteHospitals @id = 2
GO

SELECT*
FROM hospitals
GO

/***************PROCIDURE FOR Patiants TABLE***************/

--Insert Patiants by procidure
DECLARE @ID INT 
EXEC @ID = spInsertPatiants 
	@name = 'Mafuz', 
	@BGroup = 'A+', 
	@address = 'Dhaka', 
	@payment = 1800,
	@hospitalID = 4
SELECT 'Inserted patiant ID : ' + str(@ID)
GO

--Update Patiants by Procidure
EXEC spUpdatePatiants 
	@id = 1, 
	@name = 'Eftekher Alam',
	@BGroup = 'A+',
	@address = 'Bogura',
	@payment = 1500,
	@hospitalID = 2
GO

--Delete Patiants by Procidure
EXEC spDeletePatiants @id = 1
GO

SELECT *
FROM patiants
GO

/***************PROCIDURE FOR PatiantDonors TABLE***************/

--Insert PatiantDonors by Procidure
DECLARE @ID INT
EXEC @ID = spInsertPatiantDonors @donorID = 4, @patiantID = 3, @timeOfDonation = '2022-10-21'
SELECT 'Donation ID : ' + STR(@ID)
GO

--Update PatiantDonors by Procidure
EXEC spUpdatePatiantDonors @id = 1, @donorID = 4, @patiantID = 2, @timeOfDonation = '2021-05-10'
GO

--Delete PatiantDonors by Procidure
EXEC spDeletePatiantDonors @id = 9
GO

SELECT *
FROM patiantDonors
GO

SELECT *
FROM donors
GO

--------------VIEW------------------
--PATAINT Detalis by VIEW
SELECT *
FROM vPatiantDetails
GO

--Available Donors for donation by view
SELECT *
FROM vAvailableDonors
GO

--------------FUNCTIONS-----------------
--Donation details for a month 
SELECT *
FROM dbo.fnDonationDetails(1)
GO

----return patiants number based on blood group
SELECT dbo.fnPatiants('A+')