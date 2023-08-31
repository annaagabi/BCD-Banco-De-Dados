CREATE DATABASE meu_segundo_DB;

-- Exercício 1
-- Exercício 01 – Escreva uma cláusula SQL para criar uma tabela simples 
-- chamada Países, incluindo as colunas country_id, country_name e region_id

USE  meu_segundo_DB;

CREATE TABLE paises(
	country_id CHAR(4) NOT NULL PRIMARY KEY, -- PRIMARY KEY é a chave primária / Uma chave primária não pode ser nula (usar NOT NULL)
    country_name VARCHAR(40) NOT NULL,
    region_id CHAR(5)
);