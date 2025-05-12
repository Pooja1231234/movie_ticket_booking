
-- Movie Ticket Booking System SQL Script

-- Drop existing tables if they exist
DROP TABLE IF EXISTS Bookings, Showtimes, Movies, Theaters, Users;

-- Create Users table
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE
);

-- Create Theaters table
CREATE TABLE Theaters (
    theater_id INT PRIMARY KEY,
    name VARCHAR(100),
    location VARCHAR(100)
);

-- Create Movies table
CREATE TABLE Movies (
    movie_id INT PRIMARY KEY,
    title VARCHAR(100),
    genre VARCHAR(50),
    duration INT, -- in minutes
    rating DECIMAL(2,1)
);

-- Create Showtimes table
CREATE TABLE Showtimes (
    showtime_id INT PRIMARY KEY,
    movie_id INT,
    theater_id INT,
    show_date DATE,
    show_time TIME,
    available_seats INT,
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
    FOREIGN KEY (theater_id) REFERENCES Theaters(theater_id)
);

-- Create Bookings table
CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY,
    user_id INT,
    showtime_id INT,
    seats_booked INT,
    booking_date DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (showtime_id) REFERENCES Showtimes(showtime_id)
);

-- Sample data
INSERT INTO Users VALUES
(1, 'Alice', 'alice@example.com'),
(2, 'Bob', 'bob@example.com');

INSERT INTO Theaters VALUES
(1, 'CineMax', 'Downtown'),
(2, 'PVR Cinemas', 'Uptown');

INSERT INTO Movies VALUES
(1, 'Inception', 'Sci-Fi', 148, 8.8),
(2, 'The Lion King', 'Animation', 88, 7.0);

INSERT INTO Showtimes VALUES
(1, 1, 1, '2025-05-11', '18:00:00', 50),
(2, 2, 2, '2025-05-11', '20:00:00', 30);

INSERT INTO Bookings VALUES
(1, 1, 1, 2, '2025-05-10'),
(2, 2, 2, 3, '2025-05-10');

-- Sample Queries
-- List all available movies with showtimes
SELECT M.title, S.show_date, S.show_time, T.name AS theater
FROM Showtimes S
JOIN Movies M ON S.movie_id = M.movie_id
JOIN Theaters T ON S.theater_id = T.theater_id;

-- Find booking history of a user
SELECT U.name, M.title, S.show_date, S.show_time, B.seats_booked
FROM Bookings B
JOIN Users U ON B.user_id = U.user_id
JOIN Showtimes S ON B.showtime_id = S.showtime_id
JOIN Movies M ON S.movie_id = M.movie_id
WHERE U.user_id = 1;
