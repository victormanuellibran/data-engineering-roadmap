select
    genero_id,
    genero,
    cantidad_peliculas,
    cantidad_ratings,
    rating_promedio
from {{ ref('int_metricas_generos') }}
order by rating_promedio desc
