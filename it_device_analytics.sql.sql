-- ============================================================
-- IT DEVICE ANALYTICS
-- SQL PROJECT
-- PostgreSQL
-- ============================================================


-- ============================================================
-- 1. CREATE TABLES
-- ============================================================

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50),
    location VARCHAR(50)
);

CREATE TABLE devices (
    device_id VARCHAR(10) PRIMARY KEY,
    device_type VARCHAR(30),
    manufacturer VARCHAR(30),
    model VARCHAR(50),
    operating_system VARCHAR(30),
    purchase_year INT,
    device_status VARCHAR(30),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE device_usage (
    usage_id INT PRIMARY KEY,
    device_id VARCHAR(10),
    monthly_usage_hours INT,
    error_count INT,
    last_active_days_ago INT,
    FOREIGN KEY (device_id) REFERENCES devices(device_id)
);


-- ============================================================
-- 2. INSERT DATA
-- ============================================================

INSERT INTO departments VALUES
(1, 'Finance', 'Sydney'),
(2, 'Human Resources', 'Sydney'),
(3, 'Marketing', 'Parramatta'),
(4, 'IT', 'Parramatta'),
(5, 'Operations', 'Sydney'),
(6, 'Sales', 'Melbourne');


INSERT INTO devices VALUES
('D001', 'Laptop', 'Dell', 'Latitude 5420', 'Windows 11', 2022, 'Active', 1),
('D002', 'Laptop', 'HP', 'ProBook 450', 'Windows 11', 2023, 'Active', 2),
('D003', 'Desktop', 'Dell', 'OptiPlex 7090', 'Windows 11', 2021, 'Active', 3),
('D004', 'Laptop', 'Lenovo', 'ThinkPad E14', 'Windows 11', 2024, 'Active', 4),
('D005', 'Desktop', 'HP', 'EliteDesk 800', 'Windows 10', 2020, 'Under Repair', 5),
('D006', 'Laptop', 'Apple', 'MacBook Air', 'macOS', 2023, 'Active', 6),
('D007', 'Laptop', 'Dell', 'Latitude 5520', 'Windows 11', 2022, 'Active', 1),
('D008', 'Desktop', 'Dell', 'OptiPlex 7080', 'Windows 10', 2019, 'Inactive', 2),
('D009', 'Laptop', 'HP', 'EliteBook 840', 'Windows 11', 2024, 'Active', 3),
('D010', 'Laptop', 'Lenovo', 'ThinkPad T14', 'Windows 11', 2021, 'Active', 4),
('D011', 'Desktop', 'Dell', 'OptiPlex 7090', 'Windows 11', 2022, 'Active', 5),
('D012', 'Laptop', 'HP', 'ProBook 440', 'Windows 10', 2020, 'Under Repair', 6),
('D013', 'Laptop', 'Dell', 'Latitude 5430', 'Windows 11', 2023, 'Active', 1),
('D014', 'Desktop', 'Lenovo', 'ThinkCentre M720', 'Windows 10', 2019, 'Inactive', 2),
('D015', 'Laptop', 'Apple', 'MacBook Pro', 'macOS', 2024, 'Active', 3),
('D016', 'Laptop', 'Dell', 'Latitude 7420', 'Windows 11', 2022, 'Active', 4),
('D017', 'Desktop', 'HP', 'EliteDesk 800', 'Windows 11', 2021, 'Active', 5),
('D018', 'Laptop', 'Lenovo', 'ThinkPad E15', 'Windows 11', 2023, 'Active', 6),
('D019', 'Desktop', 'Dell', 'OptiPlex 7070', 'Windows 10', 2018, 'Under Repair', 5),
('D020', 'Laptop', 'HP', 'EliteBook 850', 'Windows 11', 2024, 'Active', 6);


INSERT INTO device_usage VALUES
(1, 'D001', 160, 3, 1),
(2, 'D002', 145, 2, 2),
(3, 'D003', 120, 6, 3),
(4, 'D004', 175, 1, 1),
(5, 'D005', 80, 12, 20),
(6, 'D006', 150, 2, 1),
(7, 'D007', 135, 4, 2),
(8, 'D008', 20, 9, 45),
(9, 'D009', 170, 1, 1),
(10, 'D010', 155, 3, 2),
(11, 'D011', 180, 2, 1),
(12, 'D012', 90, 10, 15),
(13, 'D013', 140, 3, 2),
(14, 'D014', 15, 8, 60),
(15, 'D015', 165, 1, 1),
(16, 'D016', 175, 2, 1),
(17, 'D017', 130, 5, 3),
(18, 'D018', 150, 2, 2),
(19, 'D019', 70, 15, 25),
(20, 'D020', 160, 1, 1);


-- ============================================================
-- 3. SQL QUESTIONS
-- ============================================================

-- QUESTION 1
-- Display all devices.

SELECT *
FROM devices;


-- QUESTION 2
-- Find all active devices.

SELECT *
FROM devices
WHERE device_status = 'Active';


-- QUESTION 3
-- Find all Dell devices.

SELECT *
FROM devices
WHERE manufacturer = 'Dell';


-- QUESTION 4
-- Count how many devices there are of each device type.

SELECT
    device_type,
    COUNT(*) AS total_devices
FROM devices
GROUP BY device_type;


-- QUESTION 5
-- Count how many devices there are for each operating system.

SELECT
    operating_system,
    COUNT(*) AS total_devices
FROM devices
GROUP BY operating_system;


-- QUESTION 6
-- Find manufacturers that have more than 3 devices.

SELECT
    manufacturer,
    COUNT(*) AS total_devices
FROM devices
GROUP BY manufacturer
HAVING COUNT(*) > 3;


-- QUESTION 7
-- Display each device together with its department name.

SELECT
    devices.device_id,
    devices.device_type,
    devices.manufacturer,
    devices.model,
    departments.department_name
FROM devices
INNER JOIN departments
    ON devices.department_id = departments.department_id;


-- QUESTION 8
-- Display each device together with its usage and error count.

SELECT
    devices.device_id,
    devices.device_type,
    device_usage.monthly_usage_hours,
    device_usage.error_count
FROM devices
INNER JOIN device_usage
    ON devices.device_id = device_usage.device_id;


-- QUESTION 9
-- Find the average number of errors across all devices.

SELECT
    AVG(error_count) AS average_errors
FROM device_usage;


-- QUESTION 10
-- Find the device with the highest number of errors.

SELECT
    device_id,
    error_count
FROM device_usage
WHERE error_count = (
    SELECT MAX(error_count)
    FROM device_usage
);


-- QUESTION 11
-- Find devices with more than 5 errors.

SELECT
    device_id,
    error_count
FROM device_usage
WHERE error_count > 5;


-- QUESTION 12
-- Find bookings... 
-- NO, this is an IT device database!
-- Find devices that have been inactive for more than 30 days.

SELECT
    device_id,
    last_active_days_ago
FROM device_usage
WHERE last_active_days_ago > 30;
