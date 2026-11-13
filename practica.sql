create database instituto_academico;

use instituto_academico;

CREATE TABLE programas (
    programa_id INT AUTO_INCREMENT PRIMARY KEY, 
    nombre VARCHAR(100) NOT NULL,               
    nivel VARCHAR(50) NOT NULL,                 
    duracion_semestres INT NOT NULL             
);

CREATE TABLE docentes (
    docente_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,       
    especialidad VARCHAR(100) NOT NULL
);

CREATE TABLE estudiantes (
    estudiante_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    fecha_nacimiento DATE NOT NULL,             
    estado VARCHAR(20) NOT NULL DEFAULT 'activo' 
);

-- cursos relacionados con programa id y docente id

CREATE TABLE cursos (
    curso_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    creditos INT NOT NULL,
    programa_id INT NOT NULL,
    docente_id INT NOT NULL,
    FOREIGN KEY (programa_id) REFERENCES programas(programa_id),
    FOREIGN KEY (docente_id) REFERENCES docentes(docente_id)
);

-- matriculas relacionado con estudiante id y curso id

CREATE TABLE matriculas (
    matricula_id INT AUTO_INCREMENT PRIMARY KEY,
    estudiante_id INT NOT NULL,
    curso_id INT NOT NULL,
    fecha_matricula DATE NOT NULL,
    estado VARCHAR(20) NOT NULL DEFAULT 'activa', 
    nota_final DECIMAL(3,1) NULL,
    FOREIGN KEY (estudiante_id) REFERENCES estudiantes(estudiante_id),
    FOREIGN KEY (curso_id) REFERENCES cursos(curso_id),
    UNIQUE (estudiante_id, curso_id)
);

INSERT INTO programas (nombre, nivel, duracion_semestres) VALUES
('Desarrollo de Software', 'Tecnico', 4),
('Analisis de Datos', 'Tecnologico', 6),
('Gestion Administrativa', 'Tecnico', 4);

INSERT INTO docentes (nombre, correo, especialidad) VALUES
('Jane Doe', 'Janedoe@instituto.edu', 'Programacion Web'),
('Laura Gomez', 'lgomez@instituto.edu', 'Bases de Datos'),
('Andres Silva', 'asilva@instituto.edu', 'Estadistica y BI'),
('Marta Rojas', 'mrojas@instituto.edu', 'Administracion');

INSERT INTO estudiantes (nombre, correo, fecha_nacimiento, estado) VALUES
('Ana Torres', 'ana.torres@correo.com', '2003-05-14', 'activo'),
('Luis Perez', 'luis.perez@correo.com', '2002-11-20', 'activo'),
('Sofia Ramirez', 'sofia.ramirez@correo.com', '2004-02-08', 'activo'),
('Mateo Castro', 'mateo.castro@correo.com', '2001-09-30', 'activo'),
('Valeria Ortiz', 'valeria.ortiz@correo.com', '2003-07-19', 'inactivo'),
('Diego Vargas', 'diego.vargas@correo.com', '2002-04-12', 'activo'),
('Camila Herrera', 'camila.herrera@correo.com', '2004-12-01', 'inactivo'),
('Julian Morales', 'julian.morales@correo.com', '2003-01-25', 'activo');

INSERT INTO cursos (nombre, creditos, programa_id, docente_id) VALUES
('Logica de Programacion', 4, 1, 1),
('Bases de Datos MySQL', 4, 1, 2),
('Python para Datos', 3, 2, 3),
('Visualizacion de Datos', 3, 2, 3),
('Contabilidad Basica', 2, 3, 4),
('Gestion de Proyectos', 3, 3, 4);

INSERT INTO matriculas (estudiante_id, curso_id, fecha_matricula, estado, nota_final) VALUES
(1, 1, '2026-02-01', 'finalizada', 4.5),
(1, 2, '2026-02-02', 'activa', NULL),
(2, 1, '2026-02-01', 'finalizada', 3.8),
(2, 2, '2026-02-03', 'activa', NULL),
(2, 3, '2026-02-05', 'retirada', 1.5),
(3, 2, '2026-02-02', 'finalizada', 4.8),
(3, 3, '2026-02-04', 'finalizada', 4.2),
(4, 1, '2026-02-03', 'finalizada', 2.9),
(4, 4, '2026-02-06', 'activa', NULL),
(5, 5, '2026-02-04', 'retirada', 0.0),
(6, 3, '2026-02-05', 'finalizada', 3.6),
(6, 4, '2026-02-07', 'finalizada', 4.0);


