CREATE OR REPLACE PROCEDURE add_sr(p_lease_id IN NUMBER, p_type IN VARCHAR2) AS
    v_exists VARCHAR(1):='N';
    v_name VARCHAR2(50);
    v_verify NUMBER;
    NOT_FOUND EXCEPTION;
    ALREADY_EXISTS EXCEPTION;
BEGIN
    SELECT 'Y' INTO v_exists FROM LEASE WHERE lease_id = p_lease_id;
    SELECT RESIDENT_NAME INTO v_name FROM LEASE WHERE lease_id = p_lease_id;
    SELECT lease_lease_id INTO v_verify FROM service_request WHERE lease_lease_id = p_lease_id;

    IF v_exists = 'N' THEN
        RAISE NOT_FOUND;
    END IF;

    IF v_verify IS NOT NULL THEN
        RAISE ALREADY_EXISTS;
    END IF;

    IF p_type = 'Electric' THEN
        INSERT INTO service_request (REQUEST_ID, LEASE_LEASE_ID, TYPE, DEPT, STATUS, RESIDENT_NAME)
        VALUES (SERVICE_REQUEST_ID_SEQ.NEXTVAL, p_lease_id, p_type, 1,'OPEN', v_name);
        DBMS_OUTPUT.PUT_LINE('Your Electric Maintenance is reported and will be assisted soon! Thank you :)');
    ELSIF p_type = 'Plumbing' THEN
        INSERT INTO service_request (REQUEST_ID, LEASE_LEASE_ID, TYPE, DEPT,STATUS, RESIDENT_NAME)
        VALUES (SERVICE_REQUEST_ID_SEQ.NEXTVAL, p_lease_id, p_type, 2,'OPEN', v_name);
        DBMS_OUTPUT.PUT_LINE('Your Plumbing Maintenance is reported and will be assisted soon! Thank you :)');
    ELSIF p_type = 'General' THEN
        INSERT INTO service_request (REQUEST_ID, LEASE_LEASE_ID, TYPE, DEPT,STATUS, RESIDENT_NAME)
        VALUES (SERVICE_REQUEST_ID_SEQ.NEXTVAL, p_lease_id, p_type, 3,'OPEN', v_name);
        DBMS_OUTPUT.PUT_LINE('Your General Maintenance is reported and will be assisted soon! Thank you :)');
    END IF;

    COMMIT;

EXCEPTION
    WHEN NOT_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Invalid Lease ID');
    WHEN ALREADY_EXISTS THEN
        DBMS_OUTPUT.PUT_LINE('There is already a request submitted, Please submit your request post completion');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END add_sr;
/
