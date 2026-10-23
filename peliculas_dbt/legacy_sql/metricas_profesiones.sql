select
    u."Occupation" as profesion,
    count(distinct u.id) as cantidad_usuarios,
    count(s.rating) as cantidad_ratings,
    round(avg(s.rating)::numeric, 2) as rating_promedio_profesion
from {{ ref('usuarios') }} u
left join {{ ref('scores') }} s
    on u.id = s.user_id
group by
    u."Occupation"
order by
    cantidad_ratings desc
