{{ config(materialized='view') }}

select
    student_id,
    attendance_date,
    attendance_status
from raw.raw_attendance
