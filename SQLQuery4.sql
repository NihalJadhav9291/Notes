--- Creating Database
CREATE DATABASE EmployeeDB;
--- Use Database
USE EmployeeDB;
--- Create Table - 1
CREATE TABLE MasterDesignation(
ID INT PRIMARY KEY IDENTITY(1,1),
DesignationName VARCHAR(30),
);
--- Inserting Designations into MasterDesignation Table
INSERT INTO MasterDesignation (DesignationName) VALUES ('Manager');
INSERT INTO MasterDesignation (DesignationName) VALUES ('Developer');
INSERT INTO MasterDesignation (DesignationName) VALUES ('Analyst');
--- Create Table - 2
CREATE TABLE Employee(
EmpID INT PRIMARY KEY IDENTITY(1,1),
EmpName VARCHAR(50),
Birthdate DATE,
DesignationID INT FOREIGN KEY REFERENCES MasterDesignation(ID),
Gender INT,
EmailID VARCHAR(50),
MobNO VARCHAR(20),
);

INSERT INTO Employee VALUES ( 'John', '2001-09-09', 1,1,'abcd@gmail.com',9876541011);
INSERT INTO Employee VALUES ( 'Jane','2001-09-09', 2,1,'abcd@gmail.com',9876541011);
INSERT INTO Employee VALUES ( 'Bob', '2001-09-09', 3,1,'abcd@gmail.com',9876541011);

SELECT * FROM Employee;

--INNER JOIN QUERY ------
select * from MasterDesignation
inner join Employee ON MasterDesignation.ID=Employee.DesignationId;

--LEFT JOIN QUERY------
select * from Employee
left join MasterDesignation ON Employee.DesignationId=MasterDesignation.ID;

--Right join query
select * from Employee
right join MasterDesignation ON Employee.DesignationID = MasterDesignation.ID;

--Full (outer) join
select * from Employee 
FULL JOIN MasterDesignation ON Employee.DesignationID = MasterDesignation.ID;


--Stored procedure for inserting employee record
GO
  CREATE PROCEDURE Usp_InsertNewRecord
  @EmpName VARCHAR(50),
  @BirthDate DATE,
  @DesignationID INT,
  @Gender INT,
  @EmailID VARCHAR(50),
  @MobNO VARCHAR(20)
AS
  BEGIN 
  --SQL QUERY {
     INSERT INTO Employee(EmpName,Birthdate,DesignationID,Gender,EmailID,MobNO)
	 VALUES (@EmpName,@BirthDate,@DesignationID,@Gender,@EmailID,@MobNO);
	 --SQL QUERY CLOSED}
  END;
EXEC Usp_InsertNewRecord @EmpName='Nihal',@BirthDate='2000-04-26',@DesignationID=1,@Gender=1,@EmailID='nihal@gmail.com',@MobNO='132456895';

--stored procedure for updating employee record

GO 
  CREATE PROCEDURE Usp_UpdateEmployeeList
    @ID INT,
	@NewEmpName VARCHAR(50)
AS
  BEGIN 
    --SQL QUERY {
	UPDATE Employee
	SET EmpName =@NewEmpName
	WHERE EmpID =@ID;
	--SQL QUERY CLOSED }
END;
EXEC Usp_UpdateEmployeeList @ID=1 , @NewEmpName='Sagar';

--Stored procedure for displaying Employee Records

GO 
 CREATE PROCEDURE Usp_GetEmployeeDetails
  @EmpID INT
AS 
  BEGIN
   --SQL QUERY {
   SELECT EmpName,DesignationName,EmailID,MobNO
   FROM Employee
   INNER JOIN MasterDesignation ON Employee.DesignationID=MasterDesignation.ID WHERE ID=@EmpID;
   --SQL QUERY CLOSED}
   END;
EXEC Usp_GetEmployeeDetails @EmpID=1;

---Stored procedure for deleting Employee Record

GO
 CREATE PROCEDURE Usp_DeleteEmployeeDetails
  @EmployeeId INT
AS
BEGIN
--SQL QUERY STARTED{
DELETE FROM Employee WHERE EmpID=@EmployeeId;
--SQL Query Closed}
END;

EXEC Usp_DeleteEmployeeDetails @EmployeeId=1;


--DROPDOWN LIST
Go 
  CREATE PROCEDURE Usp_MasterDesignation
AS 
 BEGIN 
 --SQL QUERY
 SELECT * FROM MasterDesignation;
 END;
EXEC Usp_MasterDesignation;
