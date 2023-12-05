--Checks performed: Is the lease active? Is the penalty null? Is the current pending dues null?
-- Check if the penalty is not null and update pending dues accordingly
-- If pending dues are not null, add the penalty to the existing amount and update rent status
                
                
SET SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE add_violation(
    PI_LEASE_ID VIOLATIONS.LEASE_LEASE_ID%TYPE,
    PI_PENALTY NUMBER,
    PI_TYPE VARCHAR2
)
AS
    v_lease_count NUMBER;
    E_LEASE_NOT_FOUND EXCEPTION;
    E_NEGATIVE_PENALTY EXCEPTION;
    E_NULL_PENALTY EXCEPTION;
BEGIN
    -- Check if the lease_id exists
    SELECT COUNT(*)
    INTO v_lease_count
    FROM LEASE
    WHERE LEASE_ID = PI_LEASE_ID;

    IF v_lease_count = 0 THEN
        RAISE E_LEASE_NOT_FOUND;
    END IF;

    -- Check for null or negative penalty
    IF PI_PENALTY IS NULL THEN
        RAISE E_NULL_PENALTY;
    ELSIF PI_PENALTY < 0 THEN
        RAISE E_NEGATIVE_PENALTY;
    END IF;

    -- Insert the violation
    INSERT INTO VIOLATIONS (
        VIOLATION_ID, LEASE_LEASE_ID, PENALTY, TYPE
    ) VALUES (
        violation_id_seq.NEXTVAL, PI_LEASE_ID, PI_PENALTY, PI_TYPE
    );

    -- Update the lease payment details
    UPDATE LEASE
    SET 
        PENDING_DUES = PENDING_DUES + PI_PENALTY,
        RENT_STATUS = 'Unpaid'
    WHERE LEASE_ID = PI_LEASE_ID;

    COMMIT;
EXCEPTION
    WHEN E_LEASE_NOT_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: Lease ID not found.');
    WHEN E_NEGATIVE_PENALTY THEN
        DBMS_OUTPUT.PUT_LINE('Error: Penalty cannot be negative.');
    WHEN E_NULL_PENALTY THEN
        DBMS_OUTPUT.PUT_LINE('Error: Penalty cannot be null.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Oops! ' || SQLERRM);
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