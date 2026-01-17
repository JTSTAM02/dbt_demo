{{ config(
    materialized='incremental',
    unique_key='student_id'
) }}

select
    student_id,
    count(*) as attendance_days,
    max(loaded_at) as loaded_at
from {{ ref('stg_attendance') }}

{% if is_incremental() %}
where loaded_at > (
    select max(loaded_at)
    from {{ this }}
)
{% endif %}

group by student_id

