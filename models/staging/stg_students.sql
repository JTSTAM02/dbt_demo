{{ config(materialized='view') }}

select distinct
    student_id,
    grade,
    loaded_at
from {{ source('raw', 'raw_students') }}
