select
    s.user_id,
    s.movie_id,
    s.fecha_rating,
    p.fecha_estreno

from {{ ref('stg_scores') }} s

join {{ ref('stg_peliculas') }} p
    on s.movie_id = p.movie_id

where s.fecha_rating < p.fecha_estreno
