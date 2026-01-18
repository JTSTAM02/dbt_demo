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
    *
from {{ ref('stg_students') }}


{% endsnapshot %}
