from flask import Flask, jsonify, request
import mysql.connector

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
    cursor.execute('SELECT id_usuario, nome, senha FROM usuarios')
    data = cursor.fetchall()
    cursor.close()
    conn.close()
    return jsonify(data)

@app.route('/api/categorias')
def categorias():
    conn = fazer_conexao()
    cursor = conn.cursor(dictionary=True)
    cursor.execute('SELECT id_categoria, nome, descricao FROM categorias')
    data = cursor.fetchall()
    cursor.close()
    conn.close()
    return jsonify(data)

@app.route('/api/modulos')
def modulos():
    conn = fazer_conexao()
    cursor = conn.cursor(dictionary=True)
    cursor.execute('SELECT id_modulo, id_categoria, titulo, explicacao FROM categorias')
    data = cursor.fetchall()
    cursor.close()
    conn.close()
    return jsonify(data)

@app.route('/api/progresso')
def progressos():
    conn = fazer_conexao()
    cursor = conn.cursor(dictionary=True)
    cursor.execute('SELECT id_usuario, id_modulo, estado FROM categorias')
    data = cursor.fetchall()
    cursor.close()
    conn.close()
    return jsonify(data)

@app.route('/')
def serve_frontend():
    return app.send_static_file('index.html')

app.run(debug=True)