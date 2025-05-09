CREATE DATABASE sistema_biblioteca;
USE sistema_biblioteca;

-- DROP DATABASE sistema_biblioteca;

CREATE TABLE livros(
	id_livro INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(70),
    isbn VARCHAR(13),
    descricao VARCHAR(300)
);

CREATE TABLE categoria(
	id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome_categoria VARCHAR(20)
);

CREATE TABLE autores(
	id_autor INT AUTO_INCREMENT PRIMARY KEY,
    nome_autor VARCHAR(30),
    data_nascimento DATE,
    biografia VARCHAR(300)
);

CREATE TABLE usuario(
	id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome_usuario VARCHAR(20),
    numero_identificacao INT,
    email VARCHAR(60),
    data_registro DATE
);

CREATE TABLE livro_categoria(
	id_livro_categoria INT AUTO_INCREMENT PRIMARY KEY,
    id_livro INT NOT NULL,
    FOREIGN KEY(id_livro) REFERENCES livros(id_livro),
    id_categoria INT NOT NULL,
    FOREIGN KEY(id_categoria) REFERENCES categoria(id_categoria)
);

CREATE TABLE livro_autor(
	id_livro_autor INT AUTO_INCREMENT PRIMARY KEY,
    id_livro INT NOT NULL,
    FOREIGN KEY(id_livro) REFERENCES livros(id_livro),
    id_autor INT NOT NULL,
    FOREIGN KEY(id_autor) REFERENCES autores(id_autor)
);

CREATE TABLE emprestimos(
	id_imprestimo INT AUTO_INCREMENT PRIMARY KEY,
    data_inicio DATE,
    data_retorno DATE,
    id_livro INT NOT NULL,
    FOREIGN KEY(id_livro) REFERENCES livros(id_livro),
    id_usuario INT NULL,
    FOREIGN KEY(id_usuario) REFERENCES usuario(id_usuario)
);

CREATE TABLE associacao(
	id_associacao INT AUTO_INCREMENT PRIMARY KEY,
    nivel ENUM('regular', 'premium'),
    id_usuario INT NOT NULL,
    FOREIGN KEY(id_usuario) REFERENCES usuario(id_usuario)
);

INSERT INTO livros(titulo, isbn, descricao)
VALUES
	('A Seleção', '9789000388127', 'A Seleção é uma história de romance e competição em um mundo distópico, onde jovens competem para se tornar a esposa do príncipe enquanto enfrentam dilemas emocionais e sociais.'),
    ('A Elite', '9788565765135', 'A Elite acompanha a jornada de America Singer enquanto ela lida com os conflitos emocionais e as rivalidades durante a competição para se tornar a esposa do príncipe Maxon.'),
    ('A Escolha', '9788565765142', 'A Escolha segue America Singer, que enfrenta uma decisão crucial entre seu amor por Aspen e seu compromisso com o príncipe Maxon, enquanto a competição se aproxima do fim.'),
	('Verity', '9788582354766', 'Verity é um thriller psicológico que mistura romance e mistério, onde uma escritora descobre segredos sombrios sobre a vida de uma autora famosa enquanto tenta terminar sua biografia.'),
    ('Teto para Dois', '9788551005694', 'Teto para Dois é uma história sobre uma jovem que divide um apartamento com um estranho, criando uma relação improvável enquanto ambos enfrentam desafios pessoais.'),
    ('Quarta Asa', '9788581633022', 'Quarta Asa é uma fantasia que segue a jornada de uma jovem que descobre um mundo secreto e luta para proteger suas amizades e encontrar seu verdadeiro destino.');
    
INSERT INTO categoria(nome_categoria)
VALUES
	('Romance'),
    ('Suspense'),
    ('Fantasia'),
    ('Aventura'),
    ('Autoajuda'),
    ('Ficção');
    
INSERT INTO autores(nome_autor, data_nascimento, biografia)
VALUES
	('Collen Hoover', '1979-12-11', 'Ela é uma autora americana de romances contemporâneos e New Adult, conhecida por seus livros emocionantes e por explorar temas como amor, perda e superação.'),
	("Beth O'Leary", '1992-05-17', 'Ela é uma autora britânica conhecida por seus romances contemporâneos, como Teto para Dois e A troca, que exploram temas de relacionamentos e crescimento pessoal.'),
    ('Rebecca Yarros', '1981-04-14', 'Rebecca Yarros é uma autora americana de romances contemporâneos e New Adult, conhecida por suas histórias emocionantes e com temas de superação, amor e guerra, como A Promessa de Megan.'),
    ('Kiera Cass', '1981-05-19', 'Kiera Cass é uma autora americana, conhecida pela série A Seleção, que mistura distopia, romance e competição em um futuro distópico, cativando leitores ao redor do mundo.'),
    ('Taylor Jenkins Reid', '1983-12-20', 'autora americana, famosa por seus romances contemporâneos, como O Sete Maridos de Evelyn Hugo e Daisy Jones & The Six, que exploram temas de amor, fama e complexidade humana.'),
    ('Elayne Baeta', '1997-09-4', 'autora brasileira, conhecida por suas obras de ficção e fantasia, como O Canto das Águas, que mesclam elementos de mitologia e cultura brasileira.');
    
INSERT INTO usuario(nome_usuario, numero_identificacao, email, data_registro)
VALUES
	('Raphaela', '15649', 'raphaela@gmail.com', '2023-09-15'),
    ('Marcia', '56974', 'marcia@gmail.com', '2020-04-10'),
    ('Leticia', '36985', 'leticia@gmail.com', '2024-03-25'),
    ('Gabriela', '58742', 'gabriela@gmail.com', '2025-08-14'),
    ('Luana', '74563', 'luana@gmail.com', '2024-10-02'),
    ('Francica', '23589', 'fran@gmail.com', '2025-02-22');
    
INSERT INTO livro_categoria(id_livro, id_categoria)
VALUES
	(1,1),
    (1,3),
    (2,1),
    (3,1),
    (4,1),
    (4,2),
    (4,6),
    (5,1),
    (5,6),
    (6,1),
    (6,3);
    
INSERT INTO livro_autor(id_livro, id_autor)
VALUES
	(1,4),
    (2,4),
    (3,4),
    (4,1),
    (5,2),
    (6,6);
    
INSERT INTO emprestimos(data_inicio, data_retorno, id_livro, id_usuario)
VALUES
	('2025-03-21', '2025-03-25', 6, 4),
    ('2025-04-21', '2025-04-30', 5, 6),
    ('2025-03-23', '2025-04-23', 3, 1),
    ('2025-05-25', '2025-06-23', 4, 2),
    ('2025-03-28', '2025-04-12', 2, 5),
    ('2025-04-03', '2025-04-20', 1, 2);
    
INSERT INTO associacao(nivel, id_usuario)
VALUES
	('regular', 3),
    ('regular', 6),
    ('premium', 1),
    ('regular', 5),
    ('premium', 2),
    ('premium', 4);