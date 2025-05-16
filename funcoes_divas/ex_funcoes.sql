DROP DATABASE IF EXISTS AtvGianalu;
CREATE DATABASE AtvGianalu;
USE AtvGianalu;

CREATE TABLE Cadastros(
	id_cadastro INT AUTO_INCREMENT PRIMARY KEY,
    nome_produto VARCHAR(50),
    val_produto DOUBLE,
    desconto_produto FLOAT
);

CREATE TABLE Usuarios(
	id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome_usuario VARCHAR(80),
    idade INT,
    email VARCHAR(100)
);

CREATE TABLE Pedidos(
	id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    id_cadastro INT,
    data_pedido DATETIME,
    quantidade_pediu INT,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario),
    FOREIGN KEY (id_cadastro) REFERENCES Cadastros(id_cadastro)
);

INSERT INTO Usuarios (nome_usuario, idade, email) VALUES
('Luana Cristina Dias', 28, 'lucrisdias@email.com'),
('Giovana Clara Mota', 35, 'giclaramota@email.com');

INSERT INTO Cadastros (nome_produto, val_produto, desconto_produto) VALUES
('Bolsa', 79.90, 10.0),
('Mochila', 35.50, 5.0);

INSERT INTO Pedidos (id_usuario, id_cadastro, data_pedido, quantidade_pediu) VALUES
(1, 1, '2025-05-15', 2),
(2, 2, '2025-04-10', 3);

SELECT * FROM Cadastros;
SELECT * FROM Usuarios;

SELECT Pedidos.id_pedido AS id_pedido, 
		CONCAT(Usuarios.nome_usuario, ' ', 'comprou') AS cliente, 
        Cadastros.nome_produto AS nome_produto,
        Pedidos.quantidade_pediu,
        TRUNCATE(Cadastros.val_produto, 1) as valor_unitario,
        NOW() AS data_formatada
FROM Pedidos
INNER JOIN Usuarios ON Usuarios.id_usuario = Pedidos.id_usuario
INNER JOIN Cadastros ON Cadastros.id_cadastro = Pedidos.id_cadastro;