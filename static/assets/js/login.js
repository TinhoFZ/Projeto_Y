const inputEmail = document.querySelector('#input-email');
const inputSenha = document.querySelector('#input-senha');
const buttonLogin = document.querySelector('#button-login');

const buttonVoltar = document.querySelector('#button-voltar');

async function logar() {
    let email = inputEmail.value;
    let senha = inputSenha.value;

    const res = await fetch('/api/login', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ email, senha })
    });
    
    const data = await res.json();
    
    if(data.status === "ok") {
        window.location.href = '..'
    }
}

buttonLogin.addEventListener('click', () => logar());
buttonVoltar.addEventListener('click', () => window.location.href = '..');