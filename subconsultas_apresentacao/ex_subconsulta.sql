create database subquery_aula; 
use subquery_aula;
-- drop database subquery_aula;
-- Criar tabelas
CREATE TABLE clientes (
 id INT PRIMARY KEY,
 nome VARCHAR(50)
);
CREATE TABLE pedidos (
 id INT PRIMARY KEY,
 cliente_id INT,
 valor DECIMAL(10,2)
);
-- Inserir dados
INSERT INTO clientes (id, nome) VALUES (1, 'Ana'), (2, 'Bruno'), (3, 'Clara'), (4, 'Daniel'), 
(5, 'Kauan');
INSERT INTO pedidos (id, cliente_id, valor) VALUES 
 (1, 1, 1200.00), (2, 1, 300.00), (3, 2, 600.00), (4, 3, 50.00), (5, 2, 800.00), (6, 5, 99.00);
 
-- exercicio 1 - subconsulta linha única
SELECT nome
FROM clientes
WHERE id = (SELECT cliente_id FROM pedidos WHERE valor = (SELECT MAX(valor) FROM pedidos));

-- exercicio 2 - subconsulta multiplas linhas
SELECT nome
FROM clientes
WHERE id IN (SELECT cliente_id FROM pedidos WHERE valor < 100.00);

-- exercicio 3 - subconsulta correlacionada
SELECT nome
FROM clientes
WHERE EXISTS(
	SELECT 1
    FROM pedidos
    WHERE pedidos.cliente_id = clientes.id AND pedidos.valor > 1000.00
);