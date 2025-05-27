SELECT
    e.folio_equipo AS "Folio",
	CONCAT(e.numero_serie, e.procesador, e.ram, e.so_instalado) AS "Perfil Equipo",
    i.estatus,
    i.fecha_ingreso,
    i.fecha_modificacion,
    emp.id_empleado,
    emp.nombre || ' ' || emp.a_paterno || ' ' || emp.a_materno AS "Responsable"
FROM inventario i
JOIN equipo e ON i.folio = e.folio_remoto
LEFT JOIN empleado emp ON i.id_empleado = emp.id_empleado
ORDER BY i.fecha_ingreso DESC;

SELECT
    e.folio_equipo,
    e.procesador,
    i.estatus,
    i.fecha_modificacion
FROM inventario i
JOIN equipo e ON i.folio_equipo = e.folio_equipo
WHERE i.estatus = 'Mantenimiento';

SELECT
    m.folio_equipo,
    m.tipo AS tipo_movimiento,
    m.fecha_inicio,
    m.fecha_fin,
    m.descripcion,
    u.nombre AS unidad_destino
FROM movimiento m
JOIN unidad_admin u ON m.id_unidad_destino = u.id_unidad
ORDER BY m.fecha_inicio DESC
LIMIT 50;

SELECT
    t.nombre AS tipo_equipo,
    COUNT(*) AS total
FROM equipo e
JOIN tipo_equipo t ON e.id_tipo = t.id_tipo
GROUP BY t.nombre;

SELECT
    e.folio_equipo,
    e.numero_serie,
    m.fecha_inicio,
    m.descripcion,
    u.nombre AS unidad
FROM movimiento m
JOIN equipo e ON m.folio_equipo = e.folio_equipo
JOIN unidad_admin u ON m.id_unidad_destino = u.id_unidad
WHERE u.nombre = 'TI';

SELECT
    e.folio_remoto,
    e.so_instalado,
    i.fecha_ingreso
FROM inventario i
JOIN equipo e ON i.folio = e.folio_remoto
WHERE i.fecha_ingreso BETWEEN '2024-01-01' AND '2024-12-31';

SELECT
    estatus,
    COUNT(*) AS cantidad
FROM inventario
GROUP BY estatus;