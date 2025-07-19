create Database Real_state;

use Real_state;

CREATE TABLE Agents (
    agent_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20)
);

CREATE TABLE Buyers (
    buyer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20)
);

CREATE TABLE Properties (
    property_id INT AUTO_INCREMENT PRIMARY KEY,
    address VARCHAR(255) NOT NULL,
    region VARCHAR(100),
    price DECIMAL(12,2),
    listing_date DATE,
    agent_id INT,
    FOREIGN KEY (agent_id) REFERENCES Agents(agent_id)
);

CREATE TABLE Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    property_id INT,
    buyer_id INT,
    sale_price DECIMAL(12,2),
    sale_date DATE,
    FOREIGN KEY (property_id) REFERENCES Properties(property_id),
    FOREIGN KEY (buyer_id) REFERENCES Buyers(buyer_id)
);
INSERT INTO Agents (name, email, phone) VALUES
('Ravi Sharma', 'ravi@realty.com', '9876543210'),
('Neha Kapoor', 'neha@realty.com', '9876543211'),
('Amit Verma', 'amit@realty.com', '9876543212'),
('Priya Mehra', 'priya@realty.com', '9876543213'),
('Vikram Singh', 'vikram@realty.com', '9876543214'),
('Anjali Desai', 'anjali@realty.com', '9876543215'),
('Rohit Joshi', 'rohit@realty.com', '9876543216'),
('Sneha Nair', 'sneha@realty.com', '9876543217'),
('Manoj Reddy', 'manoj@realty.com', '9876543218'),
('Pooja Iyer', 'pooja@realty.com', '9876543219');

INSERT INTO Buyers (name, email, phone) VALUES
('Arjun Patel', 'arjun@example.com', '9123456780'),
('Kavya Rao', 'kavya@example.com', '9123456781'),
('Rahul Menon', 'rahul@example.com', '9123456782'),
('Meera Jain', 'meera@example.com', '9123456783'),
('Siddharth Roy', 'siddharth@example.com', '9123456784'),
('Ishita Gupta', 'ishita@example.com', '9123456785'),
('Karan Malhotra', 'karan@example.com', '9123456786'),
('Divya Bhatt', 'divya@example.com', '9123456787'),
('Tanishq Das', 'tanishq@example.com', '9123456788'),
('Aanya Pillai', 'aanya@example.com', '9123456789');

INSERT INTO Properties (address, region, price, listing_date, agent_id) VALUES
('12 MG Road, Bengaluru', 'South', 8500000, '2025-01-10', 1),
('45 Marine Drive, Mumbai', 'West', 15000000, '2025-01-15', 2),
('101 Sector 21, Chandigarh', 'North', 7000000, '2025-01-20', 3),
('89 Park Street, Kolkata', 'East', 9500000, '2025-02-01', 4),
('77 Banjara Hills, Hyderabad', 'South', 11000000, '2025-02-10', 5),
('66 Connaught Place, Delhi', 'North', 12000000, '2025-02-15', 6),
('55 Khar, Mumbai', 'West', 13500000, '2025-03-01', 7),
('33 Adyar, Chennai', 'South', 9000000, '2025-03-05', 8),
('22 Gariahat, Kolkata', 'East', 8700000, '2025-03-10', 9),
('11 Civil Lines, Jaipur', 'North', 7500000, '2025-03-15', 10);

INSERT INTO Transactions (property_id, buyer_id, sale_price, sale_date) VALUES
(1, 1, 8400000, '2025-04-01'),
(2, 2, 14800000, '2025-04-03'),
(3, 3, 6950000, '2025-04-05'),
(4, 4, 9400000, '2025-04-08'),
(5, 5, 10800000, '2025-04-10'),
(6, 6, 11800000, '2025-04-12'),
(7, 7, 13200000, '2025-04-15'),
(8, 8, 8900000, '2025-04-18'),
(9, 9, 8600000, '2025-04-20'),
(10, 10, 7400000, '2025-04-22');

SHOW TABLES;

DESCRIBE Agents;
DESCRIBE Buyers;
DESCRIBE Properties;
DESCRIBE Transactions;

SELECT 'Agents' AS table_name, COUNT(*) AS row_count FROM Agents
UNION
SELECT 'Buyers', COUNT(*) FROM Buyers
UNION
SELECT 'Properties', COUNT(*) FROM Properties
UNION
SELECT 'Transactions', COUNT(*) FROM Transactions;

SELECT * FROM Agents LIMIT 5;
SELECT * FROM Buyers LIMIT 5;
SELECT * FROM Properties LIMIT 5;

select
    p.property_id,
    p.address,
    a.name AS agent_name
FROM Properties p
JOIN Agents a ON p.agent_id = a.agent_id
LIMIT 5;

SELECT 
    t.transaction_id,
    b.name AS buyer_Name,
    p.address AS property_address,
    t.sale_price,
    t.sale_date
FROM Transactions t
JOIN Buyers b ON t.buyer_id = b.buyer_id
JOIN Properties p ON t.property_id = p.property_id
LIMIT 5;

SELECT 
    region, 
    ROUND(AVG(price), 2) AS avg_listing_price,
    COUNT(*) AS total_listings
FROM Properties
GROUP BY region;

SELECT 
    region,
    listing_date,
    price,
    ROUND(AVG(price) OVER (
        PARTITION BY region 
        ORDER BY listing_date 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ), 2) AS rolling_avg_price
FROM Properties
ORDER BY region, listing_date;







