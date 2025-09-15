CREATE DATABASE MASSACHUSETTS_GH

USE MASSACHUSETTS_GH
GO
SELECT * FROM dbo.procedures
-- =============================================
-- DATA CLEANING
-- =============================================

/*
   0. BACKUP TABLES BEFORE CLEANING
*/

-- Backup Patients
SELECT * INTO patients_backup
FROM dbo.patients;
GO
-- Backup Encounters
SELECT * INTO encounters_backup
FROM dbo.encounters;
GO
-- Backup Payers
SELECT * INTO payers_backup
FROM dbo.payers;
GO
-- Backup Procedures
SELECT * INTO procedures_backup
FROM dbo.procedures;
GO

/* =====================================================
   1. IDENTIFY NULL VALUES ACROSS ALL TABLES
===================================================== */

-- -- Null check for Patients
SELECT 
    SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) AS null_patient_id,
	SUM(CASE WHEN BIRTHDATE IS NULL THEN 1 ELSE 0 END) AS null_birthdate,
	SUM(CASE WHEN DEATHDATE IS NULL THEN 1 ELSE 0 END) AS null_deathdate,
	SUM(CASE WHEN PREFIX IS NULL THEN 1 ELSE 0 END) AS null_prefix,
	SUM(CASE WHEN FIRST IS NULL THEN 1 ELSE 0 END) AS null_firstname,
	SUM(CASE WHEN LAST IS NULL THEN 1 ELSE 0 END) AS null_lastname,
	SUM(CASE WHEN SUFFIX IS NULL THEN 1 ELSE 0 END) AS null_suffix,
	SUM(CASE WHEN MAIDEN IS NULL THEN 1 ELSE 0 END) AS null_maiden,
	SUM(CASE WHEN MARITAL IS NULL THEN 1 ELSE 0 END) AS null_martialstatus,
	SUM(CASE WHEN RACE IS NULL THEN 1 ELSE 0 END) AS null_race,
	SUM(CASE WHEN ETHNICITY IS NULL THEN 1 ELSE 0 END) AS null_ethnicity,
    SUM(CASE WHEN gender IS NULL OR gender='' THEN 1 ELSE 0 END) AS null_gender,
	SUM(CASE WHEN BIRTHPLACE IS NULL THEN 1 ELSE 0 END) AS null_birthplace,
	SUM(CASE WHEN ADDRESS IS NULL THEN 1 ELSE 0 END) AS null_address,
	SUM(CASE WHEN CITY IS NULL THEN 1 ELSE 0 END) AS null_city,
	SUM(CASE WHEN STATE IS NULL THEN 1 ELSE 0 END) AS null_state,
	SUM(CASE WHEN COUNTY IS NULL THEN 1 ELSE 0 END) AS null_county,
	SUM(CASE WHEN ZIP IS NULL THEN 1 ELSE 0 END) AS null_zip,
	SUM(CASE WHEN LAT IS NULL THEN 1 ELSE 0 END) AS null_latitude,
	SUM(CASE WHEN LON IS NULL THEN 1 ELSE 0 END) AS null_longitude
FROM dbo.patients;
GO
-- Null check for Encounters
SELECT 
    SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) AS null_encounter_id,
    SUM(CASE WHEN START IS NULL THEN 1 ELSE 0 END) AS null_start,
    SUM(CASE WHEN STOP IS NULL THEN 1 ELSE 0 END) AS null_stop,
    SUM(CASE WHEN PATIENT IS NULL THEN 1 ELSE 0 END) AS null_patient,
	SUM(CASE WHEN ORGANIZATION IS NULL THEN 1 ELSE 0 END) AS null_organization,
	SUM(CASE WHEN CODE IS NULL THEN 1 ELSE 0 END) AS null_code,
	SUM(CASE WHEN DESCRIPTION IS NULL THEN 1 ELSE 0 END) AS null_Description,
	SUM(CASE WHEN BASE_ENCOUNTER_COST IS NULL THEN 1 ELSE 0 END) AS null_BEC,
	SUM(CASE WHEN TOTAL_CLAIM_COST IS NULL THEN 1 ELSE 0 END) AS null_TCC,
	SUM(CASE WHEN PAYER_COVERAGE IS NULL THEN 1 ELSE 0 END) AS null_PCC,
	SUM(CASE WHEN REASONCODE IS NULL THEN 1 ELSE 0 END) AS null_reasonC,
	SUM(CASE WHEN REASONDESCRIPTION IS NULL THEN 1 ELSE 0 END) AS null_reasonD
