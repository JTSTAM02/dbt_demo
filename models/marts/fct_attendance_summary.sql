{{ config(materialized='table') }}

select
    attendance_date,

    count(*) as total_records,

    count(distinct student_id) as total_students,

    sum(case when attendance_status = 'Present' then 1 else 0 end)
        as present_count,

    sum(case when attendance_status = 'Absent' then 1 else 0 end)
        as absent_count,

    round(
        100.0 * sum(case when attendance_status = 'Present' then 1 else 0 end)
        / count(*),
        2
    ) as attendance_rate

from {{ ref('fct_student_attendance') }}

group by 1
order by attendance_date
