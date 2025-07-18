CREATE TABLE categoria_equipo (
            id_categoria SERIAL PRIMARY KEY,
            nombre VARCHAR(100) NOT NULL,
            descripcion TEXT
        );

        CREATE TABLE tipo_equipo (
            id_tipo SERIAL PRIMARY KEY,
            nombre VARCHAR(100) NOT NULL,
            descripcion TEXT,
            id_categoria INT REFERENCES categoria_equipo(id_categoria)
        );

        CREATE TABLE modelo_equipo (
            id_modelo VARCHAR(20) PRIMARY KEY,
            nombre VARCHAR(100) NOT NULL,
            modelo VARCHAR(100),
            descripcion TEXT
        );

		ALTER TABLE modelo_equipo ADD COLUMN id_tipo INT
            REFERENCES tipo_equipo(id_tipo);

        CREATE TABLE unidad_admin (
            id_unidad SERIAL PRIMARY KEY,
            abreviatura VARCHAR(20),
            nombre VARCHAR(100),
            siglas VARCHAR(20),
            piso VARCHAR(10) NOT NULL DEFAULT 'N/A'
        );

        CREATE TABLE equipo (
            folio_equipo SERIAL PRIMARY KEY,
            numero_serie VARCHAR(100),
            procesador VARCHAR(100) NOT NULL DEFAULT 'N/A',
            ram VARCHAR(50) NOT NULL DEFAULT 'N/A',
			tarjeta_red VARCHAR(20) NOT NULL DEFAULT 'N/A',
            MAC_ETH VARCHAR(100) NOT NULL DEFAULT 'N/A',
            so_instalado VARCHAR(100) NOT NULL DEFAULT 'N/A',
			estatus VARCHAR(20),
            uso_actual VARCHAR(100),
            descripcion TEXT,
            id_tipo INT REFERENCES tipo_equipo(id_tipo),
            id_modelo VARCHAR(20) REFERENCES modelo_equipo(id_modelo)
        );

		ALTER TABLE equipo ADD CONSTRAINT chk_estatus_equipo CHECK(
			estatus IN('Disponible', 'En uso', 'Baja', 'Mantenimiento', 'Extraviado', 'Dañado')
		);

        CREATE TABLE inventario (
            id_inventario SERIAL PRIMARY KEY,
            estatus VARCHAR(50),
            fecha_ingreso DATE,
            fecha_modificacion DATE,
            id_empleado INT,
            folio_equipo INT REFERENCES equipo(folio_equipo)
        );

        CREATE TABLE movimiento (
            id_movimiento SERIAL PRIMARY KEY,
            fecha_inicio DATE,
            fecha_fin DATE,
            tipo VARCHAR(50),
            descripcion TEXT,
            folio_equipo INT REFERENCES equipo(folio_equipo),
            id_empleado INT,
            id_unidad_destino INT REFERENCES unidad_admin(id_unidad)
        );


		DROP TABLE movimiento;
		DROP TABLE inventario;
		DROP TABLE equipo;

		CREATE TABLE equipo (
            folio_equipo VARCHAR(8) PRIMARY KEY,
            numero_serie VARCHAR(100),
            procesador VARCHAR(100) NOT NULL DEFAULT 'N/A',
            ram VARCHAR(50) NOT NULL DEFAULT 'N/A',
			tarjeta_red VARCHAR(20) NOT NULL DEFAULT 'N/A',
            MAC_ETH VARCHAR(100) NOT NULL DEFAULT 'N/A',
            so_instalado VARCHAR(100) NOT NULL DEFAULT 'N/A',
			estatus VARCHAR(20),
            uso_actual VARCHAR(100),
            descripcion TEXT,
            id_tipo INT REFERENCES tipo_equipo(id_tipo),
            id_modelo VARCHAR(20) REFERENCES modelo_equipo(id_modelo)
        );

		ALTER TABLE equipo ADD COLUMN MAC VARCHAR(100) NOT NULL DEFAULT 'N/A';

		ALTER TABLE equipo ADD CONSTRAINT chk_estatus_equipo CHECK(
			estatus IN('Disponible', 'En uso', 'Baja', 'Mantenimiento', 'Extraviado', 'Dañado')
		);

		CREATE TABLE inventario (
            id_inventario SERIAL PRIMARY KEY,
            estatus VARCHAR(50),
            fecha_ingreso DATE,
            fecha_modificacion DATE,
            id_empleado INT,
            folio_equipo VARCHAR(8) REFERENCES equipo(folio_equipo)
        );

		CREATE TABLE movimiento (
            id_movimiento SERIAL PRIMARY KEY,
            fecha_inicio DATE,
            fecha_fin DATE,
            tipo VARCHAR(50),
            descripcion TEXT,
            folio_equipo VARCHAR(8) REFERENCES equipo(folio_equipo),
            id_empleado INT,
            id_unidad_destino INT REFERENCES unidad_admin(id_unidad)
        );


		INSERT INTO tipo_equipo (id_tipo, nombre)
			VALUES
  				(1, 'Laptop'),
  				(2, 'Escritorio'),
  				(3, 'Servidor'),
				(4, 'Tablet');

		INSERT INTO modelo_equipo (id_modelo, nombre) VALUES
			(1, 'Dell Optiplex 7070'),
			(2, 'HP ProDesk 400'),
			(3, 'Lenovo ThinkCentre M720'),
			(4, 'MacBook Pro 2021'),
			(5, 'Asus VivoBook 15');

		INSERT INTO unidad_admin (id_unidad, nombre) VALUES
			(1, 'Recursos Humanos'),
			(2, 'TI'),
			(3, 'Contabilidad'),
			(4, 'Dirección'),
			(5, 'Mantenimiento');


		

