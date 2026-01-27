{{ 
  config(
    materialized='incremental',
    unique_key='student_attendance_id',
    on_schema_change='fail'
  ) 
}}

with base as (

    select
        {{ dbt_utils.generate_surrogate_key([
            'a.student_id',
            'a.attendance_date'
        ]) }} as student_attendance_id,

        a.student_id,
        s.grade,
        a.attendance_date,
        a.attendance_status,
        a.loaded_at

    from {{ ref('stg_attendance') }} a
    left join {{ ref('dim_students') }} s
        on a.student_id = s.student_id

    {% if is_incremental() %}
        -- Only pull new or updated rows
        where a.loaded_at > (
            select max(loaded_at) from {{ this }}
        )
    {% endif %}

)

select * from base
