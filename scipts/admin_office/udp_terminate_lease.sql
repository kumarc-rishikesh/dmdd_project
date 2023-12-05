--if the lease has ended, do nothing
--if the end date isn't provided, set it to sysdate
CREATE OR REPLACE PROCEDURE TERMINATE_LEASE (
    PI_LEASE_ID LEASE.LEASE_ID%TYPE,
    PI_END_DATE DATE DEFAULT SYSDATE
)
AS
    v_lease_count NUMBER;
    v_current_end_date DATE;
    E_LEASE_NOT_FOUND EXCEPTION;
    E_INVALID_END_DATE EXCEPTION;
BEGIN
    SELECT COUNT(*)
    INTO v_lease_count
    FROM LEASE
    WHERE LEASE_ID = PI_LEASE_ID;

    IF v_lease_count = 0 THEN
        RAISE E_LEASE_NOT_FOUND;
    END IF;

    SELECT end_date INTO v_current_end_date
    FROM LEASE
    WHERE LEASE_ID = PI_LEASE_ID;

    IF PI_END_DATE > v_current_end_date OR PI_END_DATE > SYSDATE THEN
        RAISE E_INVALID_END_DATE;
    END IF;

    IF v_current_end_date >= SYSDATE THEN
        UPDATE LEASE
        SET end_date = PI_END_DATE
        WHERE lease_id = PI_LEASE_ID;

        COMMIT;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Lease has already ended, no update performed.');
    END IF;
EXCEPTION
    WHEN E_LEASE_NOT_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Lease ID not found.');
    WHEN E_INVALID_END_DATE THEN
        DBMS_OUTPUT.PUT_LINE('New end date cannot be later than the current or system date.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Oops! ' || SQLERRM);
END TERMINATE_LEASE;
/



INSERT INTO LEASE (
    LEASE_ID, START_DATE, END_DATE, ROOM_NO, UNIT_TYPE, RENT, 
    RENT_STATUS, PENDING_DUES, DUES_LAST_CLEARED, PENDING_DUE_ON, OWNER_OWNER_ID
) VALUES (
    LEASE_ID_SEQ.NEXTVAL, TO_DATE('2023-10-04', 'YYYY-MM-DD'), TO_DATE('2024-10-04', 'YYYY-MM-DD'), '101', 
    '101', 1500, 'Paid', 0, 
    null, null,1
);
commit;
EXEC TERMINATE_LEASE(1, SYSDATE);
select lease_id,end_date from lease where lease_id=185;






