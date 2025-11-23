const modulos = document.querySelector('#modulos');

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
    console.log(data);

    data.forEach(objeto => {
        let novaCategoria = document.createElement('div');
        let titulo = document.createElement('h3');
        let texto = document.createElement('div');
        let botao = document.createElement('button');

        let explicacao = objeto.explicacao;
        console.log(explicacao);

        titulo.innerText = objeto.titulo;
        texto.innerHTML = `<h3>Explicação</h3>
            <p>${explicacao.texto}</p>
            <br>
            <h3>Exemplos</h3>
            
            <p>${explicacao.exemplo.join('<br>')}</p>
            `
        botao.innerText = "Ver";

        botao.addEventListener('click', () => {
            localStorage.setItem('moduloEscolhido', objeto.id_modulo);
            console.log("Sucesso!");
        })

        novaCategoria.appendChild(titulo);
        novaCategoria.appendChild(texto);
        novaCategoria.appendChild(botao);
        
        modulos.appendChild(novaCategoria); 
    });
}

mostrarModulos();
