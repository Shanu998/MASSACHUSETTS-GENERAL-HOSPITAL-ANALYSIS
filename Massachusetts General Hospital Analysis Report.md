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
9. [Data Modeling in Power BI](#data-modeling-in-powerbi)
10. [Data Analysis in SQL](#data-analysis-in-SQL)
11. [Data Visualization in Power BI](#data-visualization-in-powerbi)
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
- [Data Cleaning]([Data cleaning file.png](https://github.com/Shanu998/MASSACHUSETTS-GENERAL-HOSPITAL-ANALYSIS/blob/main/massachusetts%20data%20model.png))

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

## **Data Modeling in Power BI**
- [Data Modeling]([Massachusetts data model.png](https://github.com/Shanu998/MASSACHUSETTS-GENERAL-HOSPITAL-ANALYSIS/blob/main/massachusetts%20data%20model.png))
- **One to many relationship was created between the patients and procedures table: Patient_ID**
- **One to many relationship was created between the patients and calendar table: Date**
- **One to many relationship was created between the procedures and calendar table: Date**
- **One to many relationship was created between the procedures and encounters table: Encounter_ID**
- **One to many relationship was created between the patients and encounters table: Patient_ID**
- **One to many relationship was created between the encounters and payers table: Payer_ID**

## **Data Analysis in SQL**

Key performance indicators (KPIs) analyzed:

Key metrics analyzed across dashboards:

- **Total patients**
- **Total encounters**
- **Total bills**
- **Total Insurance companies**
- **Readmission rates**
- **Patient demographics (age, gender, marital status, ethnicity)**
- **Insurance vs. out-of-pocket payments**
- **Average billing and procedure time**
- **Admiited patients**

## **Data Visualization in Power BI**
Five dashboards were created: an **Overview Dashboard** , **Patients Dashboard** , **Encoounters Dashboard** , **Procedures Dashboard** and **Payers Dashboard**.

### **Overview Dashboard**
- **KPI Cards**: Total patient, Total encounter, Total bill, Total insurance company, 30 days Readmission rates.
- **Stacked Bar Chart**: Which procedures contribute most to total costs?
- **Line Chart**: Monthly trend of patients inflow?
- **Pie Chart**: Distribution of encounters by type (Inpatient, Outpatient, Emergency, etc.)?
- **Stacked Column Chart**: Which insurance companies cover the largest share of claims?
- **Slicer**: Year filter for dynamic analysis.

### **Patient Dashboard**
- **KPI Cards**: Total patient, Deceased patients, Average patient age, Insurance Covered, Out of patient pocket.
- **Pie Chart**: What is the gender distribution of patients?
- **Funnel Chart**: What are the dominant marital status groups?
- **Clustered Bar Chart**: How does age group distribution look?
- **Clustered Column Chart**: How are patients distributed by ethnicity and race?

### **Encounters Dashboard**
- **KPI Cards**: Total encounter, Total bill, Admitted encouters, Average minute spent per patient.
- **Line Chart**: What are the trends in monthly encounters?
- **Stacked Bar Chart**: Who are the top 10 patients by encounter frequency?
- **Clustered Bar Chart**: What is the average length of stay by diagnosis?
- **Clustered Column Chart**: What is the admission status breakdown (Inpatient, Outpatient, etc.)?
- **Slicer**: Year filter for dynamic analysis.
  
### **Procedures Dashboard**
- **KPI Cards**: Total procedures, Total procedures bill, Average procedure bill, Average minute spent per procedure.
- **Line Chart**: How do procedure costs trend by month?
- **Line Chart**: Which procedures contribute most to costs over time?
- **Clustered Bar Chart**: What are the most frequent procedures?
- **Pie Chart**: What are the most common procedure reasons?
- **Slicer**: Year filter for dynamic analysis.
  
### **Payers Dashboard**
- **KPI Cards**: Total insurance company, Total bills, Insurance covered, Out of pocket patients. 
- **Line Chart**: How have yearly insurance payments trended?
- **Stacked Bar Chart**: Which insurers cover the highest claims?
- **Stacked Column Chart**: How much coverage do different insurance firms provide monthly?
- **Pie Chart**: What is the distribution of encounters by insurance companies?
- **Slicer**: Month filter for dynamic analysis.
- ### **View Dashboards**
- [Overview Dashboard]([Overview visualisation.png](https://github.com/Shanu998/MASSACHUSETTS-GENERAL-HOSPITAL-ANALYSIS/blob/main/MASSACHUSETTS%20VISUALISATION%20final-1.png))
- [Patients Dashboard]([Patients visualisation.png](https://github.com/Shanu998/MASSACHUSETTS-GENERAL-HOSPITAL-ANALYSIS/blob/main/MASSACHUSETTS%20VISUALISATION%20final-2.png))
- [Encounters Dashboard]([Encounters visualisation.png](https://github.com/Shanu998/MASSACHUSETTS-GENERAL-HOSPITAL-ANALYSIS/blob/main/MASSACHUSETTS%20VISUALISATION%20final-3.png))
- [Procedures Dashboard]([Procedures visualisation.png](https://github.com/Shanu998/MASSACHUSETTS-GENERAL-HOSPITAL-ANALYSIS/blob/main/MASSACHUSETTS%20VISUALISATION%20final-4.png))
- [Payers Dashboard]([Payers visualisation.png](https://github.com/Shanu998/MASSACHUSETTS-GENERAL-HOSPITAL-ANALYSIS/blob/main/MASSACHUSETTS%20VISUALISATION%20final-5.png))
  
## **Insights from the Data Analysis**

- **Unusually High Readmission Rate*: 7,905.54% – Likely a reporting or formula error, or systemic issue in patient discharge/follow-up.
- **Out-of-Pocket Dominance**: 622 patients (\~64%) pay out-of-pocket, indicating either limited insurance access or coverage denial.
- **Older Patient Base**: Average age is 73; majority are 76+, requiring complex and long-term care.
- **Top Cost Drivers**: Electrical cardioversion, chemotherapy, colonoscopy—indicating high-acuity treatments.
- **Insurance Coverage Gap**: 31.58% of patients have no insurance.
- **Peak Service Months**: January, February, November show the highest encounter volumes.
- **Top Procedures**: Oxygen administration, intubation, imaging tests—emergency & critical care dominate.
- **Frequent Flyer**: Small number of patients with repeated visits may represent chronic condition burdens or poor outpatient follow-up.


## **Recommendations from the Data Analysis**

### 👨‍⚕ Medical Directors

* Audit the readmission metric immediately for accuracy.
* Implement care coordination and discharge planning for high-risk patients to reduce repeat visits.

### 🧑‍⚕ Clinical Staff (Doctors, Nurses, Lab Technicians, Pharmacists)

* Prioritize elderly care plans and age-specific medication management.
* Focus on early intervention for atrial fibrillation, cancer, and chronic respiratory illnesses.

### 🏥 Department Heads

* Adjust staffing in January, February, and November to meet peak encounter demand.
* Improve coordination for frequently performed procedures through workflow optimization.

### 📊 Healthcare Analysts

* Perform root cause analysis for high-cost procedures.
* Analyze payer performance and claim denials to identify reimbursement inefficiencies.

### 🧑‍💼 Administrative Officers

* Launch patient financial counseling to support uninsured and out-of-pocket patients.
* Engage with insurance companies to renegotiate terms for top-billed procedures.

### 🤝 Insurance Partners

* Promote insurance literacy and simplify enrollment to reduce the uninsured population.
* Explore value-based care agreements to align billing with outcomes.

### 🧪 Public Health Workers

* Initiate outreach programs for minorities with limited healthcare access.
* Promote preventive screening for high-risk elderly patients.

## **Conclusion**

This project demonstrates the power of hospital analytics in uncovering patterns that affect patient care, hospital revenue, and operational performance. With targeted interventions, Massachusetts Hospital can improve patient outcomes, optimize financial performance, and reduce administrative inefficiencies.



