DROP TABLE IF EXISTS VENDA, VEICULO, CARRO, CAMINHAO, UTILITARIO, VENDEDOR, CLIENTE;

CREATE TABLE VEICULO(
	cod_veiculos INT PRIMARY KEY,
    preco DECIMAL(10, 2),
    modelo VARCHAR(50)
);

-- subclasses de veículo

CREATE TABLE CARRO(
	cod_veiculos INT PRIMARY KEY,
	tamanho_motor int,
    FOREIGN KEY (cod_veiculos) REFERENCES VEICULO(cod_veiculos)
);

CREATE TABLE CAMINHAO(
	cod_veiculos INT PRIMARY KEY,
	capacidade_peso int,
    FOREIGN KEY (cod_veiculos) REFERENCES VEICULO(cod_veiculos)
);

CREATE TABLE UTILITARIO(
	cod_veiculos INT PRIMARY KEY,
	total_assentos INT,
    FOREIGN KEY (cod_veiculos) REFERENCES VEICULO(cod_veiculos)
);



CREATE TABLE VENDEDOR(
	cod_vendedor CHAR(5) PRIMARY KEY,
    nome_vendedor VARCHAR(100) NOT NULL
);

CREATE TABLE CLIENTE (
    cpf CHAR(11) PRIMARY KEY,
    nome_cliente VARCHAR(100) NOT NULL,
    -- endereço é atributo composto
    cidade VARCHAR(50),
    estado CHAR(2),
    rua VARCHAR(100)
);

CREATE TABLE VENDA (
    cod_veiculo INT,
    cpf CHAR(11),
    cod_vendedor CHAR(5),
    data_venda DATE,
    PRIMARY KEY (cod_veiculo, cpf, cod_vendedor),
    FOREIGN KEY (cod_veiculo) REFERENCES VEICULO(cod_veiculos),
    FOREIGN KEY (cpf) REFERENCES CLIENTE(cpf),
    FOREIGN KEY (cod_vendedor) REFERENCES VENDEDOR(cod_vendedor)
);

