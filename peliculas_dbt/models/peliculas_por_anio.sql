select
    extract(year from "Release Date")::integer as anio,
    count(*) as cantidad_peliculas
from {{ ref('peliculas') }}
where "Release Date" is not null
group by
    extract(year from "Release Date")
order by
    anio
