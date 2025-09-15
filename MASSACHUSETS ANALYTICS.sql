USE MASSACHUSETTS_GH;
GO
/* =====================================================
   OVERVIEW PAGE
===================================================== */

--KPIS
-- 1. Total Patients
SELECT COUNT(Patient_ID) AS TotalPatients
FROM patients;

-- 2. Total Encounters
SELECT COUNT(*) AS TotalEncounters
FROM encounters;

-- 3. Total Bills (Revenue)
SELECT SUM(TotalClaimCost) AS TotalBills
FROM encounters;

-- 4. % Insured Patients
SELECT 
    (CAST(COUNT(DISTINCT CASE WHEN Payer_ID IS NOT NULL THEN Patient_ID END) AS FLOAT) 
     / COUNT(DISTINCT Patient_ID)) * 100 AS PercentInsured
FROM encounters;

-- 5. Readmission Rate (within 30 days)
WITH PatientEncounters AS (
    SELECT Patient_ID, StartDateTime,
           LAG(StartDateTime) OVER (PARTITION BY Patient_ID ORDER BY StartDateTime) AS PrevVisit
    FROM encounters
)
SELECT COUNT(*) * 100.0 / COUNT(DISTINCT Patient_ID) AS ReadmissionRate
FROM PatientEncounters
WHERE DATEDIFF(DAY, PrevVisit, StartDateTime) <= 30;

-- Business Questions
-- How is patient inflow changing monthly?
SELECT FORMAT(StartDateTime, 'yyyy-MM') AS Month,
       COUNT(Encounter_ID) AS TotalEncounters
FROM encounters
GROUP BY FORMAT(StartDateTime, 'yyyy-MM')
ORDER BY Month;

-- What is the distribution of encounters by type (Inpatient, Outpatient, Emergency, etc.)?
SELECT EncounterClass, COUNT(*) AS TotalEncounters
FROM encounters
GROUP BY EncounterClass
ORDER BY TotalEncounters DESC;

-- Which procedures contribute most to total costs?
SELECT TOP 10 ProcedureDescription, SUM(BaseProcedureCost) AS TotalProcedureCost
FROM procedures
GROUP BY ProcedureDescription
ORDER BY TotalProcedureCost DESC;

-- Which insurance companies cover the largest share of claims?
SELECT P.PayerName,
       SUM(E.PayerCoverage) AS InsuranceCoverage,
       SUM(E.TotalClaimCost - E.PayerCoverage) AS PatientOutOfPocket
FROM encounters E
JOIN payers P ON E.Payer_ID = P.Payer_ID
GROUP BY P.PayerName
ORDER BY InsuranceCoverage DESC;
GO

/* =====================================================
   PATIENTS PAGE
===================================================== */

-- KPIs
-- 1. Total Patients
SELECT COUNT(Patient_ID) AS TotalPatients
FROM patients;

-- 2. Total deceased patients
SELECT COUNT(*) AS DeceasedPatients
FROM patients
WHERE IsDeceased = 1;

-- 3. Patient Average Age 
SELECT AVG(DATEDIFF(YEAR, DateOfBirth, GETDATE())) AS AvgPatientAge
FROM patients;

-- 4. Patients covered by insurance
SELECT E.Payer_ID, COUNT(DISTINCT P.Patient_ID) AS TotalPatients
FROM encounters E
JOIN patients P ON E.Patient_ID = P.Patient_ID
GROUP BY E.Payer_ID;

-- 5. Out-of-pocket patients
SELECT COUNT(DISTINCT P.Patient_ID) AS OutOfPocketPatients
FROM encounters E
JOIN patients P ON E.Patient_ID = P.Patient_ID
WHERE E.PayerCoverage = 0;

-- Business Questions
-- Gender distribution
SELECT Gender, COUNT(Patient_ID) AS GenderDistribution
FROM patients
GROUP BY Gender;

-- Marital status distribution
SELECT MaritalStatus, COUNT(Patient_ID) AS MaritalStatusDistribution
FROM patients
GROUP BY MaritalStatus;

-- Patient Ethnic group distribution
SELECT Ethnicity, COUNT(Patient_ID) AS EthnicityDistribution
FROM patients
GROUP BY Ethnicity;

