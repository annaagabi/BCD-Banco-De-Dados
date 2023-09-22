-- criar o banco de dados turma a
CREATE DATABASE clinica_turma_a;

-- Ativar o banco para uso
USE clinica_turma_a;

CREATE TABLE sala(
	num_sala INT NOT NULL UNIQUE,
    andar INT NOT NULL UNIQUE,
    CHECK (num_sala>=1 AND num_sala<=50),
    CHECK(andar>=1 AND andar<=12),
    PRIMARY KEY (num_sala)
);

CREATE TABLE paciente(
	rg CHAR(9) NOT NULL UNIQUE,
    nome VARCHAR(40) NOT NULL,
    data_nascimento DATE NOT NULL,
    cidade VARCHAR(30) DEFAULT "ITABUNA",
    doenca VARCHAR(40) NOT NULL,
    plano_saude VARCHAR(40) NOT NULL DEFAULT "SUS",
    PRIMARY KEY(rg)
);

CREATE TABLE funcionarios(
	matricula CHAR(15) NOT NULL UNIQUE,
    nome VARCHAR(40) NOT NULL,
    data_nascimento DATE NOT NULL,
    data_admissao DATE NOT NULL,
    cargo VARCHAR(40) NOT NULL DEFAULT "Assistente Médico",
    salario FLOAT NOT NULL DEFAULT 510.00,
    PRIMARY KEY(matricula)
);

CREATE TABLE medico(
	crm CHAR(15) NOT NULL UNIQUE,
	nome VARCHAR(40) NOT NULL,
	idade INT NOT NULL,
	especialidade VARCHAR(20) NOT NULL DEFAULT "Ortopedia",
	cpf CHAR(11) NOT NULL UNIQUE,
	data_adimissao DATE NOT NULL,
    num_sala INT NOT NULL, -- vem da tabela sala
    matricula VARCHAR(15) NOT NULL UNIQUE, -- vem da tabela funcionario
    
	CHECK(idade>23),
    PRIMARY KEY (crm),
    FOREIGN KEY(num_sala) REFERENCES sala(num_sala),
    FOREIGN KEY(matricula) REFERENCES funcionarios (matricula)
);

CREATE TABLE consultas(
	codigo_consulta INT NOT NULL UNIQUE,
    data_horario DATETIME NOT NULL,
    crm_medico CHAR(15) NOT NULL,
    rg_paciente CHAR(9) NOT NULL,
    
	PRIMARY KEY(codigo_consulta),
    FOREIGN KEY(crm_medico) REFERENCES medico(crm),
    FOREIGN KEY(rg_paciente) REFERENCES paciente(rg)
);