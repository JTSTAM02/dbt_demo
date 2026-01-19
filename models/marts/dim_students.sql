{{ config(materialized='view') }}

select
    {{ dbt_utils.generate_surrogate_key([
        'student_id',
        'dbt_valid_from'
    ]) }} as student_key,
    
    student_id,
    grade,
    dbt_valid_from,
    dbt_valid_to,
    case
        when dbt_valid_to is null then true
        else false
    end as is_current
from {{ ref('student_snapshot') }}

