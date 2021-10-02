
CREATE DATABASE IF NOT EXISTS arthurElfos;
USE arthurElfos;

-- 1. Definición de tablas
CREATE TABLE IF NOT EXISTS departamentos (
   codigo                CHAR(3)     NOT NULL,
   nombre_departamento   VARCHAR(60) NOT NULL UNIQUE,
   NSS_completos		 CHAR(10)     					/* NSS_completos es el director del departamento, que ha de ser a Tiempo Completo.
														Su valor no es NOT NULL para que evitar que dé fallo por no existir departamento sin director.*/
);
/*  codigo: Tres dígitos, pues todos los ejemplos mostrados en el enunciado son de 3 dígitos.
	NSS_completos: Diez dígitos. De izquierda a derecha, dos corresponden a la provincia; 
   ocho, al número secuencial asignado al trabajador y las dos últimas son dígitos de control.
    suponemos que el NSS tiene 10 dígitos.
 */
CREATE TABLE IF NOT EXISTS trabajos ( 					/*clave primaria solo el elfo*/ 
   NSS_elfo             CHAR(10) NOT NULL UNIQUE, 		/*Gracias al NOT NULL UNIQUE, nos aseguramos que cada elfo vaya a trabajar en un único departamento */
   codigo_departamento  CHAR(3)  NOT NULL
);
CREATE TABLE IF NOT EXISTS elfos (
   NSS                  CHAR(10)         NOT NULL,
   nombre               VARCHAR(60)      NOT NULL,
   primer_apellido      VARCHAR(60)      NOT NULL,
   contratos            ENUM('TC', 'TP') NOT NULL
   /* TC hace referencia a los elfos que trabajan a Tiempo Completo.
      TP hace referencia a los elfos que trabajan a Tiempo Parcial. */
);
CREATE TABLE IF NOT EXISTS completos (
   NSS_elfo            CHAR(10) NOT NULL
);
CREATE TABLE IF NOT EXISTS parciales (
   NSS_elfo            CHAR(10) NOT NULL
);
CREATE TABLE IF NOT EXISTS tareas (
   item  	           VARCHAR(30) NOT NULL
);
CREATE TABLE IF NOT EXISTS agenda (
   NSS_parciales       CHAR(10)    NOT NULL,
   item 		       VARCHAR(30) NOT NULL
);
CREATE TABLE IF NOT EXISTS niños (
   ID                  INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
   nombre_niño         VARCHAR(60) NOT NULL,
   primer_apellido     VARCHAR(60) NOT NULL,
   coord_localizacion  POINT       NOT NULL SRID 4326,
   fecha_nacimiento    DATE        NOT NULL,
   NSS_elfo            CHAR(10)    NOT NULL
);

CREATE SPATIAL INDEX index_coord ON niños (coord_localizacion);

-- 2. Definición de claves primarias
ALTER TABLE departamentos
   ADD CONSTRAINT departamentosPK PRIMARY KEY (codigo);
ALTER TABLE trabajos
   ADD CONSTRAINT trabajosPK PRIMARY KEY (NSS_elfo, codigo_departamento);
ALTER TABLE elfos
   ADD CONSTRAINT elfosPK PRIMARY KEY (NSS);
ALTER TABLE completos
   ADD CONSTRAINT completosPK PRIMARY KEY (NSS_elfo);
ALTER TABLE parciales
   ADD CONSTRAINT parcialesPK PRIMARY KEY (NSS_elfo);
ALTER TABLE tareas
   ADD CONSTRAINT tareasPK PRIMARY KEY (item);
ALTER TABLE agenda
   ADD CONSTRAINT agendaPK PRIMARY KEY (NSS_parciales, item);
   
-- 3. Definición de claves ajenas
ALTER TABLE trabajos
   ADD CONSTRAINT trabajosFK1 FOREIGN KEY (NSS_elfo)
   REFERENCES elfos(NSS)
   ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE trabajos
   ADD CONSTRAINT trabajosFK2 FOREIGN KEY (codigo_departamento)
   REFERENCES departamentos(codigo)
   ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE completos
   ADD CONSTRAINT completosFK FOREIGN KEY (NSS_elfo)
   REFERENCES elfos(NSS)
   ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE parciales
   ADD CONSTRAINT parcialesFK FOREIGN KEY (NSS_elfo)
   REFERENCES elfos(NSS)
   ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE agenda
   ADD CONSTRAINT agendaFK1 FOREIGN KEY (NSS_parciales)
   REFERENCES parciales(NSS_elfo)
   ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE agenda
   ADD CONSTRAINT agendaFK2 FOREIGN KEY (item)
   REFERENCES tareas(item)
   ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE niños
   ADD CONSTRAINT niñosFK FOREIGN KEY (NSS_elfo)
   REFERENCES completos(NSS_elfo)
   ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE departamentos
	ADD CONSTRAINT departamentosFK FOREIGN KEY (NSS_completos)
    REFERENCES completos(NSS_elfo)
    ON DELETE RESTRICT ON UPDATE CASCADE;