CREATE TABLE inventario(
id_inventario int PRIMARY KEY,
estado_actual varchar(25),
fecha_resgurdo DATE,
fecha_fin DATE,
no_empleado int,
folio_equipo VARCHAR(10),
id_uni_admin int,
id_resguardo int,
FOREIGN KEY(id_resguardo) REFERENCES resguardo(id_resguardo),
FOREIGN KEY(folio_equipo) REFERENCES equipo(folio_equipo),
FOREIGN KEY(no_empleado) REFERENCES empleado(no_empleado),
FOREIGN KEY(id_uni_admin) REFERENCES unidad_admin(id_uni_admin)
);

ALTER TABLE equipo ADD COLUMN MAC_ETH varchar(17);

ALTER TABLE equipo ADD CONSTRAINT chk_maceth_equipo
    CHECK (
        MAC_ETH ~* '^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$'
    );

ALTER TABLE equipo DROP COLUMN estatus;

ALTER TABLE equipo ADD COLUMN estatus varchar(15);

ALTER TABLE equipo ADD CONSTRAINT chk_estatus_equipo CHECK(
estatus IN ('Baja definitiva', 'En STOCK', 'Asignado'));