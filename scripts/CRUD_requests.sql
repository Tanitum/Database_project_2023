-- Запросы созданы на основе таблиц из CreateDB и данных из InsertsDB.
-- Все INSERT в InsertsDB.

-- 10 SELECT:
-- Получить список всех магазинов:
SELECT *
FROM database_project.store;

-- Получить список всех продавцов, работающих в магазине TheBestStore:
SELECT sel.seller_id as seller_id, seller_nm
FROM database_project.seller as sel
JOIN database_project.seller_store ss on sel.seller_id = ss.seller_id
JOIN database_project.store s on s.store_id = ss.store_id
WHERE s.store_nm = 'TheBestStore';

-- Получить номера всех заказов, которые еще доставляются:
SELECT order_num, order_status
FROM database_project.order
WHERE order_status = 'On the way';

-- Получить информацию о количествах всех товаров в заказе с номером 545:
SELECT pr.product_id as product_id, product_nm, product_price, sum(position_cnt) as sum_position_cnt
FROM database_project.order
JOIN database_project.position pos on "order".order_id = pos.order_id
JOIN database_project.product pr on pr.product_id = pos.product_id
WHERE order_num = 545
GROUP BY pr.product_id, product_price;

-- SELECT запрос с использованием GROUP BY + HAVING для получения списка названий товаров,
-- максимальная цена которых за все время хотя бы в одном из магазинов была больше 150:
SELECT product_nm, max(product_price) as max_product_price
FROM database_project.product_logs
GROUP BY product_nm
HAVING max(product_price) > 150;

-- SELECT запрос с использованием ORDER BY для получения списка всех продавцов по алфавиту:
SELECT seller_id, seller_nm
FROM database_project.seller
ORDER BY seller_nm;

-- SELECT запрос с использованием <func>(...) OVER(PARTITION BY ...)
-- для получения информации обо всех продуктах с указанием максимальной цены продукта за все время:
SELECT product_id, product_nm, product_price,
       max(product_price) OVER (PARTITION BY product_id, product_nm) as max_product_price,
       valid_from_dttm, valid_to_dttm
FROM database_project.product_logs;

-- SELECT запрос с использованием <func>(...) OVER(ORDER BY ...)
-- Получение информации о складах + максимальное хранимое количество для товаров,
-- упорядоченных по product_id, по всем product_id, не превосходящим рассматриваемое:
SELECT store_id, product_id, storage_cnt,
       max(storage_cnt) OVER (ORDER BY product_id) as max_storage_count_by_pr_id
FROM database_project.storage_of_product;

-- SELECT запрос с использованием <func>(...) OVER(PARTITION BY ...) + ORDER BY
-- для получения информации о заказах с указанным количеством заказов того же статуса:
SELECT order_id, order_num, order_status,
       count(*) OVER (PARTITION BY order_status) as number_of_orders_with_this_status
FROM database_project.order
ORDER BY order_num;

-- SELECT запрос с использованием <func>(...) OVER(...)
-- <func> - все 3 типа функций - агрегирующие, ранжирующие, смещения
-- вывод всей информации о продукте, максимальной цены продукта,
-- ранга конкретного продукта по его цене за все время, предыдущей цены продукта:
SELECT product_id, product_nm, product_price, max(product_price) OVER (PARTITION BY product_nm) as max_product_price,
       row_number() OVER (PARTITION BY product_nm ORDER BY product_price) as rank_by_price_of_product,
       lag(product_price, 1, Null) OVER (PARTITION BY product_nm ORDER BY valid_from_dttm) as previous_price,
       valid_from_dttm, valid_to_dttm
FROM database_project.product_logs
ORDER BY product_nm, valid_from_dttm;

-- Пример UPDATE:
UPDATE database_project.client SET client_surname = 'Яблочный'
WHERE client_surname = 'Яблочкин';

-- Пример DELETE:
DELETE FROM database_project.order
WHERE order_num = 574;
-- при таком запросе удалится заказ из order с номером 574,
-- также удалится информация о нем из order_client и из position из-за on delete cascade.
