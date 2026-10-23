select
    (extract(year from p."Release Date")::integer / 10) * 10 as decada,
    count(distinct p.id) as cantidad_peliculas,
    count(s.rating) as cantidad_ratings,
    round(avg(s.rating)::numeric, 2) as rating_promedio
from {{ ref('peliculas') }} p
left join {{ ref('scores') }} s
    on p.id = s.movie_id
where p."Release Date" is not null
group by
    (extract(year from p."Release Date")::integer / 10) * 10
order by
    decada
