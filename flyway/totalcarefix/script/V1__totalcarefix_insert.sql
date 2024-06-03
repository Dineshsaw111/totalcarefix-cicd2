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
