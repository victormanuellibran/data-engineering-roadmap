select
    g.genero,
    count(distinct p.id) as cantidad_peliculas,
    count(s.rating) as cantidad_ratings,
    round(avg(s.rating)::numeric, 2) as rating_promedio
from {{ ref('peliculas') }} p
cross join lateral (
    values
        ('Action', p."Action"),
        ('Adventure', p."Adventure"),
        ('Animation', p."Animation"),
        ('Children''s', p."Children's"),
        ('Comedy', p."Comedy"),
        ('Crime', p."Crime"),
        ('Documentary', p."Documentary"),
        ('Drama', p."Drama"),
        ('Fantasy', p."Fantasy"),
        ('Film-Noir', p."Film-Noir"),
        ('Horror', p."Horror"),
        ('Musical', p."Musical"),
        ('Mystery', p."Mystery"),
        ('Romance', p."Romance"),
        ('Sci-Fi', p."Sci-Fi"),
        ('Thriller', p."Thriller"),
        ('War', p."War"),
        ('Western', p."Western")
) as g(genero, pertenece)
left join {{ ref('scores') }} s
    on p.id = s.movie_id
where g.pertenece = 1
group by
    g.genero
order by
    cantidad_ratings desc
