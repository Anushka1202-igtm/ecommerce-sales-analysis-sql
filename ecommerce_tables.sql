-- Table: public.customers

-- DROP TABLE IF EXISTS public.customers;

CREATE TABLE IF NOT EXISTS public.customers
(
    customer_id integer NOT NULL DEFAULT nextval('customers_customer_id_seq'::regclass),
    name character varying(100) COLLATE pg_catalog."default",
    email character varying(100) COLLATE pg_catalog."default",
    region character varying(50) COLLATE pg_catalog."default",
    created_at date,
    CONSTRAINT customers_pkey PRIMARY KEY (customer_id),
    CONSTRAINT customers_email_key UNIQUE (email)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.customers
    OWNER to postgres;




-- Table: public.discounts

-- DROP TABLE IF EXISTS public.discounts;

CREATE TABLE IF NOT EXISTS public.discounts
(
    discount_id integer NOT NULL DEFAULT nextval('discounts_discount_id_seq'::regclass),
    product_id integer,
    percentage numeric(5,2),
    start_date date,
    end_date date,
    CONSTRAINT discounts_pkey PRIMARY KEY (discount_id),
    CONSTRAINT discounts_product_id_fkey FOREIGN KEY (product_id)
        REFERENCES public.products (product_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.discounts
    OWNER to postgres;



-- Table: public.order_items

-- DROP TABLE IF EXISTS public.order_items;

CREATE TABLE IF NOT EXISTS public.order_items
(
    item_id integer NOT NULL DEFAULT nextval('order_items_item_id_seq'::regclass),
    order_id integer,
    product_id integer,
    quantity integer,
    price_each numeric(10,2),
    CONSTRAINT order_items_pkey PRIMARY KEY (item_id),
    CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id)
        REFERENCES public.orders (order_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT order_items_product_id_fkey FOREIGN KEY (product_id)
        REFERENCES public.products (product_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.order_items
    OWNER to postgres;




-- Table: public.orders

-- DROP TABLE IF EXISTS public.orders;

CREATE TABLE IF NOT EXISTS public.orders
(
    order_id integer NOT NULL DEFAULT nextval('orders_order_id_seq'::regclass),
    customer_id integer,
    order_date date,
    total_amount numeric(10,2),
    CONSTRAINT orders_pkey PRIMARY KEY (order_id),
    CONSTRAINT orders_customer_id_fkey FOREIGN KEY (customer_id)
        REFERENCES public.customers (customer_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.orders
    OWNER to postgres;




-- Table: public.payments

-- DROP TABLE IF EXISTS public.payments;

CREATE TABLE IF NOT EXISTS public.payments
(
    payment_id integer NOT NULL DEFAULT nextval('payments_payment_id_seq'::regclass),
    order_id integer,
    method character varying(50) COLLATE pg_catalog."default",
    paid_at timestamp without time zone,
    CONSTRAINT payments_pkey PRIMARY KEY (payment_id),
    CONSTRAINT payments_order_id_fkey FOREIGN KEY (order_id)
        REFERENCES public.orders (order_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.payments
    OWNER to postgres;



-- Table: public.products

-- DROP TABLE IF EXISTS public.products;

CREATE TABLE IF NOT EXISTS public.products
(
    product_id integer NOT NULL DEFAULT nextval('products_product_id_seq'::regclass),
    name character varying(100) COLLATE pg_catalog."default",
    category character varying(50) COLLATE pg_catalog."default",
    price numeric(10,2),
    stock_qty integer,
    CONSTRAINT products_pkey PRIMARY KEY (product_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.products
    OWNER to postgres;


