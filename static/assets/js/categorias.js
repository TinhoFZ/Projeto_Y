const buttonCadastro = document.querySelector('#button-cadastro');
const buttonLogin = document.querySelector('#button-login');

const categorias = document.querySelector('#categorias');

async function mostrarCategorias() {
    const res = await fetch('/api/categorias');
    const data = await res.json();
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
            window.location.href = "/static/modulos.html"
        })

        novaCategoria.appendChild(nome);
        novaCategoria.appendChild(descricao);
        novaCategoria.appendChild(botao);
        
        categorias.appendChild(novaCategoria); 
    });
}

buttonCadastro.addEventListener('click', () => window.location.href = "static/cadastro.html");
buttonLogin.addEventListener('click', () => window.location.href = "static/login.html");

mostrarCategorias();