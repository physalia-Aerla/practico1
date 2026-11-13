<?php

class AuthController
{
    private UsuarioModel $usuarios;

    public function __construct($db)
    {
        $this->usuarios = new UsuarioModel($db);
    }

    public function login(): void
    {
        $data = json_decode(file_get_contents('php://input'), true) ?: [];
        $usuario = $this->usuarios->buscarPorEmail(trim($data['email'] ?? ''));

        if (!$usuario || !password_verify($data['password'] ?? '', $usuario['password'])) {
            responder(['message' => 'Correo o contraseña incorrectos.'], 401);
        }

        $this->iniciarSesion($usuario);
        responder($_SESSION['usuario']);
    }

    public function logout(): void
    {
        session_destroy();
        responder(['message' => 'Sesión cerrada.']);
    }

    public function me(): void
    {
        if (!isset($_SESSION['usuario'])) {
            responder(['message' => 'No hay una sesión activa.'], 401);
        }
        responder($_SESSION['usuario']);
    }

    private function iniciarSesion(array $usuario): void
    {
        unset($usuario['password']);
        session_regenerate_id(true);
        $_SESSION['usuario'] = $usuario;
    }
}
