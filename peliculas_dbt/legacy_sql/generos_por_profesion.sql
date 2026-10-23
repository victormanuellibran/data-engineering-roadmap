select
    u."Occupation" as profesion,
    g.genero,
    count(s.rating) as cantidad_ratings,
    round(avg(s.rating)::numeric, 2) as rating_promedio
from {{ ref('usuarios') }} u
join {{ ref('scores') }} s
    on u.id = s.user_id
join {{ ref('peliculas') }} p
    on s.movie_id = p.id
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
where g.pertenece = 1
group by
    u."Occupation",
    g.genero
order by
    profesion,
    rating_promedio desc
