select
    (select count(*) from {{ ref('peliculas') }}) as total_peliculas,
    (select count(*) from {{ ref('usuarios') }}) as total_usuarios,
    (select count(*) from {{ ref('scores') }}) as total_ratings,
    (
        select round(avg(rating)::numeric, 2)
        from {{ ref('scores') }}
    ) as rating_promedio_global,
    (
        select min("Release Date")
        from {{ ref('peliculas') }}
        where "Release Date" is not null
    ) as pelicula_mas_antigua,
    (
        select max("Release Date")
        from {{ ref('peliculas') }}
        where "Release Date" is not null
    ) as pelicula_mas_reciente
