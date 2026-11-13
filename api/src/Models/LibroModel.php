<?php

class LibroModel
{
    private $db;

    public function __construct($db)
    {
        $this->db = $db;
    }

    public function listar(): array
    {
        return $this->db->query(
            "SELECT l.id_libro, l.titulo, l.tipo, l.precio, l.destacado, l.imagen,
                    e.nombre_editorial AS editorial,
                    GROUP_CONCAT(a.nombre_autor ORDER BY a.nombre_autor SEPARATOR ', ') AS autores
               FROM libro l
               LEFT JOIN editorial e    ON e.id_editorial = l.id_editorial
               LEFT JOIN libro_autor la ON la.id_libro = l.id_libro
               LEFT JOIN autor a        ON a.id_autor = la.id_autor
              GROUP BY l.id_libro, l.titulo, l.tipo, l.precio, l.destacado, l.imagen, e.nombre_editorial
              ORDER BY l.id_libro"
        )->fetchAll(PDO::FETCH_ASSOC);
    }
}
