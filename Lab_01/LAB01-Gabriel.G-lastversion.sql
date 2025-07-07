DROP DATABASE IF EXISTS MetropoleInformatica;
CREATE DATABASE MetropoleInformatica;
USE MetropoleInformatica;

CREATE TABLE Fornecedores (
    cnpj CHAR(14) PRIMARY KEY,
    nome_fantasia VARCHAR(100) NOT NULL,
    telefone VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE Funcionarios (
    cpf CHAR(11) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    carga_horaria_semanal INT NOT NULL CHECK (carga_horaria_semanal > 20),
    salario DECIMAL(10,2) NOT NULL CHECK (salario > 0)
);

CREATE TABLE Produtos (
    codigo CHAR(5) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    preco_custo DECIMAL(10,2) NOT NULL CHECK (preco_custo > 0),
    cnpj_fornecedor CHAR(14) NOT NULL,
    FOREIGN KEY (cnpj_fornecedor) REFERENCES Fornecedores(cnpj)
);

CREATE TABLE Clientes (
    numero_fidelidade INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE Vendas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    produto_codigo CHAR(5) NOT NULL,
    quantidade INT NOT NULL CHECK (quantidade > 0),
    funcionario_cpf CHAR(11),
    preco_total DECIMAL(10,2) NOT NULL CHECK (preco_total > 0),
    data_hora DATETIME NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES Clientes(numero_fidelidade),
    FOREIGN KEY (produto_codigo) REFERENCES Produtos(codigo),
    FOREIGN KEY (funcionario_cpf) REFERENCES Funcionarios(cpf)
);

INSERT INTO Fornecedores VALUES
('12345678000190', 'CDA', '84993969703'),
('98765432000155', 'MV Cell', '84975384888');

INSERT INTO Funcionarios VALUES
('71121310121', 'Tobias', 44, 1500.00),
('55127224562', 'Matheus', 25, 2000.00),
('81394766555', 'Vini Jr', 30, 3200.00);

INSERT INTO Produtos VALUES
('00001', 'Azeite', 25.00, '12345678000190'),
('00002', 'Whey Protein', 150.00, '98765432000155'),
('00003', 'PlayStation', 550.00, '12345678000190'),
('00004', 'Barra de Cereal', 5.00, '98765432000155'),
('00005', 'Notebook', 2500.00, '12345678000190');

INSERT INTO Clientes (nome) VALUES
('Gabriel'),
('Dias Jr'),
('Nedson Filho'),
('Nedson Pai'),
('Mayara'),
('Vitória'),
('Bruna'),
('Lucas'),
('Allany'),
('Zayan');

INSERT INTO Vendas (cliente_id, produto_codigo, quantidade, funcionario_cpf, preco_total, data_hora) VALUES
(1, '00001', 2, '71121310121', 50.00, '2025-04-01 10:00:00'),
(2, '00002', 1, '55127224562', 150.00, '2025-04-02 11:30:00'),
(3, '00003', 1, '81394766555', 550.00, '2025-04-03 14:45:00'),
(4, '00005', 1, NULL, 2500.00, '2025-04-04 09:15:00'),
(5, '00004', 3, '71121310121', 15.00, '2025-04-05 16:00:00');

SELECT * FROM Fornecedores;
SELECT * FROM Funcionarios;
SELECT * FROM Produtos;
SELECT * FROM Clientes;
SELECT * FROM Vendas;


SELECT 
    Vendas.id AS "Venda",
    Clientes.nome AS "Cliente",
    Produtos.nome AS "Produto",
    Funcionarios.nome AS "Funcionário",
    Fornecedores.nome_fantasia AS "Fornecedor",
    Produtos.preco_custo AS "Preço Unidade",
    Vendas.quantidade AS "Quantidade",
    Vendas.preco_total AS "Preço Total",
    Vendas.data_hora AS "Data e Hora"
FROM Vendas
JOIN Clientes ON Vendas.cliente_id = Clientes.numero_fidelidade
JOIN Produtos ON Vendas.produto_codigo = Produtos.codigo
JOIN Fornecedores ON Produtos.cnpj_fornecedor = Fornecedores.cnpj
LEFT JOIN Funcionarios ON Vendas.funcionario_cpf = Funcionarios.cpf;

CREATE VIEW Site_ProdutosFabricantes AS
SELECT 
    Produtos.nome AS "Produto",
    Fornecedores.nome_fantasia AS "Fornecedor"
FROM Produtos
JOIN Fornecedores ON Produtos.cnpj_fornecedor = Fornecedores.cnpj;

SELECT * FROM Site_ProdutosFabricantes;

ALTER TABLE Vendas
ADD COLUMN unidade VARCHAR(50) NOT NULL DEFAULT 'Matriz';

SELECT * FROM Vendas;