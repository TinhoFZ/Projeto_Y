const modulos = document.querySelector('#modulos');
const buttonVoltar = document.querySelector('#button-voltar');

const categoriaEscolhida = localStorage.getItem('categoriaEscolhida');

async function mostrarModulos() {
    const res = await fetch('/api/modulos', {
        method: "POST",
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ id_categoria: categoriaEscolhida })
    });

    const data = await res.json();

    data.forEach(objeto => {
        let novaCategoria = document.createElement('div');
        let titulo = document.createElement('h3');
        let botao = document.createElement('button');

        titulo.innerText = objeto.titulo;
        botao.innerText = "Ver";

        botao.addEventListener('click', () => {
            localStorage.setItem('moduloEscolhido', objeto.id_modulo);
            window.location.href = "moduloEscolhido.html";
        })

        novaCategoria.appendChild(titulo);
        novaCategoria.appendChild(botao);
        
        modulos.appendChild(novaCategoria); 
    });
}

buttonVoltar.addEventListener('click', () => {
    window.location.href = "..";
})

mostrarModulos();
