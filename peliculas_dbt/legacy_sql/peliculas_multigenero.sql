select
    id as movie_id,
    "Name" as pelicula,
    (
        "unknown" +
        "Action" +
        "Adventure" +
        "Animation" +
        "Children's" +
        "Comedy" +
        "Crime" +
        "Documentary" +
        "Drama" +
        "Fantasy" +
        "Film-Noir" +
        "Horror" +
        "Musical" +
        "Mystery" +
        "Romance" +
        "Sci-Fi" +
        "Thriller" +
        "War" +
        "Western"
    ) as cantidad_generos
from {{ ref('peliculas') }}
order by cantidad_generos desc, pelicula