-- Patient Race distribution
SELECT Race, COUNT(Patient_ID) AS RaceDistribution
FROM patients
GROUP BY Race;

-- Patient Age Group Distribution
SELECT 
    CASE 
        WHEN DATEDIFF(YEAR, DateOfBirth, GETDATE()) < 18 THEN '<18'
        WHEN DATEDIFF(YEAR, DateOfBirth, GETDATE()) BETWEEN 18 AND 35 THEN '18-35'
        WHEN DATEDIFF(YEAR, DateOfBirth, GETDATE()) BETWEEN 36 AND 55 THEN '36-55'
        WHEN DATEDIFF(YEAR, DateOfBirth, GETDATE()) BETWEEN 56 AND 75 THEN '56-75'
        ELSE '76+'
    END AS AgeGroup,
    COUNT(*) AS PatientCount
FROM patients
GROUP BY 
    CASE 
        WHEN DATEDIFF(YEAR, DateOfBirth, GETDATE()) < 18 THEN '<18'
        WHEN DATEDIFF(YEAR, DateOfBirth, GETDATE()) BETWEEN 18 AND 35 THEN '18-35'
        WHEN DATEDIFF(YEAR, DateOfBirth, GETDATE()) BETWEEN 36 AND 55 THEN '36-55'
        WHEN DATEDIFF(YEAR, DateOfBirth, GETDATE()) BETWEEN 56 AND 75 THEN '56-75'
        ELSE '76+'
    END
ORDER BY AgeGroup;

/* =====================================================
   ENCOUNTERS PAGE
===================================================== */

-- KPIs
-- Total Bills
SELECT SUM(TotalClaimCost) AS TotalBills FROM encounters;

-- Total Encounters
SELECT COUNT(*) AS TotalEncounters FROM encounters;

-- Admitted Encounters (Inpatient)
SELECT COUNT(*) AS AdmittedEncounters
FROM encounters
WHERE EncounterClass = 'Inpatient';

-- Minutes spent in encounters
SELECT SUM(DATEDIFF(MINUTE, StartDateTime, EndDateTime)) AS TotalMinutesSpent
FROM encounters;

-- Average minutes spent per encounter
SELECT AVG(DATEDIFF(MINUTE, StartDateTime, EndDateTime)) AS AvgMinutesSpent
FROM encounters;

-- Analytical Questions
-- Encounters by Month
SELECT FORMAT(StartDateTime, 'yyyy-MM') AS Month,
       COUNT(Encounter_ID) AS TotalEncounters
FROM encounters
GROUP BY FORMAT(StartDateTime, 'yyyy-MM')
ORDER BY Month;

-- Encounters by Admission Status
SELECT EncounterClass, COUNT(*) AS TotalEncounters
FROM encounters
GROUP BY EncounterClass;

-- Top 10 Encounters by Patients
SELECT TOP 10 Patient_ID, COUNT(*) AS TotalEncounters
FROM encounters
GROUP BY Patient_ID
ORDER BY TotalEncounters DESC;

-- Average Length of Stay by Diagnosis
SELECT ReasonDescription,
       AVG(DATEDIFF(MINUTE, StartDateTime, EndDateTime)) AS AvgStayMinutes
FROM encounters
GROUP BY ReasonDescription
ORDER BY AvgStayMinutes DESC;

-- Readmission Rate (within 30 days)
WITH PatientEncounters AS (
    SELECT Patient_ID, StartDateTime,
           LAG(StartDateTime) OVER (PARTITION BY Patient_ID ORDER BY StartDateTime) AS PrevVisit
    FROM encounters
)
SELECT COUNT(*) * 100.0 / COUNT(DISTINCT Patient_ID) AS ReadmissionRate
FROM PatientEncounters
WHERE DATEDIFF(DAY, PrevVisit, StartDateTime) <= 30;

-- Frequency of Visits per Patient
SELECT VisitCount, COUNT(*) AS PatientCount
FROM (
    SELECT Patient_ID, COUNT(*) AS VisitCount
    FROM encounters
    GROUP BY Patient_ID
) t
GROUP BY VisitCount
ORDER BY VisitCount;

