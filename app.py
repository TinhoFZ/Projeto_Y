from flask import Flask, jsonify, request, session
import mysql.connector, json

app = Flask(__name__)
app.secret_key = "chave_secretaz"

def fazer_conexao():
    return mysql.connector.connect(
        host='localhost',
        user='root',
        password='senha',
        database='ydb'
    )

@app.route('/api/usuarios')
def usuarios():
    conn = fazer_conexao()
    cursor = conn.cursor(dictionary=True)
    cursor.execute('SELECT id_usuario, email, senha FROM usuarios')
    data = cursor.fetchall()
    cursor.close()
    conn.close()
    return jsonify(data)

@app.route('/api/cadastro', methods=['POST'])
def cadastro():
    body = request.json
    email = body['email']
    senha = body['senha']
    conn = fazer_conexao()
    cursor = conn.cursor(dictionary=True)
    cursor.execute('INSERT INTO usuarios (email, senha) VALUES (%s, %s)', (email, senha))
    conn.commit()
    cursor.close()
    conn.close()
    return jsonify({'status': 'ok'})

@app.route('/api/login', methods=['POST'])
def login():
    data = request.json
    email = data['email']
    senha = data['senha']
    conn = fazer_conexao()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM usuarios WHERE email=%s AND senha=%s", (email, senha))
    usuario = cursor.fetchone()
    
    if not usuario:
        return jsonify({'status': 'erro'}), 401

    session['id_usuario'] = usuario['id_usuario']
    session['email'] = usuario['email']

    return jsonify({'status': 'ok'})

@app.route('/api/eu')
def eu():
    if 'id_usuario' not in session:
        return jsonify({'logado': False}), 401
    else:
        return jsonify({
            'logado': True,
            'id': session['id_usuario'],
            'email': session['email']
        })

@app.route('/api/deslogar')
def deslogar():
    session.clear()
    return jsonify({'status': 'ok'})

@app.route('/api/categorias')
def categorias():
    conn = fazer_conexao()
    cursor = conn.cursor(dictionary=True)
    cursor.execute('SELECT id_categoria, nome, descricao FROM categorias')
    data = cursor.fetchall()
    cursor.close()
    conn.close()
    return jsonify(data)

@app.route('/api/modulos', methods=['POST'])
def modulos():
    body = request.json
    id_categoria = body['id_categoria']
    conn = fazer_conexao()
    cursor = conn.cursor(dictionary=True)
    cursor.execute('SELECT id_modulo, titulo, explicacao FROM modulos WHERE id_categoria = %s', (id_categoria,))
    data = cursor.fetchall()
    for item in data:
        if isinstance(item['explicacao'], str):
            item['explicacao'] = json.loads(item['explicacao'])
    cursor.close()
    conn.close()
    return jsonify(data)

@app.route('/api/progressos')
def progressoss():
    conn = fazer_conexao()
    cursor = conn.cursor(dictionary=True)
    cursor.execute('SELECT id_usuario, id_modulo, estado FROM progressos')
    data = cursor.fetchall()
    cursor.close()
    conn.close()
    return jsonify(data)

@app.route('/api/marcar_progresso', methods=['POST'])
def marcar_progresso():
    body = request.json
    id_usuario = body['id_usuario']
    id_modulo = body['id_modulo']
    estado = body['estado']
    conn = fazer_conexao()
    cursor = conn.cursor(dictionary=True)
    cursor.execute('CALL MarcarProgresso(%s, %s, %s)', (id_usuario, id_modulo, estado))
    conn.commit()
    cursor.close()
    conn.close()
    return jsonify({'status:': 'ok'})

@app.route('/')
def serve_frontend():
    return app.send_static_file('index.html')

app.run(debug=True)