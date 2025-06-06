-- Criar banco de dados
CREATE DATABASE IF NOT EXISTS empresa;
USE empresa;
-- Criar tabela clientes
CREATE TABLE clientes (
 id INT AUTO_INCREMENT PRIMARY KEY,
 nome VARCHAR(100),
 email VARCHAR(100),
 cidade VARCHAR(100),
 estado CHAR(2)
);
-- Inserir dados fictícios
INSERT INTO clientes (nome, email, cidade, estado) VALUES
('Ana Silva', 'ana.silva@email.com', 'Campinas', 'SP'),
('Bruno Souza', 'bruno.souza@email.com', 'Belo Horizonte', 'MG'),
('Carla Mendes', 'carla.mendes@email.com', 'São Paulo', 'SP'),
('Diego Rocha', 'diego.rocha@email.com', 'Rio de Janeiro', 'RJ'),
('Eduarda Lima', 'eduarda.lima@email.com', 'Sorocaba', 'SP'),
('Fernando Alves', 'fernando.alves@email.com', 'Curitiba', 'PR');