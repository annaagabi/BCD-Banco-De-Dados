-- Executando as Procedures

-- GET BUYERS
CALL getBuyers();

-- INSERT PRODUCT
CALL insertProduct(9, 8, "Dell", "Notebook Dell Inspirion 8", "laptop", "104585461", "Blue", 25, 860);
SELECT * FROM product;

-- UPDATE PRODUCT
CALL updateProductAmount(9, 30);
SELECT * FROM product;

-- GET STORE TOTAL SALES
CALL getStoreTotalSales(8, @a);
CALL getStoreTotalSales(218, @b);

SELECT @a, @b FROM product;
SELECT * FROM product;
SELECT * FROM orderitem;

-- GET PRODUT BY BRAND
CALL getProductByBrand("Dell");

-- INSERT COMMENTS 
CALL insertComment(24, 7, 4.5, "I love my product");
SELECT * FROM comments;

-- GET BUYER ORDERS
CALL getBuyerOrders();
SELECT * FROM orders;

-- CANCEL ORDERS
SELECT * FROM orders;
CALL cancelOrder(87291231);

-- GET ORDER TOTAL ITEMS
SELECT * FROM contain;
CALL getOrderTotalItems(87291231, @a);
SELECT @a FROM contain;

-- GET STORE INVENTORY
CALL getStoreInventory(8);

-- GET PRODUCT AVERAGE RATING
CALL getProductAverageRating(8, @a);
SELECT @a FROM comments;

-- UPDATE SERVICE POINT
SELECT * FROM servicepoint;
CALL updateServicePoint("Dell",9);

-- GET ORDERS BY CREDIT CARD
SELECT * FROM creditCard;
CALL getOrdersByCreditCard('4023 1231 3431 8623');

-- GET DELIVERY ADDRESS
SELECT * FROM deliver_to;
CALL getDeliveryAddress(87291231, @g);
SELECT @g FROM deliver_to;

-- GET TOTAL PRODUCTS BY BRAND
SELECT * FROM product;
CALL getTotalProductsByBrand('Microsoft', @p);
SELECT @p FROM product;