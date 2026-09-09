/*
================================================================================
Create Data Warehouse Database and Schemas
================================================================================
Script Purpose:
    This script creates the 'DataWarehouse' database and the schemas
    required for the Data Warehouse architecture.

    Schemas:
        - bronze : Raw source data
        - silver : Cleaned and standardized data
        - gold   : Business-ready analytical data

WARNING:
    This script is intended for initial setup/development.

    If the 'DataWarehouse' database already exists, it will be dropped
    and recreated. All existing data will be permanently deleted.

    Do NOT run this script against a production database.
================================================================================
*/


-- ============================================================================
-- Create DataWarehouse Database
-- ============================================================================

use master;

CREATE DATABASE DataWarehouse ; 

use DataWarehouse;



-- ============================================================================
-- Create bronze , silver , gold schema 


CREATE SCHEMA bronze ; 
go
CREATE SCHEMA silver ; 
go
CREATE SCHEMA gold ; 
go
