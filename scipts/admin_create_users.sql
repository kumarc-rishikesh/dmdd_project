CREATE USER leasing_office IDENTIFIED BY "RootPassword123*"; 
GRANT CREATE TABLE TO leasing_office;
GRANT CONNECT TO leasing_office;
GRANT RESOURCE TO leasing_office;
GRANT UNLIMITED TABLESPACE TO leasing_office;
GRANT CREATE SEQUENCE TO leasing_office;
GRANT CREATE VIEW TO leasing_office;
GRANT CREATE PROCEDURE TO leasing_office;

CREATE USER resident IDENTIFIED BY "RootPassword123*"; 
GRANT CONNECT TO resident;
GRANT RESOURCE TO resident;
GRANT UNLIMITED TABLESPACE TO resident;

CREATE USER maintainence IDENTIFIED BY "RootPassword123*"; 
GRANT CONNECT TO maintainence;
GRANT RESOURCE TO maintainence;
GRANT UNLIMITED TABLESPACE TO maintainence;