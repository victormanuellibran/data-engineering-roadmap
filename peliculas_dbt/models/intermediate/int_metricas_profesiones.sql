select
    u.ocupacion,
    count(distinct u.user_id) as cantidad_usuarios,
    count(s.rating) as cantidad_ratings,
    round(avg(s.rating)::numeric, 2) as rating_promedio
from {{ ref('stg_usuarios') }} u
left join {{ ref('stg_scores') }} s
    on u.user_id = s.user_id
group by
    u.ocupacion
