-- Criação do banco de dados
CREATE DATABASE e_shop_connect;

-- Ativar o banco de dados
USE e_shop_connect;

-- Tabela users
CREATE TABLE users(
	pk_userid 	INT NOT NULL,
    name 		VARCHAR(50) NOT NULL,
    phoneNumber CHAR(12) NOT NULL,
    
    PRIMARY KEY(pk_userid)
);
-- drop TABLE NAME;

-- Tabela Buyer 
CREATE TABLE buyer(
	pk_userid INT NOT NULL,
    
    PRIMARY KEY(pk_userid),
    FOREIGN KEY(pk_userid) REFERENCES users(pk_userid)
);

-- Tabela Seller
CREATE TABLE seller(
	pk_userid INT NOT NULL,
    
    PRIMARY KEY(pk_userid),
    FOREIGN KEY(pk_userid) REFERENCES users(pk_userid)
);

-- DROP TABLE bank_card;

-- Tabela Bank Card
CREATE TABLE bankCard(
    pk_cardNumber 	VARCHAR(25) NOT NULL,
    expiryDate 		DATE,
    bank 			VARCHAR(20),
    
    PRIMARY KEY(pk_cardNumber)
);

-- drop table creditCard;

-- Tabela Credit Card
CREATE TABLE creditCard(
	pk_cardNumber 	CHAR(25) NOT NULL,
    fk_userid 		INT NOT NULL,
    organization 	VARCHAR(20) NOT NULL,
    
    PRIMARY KEY(pk_cardNumber),
    FOREIGN KEY(pk_cardNumber) REFERENCES bankCard(pk_cardNumber),
    FOREIGN KEY(fk_userid) REFERENCES users(pk_userid)
);

-- Tabela Debit Card
CREATE TABLE debitCard(
	pk_cardNumber 	CHAR(25) NOT NULL,
    fk_userid 		INT NOT NULL,
    organization 	VARCHAR(20) NOT NULL,
    
    PRIMARY KEY(pk_cardNumber),
    FOREIGN KEY(pk_cardNumber) REFERENCES bankCard(pk_cardNumber),
    FOREIGN KEY(fk_userid) REFERENCES users(pk_userid)
);

-- Tabela Store
CREATE TABLE store(
	pk_sid 			INT NOT NULL,
    name 			VARCHAR(20),
    streetAddr 		VARCHAR(20),
    province 		VARCHAR(20),
	city 			VARCHAR(20),
    startDate		DATE,
    customerGrade 	INT,
    
	PRIMARY KEY(pk_sid)
);

-- Tabela Brand
CREATE TABLE brand(
	pk_brandName VARCHAR(20) NOT NULL,
    PRIMARY KEY(pk_brandName)
);

-- drop table product; 
-- Tabela Product
CREATE TABLE product(
	pk_pid 		INT NOT NULL,
    fk_sid 		INT NOT NULL,
	fk_brand 	VARCHAR(50),
    name 		VARCHAR(100),
    type 		VARCHAR(50),
	color 		VARCHAR(50),
	modelNumber VARCHAR(50),
    amount 		INT,
    price DEC(10,2),
    
    PRIMARY KEY(pk_pid),
    FOREIGN KEY(fk_sid) REFERENCES store(pk_sid),
	FOREIGN KEY(fk_brand) REFERENCES brand(pk_brandName)
);

-- Tabela Order Item
CREATE TABLE orderItem(
	pk_itemid INT NOT NULL,
    fk_pid INT NOT NULL,
    price DEC(10,2),
    creationTime DATE,
    
    PRIMARY KEY(pk_itemid),
    FOREIGN KEY(fk_pid) REFERENCES Product(pk_pid)
);

-- Tabela Order 
CREATE TABLE orders(
	pk_orderNumber 	INT NOT NULL,
	creationTime 	DATE,
	paymentStatus 	VARCHAR(12) NOT NULL,
	totalAmount 	DECIMAL(10,2),
    
    PRIMARY KEY(pk_orderNumber)
);

