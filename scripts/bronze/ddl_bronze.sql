/*
==========================================================
DDl Script : create bronze table
==========================================================
script purpose:
 this sscript create tables in the 'bronze' schema , dropping existing tables
if they already exist.
Run this script to re-define the DDL structure of 'bronze' tables
==========================================================
*/
--Create database 'data warehouse--
use master 

create database datawarehouse;

use datawarehouse;

create schema bronze;
create schema silver;
go
create schema gold;
go


if object_id ('bronze.crm_cust_info','u')is not null
		drop table bronze.crm_cust_info;
go

create table bronze.crm_cust_info (
	cst_id int,
	cst_key nvarchar(50),
	cst_firtname nvarchar(50),
	cst_lastname nvarchar(50),
	cst_material_status nvarchar(50),
	cst_gndr  nvarchar(50),
	cst_create_date date
);


if object_id ('bronze.crm_prd_info','u')is not null
		drop table bronze.crm_prd_info;
create table bronze.crm_prd_info (
	prd_id int,
	prd_key nvarchar(50),
	prd_nm nvarchar(50),
	prd_cost int,
	prd_line nvarchar(50),
	prd_start_dt datetime,
	prd_end_dt datetime
);
go


if object_id ('bronze.crm_sales_details','u')is not null
		drop table bronze.crm_sales_details;
create table bronze.crm_sales_details (
		sls_ord_num nvarchar(50),
		sls_prd_key nvarchar(50),
		sls_cust_id int,
		sls_order_dt int,
		sls_ship_dt int,
		sls_due_dt int,
		sls_sales int,
		sls_quantity int,
		sls_price int
);
go


if object_id ('bronze.erp_CUST_AZ12','u')is not null
		drop table bronze.erp_CUST_AZ12;
create  table bronze.erp_CUST_AZ12 (
	CID nvarchar(50),
	BDATE date,
	GEN nvarchar(50)
);
go

if object_id ('bronze.erp_LOC_A101','u')is not null
		drop table bronze.erp_LOC_A101;
create  table bronze.erp_LOC_A101 (
	CID nvarchar(50),
	CNTRY nvarchar(50)
);
go


if object_id ('bronze.erp_PX_CAT_G1V2','u')is not null
		drop table bronze.erp_PX_CAT_G1V2;
create  table bronze.erp_PX_CAT_G1V2 (
	ID nvarchar(50),
	CAT nvarchar(50),
	SUBCAT nvarchar(50),
	MAINTENANCE nvarchar(50)
);
go

