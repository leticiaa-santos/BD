-- Criação do banco
DROP DATABASE IF EXISTS bibliotecaonline;
CREATE DATABASE bibliotecaonline;
USE bibliotecaonline;

-- Tabela autor
CREATE TABLE autor (
    id_autor INT AUTO_INCREMENT PRIMARY KEY,
    nome_autor VARCHAR(100) NOT NULL
);

INSERT INTO autor (nome_autor) VALUES
('Machado de Assis'),
('Carlos Souza'),
('Stephen Hawking'),
('Ruth Rocha');

-- Tabela categoria
CREATE TABLE categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome_categoria VARCHAR(50) NOT NULL
);

INSERT INTO categoria (nome_categoria) VALUES
('Romance'),
('Tecnologia'),
('Ciência'),
('Infantil');

-- Tabela editora
CREATE TABLE editora (
    id_editora INT AUTO_INCREMENT PRIMARY KEY,
    nome_editora VARCHAR(100) NOT NULL
);

INSERT INTO editora (nome_editora) VALUES
('Editora Moderna'),
('Companhia das Letras'),
('Pearson'),
('Saraiva');

-- Tabela usuario
CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    telefone VARCHAR(20)
);

INSERT INTO usuario (nome, email, telefone) VALUES
('Alice Pereira', 'alice@email.com', '11990000001'),
('Bruno Mendes', 'bruno@email.com', '11990000002'),
('Camila Souza', 'camila@email.com', '11990000003');

-- Tabela livro
CREATE TABLE livro (
    id_livro INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    ano_publicacao INT,
    id_editora INT,
    FOREIGN KEY (id_editora) REFERENCES editora(id_editora)
);

INSERT INTO livro (titulo, ano_publicacao, id_editora) VALUES
('Dom Casmurro', 1899, 2),
('Banco de Dados para Iniciantes', 2020, 3),
('O Universo', 2000, 1),
('A Galinha Ruiva', 2010, 4);

-- Tabela livro_autor (intermediária N:N)
CREATE TABLE livro_autor (
    id_livro INT,
    id_autor INT,
    PRIMARY KEY (id_livro, id_autor),
    FOREIGN KEY (id_livro) REFERENCES livro(id_livro),
    FOREIGN KEY (id_autor) REFERENCES autor(id_autor)
);

INSERT INTO livro_autor (id_livro, id_autor) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4);

-- Tabela livro_categoria (intermediária N:N)
CREATE TABLE livro_categoria (
    id_livro INT,
    id_categoria INT,
    PRIMARY KEY (id_livro, id_categoria),
    FOREIGN KEY (id_livro) REFERENCES livro(id_livro),
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);

INSERT INTO livro_categoria (id_livro, id_categoria) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4);

-- Tabela emprestimo
CREATE TABLE emprestimo (
    id_emprestimo INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    id_livro INT,
    data_emprestimo DATE,
    data_devolucao DATE,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_livro) REFERENCES livro(id_livro)
);

INSERT INTO emprestimo (id_usuario, id_livro, data_emprestimo, data_devolucao) VALUES
(1, 2, '2024-08-01', '2024-08-10'),
(2, 1, '2024-08-03', '2024-08-12'),
(3, 3, '2024-08-05', NULL);

SELECT * FROM usuario;

SELECT * FROM emprestimo;