const inputEmail = document.querySelector('#input-email');
const inputSenha = document.querySelector('#input-senha');
const buttonCadastro = document.querySelector('#button-cadastro');

const buttonVoltar = document.querySelector('#button-voltar');

async function cadastrar() {
    const resUsuario = await fetch('/api/usuarios');
    const data = await resUsuario.json();
    
    let email = inputEmail.value;
    let senha = inputSenha.value;
    
    let emailExiste = false;

    data.forEach(objeto => {
        if(objeto.email === email) {
            emailExiste = true;
            return;
        }
    });
    
    if(!emailExiste) {
        await fetch('/api/cadastro', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ email: email, senha: senha })
        })
        window.location.href = '..'
    }
}

buttonCadastro.addEventListener('click', () => cadastrar());
buttonVoltar.addEventListener('click', () => window.location.href = '..');