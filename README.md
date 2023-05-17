# Проект по предмету "Базы данных", ФПМИ, 2023.

## Описание проекта
В проекте будет реализована база данных для приложения, которое облегчает заказ товаров из магазина с использованием интернет доставки.
Нужна база данных, с использованием которой клиенты смогут наполнить онлайн корзину товарами одного из интернет магазинов,
продавцы смогут увидеть все заказы в своем магазине, смогут изменить статусы заказов своих клиентов и так далее.
Модули / сущности / объекты: покупатели (Client), заказы (Order), позиции в заказе (Position),
товары (Product), магазины (Store), данные продавцов (Seller).
 
## Информация о сущностях
1. Покупатель Client:
id, name, surname, username, password

2. Заказ Order:
id, client id, store id, number, status, orderdate

3. Позиция в заказе Position:
id, order id, count

4. Товар Product:
id, store id, name, price, valid from dttm, valid to dttm

5. Магазин Store:
id, name, storage_cnt

6. Продавец Seller:
id, store id, sellername, password



Отношения в базе данных:
1) client
поля / атрибуты: client_id, client_nm, client_surname, client_username, client_password

2) order_client
поля / атрибуты: order_id, client_id, store_id

3) order
поля / атрибуты: order_id, order_num, order_status, order_dttm

4) position
поля / атрибуты: order_id, product_id, position_cnt

5) product
поля / атрибуты: product_id, product_nm, product_price

6) storage_of_product
поля / атрибуты: product_id, store_id, storage_cnt

7) store
поля / атрибуты: store_id, store_nm

8) seller_store
поля / атрибуты: seller_id, store_id

9) seller
поля / атрибуты: seller_id, seller_nm, seller_password

10) product_logs (заполняется триггером create_product_logs_trigger)
поля / атрибуты: product_log_id, operation, product_id, product_nm, product_price, valid_from_dttm, valid_to_dttm

## Модели
1. [Файл с тремя моделями](https://github.com/Tanitum/Database_project_2023/blob/main/docs/models.pdf)
2. [Концептуальная модель](https://github.com/Tanitum/Database_project_2023/blob/main/docs/conceptual-model.png)
4. [Логическая модель](https://github.com/Tanitum/Database_project_2023/blob/main/docs/logical-model.png)
4. [Физическая модель](https://github.com/Tanitum/Database_project_2023/blob/main/docs/physical-model.png)

## Файлы проекта
1. [DDL скрипты](https://github.com/Tanitum/Database_project_2023/blob/main/scripts/CreateDB.sql)
2. [Заполнение БД данными](https://github.com/Tanitum/Database_project_2023/blob/main/scripts/InsertsDB.sql)
3. [CRUD-запросы](https://github.com/Tanitum/Database_project_2023/blob/main/scripts/CRUD_requests.sql)
4. [Функции](https://github.com/Tanitum/Database_project_2023/blob/main/scripts/Functions.sql)
5. [Представления](https://github.com/Tanitum/Database_project_2023/blob/main/scripts/Views.sql)
6. [Триггеры](https://github.com/Tanitum/Database_project_2023/blob/main/scripts/Triggers.sql)
7. Генерация данных, вставка данных в БД, извлечение данных и анализ с использованием Python: [код](https://github.com/Tanitum/Database_project_2023/blob/main/analysis/analysis.py), [результат](https://gitlab.atp-fivt.org/db2023/komlevro-project/-/blob/main/analysis/analysis.ipynb)


