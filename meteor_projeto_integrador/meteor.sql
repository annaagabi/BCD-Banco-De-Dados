DROP DATABASE usinagem_meteor;
CREATE DATABASE usinagem_meteor;

USE usinagem_meteor;

CREATE TABLE maquina(
	pk_id_maq 			INT NOT NULL AUTO_INCREMENT UNIQUE,
    nome_maq 			VARCHAR(100) NOT NULL,
    descricao_maq  		VARCHAR(600) NOT NULL,
    capacidade_max		INT NOT NULL,
    ultima_manutencao 	DATE NOT NULL,
    
    PRIMARY KEY (pk_id_maq)
);

CREATE TABLE operador(
    pk_id_op 			INT NOT NULL AUTO_INCREMENT UNIQUE,
    nome_op 			VARCHAR(100) NOT NULL,
    especializacao 		VARCHAR(100) NOT NULL,
    disponibilidade 	TIME NOT NULL,
    
    PRIMARY KEY (pk_id_op)
);

CREATE TABLE fornecedor(
    pk_id_forn 			INT NOT NULL AUTO_INCREMENT UNIQUE,
    nome_forn			VARCHAR(100) NOT NULL,
    endereco 			VARCHAR(100) NOT NULL,
    contato 			CHAR(14) NOT NULL,
    avaliacao_forn 		INT NOT NULL,
    
    PRIMARY KEY (pk_id_forn)
);

CREATE TABLE materia_prima(
    pk_id_mp 			INT NOT NULL AUTO_INCREMENT UNIQUE,
    fk_id_forn			INT NOT NULL,
    descricao_mp		VARCHAR(500) NOT NULL,
    quantidade_estoque 	INT NOT NULL,
    data_ultima_compra	DATE NOT NULL,
    
    PRIMARY KEY (pk_id_mp),
	FOREIGN KEY (fk_id_forn) REFERENCES fornecedor (pk_id_forn)
);

CREATE TABLE peca(
    pk_id_peca 			INT NOT NULL AUTO_INCREMENT UNIQUE,
    fk_id_mp			INT NOT NULL,
    descricao_peca		VARCHAR(500) NOT NULL,
    peso 				DEC(10,2) NOT NULL,
    dimensao			VARCHAR(80) NOT NULL,
    
    PRIMARY KEY (pk_id_peca),
	FOREIGN KEY (fk_id_mp) REFERENCES materia_prima (pk_id_mp)
);

CREATE TABLE equipamento(
    pk_id_eq			INT NOT NULL AUTO_INCREMENT UNIQUE,
    fk_id_maq			INT NOT NULL,
    nome_eq				VARCHAR(100) NOT NULL,
    descricao_eq		VARCHAR(500) NOT NULL,
    data_aquisicao		DATE NOT NULL,
    vida_util_restante	VARCHAR(20) NOT NULL,
    
    PRIMARY KEY (pk_id_eq),
	FOREIGN KEY (fk_id_maq) REFERENCES maquina (pk_id_maq)
);

CREATE TABLE manutencao_programada(
    pk_id_man			INT NOT NULL AUTO_INCREMENT UNIQUE,
    fk_id_eq			INT NOT NULL,
    fk_id_maq			INT NOT NULL,
    tipo_man			VARCHAR(100) NOT NULL,
    nome_eq				VARCHAR(500) NOT NULL,
    data_programada		DATE NOT NULL,
    responsavel_man		VARCHAR(100) NOT NULL,
    
    PRIMARY KEY (pk_id_man),
	FOREIGN KEY (fk_id_eq) REFERENCES equipamento (pk_id_eq),
    FOREIGN KEY (fk_id_maq) REFERENCES maquina (pk_id_maq)
);

CREATE TABLE inspecao(
    pk_id_insp			INT NOT NULL AUTO_INCREMENT UNIQUE,
    fk_id_peca			INT NOT NULL,
    data_insp			DATE NOT NULL,
    resultado_insp 		VARCHAR(50) NOT NULL,
    observacao_insp		VARCHAR(500) NOT NULL,
    
    PRIMARY KEY (pk_id_insp),
	FOREIGN KEY (fk_id_peca) REFERENCES peca (pk_id_peca)
);

CREATE TABLE ordem_producao(
	pk_id_ordem			INT NOT NULL AUTO_INCREMENT UNIQUE,
    fk_id_peca			INT NOT NULL,
    quantidade_ordem	INT NOT NULL,
    data_conclusao 		DATE NOT NULL,
    data_inicio 		DATE NOT NULL,
	status_ordem		VARCHAR(80) NOT NULL,
    
    PRIMARY KEY (pk_id_ordem),
	FOREIGN KEY (fk_id_peca) REFERENCES peca (pk_id_peca)
);

CREATE TABLE historico_manutencao(
	fk_id_man			INT NOT NULL,
    fk_id_eq			INT NOT NULL,
    tipo_man_realizada	VARCHAR(80) NOT NULL,
    data_man 			DATE NOT NULL,
    custo_man 			DEC(10,2) NOT NULL,
    
    PRIMARY KEY (fk_id_man),
	FOREIGN KEY (fk_id_man) REFERENCES manutencao_programada (pk_id_man),
    FOREIGN KEY (fk_id_eq) REFERENCES equipamento (pk_id_eq)
);

CREATE TABLE rejeicao(
    pk_id_rej			INT NOT NULL AUTO_INCREMENT UNIQUE,
    fk_id_peca			INT NOT NULL,
    fk_id_insp			INT NOT NULL,
    motivo_rej			VARCHAR(100) NOT NULL,
    data_rej 			DATE NOT NULL,
    acao_corretiva		VARCHAR(100) NOT NULL,
    
    PRIMARY KEY (pk_id_rej),
	FOREIGN KEY (fk_id_peca) REFERENCES peca (pk_id_peca),
    FOREIGN KEY (fk_id_insp) REFERENCES inspecao (pk_id_insp)
);

CREATE TABLE aceitacao(
    pk_id_ac			INT NOT NULL AUTO_INCREMENT UNIQUE,
    fk_id_peca			INT NOT NULL,
    fk_id_insp			INT NOT NULL,
    data_ac				DATE NOT NULL,
    destino_peca		VARCHAR(100) NOT NULL,
    observacao_ac		VARCHAR(500) NOT NULL,
    
    PRIMARY KEY (pk_id_ac),
	FOREIGN KEY (fk_id_peca) REFERENCES peca (pk_id_peca),
    FOREIGN KEY (fk_id_insp) REFERENCES inspecao (pk_id_insp)
);

CREATE TABLE historico_producao(
    pk_id_hist_prod		INT NOT NULL AUTO_INCREMENT UNIQUE,
    fk_id_peca			INT NOT NULL,
    fk_id_op			INT NOT NULL,
    fk_id_ordem			INT NOT NULL,
    fk_id_maq			INT NOT NULL,
    data_inicio			DATE NOT NULL,
	data_conclusao		DATE NOT NULL,
    lote				INT NOT NULL,
    
    PRIMARY KEY (pk_id_hist_prod),
	FOREIGN KEY (fk_id_peca) REFERENCES peca (pk_id_peca),
    FOREIGN KEY (fk_id_op) REFERENCES operador (pk_id_op),
    FOREIGN KEY (fk_id_ordem) REFERENCES ordem_producao (pk_id_ordem),
    FOREIGN KEY (fk_id_maq) REFERENCES maquina (pk_id_maq)
);
