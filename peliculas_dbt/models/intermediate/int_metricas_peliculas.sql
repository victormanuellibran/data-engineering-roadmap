select
    p.movie_id,
    p.nombre,
    p.fecha_estreno,
    count(s.rating) as cantidad_votos,
    round(avg(s.rating)::numeric, 2) as rating_promedio,
    round(stddev(s.rating)::numeric, 2) as desviacion_rating,
    min(s.rating) as rating_minimo,
    max(s.rating) as rating_maximo
from {{ ref('stg_peliculas') }} p
left join {{ ref('stg_scores') }} s
    on p.movie_id = s.movie_id
group by
    p.movie_id,
    p.nombre,
    p.fecha_estreno
