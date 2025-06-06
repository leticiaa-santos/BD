USE BibliotecaOnline;

-- EXERCICIO 1: Crie uma trigger que insira os dados do usuário excluído na tabela UsuarioExcluido.

CREATE TABLE UsuarioExcluido (
 id INT,
 nome VARCHAR(100),
 email VARCHAR(100),
 data_exclusao DATE
);


DELIMITER $

CREATE TRIGGER tgr_delete_usuarios
BEFORE DELETE ON Usuario
FOR EACH ROW
BEGIN
	INSERT INTO UsuarioExcluido(id, nome, email, data_exclusao)
    VALUES(OLD.id, OLD.nome, OLD.email, NOW());
END;

$
DELIMITER ;

INSERT INTO Usuario (nome, numero_identificacao, email, data_cadastro, nivel_associacao) 
	VALUES ('Leticia Santos', 'USR0011', 'leticia@email.com', '2023-01-10', 'regular');

SELECT * FROM Usuario;

DELETE FROM Usuario
WHERE id = 413;

SELECT * FROM UsuarioExcluido;

-- EXERCICIO 2: Crie uma trigger que preenche data_emprestimo com a data atual se ela vier nula.
DELIMITER $

CREATE TRIGGER tgr_insert_emprestimo
BEFORE INSERT ON Emprestimo
FOR EACH ROW
BEGIN
	IF NEW.data_emprestimo IS NULL THEN
        SET NEW.data_emprestimo = CURDATE();
    END IF;
END;

$
DELIMITER ;

INSERT INTO Emprestimo (usuario_id, livro_id, data_devolucao_limite, data_devolucao) 
VALUES 
(410, 301, '2024-01-20', '2024-01-18');

SELECT * FROM Emprestimo;


-- EXERCICIO 3: Crie uma trigger para registrar toda vez que o nome de um livro for alterado.

CREATE TABLE LogTituloLivro (
 id_livro INT,
 titulo_antigo VARCHAR(200),
 titulo_novo VARCHAR(200),
 data_alteracao DATE
);

DELIMITER $

CREATE TRIGGER tgr_update_livro
AFTER UPDATE ON livro
FOR EACH ROW
BEGIN
	INSERT INTO LogTituloLivro (id_livro, titulo_antigo, titulo_novo, data_alteracao)
    VALUES
		(OLD.id, OLD.titulo, NEW.titulo, CURDATE());
END;

$
DELIMITER ;

SELECT * FROM livro;

UPDATE livro
SET titulo = 'Todo esse tempo'
WHERE id = 305;

SELECT * FROM livro;
SELECT * FROM LogTituloLivro;


-- EXERCICIO 4: Crie uma trigger que registre todo novo usuário em uma tabela de log.

CREATE TABLE LogNovoUsuario (
 id_usuario INT,
 nome VARCHAR(100),
 data_criacao DATE
);

DELIMITER $

CREATE TRIGGER tgr_insert_usuario
AFTER INSERT ON usuario
FOR EACH ROW
BEGIN
	INSERT INTO LogNovoUsuario (id_usuario, nome, data_criacao)
    VALUES
		(NEW.id, NEW.nome, CURDATE());
END;

$
DELIMITER ;

INSERT INTO Usuario (nome, numero_identificacao, email, data_cadastro, nivel_associacao) 
	VALUES ('Leticia Oliveira', 'USR0015', 'leticialtc@email.com', '2023-06-06', 'regular');

SELECT * FROM usuario;

SELECT * FROM LogNovoUsuario;


-- EXERCICIO 5: Crie uma trigger que grave o título e o ISBN de todo novo livro inserido.

CREATE TABLE LogInsercaoLivro (
 id_livro INT,
 titulo VARCHAR(200),
 isbn VARCHAR(20),
 data_insercao DATE
);

DELIMITER $

CREATE TRIGGER tgr_insert_livro
AFTER INSERT ON livro
FOR EACH ROW
BEGIN
	INSERT INTO LogInsercaoLivro (id_livro, titulo, isbn, data_insercao)
    VALUES
		(NEW.id, NEW.titulo, NEW.isbn, CURDATE());
END;

$
DELIMITER ;

INSERT INTO Livro (titulo, isbn, descricao) 
VALUES
	('Melhor do que nos filmes', '978123548325', 'Um romance de filme.');
    
SELECT * FROM livro;
SELECT * FROM LogInsercaoLivro;