/* =====================================================
   PROCEDURES PAGE
===================================================== */

-- KPIs
-- Total Procedures
SELECT COUNT(*) AS TotalProcedures FROM procedures;

-- Total Base Procedure Bill
SELECT SUM(BaseProcedureCost) AS TotalProcedureBill FROM procedures;

-- Average Bill per Procedure
SELECT AVG(BaseProcedureCost) AS AvgProcedureBill FROM procedures;

-- Average Procedure Minutes
SELECT AVG(DATEDIFF(MINUTE, StartDateTime, EndDateTime)) AS AvgProcedureMinutes
FROM procedures;

-- Analytical Questions
-- Base Procedure Fee by Month
SELECT FORMAT(StartDateTime, 'yyyy-MM') AS Month, 
       SUM(BaseProcedureCost) AS TotalProcedureCost
FROM procedures
GROUP BY FORMAT(StartDateTime, 'yyyy-MM')
ORDER BY Month;

-- Top 10 Procedures by Type
SELECT TOP 10 ProcedureDescription, COUNT(*) AS ProcedureCount
FROM procedures
GROUP BY ProcedureDescription
ORDER BY ProcedureCount DESC;

-- Procedures by Reason
SELECT ReasonDescription, COUNT(*) AS ProcedureCount
FROM procedures
GROUP BY ReasonDescription
ORDER BY ProcedureCount DESC;

-- Top Cost-Driving Procedures Over Time
SELECT FORMAT(StartDateTime, 'yyyy') AS Year,
       ProcedureDescription,
       SUM(BaseProcedureCost) AS TotalCost
FROM procedures
GROUP BY FORMAT(StartDateTime, 'yyyy'), ProcedureDescription
ORDER BY TotalCost DESC;

/* =====================================================
   PAYERS PAGE
===================================================== */

-- KPIs
-- Number of Insurance Companies
SELECT COUNT(DISTINCT PayerName) AS TotalInsuranceCompanies FROM payers;

-- Total Bills
SELECT SUM(TotalClaimCost) AS TotalBills FROM encounters;

-- Insurance Covered
SELECT SUM(PayerCoverage) AS InsuranceCovered FROM encounters;

-- Patient Out-of-Pocket
SELECT SUM(TotalClaimCost - PayerCoverage) AS PatientOutOfPocket FROM encounters;

-- % of Patients with No Insurance
SELECT 
    (CAST(SUM(CASE WHEN Payer_ID IS NULL THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*)) * 100 AS PercentUninsured
FROM encounters;

-- Analytical Questions
-- Payers Coverage by Month
SELECT FORMAT(E.StartDateTime, 'yyyy-MM') AS Month,
       SUM(E.PayerCoverage) AS TotalCoverage
FROM encounters E
GROUP BY FORMAT(E.StartDateTime, 'yyyy-MM')
ORDER BY Month;

-- Encounters by Insurance Companies
SELECT P.PayerName, COUNT(E.Encounter_ID) AS TotalEncounters
FROM encounters E
JOIN payers P ON E.Payer_ID = P.Payer_ID
GROUP BY P.PayerName
ORDER BY TotalEncounters DESC;

-- Coverage and Claims by Insurance Companies
SELECT P.PayerName, 
       SUM(E.TotalClaimCost) AS TotalClaims,
       SUM(E.PayerCoverage) AS InsuranceCoverage,
       SUM(E.TotalClaimCost - E.PayerCoverage) AS PatientOutOfPocket
FROM encounters E
JOIN payers P ON E.Payer_ID = P.Payer_ID
GROUP BY P.PayerName
ORDER BY TotalClaims DESC;

-- Yearly Insurance Payments Trend
SELECT P.PayerName, FORMAT(E.StartDateTime, 'yyyy') AS Year,
       SUM(E.PayerCoverage) AS TotalInsurancePayment
FROM encounters E
JOIN payers P ON E.Payer_ID = P.Payer_ID
GROUP BY P.PayerName, FORMAT(E.StartDateTime, 'yyyy')
ORDER BY Year, TotalInsurancePayment DESC;


SELECT * FROM patients