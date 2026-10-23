select distinct
    p.movie_id,
    g.genero_id

from {{ ref('peliculas') }} raw

join {{ ref('stg_peliculas') }} p
    on raw.id = p.movie_id

cross join lateral (

    values
        (1,  raw."Action"),
        (2,  raw."Adventure"),
        (3,  raw."Animation"),
        (4,  raw."Children's"),
        (5,  raw."Comedy"),
        (6,  raw."Crime"),
        (7,  raw."Documentary"),
        (8,  raw."Drama"),
        (9,  raw."Fantasy"),
        (10, raw."Film-Noir"),
        (11, raw."Horror"),
        (12, raw."Musical"),
        (13, raw."Mystery"),
        (14, raw."Romance"),
        (15, raw."Sci-Fi"),
        (16, raw."Thriller"),
        (17, raw."War"),
        (18, raw."Western")

) as g(genero_id, pertenece)

where g.pertenece = 1
