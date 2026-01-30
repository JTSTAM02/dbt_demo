# Student Attendance Analytics Warehouse (dbt + Snowflake)

Built an end-to-end analytics engineering pipeline using dbt.

### Features

* Staging models for raw attendance + student data

* SCD Type 2 student dimension using dbt snapshots

* Incremental attendance fact table with surrogate keys

* Deduplication logic for late-arriving records

* KPI mart models for daily and grade-level attendance reporting

* dbt tests enforcing uniqueness and data quality

* Documentation site generated with dbt docs

### Tech Stack

* Snowflake

* dbt Core

* Dimensional Modeling

* Incremental Loads

* Analytics Mart Layer
