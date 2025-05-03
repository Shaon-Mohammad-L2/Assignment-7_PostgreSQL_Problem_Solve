-- Active: 1745640802340@@127.0.0.1@5432@bookstore_db

-- create a table for books. 
CREATE Table books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    author VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL check(price >= 0),
    stock INT NOT NULL check(stock >=0),
    published_year INT NOT NULL check(published_year > 1000)
);

-- create a table for customers.
CREATE Table customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    joined_date DATE NOT NULL DEFAULT CURRENT_DATE
);

-- create a table for orders.
CREATE Table orders(
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    book_id INT REFERENCES books(book_id),
    quantity INT NOT NULL check(quantity > 0),
    order_date DATE NOT NULL DEFAULT current_date
);

-- insert books data.
INSERT INTO books (title, author, price, stock, published_year) VALUES
('The Pragmatic Programmer', 'Andrew Hunt', 45.99, 10, 1999),
('Clean Code', 'Robert C. Martin', 37.50, 0, 2008),
('Eloquent JavaScript', 'Marijn Haverbeke', 25.00, 8, 2018),
('You Don’t Know JS', 'Kyle Simpson', 30.75, 12, 2015),
('JavaScript: The Good Parts', 'Douglas Crockford', 20.00, 7, 2008),
('Learning SQL', 'Alan Beaulieu', 40.00, 15, 2020),
('Design Patterns', 'Erich Gamma', 55.00, 0, 1994),
('Introduction to Algorithms', 'Thomas H. Cormen', 65.00, 6, 2009),
('The Art of Computer Programming', 'Donald Knuth', 85.00, 2, 1968),
('Code Complete', 'Steve McConnell', 50.00, 3, 2004),
('Refactoring', 'Martin Fowler', 42.00, 9, 2018),
('Eloquent JavaScript', 'Marijn Haverbeke', 35.00, 9, 2011),
('Deep Work', 'Cal Newport', 18.99, 6, 2016),
('The Alchemist', 'Paulo Coelho', 15.50, 15, 1988),
('Thinking, Fast and Slow', 'Daniel Kahneman', 22.99, 0, 2011),
('The Lean Startup', 'Eric Ries', 27.50, 11, 2011),
('Introduction to Algorithms', 'Thomas H. Cormen', 80.00, 4, 2009),
('The Mythical Man-Month', 'Frederick P. Brooks Jr.', 25.99, 5, 1975),
('The 7 Habits of Highly Effective People', 'Stephen R. Covey', 19.95, 10, 1989),
('To Kill a Mockingbird', 'Harper Lee', 14.99, 12, 1960),
('Cracking the Coding Interview', 'Gayle Laakmann McDowell', 40.00, 7, 2015),
('Refactoring', 'Martin Fowler', 45.00, 6, 1999),
('Python Crash Course', 'Eric Matthes', 38.95, 8, 2015),
('Effective Java', 'Joshua Bloch', 50.00, 0, 2008),
('Design Patterns', 'Erich Gamma', 55.00, 4, 1994);

-- insert customers data.
INSERT INTO customers (name, email) VALUES
('Ayesha Siddiqua', 'ayesha@example.com'),
('Rahim Uddin', 'rahim@example.com'),
('John Doe', 'john.doe@example.com'),
('Jane Smith', 'jane.smith@example.com'),
('Karim Khan', 'karim@example.com'),
('Anika Rahman', 'anika@example.com'),
('Tanvir Hasan', 'tanvir@example.com'),
('Sadia Ahmed', 'sadia@example.com'),
('Nayeem Islam', 'nayeem@example.com'),
('Farhana Akter', 'farhana@example.com');

-- insert orders data.
INSERT INTO orders (customer_id, book_id, quantity) VALUES
(1, 3, 2),
(2, 5, 1),
(3, 7, 3),
(7, 10, 1),
(5, 15, 4),
(6, 2, 1),
(7, 9, 2),
(8, 12, 1),
(5, 20, 3),
(10, 18, 2),
(1, 14, 1),
(2, 6, 2),
(3, 17, 1),
(4, 8, 5),
(5, 11, 2),
(6, 22, 1),
(7, 19, 3),
(1, 4, 2),
(5, 13, 1),
(10, 21, 4),
(1, 16, 1),
(2, 23, 2),
(3, 25, 1),
(2, 24, 3),
(5, 1, 2),
(6, 5, 1),
(2, 18, 2),
(8, 7, 3),
(5, 2, 1),
(10, 10, 4);



SELECT * FROM books;
SELECT * FROM customers;
SELECT * FROM orders;

----------------------------------------------------------------------------------------------------------------------

-- Problem 1 : Find books that are out of stock.
SELECT title FROM books 
    WHERE stock = 0;

-- Problem 2 : Retrieve the most expensive book in the store.
SELECT * FROM books 
    ORDER BY price DESC LIMIT 1;

-- Problem 3 : Find the total number of orders placed by each customer.
SELECT customers.name, count(customers.customer_id) as total_order from orders 
    INNER JOIN customers ON orders.customer_id = customers.customer_id 
        GROUP BY customers.customer_id;


-- Problem 4 : Calculate the total revenue generated from book sales.
SELECT sum(books.price * quantity) as total_revenue FROM orders 
    INNER JOIN books on orders.book_id = books.book_id;


-- Problem 5 : List all customers who have placed more than one order.
SELECT customers.name , count(customers.customer_id) as order_count from orders
    INNER JOIN customers ON orders.customer_id = customers.customer_id
        GROUP BY customers.customer_id
            HAVING count(orders.customer_id) > 1;

-- Problem 6 : Find the average price of books in the store.
SELECT round(avg(price),2) as avg_book_price from books;

-- Problem 7 : Increase the price of all books published before 2000 by 10%.
UPDATE books SET price = price * 1.10 
    WHERE published_year < 2000;

-- Problem 8 : Delete customers who haven't placed any orders.
DELETE FROM customers 
    WHERE customer_id NOT IN (
        SELECT DISTINCT customer_id FROM orders
    );

