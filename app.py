from flask import Flask, jsonify, request
import mysql.connector, json

app = Flask(__name__)

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

@app.route('/')
def serve_frontend():
    return app.send_static_file('index.html')

app.run(debug=True)