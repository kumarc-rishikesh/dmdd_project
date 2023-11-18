CREATE OR REPLACE PROCEDURE add_sr(p_lease_id IN NUMBER, p_type IN VARCHAR2) AS
    v_exists VARCHAR2(1) := 'N';
    NOT_FOUND EXCEPTION;
BEGIN
SELECT 'Y' INTO v_exists FROM LEASE WHERE lease_id = p_lease_id;
    IF v_exists = 'N' THEN
        RAISE NOT_FOUND;
    IF v_exists = 'N' THEN
        INSERT INTO service_request (REQUEST_ID, LEASE_LEASE_ID, TYPE)
        VALUES (SERVICE_REQUEST_ID_SEQ.NEXTVAL, p_lease_id, p_type);
        COMMIT;
    END IF;
ELSE
        RAISE NOT_FOUND;
    END IF;

EXCEPTION
    WHEN NOT_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Invalid Lease ID');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Invalid Input Data');
END add_sr;
/
