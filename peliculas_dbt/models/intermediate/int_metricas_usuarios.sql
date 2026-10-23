select
    u.user_id,
    u.ocupacion,
    u.activo_desde,
    count(s.rating) as cantidad_ratings,
    round(avg(s.rating)::numeric, 2) as rating_promedio,
    min(s.rating) as rating_minimo,
    max(s.rating) as rating_maximo
from {{ ref('stg_usuarios') }} u
left join {{ ref('stg_scores') }} s
    on u.user_id = s.user_id
group by
    u.user_id,
    u.ocupacion,
    u.activo_desde
