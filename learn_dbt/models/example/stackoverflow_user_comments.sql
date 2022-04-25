{{ config(materialized='table') }}

WITH users AS (
  SELECT
    id,
    display_name
  FROM {{ source('sample', 'users') }}
),

comments AS (
  SELECT
    id,
    user_id
  FROM {{ source('sample', 'comments') }}
)

SELECT
    u.id                    AS user_id,
    u.display_name          AS user_name,
    count(c.id)             AS comments_count,
from users u
LEFT JOIN comments c
ON u.id = c.user_id

{{group_by(2)}}