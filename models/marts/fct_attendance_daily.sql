{{ config(materialized='table') }}

with attendance as (

    select
        attendance_date,
        grade,
        attendance_status

    from {{ ref('fct_student_attendance') }}

),

daily as (

    select
        attendance_date,
        grade,

        count(*) as total_records,

        sum(
            case
                when attendance_status = 'Present' then 1
                else 0
            end
        ) as present_count

    from attendance
    group by
        attendance_date,
        grade

)

select
    attendance_date,
    grade,
    total_records,
    present_count,

    round(present_count / nullif(total_records, 0), 3)
        as attendance_rate

from daily
order by attendance_date, grade
