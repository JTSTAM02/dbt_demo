{% snapshot student_snapshot %}

{{
    config(
        target_schema='snapshots',
        unique_key='student_id',
        strategy='check',
        check_cols=['grade'],
        invalidate_hard_deletes=True
    )
}}


select
    student_id,
    grade,
    loaded_at
from {{ source('raw', 'raw_students') }}


{% endsnapshot %}
