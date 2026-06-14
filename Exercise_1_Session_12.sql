CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(50),
  	salary NUMERIC
);

CREATE TABLE customer_log (
    log_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(50),
  	action_time TIMESTAMP
);

CREATE OR REPLACE FUNCTION fn_write_log()
RETURNS TRIGGER AS
$$
BEGIN
    INSERT INTO customer_log(customer_name, action_time)
    VALUES (NEW.name, CURRENT_TIMESTAMP);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_write_log
BEFORE INSERT ON customers
FOR EACH ROW
EXECUTE FUNCTION fn_write_log();

INSERT INTO customers (name, email, salary) VALUES
('Nguyen Van A', 'test@gmail.com', 1000),
('Nguyen Van B', 'test1@gmail.com', 1000),
('Nguyen Van C', 'test2@gmail.com', 1000),
('Nguyen Van D', 'test3@gmail.com', 1000),
('Nguyen Van E', 'test4@gmail.com', 1000);
