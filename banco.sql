DROP DATABASE ydb;

CREATE DATABASE ydb;

USE ydb;

CREATE TABLE usuarios(
	id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    senha VARCHAR(100) NOT NULL
);

CREATE TABLE categorias(
	id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL UNIQUE,
    descricao VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE modulos(
	id_modulo INT PRIMARY KEY AUTO_INCREMENT,
    id_categoria INT,
    titulo VARCHAR(100),
    explicacao JSON,
    FOREIGN KEY (id_categoria) REFERENCES categorias (id_categoria)
);

CREATE TABLE progressos(
	id_usuario INT,
    id_modulo INT,
    estado ENUM("nao_iniciado", "em_progresso", "completo"),
    FOREIGN KEY (id_usuario) REFERENCES usuarios (id_usuario),
    FOREIGN KEY (id_modulo) REFERENCES modulos (id_modulo)
);

INSERT INTO usuarios (nome, senha) VALUES
("Eduardo", "123");

INSERT INTO categorias (nome, descricao) VALUES
("Matemática básica", "Ensinamentos iniciais da matemática, como somar, subtrair e etc");

SELECT * FROM progresso;