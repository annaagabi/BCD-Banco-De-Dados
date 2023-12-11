-- AULA SOBRE STORED PROCEDURES

-- USE eshop_connect_a;
USE e_shop_connect;

--  1. Crie uma stored procedure que retorne todos os usuários que são compradores.
DELIMITER $$ -- Funciona apenas para a estrutura da Procedure
DROP PROCEDURE IF EXISTS getBuyers;

CREATE PROCEDURE getBuyers()

BEGIN
	SELECT * FROM users
    WHERE pk_userid IN (SELECT pk_userid FROM buyer);
END$$

-- 2. Crie uma stored procedure que insira um novo produto na tabela Product.
DELIMITER $$ 
DROP PROCEDURE IF EXISTS insertProduct;

CREATE PROCEDURE insertProduct(
	IN p_pk_pid 		INT,
    IN p_fk_sid 		INT,
    IN p_fk_brand 		VARCHAR(50),
    IN p_name			VARCHAR(100),
    IN p_type			VARCHAR(50),
    IN p_modelNumber	VARCHAR(50),
    IN p_color			VARCHAR(50),
    IN p_amount			INT,
    IN p_price			DEC(10,2)
)

BEGIN
	INSERT INTO product(pk_pid, fk_sid, fk_brand, name, type, modelNumber, color, amount, price)
    VALUES(p_pk_pid, p_fk_sid, p_fk_brand, p_name, p_type, p_modelNumber, p_color, p_amount, p_price);
END$$

-- 3. Crie uma stored procedure que atualize a quantidade de um produto com base no seu ID
DELIMITER $$ 
DROP PROCEDURE IF EXISTS updateProductAmount;

CREATE PROCEDURE updateProductAmount(
	IN p_pk_pid 		INT,
    IN p_newAmount		INT
)

BEGIN
	UPDATE product
    SET amount = p_newAmount
    WHERE pk_pid = p_pk_pid;
END$$

-- 4. Crie uma stored procedure que retorne o total de vendas para uma loja específica.
DELIMITER $$ 
DROP PROCEDURE IF EXISTS getStoreTotalSales;

CREATE PROCEDURE getStoreTotalSales(
	IN p_fk_sid 		INT,
    OUT p_totalSales	INT
)

BEGIN
	SELECT SUM(oi.price) INTO p_totalSales
    FROM orderitem oi
    JOIN product p ON oi.fk_pid = p.pk_pid
    WHERE p.fk_sid = p_fk_sid;
END$$

-- 5. Crie uma stored procedure que liste todos os produtos de uma determinada marca.
DELIMITER $$ 
DROP PROCEDURE IF EXISTS getProductByBrand;

CREATE PROCEDURE getProductByBrand(
	IN p_fk_brand	VARCHAR(50)
)

BEGIN
	SELECT * FROM product
    WHERE fk_brand = p_fk_brand;
END$$

-- 6. Crie uma stored procedure que insira um novo comentário de um comprador para um produto.
SELECT * FROM comments;

DELIMITER $$ 
DROP PROCEDURE IF EXISTS insertComment;

CREATE PROCEDURE insertComment(
    IN p_fk_userid INT, 
    IN p_fk_pid INT, 
    IN p_grade FLOAT, 
    IN p_content VARCHAR(500)
)

BEGIN
	INSERT INTO comments (creationTime, fk_userid, fk_pid, grade, content)
    VALUES(CURRENT_DATE, p_fk_userid, p_fk_pid, p_grade, p_content);
END$$

-- 7. Crie uma stored procedure que retorne todos os pedidos feitos por um comprador específico.
SELECT * FROM orders;

-- Revisar, pois a tabela ORDERS não tem USERID
DELIMITER $$ 
DROP PROCEDURE IF EXISTS getBuyerOrders;

CREATE PROCEDURE getBuyerOrders(
    IN p_fk_userid INT, 
)

BEGIN
	SELECT * FROM orders
    WHERE p_fk_userid = fk_userid
END$$

