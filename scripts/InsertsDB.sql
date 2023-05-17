INSERT INTO database_project.client VALUES (default, 'Иван', 'Иванов', 'Pozitiv4ik', '123456');
INSERT INTO database_project.client VALUES (default, 'Андрей', 'Смирнов', 'Black_Angel', '654321'),
                                           (default, 'Катя', 'Арбузова', 'В ожидании чуда', 'xxxddd'),
                                           (default, 'Марина', 'Соколова', 'З@Я_ ИЗ _Р@Я', '1x1x2x'),
                                           (default, 'Петя', 'Яблочкин', 'Baby boom', 'ttrdfv'),
                                           (default, 'Анна', 'Смирнова', 'Части4каРая', 'cdsfh'),
                                           (default, 'Ольга', 'Сидорова', 'White_Angel', 'hzhhjjg'),
                                           (default, 'John', 'Black', 'NeGaTiG4K', 'vxbbbbffffdghj'),
                                           (default, 'Ксюша', 'Умнова', 'F R O Z E N', 'iyudhxnvln[g[j'),
                                           (default, 'Матвей', 'Ерохин', 'ПРИКИНЬ, Я КОТ!', 'stupid_password');

insert into database_project.order values (default, 545, 'Сompleted', '2014-04-04 20:00:00');
insert into database_project.order values (default, 546, 'Canceled', '2014-05-04 20:25:04');
insert into database_project.order values (default, 550, 'Canceled', '2016-04-04 15:30:20');
insert into database_project.order values (default, 570, 'On the way', '2023-04-02 10:05:30');
insert into database_project.order values (default, 547, 'Сompleted', '2014-09-07 23:40:15');
insert into database_project.order values (default, 548, 'Сompleted', '2015-10-02 08:15:23');
insert into database_project.order values (default, 571, 'On the way', '2023-04-02 11:06:45');
insert into database_project.order values (default, 590, 'Confirmed', '2023-04-02 14:24:32');
insert into database_project.order values (default, 573, 'Confirmed', '2023-04-02 14:38:15');
insert into database_project.order values (default, 574, 'Confirmed', '2023-04-02 14:45:47');

INSERT INTO database_project.store (store_id, store_nm)
VALUES (DEFAULT, 'Mall1');
INSERT INTO database_project.store (store_id, store_nm)
VALUES (DEFAULT, 'City');
INSERT INTO database_project.store (store_id, store_nm)
VALUES (DEFAULT, 'BestMall');
INSERT INTO database_project.store (store_id, store_nm)
VALUES (DEFAULT, 'TheBestStore');
INSERT INTO database_project.store (store_id, store_nm)
VALUES (DEFAULT, 'SuperStore');
INSERT INTO database_project.store (store_id, store_nm)
VALUES (DEFAULT, 'Mall1234');
INSERT INTO database_project.store (store_id, store_nm)
VALUES (DEFAULT, 'Yandex Market');
INSERT INTO database_project.store (store_id, store_nm)
VALUES (DEFAULT, 'Amazon');
INSERT INTO database_project.store (store_id, store_nm)
VALUES (DEFAULT, 'Интернет-магазин OZON');
INSERT INTO database_project.store (store_id, store_nm)
VALUES (DEFAULT, 'Интернет-магазин Дикие ягодки');

