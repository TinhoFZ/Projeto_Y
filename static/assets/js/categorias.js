const categorias = document.querySelector('#categorias');

let categoriaEscolhida = 0;

async function mostrarCategorias() {
    const res = await fetch('/api/categorias');
    const data = await res.json();
    console.log(data);
    data.forEach(objeto => {
        let novaCategoria = document.createElement('div');
        let titulo = document.createElement('h3');
        let descricao = document.createElement('p');
        let botao = document.createElement('button');

        titulo.innerText = objeto.nome;
        descricao.innerText = objeto.descricao;
        botao.innerText = "Ver";

        botao.addEventListener('click', () => {
            categoriaEscolhida = objeto.id_categoria;
            window.location.assign("/static/categorias.html")
        })

        novaCategoria.appendChild(titulo);
        novaCategoria.appendChild(descricao);
        novaCategoria.appendChild(botao);
        
        categorias.appendChild(novaCategoria); 
    });
}

mostrarCategorias();