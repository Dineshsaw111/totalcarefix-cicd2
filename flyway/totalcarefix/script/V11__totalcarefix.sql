CREATE TABLE users
  (
     user_id       INT auto_increment,
     first_name    VARCHAR(100) NOT NULL,
     last_name     VARCHAR(100) NOT NULL,
     email         VARCHAR(100) NOT NULL,
     date_of_birth DATE NOT NULL,
     mobile_number VARCHAR(15) NOT NULL,
     role_id       INT NOT NULL,
     CONSTRAINT user_fk PRIMARY KEY( user_id),
     CONSTRAINT role_fk_users FOREIGN KEY (role_id) REFERENCES roles(role_id) ON
     UPDATE CASCADE
  );

CREATE TABLE roles
  (
     role_id   INT auto_increment,
     role_name VARCHAR(100) NOT NULL,
     CONSTRAINT roles_pk PRIMARY KEY(role_id)
  );

CREATE TABLE status
  (
     status_id   INT auto_increment,
     status_name VARCHAR(100) NOT NULL,
     CONSTRAINT status_pk PRIMARY KEY(status_id)
  );

CREATE TABLE skills
  (
     skill_id   INT auto_increment,
     skill_name VARCHAR(100) NOT NULL,
     CONSTRAINT skill_pk PRIMARY KEY(skill_id)
  );

CREATE TABLE technicians
  (
     tech_id  INT NOT NULL,
     skill_id INT NOT NULL,
     CONSTRAINT technicians_pk PRIMARY KEY (tech_id),
     CONSTRAINT tech_fk_users FOREIGN KEY (tech_id) REFERENCES users(user_id),
     CONSTRAINT skills_fk_technicians FOREIGN KEY (skill_id) REFERENCES skills(
     skill_id)
  );

CREATE TABLE addresses
  (
     address_id   INT auto_increment,
     user_id      INT NOT NULL,
     house_number INT NOT NULL,
     street       VARCHAR(100),
     society      VARCHAR(100) NOT NULL,
     city         VARCHAR(50) NOT NULL,
     state        VARCHAR(50) NOT NULL,
     pincode      INT NOT NULL,
     CONSTRAINT addresses_fk PRIMARY KEY( address_id),
     CONSTRAINT users_fk_addresses FOREIGN KEY (user_id) REFERENCES users(
     user_id) ON UPDATE CASCADE
  );

CREATE TABLE feedbacks
  (
     feedback_id INT auto_increment,
     user_id     INT NOT NULL,
     tech_id     INT NOT NULL,
     message     VARCHAR(100) NOT NULL,
     rating      INT NOT NULL,
     CONSTRAINT feedbacks_pk PRIMARY KEY( feedback_id),
     CONSTRAINT technicians_fk_feedbacks FOREIGN KEY (user_id) REFERENCES users(
     user_id) ON UPDATE CASCADE,
     CONSTRAINT addresses_fk_feedbacks FOREIGN KEY (tech_id) REFERENCES
     technicians(tech_id) ON UPDATE CASCADE
  );

CREATE TABLE booking
  (
     book_id        INT auto_increment,
     user_id        INT NOT NULL,
     tech_id        INT NOT NULL,
     status_id      INT NOT NULL,
     address_id     INT NOT NULL,
     message        VARCHAR(500) NOT NULL,
     service_date   DATE NOT NULL,
     expectted_time TIME,
     CONSTRAINT booking_pk PRIMARY KEY( book_id),
     CONSTRAINT users_fk_booking FOREIGN KEY (user_id) REFERENCES users(user_id)
     ON UPDATE CASCADE,
     CONSTRAINT technicians_fk_booking FOREIGN KEY (tech_id) REFERENCES
     technicians(tech_id) ON UPDATE CASCADE,
     CONSTRAINT status_fk_booking FOREIGN KEY (status_id) REFERENCES status(
     status_id) ON UPDATE CASCADE,
     CONSTRAINT addresses_fk_booking FOREIGN KEY (address_id) REFERENCES
     addresses(address_id) ON UPDATE CASCADE
  ); 





  
-- Inserting into ROLES table
INSERT INTO ROLES (role_name) VALUES 
  ('Admin'),
  ('Technician'),
  ('User');
  
  
  -- Inserting into STATUS table
