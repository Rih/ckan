/*
This script create new tables gender and usertype
use it inside ckan schema

Warning: Uncomment DROP TABLE lines if you know what are you doing!
*/

-- DROP TABLE public."gender"; COMMIT;

CREATE TABLE IF NOT EXISTS public."gender"(
  id SERIAL PRIMARY KEY,
  name VARCHAR(20) UNIQUE,
  value TEXT,
  enable INT DEFAULT 1
);
COMMIT;
INSERT INTO public."gender" (id, name, value) VALUES (1, 'female', 'Femenino');
INSERT INTO public."gender" (id, name, value) VALUES (2, 'male', 'Masculino');



-- DROP TABLE public."usertype"; COMMIT;

CREATE TABLE IF NOT EXISTS public."usertype"(
  id SERIAL PRIMARY KEY,
  name VARCHAR(20) UNIQUE,
  value TEXT,
  enable INT DEFAULT 1
);
COMMIT;

INSERT INTO public."usertype" (id, name, value) VALUES (1, 'academic', 'Académico');
INSERT INTO public."usertype" (id, name, value) VALUES (2, 'student', 'Estudiante');
INSERT INTO public."usertype" (id, name, value) VALUES (3, 'propietary', 'Pequeño Propietario');
INSERT INTO public."usertype" (id, name, value) VALUES (4, 'pyme', 'Pyme');
INSERT INTO public."usertype" (id, name, value) VALUES (5, 'company', 'Gran Empresa');
INSERT INTO public."usertype" (id, name, value) VALUES (6, 'ong', 'ONG');
INSERT INTO public."usertype" (id, name, value) VALUES (7, 'organization', 'Organización o asociación');
INSERT INTO public."usertype" (id, name, value) VALUES (8, 'other', 'Otros usuarios');
