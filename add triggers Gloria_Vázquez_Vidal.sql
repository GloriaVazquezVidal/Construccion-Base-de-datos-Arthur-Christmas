-- 4. Definición de los disparadores

/* Trigger 1: Al contratar a un nuevo elfo, después de haber sido añadido a la tabla elfos, los añadimos también a una tabla, según Papá Noel ha decidido, entre dos posibles opcioness: completos y parciales,
según el tipo de contrato firmado: Tiempo Completo (TC) o Tiempo Parcial (TP). Al mismo tiempo, puesto que estos elfos van a trabajar para Papá Noel, los incluimos en la tabla trabajos
y se les asigna automáticamente el departamento que esté menos lleno (mediante su código de departamento). Solamente pertenecerá a un único departamento pues hemos definido que el límite sea 1. */

DELIMITER $$ 
CREATE TRIGGER insertBurocraciaContratacion AFTER INSERT ON elfos FOR EACH ROW
BEGIN
DECLARE departamento_menos_lleno CHAR(3);
SET departamento_menos_lleno := (SELECT codigo FROM departamentos LEFT JOIN trabajos ON codigo=codigo_departamento GROUP BY codigo ORDER BY COUNT(NSS_elfo) LIMIT 1); 
IF (NEW.contratos = 'TC')
		THEN INSERT INTO completos VALUE (NEW.NSS);
ELSE INSERT INTO parciales VALUE (NEW.NSS);
END IF;
INSERT INTO trabajos VALUE (NEW.NSS, departamento_menos_lleno);
END; $$
DELIMITER ;


/* Trigger 2: Si un elfo a Tiempo Completo (TC) quiere cambiar su tipo de contrato a Tiempo Parcial (TP), este trigger se asegurará de que existen más elfos que niños
para que otro elfo le pueda sustituir en su encomendada tarea: observar a su niño. Si no se cumple esto, entonces el trigger devolverá un mensaje en el que se indicará que
el cambio no está permitido. 
En el caso de que se desee cambiar de Tiempo Parcial (TP) a Tiempo Completo (TC), entonces se devolverá un mensaje de error, pues no está permitido.*/

DELIMITER $$
CREATE TRIGGER deleteinsertCambioContrato BEFORE UPDATE ON elfos FOR EACH ROW
BEGIN
DECLARE numero_niños INT;
DECLARE numero_elfosTC INT;
SET numero_niños := (SELECT COUNT(ID) FROM niños);
SET numero_elfosTC := (SELECT COUNT(NSS_elfo) FROM completos);
IF (NEW.contratos = 'TP' AND OLD.contratos = 'TC' AND (numero_elfosTC > numero_niños)) /* esta condición implica que hay elfos sin la obligación de vigilar un niño */
		THEN DELETE FROM completos;
			INSERT INTO parciales VALUE (NEW.NSS);
ELSE IF (numero_elfosTC = numero_niños)
		THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "El cambio no está permitido. Todos nuestros elfos están ocupados observando un niño.";
        END IF;
END IF;
IF (NEW.contratos = 'TC' AND OLD.contratos = 'TP')
		THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "El cambio no está permitido.";
END IF;
END; $$
DELIMITER ;


/* Trigger 3: Estudiamos si un elfo a Tiempo Completo podría dirigir un departamento concreto antes de ser añadido a la tabla departamentos.
Para ello, si este elfo pertenece a dicho departamento, entonces el trigger acaba instantáneamente. Sin embargo, si el elfo pertenece a otro departamento,
entonces el código de su departamento y el código del departamento que podría ser dirigido no coincidirían. En ese caso, este trigger nos arroja el
mensaje de que "Un departamento solo puede estar dirigido por alguien de ese departamento". */

DELIMITER $$
CREATE TRIGGER nuevoPosibleEncargadoDepartamento BEFORE UPDATE ON departamentos FOR EACH ROW
BEGIN
DECLARE departamento_posible_encargado CHAR(3);
IF (NEW.NSS_completos != OLD.NSS_completos)
		THEN SET departamento_posible_encargado := (SELECT codigo_departamento FROM trabajos WHERE NSS_elfo=NEW.NSS_completos);
			IF (departamento_posible_encargado != NEW.codigo)
				THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Un departamento solo puede estar dirigido por alguien de ese departamento.";
			END IF;
END IF;
END; $$
DELIMITER ;


/* Trigger 4: Con este trigger, aplicado antes de insertar en nuestra base de datos los datos de una persona, comprobamos
 si dicha persona es realmente un niño o un adulto, dado que solo los niños podrán ser observados*. Decidimos que una persona es un adulto a partir de los 18 años; por lo tanto, si se descubre que esta nueva persona tiene 18 años o más,
 se recibirá un mensaje de error, para avisar de que no podemos introducir a dicho adulto en nuestra base de datos. 
 
 
*Calculamos la edad actual de los niños utilizando su fecha de nacimiento y la fecha actual en cada momento.
Para ello, hacemos uso de CURDATE() y TIMESTAMDIFF(). Lo primero calcula la fecha actual y, lo segundo, la diferencia entre la fecha de nacimiento que se asigne
y la fecha actual. Según lo que surja de comparar entre las dos fechas, tendremos que restar un año para arreglar los errores que pueden surgir al calcular la 
edad solamente con el año. */

DELIMITER $$
CREATE TRIGGER niñoBeforeInsert BEFORE INSERT ON niños FOR EACH ROW
BEGIN
DECLARE edad INT;
    DECLARE mes INT;
    DECLARE dia INT;

    SET edad = TIMESTAMPDIFF(YEAR, NEW.fecha_nacimiento, CURDATE());
    SET mes = TIMESTAMPDIFF(MONTH, CURDATE(), NEW.fecha_nacimiento);
    SET dia = TIMESTAMPDIFF(DAY, CURDATE(), NEW.fecha_nacimiento);
   
	IF (mes > 0) THEN
		SET edad = edad - 1;
	ELSE 
		IF (dia > 0) THEN
			SET edad = edad - 1;
		END IF;
	END IF;
IF (edad >= 18)
	THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "El niño no puede ser mayor de edad.";
END IF;
END; $$
DELIMITER ;