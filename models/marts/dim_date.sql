{{ config(materialized='table') }}

with date_spine as (

    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="to_date('2025-01-01')",
        end_date="dateadd(day, 365, current_date)"
    ) }}

)

select
    date_day as date_key,
    date_day as date,

    extract(year from date_day) as year,
    extract(month from date_day) as month,
    extract(day from date_day) as day,

    to_char(date_day, 'Day') as day_name,
    to_char(date_day, 'Month') as month_name,

    case
        when extract(dow from date_day) in (0,6) then true
        else false
    end as is_weekend

from date_spine
