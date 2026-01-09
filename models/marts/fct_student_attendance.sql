{{ config(materialized='table') }}

select
    student_id,
    count(*) as total_days,
    sum(case when attendance_status = 'Present' then 1 else 0 end) as days_present,
    sum(case when attendance_status = 'Absent' then 1 else 0 end) as days_absent,
    round(sum(case when attendance_status = 'Present' then 1 else 0 end)::numeric / count(*), 2) as pct_present
from {{ ref('stg_attendance') }}
group by 1
