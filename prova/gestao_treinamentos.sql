/*criando o banco*/
CREATE DATABASE gestao_treinamentos;
USE gestao_treinamentos;

/*Criação das tabelas*/
CREATE TABLE turmas(
	id_turma INT AUTO_INCREMENT PRIMARY KEY,
    nome_turma VARCHAR(20) NOT NULL,
    quantidade_aluno INT,
    periodo ENUM ('Manhã', 'Tarde') NOT NULL
);

CREATE TABLE alunos(
	id_aluno INT AUTO_INCREMENT PRIMARY KEY,
    nome_aluno VARCHAR(60) NOT NULL,
    numero_identificacao INT NOT NULL,
    email VARCHAR(30),
    data_registro DATE,
    id_turma INT NOT NULL,
    FOREIGN KEY(id_turma) REFERENCES turmas(id_turma)
);

CREATE TABLE instrutor(
	id_instrutor INT AUTO_INCREMENT PRIMARY KEY,
    nome_instrutor VARCHAR(80) NOT NULL,
    numero_identificacao INT NOT NULL,
    email VARCHAR(30),
    data_registro DATE
);

CREATE TABLE materia(
	id_materia INT AUTO_INCREMENT PRIMARY KEY,
    nome_materia VARCHAR(40) NOT NULL
);

CREATE TABLE atividades(
	id_atividade INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(255) NOT NULL
);

CREATE TABLE instrutor_turma(
	id_instrutor_turma INT AUTO_INCREMENT PRIMARY KEY,
    id_turma INT NOT NULL,
    FOREIGN KEY(id_turma) REFERENCES turmas(id_turma),
    id_instrutor INT NOT NULL,
    FOREIGN KEY(id_instrutor) REFERENCES instrutor(id_instrutor)
);

CREATE TABLE turma_materia(
	id_turma_materia INT AUTO_INCREMENT PRIMARY KEY,
    id_turma INT NOT NULL,
    FOREIGN KEY(id_turma) REFERENCES turmas(id_turma),
    id_materia INT NOT NULL,
    FOREIGN KEY(id_materia) REFERENCES materia(id_materia)
);

CREATE TABLE instrutor_materia(
	id_instrutor_materia INT AUTO_INCREMENT PRIMARY KEY,
    id_instrutor INT NOT NULL,
    FOREIGN KEY(id_instrutor) REFERENCES instrutor(id_instrutor),
    id_materia INT NOT NULL,
    FOREIGN KEY(id_materia) REFERENCES materia(id_materia)
);

CREATE TABLE materia_atividade(
	id_materia_atividade INT AUTO_INCREMENT PRIMARY KEY,
    id_materia INT NOT NULL,
    FOREIGN KEY(id_materia) REFERENCES materia(id_materia),
    id_atividade INT NOT NULL,
    FOREIGN KEY(id_atividade) REFERENCES atividades(id_atividade)
);


/*Inserção de dados nas tabelas*/
INSERT INTO turmas(nome_turma, quantidade_aluno, periodo)
VALUES
	("turma 02", 20, "manhã"),
    ("turma 03", 14, "tarde"),
    ("turma 04", 10, "tarde"),
    ("turma 05", 17, "manhã"),
    ("turma 06", 12, "tarde"),
    ("turma 16", 13, "manhã");
    
INSERT INTO alunos(nome_aluno, numero_identificacao, email, data_registro, id_turma)
VALUES
	("Maria", 786645, "maria@gmail.com", "2024-03-25", 2),
    ("Gabriela", 723587, "gabi@gmail.com", "2025-03-20", 4),
    ("Letícia", 426894, "leticia.ltc@gmail.com", "2025-01-15", 6),
    ("Isabela", 712548, "isa@gmail.com", "2025-02-14", 3),
    ("João", 412897, "joao@gmail.com", "2025-03-01", 1),
    ("Pedro", 265365, "pedro@gmail.com", "2025-02-25", 5);

INSERT INTO instrutor(nome_instrutor, numero_identificacao, email, data_registro)
VALUES
	("Márcia", 12345, "marcia@gmail.com", "2025-03-28"),
    ("Fernanda", 98745, "fer@gmail.com", "2025-02-21"),
    ("Dorival", 12547, "dorival@gmail.com", "2025-03-10"),
    ("Cleber", 56984, "cleber@gmail.com", "2025-02-15"),
    ("Agatha", 16984, "agatha@gmail.com", "2025-03-20"),
    ("João", 78953, "joao@gmail.com", "2025-01-26");
    
INSERT INTO materia(nome_materia)
VALUES
	("Banco de dados"),
    ("Progamação Front-End"),
    ("Algoritmos"),
    ("Segurança de dados"),
    ("Python"),
    ("Java");
    
INSERT INTO atividades(descricao)
VALUES
	("Modelagem do banco de livros"),
    ("Lista de exercícios JavaScript"),
    ("Lista de exercícios orientação objeto"),
    ("Portifólio de exercicios"),
    ("Protótipo de sistema"),
    ("Avaliação banco de dados");
    
INSERT INTO instrutor_turma(id_instrutor, id_turma)
VALUES
	(1, 6),
    (1, 3),
    (2, 4),
    (3, 6),
    (4, 1),
    (5, 2);
    
INSERT INTO turma_materia(id_turma, id_materia)
VALUES
	(1, 3),
    (1, 6),
    (2, 1),
    (3, 2),
    (4, 4),
    (5, 5),
    (6, 1);
    
INSERT INTO instrutor_materia(id_instrutor, id_materia)
VALUES
	(1, 1),
    (2, 2),
    (2, 3),
    (3, 5),
    (4, 5),
    (5, 6),
    (6, 4);
    
INSERT INTO materia_atividade(id_materia, id_atividade)
VALUES
	(1, 6),
    (1, 1),
    (2, 2),
    (2, 4),
    (3, 3),
    (4, 4),
    (5, 3);
    

/*Consulta de todos os dados das tabelas*/
SELECT * FROM alunos;

SELECT * FROM turmas;

SELECT * FROM instrutor;

SELECT * FROM materia;

SELECT * FROM atividades;

SELECT * FROM instrutor_turma;

SELECT * FROM turma_materia;

SELECT * FROM instrutor_materia;

SELECT * FROM materia_atividade;