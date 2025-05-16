select * from usuario;

ALTER TABLE usuario ADD no_empleado int;

ALTER TABLE usuario ADD CONSTRAINT no_empleado
FOREIGN KEY(no_empleado) REFERENCES empleado(no_empleado);

CREATE TABLE proyecto(
id_proyecto int PRIMARY KEY,
nombre VARCHAR(30) NOT NULL,
fecha_inicio DATE NOT NULL,
fecha_fin DATE NOT NULL,
estatus VARCHAR(10) NULL CONSTRAINT chk_estatus_proy CHECK(estatus IN(
'activo', 'inactivo', 'finalizado')),
no_empleado int,
FOREIGN KEY(no_empleado) REFERENCES empleado(no_empleado)
);





