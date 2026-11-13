SET NAMES utf8mb4;

CREATE DATABASE IF NOT EXISTS aurora_db
    CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE aurora_db;

CREATE TABLE IF NOT EXISTS `rol` (
    `id_rol`     INT AUTO_INCREMENT PRIMARY KEY,
    `nombre_rol` VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS `categoria` (
    `id_categoria`     INT AUTO_INCREMENT PRIMARY KEY,
    `nombre_categoria` VARCHAR(60) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS `editorial` (
    `id_editorial`     INT AUTO_INCREMENT PRIMARY KEY,
    `nombre_editorial` VARCHAR(100) NOT NULL,
    `pais`             VARCHAR(60) NULL
);

CREATE TABLE IF NOT EXISTS `autor` (
    `id_autor`     INT AUTO_INCREMENT PRIMARY KEY,
    `nombre_autor` VARCHAR(100) NOT NULL,
    `nacionalidad` VARCHAR(60) NULL
);

CREATE TABLE IF NOT EXISTS `usuario` (
    `id_usuario`     INT AUTO_INCREMENT PRIMARY KEY,
    `nombre_usuario` VARCHAR(80) NOT NULL,
    `email`          VARCHAR(100) NOT NULL UNIQUE,
    `password`       VARCHAR(255) NOT NULL,
    `activo`         BOOLEAN NOT NULL DEFAULT TRUE,
    `creado`         DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `id_rol`         INT NOT NULL,
    CONSTRAINT `fk_usuario_rol`
        FOREIGN KEY (`id_rol`) REFERENCES `rol`(`id_rol`)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `libro` (
    `id_libro`         INT AUTO_INCREMENT PRIMARY KEY,
    `titulo`           VARCHAR(150) NOT NULL,
    `tipo`             ENUM('Libro', 'Audiolibro', 'Revista') NOT NULL DEFAULT 'Libro',
    `precio`           DECIMAL(8,2) NOT NULL,
    `destacado`        BOOLEAN NOT NULL DEFAULT FALSE,
    `imagen`           VARCHAR(255) NULL,
    `anio_publicacion` SMALLINT NULL,
    `id_categoria`     INT NOT NULL,
    `id_editorial`     INT NULL,
    CONSTRAINT `fk_libro_categoria`
        FOREIGN KEY (`id_categoria`) REFERENCES `categoria`(`id_categoria`)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `fk_libro_editorial`
        FOREIGN KEY (`id_editorial`) REFERENCES `editorial`(`id_editorial`)
        ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `libro_autor` (
    `id_libro` INT NOT NULL,
    `id_autor` INT NOT NULL,
    PRIMARY KEY (`id_libro`, `id_autor`),
    CONSTRAINT `fk_libroautor_libro`
        FOREIGN KEY (`id_libro`) REFERENCES `libro`(`id_libro`)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_libroautor_autor`
        FOREIGN KEY (`id_autor`) REFERENCES `autor`(`id_autor`)
        ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT IGNORE INTO `rol` (`id_rol`, `nombre_rol`) VALUES
    (1, 'Administrador'),
    (2, 'Usuario');

INSERT IGNORE INTO `usuario` (`id_usuario`, `nombre_usuario`, `email`, `password`, `id_rol`) VALUES
    (1, 'Admin Aurora', 'admin@aurora.com', '$2y$12$yNGCRCpjBovdOMmDjo8aaOQax9ESE9RmQBkt9PpvkOqTtv/D4nEOi', 1),
    (2, 'Usuario Demo', 'user@aurora.com',  '$2y$12$Jq3ZHU8F0OqbQNCNAM/VlO4ViqyzBI/ssZd087rhu.qJNG67P5YDy', 2);

INSERT IGNORE INTO `categoria` (`id_categoria`, `nombre_categoria`) VALUES
    (1, 'Novela clásica'),
    (2, 'Fantasía'),
    (3, 'Distopía'),
    (4, 'Desarrollo personal'),
    (5, 'Finanzas'),
    (6, 'Psicología'),
    (7, 'Negocios'),
    (8, 'Ciencia'),
    (9, 'Tecnología'),
    (10, 'Moda');

INSERT IGNORE INTO `editorial` (`id_editorial`, `nombre_editorial`, `pais`) VALUES
    (1, 'Penguin Classics', 'Reino Unido'),
    (2, 'J. B. Lippincott & Co.', 'Estados Unidos'),
    (3, 'Charles Scribner''s Sons', 'Estados Unidos'),
    (4, 'Little, Brown and Company', 'Estados Unidos'),
    (5, 'Secker & Warburg', 'Reino Unido'),
    (6, 'George Allen & Unwin', 'Reino Unido'),
    (7, 'Avery', 'Estados Unidos'),
    (8, 'Plata Publishing', 'Estados Unidos'),
    (9, 'Free Press', 'Estados Unidos'),
    (10, 'Farrar, Straus and Giroux', 'Estados Unidos'),
    (11, 'Portfolio', 'Estados Unidos'),
    (12, 'National Geographic Society', 'Estados Unidos'),
    (13, 'Condé Nast', 'Estados Unidos'),
    (14, 'Forbes Media', 'Estados Unidos'),
    (15, 'The Economist Group', 'Reino Unido');

INSERT IGNORE INTO `autor` (`id_autor`, `nombre_autor`, `nacionalidad`) VALUES
    (1, 'Jane Austen', 'Británica'),
    (2, 'Harper Lee', 'Estadounidense'),
    (3, 'F. Scott Fitzgerald', 'Estadounidense'),
    (4, 'J. D. Salinger', 'Estadounidense'),
    (5, 'George Orwell', 'Británica'),
    (6, 'J. R. R. Tolkien', 'Británica'),
    (7, 'James Clear', 'Estadounidense'),
    (8, 'Robert Kiyosaki', 'Estadounidense'),
    (9, 'Stephen R. Covey', 'Estadounidense'),
    (10, 'Daniel Kahneman', 'Israelí'),
    (11, 'Simon Sinek', 'Británica');

INSERT IGNORE INTO `libro` (`id_libro`, `titulo`, `tipo`, `precio`, `destacado`, `imagen`, `anio_publicacion`, `id_categoria`, `id_editorial`) VALUES
    (1,  'Pride and Prejudice',                     'Libro',      14.99, FALSE, 'imagen1.jpg',  1813, 1, 1),
    (2,  'To Kill a Mockingbird',                   'Libro',      15.99, FALSE, 'imagen2.jpg',  1960, 1, 2),
    (3,  'The Great Gatsby',                        'Libro',      13.99, FALSE, 'imagen3.jpg',  1925, 1, 3),
    (4,  'The Catcher in the Rye',                  'Libro',      12.99, FALSE, 'imagen4.jpg',  1951, 1, 4),
    (5,  '1984',                                    'Libro',      15.99, FALSE, 'imagen5.jpg',  1949, 3, 5),
    (6,  'The Hobbit',                              'Libro',      18.99, TRUE,  'imagen6.jpg',  1937, 2, 6),
    (7,  'Atomic Habits',                           'Audiolibro', 11.99, TRUE,  'imagen11.jpg', 2018, 4, 7),
    (8,  'Rich Dad Poor Dad',                       'Audiolibro', 10.99, FALSE, 'imagen12.jpg', 1997, 5, 8),
    (9,  'The 7 Habits of Highly Effective People', 'Audiolibro', 12.99, FALSE, 'imagen13.jpg', 1989, 4, 9),
    (10, 'Thinking, Fast and Slow',                 'Audiolibro', 14.99, FALSE, 'imagen14.jpg', 2011, 6, 10),
    (11, 'Start with Why',                          'Audiolibro', 12.99, FALSE, 'imagen15.jpg', 2009, 7, 11),
    (12, 'National Geographic',                     'Revista',     6.99, TRUE,  'imagen21.jpg', 2018, 8, 12),
    (13, 'WIRED',                                   'Revista',     7.99, FALSE, 'imagen22.jpg', 2011, 9, 13),
    (14, 'Forbes',                                  'Revista',     8.99, FALSE, 'imagen23.jpg', 2016, 7, 14),
    (15, 'The Economist',                           'Revista',     9.99, FALSE, 'imagen24.jpg', 2024, 7, 15),
    (16, 'Vogue',                                   'Revista',     7.99, FALSE, 'imagen25.jpg', 2024, 10, 13);

INSERT IGNORE INTO `libro_autor` (`id_libro`, `id_autor`) VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 7),
    (8, 8),
    (9, 9),
    (10, 10),
    (11, 11);
