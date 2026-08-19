/*
============================================================
Create database and schemas
============================================================
Script purpose :
This script creates  new database  names ' datawarehouse ' after checking if it already exists.
if the database exists, it is droped and recreated. Additionally the scripts set a three schemas within the database: 'brownz' , 'silver' and 'gold'.

WARNING: 
Running this script will drop the entre 'datawarehouse' database  if it exists. 
All data in the database will be permently deleted. Proceed with caution aand ensure you have proper backups beefore  running this script.
*/

use master;
GO

--drop and recreate the 'datawarehouse' database
if exists (select 1 from sys.databases where name = 'datawarehouse' )
Begin 
    Alter database datawarehouse set single_user with rollback immediate;
    Drop database datawarehouse;;
end;
go

--create the 'datawarehouse'  database
create database datawarehouse;
go

use datawarehouse;;
go

--create schemas
create schema bronze;
go
create schema silver;
go
create schema gold;
go

