-- Ejemplo 1. Trigger 1: Los elfos son asignados a las tablas parciales o completos según Papá Noel haya decidido. Del mismo modo, los nuevos elfos son añadidos a la tabla trabajos (Trigger 1).
-- Con las siguientes consultas comprobamos que todos los elfos han sido asignados correctamente, siguiendo que ha de cumplirse que:
-- numero_elfos = numero_parciales + numero_completos
-- numero_elfos = numero_trabajadores

SELECT COUNT(NSS_elfo) AS numero_parciales FROM parciales; /* 3 elfos a Tiempo Parcial */
SELECT COUNT(NSS_elfo) AS numero_completos FROM completos; /* 17 elfos a Tiempo Completo */
SELECT COUNT(NSS) AS numero_elfos FROM elfos; /* 20 elfos totales en elfos*/
SELECT COUNT(NSS_elfo) AS numero_trabajadores FROM trabajos; /* 20 elfos totales en trabajos */

-- Ejemplo 2. Trigger 2: Los elfos a Tiempo Parcial no pueden cambiar su tipo de contrato a Tiempo Completo. Si se intenta, saldrá el mensaje "El cambio no está permitido".
UPDATE elfos
SET contratos = 'TC'
WHERE NSS = '7899244202';

-- Ejemplo 3. Trigger 3: Un elfo que pertenece a un departamento no puede dirigir otro departamento. Solamente puede dirigir el departamento al cual pertenece.
-- En caso de intentarse, devolverá el mensaje: "Un departamento solo puede estar dirigido por alguien de ese departamento".
UPDATE departamentos
SET NSS_completos = '2229427158'
WHERE codigo = '123';

-- Ejemplo 4a. Trigger 4: Los datos de "niños" mayores de edad no pueden ser introducidos en la base de datos. Se devuelve el mensaje "El niño no puede ser mayor de edad".
INSERT INTO niños (nombre_niño, primer_apellido, coord_localizacion, fecha_nacimiento, NSS_elfo)
VALUES
('Keena', 'Gilmour', ST_GeomFromText('POINT(65.1666 -54.6504)', 4326), '2000-03-18', '3633130741');

-- Ejemplo 4b. Trigger 4: Los datos de "niños" mayores de edad no pueden ser introducidos en la base de datos. "El niño no puede ser mayor de edad".
INSERT INTO niños (nombre_niño, primer_apellido, coord_localizacion, fecha_nacimiento, NSS_elfo)
VALUES
('Antione',	'Bloom', ST_GeomFromText('POINT(26.0854 66.2180)', 4326), '1996-10-24', '5777006843');