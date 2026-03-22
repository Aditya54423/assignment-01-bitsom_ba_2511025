## Part 3.3
## ETL Decisions
## Decision 1 :- Data Standardization

**Problem:-** The raw retail transaction dataset contained inconsistent date format like "29/08/2023","12-12-2023" and "2023-02-05".These kind of inconsistencies would lead to parsing issues when loading the data into SQL and making time-based analysis could have become difficult and unreliable.

**Resolution:-** During the transformation stage ,all dates can be converted to the ISO standard format i.e YYYY-MM-DD which ensure compatability with SQL DATE data types and enables us to extract time hierarchy attributes such as month and year from the dim_date dimension table.

## Decision 2 :- Category Normalization

**Problem:-**
The product category column contained inconsistent casing,including values like "Electronics","electronics",and "ELECTRONICS", If this would have loaded directly aggregation queries would treat these as different categories leading to incorrect analytical results.

**Resolution:-** All category values should be standardized to a consistent format during the transformation stage,This ensures that analytical queries correctly aggregate sales by product category.


# Decision 3 : Handling Missing Values

**Problem:-** The dataset contained NULL values in certain description fields such as store_city and product category.Missing values in dimension attributes can lead to incomplete dimension records and incorrect joins in the data warehouse.

**Resolution:-**
Missing values were addressed using two strategies,where possible placeholders like "Unknown city" were used to maintain referential integrity.Records missing critical dimension attributes were excluded during transformation to prevent data quality issues in the warehouse.


