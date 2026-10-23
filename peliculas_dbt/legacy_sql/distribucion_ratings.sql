select
    rating,
    count(*) as cantidad,
    round(
        count(*) * 100.0 / sum(count(*)) over (),
        2
    ) as porcentaje
from {{ ref('scores') }}
group by rating
order by rating
