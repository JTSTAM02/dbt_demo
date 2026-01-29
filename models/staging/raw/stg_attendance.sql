{{ config(materialized='view') }}

with ranked as (

    select
        *,
        row_number() over (
            partition by student_id, attendance_date
            order by loaded_at desc
        ) as rn

    from {{ source('raw', 'raw_attendance') }}

)

select *
from ranked
where rn = 1

