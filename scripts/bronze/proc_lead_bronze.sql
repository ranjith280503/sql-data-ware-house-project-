/*
======================================================================================
Stored Procedure: Load Bronze Layer (Source-> Bronze)
======================================================================================
Script Purpose:
This stored procedure loads data into the 'bronze' schema from external CSV files.
It performs the following actions:
    Truncates the bronze tables before loading data
    Uses the  'BULK INSERTS' command to load data from csv Files to bronze tables.
Parameters :
  None
  This stored procedure does not accept any parameters or return any values.
Usage Example:
  EXEC bronze. load bronze;
========================================================================================
*/

create or alter procedure bronze.load_bronze as 
begin 
declare @start_time datetime ,@end_time datetime,@batch_start datetime, @batch_end datetime
BEGIN TRY 
print'=============================================================';
print ' bronze.load_bronze';
print'=============================================================';

print'-------------------------------------------------------------';
print 'CRM LOADING TABLES'
print'--------------------------------------------------------------';


set @start_time=GETDATE()
set @batch_start=getdate()
print'Truncating Talbles : bronze.crm_cust_info '
print('Inserting Tables : bronze.crm_cust_info')

  truncate table bronze.crm_cust_info 
        BULK INSERT  bronze.crm_cust_info
        FROM 'C:\Users\Admin\Documents\cust_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            tablock
        );
    set @end_time=getdate()
    print'Load duration :' + cast(datediff(second,@start_time,@end_time)as nvarchar)+'seconds'
    print'---------------------------------------------------------------------------'

set @start_time=GETDATE()
print'Truncating Talbles : bronze.crm_prd_info'
print('Inserting Tables : bronze.crm_prd_info')

        truncate table bronze.crm_prd_info
        bulk insert  bronze.crm_prd_info
        from 'C:\Users\Admin\Documents\prd_info.csv'
        with(
        firstrow=2,
        fieldterminator=',',
        tablock
        )
set @end_time=getdate()
print'Load duration :' + cast(datediff(second,@start_time,@end_time)as nvarchar)+'seconds'
print'---------------------------------------------------------------------------'


set @start_time=GETDATE()
print'Truncating Talbles : crm_sales_details'
print('Inserting Tables :  crm_sales_details')
        BULK INSERT bronze.crm_sales_details
        FROM   'C:\Users\Admin\Documents\sales_deatils.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );

set @end_time=getdate()
print'Load duration :' + cast(datediff(second,@start_time,@end_time)as nvarchar)+'seconds'
print'---------------------------------------------------------------------------'


print'--------------------------------------------------------------';
print 'ERP LOADING TABLES'
print'--------------------------------------------------------------';

set @start_time=GETDATE()
print'Truncating Talbles : bronze.erp_cust_az12'
print('Inserting Tables :   bronze.erp_cust_az12')

         truncate table bronze.erp_cust_az12
         bulk insert bronze.erp_cust_az12
         from 'C:\Users\Admin\Documents\custaz12.csv'
         with (
         firstrow=2,
         fieldterminator=',',
         tablock
         )
set @end_time=getdate()
print'Load duration :' + cast(datediff(second,@start_time,@end_time)as nvarchar)+'seconds'
print'---------------------------------------------------------------------------'


set @start_time=GETDATE()
print'Truncating Talbles   bronze.erp_loc_a101]'
print('Inserting Tables :  bronze.erp_loc_a101')
         truncate table  bronze.erp_loc_a101
         bulk insert bronze.erp_loc_a101
         from 'C:\Users\Admin\Documents\loc_a101.csv'
         with(
         firstrow=2,
         fieldterminator=',',
         tablock
         )
set @end_time=getdate()
print'Load duration :' + cast(datediff(second,@start_time,@end_time)as nvarchar)+'seconds'
print'---------------------------------------------------------------------------'


set @start_time=GETDATE()
print'Truncating Talbles: erp_px_cat_g1v2'
print('Inserting Tables : erp_px_cat_g1v2')
         truncate table bronze.erp_px_cat_g1v2
         bulk insert bronze.erp_px_cat_g1v2
         from 'C:\Users\Admin\Documents\px_cat_g1v2.csv'
         with(
         firstrow=2,
         fieldterminator=',',
         tablock
 );
 set @end_time=GETDATE()
 print 'load time erp :' + cast(datediff(second,@start_time,@end_time) as nvarchar)+'seconds'
 print'--------------------------------------------------------------------------------------'
 
 set @batch_end=GETDATE()
 print'======================================================================================'
 print 'Loading Bronzing lazer is Completed'
 print'Total Load duration '+ cast(datediff(second,@batch_start,@batch_end) as nvarchar)+'seconds'
 print'======================================================================================'

 end try 
 begin catch
 print'error message occured'
 print'error message:'+ error_message();
 print'error number:' + cast(error_number() as varchar);
 print'error number:' + cast(error_state() as varchar);

 set @end_time=GETDATE()
 print 'load time erp :' + cast(datediff(second,@start_time,@end_time) as nvarchar)+'seconds';
 print'--------------------------------------------------------------------------------------';
 



 end catch;

 end;

exec bronze.load_bronze ;