INSERT INTO STATUS (status_name) VALUES 
  ('appointment'),
  ('booked'),
  ('Cancelled'),
  ('Completed');

-- Inserting into SKILLS table
INSERT INTO SKILLS (skill_name) VALUES 
  ('Electrician'),
  ('Carpenter'),
  ('Locksmith'),
  ('Plumber'),
  ('Glass Repair Specialist'),
  ('Computer Technician');
  
  
  
-- Inserting into USERS table
INSERT INTO USERS (first_name, last_name, email, date_of_birth, mobile_number, role_id) VALUES
  ('John', 'Doe', 'john.doe@example.com', '1990-01-15', '1234567890', 1),
  ('Jane', 'Smith', 'jane.smith@example.com', '1985-05-22', '9876543210', 2),
  ('Alice', 'Johnson', 'alice.johnson@example.com', '1995-08-10', '5555555555', 3),
  ('Bob', 'Williams', 'bob.williams@example.com', '1980-03-03', '9999999999', 2),
  ('Charlie', 'Brown', 'charlie.brown@example.com', '1992-11-30', '1111111111', 3);


-- Inserting into technicians table
INSERT INTO technicians (tech_id, skill_id) VALUES
  (1, 1),
  (2, 2),
  (3, 3),
  (4, 2),
  (5, 1);
  
  -- Inserting into ADDRESSES table
INSERT INTO ADDRESSES (user_id, house_number, street, society, city, state, pincode) VALUES
  (1, 123, 'Main St', 'Green Valley', 'Cityville', 'State1', 12345),
  (2, 456, 'Broadway', 'Sunset Hills', 'Townsville', 'State2', 54321),
  (3, 789, 'Oak Lane', 'Maple Grove', 'Villagetown', 'State3', 67890),
  (4, 101, 'Pine Street', 'Hillside', 'Villageville', 'State4', 11111),
  (5, 202, 'Elm Avenue', 'Riverdale', 'Townburg', 'State5', 22222);



-- Inserting into BOOKING table
INSERT INTO BOOKING (user_id, tech_id, status_id, address_id, message, service_date, expectted_time) VALUES
  (1, 1, 3, 1, 'Need help with programming', '2024-03-01', '14:00:00'),
  (2, 2, 1, 2, 'Networking issue', '2024-03-02', '10:30:00'),
  (3, 3, 2, 3, 'Electrical repair', '2024-03-03', '12:00:00'),
  (4, 4, 4, 4, 'Plumbing emergency', '2024-03-04', '15:30:00'),
  (5, 5, 3, 5, 'Carpentry work', '2024-03-05', '09:00:00');
  
  
-- Inserting into FEEDBACKS table
INSERT INTO FEEDBACKS (user_id, tech_id, message, rating) VALUES
  (1, 1, 'Great service!', 5),
  (2, 2, 'Very knowledgeable technician.', 4),
  (3, 3, 'Prompt and efficient.', 5),
  (4, 4, 'Friendly and helpful.', 4),
  (5, 5, 'Excellent workmanship.', 5);





  CREATE VIEW users_details_view
AS
  SELECT users.user_id,
         users.first_name,
         users.last_name,
         users.email,
         users.date_of_birth,
         users.role_id,
         addresses.address_id,
         addresses.house_number,
         addresses.street,
         addresses.society,
         addresses.city,
         addresses.state,
         addresses.pincode
  FROM   users
         INNER JOIN addresses
                 ON users.user_id = addresses.user_id; 





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
  SELECT role_id INTO roleID FROM roles WHERE role_name = myskill;
  INSERT INTO USERS (first_name, last_name, email, date_of_birth, mobile_number, role_id)
  VALUES (fname, Lname, Email, dob, mob, roleID);
END //

DELIMITER ;





CREATE FUNCTION GetTotalBookingsForTech(techID INT)
RETURNS INT
READS SQL DATA
BEGIN
  DECLARE totalBookings INT;
  SELECT COUNT(tech_id) INTO totalBookings
  FROM BOOKING
  WHERE tech_id = techID;
  RETURN totalBookings;
END //

DELIMITER ;