CREATE OR REPLACE FUNCTION get_order_cost(num INTEGER)
RETURNS NUMERIC
AS $$
DECLARE
    TABLE_RECORD RECORD;
    answer NUMERIC;
BEGIN
IF (SELECT count(*) FROM database_project.order
        WHERE order_num = num) = 0
THEN
    RAISE 'Не существует заказ с номером %.',
        num;
ELSE
    answer = 0;
    FOR TABLE_RECORD IN
        SELECT * FROM database_project.order
        JOIN database_project.position pos ON "order".order_id = pos.order_id
        JOIN database_project.product_logs pr ON pr.product_id = pos.product_id
        WHERE order_num = num
    LOOP
            IF TABLE_RECORD."order_dttm"
            BETWEEN
               TABLE_RECORD."valid_from_dttm"
            AND
               TABLE_RECORD."valid_to_dttm"
            THEN answer = answer + (TABLE_RECORD."position_cnt" * TABLE_RECORD."product_price");
            ELSE
                RAISE 'В заказе есть товар с product_id = %, дата действия стоимости которого не соответствует дате заказа',
                    TABLE_RECORD."product_id";
            END IF;
    END LOOP;
    RETURN answer;
END IF;
END
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION check_storage_for_order(num INTEGER)
RETURNS TABLE("prod_id" INTEGER, "prod_nm" VARCHAR(50), "prod_shortage" NUMERIC) AS $$
DECLARE
    TABLE_RECORD RECORD;
BEGIN
IF (SELECT count(*) FROM database_project.order
        WHERE order_num = num) = 0
THEN RAISE 'Не существует заказ с номером %.', num;
ELSE IF (SELECT count(*) FROM database_project.order
        JOIN database_project.order_client oc ON "order".order_id = oc.order_id
        WHERE order_num = num) = 0
THEN
    RAISE 'Заказ с номером % не имеет связи с магазином и клиентом. '
    'Невозможно проверить наличие запасов на складе неизвестного магазина.', num;
ELSE
END IF;
FOR TABLE_RECORD IN
        SELECT * FROM database_project.order
        JOIN database_project.order_client oc ON "order".order_id = oc.order_id
        JOIN database_project.position pos ON "order".order_id = pos.order_id
        JOIN database_project.product_logs pr ON pr.product_id = pos.product_id
LOOP
    IF (SELECT count(*) FROM database_project.storage_of_product
        WHERE product_id = TABLE_RECORD."product_id" AND store_id = TABLE_RECORD."store_id") = 0
    THEN
        INSERT INTO database_project.storage_of_product VALUES (TABLE_RECORD."product_id", TABLE_RECORD."store_id", 0);
    END IF;
END LOOP;
RETURN QUERY(
    SELECT pr.product_id, pr.product_nm, sum(pos.position_cnt) - storage_cnt FROM database_project.order
        JOIN database_project.order_client oc ON "order".order_id = oc.order_id
        JOIN database_project.position pos ON "order".order_id = pos.order_id
        JOIN database_project.product_logs pr ON pr.product_id = pos.product_id
        RIGHT JOIN database_project.storage_of_product storage ON pr.product_id = storage.product_id
        WHERE order_num = num AND oc.store_id = storage.store_id
        GROUP BY pr.product_id, pr.product_nm, storage_cnt
        HAVING sum(pos.position_cnt) - storage_cnt > 0
        );
END IF;
END
$$
LANGUAGE plpgsql;
