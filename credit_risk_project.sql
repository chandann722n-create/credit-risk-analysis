CREATE DATABASE CREDIT_RISK_DB;

USE CREDIT_RISK_DB;

CREATE TABLE LOAN_DATA(
person_age INT,
person_income INT,
person_home_ownership VARCHAR(20),
person_emp_length INT,
loan_intent VARCHAR(50),
loan_grade CHAR(1),
loan_amnt INT,
loan_int_rate FLOAT,
loan_status INT,
loan_percent_income FLOAT,
cb_person_default_on_file CHAR(1),
cb_person_cred_hist_length INT
);

drop table LOAN_DATA


CREATE TABLE loan_data (
    person_age INT NULL,
    person_income INT NULL,
    person_home_ownership VARCHAR(20) NULL,
    person_emp_length INT NULL,
    loan_intent VARCHAR(50) NULL,
    loan_grade CHAR(1) NULL,
    loan_amnt INT NULL,
    loan_int_rate FLOAT NULL,
    loan_status INT NULL,
    loan_percent_income FLOAT NULL,
    cb_person_default_on_file CHAR(1) NULL,
    cb_person_cred_hist_length INT NULL
);

drop table credit_risk

drop table loan_data

CREATE TABLE credit_risk (
    person_age INT NULL,
    person_income INT NULL,
    person_home_ownership VARCHAR(20) NULL,
    person_emp_length INT NULL,
    loan_intent VARCHAR(50) NULL,
    loan_grade CHAR(1) NULL,
    loan_amnt INT NULL,
    loan_int_rate FLOAT NULL,
    loan_status INT NULL,
    loan_percent_income FLOAT NULL,
    cb_person_default_on_file CHAR(1) NULL,
    cb_person_cred_hist_length INT NULL
);

drop table credit_risk

drop table loan_data

CREATE TABLE credit_risk (
    person_age INT NULL,
    person_income INT NULL,
    person_home_ownership VARCHAR(20) NULL,
    person_emp_length INT NULL,
    loan_intent VARCHAR(50) NULL,
    loan_grade VARCHAR(2) NULL,
    loan_amnt INT NULL,
    loan_int_rate FLOAT NULL,
    loan_status INT NULL,
    loan_percent_income FLOAT NULL,
    cb_person_default_on_file VARCHAR(2) NULL,
    cb_person_cred_hist_length INT NULL
);

SELECT * INTO CREDIT_RISK1 
FROM CREDIT_RISK_DATASET_V2;

SELECT COUNT(*) FROM CREDIT_RISK1;

SELECT TOP 10 * FROM CREDIT_RISK1;

SELECT
COUNT(*) AS TOTAL_CUSTOMERS,
SUM(CAST(LOAN_STATUS AS INT)) AS TOTAL_DEFAULTS,
CAST(SUM(CAST(LOAN_STATUS AS INT)*1.0/COUNT(*) AS DECIMAL(5,2)) AS DEFAULT_RATE
FROM CREDIT_RISK1

SELECT 
    COUNT(*) AS Total_Customers,
    SUM(CAST(loan_status AS INT)) AS Total_Defaults,
    CAST(SUM(CAST(loan_status AS INT)) * 1.0 / COUNT(*) AS DECIMAL(5,2)) AS Default_Rate
FROM credit_risk1;


SELECT
LOAN_GRADE,
COUNT(*) AS TOTAL_CUSTOMERS,
SUM(CAST(LOAN_STATUS AS INT)) AS TOTAL_DEFAULTS,
CAST(SUM(CAST(LOAN_STATUS AS INT))*1.0/COUNT(*) AS DECIMAL(5,2))AS DEFAULT_RATE
FROM CREDIT_RISK1
GROUP BY LOAN_GRADE
ORDER BY DEFAULT_RATE DESC;

SELECT
LOAN_INTENT,
COUNT(*) AS TOTAL_CUSTOMERS,
SUM(CAST(LOAN_STATUS AS INT)) AS TOTAL_DEFAULTS,
CAST(SUM(CAST(LOAN_STATUS AS INT))*1.0/COUNT(*) AS DECIMAL(5,2))AS DEFAULT_RATE
FROM CREDIT_RISK1
GROUP BY LOAN_INTENT
ORDER BY DEFAULT_RATE DESC;


SELECT 
    CASE 
        WHEN loan_percent_income < 0.2 THEN 'Low DTI'
        WHEN loan_percent_income BETWEEN 0.2 AND 0.35 THEN 'Medium DTI'
        ELSE 'High DTI'
    END AS dti_bucket,
    COUNT(*) AS total_customers,
    SUM(CAST(loan_status AS INT)) AS total_defaults,
    CAST(SUM(CAST(loan_status AS INT)) * 1.0 / COUNT(*) AS DECIMAL(5,2)) AS default_rate
FROM CREDIT_RISK1
GROUP BY     CASE 
        WHEN loan_percent_income < 0.2 THEN 'Low DTI'
        WHEN loan_percent_income BETWEEN 0.2 AND 0.35 THEN 'Medium DTI'
        ELSE 'High DTI'
    END
ORDER BY default_rate DESC;

SELECT 
    'High Risk (D-G)' AS segment,
    SUM(CASE WHEN loan_grade IN ('D','E','F','G') THEN 1 ELSE 0 END) AS total_customers,
    SUM(CASE WHEN loan_grade IN ('D','E','F','G') THEN CAST(loan_status AS INT) ELSE 0 END) AS total_defaults
FROM CREDIT_RISK1;