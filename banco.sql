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
("Matemática básica", "Conceitos fundamentais como soma, subtração, multiplicação e divisão."),
("Números e operações", "Exploração de tipos de números e suas propriedades."),
("Geometria", "Formas, medidas, áreas, perímetros e representações espaciais."),
("Álgebra inicial", "Noções básicas de variáveis e expressões simples.");


INSERT INTO modulos (id_categoria, titulo, explicacao) VALUES
(1,
 "Somar números",
 JSON_OBJECT(
     'texto', 'A soma é a operação de juntar quantidades. Quando somamos, estamos aumentando um valor.',
     'exemplo', JSON_ARRAY('2 + 3 = 5', '10 + 15 = 25'),
     'exemploReal', JSON_ARRAY('Somar itens no mercado', 'Calcular total de pontos em um jogo')
 )
),
(1,
 "Subtrair números",
 JSON_OBJECT(
     'texto', 'A subtração representa tirar uma parte de um todo.',
     'exemplo', JSON_ARRAY('10 - 4 = 6', '20 - 7 = 13'),
     'exemploReal', JSON_ARRAY('Descontar um valor do saldo', 'Calcular tempo restante em uma contagem regressiva')
 )
),
(1,
 "Multiplicar números",
 JSON_OBJECT(
     'texto', 'Multiplicar é repetir uma quantidade várias vezes. É uma soma acelerada.',
     'exemplo', JSON_ARRAY('3 × 4 = 12', '10 × 5 = 50'),
     'exemploReal', JSON_ARRAY('Calcular preço total de vários itens iguais', 'Converter unidades repetidas')
 )
),
(1,
 "Dividir números",
 JSON_OBJECT(
     'texto', 'A divisão é repartir uma quantidade em partes iguais.',
     'exemplo', JSON_ARRAY('12 ÷ 3 = 4', '20 ÷ 4 = 5'),
     'exemploReal', JSON_ARRAY('Dividir uma pizza entre amigos', 'Repartir tarefas igualmente')
 )
);

INSERT INTO modulos (id_categoria, titulo, explicacao) VALUES
(2,
 "Números inteiros",
 JSON_OBJECT(
     'texto', 'Números inteiros incluem positivos, negativos e o zero.',
     'exemplo', JSON_ARRAY('-5 é menor que 3', '0 não é positivo nem negativo'),
     'exemploReal', JSON_ARRAY('Temperatura abaixo de zero', 'Saldo negativo no banco')
 )
),
(2,
 "Números decimais",
 JSON_OBJECT(
     'texto', 'Decimais representam valores fracionários entre os inteiros.',
     'exemplo', JSON_ARRAY('3.5 é maior que 3', '0.75 é igual a 3/4'),
     'exemploReal', JSON_ARRAY('Medir altura', 'Preços com centavos')
 )
);

INSERT INTO modulos (id_categoria, titulo, explicacao) VALUES
(3,
 "Figuras planas",
 JSON_OBJECT(
     'texto', 'Figuras planas são formas bidimensionais, como quadrados e triângulos.',
     'exemplo', JSON_ARRAY('Quadrado tem 4 lados iguais', 'Triângulo tem 3 lados'),
     'exemploReal', JSON_ARRAY('Formato de placas', 'Formas em embalagens')
 )
),
(3,
 "Perímetro",
 JSON_OBJECT(
     'texto', 'Perímetro é a soma dos lados de uma figura.',
     'exemplo', JSON_ARRAY('Perímetro do quadrado = 4 × lado', 'Perímetro do triângulo = soma dos 3 lados'),
     'exemploReal', JSON_ARRAY('Medir a cerca de um terreno', 'Contornar um campo esportivo')
 )
);

INSERT INTO modulos (id_categoria, titulo, explicacao) VALUES
(4,
 "O que é uma variável",
 JSON_OBJECT(
     'texto', 'Variáveis são símbolos que representam números desconhecidos ou que podem mudar.',
     'exemplo', JSON_ARRAY('x + 5 = 10', 'a × 3 = b'),
     'exemploReal', JSON_ARRAY('Tempo varia ao longo do dia', 'Velocidade depende da distância e do tempo')
 )
),
(4,
 "Expressões simples",
 JSON_OBJECT(
     'texto', 'Expressões algébricas representam operações com variáveis e números.',
     'exemplo', JSON_ARRAY('2x + 3', 'y - 7'),
     'exemploReal', JSON_ARRAY('Cálculo de preço com desconto', 'Velocidade média = distância/tempo')
 )
);



SELECT * FROM modulos;
SELECT * FROM progressos;