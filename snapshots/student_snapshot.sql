{% snapshot student_snapshot %}

{{
    config(
        target_schema='snapshots',
        unique_key='student_id',
        strategy='timestamp',
        updated_at='loaded_at'
    )
}}


select
    student_id,
    attendance_date,
    attendance_status,
    loaded_at
from {{ source('raw', 'raw_attendance') }}


{% endsnapshot %}
