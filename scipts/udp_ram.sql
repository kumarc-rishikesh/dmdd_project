-- 1. add employee proc

CREATE OR REPLACE PROCEDURE add_sr(
    p_lease_id IN NUMBER,
    p_resident_name IN VARCHAR2,
    p_service IN VARCHAR2
) AS
    v_resident_id NUMBER;
    v_service_count NUMBER;

    
    RESIDENT_NOT_FOUND EXCEPTION;
    SERVICE_NOT_FOUND EXCEPTION;
    SERVICE_REQUEST_ALREADY_EXISTS EXCEPTION;

BEGIN
    SELECT RESIDENT_ID INTO v_resident_id
    FROM resident
    WHERE RESIDENT_NAME = UPPER(p_resident_name)
      AND LEASE_LEASE_ID = p_lease_id;

    SELECT COUNT(*) INTO v_service_count
    FROM department
    WHERE NAME = UPPER(p_service);

    IF v_service_count = 0 THEN
        RAISE SERVICE_NOT_FOUND;
    END IF;

    SELECT COUNT(*) INTO v_service_count
    FROM service_request
    WHERE LEASE_LEASE_ID = p_lease_id
      AND TYPE = upper(p_service)
      AND STATUS IS NOT NULL;

    IF v_service_count > 0 THEN
        RAISE SERVICE_REQUEST_ALREADY_EXISTS;
    END IF;

    INSERT INTO service_request (request_id,
        LEASE_LEASE_ID,
        TYPE,
        SCHEDULED_FOR,
        RESIDENT_NAME,
        STATUS
    ) VALUES (SERVICE_REQUEST_ID_SEQ.NEXTVAL,
        p_lease_id,
        UPPER(p_service),
        NULL,
        UPPER(p_resident_name),
        'NOT ASSIGNED'
    );

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Service request raised successfully!');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Resident not found. Please provide a valid lease ID and resident name.');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Multiple residents found. Please provide a more specific Details.');
    WHEN SERVICE_NOT_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Service not found. Please provide a valid service name.');
    WHEN SERVICE_REQUEST_ALREADY_EXISTS THEN
        DBMS_OUTPUT.PUT_LINE('Service request already exists for this resident and service.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Invalid Input Data');
END add_sr;
/

--EXEC add_sr(99, 'NonExistentResident', 'Plumbing');
--EXEC add_sr(1, 'Liam', 'NonExistentService');
--EXEC add_sr(1, 'Liam', 'Plumbing');   

-- 2. onboard employee proc

CREATE OR REPLACE PROCEDURE onboard_employee(
    p_employee_name IN VARCHAR2,
    p_phone_no IN NUMBER,
    p_gender IN VARCHAR2,
    p_dob IN DATE,
    p_salary IN NUMBER,
    p_ssn IN VARCHAR2,
    p_department_dept_id IN NUMBER
) AS
    EMPLOYEE_ALREADY_EXISTS EXCEPTION;
    employee_exists NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO employee_exists
    FROM employee
    WHERE SSN = p_ssn;
    IF employee_exists > 0 THEN
        RAISE EMPLOYEE_ALREADY_EXISTS;
    ELSE
        INSERT INTO employee (
            EMPLOYEE_ID, EMPLOYEE_NAME, PHONE_NO, GENDER, DOB, DOJ, TERMINATION_DATE, SALARY, SSN, DEPARTMENT_DEPT_ID
        ) VALUES (
            EMPLOYEE_ID_SEQ.NEXTVAL, p_employee_name, p_phone_no, p_gender, p_dob, SYSDATE, NULL, p_salary, p_ssn, p_department_dept_id
        );

        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Employee onboarded successfully!');
    END IF;
EXCEPTION
    WHEN EMPLOYEE_ALREADY_EXISTS THEN
        DBMS_OUTPUT.PUT_LINE('Employee already exists.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Oops!'||SUBSTR(SQLERRM, 11));
END onboard_employee;
/
    
