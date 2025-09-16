
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE()
		PRINT '====================================';
		PRINT 'Loading Bronze layer';
		PRINT '===================================='

		PRINT '-----------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '-----------------------------';

		set @start_time = GETDATE()
		PRINT '>>Truncating Table: bronze.crm_cust_info'
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '>>Inserting to Table: bronze.crm_cust_info'
		BULK INSERT bronze.crm_cust_info 
		FROM 'C:\Users\HP\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		set @end_time = GETDATE()
		PRINT '>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'

		PRINT '>>Truncating Table: bronze.crm_prd_info'
		set @start_time = GETDATE()
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT '>>Inserting to Table: bronze.crm_prd_info'
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\HP\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		set @end_time = GETDATE()
		PRINT '>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'

		PRINT '>>Truncating Table: bronze.crm_sales_details'

		set @start_time = GETDATE()
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT '>>Inserting to Table: bronze.crm_sales_details'
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\HP\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		set @end_time = GETDATE()
		PRINT '>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'

		PRINT '-----------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '-----------------------------';

		PRINT '>>Truncating Table: bronze.erp_loc_a101'

		set @start_time = GETDATE()
		TRUNCATE TABLE bronze.erp_loc_a101;

		PRINT '>>Inserting to Table: bronze.erp_loc_a101'
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\HP\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		set @end_time = GETDATE()
		PRINT '>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'

		PRINT '>>Truncating Table: bronze.erp_cust_az12'

		set @start_time = GETDATE()
		TRUNCATE TABLE bronze.erp_cust_az12;

		PRINT '>>Inserting to Table: bronze.erp_cust_az12'
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\HP\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		set @end_time = GETDATE()
		PRINT '>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'

		PRINT '>>Truncating Table: bronze.erp_px_cat_g1v2'

		set @start_time = GETDATE()
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		PRINT '>>Inserting to Table: bronze.erp_px_cat_g1v2'
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\HP\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		set @end_time = GETDATE()
		PRINT '>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'
		SET @batch_end_time = GETDATE();
		PRINT '>> Total Load duration: ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds'

	END TRY
	BEGIN CATCH
		PRINT '===========';
		PRINT 'Error occured during laoding broze layer';
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '===========';
	END CATCH
END
