select
    p.id as movie_id,
    p."Name" as pelicula,
    round(avg(s.rating)::numeric, 2) as rating_promedio,
    count(*) as cantidad_votos
from {{ ref('peliculas') }} p
join {{ ref('scores') }} s
    on p.id = s.movie_id
group by
    p.id,
    p."Name"
order by
    rating_promedio desc,
    cantidad_votos desc

