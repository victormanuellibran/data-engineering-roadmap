with valoraciones as (
    select
        u."Occupation" as profesion,
        p.id as movie_id,
        p."Name" as pelicula,
        count(*) as cantidad_ratings,
        round(avg(s.rating)::numeric, 2) as rating_promedio
    from {{ ref('usuarios') }} u
    join {{ ref('scores') }} s
        on u.id = s.user_id
    join {{ ref('peliculas') }} p
        on s.movie_id = p.id
    group by
        u."Occupation",
        p.id,
        p."Name"
),

ranking as (
    select
        profesion,
        movie_id,
        pelicula,
        cantidad_ratings,
        rating_promedio,
        row_number() over (
            partition by profesion
            order by rating_promedio desc, cantidad_ratings desc
        ) as posicion
    from valoraciones
    where cantidad_ratings >= 3
)

select
    profesion,
    posicion,
    movie_id,
    pelicula,
    cantidad_ratings,
    rating_promedio
from ranking
where posicion <= 5
order by profesion, posicion
