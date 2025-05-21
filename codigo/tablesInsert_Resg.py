import pg8000
from faker import Faker
import random
from datetime import date
import string

# Conexión a la BD del microservicio de resguardos
conn = pg8000.connect(
    user="postgres",
    password="disahp",
    database="resguardoServicio_DISA",
    host="localhost",
    port=5432
)
cur = conn.cursor()
faker = Faker('es_MX')

# 🧠 Generador de folio aleatorio tipo RS-<3 letras><3 dígitos>
def generar_folio_resguardo():
    letras = ''.join(random.choices(string.ascii_uppercase, k=3))
    numeros = ''.join(random.choices(string.digits, k=3))
    return f"RS-{letras}{numeros}"

# Simulación de claves externas
empleados = list(range(1, 51))  # 50 empleados simulados
usuarios = list(range(1, 21))   # 20 usuarios simulados
equipos = [f"EQ{str(i).zfill(6)}" for i in range(1, 101)]  # 100 folios de equipo simulados

# Crear 30 resguardos falsos
N = 200
folios_usados = set()

for _ in range(N):
    folio_resguardo = generar_folio_resguardo()
    while folio_resguardo in folios_usados:
        folio_resguardo = generar_folio_resguardo()
    folios_usados.add(folio_resguardo)

    id_empleado = random.choice(empleados)
    id_usuario = random.choice(usuarios)

    # Insertar en tabla resguardo
    cur.execute("""
        INSERT INTO resguardo (folio_resguardo, id_empleado, id_usuario)
        VALUES (%s, %s, %s)
        RETURNING id_resguardo
    """, (folio_resguardo, id_empleado, id_usuario))
    id_resguardo = cur.fetchone()[0]

    # Agregar de 1 a 3 equipos al resguardo
    equipos_resguardados = random.sample(equipos, k=random.randint(1, 3))
    for folio_equipo in equipos_resguardados:
        cur.execute("""
            INSERT INTO resguardo_equipo (id_resguardo, folio_equipo)
            VALUES (%s, %s)
        """, (id_resguardo, folio_equipo))

        # Insertar también en historial con id_resguardo
        fecha_resguardo = faker.date_between(start_date='-1y', end_date='today')
        cur.execute("""
            INSERT INTO historial_resguardo (id_resguardo, folio_resguardo, fecha_resguardo, folio_equipo, id_empleado, id_usuario)
            VALUES (%s, %s, %s, %s, %s, %s)
        """, (id_resguardo, folio_resguardo, fecha_resguardo, folio_equipo, id_empleado, id_usuario))

# Confirmar y cerrar
conn.commit()
cur.close()
conn.close()

print("✅ ¡Datos simulados insertados con éxito en resguardos!")
