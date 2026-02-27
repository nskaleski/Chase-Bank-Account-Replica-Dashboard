/* 
   PREPARING AccountID COLUMNS FOR RELATIONSHP 
   WITH FactTransaction AND AccountID TABLE
*/


/* 
Ensure the PK column is NOT NULL
*/

ALTER TABLE [financial_transactions].[dbo].[DimAccount]
ALTER COLUMN AccountID SMALLINT NOT NULL;

/*
Add the PK contstraint to both tables
*/

ALTER TABLE [financial_transactions].[dbo].[FactTransaction]
ADD CONSTRAINT PK_Constraint PRIMARY KEY (TransactionID);

ALTER TABLE [financial_transactions].[dbo].[DimAccount]
ADD CONSTRAINT PK__DimAccountConstraint PRIMARY KEY (AccountID);


/*
making sure AccountID FK data type and precision align with
AccoutID in PK table
*/

ALTER TABLE [financial_transactions].[dbo].[FactTransaction]
ALTER COLUMN AccountID SMALLINT;

ALTER TABLE [financial_transactions].[dbo].[FactTransaction]
ALTER COLUMN AccountID SMALLINT NOT NULL;

/*=====================================================================*/
/*=====================================================================*/
/*=====================================================================*/

/* 
   PREPARING CustomerID COLUMNS FOR RELATIONSHP 
   WITH DimAccount AND CustomerID TABLE
*/

/* 
Ensure the PK column is NOT NULL
*/

ALTER TABLE [financial_transactions].[dbo].[DimCustomer]
ALTER COLUMN CustomerID TINYINT NOT NULL;

/*
Add the PK contstraint to DimCustomer table
*/

ALTER TABLE [financial_transactions].[dbo].[DimCustomer]
ADD CONSTRAINT PK_DimCustomer_Constraint PRIMARY KEY (CustomerID);

/*=====================================================================*/
/*=====================================================================*/
/*=====================================================================*/

/* 
   PREPARING ProductID COLUMNS FOR RELATIONSHP 
   WITH Dimproduct AND FactTransaction TABLES
*/

/* 
Ensure the PK column is NOT NULL
*/

ALTER TABLE [financial_transactions].[dbo].[DimProduct]
ALTER COLUMN ProductID SMALLINT NOT NULL;

/*
Add the PK contstraint to DimProduct table
*/

ALTER TABLE [financial_transactions].[dbo].[DimProduct]
ADD CONSTRAINT PK_DimProduct_Constraint PRIMARY KEY (ProductID);

/*=====================================================================*/
/*=====================================================================*/
/*=====================================================================*/

/* 
   PREPARING ProductCategoryID COLUMNS FOR RELATIONSHP 
   WITH DimProductCategory AND DimProductSubCategory TABLES
*/

/* 
Ensure the PK column is NOT NULL
*/

ALTER TABLE [financial_transactions].[dbo].[DimProductCategory]
ALTER COLUMN ProductCategoryID NVARCHAR(50) NOT NULL;

/*
Add the PK contstraint to DimProduct table
*/

ALTER TABLE [financial_transactions].[dbo].[DimProductCategory]
ADD CONSTRAINT PK_DimProductCategory_Constraint PRIMARY KEY (ProductCategoryID);

/*
making sure ProductCategoryID FK data type and precision align with
ProductCategoryID in PK table
*/

ALTER TABLE [financial_transactions].[dbo].[DimProductSubCategory]
ALTER COLUMN ProductCategoryID NVARCHAR(50) NOT NULL;

/*=====================================================================*/
/*=====================================================================*/
/*=====================================================================*/

/* 
   Setting PK in DimProductSubCategory table
*/

/* 
   Ensure the PK column is NOT NULL
*/

ALTER TABLE [financial_transactions].[dbo].[DimProductSubCategory]
ALTER COLUMN ProductSubCategoryID TINYINT NOT NULL;

/*
Add the PK contstraint to DimProduct table
*/

ALTER TABLE [financial_transactions].[dbo].[DimProductSubCategory]
ADD CONSTRAINT PK_DimProductSubCategory_Constraint PRIMARY KEY (ProductSubCategoryID);

