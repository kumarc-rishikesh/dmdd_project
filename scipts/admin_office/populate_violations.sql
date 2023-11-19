DECLARE
  v_count NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_count FROM VIOLATIONS;
  IF v_count >= 1 THEN
    DBMS_OUTPUT.PUT_LINE('Data already exists in the VIOLATIONS table. Script terminated.');
  ELSE
    INSERT INTO VIOLATIONS (violation_id, LEASE_lease_id, penalty, type) VALUES (VIOLATION_ID_SEQ.NEXTVAL, 1, 100, 'Noise Violation');
    INSERT INTO VIOLATIONS (violation_id, LEASE_lease_id, penalty, type) VALUES (VIOLATION_ID_SEQ.NEXTVAL, 2, 150, 'Parking Violation');
    INSERT INTO VIOLATIONS (violation_id, LEASE_lease_id, penalty, type) VALUES (VIOLATION_ID_SEQ.NEXTVAL, 3, 200, 'Parking Violation');
    INSERT INTO VIOLATIONS (violation_id, LEASE_lease_id, penalty, type) VALUES (VIOLATION_ID_SEQ.NEXTVAL, 4, 120, 'Pet Policy Violation');
    INSERT INTO VIOLATIONS (violation_id, LEASE_lease_id, penalty, type) VALUES (VIOLATION_ID_SEQ.NEXTVAL, 5, 180, 'Damage to Property');
    DBMS_OUTPUT.PUT_LINE('Violations inserted successfully.');
  END IF;
END;
/