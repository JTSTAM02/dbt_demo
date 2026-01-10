{{ config(materialized='view') }}

select
    student_id,
    attendance_date,
    attendance_status
from {{ source('raw', 'raw_attendance') }}
