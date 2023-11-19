CREATE OR REPLACE PROCEDURE add_sr (
    p_lease_id IN NUMBER,
    p_name IN VARCHAR2,
    p_dep1 IN NUMBER DEFAULT NULL,
    p_dep2 IN NUMBER DEFAULT NULL,
    p_dep3 IN NUMBER DEFAULT NULL)
IS
    v_dept_ids SYS.ODCINUMBERLIST := SYS.ODCINUMBERLIST();
    v_request_id NUMBER;
    ALL_NULL EXCEPTION;
    SAME_DEPS EXCEPTION;
BEGIN
    IF p_dep1 IS NULL AND p_dep2 IS NULL AND p_dep3 IS NULL THEN
        RAISE ALL_NULL;
    END IF;

    IF p_dep1 IS NOT NULL THEN
        v_dept_ids.EXTEND;
        v_dept_ids(1) := p_dep1;
    END IF;

    IF p_dep2 IS NOT NULL THEN
        v_dept_ids.EXTEND;
        v_dept_ids(2) := p_dep2;
    END IF;

    IF p_dep3 IS NOT NULL THEN
        v_dept_ids.EXTEND;
        v_dept_ids(3) := p_dep3;
    END IF;

    SELECT SERVICE_REQUEST_ID_SEQ.NEXTVAL INTO v_request_id FROM DUAL;
    INSERT INTO SERVICE_REQUEST (request_id, LEASE_lease_id, type, status, scheduled_for,resident_name)
    VALUES (v_request_id, p_lease_id, 'resident_raised', 'open' , SYSDATE+5 ,p_name);

    FOR i IN 1..v_dept_ids.COUNT LOOP
        INSERT INTO SR_DEPT (sr_dept_id, DEPARTMENT_dept_id, SERVICE_REQUEST_request_id)
        VALUES (SR_DEPT_ID_SEQ.NEXTVAL, v_dept_ids(i), v_request_id);
        DBMS_OUTPUT.PUT_LINE('Data inserted successfully.');
    END LOOP;

    COMMIT;
EXCEPTION
    WHEN ALL_NULL THEN
        DBMS_OUTPUT.PUT_LINE('ALL 3 DEPARTMENTS ARE NULL');
    WHEN SAME_DEPS THEN
        DBMS_OUTPUT.PUT_LINE('DEPARTMENTS MUST BE DISTINCT');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END add_sr;
/