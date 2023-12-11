-- Lista de exercícios – Criação de Views

USE e_shop_connect;

-- 1. Crie uma view que liste o nome e número de telefone de todos os usuários.
DROP VIEW IF EXISTS getNameNumberUser;
CREATE VIEW getNameNumberUser AS 
SELECT 
		name 		'Nome',
		phoneNumber 'Telefone'
FROM users;
SHOW TABLES;
SELECT * FROM getNameNumberUser;

-- 2. Crie uma view que mostre os detalhes dos produtos, incluindo nome, tipo, e preço.
CREATE VIEW getDetailsProducts AS 
SELECT 
		name 	'Nome',
        type 	'Tipo',
		price 	'Preço'
FROM product;
SELECT * FROM getDetailsProducts;

-- 3. Crie uma view que exiba os comentários dos compradores, incluindo nome do comprador, 
-- nome do produto e conteúdo do comentário.
DROP VIEW IF EXISTS getComments;
CREATE VIEW getComments AS 
SELECT 
		u.name 		'Comprador',
        p.name 		'Produto',
		c.content 	'Comentário'
FROM users u
JOIN comments c ON u.pk_userid = c.fk_userId
JOIN product p ON p.pk_pid = c.fk_pid
JOIN buyer b ON u.pk_userid = b.pk_userid;

SELECT * FROM getComments;

-- 4. Crie uma view que mostre informações de entrega, incluindo endereço, cidade e data de entrega.
CREATE VIEW getDelivery AS 
SELECT 
		a.streetAddr	'Endereço',
		a.city 			'Cidade',
		d.timeDelivered 'Data de Entrega'
FROM address a
JOIN deliver_to d ON a.pk_addid = d.fk_addid;

SELECT * FROM getDelivery;

-- 5. Crie uma view que liste todas as lojas com suas classificações de cliente.
CREATE VIEW getGradeStore AS 
SELECT 
		name			'Nome da Loja',
		customerGrade 	'Avaliação'
FROM store;

SELECT * FROM getGradeStore;

-- 6. Crie uma view que mostre os produtos agrupados por marca, incluindo a contagem de produtos em 
-- cada marca.
DROP VIEW IF EXISTS getProductByBrand;
CREATE VIEW getProductByBrand AS 
SELECT 
		COUNT(pk_pid)	'Número de Produtos',
		fk_brand		'Marca'
FROM product
GROUP BY fk_brand;

SELECT * FROM getProductByBrand;

-- 7. Crie uma view que exiba os pedidos com detalhes de pagamento, incluindo número do pedido, estado 
-- de pagamento e método de pagamento.
DROP VIEW IF EXISTS getDetailsPayment;
CREATE VIEW getDetailsPayment AS 
SELECT 
		o.pk_orderNumber	'Número do Pedido',
		o.paymentStatus 	'Estado do Pagamento',
        COALESCE('Cartão de Crédito', 'Cartão de Débito') 'Método de Pagamento'
FROM orders o
LEFT JOIN payment p ON o.pk_orderNumber = p.fk_orderNumber
LEFT JOIN creditCard c ON p.fk_cardNumber = c.pk_cardNumber
LEFT JOIN debitCard d ON p.fk_cardNumber = d.pk_cardNumber;

SELECT * FROM getDetailsPayment;

-- 8. Crie uma view que liste os produtos em estoque, incluindo nome, quantidade e preço.
DROP VIEW IF EXISTS getProductAmount;
CREATE VIEW getProductAmount AS 
SELECT 
		amount			'Quantidade',
		name			'Nome',
        price			'Preço'
FROM product;

SELECT * FROM getProductAmount;

-- 9. Crie uma view que mostre a quantidade total de itens em cada pedido.
DROP VIEW IF EXISTS getOrderTotalItens;
CREATE VIEW getOrderTotalItens AS 
SELECT 
		c.pk_orderNumber		'Pedido',
		SUM(c.quantity)			'Quantidade'
FROM contain c 
JOIN orders o ON c.pk_orderNumber = o.pk_orderNumber
GROUP BY c.pk_orderNumber;

SELECT * FROM getOrderTotalItens;

-- 10.Crie uma view que exiba o total de vendas por loja, incluindo nome da loja e total de vendas.
DROP VIEW IF EXISTS getSaleStore;
CREATE VIEW getSaleStore AS 
SELECT 
		s.name						'Nome da Loja',
		COUNT(o.pk_orderNumber)		'Total de Vendas'
FROM store s
JOIN product p ON p.fk_sid = s.pk_sid
JOIN orderitem oi ON oi.fk_pid = p.pk_pid
JOIN contain c ON oi.pk_itemid = c.fk_itemid
JOIN orders o ON c.pk_orderNumber = o.pk_orderNumber
GROUP BY s.name
ORDER BY COUNT(o.pk_orderNumber);

SELECT * FROM getSaleStore;

-- 11.Crie uma view que liste os produtos com suas avaliações médias.
CREATE VIEW getAVGGradeProduct AS 
SELECT 
		p.name			'Produto',
		AVG(c.grade)	'Avaliações Médias'
FROM product p 
LEFT  JOIN comments c ON c.fk_pid = p.pk_pid
GROUP BY p.name;

SELECT * FROM getAVGGradeProduct;

-- 12.Crie uma view que exiba informações de cartão de crédito, incluindo número do cartão e data de 
-- validade.
CREATE VIEW getCreditCardInformations AS 
SELECT 
		c.pk_cardNumber	'Número do Cartão',
		b.expiryDate	'Data de Validade'
FROM creditCard  c
JOIN bankCard b ON c.pk_cardNumber = b.pk_cardNumber;

SELECT * FROM getCreditCardInformations;

-- 13.Crie uma view que liste as marcas e a quantidade total de produtos de cada marca.
CREATE VIEW getBrands AS 
SELECT 
		SUM(p.pk_pid)	'Número de Produtos',
		fk_brand		'Marca'
FROM product 
GROUP BY fk_brand;

SELECT * FROM getBrands;

-- 14.Crie uma view que mostre os produtos mais caros, incluindo nome e preço.
CREATE VIEW getMoreExpensiveProducts AS 
SELECT 
		name			'Nome do Produto',
		price			'Preço'
FROM product
WHERE price > (
				SELECT AVG(price)
                FROM product);

SELECT * FROM getMoreExpensiveProducts;

-- 15.Crie uma view que exiba as informações de gerenciamento de loja, incluindo nome do vendedor e 
-- nome da loja
CREATE VIEW getStoreManagement AS 
SELECT 
		s.name			'Nome da Loja',
		u.name			'Nome do Gerente/ Vendedor'
FROM store s
JOIN manage m ON s.pk_sid = m.fk_sid
JOIN users u ON u.pk_userid = m.fk_userid;

SELECT * FROM getStoreManagement;