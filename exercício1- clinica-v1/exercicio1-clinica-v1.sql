-- Isto é um comentario

-- Criar o banco de dados clinica
CREATE DATABASE clinica_turmaA;

-- Ativar o banco de dados
USE clinica_turmaA;

CREATE TABLE sala(
	numero_sala int NOT NULL, -- O "int' também pode ser maiúsculo
    andar INT NOT NULL,
    CHECK(numero_sala>1 and numero_sala<50), -- O Check é como se fosse um "if"
	CHECK(andar<12)
);
CREATE TABLE medicos(
	crm CHAR (15) NOT NULL UNIQUE,
    nome VARCHAR(40) NOT NULL,
    idade INT,
    especialidade CHAR(20) NOT NULL DEFAULT "ORTOPEDIA", -- O DEFAULT é para estabelecer um padrão
    cpf CHAR(20) NOT NULL,
    data_admissao DATE NOT NULL,
    CHECK(idade>23)
);
CREATE TABLE pacientes(
	rg CHAR (9) NOT NULL UNIQUE,
    nome VARCHAR(40) NOT NULL,
    data_nascimento DATE NOT NULL,
    cidade VARCHAR(30) DEFAULT "ITABUNA",
    doenca VARCHAR(40) NOT NULL,
    plano_saude VARCHAR(40) NOT NULL DEFAULT "SUS"
);
CREATE TABLE funcionarios(
	matricula CHAR (15) NOT NULL UNIQUE,
    nome VARCHAR(40) NOT NULL,
    data_nascimento DATE NOT NULL,
    data_admissao DATE NOT NULL,
    cargo VARCHAR(40) NOT NULL DEFAULT "ASSISTENTE  MEDICO",
    salario FLOAT NOT NULL DEFAULT "510.00"
);
CREATE TABLE consultas(
	codigo_consulta INT UNIQUE NOT NULL,
    data_horario DATETIME
);