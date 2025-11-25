const buttonCadastro = document.querySelector('#button-cadastro');
const buttonLogin = document.querySelector('#button-login');
const buttonDeslogar = document.querySelector('#button-deslogar');

const categorias = document.querySelector('#categorias');

async function mostrarCategorias() {
    const res = await fetch('/api/categorias');
    const data = await res.json();
    data.forEach(objeto => {
        let novaCategoria = document.createElement('div');
        let nome = document.createElement('h3');
        let descricao = document.createElement('p');
        let botao = document.createElement('button');

        // CLASSES COMPATÍVEIS COM O CSS EXISTENTE
        novaCategoria.classList.add('card');

        nome.innerText = objeto.nome;
        descricao.innerText = objeto.descricao;
        botao.innerText = "Ver";

        botao.addEventListener('click', () => {
            localStorage.setItem('categoriaEscolhida', objeto.id_categoria);
            window.location.href = "/static/modulos.html";
        });

        novaCategoria.appendChild(nome);
        novaCategoria.appendChild(descricao);
        novaCategoria.appendChild(botao);

        categorias.appendChild(novaCategoria);
    });
}

async function checarLogin() {
    const res = await fetch('/api/eu');
    const data = await res.json();
    if(data.logado) {
        buttonCadastro.classList.add('hidden');
        buttonLogin.classList.add('hidden');
        buttonDeslogar.classList.remove('hidden');
    } else {
        buttonCadastro.classList.remove('hidden');
        buttonLogin.classList.remove('hidden');
        buttonDeslogar.classList.add('hidden');
    }
}

async function deslogar() {
    await fetch('/api/deslogar');
    checarLogin();
}

buttonCadastro.addEventListener('click', () => window.location.href = "static/cadastro.html");
buttonLogin.addEventListener('click', () => window.location.href = "static/login.html");
buttonDeslogar.addEventListener('click', () => deslogar());

checarLogin();
mostrarCategorias();
