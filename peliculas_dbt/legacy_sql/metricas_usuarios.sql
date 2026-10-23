select
    u.id as user_id,
    u."Occupation" as profesion,
    u."Active Since" as activo_desde,
    count(s.rating) as cantidad_ratings,
    round(avg(s.rating)::numeric, 2) as rating_promedio,
    min(s.rating) as rating_minimo,
    max(s.rating) as rating_maximo
from {{ ref('usuarios') }} u
left join {{ ref('scores') }} s
    on u.id = s.user_id
group by
    u.id,
    u."Occupation",
    u."Active Since"
