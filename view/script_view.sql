-- EXERCICIO 1: Crie a VIEW clientes_sp com clientes do estado de SP.
CREATE VIEW clientes_sp AS
SELECT *
FROM clientes
WHERE estado = 'SP';


-- EXERCICIO 2: Consulte a VIEW clientes_sp usando SELECT *.
SELECT * FROM clientes_sp;


-- EXERCICIO 3: Crie a VIEW clientes_upper com nomes em letras maiúsculas (UPPER).
CREATE VIEW clientes_upper AS
SELECT UPPER(nome) AS nome_maiusculo
FROM clientes;

SELECT * FROM clientes_upper;

-- EXERCICIO 4:  Tente dar UPDATE na VIEW clientes_upper. O que acontece?
UPDATE clientes_upper
SET nome_maiusculo = 'ana'
WHERE nome_maiusculo = 'ANA';

-- Aconteceu esse erro:
-- Error Code: 1348. Column 'nome_maiusculo' is not updatable

-- EXERCICIO 5: Crie a VIEW clientes_editaveis com id, nome e cidade. Altere a cidade de um cliente pela VIEW.
CREATE VIEW clientes_editaveis AS
SELECT id, nome, cidade
FROM clientes;

UPDATE clientes_editaveis
SET cidade = 'Hortolândia'
WHERE id = 2;

SELECT * FROM clientes_editaveis;

-- EXERCICIO 6:
SHOW FULL TABLES WHERE Table_type = 'VIEW';
SHOW CREATE VIEW clientes_editaveis;