INSERT INTO database_project.seller (seller_id, seller_nm, seller_password) VALUES
(DEFAULT, 'John-seller', '$2a$10$ATsozapL8Dl/FMz/Y0g4dec6gA3cxr0mYY9rv1qdbwwIndBsE3W4e'),
(DEFAULT, 'Petr-seller', '$2a$10$QBwbLhn9Hs7pa.H.V2RJ/uWEBPPDsnKgpvOKD36MyZRSiesOnWolq'),
(DEFAULT, 'IvanSeller', '$2a$10$iw5gieQti07diS1JUcvodePyPBZm6p5flsly2BJ8G.1CI8QFi.Uvq'),
(DEFAULT, 'XYZSeller', '$2a$10$vBmu3uGF3qSxI8vkLx.bHuft6WHwvYZpJuIh5JOt3Rj0I1/cJU2.y'),
(DEFAULT, 'MariaSeller', '$2a$10$rR2sl6RIn2ZDMxwuHSKRm.VBgzwql0GLvx3g6BL2kKbT/IuQsHOjW'),
(DEFAULT, 'Лучший продавец мира', 'p@SSW0Rd'),
(DEFAULT, 'AnnaSeller', '$2a$10$E8.Xt5PA3bS7oM5ueaFN7uxDsF/dXVC1p1HvPCxZjuN5EjYDcZt.W'),
(DEFAULT, 'FirstSeller', '$2a$10$een./CEAVgMPVfk/zjBzEeB5ObCcLbqI1Tbc2O33GjwBKIKCCTLRG'),
(DEFAULT, 'SecondSeller', '$2a$10$w9VTI/SRH1V0M9cIcNYJgO/IT4ynkPZvjoN39oYJEuoCZDEgg4eKm'),
(DEFAULT, 'BootmanSeller', '$2a$10$J.180HRJdsGpyZEXqeC2aOjfQAnOVapdiXPSr1LKvMfA/gMIYQlUW');

INSERT INTO database_project.product (product_id, product_nm, product_price) VALUES
(DEFAULT, 'Butter', 145.66666), -- 1 магазин
(DEFAULT, 'Огурцы', 200), -- 1
(DEFAULT, 'Яблоки', 150), -- 2
(DEFAULT, 'Яблоки', 150), -- 3
(DEFAULT, 'Огурцы', 200), -- 4
(DEFAULT, 'Яблоки', 150), -- 5
(DEFAULT, 'Яблоки', 150), -- 6
(DEFAULT, 'Tea', 700), -- 7
(DEFAULT, 'Bread', 50), -- 7
(DEFAULT, 'Milk', 100.5), -- 7
(DEFAULT, 'Яблоки', 150), -- 7
(DEFAULT, 'Огурцы', 200), -- 7
(DEFAULT, 'Огурцы', 200), -- 8
(DEFAULT, 'Яблоки', 150), -- 8
(DEFAULT, 'Огурцы', 200), -- 9
(DEFAULT, 'Огурцы', 200); -- 10

INSERT INTO database_project.position (order_id, product_id, position_cnt) VALUES
(1, 8, 10.5),
(1, 9, 3),
(1, 10, 1),
(1, 11, 1.5),
(1, 12, 6),
(1, 12, 6),
(2, 13, 7),
(3, 3, 70000),
(4, 1, 3),
(4, 2, 5),
(5, 13, 16),
(6, 12, 17),
(7, 12, 3),
(8, 15, 1.2),
(9, 9, 5),
(10, 9, 32);

INSERT INTO database_project.storage_of_product (product_id, store_id, storage_cnt) VALUES
(1, 1, 1000),
(2, 1, 500),
(3, 2, 1200.5),
(4, 3, 2200.5),
(5, 4, 2300.5),
(6, 5, 2400.5),
(7, 6, 2500),
(8, 7, 300),
(9, 7, 1000),
(10, 7, 20),
(11, 7, 500),
(12, 7, 800),
(13, 8, 700),
(14, 8, 250),
(15, 9, 300),
(16, 10, 500);

INSERT INTO database_project.seller_store (seller_id, store_id) VALUES
(1, 1),
(1, 2),
(2, 1),
(3, 2),
(3, 3),
(4, 4),
(5, 4),
(6, 4),
(7, 5),
(7, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

INSERT INTO database_project.order_client (order_id, client_id, store_id) VALUES
(1, 1, 7),
(2, 2, 8),
(3, 3, 2),
(4, 4, 1),
(5, 5, 8),
(6, 6, 7),
(8, 7, 9),
(7, 8, 7),
(9, 9, 7),
(10, 9, 7);
