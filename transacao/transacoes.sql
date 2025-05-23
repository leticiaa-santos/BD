USE bibliotecaonline;

START TRANSACTION;

INSERT INTO usuario(nome, email)
VALUES ('João', 'joao@email.com');

SAVEPOINT depois_usuario;

INSERT INTO emprestimo(id_usuario, id_livro, data_emprestimo)
VALUES (LAST_INSERT_ID(), 2, CURDATE());

ROLLBACK TO depois_usuario;

COMMIT;

SELECT * FROM usuario;
SELECT * FROM emprestimo;