-- Employee already exists
--EXEC onboard_employee('John Doe', 1234567890, 'Male', TO_DATE('15-JAN-90', 'DD-MON-YY'), 50000, '123-45-6789', 1);
    
-- 3. create department

CREATE OR REPLACE PROCEDURE onboard_department(
    p_dept_id IN NUMBER,
    p_name IN VARCHAR2
) AS
    DEPARTMENT_ALREADY_EXISTS EXCEPTION;

    department_exists NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO department_exists
    FROM department
    WHERE DEPT_ID = p_dept_id and name = UPPER(p_name);
    IF department_exists > 0 THEN
        RAISE DEPARTMENT_ALREADY_EXISTS;
    ELSE
        INSERT INTO department (DEPT_ID, NAME)
        VALUES (p_dept_id, UPPER(p_name));
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Department onboarded successfully!');
    END IF;
EXCEPTION
    WHEN DEPARTMENT_ALREADY_EXISTS THEN
        DBMS_OUTPUT.PUT_LINE('Department already exists.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Invalid');
END onboard_department;
/
--EXEC onboard_department(1, 'Electric');
-- 4. close sr proc

CREATE OR REPLACE PROCEDURE close_sr(p_request_id IN NUMBER) AS
    v_status VARCHAR2(50):= 'COMPLETED';
    v_exists VARCHAR2(1) := 'N';
    NOT_FOUND EXCEPTION;
BEGIN
SELECT 'Y' INTO v_exists FROM SERVICE_REQUEST WHERE REQUEST_ID = p_request_id;
IF v_exists = 'Y' THEN
    UPDATE SERVICE_REQUEST
    SET STATUS = UPPER(v_status),
    COMPLETED_AT = SYSDATE
    WHERE REQUEST_ID = p_request_id;
    COMMIT;
    ELSE
    RAISE NOT_FOUND;
    END IF;
EXCEPTION
WHEN NOT_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Service Request not found');
WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Invalid Request Number');     
END close_sr;
/

--EXEC CLOSE_SR(999);    
    

-- 7. schedule emp proc

CREATE OR REPLACE PROCEDURE schedule_emp(
    p_req_id IN NUMBER, 
    p_emp_id IN NUMBER
) AS
    V_EXISTS_REQ VARCHAR2(1) := 'N';
    V_DEPT_REQ NUMBER;
    V_name VARCHAR2(50);

    SERVICE_REQUEST_NOT_FOUND EXCEPTION;
    DEPARTMENT_NOT_FOUND EXCEPTION;
    EMPLOYEE_NOT_FOUND EXCEPTION;
    
BEGIN
    SELECT count(*) into v_exists_req FROM SERVICE_REQUEST WHERE REQUEST_ID = p_req_id;
    IF V_EXISTS_REQ = 0 THEN
        RAISE SERVICE_REQUEST_NOT_FOUND;
    END IF;    
        
    SELECT D.DEPT_ID INTO V_DEPT_REQ FROM SERVICE_REQUEST S JOIN DEPARTMENT D ON S.TYPE = D.NAME WHERE REQUEST_ID = P_REQ_ID;
    IF V_DEPT_REQ IS NULL THEN
        RAISE  DEPARTMENT_NOT_FOUND;
    END IF;

    IF V_DEPT_REQ IS NOT NULL THEN
        SELECT employee_NAME INTO v_name FROM EMPLOYEE WHERE EMPLOYEE_ID = p_emp_id AND DEPARTMENT_DEPT_ID = V_DEPT_REQ;
    ELSE
        RAISE EMPLOYEE_NOT_FOUND;
    END IF;

    IF V_EXISTS_REQ = 'Y' AND v_name IS NOT NULL AND V_DEPT_REQ IS NOT NULL THEN
    UPDATE SERVICE_REQUEST SET 
    STATUS = UPPER('Assigned to ' || V_name),
    SCHEDULED_FOR = SYSDATE,
    COMPLETED_AT = NULL
    WHERE REQUEST_ID = p_req_id;
    DBMS_OUTPUT.PUT_LINE('Assigned to ' || v_name || ' Successfully');
    END IF;
    
