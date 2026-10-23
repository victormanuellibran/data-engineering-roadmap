select
    movie_id,
    genero_id,
    count(*) as cantidad

from {{ ref('stg_pelicula_genero') }}

group by
    movie_id,
    genero_id

having count(*) > 1
