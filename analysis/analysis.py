import pandas as pd
import psycopg2 as pg
from faker import Faker
import matplotlib.pyplot as plt
import seaborn as sns

# Создание docker и database:
# https://alexsaplin.notion.site/alexsaplin/10-a1f16c857c1444a685afdffbafdd0dee

if __name__ == '__main__':
    conn = pg.connect(f"""
        dbname='{"postgres"}' 
        user='{"postgres"}' 
        port='{"5432"}' 
        password='{"postgres"}'
    """)

    cursor = conn.cursor()

    # для генерации данных используем библиотеку Faker
    # https://pypi.org/project/Faker/

    fake = Faker()
    comp_1 = fake.company() + " Store"
    comp_2 = fake.company() + " Store"
    comp_3 = fake.company() + " Store"

    cursor.execute("""
    INSERT INTO database_project.store (store_id, store_nm) VALUES
        (DEFAULT, %s),
        (DEFAULT, %s),
        (DEFAULT, %s);
    """, [comp_1, comp_2, comp_3])

    cursor.execute("""
    INSERT INTO database_project.client (client_id, client_nm, client_surname,
    client_username, client_password) VALUES
        (DEFAULT, %s, %s, %s, %s);
    """, [fake.first_name(), fake.last_name(), fake.user_name(), fake.password()])

    # Посмотрим на список всех магазинов, включая добавленные.
    cursor.execute(f"SELECT * FROM database_project.store")
    rows = cursor.fetchall()
    print("Лист из id store_nm из таблицы store:")
    print(rows)

    conn.commit()

    # Дальше проведем какой-то анализ с помощью pandas, можем построить графики/хитмапы.

    columns = ["client_id", "client_nm", "client_surname", "client_username"]
    clients = pd.DataFrame(columns=columns)
    cursor.execute(f"SELECT {', '.join(columns)} FROM database_project.client")
    rows = cursor.fetchall()
    for row in rows:
        clients = pd.concat(
            [clients, pd.DataFrame.from_dict(dict(zip(columns, list(map(lambda x: [x], row)))))],
            ignore_index=True
        )

    print("")
    print("Dataframe с данными из client без учета client_password, добавлены сгенерированные люди:")
    print(clients)

    columns = ["order_id", "order_num", "order_status", "order_dttm"]
    orders = pd.DataFrame(columns=columns)
    cursor.execute(f"SELECT {', '.join(columns)} FROM database_project.order")
    rows = cursor.fetchall()
    for row in rows:
        orders = pd.concat(
            [orders, pd.DataFrame.from_dict(dict(zip(columns, list(map(lambda x: [x], row)))))],
            ignore_index=True
        )

    plt.title("Количество заказов различных статусов")
    sns.histplot(data=orders, x='order_status')
    plt.show()

    # Посмотрим на значения в представлении store_products_view:
    columns = ["store_id", "product_id", "store_name", "product_nm", "storage_cnt", "product_price"]
    store_products_view = pd.DataFrame(columns=columns)
    cursor.execute(f"SELECT {', '.join(columns)} FROM database_project.store_products_view")
    rows = cursor.fetchall()
    for row in rows:
        store_products_view = pd.concat(
           [store_products_view, pd.DataFrame.from_dict(dict(zip(columns, list(map(lambda x: [x], row)))))],
            ignore_index=True
        )
    print(store_products_view.head())

    # Обработаем эти данные. Для начала уберем лишний текст во всех столбцах.
    store_products = store_products_view;
    store_products['store_id'] = store_products['store_id'].str[13:].astype('int')
    store_products['product_id'] = store_products['product_id'].str[11:].astype('int')
    store_products['store_name'] = store_products['store_name'].str[19:]
    store_products['product_nm'] = store_products['product_nm'].str[17:]
    store_products['storage_cnt'] = store_products['storage_cnt'].str[15:].astype('float')
    store_products['product_price'] = store_products['product_price'].str[13:].astype('float')
    print(store_products.head())

    # Посмотрим на цены товаров и хранимое количество в магазине с store_id = 7.
    store_products_7 = store_products.loc[(store_products['store_id'] == 7)]
    print("Статистика по магазину: " + store_products_7.iloc[0]['store_name'])

    plt.scatter (store_products_7['storage_cnt'], store_products_7['product_price'])
    plt.xlabel('Запасы товара')
    plt.ylabel('Цена товара')
    plt.title("Данные по товарам магазина " + store_products_7.iloc[0]['store_name'])

    for i, txt in enumerate(store_products_7['product_nm'].squeeze()):
       plt.annotate(txt, (store_products_7['storage_cnt'].iloc[i]-40, store_products_7['product_price'].iloc[i]+12))
    plt.show()  