-- Tabela comments
CREATE TABLE comments(
	creationTime 		TIME NOT NULL,
	fk_userId 			INT NOT NULL,
	fk_pid 				INT NOT NULL,
    grade 				FLOAT,
    content 			VARCHAR(100),
    
    PRIMARY KEY(creationTime, fk_userId, fk_pid), -- Chave composta
    FOREIGN KEY(fk_userid) REFERENCES users(pk_userid),
    FOREIGN KEY(fk_pid) REFERENCES product(pk_pid)
);

-- DROP TABLE servicePoint;
-- Tabela Service Point
CREATE TABLE servicePoint(
	pk_spid 	INT NOT NULL UNIQUE,
	streetAddr 	VARCHAR(40),
	city 		VARCHAR(30),
	province 	VARCHAR(20),
	startTime	TIME, -- VARCHAR(20),
    endTime 	TIME, -- VARCHAR(20),
    
    PRIMARY KEY(pk_spid)
);

-- Tabela Save To Shopping Cart
CREATE TABLE saveToShoppingCart(
	pk_userid 	INT NOT NULL,
	pk_pid 		INT NOT NULL,
	addTime 	TIME,
    quantity 	INT,
    
    PRIMARY KEY(pk_userid, pk_pid),
    FOREIGN KEY(pk_userid) REFERENCES buyer(pk_userid),
    FOREIGN KEY(pk_pid) REFERENCES product(pk_pid)
);

-- Tabela Contain
CREATE TABLE contain(
	pk_orderNumber 	INT NOT NULL,
	fk_itemid 		INT NOT NULL,
    quantity 		INT,
    
    PRIMARY KEY(pk_orderNumber, fk_itemid),
    FOREIGN KEY(pk_orderNumber) REFERENCES orders(pk_orderNumber),
    FOREIGN KEY(fk_itemid) REFERENCES orderItem(pk_itemid)
);

-- Tabela Paymeant
CREATE TABLE payment(
	fk_orderNumber 		INT NOT NULL,
	fk_cardNumber 		VARCHAR(25) NOT NULL,
    payTime 			DATETIME,
    
    PRIMARY KEY(fk_orderNumber, fk_cardNumber),
    FOREIGN KEY(fk_orderNumber) REFERENCES orders(pk_orderNumber),
    FOREIGN KEY(fk_cardNumber) REFERENCES bankCard(pk_cardNumber)
);

-- drop TABLE address;
-- Tabela Address
CREATE TABLE address(
	pk_addid 			INT NOT NULL,
	fk_userid 			INT NOT NULL,
    name 				VARCHAR(50) ,
    city 				VARCHAR(100),
    streetAddr 			VARCHAR(100),
    province 			VARCHAR(100),
	postCode 			VARCHAR(12),
    contactPhoneNumber 	VARCHAR(20),
    
    PRIMARY KEY(pk_addid),
    FOREIGN KEY(fk_userid) REFERENCES users(pk_userid)
);

-- Tabela Deliver To
CREATE TABLE deliver_To(
    fk_addid                  INT NOT NULL,
    fk_orderNumber            INT NOT NULL,
    timeDelivered             DATE,
    PRIMARY KEY(fk_addid, fk_orderNumber),
    FOREIGN KEY(fk_addid) REFERENCES address(pk_addid),
    FOREIGN KEY(fk_orderNumber) REFERENCES orders(pk_orderNumber)
);

-- DROP  TABLE Manage;
-- Tabela Manage
CREATE TABLE manage(
	fk_userid 		INT NOT NULL,
	fk_sid			INT NOT NULL,
    setUpTime 		DATE,
    
    PRIMARY KEY(fk_userid, fk_sid),
    FOREIGN KEY(fk_userid) REFERENCES seller(pk_userid),
	FOREIGN KEY(fk_sid) REFERENCES store(pk_sid)
);

-- Tabela After Sales Service At
CREATE TABLE After_Sales_Service_At(
	fk_brandName 	VARCHAR(20) NOT NULL,
	fk_spid 		INT NOT NULL UNIQUE,

    PRIMARY KEY(fk_brandName, fk_spid),
    FOREIGN KEY(fk_brandName) REFERENCES brand(pk_brandName),
    FOREIGN KEY(fk_spid) REFERENCES servicePoint(pk_spid)
);

