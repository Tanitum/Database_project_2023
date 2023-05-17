-- Триггеры:

CREATE OR REPLACE FUNCTION check_storage() RETURNS TRIGGER AS $$
BEGIN
IF (SELECT count(*) FROM database_project.storage_of_product WHERE product_id = NEW.product_id) = 1
THEN
    IF (SELECT store_id FROM database_project.storage_of_product limit 1) != NEW.store_id
    THEN RAISE 'Товар с id % уже является товаром другого магазина. '
           'Используйте товар с другим id, при необходимости добавьте копию в таблицу product с новым id', NEW.product_id;
    ELSE
    RETURN NEW;
    END IF;
ELSE
RETURN NEW;
END IF;
END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER check_storage_trigger
BEFORE INSERT OR UPDATE ON database_project.storage_of_product
FOR EACH ROW
EXECUTE FUNCTION check_storage();


CREATE OR REPLACE FUNCTION create_product_logs() RETURNS TRIGGER AS $$
BEGIN
IF TG_OP = 'INSERT' THEN
    INSERT INTO database_project.product_logs VALUES (default, TG_OP, NEW.product_id, NEW.product_nm,
                                     NEW.product_price, default, default);
    RETURN NEW;
ELSIF TG_OP = 'UPDATE' THEN
    UPDATE database_project.product_logs
        SET valid_to_dttm = now()
        WHERE product_log_id = (SELECT product_log_id FROM database_project.product_logs
                                WHERE product_id = OLD.product_id ORDER BY valid_from_dttm DESC limit 1);

    INSERT INTO database_project.product_logs VALUES (default, TG_OP, NEW.product_id, NEW.product_nm,
                                 NEW.product_price, default, default);
    RETURN NEW;
ELSIF TG_OP = 'DELETE' THEN
    UPDATE database_project.product_logs
        SET valid_to_dttm = now()
        WHERE product_log_id = (SELECT product_log_id FROM database_project.product_logs
                                WHERE product_id = OLD.product_id ORDER BY valid_from_dttm DESC limit 1);
    INSERT INTO database_project.product_logs VALUES (default, TG_OP, OLD.product_id, OLD.product_nm,
                                 OLD.product_price,
                                (SELECT valid_from_dttm FROM database_project.product_logs
                                WHERE product_id = OLD.product_id ORDER BY valid_from_dttm DESC limit 1),
                                (SELECT valid_to_dttm FROM database_project.product_logs
                                WHERE product_id = OLD.product_id ORDER BY valid_from_dttm DESC limit 1));
    RETURN OLD;
END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER create_product_logs_trigger
BEFORE INSERT OR UPDATE OR DELETE ON database_project.product
FOR EACH ROW
EXECUTE FUNCTION create_product_logs();
