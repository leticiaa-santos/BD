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
	VALUES ('Leticia', 'USR0011', 'leticia@email.com', '2023-01-10', 'regular');

SELECT * FROM Usuario;

DELETE FROM Usuario
WHERE id = 412;

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

drop trigger tgr_insert_emprestimo;