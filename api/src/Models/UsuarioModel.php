<?php

class UsuarioModel
{
    private $db;

    public function __construct($db)
    {
        $this->db = $db;
    }

    public function buscarPorEmail(string $email): ?array
    {
        $stmt = $this->db->prepare(
            'SELECT u.nombre_usuario AS nombre, u.password, u.id_rol, r.nombre_rol AS rol
               FROM usuario u
               INNER JOIN rol r ON r.id_rol = u.id_rol
              WHERE u.email = :email AND u.activo = 1'
        );
        $stmt->execute(['email' => $email]);

        return $stmt->fetch(PDO::FETCH_ASSOC) ?: null;
    }

    public function existeEmail(string $email): bool
    {
        $stmt = $this->db->prepare('SELECT 1 FROM usuario WHERE email = :email');
        $stmt->execute(['email' => $email]);

        return (bool) $stmt->fetchColumn();
    }

    public function crear(string $nombre, string $email, string $passwordHash, int $idRol): void
    {
        $stmt = $this->db->prepare(
            'INSERT INTO usuario (nombre_usuario, email, password, id_rol)
             VALUES (:nombre, :email, :password, :id_rol)'
        );
        $stmt->execute([
            'nombre'   => $nombre,
            'email'    => $email,
            'password' => $passwordHash,
            'id_rol'   => $idRol,
        ]);
    }
}
