const informacoes = document.querySelector('#informacoes');
const buttonVoltar = document.querySelector('#button-voltar');

const categoriaEscolhida = localStorage.getItem('categoriaEscolhida');
const moduloEscolhido = localStorage.getItem('moduloEscolhido');

let idModuloAtual = 0;
let idUsuarioAtual = 0;

async function mostrarModulo() {
    const resModulos = await fetch('/api/modulos', {
        method: "POST",
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ id_categoria: categoriaEscolhida })
    });

    const data = await resModulos.json();

    data.forEach(objeto => {
        if(objeto.id_modulo == moduloEscolhido){
            idModuloAtual = objeto.id_modulo;
            let novaCategoria = document.createElement('div');
            let titulo = document.createElement('h3');
            let texto = document.createElement('div');

            titulo.innerText = objeto.titulo;

            let explicacao = objeto.explicacao;
            texto.innerHTML = `<h3>Explicação</h3>
                <p>${explicacao.texto}</p>
                
                <h3>Exemplos</h3>
                <p>${explicacao.exemplo.join('<br>')}</p>

                <h3>Na vida real</h3>
                <p>${explicacao.exemploReal.join('<br>')}</p>    
                `

            novaCategoria.appendChild(titulo);
            novaCategoria.appendChild(texto);

            informacoes.appendChild(novaCategoria); 
        }
    });

    const resEu = await fetch('/api/eu');
    dataUsuario = await resEu.json();
    console.log(dataUsuario);
    idUsuarioAtual = dataUsuario.id;

    dataUsuario.logado ? criarProgresso() : null;
}

function criarProgresso() {
    let range = document.createElement('input');
    let botao = document.createElement('botao');
    let div = document.createElement('div');

    range.type = "range", range.id = "range-progresso", range.min = 1, range.max = 3, range.step = 1;

    botao.innerText = 'Marcar';
    botao.addEventListener('click',  () => {
        modificarProgresso();
    })

    div.appendChild(range);
    div.appendChild(botao);

    buttonVoltar.before(div);
}

async function modificarProgresso() {
    const valorEstado = document.querySelector('#range-progresso').value;

    await fetch('/api/marcar_progresso', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
            body: JSON.stringify({ 
            id_usuario: idUsuarioAtual,
            id_modulo: idModuloAtual,
            estado: valorEstado
         })
    })
}

buttonVoltar.addEventListener('click', () => {
    window.location.href = "modulos.html"
})

mostrarModulo();
