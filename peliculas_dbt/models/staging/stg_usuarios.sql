with usuarios_limpios as (

    select
        id::integer as user_id,
        lower(trim("Occupation")) as ocupacion,
        "Active Since"::timestamp as activo_desde,

        row_number() over (
            partition by id
            order by index
        ) as numero_fila

    from {{ ref('usuarios') }}

    where id is not null
      and "Occupation" is not null
      and "Active Since" is not null

)

select
    user_id,
    ocupacion,
    activo_desde

from usuarios_limpios

where numero_fila = 1
  and ocupacion <> ''
