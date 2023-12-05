SET SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE add_payment(
    PI_LEASE_ID LEASE.LEASE_ID%TYPE
)
AS
    v_lease_count NUMBER;
    v_rent_status VARCHAR2(100);
    v_pending_dues NUMBER;
    E_LEASE_NOT_FOUND EXCEPTION;
    E_NOTHING_TO_PAY EXCEPTION;
BEGIN
    SELECT COUNT(*)
    INTO v_lease_count
    FROM LEASE
    WHERE LEASE_ID = PI_LEASE_ID;

    IF v_lease_count = 0 THEN
        RAISE E_LEASE_NOT_FOUND;
    END IF;

    SELECT RENT_STATUS, PENDING_DUES
    INTO v_rent_status, v_pending_dues
    FROM LEASE
    WHERE LEASE_ID = PI_LEASE_ID;

    IF v_rent_status = 'Paid' AND v_pending_dues < 1 THEN
        RAISE E_NOTHING_TO_PAY;
    END IF;

    UPDATE LEASE
    SET 
        RENT_STATUS = 'Paid',
        PENDING_DUES = 0,
        DUES_LAST_CLEARED = SYSDATE,
        PENDING_DUE_ON = ADD_MONTHS(PENDING_DUE_ON, 1)
    WHERE LEASE_ID = PI_LEASE_ID;

    COMMIT;
EXCEPTION
    WHEN E_LEASE_NOT_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: Lease ID not found.');
    WHEN E_NOTHING_TO_PAY THEN
        DBMS_OUTPUT.PUT_LINE('Error: There is nothing to be paid.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Oops! ' || SQLERRM);
END add_payment;
/



select * from lease where lease_id=51;
EXEC add_payment(51);
select * from lease where lease_id=51;

