select
    g.genero_id,
    g.genero,
    count(distinct pg.movie_id) as cantidad_peliculas,
    count(s.rating) as cantidad_ratings,
    round(avg(s.rating)::numeric, 2) as rating_promedio
from {{ ref('stg_generos') }} g
join {{ ref('stg_pelicula_genero') }} pg
    on g.genero_id = pg.genero_id
left join {{ ref('stg_scores') }} s
    on pg.movie_id = s.movie_id
group by
    g.genero_id,
    g.genero
