# TotalCareFix Application
 ## Application Overview
   ### TotalCareFix is a platform that connects users with skilled technicians for various services such as plumbing, electrical work, carpentry, and more. The application allows users to book technicians for specific services, providing a seamless and efficient way to address home service needs.

 ## User Roles
  ### 1.	User:
   #### •	Can browse and search for technicians based on skills.
   #### •	Can book a technician for a specific service.
   #### •	Can provide feedback and ratings for completed services.

   ### 2. Technician:
   #### •	Registers skills.
   #### •	Receives booking requests from users.
   #### •	Performs services and receives feedback from users.

   ### 2. Admin:
   #### •	Can view the dashboard of Showing Booking details.
   #### •	Can observer users and techincian activity.

  ## Booking Process
   ### 1.	User Requests Service:
   #### •	Users can browse through available skills.
   #### •	Users can book a apponitment for a specific service by providing details like service date, time, and address.

   ### 2.	Technician Accepts Booking:
   #### •	Technicians receive booking requests and can accept or decline them based on their availability.

   ### 3.	Service Execution:
   #### •	Technicians perform the requested service on the scheduled date and time.

   ### 4.	Feedback and Rating:
   #### •	After service completion, users can provide feedback and ratings for the technician's performance.
  
   
 ## TotalCareFix Database Creation
 
 
  ## Database Design Documentation
  ### Database Schema Overview
   #### Roles Table
   ##### •	role_id: Primary key, auto-incremented unique identifier for roles.
   ##### •	role_name: Name of the role ( User, Technician and Admin).
    
   #### Status Table
   ##### •  status_id: Primary key, auto-incremented unique identifier for status.
   ##### •  status_name: Name of the status (e.g., Appointment, Booked, Cancelled, Completed).

   #### Skills Table
   ##### • 	skill_id: Primary key, auto-incremented unique identifier for skills.
   ##### • 	skill_name: Name of the skill (e.g., Electrician, Carpenter, Plumber).

     
   #### Users Table
   ##### • 	user_id: Primary key, auto-incremented unique identifier for users.
   ##### • 	first_name: First name of the user.
   ##### • 	last_name: last name of the user.
   ##### •  email: Email address of the user (unique).
   ##### • 	date_of_birth: Date of birth of the user.
   ##### • 	mobile_number: Mobile number of the user.
   ##### • 	role_id: Foreign key referencing the Roles table.


   #### Technicians Table
   ##### • 	tech_id: Primary key, unique identifier for technicians.
   ##### • 	skill_id: Foreign key referencing the Skills table.

   #### Addresses Table
   ##### • 	address_id: Primary key, auto-incremented unique identifier for addresses.
   ##### • 	user_id: Foreign key referencing the Users table.
   ##### • 	house_number: House number of the address.
   ##### •  street: Street name of the address.
   ##### • 	society: Society of the address.
   ##### • 	city: City of the address.
   ##### • 	state: State of the address.
   ##### • 	pincode: Pincode of the address.
   
   #### Feedbacks Table
   ##### • 	feedback_id: Primary key, auto-incremented unique identifier for feedbacks.
   ##### • 	user_id: Foreign key referencing the Users table.
   ##### • 	tech_id: Foreign key referencing the Technicians table.
   ##### • 	message: Feedback message.
   ##### • 	rating: Rating given in the feedback.

        
   #### Booking Table
   ##### • 	book_id: Primary key, auto-incremented unique identifier for bookings.
   ##### • 	user_id: Foreign key referencing the Users table.
   ##### • 	tech_id: Foreign key referencing the Technicians table.
   ##### • 	status_id: Foreign key referencing the Status table.
   ##### • 	address_id: Foreign key referencing the Addresses table.
   ##### • 	message: Booking message.
   ##### • 	service_date: Date of the booked service.
   ##### • 	expected_time: Expected time for the service.
   
 
# Database query

For reference (https://github.com/Dineshsaw111/totalcarefix-cicd2/blob/main/flyway/totalcarefix/script/V12__totalcarefix.sql)
 
  ## Functions.
   ### 1. GetTotalBookingsForTech(arg1);  Provides total bookig for a techID.

  ## Procedures.
   ### 1. CALL INSERT_TECH({firstname}, {laststname},{email}, {date_of_birth}, {mobile_number}, {role_name});  To insert into table roles and fetch role_id from there and insert into users table.

   ## Views.
   ### 1. users_details_view; view users details.  

## AWS Account Setup
 
To deploy resources on AWS using Terraform, you need an AWS account. If you don't have an AWS account, follow these steps to create one:
 
1. Sign in to the AWS Management Console
2. Navigate to IAM (Identity and Access Management)
3. Create a New IAM User
4. Enter User Details    
5. Set Permissions
6. Create the User
7. View Access Key ID and Secret Access Key
8. Download Credentials for deploy resources on AWS using Terraform
 
for reference visit https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html
 
## Terraform Installation
 
Terraform is a tool for building, changing, and versioning infrastructure safely and efficiently. Follow these steps to install Terraform on your local machine:
 
1. Download the appropriate Terraform binary for your operating system from the https://developer.hashicorp.com/terraform/install.
2. Extract the downloaded archive to a directory included in your system's PATH.
3. Verify the installation by running terraform version in your terminal. You should see the Terraform version printed to the console.
 
For reference visit https://spacelift.io/blog/how-to-install-terraform


## Terraform Configuration
 
1. Create infrastructure for this project ( you can use any name for directory and filename )
 
    - Create a directory - Terraform
    - Inside that create rds.tf file to specify AWS resources like VPC, subnet, security groups, and RDS instance according to your requirements.
    - for example: visit ( https://github.com/Dineshsaw111/totalcarefix-cicd2/blob/main/terraform/rds.tf)
 
2. Navigate to the Terraform directory
 
3.  Run `terraform init` to initialize the Terraform configuration.
 
4. Run `terraform validate` to validates the configuration files in a directory, referring only to the configuration
 
5. Run `terraform plan` to review the planned infrastructure changes.
 
6. If everything looks correct, run `terraform apply` to deploy the infrastructure on AWS.
 
```
terraform apply
```
 
## Flyway Installation
 
Flyway is an open-source database-independent library for tracking, managing, and applying database changes. Flyway is an open-source database migration tool that helps you version control your database schema and apply changes to it over time. Here are the general steps to install Flyway:
 
1. Visit the official Flyway website at https://flywaydb.org/.
2. Navigate to the "Downloads" section.
3. Download the version of Flyway that corresponds to your operating system (Windows, macOS, or Linux).
4. Flyway can be run from any directory, but you may want to add its location to your system's PATH environment variable for convenience.
5. Verify Installation: flyway -v.
6. Database Configuration: Before using Flyway, you need to configure it for your specific database. Create a configuration file named flyway.conf or use command-line options.

 Example flyway.conf file for MySQL: (https://github.com/Dineshsaw111/totalcarefix-cicd2/blob/main/flyway/totalcarefix/flyway.toml)

 Our Flyway ci/cd : (flyway yamlci/cd  https://github.com/Dineshsaw111/totalcarefix-cicd2/blob/main/.github/workflows/flyway.yml)

 
For reference visit https://flywaydb.org/documentation.
 
### TotalCareFix ER
 
![image](https://github.com/Dineshsaw111/totalcarefix-cicd2/blob/main/ER3.png)
has context menu
Compose
