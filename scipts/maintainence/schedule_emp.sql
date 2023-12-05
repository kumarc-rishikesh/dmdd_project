CREATE OR REPLACE PROCEDURE schedule_emp(
    p_req_id IN NUMBER, 
    p_emp_id IN VARCHAR2
) AS
    V_EXISTS_REQ VARCHAR2(1) := 'N';
    V_DEPT_REQ NUMBER;
    V_name VARCHAR2(50);

    -- Exceptions
    SERVICE_REQUEST_NOT_FOUND EXCEPTION;
    DEPARTMENT_NOT_FOUND EXCEPTION;
    EMPLOYEE_NOT_FOUND EXCEPTION;

BEGIN
    SELECT 'Y' INTO V_EXISTS_REQ FROM SERVICE_REQUEST WHERE REQUEST_ID = p_req_id;
    IF V_EXISTS_REQ = 'N' THEN
        RAISE SERVICE_REQUEST_NOT_FOUND;
    END IF;

    SELECT D.DEPT_ID INTO V_DEPT_REQ FROM SERVICE_REQUEST S JOIN DEPARTMENT D ON S.TYPE = D.NAME WHERE REQUEST_ID = P_REQ_ID;
    IF V_DEPT_REQ IS NULL THEN
        RAISE DEPARTMENT_NOT_FOUND;
    END IF;

    SELECT employee_NAME INTO V_name FROM EMPLOYEE WHERE EMPLOYEE_ID = p_emp_id AND DEPARTMENT_DEPT_ID = V_DEPT_REQ;
    IF V_name IS NULL THEN
        RAISE EMPLOYEE_NOT_FOUND;
    END IF;


    IF V_EXISTS_REQ = 'Y' THEN
        UPDATE SERVICE_REQUEST SET 
        STATUS = UPPER('Assigned to ' || V_name),
        SCHEDULED_FOR = SYSDATE,
        COMPLETED_AT = NULL
        WHERE REQUEST_ID = p_req_id;
    
        DBMS_OUTPUT.PUT_LINE('Assigned to ' || V_name || ' Successfully');
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
