CREATE DATABASE FiveGuysCellular;

-- highlight and run line 4 in order to run commands
USE FiveGuysCellular;

CREATE TABLE User (
    userID CHAR(36) NOT NULL PRIMARY KEY DEFAULT (UUID()), 
    fullName VARCHAR(100) NOT NULL,
    fName VARCHAR(50) NOT NULL,
    lName VARCHAR(50) NOT NULL,
    passwordHash VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    createDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    phoneNumber VARCHAR(15)
);

DESCRIBE User;

CREATE TABLE EmployeeRole (
    roleID CHAR(36) NOT NULL PRIMARY KEY DEFAULT (UUID()),
    roleName VARCHAR(50) NOT NULL,
    roleDescription VARCHAR(150),
    updatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

Describe EmployeeRole;

CREATE TABLE Location (
    storeID CHAR(36) NOT NULL PRIMARY KEY DEFAULT (UUID()),
    storeName VARCHAR(100) NOT NULL,
    street VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    province VARCHAR(50) NOT NULL,
    postalCode CHAR(7) NOT NULL,
    callAddress VARCHAR(50)
);

Describe Location;

CREATE TABLE EmployeeProfile (
    employeeID CHAR(36) NOT NULL PRIMARY KEY DEFAULT (UUID()),
    salary DECIMAL(10,2) NOT NULL,
    commission DECIMAL(5,2) NOT NULL,
    storeID CHAR(36) NOT NULL,
    roleID CHAR(36) NOT NULL,
    FOREIGN KEY (storeID) REFERENCES Location(storeID),
    FOREIGN KEY (roleID) REFERENCES EmployeeRole(roleID)
);

Describe EmployeeProfile;

CREATE TABLE CustomerProfile (
    customerID CHAR(36) NOT NULL PRIMARY KEY,
    SIN CHAR(9) NOT NULL UNIQUE,
    numYearsWithCarrier INT NOT NULL,
    FOREIGN KEY (customerID) REFERENCES User(userID)
);

Describe CustomerProfile;
