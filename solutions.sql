--Вывести к каждому самолету класс обслуживания и количество мест этого класса

--Найти 3 самых вместительных самолета (модель + кол-во мест)
select ad.model,
       (select count(*) from seats s where ad.aircraft_code = s.aircraft_code) seats
from aircrafts_data ad
order by seats desc limit 3;



--Вывести код,модель самолета и места не эконом класса для самолета 'Аэробус A321-200' с сортировкой по местам

--Вывести города в которых больше 1 аэропорта ( код аэропорта, аэропорт, город)

-- Найти ближайший вылетающий рейс из Екатеринбурга в Москву, на который еще не завершилась регистрация


--Вывести самый дешевый и дорогой билет и стоимость ( в одном результирующем ответе)
    (SELECT * FROM ticket_flights ORDER BY amount DESC LIMIT 1)
    UNION ALL
    (SELECT * FROM ticket_flights ORDER BY amount LIMIT 1);



-- Написать DDL таблицы Customers , должны быть поля id , firstName, LastName, email , phone. Добавить ограничения на поля ( constraints) .
create table if not exists bookings."Customers"
(
    id serial,
    first_name varchar,
    last_name varchar,
    email varchar not null,
    phone varchar not null,
    constraint "Customers_pk"
    primary key (id),
    unique (email),
    unique (phone)
    );


-- Написать DDL таблицы Orders , должен быть id, customerId,	quantity. Должен быть внешний ключ на таблицу customers + ограничения
create table if not exists "Orders"
(
    id serial,
    customer_id integer not null,
    quantity integer not null,
    constraint "Orders_pk"
    primary key (id),
    constraint "Orders_Customers_id_fk"
    foreign key (customer_id) references "Customers"
    );



-- Написать 5 insert в эти таблицы
insert into "Customers" (id, first_name, last_name, email, phone)
values (5, 'Nam', 'Surn', 'qwe@qwe.qwe', '88005553535'),
       (6, 'Uio', 'Surn', 'qwe2@qwe.qwe', '88005553536'),
       (7, 'Bnm', 'Shjk', 'qwe3@qwe.qwe', '88005553537');

insert into "Orders" (id, customer_id, quantity)
values (2, 5, 3),
       (3, 6, 10);



-- удалить таблицы
drop table if exists "Customers", "Orders" cascade ;



-- Написать свой кастомный запрос ( rus + sql)
-- Выбрать записи, у которых одновременно одинаковые поля почты и телефона.
-- (для выявления дубликатов при неправильно прописанных констреинтах, например)
SELECT email, phone, COUNT(*)
FROM "Customers"
GROUP BY email, phone
HAVING COUNT(*) > 1;
