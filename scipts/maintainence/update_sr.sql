CREATE OR REPLACE PROCEDURE update_sr(p_request_id IN NUMBER, p_status IN VARCHAR2) AS
    v_status VARCHAR2(50) := 'COMPLETED';
    v_exists VARCHAR2(1) := 'N';
    NOT_FOUND EXCEPTION;
BEGIN
SELECT 'Y' INTO v_exists FROM SERVICE_REQUEST WHERE REQUEST_ID = p_request_id;
IF v_exists = 'Y' THEN
    UPDATE SERVICE_REQUEST
    SET STATUS = v_status,
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
END update_sr;
/
