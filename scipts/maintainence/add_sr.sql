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
