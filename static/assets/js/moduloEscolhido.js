const informacoes = document.querySelector('#informacoes');
const buttonVoltar = document.querySelector('#button=-voltar');

const categoriaEscolhida = localStorage.getItem('categoriaEscolhida');
const moduloEscolhido = localStorage.getItem('moduloEscolhido');

async function mostrarModulo() {
    const res = await fetch('/api/modulos', {
        method: "POST",
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ id_categoria: categoriaEscolhida })
    });

    const data = await res.json();


    data.forEach(objeto => {
        if(objeto.id_modulo == moduloEscolhido){
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
}

buttonVoltar.addEventListener('click', () => {
    window.location.href = "modulos.html"
})

mostrarModulo();
