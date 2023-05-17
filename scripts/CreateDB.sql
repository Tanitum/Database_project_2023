create schema database_project;
set search_path = database_project;

create table if not exists database_project.client
(
    client_id       serial primary key not null,
    client_nm       varchar(50)        not null,
    client_surname  varchar(50)        not null,
    client_username varchar(50)        not null,
    client_password text               not null
);

create table if not exists database_project.order
(
    order_id     serial primary key not null,
    order_num    integer            not null,
    order_status text               not null,
    order_dttm   timestamp          not null DEFAULT now()
);

create table if not exists database_project.store
(
    store_id serial primary key not null,
    store_nm varchar(50)        not null
);

create table if not exists database_project.seller
(
    seller_id       serial primary key not null,
    seller_nm       varchar(50)        not null,
    seller_password text               not null
);

create table if not exists database_project.product
(
    product_id      serial primary key not null,
    product_nm      varchar(50)        not null,
    product_price   numeric            not null
);

create table if not exists database_project.position
(
    order_id integer not null,
    constraint position_order_fk foreign key (order_id) references database_project.order (order_id)
    on delete cascade
    on update cascade,
    product_id integer not null,
    constraint position_product_fk foreign key (product_id) references database_project.product (product_id)
    on delete cascade
    on update cascade,
    position_cnt numeric not null
);

create table if not exists database_project.storage_of_product
(
    product_id integer not null,
    constraint storage_product_fk foreign key (product_id) references database_project.product (product_id)
    on delete cascade
    on update cascade,
    store_id integer not null,
    constraint storage_store_fk foreign key (store_id) references database_project.store (store_id)
    on delete cascade
    on update cascade,
    storage_cnt numeric not null DEFAULT 0
);

create table if not exists database_project.seller_store
(
    seller_id integer not null,
    constraint seller_store_seller_fk foreign key (seller_id) references database_project.seller (seller_id)
    on delete cascade
    on update cascade,
    store_id integer not null,
    constraint seller_store_store_fk foreign key (store_id) references database_project.store (store_id)
    on delete cascade
    on update cascade
);

create table if not exists database_project.order_client
(
    order_id integer not null,
    constraint order_client_order_fk foreign key (order_id) references database_project.order (order_id)
    on delete cascade
    on update cascade,
    client_id integer not null,
    constraint order_client_client_fk foreign key (client_id) references database_project.client (client_id)
    on delete cascade
    on update cascade,
    store_id integer not null,
    constraint order_client_store_fk foreign key (store_id) references database_project.store (store_id)
    on delete cascade
    on update cascade
);

alter table database_project.product add constraint chk_product
check (product_price>=0);

alter table database_project.position add constraint chk_position
check (position_cnt>=0);

alter table database_project.storage_of_product add constraint chk_storage_of_product
check (storage_cnt>=0);

CREATE TABLE IF NOT EXISTS database_project.product_logs (
    product_log_id serial,
    operation TEXT,
    product_id      integer not null,
    product_nm      varchar(50)        not null,
    product_price   numeric            not null,
    valid_from_dttm timestamp          not null DEFAULT now(),
    valid_to_dttm   timestamp          not null DEFAULT '9999-12-01 00:00:00');
