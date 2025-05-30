DROP DATABASE IF EXISTS aula_triggers;
CREATE DATABASE aula_triggers;
USE aula_triggers;

CREATE TABLE produtos (
    id INT PRIMARY KEY,
    nome VARCHAR(100),
    preco DECIMAL(10,2)
);

CREATE TABLE auditoria_precos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    produto_id INT,
    preco_antigo DECIMAL(10,2),
    preco_novo DECIMAL(10,2),
    data_alteracao DATETIME,
    usuario VARCHAR(100)
);

INSERT INTO produtos (id, nome, preco) VALUES (1, 'Monitor', 800.00);


DELIMITER $$
CREATE TRIGGER trg_auditar_preco
BEFORE UPDATE ON produtos
FOR EACH ROW
BEGIN
        INSERT INTO auditoria_precos (produto_id, preco_antigo, preco_novo, data_alteracao)
        VALUES (OLD.id, OLD.preco, NEW.preco, NOW());
END $$

DELIMITER ;

UPDATE produtos SET preco = 850.00 WHERE id = 1;
SELECT * FROM auditoria_precos;