FROM dbo.encounters;

-- Null check for Payers
SELECT 
    SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) AS null_payer_id,
	SUM(CASE WHEN NAME IS NULL THEN 1 ELSE 0 END) AS null_payer_name,
	SUM(CASE WHEN ADDRESS IS NULL THEN 1 ELSE 0 END) AS null_payer_address,
	SUM(CASE WHEN CITY IS NULL THEN 1 ELSE 0 END) AS null_payer_city,
	SUM(CASE WHEN STATE_HEADQUARTERED IS NULL THEN 1 ELSE 0 END) AS null_payer_state_HQ,
	SUM(CASE WHEN ZIP IS NULL THEN 1 ELSE 0 END) AS null_payer_zip,
	SUM(CASE WHEN PHONE IS NULL THEN 1 ELSE 0 END) AS null_payer_phone
FROM dbo.payers;

-- Null check for Procedures
SELECT 
    SUM(CASE WHEN START IS NULL THEN 1 ELSE 0 END) AS null_procedure_start,
    SUM(CASE WHEN STOP IS NULL THEN 1 ELSE 0 END) AS null_procedure_stop,
	SUM(CASE WHEN PATIENT IS NULL THEN 1 ELSE 0 END) AS null_patient,
	SUM(CASE WHEN ENCOUNTER IS NULL THEN 1 ELSE 0 END) AS null_encounter,
	SUM(CASE WHEN CODE IS NULL THEN 1 ELSE 0 END) AS null_code,
	SUM(CASE WHEN DESCRIPTION IS NULL THEN 1 ELSE 0 END) AS description,
	SUM(CASE WHEN BASE_COST IS NULL THEN 1 ELSE 0 END) AS null_basecode,
	SUM(CASE WHEN REASONCODE IS NULL THEN 1 ELSE 0 END) AS null_reasoncode,
	SUM(CASE WHEN REASONDESCRIPTION IS NULL THEN 1 ELSE 0 END) AS null_reasondescription
FROM dbo.procedures;
/* =====================================================
   2. REMOVE DUPLICATES
===================================================== */

-- Patients table
WITH CTE AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY id ORDER BY id) AS rn
    FROM dbo.patients
)
DELETE FROM CTE WHERE rn > 1;

WITH CTE AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY id ORDER BY id) AS rn
    FROM dbo.patients
)
DELETE FROM CTE WHERE rn > 1;

-- Encounters table
WITH CTE AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY id ORDER BY id) AS rn
    FROM dbo.encounters
)
DELETE FROM CTE WHERE rn > 1;

-- Payers table
WITH CTE AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY Payer_ID ORDER BY Payer_ID) AS rn
    FROM dbo.payers
)
DELETE FROM CTE WHERE rn > 1;
SELECT * FROM dbo.patients
-- Procedures table
WITH CTE AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY patient ORDER BY patient) AS rn
    FROM dbo.procedures
)DELETE FROM CTE WHERE rn > 1;
/* =====================================================
   3. HANDLE NULLS & MISSING VALUES
===================================================== */

-- Replace missing or blank gender with 'Unknown'
UPDATE dbo.patients
SET gender = 'Unknown'
WHERE gender IS NULL OR gender = '';
GO
ALTER TABLE dbo.patients ADD is_deceased BIT;
UPDATE dbo.patients
SET is_deceased = CASE WHEN deathdate IS NOT NULL THEN 1 ELSE 0 END;
GO

-- Replace null deathdate with dummy date '1900-01-01'
UPDATE dbo.patients
SET DEATHDATE = '1900-01-01'
WHERE DEATHDATE IS NULL;
GO

