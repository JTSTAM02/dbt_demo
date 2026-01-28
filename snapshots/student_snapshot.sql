{% snapshot student_snapshot %}

{{
    config(
        target_schema='snapshots',
        unique_key='student_id',
        strategy='check',
        check_cols=['grade']
    )
}}


select
    student_id,
    grade,
    loaded_at
from {{ source('raw', 'raw_students') }}


{% endsnapshot %}
