-- view для таблицы client
CREATE OR REPLACE VIEW database_project.client_view AS
    SELECT
        'Имя клиента: ' || client_nm AS name,
        'Фамилия клиента: ' || client_surname AS surname,
        'Логин клиента: ' || client_username AS username,
        '1-й символ пароля клиента: ' ||
        overlay(client_password PLACING '*****' FROM 2 FOR 300) AS password_mask
    FROM database_project.client
    ORDER BY client_nm, client_surname, client_username;

SELECT * FROM database_project.client_view;

-- view для таблицы order
CREATE OR REPLACE VIEW database_project.order_view AS
    SELECT
        'Номер заказа: ' || order_num AS number,
        'Статус заказа: ' || order_status AS status,
        'Дата заказа: ' ||
         date(order_dttm) AS date
    FROM database_project.order
    ORDER BY order_num;

SELECT * FROM database_project.order_view;

-- view для таблиц seller, seller_store и store
CREATE OR REPLACE VIEW database_project.seller_info_view AS
    SELECT
        'ID продавца: ' || seller.seller_id AS seller_id,
        'ID магазина: ' || store.store_id AS store_id,
        'Имя продавца: ' || seller_nm AS seller_name,
        'Название магазина: ' || store_nm AS store_name
    FROM database_project.seller AS seller
    JOIN database_project.seller_store ss ON seller.seller_id = ss.seller_id
    JOIN database_project.store store ON store.store_id = ss.store_id
    ORDER BY seller_nm, store_nm;

SELECT * FROM database_project.seller_info_view;

-- view для таблиц client, order_client, order
CREATE OR REPLACE VIEW database_project.orders_of_client_view AS
    SELECT
        'Имя клиента: ' || client_nm AS name,
        'Фамилия клиента: ' || client_surname AS surname,
        'Логин клиента: ' || client_username AS username,
        'Номер заказа: ' || order_num AS order_number,
        'Статус заказа: ' || order_status AS order_status,
        'Дата заказа: ' ||
         date(order_dttm) AS order_date
    FROM database_project.client AS client
    JOIN database_project.order_client oc ON client.client_id = oc.client_id
    JOIN database_project.order ord ON ord.order_id = oc.order_id
    ORDER BY client_nm, client_surname, client_username;

SELECT * FROM database_project.orders_of_client_view;

-- view для таблиц store, storage_of_product, product со всей информацией об актуальных товарах в магазинах
CREATE OR REPLACE VIEW database_project.store_products_view AS
    SELECT
        'ID магазина: ' || store.store_id AS store_id,
        'ID товара: ' || product.product_id AS product_id,
        'Название магазина: ' || store_nm AS store_name,
        'Название товара: ' || product.product_nm AS product_nm,
        'Запасы товара: ' || storage.storage_cnt AS storage_cnt,
        'Цена товара: ' || product.product_price AS product_price
    FROM database_project.store AS store
    JOIN database_project.storage_of_product storage ON store.store_id = storage.store_id
    JOIN database_project.product product ON product.product_id = storage.product_id
    ORDER BY store_nm, product_nm;

SELECT * FROM database_project.store_products_view;

-- view для таблиц order, position, product_logs со всей информацией о товарах в заказах.
CREATE OR REPLACE VIEW database_project.order_products_view AS
    SELECT
        'ID заказа: ' || ord.order_id AS order_id,
        'ID товара: ' || pos.product_id AS product_id,
        'Номер заказа: ' || order_num AS order_number,
        'Название товара: ' || pr.product_nm AS product_nm,
        'Количество товара: ' || position_cnt AS position_cnt,
        'Цена товара: ' || pr.product_price AS product_price,
        'Статус заказа: ' || order_status AS order_status,
        'Дата заказа: ' || date(order_dttm) AS order_date
        FROM database_project.order AS ord
        JOIN database_project.position pos ON ord.order_id = pos.order_id
        JOIN database_project.product_logs pr ON pr.product_id = pos.product_id
        WHERE order_dttm BETWEEN valid_from_dttm AND valid_to_dttm
        ORDER BY order_num, product_nm;

SELECT * FROM database_project.order_products_view;
