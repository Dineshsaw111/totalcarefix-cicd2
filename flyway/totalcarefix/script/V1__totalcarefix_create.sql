CREATE TABLE roles (
    role_id INT auto_increment,
    name VARCHAR(20) NOT NULL,
    CONSTRAINT roles_pk PRIMARY KEY(role_id)
);
 
CREATE TABLE users_status (
    users_status_id INT NOT NULL auto_increment,
    name VARCHAR(8) NOT NULL,
    CONSTRAINT users_status_pk PRIMARY KEY(users_status_id)
);

CREATE TABLE users (
    user_id INT auto_increment,
    first_name VARCHAR(40) NOT NULL,
    last_name VARCHAR(40) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    role_id INT NOT NULL,
    status_id INT NOT NULL,
    creation_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT user_fk PRIMARY KEY(user_id),
    CONSTRAINT role_fk_users FOREIGN KEY (role_id) REFERENCES roles(role_id) ON UPDATE CASCADE,
    CONSTRAINT users_status_fk_users FOREIGN KEY (status_id) REFERENCES users_status(users_status_id) ON UPDATE CASCADE
);
 
CREATE TABLE contacts (
    contact_id INT auto_increment,
    user_id INT NOT NULL,
    contact_number varchar(15) NOT NULL,
    CONSTRAINT contacts_fk PRIMARY KEY(contact_id),
    CONSTRAINT users_fk_contacts FOREIGN KEY (user_id) REFERENCES users(user_id) ON
     UPDATE CASCADE
);
 
CREATE TABLE status (
    status_id INT auto_increment,
    name VARCHAR(100) NOT NULL,
    CONSTRAINT status_pk PRIMARY KEY(status_id)
);
 
CREATE TABLE skills (
    skill_id INT auto_increment,
    name VARCHAR(100) NOT NULL,
    CONSTRAINT skill_pk PRIMARY KEY(skill_id)
);
 
CREATE TABLE technicians (
    tech_id INT NOT NULL,
    skill_id INT NOT NULL,
    CONSTRAINT technicians_pk PRIMARY KEY (tech_id),
    CONSTRAINT tech_fk_users FOREIGN KEY (tech_id) REFERENCES users(user_id),
    CONSTRAINT skills_fk_technicians FOREIGN KEY (skill_id) REFERENCES skills(skill_id)
);
 
CREATE TABLE states (
    state_id INT auto_increment,
    name varchar(30) NOT NULL,
    CONSTRAINT states_pk PRIMARY KEY (state_id)
);
 
CREATE TABLE cities (
    city_id INT auto_increment,
    state_id INT NOT NULL,
    name varchar(30) NOT NULL,
    CONSTRAINT cities_pk PRIMARY KEY (city_id),
    CONSTRAINT states_fk_cities FOREIGN KEY (state_id) REFERENCES states(state_id)
);
 
CREATE TABLE addresses (
    address_id INT AUTO_INCREMENT,
    user_id INT NOT NULL,
    house_number VARCHAR(20) NOT NULL,
    street VARCHAR(100),
    society VARCHAR(100) NOT NULL,
    locality VARCHAR(100) NOT NULL,
    city_id INT NOT NULL,
    pincode VARCHAR(6) NOT NULL,
    address_type ENUM('fixed', 'booking') NOT NULL DEFAULT 'fixed',
    CONSTRAINT addresses_pk PRIMARY KEY(address_id),
    CONSTRAINT users_fk_addresses FOREIGN KEY (user_id) REFERENCES users(user_id) ON UPDATE CASCADE,
    CONSTRAINT cities_fk_addresses FOREIGN KEY (city_id) REFERENCES cities(city_id) ON UPDATE CASCADE
);
 

 
CREATE TABLE booking (
    booking_id INT auto_increment,
    booker_id INT NOT NULL,
    tech_id INT,
    status_id INT NOT NULL,
    address_id INT NOT NULL,
    skill_id INT NOT NULL,
    message VARCHAR(500) NOT NULL,
    service_date TIMESTAMP NOT NULL,
    expected_time TIME NOT NULL,
    logtime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT booking_pk PRIMARY KEY(booking_id),
    CONSTRAINT users_fk_booking FOREIGN KEY (booker_id) REFERENCES users(user_id) ON UPDATE CASCADE,
    CONSTRAINT technicians_fk_booking FOREIGN KEY (tech_id) REFERENCES technicians(tech_id) ON UPDATE CASCADE,
    CONSTRAINT status_fk_booking FOREIGN KEY (status_id) REFERENCES status(status_id) ON UPDATE CASCADE,
    CONSTRAINT addresses_fk_booking FOREIGN KEY (address_id) REFERENCES addresses(address_id) ON UPDATE CASCADE,
    CONSTRAINT addresses_fk_skill FOREIGN KEY (skill_id) REFERENCES skills(skill_id) ON UPDATE CASCADE
);

