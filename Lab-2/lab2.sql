-- Create Department Table
CREATE TABLE Department (
 DepartmentID INT PRIMARY KEY,
 DepartmentName VARCHAR(100) NOT NULL UNIQUE
);
-- Create Designation Table
CREATE TABLE Designation (
 DesignationID INT PRIMARY KEY,
 DesignationName VARCHAR(100) NOT NULL UNIQUE
);
-- Create Person Table 
CREATE TABLE Person (
 PersonID INT PRIMARY KEY IDENTITY(101,1),
 FirstName VARCHAR(100) NOT NULL,
 LastName VARCHAR(100) NOT NULL,
 Salary DECIMAL(8, 2) NOT NULL,
 JoiningDate DATETIME NOT NULL,
 DepartmentID INT NULL,
 DesignationID INT NULL,
 FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
 FOREIGN KEY (DesignationID) REFERENCES Designation(DesignationID)	
);



--LAB-A

CREATE PROCEDURE pr_InsertDepartment
	@departmentid int,
	@departmentname varchar(100)
as
begin 
insert into  department
	values
	(
		@departmentid,
		@departmentName
	)
end

--UPDATE 

CREATE PROCEDURE pr_UpdateDepartment
    @departmentid INT,
    @newDepartmentName VARCHAR(100)
AS
BEGIN
    UPDATE Department
    SET DepartmentName = @newDepartmentName
    WHERE DepartmentID = @departmentid;
END;

--DELETE 
CREATE PROCEDURE pr_DeleteDepartment
    @departmentid INT
AS
BEGIN
    DELETE FROM Department
    WHERE DepartmentID = @departmentid;
END;





--FOR SECOND TABLE
CREATE PROCEDURE pr_InsertDesignation
	@Designationtid int,
	@Designationname varchar(100)
as
begin 
insert into  Designation
	values
	(
		@Designationtid,
		@DesignationName
	)
end

--UPDATE 

CREATE PROCEDURE pr_UpdateDesignation
    @DesignationID INT,
    @DesignationName VARCHAR(100)
AS
BEGIN
    UPDATE Designation
    SET  DesignationName = @DesignationName
    WHERE  DesignationID = @DesignationID;
END;

--DELETE 
CREATE PROCEDURE pr_DeleteDesignation
    @Designationid INT
AS
BEGIN
    DELETE FROM Designation
    WHERE DesignationID = @Designationid;
END;





-- Insert Person Procedure
CREATE PROCEDURE pr_InsertPerson
    @FirstName VARCHAR(100),
    @LastName VARCHAR(100),
    @Salary DECIMAL(8,2),
    @JoiningDate DATETIME,
    @DepartmentID INT = NULL,
    @DesignationID INT = NULL
AS
BEGIN
    INSERT INTO Person (FirstName, LastName, Salary, JoiningDate, DepartmentID, DesignationID)
    VALUES (@FirstName, @LastName, @Salary, @JoiningDate, @DepartmentID, @DesignationID);
END;

-- Update Person Procedure
CREATE PROCEDURE pr_UpdatePerson
    @PersonID INT,
    @FirstName VARCHAR(100),
    @LastName VARCHAR(100),
    @Salary DECIMAL(8,2),
    @JoiningDate DATETIME,
    @DepartmentID INT = NULL,
    @DesignationID INT = NULL
AS
BEGIN
    UPDATE Person
    SET FirstName = @FirstName,
        LastName = @LastName,
        Salary = @Salary,
        JoiningDate = @JoiningDate,
        DepartmentID = @DepartmentID,
        DesignationID = @DesignationID
    WHERE PersonID = @PersonID;
END;

-- Delete Person Procedure
CREATE PROCEDURE pr_DeletePerson
    @PersonID Int
AS
BEGIN
    DELETE FROM Person WHERE PersonID = @PersonID;
END;




exec pr_InsertDepartment 1,'admin'
exec pr_InsertDepartment 2,'IT'
exec pr_InsertDepartment 3, 'HR'
exec pr_InsertDepartment 4, 'Account'

-- ============================================




-- ============================================
-- 2. Department, Designation & Person Table’s SELECTBYPRIMARYKEY
-- ============================================

-- Procedure for selecting Department by Primary Key (DepartmentID)
CREATE PROCEDURE SelectDepartmentByPrimaryKey 
    @p_DepartmentID INT
AS
BEGIN
    -- Question: Select details of a Department based on DepartmentID (Primary Key)
    SELECT DepartmentID, DepartmentName
    FROM Department
    WHERE DepartmentID = @p_DepartmentID;
END;
GO

-- Procedure for selecting Designation by Primary Key (DesignationID)
CREATE PROCEDURE SelectDesignationByPrimaryKey 
    @p_DesignationID INT
AS
BEGIN
    -- Question: Select details of a Designation based on DesignationID (Primary Key)
    SELECT DesignationID, DesignationName
    FROM Designation
    WHERE DesignationID = @p_DesignationID;
END;
GO

-- Procedure for selecting Person by Primary Key (PersonID)
CREATE PROCEDURE SelectPersonByPrimaryKey 
    @p_PersonID INT
AS
BEGIN
    -- Question: Select details of a Person based on PersonID (Primary Key)
    SELECT PersonID, FirstName, LastName, Salary, JoiningDate, DepartmentID, DesignationID
    FROM Person
    WHERE PersonID = @p_PersonID;
END;
GO

-- ============================================
-- 3. Department, Designation & Person Table’s (If foreign key is available then do write join and take columns on select list)
-- ============================================

-- Procedure for selecting Person with Department and Designation details using JOINs
CREATE PROCEDURE SelectPersonWithDepartmentAndDesignation 
    @p_PersonID INT
AS
BEGIN
    -- Question: If foreign key is available (DepartmentID and DesignationID), join the tables to fetch details
    SELECT 
        p.PersonID, 
        p.FirstName, 
        p.LastName, 
        p.Salary, 
        p.JoiningDate, 
        d.DepartmentName, 
        de.DesignationName
    FROM Person p
    LEFT JOIN Department d ON p.DepartmentID = d.DepartmentID
    LEFT JOIN Designation de ON p.DesignationID = de.DesignationID
    WHERE p.PersonID = @p_PersonID;
END;
GO

-- ============================================
-- 4. Create a Procedure that shows details of the first 3 persons
-- ============================================

-- Procedure for selecting the first 3 persons along with their Department and Designation details
CREATE PROCEDURE SelectFirstThreePersons 
AS
BEGIN
    -- Question: Show details of the first 3 persons based on PersonID (including Department and Designation details)
    SELECT 
        p.PersonID, 
        p.FirstName, 
        p.LastName, 
        p.Salary, 
        p.JoiningDate, 
        d.DepartmentName, 
        de.DesignationName
    FROM Person p
    LEFT JOIN Department d ON p.DepartmentID = d.DepartmentID
    LEFT JOIN Designation de ON p.DesignationID = de.DesignationID
    ORDER BY p.PersonID
    OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY;  -- SQL Server uses OFFSET-FETCH for pagination
END;
GO
