create schema skywhysales;

create type skywhysales.role as enum('Клиент', 'Менеджер');
create type skywhysales.ticket_status as enum('Куплен', 'Отменен');
create type skywhysales.class_of_service as enum('Эконом', 'Комфорт','Бизнес', 'Первый класс');

CREATE TABLE skywhysales.users (
	u_id int4 NOT NULL,
	u_surname varchar(45) NOT NULL,
	u_name varchar(30) NOT NULL,
	u_patronymic varchar(45) NULL,
	u_email text NOT NULL,
	u_password text NOT NULL,
	u_role skywhysales."role" NOT NULL,
	u_phone varchar(20) NOT NULL,
	u_birthdate date NOT NULL,
	u_passport_serial decimal(4,0) not null,
	u_passport_number decimal(6,0) not null,
	CONSTRAINT users_pk PRIMARY KEY (u_id),
	CONSTRAINT users_unique UNIQUE (u_email),
	CONSTRAINT users_unique1 UNIQUE (u_phone),
	CONSTRAINT users_unique2 UNIQUE (u_passport_number)
);

CREATE TABLE skywhysales.airlines (
	al_id int4 NOT NULL,
	al_name varchar(45) NOT NULL,
	al_email text not null,
	CONSTRAINT airlines_pk PRIMARY KEY (al_id)
);


CREATE TABLE skywhysales.airports (
	ap_id int4 NOT NULL,
	ap_name varchar(45) NOT NULL,
	ap_country varchar(25) not null,
	ap_city varchar(30) not null,
	ap_street varchar(50) not null,
	ap_building varchar(10) not null,
	CONSTRAINT airports_pk PRIMARY KEY (ap_id)
);

CREATE TABLE skywhysales.flights (
	f_id int4 NOT NULL,
	f_airline int4 NOT NULL,
	f_departure_airport int4 NOT NULL,
	f_arrival_airport int4 NOT NULL,
	f_departure_time timestamp NOT NULL,
	f_arrival_time timestamp NOT null,
	f_seats_count int4 NOT null,
	f_price int4 not null,
	CONSTRAINT flights_pk PRIMARY KEY (f_id),
	CONSTRAINT flights_airlines_fk FOREIGN KEY (f_airline) REFERENCES skywhysales.airlines(al_id) ON DELETE CASCADE ON UPDATE cascade,
	CONSTRAINT flights_airports_fk FOREIGN KEY (f_departure_airport) REFERENCES skywhysales.airports(ap_id) ON DELETE CASCADE ON UPDATE cascade,
	CONSTRAINT flights_airports_fk1 FOREIGN KEY (f_arrival_airport) REFERENCES skywhysales.airports(ap_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE skywhysales.tickets (
	t_id int4 NOT NULL,
	t_flight int4 NOT NULL,
	t_user int4 not null,
	t_bought_date timestamp NOT NULL,
	t_class skywhysales.class_of_service not null,
	t_total_price int4 NOT NULL,
	t_status skywhysales.ticket_status NOT NULL,
	CONSTRAINT tickets_pk PRIMARY KEY (t_id),
	CONSTRAINT tickets_flights_fk FOREIGN KEY (t_flight) REFERENCES skywhysales.flights(f_id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT tickets_users_fk FOREIGN KEY (t_user) REFERENCES skywhysales.users(u_id) ON DELETE CASCADE ON UPDATE CASCADE
);