CREATE TABLE feedbacks (
    feedback_id INT auto_increment,
    booking_id INT NOT NULL,
    user_id INT NOT NULL,
    tech_id INT NOT NULL,
    message VARCHAR(100) NOT NULL,
    rating TINYINT UNSIGNED NOT NULL CHECK(
        rating <= 5
        AND rating >= 1
    ),
    creation_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT feedbacks_pk PRIMARY KEY(feedback_id),
    CONSTRAINT technicians_fk_feedbacks FOREIGN KEY (user_id) REFERENCES users(user_id) ON UPDATE CASCADE,
    CONSTRAINT addresses_fk_feedbacks FOREIGN KEY (tech_id) REFERENCES technicians(tech_id) ON UPDATE CASCADE,
    CONSTRAINT booking_fk_feedbacks FOREIGN KEY (booking_id) REFERENCES booking(booking_id) ON UPDATE CASCADE
);


INSERT INTO roles (name) VALUES 
  ('Admin'),
  ('Technician'),
  ('User');
INSERT INTO users_status (name) VALUES 
  ('active'),
  ('deactive');

INSERT INTO users (first_name, last_name, email, role_id, status_id) VALUES
  ('John', 'Doe', 'john.doe@example.com', 1, 1),
  ('Jane', 'Smith', 'jane.smith@example.com', 2, 1),
  ('Alice', 'Johnson', 'alice.johnson@example.com', 3, 1),
  ('Bob', 'Williams', 'bob.williams@example.com', 2, 1),
  ('Charlie', 'Brown', 'charlie.brown@example.com', 3, 1);


INSERT INTO status (name) VALUES 
  ('appointment'),
  ('booked'),
  ('Cancelled'),
  ('Completed');

INSERT INTO skills (name) VALUES 
  ('Electrician'),
  ('Carpenter'),
  ('Locksmith'),
  ('Plumber'),
  ('Glass Repair Specialist'),
  ('Computer Technician');

INSERT INTO technicians (tech_id, skill_id) VALUES
  (2, 1),
  (4, 2);

INSERT INTO states (name) VALUES 
  ('Gujarat'),
  ('Rajasthan');

INSERT INTO cities (state_id, name) VALUES
    (1, 'surat'),
    (1, 'barodra'),
    (1, 'gandhinagar'),
    (1, 'rajkot'),
    (1, 'ahmedabad'),
    (2, 'udaipur'),
    (2, 'jaipur'),
    (2, 'bikaner'),
    (2, 'kota'),
    (2, 'jodpur');  

  
INSERT INTO addresses (user_id, house_number, street, society, locality, city_id, pincode) VALUES
  (1, '123', 'Main St', 'Green Valley', 'Cityville', 1, '12345'),
  (2, '456', 'Broadway', 'Sunset Hills', 'Townsville', 2, '54321'),
  (3, '789', 'Oak Lane', 'Maple Grove', 'Villagetown', 1, '67890'),
  (4, '101', 'Pine Street', 'Hillside', 'Villageville', 2, '11111'),
  (5, '202', 'Elm Avenue', 'Riverdale', 'Townburg', 2, '22222');

INSERT INTO booking (booker_id, tech_id, status_id, address_id,skill_id, message, service_date, expected_time) VALUES
  (1, 2, 3, 1,1,'Need help with programming', '2024-03-01', '14:00:00'),
  (2, 4, 4, 2,2, 'Networking issue', '2024-03-02', '10:30:00'),
  (3, 2, 2, 3,1, 'Electrical repair', '2024-03-03', '12:00:00'),
  (5, 2, 3, 5,1, 'Carpentry work', '2024-03-05', '09:00:00');

INSERT INTO feedbacks (user_id,booking_id, tech_id, message, rating) VALUES
  (1, 2, 4, 'Great service!', 5),
  (2, 1, 2, 'Very knowledgeable technician.', 4);



CREATE VIEW users_details_view AS
SELECT 
    users.user_id,
    users.first_name,
    users.last_name,
    users.email,
    users.role_id,
    addresses.address_id,
    addresses.house_number,
    addresses.street,
    addresses.society,
    cities.name AS city,
    states.name AS state,
    addresses.pincode
FROM users
INNER JOIN addresses ON users.user_id = addresses.user_id
INNER JOIN cities ON addresses.city_id = cities.city_id
INNER JOIN states ON cities.state_id = states.state_id;




DELIMITER //

CREATE PROCEDURE INSERT_TECH(
  IN fname VARCHAR(100),
  IN Lname VARCHAR(100),
  IN Email VARCHAR(100),
  IN dob DATE,
  IN mob VARCHAR(15),
  IN myskill VARCHAR(20)
)
BEGIN
  DECLARE roleID INT;
  SELECT role_id INTO roleID FROM roles WHERE name = myskill;
  INSERT INTO users (first_name, last_name, email, date_of_birth, mobile_number, role_id)
  VALUES (fname, Lname, Email, dob, mob, roleID);
END//

DELIMITER ;

DELIMITER //

CREATE FUNCTION GetTotalBookingsForTech(techID INT)
RETURNS INT
READS SQL DATA
BEGIN
  DECLARE totalBookings INT;
  SELECT COUNT(tech_id) INTO totalBookings FROM booking WHERE tech_id = techID;
  RETURN totalBookings;
END//

DELIMITER ;
