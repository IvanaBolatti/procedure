CREATE SCHEMA biblioteca;
USE biblioteca;

CREATE TABLE editorial(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(45) NOT NULL,
    contacto VARCHAR(50)
);

CREATE TABLE nacionalidad(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    nombre VARCHAR(40) NOT NULL
);

CREATE TABLE serie(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(40) NOT NULL
);

CREATE TABLE tematica(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(40) NOT NULL
);

CREATE TABLE estado_libro(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(40) NOT NULL
);

CREATE TABLE autor(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(40) NOT NULL,
    id_nacionalidad INT NOT NULL,
    FOREIGN KEY (id_nacionalidad) REFERENCES nacionalidad (id)
);

CREATE TABLE ilustrador(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(40) NOT NULL,
    id_nacionalidad INT NOT NULL,
    FOREIGN KEY (id_nacionalidad) REFERENCES nacionalidad (id)
);

ALTER TABLE ilustrador
ADD COLUMN  edad INT NOT NULL;

CREATE TABLE lector(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    nombre VARCHAR(40) NOT NULL, 
    apellido VARCHAR(40)NOT NULL,
    contacto VARCHAR(50)
);

CREATE TABLE libro(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(40) NOT NULL,
    id_autor INT NOT NULL,
    FOREIGN KEY (id_autor) REFERENCES autor (id),
    id_ilustrador INT NOT NULL,
    FOREIGN KEY (id_ilustrador) REFERENCES ilustrador (id),
    id_editorial INT NOT NULL,
    FOREIGN KEY (id_editorial) REFERENCES editorial (id),
    id_tematica INT NOT NULL,
    FOREIGN KEY (id_tematica) REFERENCES tematica (id),
    id_estado INT NOT NULL,
    FOREIGN KEY (id_estado) REFERENCES estado_libro (id),
    id_serie INT NOT NULL,
    FOREIGN KEY (id_serie) REFERENCES serie (id),
    detalle VARCHAR(50),
    edad INT
);

CREATE TABLE prestamo (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
id_libro INT NOT NULL,
FOREIGN KEY (id_libro) REFERENCES libro (id),
id_lector INT NOT NULL,
FOREIGN KEY (id_lector) REFERENCES lector (id),
f_pedido DATE,
f_devolucion DATE,
detalle VARCHAR(60)
);

select * FROM editorial;
select * FROM autor;
INSERT INTO nacionalidad VALUES 
(NULL,"argentino"),
(NULL,"brasilero"),
(NULL,"peruano"),
(NULL,"mexicano");

SELECT * FROM nacionalidad;

INSERT INTO autor VALUES 
(NULL,"Juan Carlos", 2),
(NULL,"Pedro Alfonso", 1),
(NULL,"Raúl Perez", 2);
SELECT * FROM lector;
SELECT * FROM serie;

select * from autor;

INSERT INTO ilustrador VALUES 
(NULL,"Juan Esteban",3, 67),
(NULL,"Roberto Segura",1, 56),
(NULL,"Carlos Tami",2, 42),
(NULL,"Camila Bas",4, 23);

select * FROM ilustrador;

DELIMITER //
CREATE PROCEDURE ordenar_autores (IN campo char(20))
BEGIN
if campo<>' ' then
  SET  @orden= CONCAT ('ORDER BY ', campo);
  ELSE 
    SET @orden=' ';
 END IF;
 
 SET @clausula= CONCAT ('SELECT * FROM autor ', @orden );
 PREPARE runSQL FROM @clausula;
 EXECUTE runSQL;
 DEALLOCATE PREPARE runSQL;
 END
 //
 
 CALL ordenar_autores('nombre');

DELIMITER //
CREATE PROCEDURE eliminar_autor (IN id_eliminar int)
BEGIN
 DELETE FROM autor WHERE autor.id=id_eliminar;
 END
 //

CALL eliminar_autor (4);
