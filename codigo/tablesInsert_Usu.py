import pg8000
from faker import Faker
import random
import hashlib

# Configuración de conexión

faker = Faker()
conn = pg8000.connect(user="postgres", password="disahp", database="usuarioServicio_DISA", host="localhost", port=5432)
cur = conn.cursor()

# Número de registros a generar
N_USUARIOS = 50

# Generar tabla ROL
roles = [
    {"nombre": "admin", "permisos": "usuarios:crud,equipos:crud,resguardos:crud"},
    {"nombre": "responsable_ua", "permisos": "equipos:read,resguardos:create"},
    {"nombre": "tecnico", "permisos": "tickets:read,tickets:update"},
    {"nombre": "consultor", "permisos": "equipos:read"},
    {"nombre": "usuario", "permisos": "equipos:read_own,tickets:create"}
]

for rol in roles:
    cur.execute("""
        INSERT INTO rol (nombre, permisos)
        VALUES (%s, %s)
    """, (rol["nombre"], rol["permisos"]))


faker = Faker('es_MX')

for _ in range(N_USUARIOS):
    nombre = faker.first_name()
    a_paterno = faker.last_name()
    a_materno = faker.last_name()
    correo = faker.email()
    password = hashlib.sha256("1234".encode()).hexdigest()  # hash simple de prueba

    cur.execute("SELECT id_rol FROM rol")
    id_roles = [row[0] for row in cur.fetchall()]
    id_rol = random.choice(id_roles)  # suponiendo 5 roles

    cur.execute("""
        INSERT INTO usuario (nombre, a_paterno, a_materno, correo, password, id_rol)
        VALUES (%s, %s, %s, %s, %s, %s)
    """, (nombre, a_paterno, a_materno, correo, password, id_rol))


# Confirmar y cerrar
conn.commit()
cur.close()
conn.close()
print("¡Inserción completada con éxito! 🎉")
