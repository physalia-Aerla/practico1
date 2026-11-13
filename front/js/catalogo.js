const CARPETA_IMAGENES = '/front/assets/imagenes/';

const CARRUSELES = {
    'Libro': 'libros',
    'Audiolibro': 'audio',
    'Revista': 'revistas'
};

function cuerpoTarjeta(libro, prefijo = '', moneda = '') {
    const subtitulo = libro.autores || libro.editorial || '';

    return `
        <div class="card">
            <img src="${CARPETA_IMAGENES + libro.imagen}" class="card-img-top" alt="${libro.titulo}">
            <div class="card-body">
                <h5>${prefijo}${libro.titulo}</h5>
                <p>${subtitulo}</p>
                <strong>$${Number(libro.precio).toFixed(2)}${moneda}</strong>
            </div>
        </div>
    `;
}

function cargarTop3(libros) {
    let html = '';

    libros
        .filter(libro => Number(libro.destacado) === 1)
        .slice(0, 3)
        .forEach(libro => {
            html += `<div class="col-md-4">${cuerpoTarjeta(libro, '⭐ ', ' USD')}</div>`;
        });

    document.getElementById('top3').innerHTML = html;
}

function cargarCarruseles(libros) {
    Object.entries(CARRUSELES).forEach(([tipo, clave]) => {
        let html = '';

        libros
            .filter(libro => libro.tipo === tipo)
            .forEach(libro => {
                html += `<div class="catalogo-card ${clave}-card">${cuerpoTarjeta(libro)}</div>`;
            });

        document.querySelector(`.${clave}-track`).innerHTML = html;
    });
}

async function cargarCatalogo() {
    try {
        const respuesta = await fetch('/api/libros');
        const data = await respuesta.json();

        cargarTop3(data.libros);
        cargarCarruseles(data.libros);
    } catch {
        document.getElementById('top3').innerHTML =
            '<p class="text-white text-center">No se pudo cargar el catálogo. Intentá de nuevo más tarde.</p>';
    }
}

cargarCatalogo();
