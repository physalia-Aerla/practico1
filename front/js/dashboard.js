async function cargarTablaCatalogo() {
    const respuesta = await fetch('/api/libros');
    const data = await respuesta.json();
    let filas = '';

    data.libros.forEach(libro => {
        filas += `
            <tr>
                <td>${libro.id_libro}</td>
                <td>${libro.titulo}</td>
                <td>${libro.tipo}</td>
                <td>${libro.autores || '-'}</td>
                <td>${libro.editorial || '-'}</td>
                <td>$${Number(libro.precio).toFixed(2)}</td>
                <td>${Number(libro.destacado) === 1 ? '⭐' : ''}</td>
            </tr>
        `;
    });

    document.getElementById('tablaCatalogo').innerHTML = filas;
    document.getElementById('totalCatalogo').textContent = data.libros.length;
}

protegerPagina(ROL_ADMIN).then(cargarTablaCatalogo);
