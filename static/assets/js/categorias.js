const categorias = document.querySelector('#categorias');

async function mostrarCategorias() {
    const res = await fetch('/api/categorias');
    const data = await res.json();
    console.log(data);
    data.forEach(objeto => {
        let novaCategoria = document.createElement('div');
        let nome = document.createElement('h3');
        let descricao = document.createElement('p');
        let botao = document.createElement('button');

        nome.innerText = objeto.nome;
        descricao.innerText = objeto.descricao;
        botao.innerText = "Ver";

        botao.addEventListener('click', () => {
            localStorage.setItem('categoriaEscolhida', objeto.id_categoria);
            window.location.assign("/static/modulos.html")
        })

        novaCategoria.appendChild(nome);
        novaCategoria.appendChild(descricao);
        novaCategoria.appendChild(botao);
        
        categorias.appendChild(novaCategoria); 
    });
}

mostrarCategorias();