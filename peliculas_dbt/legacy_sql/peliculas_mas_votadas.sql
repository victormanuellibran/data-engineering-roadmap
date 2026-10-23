select
    movie_id,
    pelicula,
    cantidad_votos,
    rating_promedio
from {{ ref('metricas_peliculas') }}
where cantidad_votos > 0
order by cantidad_votos desc
