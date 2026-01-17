{{ config(materialized='view') }}

select
    student_id,
    attendance_date,
    attendance_status,
    loaded_at
from {{ source('raw', 'raw_attendance') }}
