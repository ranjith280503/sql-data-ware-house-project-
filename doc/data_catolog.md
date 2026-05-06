========================================================================================
DATA DICTIONARY – GOLD LAYER
========================================================================================
 Overview:
    The Gold Layer represents the business-level data, structured for:
    📈 Analytical use
    📊 Reporting purposes
It consists of:
      Dimension Tables → Store descriptive data
      Fact Tables → Store transactional data
-----------------------------------------------------------------------------------------
 --------------------------------  
 Table: gold.dim_customers:    
----------------------------------   


Purpose:
      Stores customer details enriched with demographic and geographic data.

📋 Columns
ColumnName                  	DataType                                          Description
customer_key	                INT	                                 Surrogate key uniquely identifying each customer record
customer_id	I                 INT	                                 Unique numerical identifier assigned to each customer
customer_number   	          NVARCHAR(50)	                       Alphanumeric identifier used for tracking customers
first_name	                  NVARCHAR(50)	                       Customer’s first name
last_name	                    NVARCHAR(50)	                       Customer’s last name
country	                      NVARCHAR(50)	                       Country of residence (e.g., Australia)
marital_status	              NVARCHAR(50)	                       Marital status (e.g., Married, Single)
gender	                      NVARCHAR(50)	                       Gender (e.g., Male, Female)
birthdate	                    DATE	                               Date of birth (YYYY-MM-DD)
create_date	                  DATE                               	 Date when the record was created

---------------------------
Table: gold.dim_products
---------------------------

Purpose:
      Stores information about products and their attributes.

📋 Columns
ColumnName	                        Data Type	                             Description
product_key	                          INT	                        Surrogate key uniquely identifying each product
product_id	                          INT	                        Unique identifier for internal tracking
product_number	                      NVARCHAR(50)	              Alphanumeric product code
product_name	                        NVARCHAR(50)	              Descriptive name of the product
category_id	                          INT	                        Identifier for product category
category	                            NVARCHAR(50)	              High-level category (e.g., Bikes, Components)
subcategory	                          NVARCHAR(50)	              Detailed classification of product
maintenance_required	                NVARCHAR(50)	              Indicates if maintenance is required (Yes/No)
cost	                                INT	                        Base price of the product
product_line	                        NVARCHAR(50)	              Product line (e.g., Road, Mountain)


-----------------------------
Table: gold.fact_sales
------------------------------
Purpose:
    Stores transactional sales data for analytical purposes.

📋 Columns:

ColumnName	                                  DataType	                        Description
order_number	                                NVARCHAR(50)	          Unique identifier for each order (e.g., S054496)
product_key	                                  INT	                    Foreign key referencing product table
customer_key	                                INT	                    Foreign key referencing customer table
order_date	                                  DATE	                  Date when the order was placed
shipping_date	DATE	                          Date                    when the order was shipped
due_date	                                    DATE	                  Payment due date
sales_amount	                                INT	                    Total sales value
quantity	                                    INT                    	Number of units sold
price	                                        INT                    	Price per unit
