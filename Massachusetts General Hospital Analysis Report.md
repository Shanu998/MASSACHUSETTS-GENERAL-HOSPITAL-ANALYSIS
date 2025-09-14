#  **Massachusetts Hospital Analysis**

##  **Table of Contents**

1. [Introduction](#introduction)
2. [Project Description](#project-description)
3. [Project Aim](#project-aim)
4. [Tools & Technologies](#-tools--technologies)
5. [About the Dataset](#about-the-dataset)
6. [Project breakdown](#project-breakdown)
7. [Importing the Dataset to SQL](#importing-the-dataset-to-SQL)
8. [Preparation of the Dataset: Cleaning and Transforming](#preparation-of-the-dataset-cleaning-and-transforming)
9. [Data Modeling in Excel](#data-modeling-in-excel)
10. [Data Analysis in Excel](#data-analysis-in-excel)
11. [Data Visualization in Excel](#data-visualization-in-excel)
12. [Insights from the Data Analysis](#insights-from-the-data-analysis)
13. [Recommendations from the Data Analysis](#recommendations-from-the-data-analysis)
14. [Conclusion](#conclusion)

---

## **Introduction**

This project focuses on analyzing operational, clinical, and financial data from Massachusetts Hospital using Structured Query Language (SQL). The objective is to discover insights into patient demographics, hospital encounters, insurance payments, procedure costs, and overall performance to drive data-driven decisions across departments and stakeholders.

## **Project Description**

Massachusetts Hospital operates in a dynamic healthcare environment where patient care, billing, insurance, and clinical performance intersect. This project uses a dataset exported from a hospital management system to visualize and analyze patient inflows, encounter types, procedure volumes, costs, and payer distributions.
The analysis covers five core areas:

* Overview
* Patients
* Encounters
* Procedures
* Insurance (Payers)


## 🎯 Project Aim

The main objective of this project is to analyze Massachusetts Hospital's performance and answer key healthcare business questions:

✅ What are the key drivers of hospital cost and revenue?

✅ What patient demographics are most common, and how do they affect care delivery?

✅ How are hospital encounters distributed throughout the year?

✅ Which procedures are most frequent and expensive?

✅ What role do insurers play in covering the cost of care?

## **Tools & Technologies**
- **SQL (Microsift SQL Server)** → data cleaning & transformation  
- **Power BI** → dashboarding & storytelling    

## **About the Dataset**

The dataset used for this project was extracted from the hospital’s information system and structured in an Excel-based reporting. It includes:

1. Patients table containing 974 rows and 20 columns:
- **Id** - Unique Identifier of the patient.
- **BIRTHDATE** - The date (YYYY-MM-DD) the patient was born.
- **DEATHDATE** - The date (YYYY-MM-DD) the patient died.
- **PREFIX** - Name prefix, such as Mr., Mrs., Dr., etc.
- **FIRST** - First name of the patient.
- **LAST** - Last or surname of the patient.
- **SUFFIX** - Name suffix, such as PhD, MD, JD, etc.
- **MAIDEN** - Maiden name of the patient.
- **MARITAL** - Patient's Marital Status; M is married, S is single.
- **RACE** - Description of the patient's primary race.
- **ETHNICITY** - Description of the patient's primary ethnicity.
- **GENDER** - Patient sexual orientation; Male, Female, Unknown.
- **BIRTHPLACE** - Name of the town where the patient was born.
- **ADDRESS** - Patient's street address.
- **CITY** - Patient's address city.
- **STATE** - Patient's address state.
- **COUNTY** - Patient's address county.
- **ZIP** - Patient's zip code.
- **LAT** - Latitude of Patient's address.
- **LON** - Longitude of Patient's address.

2. Encounters table containing 27,891 rows and 14 columns:
- **Id** - Unique Identifier of the encounter.
- **START** - The date and time the encounter started
- **STOP** - The date and time the encounter concluded
- **PATIENT** - Foreign key to the Patient.
- **ORGANIZATION** - Foreign key to the Organization.
- **PAYER** - Foreign key to the Payer.
- **ENCOUNTERCLASS** - The class of the encounter, such as ambulatory, emergency, inpatient, wellness, or urgentcare
- **CODE** - Encounter code from SNOMED-CT
- **DESCRIPTION** - Description of the type of encounter.
- **BASE_ENCOUNTER_COST** - The base cost of the encounter, not including any line item costs related to medications, immunizations, procedures, or other services.
- **TOTAL_CLAIM_COST** - The total cost of the encounter, including all line items.
- **PAYER_COVERAGE** - The amount of cost covered by the Payer.
- **REASONCODE** - Diagnosis code from SNOMED-CT.
- **REASONDESCRIPTION** - Description of the reason code.
  
3. Procedures table containing 47,701 rows and 9 columns:
- **START** - The date and time the procedure was performed.
- **STOP** - The date and time the procedure was completed, if applicable.
- **PATIENT** - Foreign key to the Patient.
- **ENCOUNTER** - Foreign key to the Encounter where the procedure was performed.
- **CODE** - Procedure code from SNOMED-CT
- **DESCRIPTION** - Description of the procedure.
- **BASE_COST** - The line item cost of the procedure.
- **REASONCODE** - Diagnosis code from SNOMED-CT specifying why this procedure was performed.
- **REASONDESCRIPTION** - Description of the reason code.


4. Payers table containing 10 rows and 7 columns:
- **Id** - Unique Identifier of the payer.
- **NAME** - Name of the Payer.
- **ADDRESS** - Payer's street address.
- **CITY** - Street address city.
- **STATE_HEADQUARTERED** - Street address state abbreviation.
- **ZIP** - Street address zip or postal code.
- **PHONE** - Payer's phone number.

Data Types:

* Text (Names, Categories)
* Numeric (Counts, Costs, Percentages)
* Date (Admission Dates, Report Date)
* Categorical (Gender, Ethnicity, Encounter Type, Insurance)

## **Project breakdown** 
1. **Understanding the Project brief**  
   - Define Problem Statement
   - Identify key stakeholders  
   - Drafted healthcare business questions
  
2. **Data Cleaning Process**
   - Imported raw CSVs into SQL Server for data cleaning, standardization and validation

3. **Data Analysis**  
   - SQL queries were used in answering the business questions 

4. **Data Visualization**  
   - Built Power BI dashboards  
   - Designed KPIs with conditional formatting  
   - Data storytelling structure
  
5. **Imsights and Recommendations**
   - Valid insights and actionable recommendation from the visualisation process

## **Importing the Dataset to SQL**

The dataset was imported as a CSV file into Microsoft SQL Server. A duplicate copy was created before commencement of data cleaning process.

## **Preparation of the Dataset: Cleaning and Transforming**

- **Creation of Database: Massachusettts_GH**
- **Assigned Correct Data Types**
- **Creation of Backup files**
- **Renamed column headers to enhance readability and understanding**
- **Identification of Null values**
- **Identified and Removed Duplicates**   
- **Replaced Null values with Unknown and 0 appropriately**  
- **Creation of a new column within the patient table 'is_deceased' to flag either patient is alive or dead using 1 or 0** 
- **Creation of a new column 'Fullname' - Concenate First and Last name to Fullname**
- **Standardized Gender, Marital status and encounter_class columns**
- **Standardized Name column by removing the numerical values embedded in the text**