-- actividad 8

SELECT * FROM matriculas WHERE matricula_id = 4;

UPDATE matriculas
SET estado = 'retirada'
WHERE matricula_id = 4;

SELECT * FROM docentes WHERE docente_id = 4;

UPDATE docentes
SET especialidad = 'Gestion Empresarial'
WHERE docente_id = 4;

-- actividad 9

SELECT * FROM matriculas WHERE matricula_id = 2 AND nota_final IS NULL;

UPDATE matriculas
SET nota_final = 4.3
WHERE matricula_id = 2;

SHOW TABLES;

DESCRIBE programas;
DESCRIBE docentes;
DESCRIBE estudiantes;
DESCRIBE cursos;
DESCRIBE matriculas;


-- consultas actividad 7

SELECT * FROM programas;
SELECT * FROM docentes;
SELECT * FROM estudiantes;
SELECT * FROM cursos;
SELECT * FROM matriculas;


--  actividad 10

INSERT INTO programas (nombre, nivel, duracion_semestres)
VALUES ('Prueba', 'Tecnico', 2);

DELETE FROM programas
WHERE nombre = 'Prueba';
SELECT * FROM programas WHERE nombre = 'Prueba';


-- consultas de 11 a 20 en orden 

SELECT *FROM estudiantes
ORDER BY nombre ASC;

SELECT *FROM estudiantes
WHERE estado = 'activo' AND nombre LIKE 'A%';

SELECT *
FROM cursos
WHERE creditos >= 3
ORDER BY creditos DESC;


SELECT *
FROM matriculas
WHERE fecha_matricula BETWEEN '2026-02-01' AND '2026-02-04';

-- apartir de aqui se usaran abreviaturas C para cursos, P para programas, E para estudiantes
-- D para docentes y M para matriculas

SELECT c.nombre AS curso, p.nombre AS programa
FROM cursos AS c
INNER JOIN programas AS p ON c.programa_id = p.programa_id;

SELECT c.nombre AS curso, d.nombre AS docente, d.correo AS correo_docente
FROM cursos AS c
INNER JOIN docentes AS d ON c.docente_id = d.docente_id;

SELECT e.nombre AS estudiante, c.nombre AS curso, m.fecha_matricula, m.estado
FROM matriculas AS m
INNER JOIN estudiantes AS e ON m.estudiante_id = e.estudiante_id
INNER JOIN cursos AS c ON m.curso_id = c.curso_id
ORDER BY e.nombre, c.nombre;

SELECT e.nombre AS estudiante, c.nombre AS curso, m.nota_final
FROM matriculas AS m
INNER JOIN estudiantes AS e ON m.estudiante_id = e.estudiante_id
INNER JOIN cursos AS c ON m.curso_id = c.curso_id
WHERE m.nota_final IS NOT NULL;

SELECT e.nombre AS estudiante, m.matricula_id, m.fecha_matricula, m.estado
FROM estudiantes AS e
LEFT JOIN matriculas AS m ON e.estudiante_id = m.estudiante_id
ORDER BY e.nombre;

SELECT c.curso_id, c.nombre AS curso
FROM cursos AS c
LEFT JOIN matriculas AS m ON c.curso_id = m.curso_id
WHERE m.matricula_id IS NULL;

-- consultas de 21 a 28

USE instituto_academico;

SELECT estado, COUNT(*) AS total_estudiantes
FROM estudiantes
GROUP BY estado;

SELECT c.nombre AS curso, COUNT(m.matricula_id) AS total_matriculas
FROM cursos AS c
LEFT JOIN matriculas AS m ON c.curso_id = m.curso_id
GROUP BY c.curso_id, c.nombre;

SELECT c.nombre AS curso, AVG(m.nota_final) AS promedio_nota
FROM cursos AS c
INNER JOIN matriculas AS m ON c.curso_id = m.curso_id
GROUP BY c.curso_id, c.nombre;

SELECT c.nombre AS curso, AVG(m.nota_final) AS promedio_nota
FROM cursos AS c
INNER JOIN matriculas AS m ON c.curso_id = m.curso_id
GROUP BY c.curso_id, c.nombre
HAVING AVG(m.nota_final) >= 3.5;

