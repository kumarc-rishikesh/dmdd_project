--Checks performed: Is the lease active? Is the penalty null? Is the current pending dues null?
                
                
SET SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE add_violation(
    PI_LEASE_ID VIOLATIONS.LEASE_LEASE_ID%TYPE,
    PI_PENALTY NUMBER,
    PI_TYPE VARCHAR2
)
AS
    v_current_pending_dues NUMBER;
    v_lease_count NUMBER;
    E_LEASE_NOT_FOUND EXCEPTION;
    E_NO_PENDING_DUES EXCEPTION;
BEGIN
    SELECT COUNT(*)
    INTO v_lease_count
    FROM LEASE
    WHERE LEASE_ID = PI_LEASE_ID;

    IF v_lease_count = 0 THEN
        RAISE E_LEASE_NOT_FOUND;
    END IF;

    SELECT PENDING_DUES INTO v_current_pending_dues FROM LEASE WHERE LEASE_ID = PI_LEASE_ID;

    IF v_current_pending_dues = 0 THEN
        RAISE E_NO_PENDING_DUES;
    END IF;


EXCEPTION
    WHEN E_LEASE_NOT_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: Lease ID not found.');
    WHEN E_NO_PENDING_DUES THEN
        DBMS_OUTPUT.PUT_LINE('Error: No pending dues for this lease.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END add_violation;
/




EXEC ADD_VIOLATION('591', 500, 'Pet');
--select * from violations where lease_lease_id=51;
select * from lease where lease_id=51;

--SELECT lease_id, start_date, end_date
--FROM LEASE
--WHERE start_date <= SYSDATE AND end_date >= SYSDATE;

--select * from lease;




--delete from violations where lease_lease_id=51;
--commit;