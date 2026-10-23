with peliculas_limpias as (

    select
        id::integer as movie_id,
        trim("Name") as nombre,
        "Release Date"::date as fecha_estreno,
        nullif(trim("IMDB URL"), '') as imdb_url,

        row_number() over (
            partition by id
            order by index
        ) as numero_fila

    from {{ ref('peliculas') }}

    where id is not null
      and "Name" is not null
      and "Release Date" is not null

)

select
    movie_id,
    nombre,
    fecha_estreno,
    imdb_url

from peliculas_limpias

where numero_fila = 1
  and nombre <> ''

