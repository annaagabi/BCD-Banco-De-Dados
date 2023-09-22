CREATE DATABASE meu_segundo_DB;

-- Exercício 1
-- Exercício 01 – Escreva uma cláusula SQL para criar uma tabela simples 
-- chamada Países, incluindo as colunas country_id, country_name e region_id

USE  meu_segundo_DB;
-- Drop DATABASE meu_segundo_DB;
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

-- Exercício 04 - Escreva uma instrução SQL para criar uma cópia duplicada da tabela de países, incluindo estrutura e dados
-- por nome dup_countries.
CREATE TABLE dup_countries_2 AS SELECT * FROM paises;

-- Exercício 05 - Escreva uma instrução SQL para criar uma tabela de países que defina uma restrição NULL.
	CREATE TABLE IF NOT EXISTS paises_3( -- se a tabela não existir ela será criada
	country_id CHAR(4) NOT NULL PRIMARY KEY, 
    country_name VARCHAR(40) NOT NULL,
    region_id CHAR(5) DEFAULT NULL
);

-- Exercício 06 - Escreva uma instrução SQL para criar uma tabela chamada jobs incluindo as colunas job_id, job_title, min_salary, 
-- max_salary e verifique se o valor max_salary excede o limite superior de 25.000

CREATE TABLE jobs(
	job_id VARCHAR(10) NOT NULL PRIMARY KEY,
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

-- Exercício 11 - Escreva uma instrução SQL para criar uma tabela chamada países incluindo as colunas country_id, country_name e 
-- region_id e certifique-se de que a coluna country_id será um campo-chave que não conterá nenhum dado duplicado no momento da inserção.

CREATE TABLE IF NOT EXISTS paises_4(
	country_id CHAR(4) NOT NULL UNIQUE PRIMARY KEY, 
    country_name VARCHAR(40) NOT NULL,
    region_id CHAR(5)
);

-- Exercício 12 - Escreva uma instrução SQL para criar uma tabela países incluindo as colunas country_id, country_name e region_id e 
-- certifique-se de que a coluna country_id seja exclusiva e armazene um valor incrementado automaticamente.
CREATE TABLE IF NOT EXISTS paises_5(
	country_id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY, 
    country_name VARCHAR(40) NOT NULL,
    region_id CHAR(5)
);

-- Exercício 13 - Escreva uma instrução SQL para criar uma tabela países incluindo as colunas country_id, country_name e region_id e 
-- certifique-se de que a combinação das colunas country_id e region_id será exclusiva.
CREATE TABLE IF NOT EXISTS paises_6(
	country_id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY, 
    country_name VARCHAR(40) NOT NULL UNIQUE,
    region_id CHAR(5) UNIQUE
);

-- Exercício 14 - Escreva uma instrução SQL para criar uma tabela job_history incluindo as colunas Employee_id, Start_date, End_date, 
-- Job_id e Department_id e certifique-se de que a coluna Employee_id não contenha nenhum valor duplicado no momento da inserção e a 
-- coluna de chave estrangeira Job_id contenha apenas esses valores que existem na tabela de empregos

CREATE TABLE IF NOT EXISTS job_history_2(
	employee_id INT AUTO_INCREMENT PRIMARY KEY, 
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    job_id VARCHAR(10) NOT NULL,
    department_id VARCHAR(5) NOT NULL,
    CHECK(end_date LIKE '--/-- /----'),
    
    FOREIGN KEY (job_id) REFERENCES jobs(job_id)
);

-- Exercício 15 - Escreva uma instrução SQL para criar uma tabela funcionários incluindo as colunas Employee_id, First_Name, Last_Name, 
-- Email, Phone_number Hire_date, Job_id, Salary, Commission, Manager_id e Department_id e certifique-se de que a coluna Employee_id 
-- não contenha nenhum valor duplicado no momento de inserção e as colunas de chave estrangeira combinadas pelas colunas Department_id e 
-- Manager_id contêm apenas os valores de combinação exclusivos, cujas combinações existem na tabela de departamentos.
CREATE TABLE departamentos(
	Department_id CHAR(9) UNIQUE NOT NULL PRIMARY KEY,
    Manager_id CHAR(9) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS funcionarios(
	Employee_id INT AUTO_INCREMENT UNIQUE PRIMARY KEY,
    First_Name VARCHAR(30) NOT NULL,
    Last_Name VARCHAR(30) NOT NULL,
	Email VARCHAR(40),
    Phone_number CHAR(11) NOT NULL,
    Hire_date DATE NOT NULL,
    Job_id VARCHAR(10) NOT NULL,
    Salary DECIMAL (8,2),
    Commission DECIMAL (8,2),
    Manager_id VARCHAR(9) NOT NULL,
    Department_id VARCHAR(9) NOT NULL,
    
	FOREIGN KEY (Manager_id) REFERENCES departamentos(Manager_id),
	FOREIGN KEY (Department_id) REFERENCES departamentos(Department_id)
);

-- Exercício 16 - Escreva uma instrução SQL para criar uma tabela funcionários incluindo as colunas Employee_id, First_Name, Last_Name, 
-- Email, Phone_number Hire_date, Job_id, Salary, Commission, Manager_id e Department_id e certifique-se de que a coluna Employee_id 
-- não contenha nenhum valor duplicado no momento de inserção, e a coluna de chave estrangeira Department_id, referenciada pela coluna 
-- Department_id da tabela de departamentos, pode conter apenas os valores que existem na tabela de departamentos e outra coluna de chave 
-- estrangeira job_id, referenciada pela coluna Job_id da tabela de empregos, pode conter apenas aqueles valores que existem na tabela de 
-- empregos. O InnoDB Engine foi usado para criar as tabelas.

CREATE TABLE IF NOT EXISTS funcionarios_2(
	Employee_id INT AUTO_INCREMENT UNIQUE PRIMARY KEY,
    First_Name VARCHAR(30) NOT NULL,
    Last_Name VARCHAR(30) NOT NULL,
	Email VARCHAR(40),
    Phone_number CHAR(11) NOT NULL,
    Hire_date DATE NOT NULL,
    Job_id VARCHAR(10) NOT NULL,
    Salary DECIMAL (8,2),
    Commission DECIMAL (8,2),
    Manager_id VARCHAR(9) NOT NULL,
    Department_id VARCHAR(9) NOT NULL,
    
	FOREIGN KEY (Department_id) REFERENCES departamentos(Department_id),
	FOREIGN KEY (job_id) REFERENCES jobs(job_id)
) ENGINE=InnoDB;

-- Exercício 17 - Escreva uma instrução SQL para criar uma tabela funcionários incluindo colunas Employee_id, first_name, last_name, 
-- job_id, salário e certifique-se de que a coluna Employee_id não contenha nenhum valor duplicado no momento da inserção, e a coluna 
-- de chave estrangeira job_id, referenciada pela coluna job_id da tabela de empregos, pode conter apenas os valores que existem na tabela 
-- de empregos. O InnoDB Engine foi usado para criar as tabelas. A especialidade da instrução é que a ação ON UPDATE CASCADE permite 
-- realizar atualização entre tabelas e a ação ON DELETE RESTRICT rejeita a exclusão. A ação padrão é ON DELETE RESTRICT.
CREATE TABLE IF NOT EXISTS funcionarios_3(
	Employee_id INT AUTO_INCREMENT UNIQUE PRIMARY KEY,
    First_Name VARCHAR(30) NOT NULL,
    Last_Name VARCHAR(30) NOT NULL,
    Job_id VARCHAR(10) NOT NULL,
    Salary DECIMAL (8,2),
    
	FOREIGN KEY (job_id) REFERENCES jobs(job_id) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=INNODB;

-- Exercício 18 - Escreva uma instrução SQL para criar uma tabela funcionários incluindo colunas Employee_id, first_name, last_name, 
-- job_id, salário e certifique-se de que a coluna Employee_id não contenha nenhum valor duplicado no momento da inserção, e a coluna de 
-- chave estrangeira job_id, referenciada pela coluna job_id da tabela de empregos, pode conter apenas os valores que existem na tabela 
-- de empregos. O InnoDB Engine foi usado para criar as tabelas. A especialidade da instrução é que, O ON DELETE CASCADE que permite 
-- excluir registros na tabela Employees(child) que se referem a um registro na tabela jobs(parent) quando o registro na tabela pai é 
-- excluído e o ON As ações UPDATE RESTRICT rejeitam quaisquer atualizações.

CREATE TABLE IF NOT EXISTS funcionarios_4(
	Employee_id INT AUTO_INCREMENT UNIQUE PRIMARY KEY,
    First_Name VARCHAR(30) NOT NULL,
    Last_Name VARCHAR(30) NOT NULL,
    Job_id VARCHAR(10) NOT NULL,
    Salary DECIMAL (8,2),
    
	FOREIGN KEY (job_id) REFERENCES jobs(job_id) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=INNODB;


-- Exercício 19 - Escreva uma instrução SQL para criar uma tabela Employees incluindo as colunas Employee_id, First_Name, Last_Name, 
-- Job_id, Salary e certifique-se de que a coluna Employee_id não contenha nenhum valor duplicado no momento da inserção e a coluna de 
-- chave estrangeira Job_id, referenciada pelo coluna job_id da tabela de empregos, pode conter apenas os valores que existem na tabela de
-- empregos. O InnoDB Engine foi usado para criar as tabelas. A especialidade da instrução é que, a ação ON DELETE SET NULL definirá os 
-- valores da coluna de chave estrangeira na tabela filho (funcionários) como NULL quando o registro na tabela pai (trabalhos) for 
-- excluído, Suponha que a estrutura de dois trabalhos de tabela e o InnoDB Engine tenham sido usados para criar os trabalhos de tabela

CREATE TABLE IF NOT EXISTS Employees(
	Employee_id INT AUTO_INCREMENT UNIQUE PRIMARY KEY,
    First_Name VARCHAR(30) NOT NULL,
    Last_Name VARCHAR(30) NOT NULL,
    Job_id VARCHAR(10),
    Salary DECIMAL (8,2) NULL,
    
	FOREIGN KEY (job_id) REFERENCES jobs(job_id) ON DELETE SET NULL
) ENGINE=INNODB;

-- Exercício 20 - Escreva uma instrução SQL para criar uma tabela funcionários incluindo colunas Employee_id, first_name, last_name, 
-- job_id, salário e certifique-se de que a coluna Employee_id não contenha nenhum valor duplicado no momento da inserção, e a coluna de 
-- chave estrangeira job_id, referenciada pela coluna job_id da tabela de empregos, pode conter apenas os valores que existem na tabela 
-- de empregos. O InnoDB Engine foi usado para criar as tabelas. A especialidade da declaração é que as ações ON DELETE NO ACTION e ON 
-- UPDATE NO ACTION rejeitarão a exclusão e quaisquer atualizações.

CREATE TABLE IF NOT EXISTS funcionarios_4(
	Employee_id INT AUTO_INCREMENT UNIQUE PRIMARY KEY,
    First_Name VARCHAR(30) NOT NULL,
    Last_Name VARCHAR(30) NOT NULL,
    Job_id VARCHAR(10),
    Salary DECIMAL (8,2),
    
	FOREIGN KEY (job_id) REFERENCES jobs(job_id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB;
