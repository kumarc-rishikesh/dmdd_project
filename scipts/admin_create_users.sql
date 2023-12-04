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
    
    BEGIN
        EXECUTE IMMEDIATE 'CREATE ROLE leasing_office_role' ; 
        EXECUTE IMMEDIATE 'GRANT CREATE TABLE TO leasing_office_role';
        EXECUTE IMMEDIATE 'GRANT CONNECT TO leasing_office_role';
        EXECUTE IMMEDIATE 'GRANT RESOURCE TO leasing_office_role';
        EXECUTE IMMEDIATE 'GRANT CREATE SEQUENCE TO leasing_office_role';
        EXECUTE IMMEDIATE 'GRANT CREATE VIEW TO leasing_office_role';
        EXECUTE IMMEDIATE 'GRANT CREATE PROCEDURE TO leasing_office_role';
        EXECUTE IMMEDIATE 'GRANT INSERT TO leasing_office_role';

        DBMS_OUTPUT.PUT_LINE('Created role: leasing_office_role');

        EXECUTE IMMEDIATE 'CREATE ROLE resident_role ';
        EXECUTE IMMEDIATE 'GRANT CONNECT TO resident_role';
        EXECUTE IMMEDIATE 'GRANT RESOURCE TO resident_role';
        DBMS_OUTPUT.PUT_LINE('Created role: resident_role');
        
        EXECUTE IMMEDIATE 'CREATE ROLE maintenence_role '; 
        EXECUTE IMMEDIATE 'GRANT CONNECT TO maintenence_role';
        EXECUTE IMMEDIATE 'GRANT RESOURCE TO maintenence_role';
        DBMS_OUTPUT.PUT_LINE('Created role: maintenence_role');        
        
        EXECUTE IMMEDIATE 'CREATE USER leasing_office IDENTIFIED BY "RootPassword123*"'; 
        EXECUTE IMMEDIATE 'GRANT leasing_office_role TO leasing_office';
        DBMS_OUTPUT.PUT_LINE('Created user: leasing_office');

        EXECUTE IMMEDIATE 'CREATE USER resident IDENTIFIED BY "RootPassword123*"'; 
        EXECUTE IMMEDIATE 'GRANT resident_role TO resident';
        DBMS_OUTPUT.PUT_LINE('Created user: resident');

        EXECUTE IMMEDIATE 'CREATE USER maintenence IDENTIFIED BY "RootPassword123*"'; 
        EXECUTE IMMEDIATE 'GRANT maintenence_role TO maintenence';
        DBMS_OUTPUT.PUT_LINE('Created user: maintainence');

    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR IN ROLE/USER CREATION : ' || SQLERRM );
    END;
END;
/
