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

-- Exercício 02 - Escreva uma cláusula SQL para criar uma tabela simples de países incluindo as colunas country_id, country_name e 
-- region_id que já existe.
-- Usando método IF NOT EXISTS

CREATE TABLE IF NOT EXISTS paises( -- se a tabela não existir ela será criada
	country_id CHAR(4) NOT NULL PRIMARY KEY, 
    country_name VARCHAR(40) NOT NULL,
    region_id CHAR(5)
);

-- Exercício 03 - Escreva uma instrução SQL para criar a estrutura de uma 
-- tabela dup_countries semelhantes a países

-- Cria uma tabela identica a tabela paises caso não exista a tabela dup_contries
CREATE TABLE IF NOT EXISTS dup_contries LIKE paises;

SHOW TABLES; -- mostra todas as tabelas existem em um banco
SHOW TABLES LIKE 'paises'; -- mostra uma tabela espicifica

-- Exercício 06 - Escreva uma instrução SQL para criar uma tabela chamada jobs incluindo as colunas job_id, job_title, min_salary, 
-- max_salary e verifique se o valor max_salary excede o limite superior de 25.000

CREATE TABLE jobs(
	job_id VARCHAR(10) NOT NULL,
    job_title VARCHAR(40) NOT NULL,
    min_salary DECIMAL(6,2),
    max_salary DECIMAL(6,2),
    CHECK(max_salary<=25000)
);

-- Exercício 07 - Escreva uma instrução SQL para criar uma tabela chamada países incluindo as colunas country_id, country_name e 
-- region_id e certifique-se de que nenhum país, exceto Itália, Índia e China, será inserido na tabela.


CREATE TABLE countries_2(
	country_id VARCHAR(2) NOT NULL PRIMARY KEY, 
    country_name VARCHAR(40) NOT NULL,
    region_id CHAR(5),
    -- CHECK (country_name = "ITALIA" OR country_name = "ÍNDIA" OR country_name = "CHINA")
    CHECK(country_name IN ('ITALIA', 'ÍNDIA', 'CHINA'))
);

-- Exercício 08 - Escreva uma instrução SQL para criar uma tabela chamada job_history incluindo as colunas Employee_id, start_date, 
-- end_date, job_id e Department_id e certifique-se de que o valor da coluna end_date será inserido no momento da inserção no formato 
-- como '--/-- /----'.

CREATE TABLE job_history(
	employee_id INT AUTO_INCREMENT PRIMARY KEY, -- Faz um incremento automatico na coluna
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    job_id VARCHAR(10) NOT NULL,
    department_id VARCHAR(5) NOT NULL,
    CHECK(end_date LIKE '--/-- /----')
);

-- Exercício 09 - Escreva uma instrução SQL para criar uma tabela chamada países incluindo as colunas country_id, country_name e 
-- region_id e certifique-se de que nenhum dado duplicado na coluna country_id será permitido no momento da inserção.

CREATE TABLE countries_3(
	country_id VARCHAR(2) NOT NULL UNIQUE, 
    country_name VARCHAR(40) NOT NULL,
    region_id CHAR(5)
);

-- Exercício 10 - Escreva uma instrução SQL para criar uma tabela chamada jobs incluindo as colunas job_id, job_title, min_salary e 
-- max_salary e certifique-se de que o valor padrão para job_title esteja em branco e min_salary seja 8000 e max_salary seja NULL será 
-- inserido automaticamente no momento de inserção se nenhum valor for atribuído às colunas especificadas.

CREATE TABLE jobs_2(
	job_id VARCHAR(10) NOT NULL,
    job_title VARCHAR(40) NOT NULL DEFAULT '',
    min_salary DECIMAL(6,2) DEFAULT 8000,
    max_salary DECIMAL(6,2) DEFAULT NULL
);
