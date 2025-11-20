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
    salary DECIMAL(10,2) NOT NULL CHECK (salary >= 0),
    commission DECIMAL(5,2) NOT NULL DEFAULT 0.00 CHECK (commission >= 0),
    storeID CHAR(36) NOT NULL,
    roleID CHAR(36) NOT NULL,
    CONSTRAINT fk_EmpProfile_Store
        FOREIGN KEY (storeID) REFERENCES Location(storeID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_EmpProfile_Role
        FOREIGN KEY (roleID) REFERENCES EmployeeRole(roleID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);


Describe EmployeeProfile;

CREATE TABLE CustomerProfile (
    customerID CHAR(36) NOT NULL PRIMARY KEY,
    SIN CHAR(9) NOT NULL UNIQUE,
    numYearsWithCarrier INT NOT NULL CHECK (numYearsWithCarrier >= 0),
    CONSTRAINT fk_Customer_User
        FOREIGN KEY (customerID) REFERENCES User(userID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

Describe CustomerProfile;

CREATE TABLE Inventory (
    inventoryID CHAR(36) NOT NULL PRIMARY KEY DEFAULT (UUID()),
    invStatus VARCHAR(20) NOT NULL CHECK (invStatus IN ('IN_STOCK','RESERVED','SOLD','RETURNED')),
    dateReceived TIMESTAMP NOT NULL,
    dateSold TIMESTAMP NULL,
    storeID CHAR(36) NOT NULL,
    CONSTRAINT fk_Inventory_Store
        FOREIGN KEY (storeID) REFERENCES Location(storeID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

describe Inventory;

CREATE TABLE Plan (
    planID CHAR(36) NOT NULL PRIMARY KEY DEFAULT (UUID()),
    planName VARCHAR(50) NOT NULL,
    dataAmount INT NULL,
    callMinutes INT NOT NULL,
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0)
);
 describe Plan;
 
CREATE TABLE Payment (
    creditCardNumber CHAR(16) NOT NULL PRIMARY KEY,
    cvv CHAR(4) NOT NULL,
    expirationDate CHAR(5) NOT NULL,
    billingAddress VARCHAR(255) NOT NULL,
    customerID CHAR(36) NOT NULL,
    CONSTRAINT fk_Payment_Customer
        FOREIGN KEY (customerID) REFERENCES CustomerProfile(customerID)
        ON UPDATE CASCADE ON DELETE RESTRICT
); 
describe Payment; 

CREATE TABLE Sale (
    saleID CHAR(36) NOT NULL PRIMARY KEY DEFAULT (UUID()),
    saleDate DATE NOT NULL DEFAULT (CURRENT_DATE),
    saleTime TIME NOT NULL DEFAULT (CURRENT_TIME),
    customerID CHAR(36) NOT NULL,
    employeeID CHAR(36) NOT NULL,
    storeID CHAR(36) NOT NULL,
    creditCardNumber CHAR(16) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL CHECK (subtotal >= 0),
    discount DECIMAL(10,2) NOT NULL DEFAULT 0.00 CHECK (discount >= 0),
    taxTotal DECIMAL(10,2) NOT NULL CHECK (taxTotal >= 0),
    grandTotal DECIMAL(10,2) NOT NULL CHECK (grandTotal >= 0),
    CONSTRAINT fk_Sale_Customer
        FOREIGN KEY (customerID) REFERENCES CustomerProfile(customerID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_Sale_Employee
        FOREIGN KEY (employeeID) REFERENCES EmployeeProfile(employeeID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_Sale_Store
        FOREIGN KEY (storeID) REFERENCES Location(storeID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_Sale_Payment
        FOREIGN KEY (creditCardNumber) REFERENCES Payment(creditCardNumber)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

describe Sale;

CREATE TABLE Device (
    serialIMEI CHAR(15) NOT NULL PRIMARY KEY,
    deviceName VARCHAR(100) NOT NULL,
    modelNumber VARCHAR(50) NOT NULL,
    specifications VARCHAR(255),
    deviceStatus VARCHAR(20) NOT NULL CHECK (deviceStatus IN ('IN_STOCK','ACTIVE','INACTIVE','RETIRED')),
    customerID CHAR(36) NULL,
    inventoryID CHAR(36) NOT NULL,
    planID CHAR(36) NULL,
    saleID CHAR(36) NULL,
    CONSTRAINT fk_Device_Customer
        FOREIGN KEY (customerID) REFERENCES CustomerProfile(customerID)
        ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT fk_Device_Inventory
        FOREIGN KEY (inventoryID) REFERENCES Inventory(inventoryID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_Device_Plan
        FOREIGN KEY (planID) REFERENCES Plan(planID)
        ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT fk_Device_Sale
        FOREIGN KEY (saleID) REFERENCES Sale(saleID)
        ON UPDATE CASCADE ON DELETE SET NULL
);

DESCRIBE Device;