EXCEPTION
    WHEN SERVICE_REQUEST_NOT_FOUND THEN
        DBMS_OUTPUT.PUT_LINE(' Service request not found.');
    WHEN DEPARTMENT_NOT_FOUND THEN
        DBMS_OUTPUT.PUT_LINE(' Request ID ' || p_req_id || ' belongs to Department ' || V_DEPT_REQ || '. Assign to the proper department.');
    WHEN EMPLOYEE_NOT_FOUND THEN
        DBMS_OUTPUT.PUT_LINE(' Employee not found in the specified department.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Oops!'||SUBSTR(SQLERRM, 11));
        DBMS_OUTPUT.PUT_LINE('Request ID ' || p_req_id || ' belongs to Department ' || V_DEPT_REQ || '. Assign to the proper employee of respective department.');
END schedule_emp;
/

--EXEC schedule_emp(999, '8888');
--EXEC schedule_emp(1,5);

-- 5. fire emp proc

CREATE OR REPLACE PROCEDURE fire_emp(
    p_emp_id IN NUMBER, 
    p_name IN VARCHAR2
) AS
    V_EXISTS VARCHAR2(1) := 'N';
    V_NAME VARCHAR2(50);
    V_DEPT_ID NUMBER;
    V_NEW_EMPLOYEE_NAME VARCHAR2(50);

BEGIN
    SELECT 'Y', EMPLOYEE_NAME, DEPARTMENT_DEPT_ID
    INTO V_EXISTS, V_NAME, V_DEPT_ID
    FROM EMPLOYEE 
    WHERE EMPLOYEE_ID = p_emp_id AND EMPLOYEE_NAME = INITCAP(p_name);

    IF V_EXISTS = 'Y' THEN
        SELECT EMPLOYEE_NAME
        INTO V_NEW_EMPLOYEE_NAME
        FROM EMPLOYEE
        WHERE DEPARTMENT_DEPT_ID = V_DEPT_ID
          AND EMPLOYEE_ID != p_emp_id
        ORDER BY DBMS_RANDOM.VALUE
        FETCH FIRST 1 ROW ONLY;
        DELETE FROM EMPLOYEE WHERE EMPLOYEE_ID = p_emp_id;
        DBMS_OUTPUT.PUT_LINE('Sorry ' || V_NAME || '! Goodbye :(');
        UPDATE SERVICE_REQUEST
        SET STATUS = 'Assigned to ' || V_NEW_EMPLOYEE_NAME
        WHERE STATUS = 'Assigned to ' || V_NAME
        AND TYPE IN (SELECT NAME FROM DEPARTMENT WHERE DEPT_ID = V_DEPT_ID);

        DBMS_OUTPUT.PUT_LINE('If any current SRs exists then ' || V_NEW_EMPLOYEE_NAME || ' will take care after employee departure.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Employee not found.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE('Oops!'||SUBSTR(SQLERRM, 11));
END fire_emp;
/

-- 6. trigger

CREATE OR REPLACE TRIGGER before_sr_insert
BEFORE INSERT ON SERVICE_REQUEST
FOR EACH ROW
DECLARE
    V_RANDOM_EMPLOYEE_NAME VARCHAR2(50);
BEGIN
    SELECT EMPLOYEE_NAME
    INTO V_RANDOM_EMPLOYEE_NAME
    FROM EMPLOYEE
    WHERE DEPARTMENT_DEPT_ID = (
        SELECT DEPT_ID
        FROM DEPARTMENT
        WHERE NAME = :NEW.TYPE
    )
    ORDER BY DBMS_RANDOM.VALUE
    FETCH FIRST 1 ROW ONLY;

    IF V_RANDOM_EMPLOYEE_NAME IS NOT NULL THEN
        :NEW.STATUS := UPPER('Assigned to ' || V_RANDOM_EMPLOYEE_NAME);
    ELSE
        :NEW.STATUS := 'Not Assigned (No Employee in Department)';
    END IF;
END before_sr_insert;
/




