CREATE OR REPLACE PROCEDURE onboard_employee(
    p_phone_no IN NUMBER,
    p_gender IN VARCHAR2,
    p_dob IN DATE,
    p_salary IN NUMBER,
    p_ssn IN VARCHAR2,
    p_department_dept_id IN NUMBER
) AS
    EMPLOYEE_ALREADY_EXISTS EXCEPTION;
    PRAGMA EXCEPTION_INIT(EMPLOYEE_ALREADY_EXISTS, -1);
BEGIN
    INSERT INTO employee (
        EMPLOYEE_ID, PHONE_NO, GENDER, DOB, DOJ, TERMINATION_DATE, SALARY, SSN, DEPARTENT_DEPT_ID
    ) VALUES (
        EMPLOYEE_ID_SEQ.NEXTVAL, p_phone_no, p_gender, p_dob, SYSDATE, NULL, p_salary, p_ssn, p_department_dept_id
    );
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Employee onboarded successfully!');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Employee already exists. Employee ID must be unique.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Invalid');
END onboard_employee;
/
