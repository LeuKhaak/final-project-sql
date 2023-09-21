CREATE TABLE payment_orders (
    id INT NOT NULL,
    order_type VARCHAR2(70) NOT NULL,
    constraint PAYMENT_ORDERS_PK PRIMARY KEY (id));

CREATE sequence PAYMENT_ORDERS_ID_SEQ;

CREATE trigger BI_PAYMENT_ORDERS_ID
  before insert on payment_orders
  for each row
begin
  select PAYMENT_ORDERS_ID_SEQ.nextval into :NEW.id from dual;
end;

/
CREATE TABLE cities (
    id INT NOT NULL,
    city VARCHAR2(30) NOT NULL,
    constraint CITIES_PK PRIMARY KEY (id));

CREATE sequence CITIES_ID_SEQ;

CREATE trigger BI_CITIES_ID
  before insert on cities
  for each row
begin
  select CITIES_ID_SEQ.nextval into :NEW.id from dual;
end;

/
CREATE TABLE clients (
    id INT NOT NULL,
    title VARCHAR2(70) NOT NULL,
    city INT NOT NULL,
    phone VARCHAR2(20) NOT NULL,
    email VARCHAR2(30) NOT NULL,
    payment_order INT NOT NULL,
    constraint CLIENTS_PK PRIMARY KEY (id));

CREATE sequence CLIENTS_ID_SEQ;

CREATE trigger BI_CLIENTS_ID
  before insert on clients
  for each row
begin
  select CLIENTS_ID_SEQ.nextval into :NEW.id from dual;
end;

/
CREATE TABLE invoices (
    id INT NOT NULL,
    invoice_date DATE NOT NULL,
    client_id INT NOT NULL,
    invoice_sum INT NOT NULL,
    constraint INVOICES_PK PRIMARY KEY (id));

CREATE sequence INVOICES_ID_SEQ;

CREATE trigger BI_INVOICES_ID
  before insert on invoices
  for each row
begin
  select INVOICES_ID_SEQ.nextval into :NEW.id from dual;
end;

/

ALTER TABLE clients ADD CONSTRAINT clients_fk0 FOREIGN KEY (city) REFERENCES cities(id);
ALTER TABLE clients ADD CONSTRAINT clients_fk1 FOREIGN KEY (payment_order) REFERENCES payment_orders(id);
ALTER TABLE invoices ADD CONSTRAINT invoices_fk0 FOREIGN KEY (client_id) REFERENCES clients(id);


