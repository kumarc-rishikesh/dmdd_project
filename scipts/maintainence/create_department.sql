CREATE OR REPLACE PROCEDURE onboard_department(
    p_dept_id IN NUMBER,
    p_name IN VARCHAR2
) AS
    DEPARTMENT_ALREADY_EXISTS EXCEPTION;
    PRAGMA EXCEPTION_INIT(DEPARTMENT_ALREADY_EXISTS, -1);
BEGIN
    INSERT INTO department (DEPT_ID, NAME) VALUES (p_dept_id, p_name);
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Department onboarded successfully!');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Department already exists. Department ID must be unique.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Invalid');
END onboard_department;
/ 
