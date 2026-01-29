{{ config(materialized='table') }}

with spine as (

    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="to_date('2024-01-01')",
        end_date="current_date"
    ) }}

)

select
    date_day as date,

    year(date_day) as year,
    month(date_day) as month,
    day(date_day) as day_of_month,

    dayofweek(date_day) as day_of_week,

    case
        when dayofweek(date_day) in (1,7) then true
        else false
    end as is_weekend

from spine
