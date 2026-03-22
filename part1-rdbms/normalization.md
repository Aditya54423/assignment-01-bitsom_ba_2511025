# Normalization Analysis

## 1.1 - ANOMALY ANALYSIS
**Insert Anomaly:-**
In the orders_flat.csv dataset , all information about customers,products,and sales representatives is stored together in a one table.Because of this structure , it makes it hard to add information about a product or customer unless there is an order.

Let us say for example if the company wants to add a new product that has not yet been ordered , there is no efficient way to store information . Every row need to have fields like order_id,customer_id,and sales_rep_id and then If we try to add a new product such as product_id = P010,we need to store that information, Every requires fields like order_id,customer_id,and sales_rep_id.If we want to add a new product such as product_id = P010 we have to create a fake order record just to store product details this leads to data entries.

This issue happens because product information like product_id ,product_name,category and unit_price is closely tied to order data .

**Update Anomaly:-**
Since the dataset stores repeated information across multiple rows,updating a single piece of information can require changing many records.For instance,consider a product such as P004. If the unit_price of this product changes then that update must be made in every row where P004,If one of those rows is accidentally missed the order_flat.csv dataset will values for the same product.

Similarily customer details such as customer_email appear rows whenever the customer places different orders and if we want to update the email address we have to update every row related to the customer.This creates a risk of data inconsistency.


**Delete Anomaly:-**
Another problem occurs when deleting records . Because of many types of information are stored together ,deleting one record can unintentionally remove other information.

For example if only order associated with a particular product is deleted the product's information may disappear from th dataset entirely.This means details like product_name , category and unit_price could be lost . Similarily if a sales representatives appears only in one order and that order is removed all information about that representative can be lost.

This demonstrates how storing all data in a single table can cause accidental loss of important information.

## Normalization Justification:-
At first ,it might seem simpler keeping all the data in a single table.However,the structure of the orders_flat.csv data clearly shows problems caused by this design.When customer details,product information,sales representatives and orders are all stored together the same gets repeated.

More importantly ,this structure creates insert,update and delete anomalies .As we have seen earlier,adding a new product requires inserting a full order record ,which does not accurately represent the real situation.Also updating product prices or customer details require us to modify multiple rows thus increasing the chance of inconsistencies .Deleting records can also lead to removal  of important  data unintentionally.

By Normalizing the database into seperate tables such as customers,products,sales_reps,orders and order_items solves these issues, where each table stores only the data that belongs to the entity and relationships are established and maintained using primary and foreign keys.This kind of structure reduces redundancy ,improves data integrity and also makes updates safer and easier to manage.

Therefore,we can say that normalization does not lead to unnecessary complexity but it is a fundamental design practice that ensures the database remains consistent ,reliable ad scalable as system grows.
