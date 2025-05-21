import pg8000
from faker import Faker
import random
from datetime import timedelta
import string

# Configuración de conexión

faker = Faker()
conn = pg8000.connect(user="postgres", password="disahp", database="empleadoServicio_DISA", host="localhost", port=5432)
cur = conn.cursor()

# Número de registros a generar
N_EMPLEADOS = 50
N_PROYECTOS = 10
MOVIMIENTOS_POR_EMPLEADO = 3

# Generar folios random 
def generar_folio_equipo():
    letras = ''.join(random.choices(string.ascii_uppercase, k=2))  # AB
    numeros = ''.join(random.choices(string.digits, k=6))          # 123456
    return letras + numeros

# Generar proyectos
proyecto_ids = []
for _ in range(N_PROYECTOS):
    nombre = faker.bs().capitalize()
    fecha_inicio = faker.date_between(start_date='-2y', end_date='today')
    fecha_fin = fecha_inicio + timedelta(days=random.randint(30, 365))
    estatus = random.choice(['Activo', 'Inactivo', 'Finalizado'])
    descripcion = faker.text(max_nb_chars=100)

    cur.execute("""
        INSERT INTO proyecto (nombre, fecha_inicio, fecha_fin, estatus, descripcion, id_empleado)
        VALUES (%s, %s, %s, %s, %s, NULL)
        RETURNING id_proyecto
    """, (nombre, fecha_inicio, fecha_fin, estatus, descripcion))

    proyecto_ids.append(cur.fetchone()[0])

# Generar empleados
empleado_ids = []
for _ in range(N_EMPLEADOS):
    nombre = faker.first_name()
    a_paterno = faker.last_name()
    a_materno = faker.last_name()
    correo = faker.email()

    cur.execute("""
        INSERT INTO empleado (nombre, a_paterno, a_materno)
        VALUES (%s, %s, %s)
        RETURNING id_empleado
    """, (nombre, a_paterno, a_materno))

    empleado_ids.append(cur.fetchone()[0])

# Asignar empleados a proyectos (empleado_proyecto)
for id_emp in empleado_ids:
    proyectos_asignados = random.sample(proyecto_ids, k=random.randint(1, 3))
    for id_proj in proyectos_asignados:
        cur.execute("""
            INSERT INTO empleado_proyecto (id_empleado, id_proyecto)
            VALUES (%s, %s)
        """, (id_emp, id_proj))

for _ in range(MOVIMIENTOS_POR_EMPLEADO):
        fecha = faker.date_between(start_date='-1y', end_date='today')
        tipo = random.choice(['Activado', 'Baja', 'Cambio'])
        folio = generar_folio_equipo()
        descripcion = faker.sentence(nb_words=6)
        id_proj_random = random.choice(proyectos_asignados)

        cur.execute("""
            INSERT INTO movimiento (fecha_inicio, tipo, folio_equipo, descripcion, id_empleado, id_proyecto)
            VALUES (%s, %s, %s, %s, %s, %s)
        """, (fecha, tipo, folio, descripcion, id_emp, id_proj_random))


# Confirmar y cerrar
conn.commit()
cur.close()
conn.close()
print("¡Inserción completada con éxito! 🎉")
