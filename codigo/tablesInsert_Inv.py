import pg8000
from faker import Faker
import random
import string
from datetime import date, timedelta

# Conexión a la base de datos del microservicio de inventario
conn = pg8000.connect(
    user="postgres",
    password="disahp",
    database="inventarioServicio_DISA",
    host="localhost",
    port=5432
)
cur = conn.cursor()
faker = Faker('es_MX')

# Simulación de claves externas
empleados = list(range(1, 51))  # IDs simulados de empleados
tipos = list(range(1, 5))       # IDs de tipo_equipo simulados
categorias = list(range(1, 4))  # IDs de categoria_equipo simulados
unidades = list(range(1, 6))    # IDs de unidad_admin simulados

# 🧠 Generador de folio único para equipo
def generar_folio_equipo():
    letras = ''.join(random.choices(string.ascii_uppercase, k=2))
    numeros = ''.join(random.choices(string.digits, k=6))
    return f"{letras}{numeros}"

# Registro de folios usados para evitar duplicados
folios_usados = set()

# 🧠 Generador de folio único para equipo
def generar_modelo_equipo():
    letras = ''.join(random.choices(string.ascii_uppercase, k=5))
    numeros = ''.join(random.choices(string.digits, k=8))
    return f"{letras}{numeros}"

# Registro de folios usados para evitar duplicados
modelos_usados = set()

# Cantidad de equipos a insertar
N = 300

for _ in range(N):
    folio = generar_folio_equipo()
    while folio in folios_usados:
        folio = generar_folio_equipo()
    folios_usados.add(folio)

    cur.execute("SELECT id_modelo FROM modelo_equipo")
    modelos = [row[0] for row in cur.fetchall()]
    id_modelo = random.choice(modelos)


    procesador = random.choice(["Intel i5", "Intel i7", "AMD Ryzen 5", "AMD Ryzen 7"])
    ram = random.choice(["8GB", "16GB", "32GB"])
    mac_eth = faker.mac_address()
    so_instalado = random.choice(["Windows 10", "Windows 11", "Ubuntu 22.04"])
    uso_actual = random.choice(["Operativo", "En pruebas", "Almacenado"])
    descripcion = faker.sentence()
    id_tipo = random.choice(tipos)

    # Insertar equipo
    cur.execute("""
        INSERT INTO equipo (folio_equipo, numero_serie, procesador, ram, MAC_ETH, so_instalado, uso_actual, descripcion, id_modelo, id_tipo)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    """, (folio, faker.uuid4(), procesador, ram, mac_eth, so_instalado, uso_actual, descripcion, id_modelo, id_tipo))

    # Insertar inventario relacionado
    fecha_ingreso = faker.date_between(start_date='-2y', end_date='-1y')
    fecha_modificacion = fecha_ingreso + timedelta(days=random.randint(30, 365))
    estatus = random.choice(["Disponible", "En uso", "Mantenimiento", "Baja", 'Extraviado', 'Dañado'])
    id_empleado = random.choice(empleados)

    cur.execute("""
        INSERT INTO inventario (folio_equipo, fecha_ingreso, fecha_modificacion, estatus, id_empleado)
        VALUES (%s, %s, %s, %s, %s)
    """, (folio, fecha_ingreso, fecha_modificacion, estatus, id_empleado))

    # Insertar movimiento del equipo
    fecha_inicio = fecha_ingreso
    fecha_fin = fecha_inicio + timedelta(days=random.randint(5, 120))
    tipo_mov = random.choice(["Cambio de ubicación", "Mantenimiento", "Reasignación"])
    id_unidad = random.choice(unidades)
    descripcion_mov = faker.sentence()

    cur.execute("""
        INSERT INTO movimiento (fecha_inicio, fecha_fin, tipo, descripcion, folio_equipo, id_empleado, id_unidad_destino)
        VALUES (%s, %s, %s, %s, %s, %s, %s)
    """, (fecha_inicio, fecha_fin, tipo_mov, descripcion_mov, folio, id_empleado, id_unidad))

# Finalizar
conn.commit()
cur.close()
conn.close()

print("✅ ¡Datos simulados insertados con éxito en el microservicio de inventario!")
