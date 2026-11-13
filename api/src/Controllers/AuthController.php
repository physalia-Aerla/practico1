<?php

class AuthController
{
    private const ROL_USUARIO = 2;

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

    public function registro(): void
    {
        $data = json_decode(file_get_contents('php://input'), true) ?: [];
        $nombre = trim($data['nombre'] ?? '');
        $email = trim($data['email'] ?? '');
        $password = $data['password'] ?? '';

        if ($nombre === '' || mb_strlen($nombre) > 80) {
            responder(['message' => 'Ingresá un nombre válido.'], 422);
        }
        if (!filter_var($email, FILTER_VALIDATE_EMAIL) || mb_strlen($email) > 100) {
            responder(['message' => 'Ingresá un correo electrónico válido.'], 422);
        }
        if (mb_strlen($password) < 8) {
            responder(['message' => 'La contraseña debe tener al menos 8 caracteres.'], 422);
        }
        if ($this->usuarios->existeEmail($email)) {
            responder(['message' => 'Ya existe una cuenta con ese correo.'], 409);
        }

        $this->usuarios->crear($nombre, $email, password_hash($password, PASSWORD_DEFAULT), self::ROL_USUARIO);

        $this->iniciarSesion($this->usuarios->buscarPorEmail($email));
        responder($_SESSION['usuario'], 201);
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
