/*
====================================================================
DDL Script: Create Silver Tables
====================================================================

Script Purpose:
    This script creates the tables in the 'silver' schema
    to store cleaned, transformed, and standardized data
    from the Bronze layer.

    Existing Silver tables are dropped if they already exist.

    The Silver layer is responsible for preparing source data
    for further transformation and integration into the Gold layer.

    Source:
        - Bronze CRM tables
        - Bronze ERP tables

Tables:
        CRM:
            - crm_cust_info
            - crm_prd_info
            - crm_sales_details

        ERP:
            - erp_cust_az12
            - erp_loc_a101
            - erp_px_cat_g1v2

Note:
    The table structures are initially based on the Bronze layer.
    Data cleaning, standardization, validation, and transformation
    will be handled during the Silver layer loading process.

====================================================================
*/

IF OBJECT_ID ('silver.crm_cust_info' , 'U') IS NOT NULL 
DROP TABLE silver.crm_cust_info

CREATE TABLE silver.crm_cust_info (
cst_id INT,
cst_key VARCHAR(50),
cst_firstname NVARCHAR(50),
cst_lastname NVARCHAR(50),
cst_marital_status NVARCHAR(50),
cst_gndr NVARCHAR(50),
cst_create_date DATE 

);


IF OBJECT_ID ('silver.crm_prd_info' , 'U') IS NOT NULL 
DROP TABLE silver.crm_prd_info

CREATE TABLE silver.crm_prd_info(
prd_id INT ,
prd_key VARCHAR(50),
prd_nm NVARCHAR(50),
prd_cost INT,
prd_line VARCHAR(50),
prd_start_dt DATE,
prd_end_dt DATE
);


IF OBJECT_ID ('silver.crm_sales_details' , 'U') IS NOT NULL 
DROP TABLE silver.crm_sales_details

CREATE TABLE silver.crm_sales_details (
sls_ord_num NVARCHAR(50),
sls_prd_key NVARCHAR(50),
sls_cust_id INT,
sls_order_dt INT,
sls_ship_dt INT,
sls_due_dt INT,
sls_sales INT,
sls_quantity INT,
sls_price INT
) ;



IF OBJECT_ID ('silver.erp_cust_az12' , 'U') IS NOT NULL 
DROP TABLE silver.erp_cust_az12

CREATE TABLE silver.erp_cust_az12(
CID NVARCHAR(50),
BDAT DATE,
GEN NVARCHAR(50)
);


IF OBJECT_ID ('silver.erp_loc_a101' , 'U') IS NOT NULL 
DROP TABLE silver.erp_loc_a101

CREATE TABLE silver.erp_loc_a101(
CID NVARCHAR(50),
CNTRY NVARCHAR(50)
);



IF OBJECT_ID ('silver.erp_px_cat_g1v2' , 'U') IS NOT NULL 
DROP TABLE silver.erp_px_cat_g1v2

CREATE TABLE silver.erp_px_cat_g1v2(
ID NVARCHAR(50),
CAT NVARCHAR(50),
SUBCAT NVARCHAR(50),
MAINTENANCE NVARCHAR(50)
);
