select
    p.id as movie_id,
    p."Name" as pelicula,
    p."Release Date" as fecha_estreno,
    count(s.rating) as cantidad_votos,
    round(avg(s.rating)::numeric, 2) as rating_promedio,
    round(stddev(s.rating)::numeric, 2) as desviacion_rating,
    min(s.rating) as rating_minimo,
    max(s.rating) as rating_maximo
from {{ ref('peliculas') }} p
left join {{ ref('scores') }} s
    on p.id = s.movie_id
group by
    p.id,
    p."Name",
    p."Release Date"
