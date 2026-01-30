{{ config(materialized='table') }}

select
    attendance_date,
    grade,

    count(*) as total_students,

    sum(case when attendance_status = 'Absent' then 1 else 0 end)
        as absent_students,

    round(
        sum(case when attendance_status = 'Present' then 1 else 0 end)
        / nullif(count(*), 0),
        4
    ) as attendance_rate

from {{ ref('fct_student_attendance') }}

group by attendance_date, grade
order by attendance_date, grade
