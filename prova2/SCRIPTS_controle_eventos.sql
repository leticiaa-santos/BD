-- criando o banco com condições de existencia

DROP DATABASE IF EXISTS controle_eventos;
CREATE DATABASE IF NOT EXISTS controle_eventos;
USE controle_eventos;

-- tabela de funcionarios
CREATE TABLE funcionario(
	id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255),
    setor VARCHAR(255),
    cargo VARCHAR(255)
);

-- tabela de salas
CREATE TABLE sala(
	id_sala INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255),
    capacidade INT,
    recursos TEXT
);

-- tabela de instrutores
CREATE TABLE instrutor(
	id_instrutor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255),
    email VARCHAR(255)
);

-- tabela de eventos
CREATE TABLE evento(
	id_evento INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255),
    descricao TEXT,
    data DATE,
    horario TIME,
    id_sala INT NOT NULL,
    FOREIGN KEY (id_sala) REFERENCES sala(id_sala)
);

-- tabela de crachás
CREATE TABLE cracha(
	id_cracha INT AUTO_INCREMENT PRIMARY KEY,
    qr_code VARCHAR(255),
    data_emissao DATETIME,
    id_funcionario INT NOT NULL,
    FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario)
);

-- tabela que relaciona os funcionarios com os eventos por ID
CREATE TABLE funcionario_evento(
	id_funcionario_evento INT AUTO_INCREMENT PRIMARY KEY,
    id_funcionario INT NOT NULL,
    id_evento INT NOT NULL,
    FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario),
    FOREIGN KEY (id_evento) REFERENCES evento(id_evento)
);

-- tabela que realaciona os instrutores com o evento por ID
CREATE TABLE instrutor_evento(
	id_instrutor_evento INT AUTO_INCREMENT PRIMARY KEY,
    id_instrutor INT NOT NULL,
    id_evento INT NOT NULL,
    FOREIGN KEY (id_instrutor) REFERENCES instrutor(id_instrutor),
    FOREIGN KEY (id_evento) REFERENCES evento(id_evento)
);

-- inserindo funcionários
INSERT INTO funcionario (nome, setor, cargo)
VALUES
	('marcia', 'administrativo', 'gerente'),
    ('fernanda', 'tecnologia da informação', 'P.O.'),
    ('dorival', 'comercial', 'gerente'),
    ('francisca', 'recursos humanos', 'coordenadora'),
    ('funcionario 01', 'administrativo', 'assistente'),
    ('funcionario 02', 'tecnologia da informação', 'aprendiz'),
    ('leticia', 'financeiro', 'financeiro');
    
-- inserindo salas
INSERT INTO sala (nome, capacidade, recursos)
VALUES
	('sala 01', 23, 'a sala tem projetores e sistema de som'),
    ('sala 02', 15, 'a sala tem área para café e duas TVs'),
    ('sala 03', 35, 'a sala tem 35 caeiras disponíveis, projetor e sistema de som');
    
-- inserindo instrutores
INSERT INTO instrutor (nome, email)
VALUES
	('gabriela', 'gabi@gabi.com'),
    ('luana', 'luana@luana.com'),
    ('ana clara', 'ana@ana.com');
    
-- inserindo eventos
INSERT INTO evento (titulo, descricao, data, horario, id_sala)
VALUES
	('workshop UI/UX', 'No workshop será possível saber mais sobre UI/UX, carreiras, estudos', '2025-04-25', '14:00:00', 3),
    ('seminario redes', 'No seminário você saberá sobre redes e como atuar trabalhando', '2025-05-12', '09:20:00', 1);
    
-- inserindo crachás
INSERT INTO cracha (qr_code, data_emissao, id_funcionario)
VALUE
	('8569742356lkjh', '2025-03-23 10:30:00', 2),
    ('7548665548gryr', '2025-02-14 15:20:00', 5),
    ('5164215456ftyo', '2025-04-23 10:45:00', 1),
    ('5475113897ersg', '2025-03-14 08:30:00', 3),
    ('2666558478ncfg', '2025-05-20 12:26:00', 4);
    
-- inserindo os IDs funcionarios e os eventos para a relação
INSERT INTO funcionario_evento (id_funcionario, id_evento)
VALUE 
	(3, 1), 
    (1, 1),
    (2, 1),
    (5, 1),
    (6, 1),
    (4, 2),
    (2, 2),
    (3, 2),
    (7, 2),
    (1, 2);
    
-- inserindo os IDs instrutores e os eventos para a relação
INSERT INTO instrutor_evento (id_instrutor, id_evento)
VALUES
	(2, 1),
    (3, 2),
    (2, 2),
    (1, 1);
    
-- consultas gerais para ver todos os dados de todas as tabelas
SELECT * FROM funcionario;
SELECT * FROM sala;
SELECT * FROM evento;
SELECT * FROM instrutor;
SELECT * FROM cracha;
SELECT * FROM funcionario_evento;
SELECT * FROM instrutor_evento;

-- listar funcionários de um evento específico
SELECT 
	funcionario.nome,
    funcionario.setor,
    funcionario.cargo,
    evento.titulo AS evento
FROM funcionario_evento
INNER JOIN funcionario ON funcionario_evento.id_funcionario = funcionario.id_funcionario
INNER JOIN evento ON funcionario_evento.id_evento = evento.id_evento
WHERE
	evento.id_evento = 1;
    
-- eventos ministrados por um instrutor específico
SELECT 
	instrutor.nome,
    instrutor.email,
    evento.titulo AS eventos
FROM instrutor_evento
INNER JOIN instrutor ON instrutor_evento.id_instrutor = instrutor.id_instrutor
INNER JOIN evento ON instrutor_evento.id_evento = evento.id_evento
WHERE
	instrutor.id_instrutor = 2;
    
-- eventos realizados e suas salas
SELECT
	evento.titulo,
    evento.data,
    evento.horario,
    sala.nome AS sala
FROM evento
INNER JOIN sala ON evento.id_sala = sala.id_sala;