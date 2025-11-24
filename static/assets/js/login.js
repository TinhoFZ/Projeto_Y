const inputEmail = document.querySelector('#input-email');
const inputSenha = document.querySelector('#input-senha');
const buttonLogin = document.querySelector('#button-login');

const buttonVoltar = document.querySelector('#button-voltar');

async function logar() {
    const res = await fetch('/api/usuarios');
    const data = await res.json();

    let email = inputEmail.value;
    let senha = inputSenha.value;

    data.forEach(objeto => {
        if(objeto.email === email && objeto.senha === senha) {
            window.location.href = '..';
        }
    });
}

buttonLogin.addEventListener('click', () => logar());
buttonVoltar.addEventListener('click', () => window.location.href = '..');