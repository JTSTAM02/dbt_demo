{{ 
  config(
    materialized='incremental',
    unique_key='student_attendance_id',
    on_schema_change='sync_all_columns'
  ) 
}}

with base as (

    select
        {{ dbt_utils.generate_surrogate_key([
            'a.student_id',
            'attendance_date'
        ]) }} as student_attendance_id,

        s.student_key,
        a.student_id,
        s.grade,

        a.attendance_date,
        a.attendance_status,
        a.loaded_at

    from {{ ref('stg_attendance') }} a
    left join {{ ref('dim_students') }} s
        on a.student_id = s.student_id
        and a.attendance_date >= s.dbt_valid_from
        and (a.attendance_date < s.dbt_valid_to or s.dbt_valid_to is null)

    {% if is_incremental() %}
        -- Only pull new or updated rows
        where a.loaded_at > (
            select coalesce(max(loaded_at), '1900-01-01') 
            from {{ this }}
        )
    {% endif %}

)

select * from base
