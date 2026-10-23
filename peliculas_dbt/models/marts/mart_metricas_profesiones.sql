select
    ocupacion,
    cantidad_usuarios,
    cantidad_ratings,
    rating_promedio
from {{ ref('int_metricas_profesiones') }}
order by cantidad_ratings desc
