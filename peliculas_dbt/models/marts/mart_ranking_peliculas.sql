select
    movie_id,
    nombre,
    fecha_estreno,
    cantidad_votos,
    rating_promedio
from {{ ref('int_metricas_peliculas') }}
where cantidad_votos >= 50
order by rating_promedio desc, cantidad_votos desc
