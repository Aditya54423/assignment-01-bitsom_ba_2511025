## **Design Justification - Hospital AI Data System**

## Storage Systems
For our first goal of **predicting readmission risk**,I needed both a place to store live patient records and a seperate system for running heavy historical queries.I went with **PostgreSQL** as the operational database because it handles structured clinical data well and supports ACID transactions such that even if a patient record gets partially written during an admission event ,a rollback keeps the data consistent.But PostgreSQL solely isn't great for training ML models across millions of records , so I also replicate into **Snowflake**, which is a columnar data warehouse built for exactly this kind of analytical workload .The readmission model trains off Snowflake snapshots rather than hitting the live DB.

Second goal- **natural language queries** like "had this patient had a cardiac event ?",a relational database isn't really the right tool,you can't write an SQL query for something that vague.I used **pgvector** (a PostgreSQL extension,so that it fits into existing infrastructure) to store vector embeddings of patient history .When a doctor asks a question in plain English,the question gets embedded and matched againststored vectors .This is a RAG setup and it works better than trying to traslate natural language into SQL.

For goal 3 - **monthly reports on bed occupancy** and costs ,Snowflake again is the right call.Running aggregations like "total ICU cost by department for October" on a row oriented OLTP database wpuld be slow and would compete with live clinical queries .Snowflake seperates compute from storage so you can run big reports without affecting anything else.

Another goal here is **real time ICU vitals** , I chose **InfluxDB** because it's a time series database built for exactly to manage high frequency sensor data queried by time window ,Storing vitals in PostgreSQL would work but would get very large vary fast,and time series queries likeshow last "show last 30 minutes of heart rate" are much slower on a row store.

## OLTP vs OLAP Boundary
The transactional system ends at PostgreSQL.Everything that involves writing live data like new admissions,updated prescriptions ,doctor notes happens here,These are considered as short,frequent and low latency operations.

The OLAP boundary begins the moment data crosses into Snowflake via the ETL job,From that point on,data is read only and optimized for aggregation rather than  individual record lookups.The readmission model,the report generator,and any long running historical analysis all work exclusively off Snowflake.This separation means a slow analytics query never blocks a doctor trying to pull a patient's file in the middle of a shift.

InfluxDB sits outside this binary as it's neither transactional not batch , it's just a specialised store for the streaming path.

## Trade - offs
The biggest trade-off in my design is **data freshness/opertational isolation**.Because Snowflake is populated by a batch job,the readmission model is always working with data that could be up to 24 hours old . a patient admitted this morning won't influece the risk scores until tomorrow's batch runs which is at ideal for a clinical setting.

I chose this approach anyway because running continuous writes into Snowflake while also running analytical queries would create resource contentio and significantly increase cost. The batch keeps the two systems cleanly isolated.

To mitigate the staleness problem,I would implement **Change Data Capture (CDC)** using Debezium this streams row level changes from PostgreSQL into Kafka and then into Snowflake incrementally , reducing the lag from 24 hours to under afew minutes .The batch job becomes a fallback rather than the primary sync mechanism.For inference specifically ,the model can also pull the latest PostgreSQL record at prediction time and combine it with the pre trained weights, so at least the input features are fresh even if the model itself was trained on yesterday's snapshot.