--Fixing all null values appropriately in patients table
UPDATE dbo.patients
SET 
    first      = ISNULL(NULLIF(LTRIM(RTRIM(first)), ''), 'Unknown'),
    last       = ISNULL(NULLIF(LTRIM(RTRIM(last)),  ''), 'Unknown'),
    suffix     = ISNULL(NULLIF(LTRIM(RTRIM(suffix)), ''), 'Unknown'),
    maiden     = ISNULL(NULLIF(LTRIM(RTRIM(maiden)), ''), 'Unknown'),
    marital    = ISNULL(NULLIF(LTRIM(RTRIM(marital)), ''), 'Unknown'),
    race       = ISNULL(NULLIF(LTRIM(RTRIM(race)), ''), 'Unknown'),
    ethnicity  = ISNULL(NULLIF(LTRIM(RTRIM(ethnicity)), ''), 'Unknown'),
    city       = ISNULL(NULLIF(LTRIM(RTRIM(city)), ''), 'Unknown'),
    state      = ISNULL(NULLIF(LTRIM(RTRIM(state)), ''), 'Unknown'),
    zip        = ISNULL(NULLIF(LTRIM(RTRIM(zip)), ''), '00000');
GO

-- Replace null values with unknown in the procedures table
UPDATE dbo.procedures
SET 
    REASONCODE = ISNULL(REASONCODE, '0000'),
    REASONDESCRIPTION = ISNULL(REASONDESCRIPTION, 'Unknown');
GO

-- Replace null values with unknown in the encounters table
UPDATE dbo.encounters
SET 
    REASONCODE = ISNULL(REASONCODE, '0000'),
    REASONDESCRIPTION = ISNULL(REASONDESCRIPTION, 'Unknown');

/* =====================================================
   4. STANDARDIZE FORMATS
===================================================== */

-- Standardize gender values
UPDATE dbo.patients
SET gender = CASE 
    WHEN gender IN ('M','Male','male','m') THEN 'Male'
    WHEN gender IN ('F','Female','female','f') THEN 'Female'
    ELSE 'Unknown'
END;        ---974 ROWS AFFECTED
GO
-- Standardize marital_status
UPDATE dbo.patients
SET marital = CASE
	WHEN Marital IN ('M') THEN 'Married'
	WHEN Marital IN ('S') THEN 'Single'
	ELSE 'Unknown'
END;     ---974 ROWS AFFECTED
GO
-- Standardize the name columns
UPDATE dbo.patients
SET 
    first = LTRIM(RTRIM(REPLACE(TRANSLATE(FIRST, '0123456789', '          '), ' ', ''))),
    last = LTRIM(RTRIM(REPLACE(TRANSLATE(LAST,  '0123456789', '          '), ' ', ''))),
	maiden = LTRIM(RTRIM(REPLACE(TRANSLATE(MAIDEN,  '0123456789', '          '), ' ', '')))
GO
UPDATE dbo.encounters
SET encounterclass = CASE UPPER(TRIM(ENCOUNTERCLASS))
    WHEN 'INPATIENT' THEN 'Inpatient'
    WHEN 'OUTPATIENT' THEN 'Outpatient'
    WHEN 'EMERGENCY' THEN 'Emergency'
    WHEN 'AMBULATORY' THEN 'Ambulatory'
    WHEN 'WELLNESS' THEN 'Wellness'
    WHEN 'URGENTCARE' THEN 'UrgentCare'
    ELSE 'Other' 
END;

/* =====================================================
   5. CONCATENATE THE NAME COLUMN WITH TRIM
===================================================== */
ALTER TABLE dbo.patients
ADD full_name VARCHAR(255);
GO
UPDATE dbo.patients
SET full_name = CONCAT_WS(' ', LTRIM(RTRIM([first])), LTRIM(RTRIM([last])));

SELECT * FROM dbo.patients
GO
/* =====================================================
   6. POST-CLEANING SUMMARY (ROW COUNTS)
===================================================== */

