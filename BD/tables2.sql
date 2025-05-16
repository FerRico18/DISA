CREATE TABLE modelo_equipo(
id_modelo int PRIMARY KEY,
marca varchar(15) NOT NULL,
modelo varchar(10) NOT NULL,
descripcion varchar(30));


CREATE TABLE equipo(
folio_equipo VARCHAR(10) PRIMARY KEY UNIQUE,
hostname varchar(10) UNIQUE,
perfil varchar(25) NOT NULL,
MAC VARCHAR(17) NOT NULL,
    CHECK (
        MAC ~* '^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$'
    ),
no_serie varchar(15) NOT NULL,
modelo varchar(10) NOT NULL,
descripcion varchar(30),
estatus VARCHAR(10) NULL CONSTRAINT chk_estatus_equipo CHECK(estatus IN(
'STOCK', 'resguardo', 'reparación', 'inactivo')),
id_tipo int,
id_modelo int,
FOREIGN KEY(id_tipo) REFERENCES tipo_equipo(id_tipo),
FOREIGN KEY(id_modelo) REFERENCES modelo_equipo(id_modelo)
);

CREATE TABLE resguardo(
id_resguardo int PRIMARY KEY,
feha_resguardo DATE NOT NULL,
estatus varchar(10),
no_empleado int,
id_uni_admin int,
FOREIGN KEY(no_empleado) REFERENCES empleado(no_empleado),
FOREIGN KEY(id_uni_admin) REFERENCES unidad_admin(id_uni_admin)
);

CREATE TABLE resguardo_equipo(
id_resguardo int,
folio_equipo VARCHAR(10),
FOREIGN KEY(id_resguardo) REFERENCES resguardo(id_resguardo),
FOREIGN KEY(folio_equipo) REFERENCES equipo(folio_equipo)
);

CREATE TABLE movimiento(
id_movimiento int PRIMARY KEY,
fecha_inicio DATE NOT NULL,
fecha_fin DATE NOT NULL,
tipo VARCHAR(10) NULL CONSTRAINT chk_tipo_mov CHECK(tipo IN(
'Alta', 'Baja', 'Incidencia')),
descripcion VARCHAR(30),
folio_equipo VARCHAR(10),
no_empleado int,
id_proyecto int,
FOREIGN KEY(folio_equipo) REFERENCES equipo(folio_equipo),
FOREIGN KEY(no_empleado) REFERENCES empleado(no_empleado),
FOREIGN KEY(id_proyecto) REFERENCES proyecto(id_proyecto)
);

CREATE TABLE empleado_proyecto(
no_empleado int,
id_proyecto int,
FOREIGN KEY(no_empleado) REFERENCES empleado(no_empleado),
FOREIGN KEY(id_proyecto) REFERENCES proyecto(id_proyecto)
);

CREATE TABLE inventario(
id_inventario int PRIMARY KEY,
estado_actual varchar(25),

)