# Proyecto de Data Engineering - Películas con dbt

Proyecto realizado con PostgreSQL, dbt Core y dbt-postgres para limpiar, transformar y analizar un dataset de películas, usuarios y calificaciones.

## Arquitectura

El proyecto sigue la arquitectura:

**RAW / SEEDS → STAGING → INTERMEDIATE → MARTS**

## Datos originales

Se utilizan tres datasets:

- `peliculas.csv`
- `usuarios.csv`
- `scores.csv`

Registros originales:

- 1344 películas
- 377 usuarios
- 25000 calificaciones

## Staging

La capa staging limpia y valida los datos originales.

Modelos:

- `stg_peliculas`
- `stg_usuarios`
- `stg_scores`
- `stg_generos`
- `stg_pelicula_genero`

En esta capa se realizan:

- eliminación de columnas técnicas como `index` y `Unnamed: 0`;
- eliminación de registros inválidos;
- control de valores nulos;
- eliminación de duplicados;
- casteo de fechas y timestamps;
- validación de ratings entre 1 y 5;
- validación de relaciones entre usuarios y películas;
- validación de que un rating no sea anterior al estreno de una película;
- normalización de géneros.

Después de la limpieza quedaron:

- 1343 películas
- 377 usuarios
- 24940 scores válidos

Se descartó la película `id = 267`, cuyo nombre era `unknown` y no poseía fecha de estreno.

También fueron descartados:

- 6 scores asociados a esa película;
- 54 scores cuya fecha de calificación era anterior al estreno.

## Normalización

Los géneros originalmente estaban almacenados como columnas:

`Action`, `Comedy`, `Drama`, `Horror`, `Sci-Fi`, etc.

Para mejorar el modelo relacional se crearon:

- `stg_peliculas`
- `stg_generos`
- `stg_pelicula_genero`

De esta manera se representa la relación muchos-a-muchos entre películas y géneros de forma normalizada.

## Intermediate

La capa intermediate utiliza los datos ya limpios para generar cálculos reutilizables.

Modelos:

- `int_metricas_peliculas`
- `int_metricas_usuarios`
- `int_metricas_profesiones`
- `int_metricas_generos`

Estos modelos se materializan como vistas.

## Marts

La capa marts contiene resultados finales orientados al análisis y al valor de negocio.

Modelos:

- `mart_ranking_peliculas`
- `mart_peliculas_mas_votadas`
- `mart_metricas_generos`
- `mart_metricas_profesiones`

Estos modelos se materializan como tablas físicas.

## Calidad de datos

Se implementaron tests de dbt para validar:

- valores no nulos;
- identificadores únicos;
- ratings entre 1 y 5;
- integridad referencial;
- existencia de usuarios y películas;
- relaciones válidas entre películas y géneros;
- ausencia de relaciones película-género duplicadas;
- fechas de ratings posteriores o iguales al estreno.

Resultado de los tests:

`PASS=24 WARN=0 ERROR=0`

## Ejecución completa

Para construir y validar todo el proyecto:

```bash
dbt build
```

Último resultado:

- 3 seeds
- 13 modelos
- 24 tests

`PASS=40 WARN=0 ERROR=0`

## Estructura

```text
peliculas_dbt/
├── seeds/
├── models/
│   ├── staging/
│   ├── intermediate/
│   └── marts/
├── tests/
├── legacy_sql/
├── dbt_project.yml
└── requirements-dbt.txt
```

La carpeta `legacy_sql` contiene los modelos de la primera versión del proyecto y no forma parte del DAG activo de dbt.

## Tecnologías utilizadas

- PostgreSQL
- dbt Core
- dbt-postgres
- Docker
- Git
- GitHub