-- 8. Crie uma stored procedure que cancele um pedido com base no número do pedido.
DELIMITER $$ 
DROP PROCEDURE IF EXISTS cancelOrder;

CREATE PROCEDURE cancelOrder(
    IN p_pk_orderNumber INT
)

BEGIN
	DELETE FROM orders
    WHERE pk_orderNumber = p_pk_orderNumber;
END$$

-- 9. Crie uma stored procedure que retorne o total de itens em um pedido específico.
DELIMITER $$ 
DROP PROCEDURE IF EXISTS getOrderTotalItems;

CREATE PROCEDURE getOrderTotalItems(
	IN p_pk_orderNumber	INT,
    OUT p_totalItens	INT
)

BEGIN
	SELECT COUNT(fk_itemid) INTO p_totalItens
    FROM contain
    WHERE p_pk_orderNumber = pk_orderNumber;
END$$

-- 10.Crie uma stored procedure que liste todos os produtos em estoque em uma determinada loja.
DELIMITER $$ 
DROP PROCEDURE IF EXISTS getStoreInventory;

CREATE PROCEDURE getStoreInventory(
    IN p_fk_sid INT
)

BEGIN
	SELECT * FROM product
    WHERE p_fk_sid = fk_sid AND amount > 0;
END$$

-- 11.Crie uma stored procedure que retorne o nome e a avaliação média de um produto específico.
DELIMITER $$ 
DROP PROCEDURE IF EXISTS getProductAverageRating;

CREATE PROCEDURE getProductAverageRating(
    IN p_fk_pid 	INT,
    OUT p_avgRating FLOAT
)

BEGIN
	SELECT AVG(grade) INTO p_avgRating
    FROM comments
    WHERE p_fk_pid = fk_pid;
END$$

-- 12.Crie uma stored procedure que atualize o número de pontos de serviço de uma marca específica.
DELIMITER $$ 
DROP PROCEDURE IF EXISTS updateServicePoint;

CREATE PROCEDURE updateServicePoint(
	IN p_brandName				VARCHAR(20),
    IN p_newServicePoint		INT
)

BEGIN
	UPDATE servicepoint
    SET pk_spid = p_newServicePoint
    WHERE fk_brandname = p_brandName;
END$$

-- 13.Crie uma stored procedure que liste todos os pedidos feitos com um determinado cartão de crédito.
DELIMITER $$ 
DROP PROCEDURE IF EXISTS getOrdersByCreditCard;

CREATE PROCEDURE getOrdersByCreditCard(
    IN p_creditCardNumber 	VARCHAR(25)
)

BEGIN
	SELECT * FROM orders
    WHERE pk_orderNumber IN (
								SELECT fk_orderNumber 
                                FROM payment
                                WHERE fk_cardNumber = p_creditCardNumber
                                );
END$$

-- 14.Crie uma stored procedure que retorne o endereço de entrega de um pedido específico.
DELIMITER $$ 
DROP PROCEDURE IF EXISTS getDeliveryAddress;

CREATE PROCEDURE getDeliveryAddress(
    IN p_fk_orderNumber		INT,
    OUT p_fk_address 		VARCHAR(200)
)

BEGIN
	SELECT CONCAT(a.streetAddr, ',',a.city ,',', a.province) INTO p_fk_address
    FROM deliver_to d
    JOIN address a ON d.fk_addid = a.pk_addid 
    WHERE d.fk_orderNumber = p_fk_address;
END$$

-- 15.Crie uma stored procedure que retorne o nome e a quantidade total de produtos de uma determinada marca em todas as lojas
DELIMITER $$ 
DROP PROCEDURE IF EXISTS getTotalProductsByBrand;

CREATE PROCEDURE getTotalProductsByBrand(
    IN p_fk_brand			VARCHAR(50),
    OUT p_totalQuantity 	INT
)

BEGIN
	SELECT SUM(amount) INTO p_totalQuantity 
    FROM product
    WHERE fk_brand = p_fk_brand;
END$$