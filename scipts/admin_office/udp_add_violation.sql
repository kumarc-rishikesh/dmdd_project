-- Check if the penalty is not null and update pending dues accordingly
-- If pending dues are not null, add the penalty to the existing amount and update rent status
                
                
SET SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE add_violation(
    PI_LEASE_ID VIOLATIONS.LEASE_LEASE_ID%TYPE,
    PI_PENALTY NUMBER,
    PI_TYPE VARCHAR2
)
AS
    v_current_pending_dues NUMBER;
    v_current_pending_due_on DATE;
    v_lease_end_date DATE;
    E_LEASE_NOT_ACTIVE EXCEPTION;
BEGIN
    SELECT PENDING_DUES, PENDING_DUE_ON, END_DATE INTO v_current_pending_dues, v_current_pending_due_on, v_lease_end_date
    FROM LEASE
    WHERE LEASE_ID = PI_LEASE_ID;

    IF v_lease_end_date < SYSDATE THEN
        RAISE E_LEASE_NOT_ACTIVE;
    END IF;

    INSERT INTO VIOLATIONS (
        VIOLATION_ID, LEASE_LEASE_ID, PENALTY, TYPE
    ) VALUES (
        violation_id_seq.NEXTVAL, PI_LEASE_ID, PI_PENALTY, PI_TYPE
    );

   

    IF PI_PENALTY IS NOT NULL THEN
        IF v_current_pending_dues IS NULL THEN
            -- If pending dues are null, set it to the penalty and update rent status
            UPDATE LEASE SET PENDING_DUES = PI_PENALTY, RENT_STATUS = 'Unpaid', DUES_LAST_CLEARED = SYSDATE WHERE LEASE_ID = PI_LEASE_ID;
        ELSE
            UPDATE LEASE SET PENDING_DUES = PENDING_DUES + PI_PENALTY, RENT_STATUS = 'Unpaid', DUES_LAST_CLEARED = SYSDATE WHERE LEASE_ID = PI_LEASE_ID;
        END IF;
        
        IF v_current_pending_due_on IS NULL THEN
            UPDATE LEASE SET PENDING_DUE_ON = ADD_MONTHS(SYSDATE, 1) WHERE LEASE_ID = PI_LEASE_ID;
        ELSE
            UPDATE LEASE SET PENDING_DUE_ON = ADD_MONTHS(v_current_pending_due_on, 1) WHERE LEASE_ID = PI_LEASE_ID;
        END IF;
    END IF;

    COMMIT;
EXCEPTION
    WHEN E_LEASE_NOT_ACTIVE THEN
        DBMS_OUTPUT.PUT_LINE('Lease is not active.');
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Lease ID not found.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END add_violation;
/




EXEC ADD_VIOLATION('51', 500, 'Pet');
--select * from violations where lease_lease_id=51;
--select * from lease where lease_id=51;

--SELECT lease_id, start_date, end_date
--FROM LEASE
--WHERE start_date <= SYSDATE AND end_date >= SYSDATE;

--select * from lease;




--delete from violations where lease_lease_id=51;
--commit;