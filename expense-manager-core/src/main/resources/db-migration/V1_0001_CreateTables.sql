USE TEST;
DROP DATABASE EXPENSEMANAGER;
CREATE DATABASE EXPENSEMANAGER;
USE EXPENSEMANAGER;

CREATE TABLE customer (
	customer_key BIGINT AUTO_INCREMENT NOT NULL,
	customer_name VARCHAR(64),
    enabled BIT,
	password VARCHAR(64),
	PRIMARY KEY (customer_key)
) ENGINE=INNODB;

INSERT INTO customer (customer_key, customer_name, enabled, password) VALUES (1, 'admin', true, 'password');
INSERT INTO customer (customer_key, customer_name, enabled, password) VALUES (2, 'user', true, 'password');

CREATE TABLE role (
	role_key BIGINT AUTO_INCREMENT NOT NULL,
	role_name VARCHAR(64),
	PRIMARY KEY (role_key)
) ENGINE=INNODB;

INSERT INTO role (role_key, role_name) VALUES (1, 'admin');
INSERT INTO role (role_key, role_name) VALUES (2, 'customer');
INSERT INTO role (role_key, role_name) VALUES (3, 'guest');

CREATE TABLE customer_role (
	customer_key BIGINT NOT NULL,
	role_key BIGINT NOT NULL,
	CONSTRAINT FK_CUSTOMER_ROLE FOREIGN KEY (customer_key) REFERENCES customer (customer_key),
	CONSTRAINT FK_ROLE_CUSTOMER FOREIGN KEY (role_key) REFERENCES role (role_key)
) ENGINE=INNODB;

INSERT INTO customer_role (customer_key, role_key) VALUES (1, 1);
INSERT INTO customer_role (customer_key, role_key) VALUES (2, 2);

CREATE TABLE INTERCHANGE_TYPE (
	INTERCHANGE_TYPE_KEY BIGINT AUTO_INCREMENT NOT NULL,
	NAME VARCHAR(20) NOT NULL,
	TYPE VARCHAR(1) NOT NULL,
	CUSTOMER_KEY BIGINT NOT NULL,
	PRIMARY KEY (INTERCHANGE_TYPE_KEY),
	CONSTRAINT FK_INTERCHANGE_TYPE_CUSTOMER FOREIGN KEY (CUSTOMER_KEY) REFERENCES CUSTOMER (CUSTOMER_KEY)
) ENGINE=INNODB;

INSERT INTO INTERCHANGE_TYPE (INTERCHANGE_TYPE_KEY, NAME, TYPE, CUSTOMER_KEY) VALUES ('1', 'Salary', 'D', '1');
INSERT INTO INTERCHANGE_TYPE (INTERCHANGE_TYPE_KEY, NAME, TYPE, CUSTOMER_KEY) VALUES ('2', 'Food', 'C', '1');
INSERT INTO INTERCHANGE_TYPE (INTERCHANGE_TYPE_KEY, NAME, TYPE, CUSTOMER_KEY) VALUES ('3', 'Fuel', 'C', '1');
INSERT INTO INTERCHANGE_TYPE (INTERCHANGE_TYPE_KEY, NAME, TYPE, CUSTOMER_KEY) VALUES ('4', 'Internet', 'C', '1');
INSERT INTO INTERCHANGE_TYPE (INTERCHANGE_TYPE_KEY, NAME, TYPE, CUSTOMER_KEY) VALUES ('5', 'Bonus', 'D', '1');

CREATE TABLE COUNTER_PARTY (
	COUNTER_PARTY_KEY BIGINT AUTO_INCREMENT NOT NULL,
	NAME VARCHAR(35) NOT NULL,
	CUSTOMER_KEY BIGINT NOT NULL,
	PRIMARY KEY (COUNTER_PARTY_KEY),
	CONSTRAINT FK_COUNTER_PARTY_CUSTOMER FOREIGN KEY (CUSTOMER_KEY) REFERENCES CUSTOMER (CUSTOMER_KEY)
) ENGINE=INNODB;

INSERT INTO COUNTER_PARTY (COUNTER_PARTY_KEY, NAME, CUSTOMER_KEY) VALUES ('1', 'Работа (IBA)', '1');
INSERT INTO COUNTER_PARTY (COUNTER_PARTY_KEY, NAME, CUSTOMER_KEY) VALUES ('2', 'Простор на Дзержинского', '1');
INSERT INTO COUNTER_PARTY (COUNTER_PARTY_KEY, NAME, CUSTOMER_KEY) VALUES ('3', 'Универсам Столичный', '1');
INSERT INTO COUNTER_PARTY (COUNTER_PARTY_KEY, NAME, CUSTOMER_KEY) VALUES ('4', 'Случайный человек', '1');

CREATE TABLE INTERCHANGE (
	INTERCHANGE_KEY BIGINT AUTO_INCREMENT NOT NULL,
	AMOUNT NUMERIC(19,2),
    PROCESSING_DATE DATETIME,
	CURRENCY VARCHAR(3),
	DESCRIPTION VARCHAR(255),
	CUSTOMER_KEY BIGINT NOT NULL,
	INTERCHANGE_TYPE_KEY BIGINT NOT NULL,
	COUNTER_PARTY_KEY BIGINT,
	PRIMARY KEY (INTERCHANGE_KEY),
	CONSTRAINT FK_INTERCHANGE_CUSTOMER FOREIGN KEY (CUSTOMER_KEY) REFERENCES CUSTOMER (CUSTOMER_KEY),
	CONSTRAINT FK_INTERCHANGE_INTERCHANGE_TYPE FOREIGN KEY (INTERCHANGE_TYPE_KEY) REFERENCES INTERCHANGE_TYPE (INTERCHANGE_TYPE_KEY),
	CONSTRAINT FK_ICOUNTER_PARTY_TYPE FOREIGN KEY (COUNTER_PARTY_KEY) REFERENCES COUNTER_PARTY (COUNTER_PARTY_KEY)
) ENGINE=INNODB;

INSERT INTO INTERCHANGE (INTERCHANGE_KEY, AMOUNT, PROCESSING_DATE, CURRENCY, DESCRIPTION, CUSTOMER_KEY, INTERCHANGE_TYPE_KEY, COUNTER_PARTY_KEY)
	VALUES ('1', '7197800.00', '2015-07-21', 'BYR', 'Аванс', '1', '1', '1');
INSERT INTO INTERCHANGE (INTERCHANGE_KEY, AMOUNT, PROCESSING_DATE, CURRENCY, DESCRIPTION, CUSTOMER_KEY, INTERCHANGE_TYPE_KEY, COUNTER_PARTY_KEY)
	VALUES ('2', '58000.00', '2015-07-21', 'BYR', 'Персики и торт', '1', '2', '2');
INSERT INTO INTERCHANGE (INTERCHANGE_KEY, AMOUNT, PROCESSING_DATE, CURRENCY, DESCRIPTION, CUSTOMER_KEY, INTERCHANGE_TYPE_KEY, COUNTER_PARTY_KEY)
	VALUES ('3', '7800.00', '2015-07-22', 'BYR', 'Сметанник и булочка', '1', '2', '3');
INSERT INTO INTERCHANGE (INTERCHANGE_KEY, AMOUNT, PROCESSING_DATE, CURRENCY, DESCRIPTION, CUSTOMER_KEY, INTERCHANGE_TYPE_KEY, COUNTER_PARTY_KEY)
	VALUES ('4', '11000.00', '2015-07-22', 'BYR', 'Вознаграждение за прикуривание', '1', '5', '4');