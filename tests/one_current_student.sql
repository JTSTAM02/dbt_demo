select
    student_id,
    count(*) as cnt
from {{ ref('dim_students') }}
where is_current = true
group by student_id
having count(*) > 1