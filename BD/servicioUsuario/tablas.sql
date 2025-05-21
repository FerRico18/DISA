CREATE TABLE rol (
            id_rol SERIAL PRIMARY KEY,
            nombre VARCHAR(50) NOT NULL,
            permisos TEXT
        );

        CREATE TABLE usuario (
            id_usuario SERIAL PRIMARY KEY,
            nombre VARCHAR(100),
            a_paterno VARCHAR(100),
            a_materno VARCHAR(100),
            correo VARCHAR(100) UNIQUE NOT NULL,
            ultimo_login TIMESTAMP,
            password TEXT NOT NULL,
            id_empleado INT
        );

		ALTER TABLE usuario ADD COLUMN id_rol INT;

		ALTER TABLE usuario ADD FOREIGN KEY(id_rol)
			REFERENCES rol(id_rol);

SELECT * FROM rol;
SELECT * FROM usuario;

DELETE FROM usuario;
DELETE FROM rol;