-- drop DATABASE REVENDEDORA_CARROS;
CREATE DATABASE REVENDEDORA_CARROS;

USE REVENDEDORA_CARROS;

CREATE TABLE automoveis (
    pk_renavam INT PRIMARY KEY UNIQUE,
    placa VARCHAR(7) NOT NULL,
    marca VARCHAR(30) NOT NULL,
    modelo VARCHAR(30) NOT NULL,
    ano_fabricacao DATE NOT NULL,
    ano_modelo DATE NOT NULL,
    cor VARCHAR(20) NOT NULL,
    motor VARCHAR(20) NOT NULL,
    numero_portas INT NOT NULL,
    tipo_combustivel VARCHAR(20) NOT NULL,
    preco FLOAT NOT NULL
    );

 -- drop TABLE clientes;
CREATE TABLE clientes (
    pk_codigo_cliente INT UNIQUE,
    nome VARCHAR(30) NOT NULL,
    sobrenome VARCHAR(30) NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    rua VARCHAR(50) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    complemento VARCHAR(50),
    bairro VARCHAR(40) NOT NULL,
    cidade VARCHAR(40) NOT NULL,
    estado CHAR(2) NOT NULL,
    cep CHAR(10) NOT NULL,
    
    PRIMARY KEY(pk_codigo_cliente)
    );
    
-- drop TABLE vendedores;
CREATE TABLE vendedores (
    pk_Codigo_Vendedor INT UNIQUE,
    nome VARCHAR(30) NOT NULL,
    sobrenome VARCHAR(30) NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    rua VARCHAR(50) NOT NULL UNIQUE,
    numero VARCHAR(10) NOT NULL,
    complemento VARCHAR(50),
    bairro VARCHAR(40) NOT NULL,
    cep CHAR(10) NOT NULL,
    cidade VARCHAR(40) NOT NULL,
    estado CHAR(2) NOT NULL,
    data_admissao DATE NOT NULL,
    salario FLOAT NOT NULL,
    
    PRIMARY KEY(pk_Codigo_Vendedor)
);

-- DROP TABLE endereco;
CREATE TABLE endereco(
	pk_id CHAR(10) UNIQUE,
	fk_rua VARCHAR(50) NOT NULL,
    fk_numero VARCHAR(10) NOT NULL,
    fk_complemento VARCHAR(50),
    fk_bairro VARCHAR(40) NOT NULL,
    fk_cidade VARCHAR(40) NOT NULL,
    fk_estado CHAR(2) NOT NULL,
    fk_cep CHAR(10) NOT NULL,
    
	PRIMARY KEY(pk_id),
    FOREIGN KEY(fk_rua) REFERENCES clientes(rua),
    FOREIGN KEY(fk_numero) REFERENCES clientes(numero),
    FOREIGN KEY(fk_complemento) REFERENCES clientes(complemento),
    FOREIGN KEY(fk_bairro) REFERENCES clientes(bairro),
	FOREIGN KEY(fk_cep) REFERENCES clientes(cep),
    FOREIGN KEY(fk_estado) REFERENCES clientes(estado),
    FOREIGN KEY(fk_cidade) REFERENCES clientes(cidade),
    
	FOREIGN KEY(fk_rua) REFERENCES vendedores(rua),
    FOREIGN KEY(fk_numero) REFERENCES vendedores(numero),
    FOREIGN KEY(fk_complemento) REFERENCES vendedores(complemento),
    FOREIGN KEY(fk_bairro) REFERENCES vendedores(bairro),
	FOREIGN KEY(fk_cep) REFERENCES vendedores(cep),
    FOREIGN KEY(fk_estado) REFERENCES vendedores(estado),
    FOREIGN KEY(fk_cidade) REFERENCES vendedores(cidade)
);

-- DROP TABLE vendas;

CREATE TABLE vendas (
    pk_codigo_venda INT UNIQUE,
    fk_codigo_cliente INT NOT NULL,
    fk_codigo_vendedor INT NOT NULL,
    fk_renavam INT NOT NULL,
    Preco_Pago FLOAT NOT NULL,
    Data_venda DATE NOT NULL,
	
	 PRIMARY KEY(pk_codigo_venda),
     FOREIGN KEY(fk_codigo_cliente) REFERENCES clientes(pk_codigo_cliente),
     FOREIGN KEY(fk_codigo_vendedor) REFERENCES vendedores(pk_codigo_vendedor),
     FOREIGN KEY(fk_renavam) REFERENCES automoveis(pk_renavam)
);