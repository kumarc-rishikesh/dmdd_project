CREATE OR REPLACE VIEW RESIDENT_VIEW AS
    WITH dues AS(
    SELECT l.lease_id, l.rent+(u.utility_cost*u.curr_cycle_units)+v.penalty as pending_dues from lease l
    INNER JOIN utility u ON l.lease_id = u.lease_lease_id
    INNER JOIN violations v on l.lease_id = v.lease_lease_id)
    SELECT r.resident_id resident_id, l.lease_id, d.pending_dues 
    FROM resident r 
    INNER JOIN lease l
    ON r.lease_lease_id = l.lease_id
    INNER JOIN dues d 
    ON l.lease_id = d.lease_id;
    
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE RESIDENT_GETDUES(PI_RESIDENT_ID NUMBER)
AS
    v_resident_check NUMBER := 1;
    v_lease_id NUMBER;
    v_pending_dues NUMBER;
BEGIN
    SELECT resident_id INTO v_resident_check
    FROM RESIDENT_VIEW
    WHERE resident_id = PI_RESIDENT_ID;
    IF v_resident_check = PI_RESIDENT_ID THEN
        DBMS_OUTPUT.PUT_LINE('Lease ID | Pending Dues');
        DBMS_OUTPUT.PUT_LINE('---------------------------------');
        

        FOR rec IN (SELECT rv.lease_id,rv.pending_dues
                    FROM RESIDENT_VIEW rv 
                    WHERE rv.resident_id = PI_RESIDENT_ID)
        LOOP
            v_lease_id := rec.lease_id;
            v_pending_dues := rec.pending_dues;

            DBMS_OUTPUT.PUT_LINE(v_lease_id || ' | ' || v_pending_dues);
        END LOOP;
    ELSE
        DBMS_OUTPUT.PUT_LINE('PLEASE ENTER A VALID RESIDENT ID');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END RESIDENT_GETDUES;
/


exec resident_getdues(11);