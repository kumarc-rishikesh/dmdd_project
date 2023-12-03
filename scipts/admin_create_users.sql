SET SERVEROUTPUT ON;
BEGIN
  FOR user_rec IN (
    SELECT username FROM dba_users
    WHERE cloud_maintained = 'NO'
      AND username != 'ADMIN'
      AND username != 'ADB_APP_STORE'
  )
  LOOP
    BEGIN
      EXECUTE IMMEDIATE 'DROP USER ' || user_rec.username || ' CASCADE';
      DBMS_OUTPUT.PUT_LINE('Dropped user: ' || user_rec.username);
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error dropping user ' || user_rec.username || ': ' || SQLERRM);
    END;
  END LOOP;

  FOR role_rec IN (
    SELECT role FROM dba_roles
    WHERE oracle_maintained = 'N'
  )
  LOOP
    BEGIN
      EXECUTE IMMEDIATE 'DROP ROLE ' || role_rec.role;
      DBMS_OUTPUT.PUT_LINE('Dropped role: ' || role_rec.role);
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error dropping role ' || role_rec.role || ': ' || SQLERRM);
    END;
  END LOOP;

  COMMIT; 
END;
/


CREATE ROLE leasing_office_role ; 
GRANT CREATE TABLE TO leasing_office_role;
GRANT CONNECT TO leasing_office_role;
GRANT RESOURCE TO leasing_office_role;
GRANT CREATE SEQUENCE TO leasing_office_role;
GRANT CREATE VIEW TO leasing_office_role;
GRANT CREATE PROCEDURE TO leasing_office_role;

CREATE ROLE resident_role ;
GRANT CONNECT TO resident_role;
GRANT RESOURCE TO resident_role;

CREATE ROLE maintenence_role ; 
GRANT CONNECT TO maintenence_role;
GRANT RESOURCE TO maintenence_role;


CREATE USER leasing_office IDENTIFIED BY "RootPassword123*"; 
GRANT leasing_office_role TO leasing_office;
CREATE USER resident IDENTIFIED BY "RootPassword123*"; 
GRANT resident_role TO resident;
CREATE USER maintenence IDENTIFIED BY "RootPassword123*"; 
GRANT maintenence_role TO maintenence;