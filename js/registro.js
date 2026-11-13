const registroForm = document.getElementById('registroForm');
const registroError = document.getElementById('registroError');

obtenerSesion().then((usuario) => {
    if (usuario) {
        window.location.replace(PANELES[usuario.id_rol]);
    }
});

registroForm.addEventListener('submit', async function (e) {
    e.preventDefault();

    if (registroForm.password.value !== registroForm.confirmar.value) {
        registroError.textContent = 'Las contraseñas no coinciden.';
        return;
    }

    const respuesta = await fetch('/api/registro', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
            nombre: registroForm.nombre.value,
            email: registroForm.email.value,
            password: registroForm.password.value
        })
    });
    const data = await respuesta.json();

    if (respuesta.ok) {
        window.location.replace(PANELES[data.id_rol]);
    } else {
        registroError.textContent = data.message;
    }
});
