-- Consultas (Queries)

-- 1 - Selecionar todos os produtos
SELECT * FROM Product;

-- 2 - Selecionar o nome dos usuários 
SELECT name FROM users;

-- 3 - Retornar todos os conteúdos dos comentários dos produto
SELECT content FROM Comments;

-- 4 - Qual endereço do usuário cujo id é igual a 21?
 SELECT streetAddr FROM address WHERE fk_userid = 21;

-- 5 - Qual o endereço da loja cujo id 39?
 SELECT streetAddr FROM store WHERE pk_sid = 39;
 
-- 6 - Os pedidos com id 74892932 e 84821231 foram pagos?
 SELECT  pk_orderNumber, paymentStatus FROM orders WHERE pk_orderNumber = "74892932" OR pk_orderNumber = "84821231";