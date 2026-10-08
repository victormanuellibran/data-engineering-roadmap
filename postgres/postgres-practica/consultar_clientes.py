import os
import psycopg
from dotenv import load_dotenv

load_dotenv()

conexion = psycopg.connect(
    host="127.0.0.1",
    port=5432,
    dbname=os.getenv("POSTGRES_DB"),
    user=os.getenv("POSTGRES_USER"),
    password=os.getenv("POSTGRES_PASSWORD")
)

cursor = conexion.cursor()

cursor.execute("SELECT * FROM clientes ORDER BY id;")

filas = cursor.fetchall()

for fila in filas:
    print(fila)

cursor.close()
conexion.close()
