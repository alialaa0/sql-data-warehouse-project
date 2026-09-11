/*
====================================================================
Stored Procedure: Load Bronze Layer
====================================================================

Script Purpose:
    This stored procedure loads raw data from CRM and ERP source
    CSV files into the corresponding tables in the 'bronze' schema.

    The procedure:
        - Truncates existing Bronze tables before loading.
        - Loads source CSV files using BULK INSERT.
        - Measures and prints the loading duration for each table.
        - Tracks the total Bronze layer loading duration.
        - Handles errors using TRY...CATCH.
        - Displays error message, number, and state when a failure occurs.

Source Systems:
    - CRM
        * Customer Information
        * Product Information
        * Sales Details

    - ERP
        * Customer Information
        * Customer Location
        * Product Category Information

ETL Monitoring:
    Start and end timestamps are captured to calculate:
        - Individual table load duration.
        - Total Bronze layer batch duration.

Error Handling:
    TRY...CATCH is used to capture and display errors that occur
    during the Bronze layer loading process.

====================================================================
*/

EXEC bronze.load_bronze 

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN 

BEGIN TRY 

DECLARE @start_time DATETIME , @end_time DATETIME  , @start_batch_time DATETIME , @end_batch_time DATETIME 
-------------------------------------------------------------
--                   FILE 1 
-------------------------------------------------------------
PRINT '=============================================='
PRINT 'loading Bronze Layer '
PRINT '==============================================' 

PRINT '----------------------------------------------'
PRINT 'Loading CRM Files ' 
PRINT '----------------------------------------------'


SET @start_batch_time = GETDATE()
SET @start_time = GETDATE()

PRINT '>> Truncate Table bronze.crm_cust_info ' 
TRUNCATE TABLE bronze.crm_cust_info

PRINT '>> INSERT Data Into >> bronze.crm_cust_info table '
BULK INSERT bronze.crm_cust_info 
FROM 'A:\Data_Engineer\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
WITH (
FIRSTROW = 2 , 
FIELDTERMINATOR = ',' ,
TABLOCK ) 

SET @end_time = GETDATE() 
PRINT '>> Loadin Duration : ' + CAST( DATEDIFF(second , @start_time , @end_time ) AS NVARCHAR ) 
PRINT'---------------------------------------------------------------------------'

--SELECT * FROM bronze.crm_cust_info 
--SELECT count(*) FROM bronze.crm_cust_info 

-------------------------------------------------------------
--                   FILE 2 
-------------------------------------------------------------
SET @start_time = GETDATE()
PRINT '>> Truncate Table bronze.crm_prd_info '
TRUNCATE TABLE bronze.crm_prd_info

PRINT '>> INSERT Data Into >> bronze.crm_prd_info table '
BULK INSERT bronze.crm_prd_info 
FROM 'A:\Data_Engineer\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
WITH (
FIRSTROW = 2 , 
FIELDTERMINATOR = ',' ,
TABLOCK ) 
SET @end_time = GETDATE() 
PRINT '>> Loadin Duration : ' + CAST( DATEDIFF(second , @start_time , @end_time ) AS NVARCHAR ) 
PRINT'---------------------------------------------------------------------------'

-------------------------------------------------------------
--                   FILE 3
-------------------------------------------------------------
SET @start_time = GETDATE()
PRINT '>> Truncate Table bronze.crm_sales_details '
TRUNCATE TABLE bronze.crm_sales_details

PRINT '>> INSERT Data Into >> bronze.crm_sales_details table '
BULK INSERT bronze.crm_sales_details
FROM 'A:\Data_Engineer\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
WITH (
FIRSTROW = 2 , 
FIELDTERMINATOR = ',' ,
TABLOCK ) 
SET @end_time = GETDATE() 
PRINT '>> Loadin Duration : ' + CAST( DATEDIFF(second , @start_time , @end_time ) AS NVARCHAR ) 
PRINT'---------------------------------------------------------------------------'
-------------------------------------------------------------
--                   FILE 4
-------------------------------------------------------------
SET @start_time = GETDATE()
PRINT '----------------------------------------------'
PRINT 'Loading ERP Files ' 
PRINT '----------------------------------------------'

PRINT '>> Truncate Table bronze.erp_cust_az12 '
TRUNCATE TABLE bronze.erp_cust_az12

PRINT '>> INSERT Data Into >> bronze.erp_cust_az12 '
BULK INSERT bronze.erp_cust_az12
FROM 'A:\Data_Engineer\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
WITH (
FIRSTROW = 2 , 
FIELDTERMINATOR = ',' ,
TABLOCK )  
SET @end_time = GETDATE() 
PRINT '>> Loadin Duration : ' + CAST( DATEDIFF(second , @start_time , @end_time ) AS NVARCHAR ) 
PRINT'---------------------------------------------------------------------------'

-------------------------------------------------------------
--                   FILE 5
-------------------------------------------------------------
SET @start_time = GETDATE()
PRINT '>> Truncate Table bronze.erp_loc_a101 '
TRUNCATE TABLE bronze.erp_loc_a101 

PRINT '>> INSERT Data Into >> bronze.erp_loc_a101 table '
BULK INSERT bronze.erp_loc_a101 
FROM 'A:\Data_Engineer\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
WITH (
FIRSTROW = 2 , 
FIELDTERMINATOR = ',' ,
TABLOCK ) 

SET @end_time = GETDATE() 
PRINT '>> Loadin Duration : ' + CAST( DATEDIFF(second , @start_time , @end_time ) AS NVARCHAR ) 
PRINT'---------------------------------------------------------------------------'

-------------------------------------------------------------
--                   FILE 6
-------------------------------------------------------------
SET @start_time = GETDATE()
PRINT '>> Truncate Table bronze.erp_px_cat_g1v2 '
TRUNCATE TABLE bronze.erp_px_cat_g1v2

PRINT '>> INSERT Data Into >> bronze.erp_px_cat_g1v2 table '
BULK INSERT bronze.erp_px_cat_g1v2 
FROM 'A:\Data_Engineer\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
WITH (
FIRSTROW = 2 , 
FIELDTERMINATOR = ',' ,
TABLOCK ) 

SET @end_time = GETDATE() 
PRINT '>> Loadin Duration : ' + CAST( DATEDIFF(second , @start_time , @end_time ) AS NVARCHAR ) 
PRINT'---------------------------------------------------------------------------'

SET @end_batch_time = GETDATE() ;
PRINT'Whole Bath Duration : ' + CAST( DATEDIFF( second,@start_batch_time , @end_batch_time) AS VARCHAR ) + ' SEC'
END TRY 
BEGIN CATCH 
PRINT '====================================================='
PRINT 'ERROR OCCURED DURAING lOADING BRONZE LAYER'
PRINT 'ERROR MESSAGE' + ERROR_MESSAGE()
PRINT 'ERROR NUMBER' + CAST(ERROR_NUMBER() AS NVARCHAR)
PRINT 'ERROR NUMBER' + CAST(ERROR_STATE() AS NVARCHAR)
PRINT '====================================================='
END CATCH
END
