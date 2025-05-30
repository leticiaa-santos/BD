-- Banco:
DROP DATABASE IF EXISTS bibliotecaonline;
CREATE DATABASE bibliotecaonline;
USE bibliotecaonline;

-- Tabela: Autores (IDs de 100+)
CREATE TABLE Autores (
 id INT PRIMARY KEY,
 nome VARCHAR(100)
);

INSERT INTO Autores (id, nome) VALUES
(101, 'Machado de Assis'),
(102, 'Monteiro Lobato'),
(103, 'Clarice Lispector'),
(104, 'Paulo Coelho');

-- Tabela: Editoras (IDs de 200+)
CREATE TABLE Editoras (
 id INT PRIMARY KEY,
 nome VARCHAR(100)
);

INSERT INTO Editoras (id, nome) VALUES
(201, 'Companhia das Letras'),
(202, 'Editora Globo'),
(203, 'Rocco'),
(204, 'Saraiva');

-- Tabela: Livros (IDs de 300+)
CREATE TABLE Livros (
 id INT PRIMARY KEY,
 titulo VARCHAR(100),
 id_autor INT,
 id_editora INT,
 ano_publicacao INT,
 FOREIGN KEY (id_autor) REFERENCES Autores(id),
 FOREIGN KEY (id_editora) REFERENCES Editoras(id)
);

INSERT INTO Livros (id, titulo, id_autor, id_editora, ano_publicacao) VALUES
(301, 'Dom Casmurro', 101, 201, 1899),
(302, 'O Alienista', 101, 201, 1882),
(303, 'Reinações de Narizinho', 102, 204, 1931),
(304, 'A Hora da Estrela', 103, 203, 1977),
(305, 'O Alquimista', 104, 202, 1988);

-- Tabela: Leitores (IDs de 400+)
CREATE TABLE Leitores (
 id INT PRIMARY KEY,
 nome VARCHAR(100)
);

INSERT INTO Leitores (id, nome) VALUES
(401, 'Ana Clara'),
(402, 'Bruno Martins'),
(403, 'Carlos Souza');

-- Tabela: Emprestimos (IDs de 500+)
CREATE TABLE Emprestimos (
 id INT PRIMARY KEY,
 id_livro INT,
 id_leitor INT,
 data_emprestimo DATE,
 data_devolucao DATE,
 FOREIGN KEY (id_livro) REFERENCES Livros(id),
 FOREIGN KEY (id_leitor) REFERENCES Leitores(id)
);

INSERT INTO Emprestimos (id, id_livro, id_leitor, data_emprestimo, data_devolucao) VALUES
(501, 301, 401, '2025-05-01', '2025-05-10'),
(502, 304, 401, '2025-05-05', NULL),
(503, 303, 402, '2025-05-02', '2025-05-09');

-- exercicio 1: título e o ano de publicação dos livros cuja editora é “Companhia das Letras”. (subconsulta no Where)
SELECT titulo, ano_publicacao
FROM Livros
WHERE id_editora = (
	SELECT id FROM Editoras WHERE Editoras.nome = 'Companhia das Letras'
);

-- exercicio 2:  nomes dos autores que possuem livros da editora “Rocco”. (subconsulta no Where)
SELECT Autores.nome
FROM Autores
INNER JOIN Livros ON Livros.id_autor = Autores.id
INNER JOIN Editoras ON Editoras.id = Livros.id_editora
WHERE Editoras.id IN (
	SELECT id FROM Editoras
    WHERE nome = 'Rocco'
);

-- exercicio 3: títulos dos livros que foram emprestados por algum leitor com o nome “Ana Clara”
SELECT titulo
FROM Livros
WHERE id IN (
	SELECT id_livro
    FROM Emprestimos
		WHERE id_leitor = (
			SELECT id
            FROM Leitores
            WHERE nome = "Ana Clara"
));

-- exercicio 4: livros que ainda estão emprestados (sem data de devolução).
SELECT titulo
FROM Livros
WHERE id IN (
	SELECT id_livro
    FROM Emprestimos
		WHERE data_devolucao IS NULL
);

-- exercicio 5: nomes dos autores que escreveram livros que ainda estão emprestados (sem data de devolução)
SELECT nome
FROM Autores
WHERE id IN (
	SELECT id_autor
    FROM Livros
	WHERE id IN (
		SELECT id_livro
		FROM Emprestimos
		WHERE data_devolucao IS NULL
));

-- exercicio 6: nomes dos leitores que ainda têm livros emprestados.
SELECT nome
FROM Leitores
WHERE id IN (
	SELECT id_leitor
    FROM Emprestimos
		WHERE data_devolucao IS NULL
);

-- exercicio 7: nomes dos leitores e, ao lado, o nome do último livro que cada um pegou emprestado.
SELECT Lt.nome, L.titulo
FROM Leitores Lt
LEFT JOIN Emprestimos E ON E.id_leitor = Lt.id
LEFT JOIN Livros L ON L.id = E.id_livro
WHERE E.data_emprestimo = (
	SELECT MAX(E.data_emprestimo)
    FROM Emprestimos
    WHERE id_leitor = Lt.id
);

-- exercicio 8: livros com o nome da editora ao lado, usando subconsulta no SELECT
SELECT Livros.titulo,
	(SELECT nome FROM Editoras WHERE Editoras.id = Livros.id_editora) AS editora
FROM Livros;

-- exercicio 9:  nomes e títulos de livros emprestados atualmente, usando uma subconsulta no FROM.
SELECT T.nome, T.titulo -- Tabela temporaria para a subconsulta
FROM (
	SELECT
		E.id_livro,
        E.id_leitor,
        Lt.nome AS nome,
        L.titulo AS titulo,
        E.data_devolucao
        FROM Emprestimos E
        INNER JOIN Leitores Lt ON Lt.id = E.id_leitor
        INNER JOIN Livros L ON L.id = E.id_livro
) AS T
WHERE T.data_devolucao IS NULL;

-- exercicio 10: nomes das editoras que publicaram livros emprestados, usando uma subconsulta no FROM
SELECT sub.editora -- Tabela temporaria para a subconsulta
FROM (
	SELECT Ed.nome AS editora
    FROM Emprestimos E
    INNER JOIN Livros L ON E.id_livro = L.id
    INNER JOIN Editoras Ed ON L.id_editora = Ed.id
) AS sub;