SELECT p.nombre AS programa, COUNT(DISTINCT m.estudiante_id) AS estudiantes_distintos
FROM programas AS p
LEFT JOIN cursos AS c ON p.programa_id = c.programa_id
LEFT JOIN matriculas AS m ON c.curso_id = m.curso_id
GROUP BY p.programa_id, p.nombre;

SELECT estudiante_id, nombre, correo
FROM estudiantes
WHERE estudiante_id IN (
    SELECT estudiante_id
    FROM matriculas
);



-- 32 Revisar el plan de ejecucion de una busqueda por correo
EXPLAIN
SELECT *
FROM estudiantes
WHERE correo = 'ana.torres@correo.com';

-- actividades 33 y 34Comprobar las restricciones de integridad sin dejar errores

DROP PROCEDURE IF EXISTS verificar_integridad;
DELIMITER $$
CREATE PROCEDURE verificar_integridad()
BEGIN
    DECLARE error_borrado BOOLEAN DEFAULT FALSE;
    DECLARE error_fk BOOLEAN DEFAULT FALSE;
    DECLARE error_duplicado BOOLEAN DEFAULT FALSE;

    DECLARE CONTINUE HANDLER FOR 1451 SET error_borrado = TRUE;
    DECLARE CONTINUE HANDLER FOR 1452 SET error_fk = TRUE;
    DECLARE CONTINUE HANDLER FOR 1062 SET error_duplicado = TRUE;

    -- Prueba A
    DELETE FROM programas WHERE programa_id = 1;
    IF error_borrado THEN
        SELECT 'Correcto: la clave foranea impide borrar un programa con cursos asociados.' AS resultado;
    ELSE
        SELECT 'Revisar: se esperaba que la clave foranea impidiera el borrado.' AS resultado;
    END IF;

    -- Prueba B
    SET error_fk = FALSE;
    INSERT INTO matriculas
        (estudiante_id, curso_id, fecha_matricula, estado, nota_final)
    VALUES
        (99999, 1, CURDATE(), 'activa', NULL);
    IF error_fk THEN
        SELECT 'Correcto: no se permite matricular a un estudiante inexistente.' AS resultado;
    ELSE
        SELECT 'Revisar: se esperaba un error por estudiante inexistente.' AS resultado;
    END IF;

    -- Prueba C
    SET error_fk = FALSE;
    INSERT INTO matriculas
        (estudiante_id, curso_id, fecha_matricula, estado, nota_final)
    VALUES
        (1, 99999, CURDATE(), 'activa', NULL);
    IF error_fk THEN
        SELECT 'Correcto: no se permite matricular en un curso inexistente.' AS resultado;
    ELSE
        SELECT 'Revisar: se esperaba un error por curso inexistente.' AS resultado;
    END IF;

    -- Prueba D
    SET error_duplicado = FALSE;
    INSERT INTO matriculas
        (estudiante_id, curso_id, fecha_matricula, estado, nota_final)
    VALUES
        (1, 1, CURDATE(), 'activa', NULL);
    IF error_duplicado THEN
        SELECT 'Correcto: no se permite repetir la matricula del mismo estudiante en el mismo curso.' AS resultado;
    ELSE
        SELECT 'Revisar: se esperaba un error por matricula duplicada.' AS resultado;
    END IF;
END$$
DELIMITER ;

CALL verificar_integridad();
DROP PROCEDURE verificar_integridad;

-- actividad 35
SELECT
    p.nombre AS programa,
    c.nombre AS curso,
    d.nombre AS docente,
    COUNT(DISTINCT m.estudiante_id) AS cantidad_estudiantes_matriculados,
    ROUND(AVG(m.nota_final), 2) AS promedio_notas,
    SUM(CASE WHEN m.estado = 'activa' THEN 1 ELSE 0 END) AS cantidad_matriculas_activas
FROM cursos AS c
INNER JOIN programas AS p ON c.programa_id = p.programa_id
INNER JOIN docentes AS d ON c.docente_id = d.docente_id
LEFT JOIN matriculas AS m ON c.curso_id = m.curso_id
GROUP BY
    p.programa_id, p.nombre,
    c.curso_id, c.nombre,
    d.docente_id, d.nombre
ORDER BY
    cantidad_estudiantes_matriculados DESC,
    p.nombre ASC,
    c.nombre ASC;
