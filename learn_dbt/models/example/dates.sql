{{ config(materialized='incremental', unique_key = 'full_date') }}


select *
from {{ ref('dates_dim') }}
where full_date <= current_date()

{% if is_incremental() %}
  and full_date > (select max(full_date) from {{ this }})
{% endif %}