SELECT 'patients' AS table_name, COUNT(*) AS total_rows FROM dbo.patients
UNION ALL
SELECT 'encounters', COUNT(*) FROM dbo.encounters
UNION ALL
SELECT 'payers', COUNT(*) FROM dbo.payers
UNION ALL
SELECT 'procedures', COUNT(*) FROM dbo.procedures;

-- RENAME COLUMN HEADER FOR READABILITY AND UNDERSTANDING
-- PATIENTS TABLE
EXEC sp_rename 'patients.id', 'Patient_ID', 'COLUMN';
EXEC sp_rename 'patients.birthdate', 'DateOfBirth', 'COLUMN';
EXEC sp_rename 'patients.deathdate', 'DateOfDeath', 'COLUMN';
EXEC sp_rename 'patients.prefix', 'NamePrefix', 'COLUMN';
EXEC sp_rename 'patients.first', 'FirstName', 'COLUMN';
EXEC sp_rename 'patients.last', 'LastName', 'COLUMN';
EXEC sp_rename 'patients.suffix', 'NameSuffix', 'COLUMN';
EXEC sp_rename 'patients.maiden', 'MaidenName', 'COLUMN';
EXEC sp_rename 'patients.marital', 'MaritalStatus', 'COLUMN';
EXEC sp_rename 'patients.race', 'Race', 'COLUMN';
EXEC sp_rename 'patients.ethnicity', 'Ethnicity', 'COLUMN';
EXEC sp_rename 'patients.gender', 'Gender', 'COLUMN';
EXEC sp_rename 'patients.birthplace', 'BirthPlace', 'COLUMN';
EXEC sp_rename 'patients.city', 'City', 'COLUMN';
EXEC sp_rename 'patients.state', 'State', 'COLUMN';
EXEC sp_rename 'patients.county', 'County', 'COLUMN';
EXEC sp_rename 'patients.zip', 'ZIPCode', 'COLUMN';
EXEC sp_rename 'patients.lat', 'Latitude', 'COLUMN';
EXEC sp_rename 'patients.lon', 'Longitude', 'COLUMN';
EXEC sp_rename 'patients.is_deceased', 'IsDeceased', 'COLUMN';
EXEC sp_rename 'patients.full_name', 'FullName', 'COLUMN';
GO

ENCOUNTERS
EXEC sp_rename 'encounters.id', 'Encounter_ID', 'COLUMN';
EXEC sp_rename 'encounters.start', 'StartDateTime', 'COLUMN';
EXEC sp_rename 'encounters.stop', 'EndDateTime', 'COLUMN';
EXEC sp_rename 'encounters.patient', 'Patient_ID', 'COLUMN';
EXEC sp_rename 'encounters.organization', 'Organization_ID', 'COLUMN';
EXEC sp_rename 'encounters.payer', 'Payer_ID', 'COLUMN';
EXEC sp_rename 'encounters.code', 'EncounterCode', 'COLUMN';
EXEC sp_rename 'encounters.description', 'EncounterDescription', 'COLUMN';
EXEC sp_rename 'encounters.base_encounter_cost', 'BaseEncounterCost', 'COLUMN';
EXEC sp_rename 'encounters.total_claim_cost', 'TotalClaimCost', 'COLUMN';
EXEC sp_rename 'encounters.payer_coverage', 'PayerCoverage', 'COLUMN';
EXEC sp_rename 'encounters.reasoncode', 'ReasonCode', 'COLUMN';
EXEC sp_rename 'encounters.reasondescription', 'ReasonDescription', 'COLUMN';
EXEC sp_rename 'encounters.encounterclass', 'EncounterClass', 'COLUMN';
GO

PROCEDURES
EXEC sp_rename 'procedures.start', 'StartDateTime', 'COLUMN';
EXEC sp_rename 'procedures.stop', 'EndDateTime', 'COLUMN';
EXEC sp_rename 'procedures.patient', 'Patient_ID', 'COLUMN';
EXEC sp_rename 'procedures.encounter', 'Encounter_ID', 'COLUMN';
EXEC sp_rename 'procedures.code', 'ProcedureCode', 'COLUMN';
EXEC sp_rename 'procedures.description', 'ProcedureDescription', 'COLUMN';
EXEC sp_rename 'procedures.base_cost', 'BaseProcedureCost', 'COLUMN';
EXEC sp_rename 'procedures.reasoncode', 'ReasonCode', 'COLUMN';
EXEC sp_rename 'procedures.reasondescription', 'ReasonDescription', 'COLUMN';
GO

