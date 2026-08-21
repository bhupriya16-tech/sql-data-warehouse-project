/*
===========================================================
stored procedure: load bronze layer( source->bronze)
============================================================
Script purpose:
This stored procedure loads  data into the 'bronze'schema from external csv file.
it performs the following actions:
-Truncate the bronze tables before loading data.
-uses the 'bolk insert' command to load data from a csv files  to bronze tables.

Parameters:
none.
This stored procedure  doesn not accept  any parameters or retuen any values.

usage example :
  Exec bronze.load_ bronze;
=============================================================   
*/
create or alter procedure bronze.load_bronze as 
begin
	declare @start_time datetime, @end_time datetime, @batch_start_time datetime, @batch_end_time datetime;
	begin try
		set @batch_start_time = getdate();
		print '=========================================';
		print 'Loading bronze layer';
		print '=========================================';

		print '-----------------------------------------';
		print 'Loading crm tables';
		print '-----------------------------------------';

		set @start_time = Getdate();
		print '>>truncate table: bronze.crm_cust_info';
		truncate table bronze.crm_cust_info;
		print '>>inserting data into: bronze.crm_cust_info';
		bulk insert bronze.crm_cust_info
		from 'C:\SQLData\cust_info.csv'
		with (
			firstrow=2,
			fieldterminator=',',
			tablock
		);
		set @end_time = getdate();
		print '>>load duration:' + cast(datediff(second,@start_time,@end_time) as nvarchar) + 'seconds';
		print '>>-------------------------------------';
		set @start_time = getdate();
		print '>>truncate table: bronze.crm_prd_info';
		truncate table bronze.crm_prd_info;
		print '>>inserting data into: bronze.crm_prd_info';
		bulk insert bronze.crm_prd_info
		from 'C:\SQLData\prd_info.csv'
		with (
			firstrow=2,
			fieldterminator=',',
			tablock
		);
		set @end_time = getdate();
		print '>>load durattion:' + cast(datediff(second,@start_time,@end_time) as nvarchar) + 'seconds';
		print '>>---------------------------------------';
		set @start_time = getdate();
		print '>>truncate table: bronze.crm_sales_details';
		truncate table bronze.crm_sales_details;
		print '>>inserting data into: bronze.crm_sales_details';
		bulk insert bronze.crm_sales_details
		from 'C:\SQLData\sales_details.csv'
		with (
			firstrow=2,
			fieldterminator=',',
			tablock
		);
		set @end_time = getdate();
		print '>>load duration:' + cast(datediff(second,@start_time,@end_time) as nvarchar) + 'seconds';
		print '>>------------------------------------------';

		print '-----------------------------------------';
		print 'Loading erp tables';
		print '-----------------------------------------';

		set @start_time = getdate();
		print '>>truncate table: bronze.erp_CUST_AZ12';
		truncate table bronze.erp_CUST_AZ12;
		print '>>inserting data into: bronze.erp_CUST_AZ12';
		bulk insert bronze.erp_CUST_AZ12
		from 'C:\SQLData\CUST_AZ12.csv'
		with (
			firstrow=2,
			fieldterminator=',',
			tablock
		);
		set @end_time = getdate();
		print '>>load duration:' + cast(datediff(second,@start_time,@end_time) as nvarchar) + 'seconds';
		print '>>-------------------------------------------';
		set @start_time =  getdate();
		print '>>truncate table: bronze.erp_LOC_A101';
		truncate table bronze.erp_LOC_A101;
		print '>>inserting data into: bronze.erp_LOC_A101';
		bulk insert bronze.erp_LOC_A101
		from 'C:\SQLData\LOC_A101.csv'
		with (
			firstrow=2,
			fieldterminator=',',
			tablock
		);
		set @end_time = getdate();
		print '>>load duration:' + cast(datediff(second,@start_time,@end_time)  as varchar) + 'seconds';
		print '>>------------------------------------------';
		set @start_time = getdate();
		print '>>truncate table: bronze.erp_PX_CAT_G1V2';
		truncate table bronze.erp_PX_CAT_G1V2;
		print '>>inserting data into: bronze.erp_PX_CAT_G1V2';
		bulk insert bronze.erp_PX_CAT_G1V2
		from 'C:\SQLData\PX_CAT_G1V2.csv'
		with (
			firstrow=2,
			fieldterminator=',',
			tablock
		);
		set @end_time =  getdate();
		print '>>load duration:' + cast(datediff(second,@start_time,@end_time) as varchar) + 'seconds';
		print '>>------------------------------------------';

		set @batch_end_time = getdate();
		print '==================================================';
		print 'loading bronze layer is completed';
		print '  -total load duration:' + cast(datediff(second,@batch_start_time,@batch_end_time) as varchar) + 'seconds';
		print '===================================================';
	end try
	begin catch
		print '===================================================';
		print 'error occured during loading bronze layeer';
		print 'error message' + error_message();
		print 'error message' + cast(error_number() as nvarchar);
		print 'error messsage' + cast(error_state() as nvarchar);
		print '===================================================';
	end catch
end;
