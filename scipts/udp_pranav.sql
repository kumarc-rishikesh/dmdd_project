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



--select * from lease where lease_id=51;
--EXEC add_payment(51);
--EXEC add_payment(519);
--select * from lease where lease_id=51;


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





--EXEC ADD_VIOLATION('51', 500, 'Pet');
--select * from violations where lease_lease_id=51;
--select * from lease where lease_id=51;

--SELECT lease_id, start_date, end_date
--FROM LEASE
--WHERE start_date <= SYSDATE AND end_date >= SYSDATE;

--select * from lease;




--delete from violations where lease_lease_id=51;
--commit;

CREATE OR REPLACE PROCEDURE ADD_NEW_LEASE(
    PI_OWNER_ID OWNER.OWNER_ID%TYPE,
    PI_START_DATE DATE,
    PI_END_DATE DATE,
    PI_ROOM_NO VARCHAR2,
    PI_UNIT_TYPE VARCHAR2,
    PI_RENT NUMBER,
    PI_RENT_STATUS VARCHAR2,
    PI_PENDING_DUES NUMBER DEFAULT 0,
    PI_DUES_LAST_CLEARED DATE DEFAULT NULL,
    PI_PENDING_DUE_ON DATE
)
AS
    v_lease_count NUMBER;
    v_owner_count NUMBER;
    E_ROOM_ALREADY_LEASED EXCEPTION;
    E_OWNER_NOT_FOUND EXCEPTION;
BEGIN
    -- Check if the owner exists
    SELECT COUNT(*)
    INTO v_owner_count
    FROM OWNER
    WHERE OWNER_ID = PI_OWNER_ID;

    IF v_owner_count = 0 THEN
        RAISE E_OWNER_NOT_FOUND;
    END IF;

    -- Check if the room is already leased
    SELECT COUNT(*)
    INTO v_lease_count
    FROM LEASE
    WHERE ROOM_NO = PI_ROOM_NO
    AND (
        (PI_START_DATE <= START_DATE AND PI_END_DATE >= START_DATE)
    );

    IF v_lease_count > 0 THEN
        RAISE E_ROOM_ALREADY_LEASED;
    ELSE
        -- Insert the new lease
        INSERT INTO LEASE (
            LEASE_ID, OWNER_OWNER_ID, START_DATE, END_DATE, ROOM_NO, UNIT_TYPE, RENT, 
            RENT_STATUS, PENDING_DUES, DUES_LAST_CLEARED, PENDING_DUE_ON
        ) VALUES (
            LEASE_ID_SEQ.NEXTVAL, PI_OWNER_ID, PI_START_DATE, PI_END_DATE, PI_ROOM_NO, 
            PI_UNIT_TYPE, PI_RENT, PI_RENT_STATUS, PI_PENDING_DUES, 
            PI_DUES_LAST_CLEARED, PI_PENDING_DUE_ON
        );
        COMMIT;
    END IF;

EXCEPTION
    WHEN E_ROOM_ALREADY_LEASED THEN
        DBMS_OUTPUT.PUT_LINE('The room is already leased for the specified period.');
    WHEN E_OWNER_NOT_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Owner ID not found.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Oops! ' || SQLERRM);
END ADD_NEW_LEASE;
/


--EXEC ADD_NEW_LEASE(1, TO_DATE('2023-10-04', 'YYYY-MM-DD'), TO_DATE('2023-10-04', 'YYYY-MM-DD'), '101', '2BHK', 1500, 'Not Paid', 0, NULL, TO_DATE('2023-11-04', 'YYYY-MM-DD'));


CREATE OR REPLACE PROCEDURE ONBOARD_OWNER(
    PI_OWNER_ID OWNER.OWNER_ID%TYPE,
    PI_OWNER_NAME OWNER.OWNER_NAME%TYPE,
    PI_PHONE_NO OWNER.PHONE_NO%TYPE,
    PI_NATIONALITY OWNER.NATIONALITY%TYPE,
    PI_GENDER OWNER.GENDER%TYPE,
    PI_DOB OWNER.DOB%TYPE,
    PI_SSN OWNER.SSN%TYPE
)
AS
    v_owner_count NUMBER;
    v_ssn_count NUMBER;
    v_new_owner_id OWNER.OWNER_ID%TYPE;
    E_SSN_ALREADY_EXISTS EXCEPTION;
BEGIN
    SELECT COUNT(*)
    INTO v_owner_count
    FROM OWNER
    WHERE OWNER_ID = PI_OWNER_ID;

    IF v_owner_count = 0 THEN
        v_new_owner_id := PI_OWNER_ID;
    ELSE
        SELECT OWNER_ID_SEQ.NEXTVAL INTO v_new_owner_id FROM DUAL;
    END IF;

    SELECT COUNT(*)
    INTO v_ssn_count
    FROM OWNER
    WHERE SSN = PI_SSN;

    IF v_ssn_count > 0 THEN
        RAISE E_SSN_ALREADY_EXISTS;
    END IF;

    INSERT INTO OWNER (
        OWNER_ID, OWNER_NAME, PHONE_NO, NATIONALITY, GENDER, DOB, SSN
    ) VALUES (
        v_new_owner_id, PI_OWNER_NAME, PI_PHONE_NO, PI_NATIONALITY,
        PI_GENDER, PI_DOB, PI_SSN
    );

    COMMIT;
EXCEPTION
    WHEN E_SSN_ALREADY_EXISTS THEN
        DBMS_OUTPUT.PUT_LINE('Error: SSN already in use.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Oops!'||SUBSTR(SQLERRM, 11));
END ONBOARD_OWNER;
/



--EXEC ONBOARD_OWNER(1, 'John Doe', 1234567890, 'American', 'Male', TO_DATE('1980-01-01', 'YYYY-MM-DD'), '123456789');
--SELECT * FROM OWNER WHERE SSN = '123456789';


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



--INSERT INTO LEASE (
 --   LEASE_ID, START_DATE, END_DATE, ROOM_NO, UNIT_TYPE, RENT, 
--    RENT_STATUS, PENDING_DUES, DUES_LAST_CLEARED, PENDING_DUE_ON, OWNER_OWNER_ID
--) VALUES (
--    LEASE_ID_SEQ.NEXTVAL, TO_DATE('2023-10-04', 'YYYY-MM-DD'), TO_DATE('2024-10-04', 'YYYY-MM-DD'), '101', 
--    '101', 1500, 'Paid', 0, 
--    null, null,1
--);
--commit;
--EXEC TERMINATE_LEASE(1, SYSDATE);
--select lease_id,end_date from lease where lease_id=185;







