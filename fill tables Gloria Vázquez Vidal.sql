-- 5. Insertar datos 

/* Por un lado, se han generado las tuplas relacionadas con el número de la Seguridad Social (NSS) de los elfos mediante un generador web de NSS de Estados Unidos (9 cifras).
La última cifra ha sido rellenada manualmente hasta lograr las 10 cifras.

Por otro lado, tanto los nombres (y apellidos) de los niños como los de los elfos también han sido generados mediante una aplicación web. Para separar el nombre y el primer
apellido (venían en bloque) de cada niño y de cada elfo, se ha utilizado un comando en Excel. De la misma forma, se han generado las coordenadas geográficas, que indican 
dónde vive cada niño, y la fecha de nacimiento de los mismos, atendiendo a la estructura YYYY-MM-DD.

Asimismo, el resto de números, como el código de departamento, o los nombres de departamentos o de tareas son inventadas.

Por último, seleccionamos los elfos a Tiempo Completo que serán los encargados de cada departamento.
*/

INSERT INTO departamentos (codigo, nombre_departamento) /*quitar NSS_Completos y los valores entre comillas referentes a NSS COMPLETOS ¿Con o sin comilas en el código dept? CON COMILLAS*/
VALUES
('123','Compras'),
('749','Envoltorios'),
('675','Repartos'),
('356','RRHH'),
('248','Diseño'),
('609','Marketing'),
('312','Montaje'),
('189','Música navideña'),
('456','Decoración navideña'),
('403','Limpieza');


INSERT INTO elfos (NSS, nombre, primer_apellido, contratos)
VALUES 
('5777006843', 'Nyla', 'Gould', 'TC'),
('1367348712', 'Wilfred', 'Alexander', 'TC'),
('3633130741', 'Ignacia', 'Lane', 'TC'),
('4335572070', 'Marybeth', 'Blackmore',	'TC'),
('1019664007', 'Carly',	'Hutchinson', 'TC'),
('5465216178', 'Pete', 'Dickson', 'TC'),
('4499184759', 'Korey',	'Mccarthy',	'TC'),
('2229427158', 'Dario',	'Drake', 'TC'),
('5469704876', 'Xochitl', 'Whiteley', 'TC'),
('2382638245', 'Dorine', 'Mangnall', 'TC'),
('5160629184', 'Roselyn', 'Colley',	'TC'),
('5857571126', 'Sheena', 'Boyd', 'TC'),
('5527836212', 'Evie', 'Booth',	'TC'),
('5402183817', 'Buffy',	'Naylor', 'TC'),
('4299228251', 'Dario',	'Drake', 'TC'),
('3299725253', 'Sharan', 'Parker', 'TP'),
('5559228321', 'Vern', 'Morrow', 'TP'),
('7899244202', 'Tarsha', 'Wilde', 'TP'),
('5188103654', 'Kimberlie',	'Hutton', 'TC'),
('2232279660', 'Jeannie', 'Whitfield', 'TC'),
('2232279333', 'Susana', 'Luna', 'TC');


INSERT INTO tareas (item)
VALUES
('Envolver regalos'),
('Montar juguetes Lego'),
('Poner lacitos'),
('Transportar regalos'),
('Comprar juguetes');


INSERT INTO agenda (NSS_parciales, item)
VALUES
('3299725253','Envolver regalos'),
('5559228321','Montar juguetes Lego'),
('7899244202','Poner lacitos'),
('7899244202','Transportar regalos'),
('5559228321','Comprar juguetes');


INSERT INTO niños (nombre_niño, primer_apellido, coord_localizacion, fecha_nacimiento, NSS_elfo)
VALUES
('Lilli', 'Fleming', ST_GeomFromText('POINT(77.2335 40.2229)', 4326), '2019-11-13', '1367348712'),
('Tarsha', 'Wiggins', ST_GeomFromText('POINT(76.1678 -53.3281)', 4326), '2019-11-15', '4335572070'),
('Leigh', 'Dawe', ST_GeomFromText('POINT(37.4431 57.0855)', 4326), '2017-06-07', '1019664007'),
('Arnulfo',	'Bray',	ST_GeomFromText('POINT(52.7758 -68.3384)', 4326), '2005-08-25', '5465216178'),
('Carola', 'Cole', ST_GeomFromText('POINT(84.0490 -14.4566)', 4326), '2011-03-25', '4499184759'),
('Mui',	'Heaton', ST_GeomFromText('POINT(69.5929 26.3603)', 4326),	'2006-02-20', '2229427158'),
('Ilona', 'Ready', ST_GeomFromText('POINT(42.9314 83.0338)', 4326), '2020-02-03', '5469704876'),
('Lavern', 'Lopez',	ST_GeomFromText('POINT(14.0439 51.0135)', 4326), '2019-11-21',	'2382638245'),
('Louis', 'Grimes',	ST_GeomFromText('POINT(69.7801 71.9902)', 4326), '2008-08-25', '5160629184'),
('Stephine', 'Searle', ST_GeomFromText('POINT(84.5923 59.5710)', 4326), '2019-11-23', '5857571126'),
('Felicitas', 'Dawe', ST_GeomFromText('POINT(0.3495 41.0256)', 4326), '2019-11-23', '5527836212'),
('Darrell',	'Robbins', ST_GeomFromText('POINT(51.4084 -52.1405)', 4326), '2019-11-23', '5402183817'),
('Dora', 'Laexploradora', ST_GeomFromText('POINT(59.7894 -10.5621)', 4326), '2010-10-01', '2232279333'),
('Sandra', 'Spencer', ST_GeomFromText('POINT(44.5006 0.6018)', 4326), '2006-08-06', '4299228251');



-- Definimos a continuación los elfos a Tiempo Completo que serán los encargados de cada departamento.

UPDATE departamentos
SET NSS_completos = '5777006843'
WHERE codigo = '123';

UPDATE departamentos
SET NSS_completos = '1367348712'
WHERE codigo = '749';

UPDATE departamentos
SET NSS_completos = '2382638245'
WHERE codigo = '675';

UPDATE departamentos
SET NSS_completos = '5465216178'
WHERE codigo = '356';

UPDATE departamentos
SET NSS_completos = '5402183817'
WHERE codigo = '248';

UPDATE departamentos
SET NSS_completos = '5188103654'
WHERE codigo = '609';

UPDATE departamentos
SET NSS_completos = '4299228251'
WHERE codigo = '312';

UPDATE departamentos
SET NSS_completos = '3633130741'
WHERE codigo = '189';

UPDATE departamentos
SET NSS_completos = '2229427158'
WHERE codigo = '456';

UPDATE departamentos
SET NSS_completos = '4499184759'
WHERE codigo = '403';