PAYERS
EXEC sp_rename 'payers.id', 'Payer_ID', 'COLUMN';
EXEC sp_rename 'payers.name', 'PayerName', 'COLUMN';
EXEC sp_rename 'payers.address', 'PayerAddress', 'COLUMN';
EXEC sp_rename 'payers.city', 'PayerCity', 'COLUMN';
EXEC sp_rename 'payers.state_headquartered', 'HQ_State', 'COLUMN';
EXEC sp_rename 'payers.zip', 'PayerZIPCode', 'COLUMN';
EXEC sp_rename 'payers.phone', 'PayerPhone', 'COLUMN';




-- BUSINESS QUESTIONS
-- PATIENTS 
KPIs
1. Total Patients
SELECT COUNT(id)
SELECT * FROM dbo.patients
2. Total deceased patient
SELECT COUNT (is_deceased)
FROM dbo.patients
WHERE is_deceased = 0
3. Patient Average Age
SELECT AVG(YEAR(BIRTHDATE))
FROM dbo.patients
4. Patients covered by insurance
SELECT E.payer, count(DISTINCT P.id) AS Total_patients
FROM dbo.encounters E
JOIN dbo.patients P
ON E.patient = P.id
GROUP BY E.Payer;
5. Out of patient pocket

Business questions
1. Patient gender distribution
SELECT GENDER, COUNT(id) AS Gender_distribution
FROM dbo.patients
GROUP BY GENDER;
2. Patient Marital status distribution
SELECT Marital, COUNT(id) AS Maritalstatus_distribution
FROM dbo.patients
GROUP BY Marital;
3. Patients Geographical Location
SELECT full_name, CITY
FROM dbo.patients
4. Patient Ethnic group distribution
SELECT Ethnicity, COUNT(id) AS Ethnicity_distribution
FROM dbo.patients
GROUP BY Ethnicity;
5. Patient Race Distribution
SELECT Race, COUNT(id) AS Race_distribution
FROM dbo.patients
GROUP BY Race;
6. Patient Age group distribution 

SELECT * FROM dbo.patients
SELECT * FROM dbo.encounters

select count (Payer_ID)
from payers
-- ENCOUNTERS
KPIs
1.
-- PROCEDURES
-- PAYERS
1. 
•	What is the average length of stay by department, diagnosis, and procedure?
•	What is the readmission rate over time and by condition?
•	What is the top cost-driving procedures and are they increasing over time?
•	How much is covered by insurance vs. patient out-of-pocket payments?
•	What is the yearly payment by the insurance company- is it increasing or decreasing?
•	Which insurers cover the highest proportion of costs?
•	Which hospital departments are under/over-utilized?
•	How many patients are coming through each encounter type (inpatient, outpatient, emergency)?
•	What are the distribution fee patterns by procedures?
•	Patient population by Age, Gender and Race?... done
•	What age, gender, or insurance groups have the highest readmission rates?
•	Are certain demographics experiencing longer stays or higher costs?
•	What is the frequency of visits per patient?


SELECT FORMAT(StartDateTime, 'yyyy') AS YEAR,
       COUNT(Encounter_ID) AS TotalEncounters
FROM encounters
GROUP BY FORMAT(StartDateTime, 'yyyy')
ORDER BY YEAR;

WITH PatientEncounters AS (
    SELECT Patient_ID, StartDateTime,
           LAG(StartDateTime) OVER (PARTITION BY Patient_ID ORDER BY StartDateTime) AS PrevVisit
    FROM encounters
)
SELECT COUNT(*) * 100.0 / COUNT(DISTINCT Patient_ID) AS ReadmissionRate
FROM PatientEncounters
WHERE DATEDIFF(DAY, PrevVisit, StartDateTime) <= 30;