with scores_limpios as (

    select
        user_id::integer as user_id,
        movie_id::integer as movie_id,
        rating::integer as rating,
        "Date"::timestamp as fecha_rating,

        row_number() over (
            partition by user_id, movie_id, rating, "Date"
            order by index
        ) as numero_fila

    from {{ ref('scores') }}

    where user_id is not null
      and movie_id is not null
      and rating is not null
      and "Date" is not null
      and rating between 1 and 5

),

scores_validos as (

    select
        s.user_id,
        s.movie_id,
        s.rating,
        s.fecha_rating

    from scores_limpios s

    join {{ ref('stg_usuarios') }} u
        on s.user_id = u.user_id

    join {{ ref('stg_peliculas') }} p
        on s.movie_id = p.movie_id

    where s.numero_fila = 1

      and s.fecha_rating >= p.fecha_estreno

)

select *
from scores_validos
