CREATE TABLE resguardo (
            id_resguardo SERIAL PRIMARY KEY,
            folio_resguardo VARCHAR(100),
            id_empleado INT,
            id_usuario INT
        );

        CREATE TABLE resguardo_equipo (
            id_resguardo INT REFERENCES resguardo(id_resguardo),
            folio_equipo INT,
            PRIMARY KEY (id_resguardo, folio_equipo)
        );

        CREATE TABLE historial_resguardo (
            id_historial SERIAL PRIMARY KEY,
            folio_resguardo VARCHAR(100),
            fecha_resguardo DATE,
            folio_equipo INT,
            id_empleado INT,
            id_usuario INT
        );

		ALTER TABLE historial_resguardo ADD COLUMN id_resguardo INT;

		ALTER TABLE historial_resguardo ADD FOREIGN KEY(id_resguardo)
			REFERENCES resguardo(id_resguardo);

		ALTER TABLE resguardo_equipo ALTER folio_equipo TYPE VARCHAR(8);

		ALTER TABLE historial_resguardo ALTER folio_equipo TYPE VARCHAR(8);

		SELECT * FROM resguardo;
