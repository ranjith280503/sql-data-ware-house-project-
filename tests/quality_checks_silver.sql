/*
======================================================================================
Quality Checks
=======================================================================================
Script Purpose:
    This script performs various quality checks for data consistency, accuracy,
    and standardization across the 'silver' schema. It includes checks for:
    - Null or duplicate primary keys.
    - Unwanted spaces in string fields.
    - Data standardization and consistency.
    - Invalid date ranges and orders .
    - Data consistency between related fields.

Usage Notes :
- Run these checks after data loading Silver Layer.
- Investigate and resolve any discrepancies found during the checks.
===========================================================================================
*/
--=========================================================================================
-- Checking silver.
--=========================================================================================
-- Check for NULL s or Duplicates in Primary Key
--Expectation: No Results
SELECT
cst_id,
  count(*)
FROM silver. crm_cust_info
GROUP BY cst_id
HAVING count(*)> 1 OR cst_id IS NULL;

-- Check for Unwanted Spaces
--Expectation: No Results

SELECT
cst_key
FROM silver.crm_cust_info
WHERE cst_key!=trim(cst_key)
  
--Data Standardization & Consistency

SELECT DISTINCT
cst_marital_status
FROM silver.cust_info;
--============================================================
-- Checking 'Silver.crm_prd_info'
--============================================================
--Check for NULLS or Duplicates in Primary Key
--Expectation: No Results
SELECT
prd_id,
COUNT (*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING count(*)> 1 OR prd_id IS NULL;

--Check for Unwanted Spaces
--Expectation: NO Results
SELECT
prd_nm
FROM  silver.crm_prd_info
WHERE prd_nm !=trim(prd_nm);

-- Check for NULL s or Negative Values in Cost
- -Expectation: NO Results
SELECT
prd_cost
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

--Data Standardization & Consistency
SELECT DISTINCT
prd_line
FROM silver.crm_prd_info;


-- Check for Invalid Date Orders (Start Date > End Date)
-- Expectation: No Results
SELECT *
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt;
--==========================================================================================
-- Checking 'silver.crm_sales_details'
--==========================================================================================
--Check for Invalid Dates
--Expectation: No Invalid Dates
SELECT
NULLIF(sls_due_dt, 0) AS sls_due_dt
FROM bronze.crm_sales_details
WHERE sls_due_dt <=0
OR LEN(sls_due_dt)!=8
OR sls_due_dt > 20500101
OR sls_due_dt < 19000101;

--Check for Invalid Date Orders (Order Date > Shipping/Due Dates)
--Expectation: NO Results
SELECT *
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt
OR sls_order_dt > sls_due_dt;

-- Check Data Consistency: Sales = Quantity * Price
-- Expectation: No Results
SELECT DISTINCT
sls_sales,
sls_quantity,
sls_price
FROM silver.crm_sales_details
WHERE sls_sales!=sls_quantity*sls_price
OR  sls_sales is null 
or sls_quantity is null 
or sls_price is null
OR  sls_sales <=0
or sls_quantity <=0 
or sls_price  <=0
order by sls_sales,sls_quantity,sls_price 
  
--==============================================================
-- Checking silver.erp_cust_az12
--===============================================================
-- Identify Out-of-Range Dates
--Expectation: Birthdates between 1924-01-01 and Today
SELECT DISTINCT
bdate
FROM silver.erp_cust_az12
WHERE bdate < '1924-01-01'
OR bdate > GETDATE();
--Data Standardization & Consistency
SELECT DISTINCT
gen
FROM silver.erp_cust_az12;
--========================================================================================
-- Checking silver.erp_loc_a101
--========================================================================================
--Data Standardization & Consistency
SELECT DISTINCT
cntry
FROM  silver.erp_loc_a101
ORDER BY cntry;

--================================================================================
--Checking silver.erp_px_cat_g1v2
--==============================================================================
--Check for Unwanted Spaces
--Expectation: No Results
SELECT
  *
FROM silver.erp_px_cat_g1v2
WHERE cat != TRIM(cat)
OR subcat != TRIM(subcat)
OR maintenance != TRIM(maintenance);
--Data Standardization & Consistency
SELECT DISTINCT
maintenance
FROM silver.erp_px_cat_g1v2;























