-- 1. Faça a inserção de dados nas tabelas, utilize o arquivo inserts.sql para incluir essas informações nas tabelas;
-- 2. Crie visualizações (views) para fazer o seguinte:
-- a. Consultar todos os produtos existentes na loja;
SELECT * FROM product;
SELECT
    p.type, 
    s.name AS loja
FROM product AS p
JOIN store AS s;

-- b. Consultar os nomes de todos os usuários;
SELECT name from users;

-- c. Consultar as lojas que vendem produtos;
SELECT * FROM product;
SELECT * FROM store;
SELECT 
	-- p.fk_sid,
	s.pk_sid,
    s.name
FROM product AS p 
JOIN store AS s ON p.fk_sid = s.pk_sid;

-- d. Consultar os endereços relacionando com os clientes;
SELECT * FROM buyer;
SELECT * FROM address;

SELECT 
	b.pk_userid,
    a.streetAddr
FROM buyer AS b 
JOIN address AS a ON b.pk_userid = a.fk_userid;

-- e. Consultar todos os produtos do tipo laptop;
SELECT * FROM product;

SELECT 
	name,
	type
FROM product 
WHERE type = "laptop";


-- f. Consultar o endereço, hora de inicio (start time) e hora final (end time) dos pontos de serviço dA mesma cidade que o usuário 
-- cujo ID é 5.
SELECT * FROM users;
SELECT * FROM address;
SELECT * FROM servicePoint;

SELECT 
    u.name,
    s.streetAddr 	AS ENDEREÇO,
    s.startTime 	AS INICIO,
    s.endTime		AS FIM
FROM users 					AS u 
JOIN comments 				AS c 	ON u.pk_userid = c.fk_userid
JOIN product 				AS p 	ON c.fk_pid = p.pk_pid
JOIN brand 					AS b 	ON p.fk_brand = b.pk_brandName
JOIN after_sales_service_at AS a 	ON a.fk_brandName = b.pk_brandName
JOIN servicePoint 			AS s 	ON a.fk_spid = s.pk_spid
WHERE u.pk_userid = 5;

-- g. Consultar a quantidade total de produtos que foram colocados no carrinho (shopping cart), considerando a loja com ID (sid) igual a 8.
SELECT * FROM products;
SELECT * FROM savetoshoppingcart;
SELECT * FROM store;

SELECT
	s.pk_sid,
	p.pk_pid AS PRODUTO,
    SUM(quantity) AS QUANTIDADE
FROM product 			AS p
JOIN savetoshoppingcart AS save ON p.pk_pid = save.pk_pid
JOIN store 				AS s 	ON p.fk_sid = s.pk_sid
WHERE s.pk_sid = 8
GROUP BY PRODUTO;
    
-- H. Consultar os comentários do produto 123456789.
SELECT * FROM product;
SELECT * FROM comments;

SELECT
	c.content
FROM comments AS c
JOIN product AS p ON p.pk_pid = c.fk_pid
WHERE p.pk_pid = 123456789;
