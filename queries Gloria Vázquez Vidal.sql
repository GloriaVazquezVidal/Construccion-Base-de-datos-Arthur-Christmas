-- 6. Consultas
        
# 1. Datos completos de los elfos contratados a Tiempo Parcial que realizan al menos dos tareas.
SELECT * 
        FROM elfos
        WHERE NSS IN (
            SELECT NSS_parciales
            FROM agenda
            GROUP BY NSS_parciales
            HAVING COUNT(item) >= 2
        );

# 2. Datos completos de los elfos que dirigen un departamento con número impar, con su nombre y código de departamento (impar) asignado.
SELECT NSS, nombre, primer_apellido, contratos, codigo_departamento, nombre_departamento 
	FROM elfos JOIN trabajos ON NSS = NSS_elfo JOIN departamentos ON codigo_departamento = codigo
    WHERE NSS IN (
		SELECT NSS_completos
        FROM departamentos 
        WHERE codigo LIKE '%1' OR codigo LIKE '%3' OR codigo LIKE '%5' OR codigo LIKE '%7' OR codigo LIKE '%9'
        );
    
# 3. Número de niños cuya fecha de nacimiento es la misma.
SELECT fecha_nacimiento, COUNT(ID) AS numero
	FROM niños
    GROUP BY fecha_nacimiento
    HAVING numero >= 2;

# 4. Datos completos de los elfos a Tiempo Parcial que montan juguetes de Lego en algún departamento, y revelar el nombre de dicho departamento.
SELECT NSS_parciales, nombre, primer_apellido, item, codigo_departamento, nombre_departamento
	FROM (elfos AS e INNER JOIN agenda ON e.NSS = agenda.NSS_parciales) INNER JOIN
		trabajos AS t ON t.NSS_elfo = agenda.NSS_parciales INNER JOIN departamentos AS d ON d.codigo = t.codigo_departamento
        WHERE agenda.item LIKE 'Montar juguetes Lego%';

# 5. Niños (posiciones) que se encuentran a una distancia del origen igual o inferior que 7500000.
SET @origenUsuario_G = ST_GeomFromText('POINT(0 0)', 4326);
SELECT ID, nombre_niño, ST_AsText(coord_localizacion) AS coord_localizacion, ST_Distance_Sphere(coord_localizacion, @origenUsuario_G) AS distancia
FROM niños
WHERE ST_Distance_Sphere(coord_localizacion, @origenUsuario_G) <= 7500000;
        
# 6. Código y nombre de los departamentos a los que pertenecen al menos dos elfos contratados a Tiempo Completo.
SELECT d.codigo, d.nombre_departamento FROM departamentos AS d
INNER JOIN trabajos AS t ON t.codigo_departamento = d.codigo
INNER JOIN elfos AS e ON e.NSS = t.NSS_elfo
WHERE contratos = 'TC'
GROUP BY d.codigo
HAVING COUNT(t.NSS_elfo) >= 2;

# 7. Número de elfos que trabajan en cada departamento, con su nombre y su código de departamento.
SELECT nombre_departamento, codigo, COUNT(NSS_elfo)
FROM departamentos LEFT JOIN trabajos ON codigo=codigo_departamento
GROUP BY codigo
ORDER BY COUNT(NSS_elfo);
