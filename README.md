# Aurora — Biblioteca virtual

## Cómo levantarlo

1. Copiar `.env.example` a `.env` (en la raíz).
2. Copiar `api/.env.example` a `api/.env`.
3. Ejecutar `docker compose up -d --build`.

- Sitio: http://localhost:8080
- phpMyAdmin: http://localhost:8081 (usuario `root`, contraseña `root_pass`)

La primera vez que arranca, la base se crea y se carga con `api/config/init.sql`. Para volver a cargarla desde cero: `docker compose down -v` y levantar de nuevo.

## Usuarios de prueba

| Rol | Email | Contraseña |
|---|---|---|
| Administrador | admin@aurora.com | admin1234 |
| Usuario | user@aurora.com | user1234 |

También se pueden crear cuentas nuevas desde la página de registro (quedan con rol Usuario).

## API

| Método | Ruta | Descripción |
|---|---|---|
| POST | `/api/login` | Inicia sesión (`email`, `password`). |
| POST | `/api/registro` | Crea una cuenta con rol Usuario e inicia sesión (`nombre`, `email`, `password`). |
| POST | `/api/logout` | Cierra la sesión. |
| GET | `/api/me` | Devuelve el usuario de la sesión actual. |
| GET | `/api/libros` | Lista el catálogo (libros, audiolibros y revistas). |

## Documentación

- [MER](docs/MER.md)
- [Pasaje a tablas](docs/pasaje-a-tablas.md)
- [Glosario de datos](docs/glosario-de-datos.md)
