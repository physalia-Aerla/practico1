const LOGIN = '/front/paginas/login.html';

const ROL_ADMIN = 1;
const ROL_USUARIO = 2;
const PANELES = {
    [ROL_ADMIN]: '/front/paginas/admin/dashboard.html',
    [ROL_USUARIO]: '/front/paginas/usuario/usuario.html'
};

async function obtenerSesion() {
    try {
        const respuesta = await fetch('/api/me');
        return respuesta.ok ? respuesta.json() : null;
    } catch {
        return null;
    }
}

async function protegerPagina(rolPermitido) {
    const usuario = await obtenerSesion();

    if (!usuario) {
        window.location.replace(LOGIN);
        return;
    }

    if (Number(usuario.id_rol) !== rolPermitido) {
        window.location.replace(PANELES[usuario.id_rol]);
        return;
    }

    document.getElementById('nombre').textContent = usuario.nombre;
    document.getElementById('rol').textContent = usuario.rol;
    document.body.style.visibility = 'visible';
}

async function cerrarSesion() {
    await fetch('/api/logout', { method: 'POST' });
    window.location.replace('/');
}

async function mostrarSesionEnHeader() {
    const acciones = document.getElementById('acciones-sesion');
    const usuario = await obtenerSesion();

    if (!acciones || !usuario) {
        return;
    }

    acciones.innerHTML = `
        <a href="${PANELES[usuario.id_rol]}" class="btn-login">Mi cuenta</a>
        <a href="#" class="btn-registro" onclick="cerrarSesion(); return false;">Cerrar sesión</a>
    `;
}
