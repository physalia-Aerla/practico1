let index = 0;

function mover(dir){

    const track = document.querySelector(".opiniones-track");
    const cards = document.querySelectorAll(".opinion-card");

    const visible = window.innerWidth <= 768 ? 1 : 3;

    const max = cards.length - visible;

    index += dir;

    if(index < 0){
        index = 0;
    }

    if(index > max){
        index = max;
    }

    const anchoCard = cards[0].offsetWidth + 20;

    track.style.transform =
        `translateX(${-index * anchoCard}px)`;
}

const posiciones = {
    libros: 0,
    audio: 0,
    revistas: 0
};

function moverCatalogo(tipo, dir){

    const track = document.querySelector(`.${tipo}-track`);
    const cards = document.querySelectorAll(`.${tipo}-card`);

    const visible = window.innerWidth <= 768 ? 1 : 3;

    const max = cards.length - visible;

    posiciones[tipo] += dir;

    if(posiciones[tipo] < 0){
        posiciones[tipo] = 0;
    }

    if(posiciones[tipo] > max){
        posiciones[tipo] = max;
    }

    const anchoCard = cards[0].offsetWidth + 20;

    track.style.transform =
        `translateX(${-posiciones[tipo] * anchoCard}px)`;
}