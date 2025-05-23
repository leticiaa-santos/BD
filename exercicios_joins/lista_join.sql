DROP DATABASE IF EXISTS biblioteca_joins;
CREATE DATABASE biblioteca_joins;
USE biblioteca_joins;

-- Tabela de autores (ID a partir de 200)
CREATE TABLE autores (
id_autor INT PRIMARY KEY,
nome_autor VARCHAR(50)
);

-- Tabela de editoras (ID a partir de 300)
CREATE TABLE editoras (
 id_editora INT PRIMARY KEY,
 nome_editora VARCHAR(50)
);

-- Tabela de livros (ID a partir de 100)
CREATE TABLE livros (
 id_livro INT PRIMARY KEY,
 titulo VARCHAR(100),
 id_autor INT,
 id_editora INT,
 FOREIGN KEY (id_autor) REFERENCES autores(id_autor),
 FOREIGN KEY (id_editora) REFERENCES editoras(id_editora)
);

-- Tabela de leitores (ID a partir de 500)
CREATE TABLE leitores (
 id_leitor INT PRIMARY KEY,
 nome_leitor VARCHAR(50)
);

-- Tabela de empréstimos (ID a partir de 400)
CREATE TABLE emprestimos (
 id_emprestimo INT PRIMARY KEY,
 id_livro INT,
 data DATE
 -- sem FOREIGN KEY para simular dados inválidos
);

-- Associação entre empréstimos e leitores
CREATE TABLE emprestimos_leitores (
 id_emprestimo INT,
 id_leitor INT
 -- sem FOREIGN KEY para simular leitor inexistente
);

-- Autores
INSERT INTO autores VALUES
(200, 'Machado de Assis'),
(201, 'George Orwell'),
(202, 'Jorge Amado'),
(203, 'Autor Fantasma'); -- não tem livro

-- Editoras
INSERT INTO editoras VALUES
(300, 'Editora Brasil'),
(301, 'Companhia das Letras'),
(302, 'Saraiva'),
(303, 'Editora Fantasma'); -- não tem livro

-- Livros
INSERT INTO livros VALUES
(100, 'Dom Casmurro', 200, 300),
(101, '1984', 201, 301),
(102, 'A Revolução dos Bichos', 201, 301),
(103, 'Capitães da Areia', 202, 302);

-- Leitores
INSERT INTO leitores VALUES
(500, 'Alice'),
(501, 'Bruno'),
(502, 'Carla');

-- Empréstimos
INSERT INTO emprestimos VALUES
(400, 100, '2024-05-01'),
(401, 101, '2024-05-02'),
(402, 104, '2024-05-03'), -- livro inexistente
(403, 105, '2024-05-04'); -- livro inexistente

-- Empréstimos-Leitores
INSERT INTO emprestimos_leitores VALUES
(400, 500),
(401, 501),
(403, 503); -- leitor inexistente

-- INNER JOIN exercício 1
SELECT emprestimos.id_emprestimo, leitores.nome_leitor, livros.titulo
FROM emprestimos
INNER JOIN livros ON livros.id_livro = emprestimos.id_livro
INNER JOIN emprestimos_leitores ON emprestimos_leitores.id_emprestimo = emprestimos.id_emprestimo
INNER JOIN leitores ON leitores.id_leitor = emprestimos_leitores.id_leitor;

-- LEFT JOIN exercicio 2
SELECT livros.titulo, autores.nome_autor
FROM livros
LEFT JOIN autores ON autores.id_autor = livros.id_autor;

-- RIGHT JOIN exercicio 3
SELECT autores.nome_autor, livros.titulo
FROM livros
RIGHT JOIN autores ON autores.id_autor = livros.id_autor;

-- FULL OUTER JOIN exercicio 4
SELECT livros.titulo, editoras.nome_editora
FROM editoras
LEFT JOIN livros ON editoras.id_editora = livros.id_editora
UNION
SELECT livros.titulo, editoras.nome_editora
FROM editoras
RIGHT JOIN livros ON editoras.id_editora = livros.id_editora;

-- CROSS JOIN exercicio 5
SELECT leitores.nome_leitor, livros.titulo
FROM livros
CROSS JOIN leitores;

-- FULL OUTER JOIN exercicio 6
SELECT nome_autor
FROM autores
UNION
SELECT nome_editora
FROM editoras;

-- LEFT JOIN com erro exercicio 7
SELECT emprestimos.id_emprestimo, livros.titulo
FROM emprestimos
LEFT JOIN livros ON livros.id_livro = emprestimos.id_livro;

-- INNER JOIN com erro exercicio 8
SELECT emprestimos_leitores.id_emprestimo, leitores.nome_leitor
FROM emprestimos_leitores
INNER JOIN leitores ON leitores.id_leitor = emprestimos_leitores.id_leitor;

-- livros com editoras, mesmo que a editora não tenha livro exercicio 9
SELECT editoras.nome_editora, livros.titulo
FROM editoras
LEFT JOIN livros ON livros.id_editora = editoras.id_editora;

-- leitores e livros que pegaram, se houver exercicio 10
SELECT leitores.nome_leitor, livros.titulo
FROM leitores
LEFT JOIN emprestimos_leitores ON emprestimos_leitores.id_leitor = leitores.id_leitor
LEFT JOIN emprestimos ON emprestimos.id_emprestimo = emprestimos_leitores.id_emprestimo
LEFT JOIN livros ON livros.id_livro = emprestimos.id_livro;

-- Todos os autores e os títulos dos livros, mesmo que não tenham livros exercício 11
SELECT autores.nome_autor, livros.titulo
FROM autores
LEFT JOIN livros ON livros.id_autor = autores.id_autor;