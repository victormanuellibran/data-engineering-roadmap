select
    movie_id,
    nombre,
    cantidad_votos,
    rating_promedio
from {{ ref('int_metricas_peliculas') }}
where cantidad_votos > 0
order by cantidad_votos desc
