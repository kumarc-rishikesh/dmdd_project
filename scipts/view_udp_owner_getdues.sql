CREATE OR REPLACE VIEW OWNER_VIEW AS
    WITH dues AS(
    SELECT l.room_no, l.lease_id, l.rent+(u.utility_cost*u.curr_cycle_units)+v.penalty as pending_dues from lease l
    INNER JOIN utility u ON l.lease_id = u.lease_lease_id
    INNER JOIN violations v on l.lease_id = v.lease_lease_id)
    SELECT  l.owner_owner_id owner_id, l.lease_id, l.room_no, d.pending_dues 
    FROM lease l
    INNER JOIN dues d 
    ON l.lease_id = d.lease_id;
    
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE OWNER_GETDUES(PI_OWNER_ID NUMBER)
AS
    v_owner_check NUMBER := 1;
    v_lease_id NUMBER;
    v_room_no NUMBER;
    v_pending_dues NUMBER;
BEGIN
    SELECT owner_id INTO v_owner_check
    FROM OWNER_VIEW
    WHERE owner_id = PI_OWNER_ID;
    IF v_owner_check = PI_OWNER_ID THEN
        DBMS_OUTPUT.PUT_LINE('Lease ID | Room No | Pending Dues');
        DBMS_OUTPUT.PUT_LINE('---------------------------------');

        FOR rec IN (SELECT ov.lease_id, ov.room_no, ov.pending_dues
                    FROM OWNER_VIEW ov 
                    WHERE ov.owner_id = PI_OWNER_ID)
        LOOP
            v_lease_id := rec.lease_id;
            v_room_no := rec.room_no;
            v_pending_dues := rec.pending_dues;

            DBMS_OUTPUT.PUT_LINE(v_lease_id || ' | ' || v_room_no || ' | ' || v_pending_dues);
        END LOOP;
    ELSE
        DBMS_OUTPUT.PUT_LINE('PLEASE ENTER A VALID OWNER ID');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END OWNER_GETDUES;
/