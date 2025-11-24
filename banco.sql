DROP DATABASE ydb;

CREATE DATABASE ydb;

USE ydb;

CREATE TABLE usuarios(
	id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(100) NOT NULL,
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

DELIMITER $$
CREATE PROCEDURE MarcarProgresso(
    IN p_usuario INT,
    IN p_modulo INT,
    IN p_estado_novo ENUM('nao_iniciado','em_progresso','completo')
)
BEGIN
    DECLARE v_count INT DEFAULT 0;

    SELECT COUNT(*) INTO v_count
    FROM progressos
    WHERE id_usuario = p_usuario AND id_modulo = p_modulo;

    IF v_count = 0 THEN
        INSERT INTO progressos (id_usuario, id_modulo, estado)
        VALUES (p_usuario, p_modulo, p_estado_novo);
    ELSE
        UPDATE progressos
        SET estado = p_estado_novo
        WHERE id_usuario = p_usuario AND id_modulo = p_modulo;
    END IF;
END $$
DELIMITER ;


INSERT INTO usuarios (email, senha) VALUES
("edupassosa18@gmail.com", "123");

INSERT INTO categorias (id_categoria, nome, descricao) VALUES
(1, "Matemática básica", "Operações fundamentais, essenciais para qualquer aprendizado matemático."),
(2, "Cálculo mental", "Estratégias rápidas para resolver cálculos usando padrões e aproximações."),
(3, "Números e operações", "Entendimento de diferentes tipos de números e como eles funcionam."),
(4, "Geometria", "Estudo das formas, medidas, áreas e propriedades espaciais."),
(5, "Álgebra inicial", "Introdução a variáveis, expressões, equações e como resolvê-las.");


INSERT INTO modulos (id_categoria, titulo, explicacao) VALUES
(1,
 "Somar números",
 JSON_OBJECT(
     'texto', 'A soma junta quantidades. Serve para obter totais e combinar valores.',
     'exemplo', JSON_ARRAY('12 + 7 = 19', '145 + 230 = 375'),
     'exemploReal', JSON_ARRAY('Somar o valor de produtos no mercado', 'Totalizar pontos em um jogo')
 )
),

(1,
 "Subtrair números",
 JSON_OBJECT(
     'texto', 'A subtração representa quando algo é retirado ou diminuído.',
     'exemplo', JSON_ARRAY('20 - 6 = 14', '100 - 37 = 63'),
     'exemploReal', JSON_ARRAY('Calcular troco', 'Reduzir despesas do orçamento')
 )
),

(1,
 "Multiplicar números",
 JSON_OBJECT(
     'texto', 'Multiplicar é somar um número várias vezes. Simplifica quantidades repetidas.',
     'exemplo', JSON_ARRAY('4 × 6 = 24', '15 × 3 = 45'),
     'exemploReal', JSON_ARRAY('Preço de vários itens iguais', 'Escalar receitas de cozinha')
 )
),

(1,
 "Dividir números",
 JSON_OBJECT(
     'texto', 'A divisão reparte uma quantidade em partes iguais.',
     'exemplo', JSON_ARRAY('40 ÷ 5 = 8', '90 ÷ 9 = 10'),
     'exemploReal', JSON_ARRAY('Dividir conta entre amigos', 'Distribuir materiais igualmente')
 )
),

(2,
 "Multiplicação usando múltiplos de 10",
 JSON_OBJECT(
     'texto', 'A ideia é aproximar números para facilitar o cálculo mental.',
     'exemplo', JSON_ARRAY('12 × 7 → (10 × 7) + (2 × 7)', '19 × 5 → (20 × 5) − 5'),
     'exemploReal', JSON_ARRAY('Fazer estimativas rápidas de preços', 'Comparar valores grandes rapidamente')
 )
),

(2,
 "Divisão usando arredondamento",
 JSON_OBJECT(
     'texto', 'Arredondar facilita contas mentalmente sem alterar muito o resultado.',
     'exemplo', JSON_ARRAY('98 ÷ 7 → 100 ÷ 7', '51 ÷ 3 → 48 ÷ 3 + 3 ÷ 3'),
     'exemploReal', JSON_ARRAY('Dividir despesas', 'Estimativas rápidas em tarefas diárias')
 )
),

(2,
 "Cálculo mental com decomposição",
 JSON_OBJECT(
     'texto', 'Decompor transforma contas difíceis em duas contas fáceis.',
     'exemplo', JSON_ARRAY('37 + 28 → (30 + 20) + (7 + 8)', '63 − 27 → (60 − 20) + (3 − 7)'),
     'exemploReal', JSON_ARRAY('Somar valores de cabeça', 'Ajustar medidas rapidamente')
 )
),

(2,
 "Multiplicação rápida por 5, 2 e 4",
 JSON_OBJECT(
     'texto', 'Baseado em padrões: ×5 é metade de ×10; ×4 é dobrar duas vezes; ×2 é só dobrar.',
     'exemplo', JSON_ARRAY('18 × 5 → 180 ÷ 2 = 90', '12 × 4 → 12 × 2 × 2 = 48'),
     'exemploReal', JSON_ARRAY('Calcular preços', 'Pontuação em jogos')
 )
),

(3,
 "Números inteiros",
 JSON_OBJECT(
     'texto', 'Inteiros incluem negativos, positivos e zero.',
     'exemplo', JSON_ARRAY('-8 < 2', '0 é neutro'),
     'exemploReal', JSON_ARRAY('Temperaturas negativas', 'Saldo negativo no banco')
 )
),

(3,
 "Números decimais",
 JSON_OBJECT(
     'texto', 'Decimais representam valores entre inteiros e permitem mais precisão.',
     'exemplo', JSON_ARRAY('1.5 = 1 + 0.5', '3.75 significa três inteiros e 75 centésimos'),
     'exemploReal', JSON_ARRAY('Preços', 'Medições de altura ou distância')
 )
),

(3,
 "Frações",
 JSON_OBJECT(
     'texto', 'Frações mostram partes de um todo.',
     'exemplo', JSON_ARRAY('1/2 é metade', '3/4 significa 3 partes de 4'),
     'exemploReal', JSON_ARRAY('Cortar pizza', 'Medir ingredientes de receitas')
 )
),

(4,
 "Figuras planas",
 JSON_OBJECT(
     'texto', 'Figuras de duas dimensões, como quadrado, triângulo, círculo e retângulo.',
     'exemplo', JSON_ARRAY('Quadrado – 4 lados iguais', 'Triângulo – 3 lados'),
     'exemploReal', JSON_ARRAY('Placas', 'Mapas e desenhos')
 )
),

(4,
 "Perímetro",
 JSON_OBJECT(
     'texto', 'O perímetro é a soma dos lados de uma figura.',
     'exemplo', JSON_ARRAY('Quadrado: 4 × lado', 'Triângulo: lado1 + lado2 + lado3'),
     'exemploReal', JSON_ARRAY('Contornar um terreno', 'Tapar bordas de mesas')
 )
),

(4,
 "Área",
 JSON_OBJECT(
     'texto', 'Área representa o espaço interno de uma figura.',
     'exemplo', JSON_ARRAY('Quadrado = lado²', 'Retângulo = base × altura'),
     'exemploReal', JSON_ARRAY('Calcular piso', 'Quantidade de tinta necessária')
 )
),

(5,
 "O que é uma variável",
 JSON_OBJECT(
     'texto', 'Uma variável representa um valor desconhecido. É como uma caixa vazia que pode guardar qualquer número. Para resolver expressões com variáveis, substituímos a variável pelo número indicado para descobrir o resultado.',
     'exemplo', JSON_ARRAY('Se x = 3, então 2x = 6', 'Se a = 10, então a − 4 = 6'),
     'exemploReal', JSON_ARRAY('Distância = velocidade × tempo', 'Preço = quantidade × valor unitário')
 )
),

(5,
 "Expressões simples e como resolvê-las",
 JSON_OBJECT(
     'texto', 'Uma expressão combina números, variáveis e operações. Resolver significa calcular tudo substituindo variáveis. Passo a passo: 1) Substitua valores. 2) Faça multiplicações e divisões. 3) Faça somas e subtrações.',
     'exemplo', JSON_ARRAY('Se x = 4: 2x + 3 → 2(4) + 3 = 11', 'Se y = 10: y − 7 → 3'),
     'exemploReal', JSON_ARRAY('Calcular descontos', 'Determinar consumo médio')
 )
),

(5,
 "Equações básicas e como resolver",
 JSON_OBJECT(
     'texto', 'Equações têm uma igualdade e o objetivo é descobrir o valor da variável. Passo a passo para resolver: 1) Mantenha o que tem variável de um lado. 2) Passe números para o outro lado com a operação inversa. 3) Simplifique.',
     'exemplo', JSON_ARRAY('x + 5 = 12 → x = 12 − 5 → x = 7', '3x = 18 → x = 18 ÷ 3 → x = 6'),
     'exemploReal', JSON_ARRAY('Calcular tempo para terminar uma viagem', 'Descobrir preço unitário quando se conhece o total')
 )
);

SELECT * FROM modulos;
SELECT * FROM progressos;
SELECT * FROM usuarios;