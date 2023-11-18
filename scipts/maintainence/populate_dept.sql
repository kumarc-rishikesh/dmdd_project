DECLARE
  v_dept_id NUMBER;
  v_name VARCHAR2(250);
BEGIN
  SELECT COUNT(*) INTO v_dept_id FROM department;

  IF v_dept_id >= 1 THEN
    DBMS_OUTPUT.PUT_LINE('Departments already exist. Script terminated.');
  ELSE
  
    BEGIN
      SELECT SR_DEPT_ID_SEQ.NEXTVAL INTO v_dept_id FROM dual;
      v_name := 'Electric';

      INSERT INTO department (DEPT_ID, NAME)
        VALUES (v_dept_id, v_name);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Duplicate department ID found. Skipping Electric department.');
    END;

    BEGIN
      SELECT SR_DEPT_ID_SEQ.NEXTVAL INTO v_dept_id FROM dual;
      v_name := 'Plumbing';

      INSERT INTO department (DEPT_ID, NAME)
        VALUES (v_dept_id, v_name);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Duplicate department ID found. Skipping Plumbing department.');
    END;

    BEGIN
      SELECT SR_DEPT_ID_SEQ.NEXTVAL INTO v_dept_id FROM dual;
      v_name := 'General';

      INSERT INTO department (DEPT_ID, NAME)
        VALUES (v_dept_id, v_name);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Duplicate department ID found. Skipping General department.');
    END;

    DBMS_OUTPUT.PUT_LINE('Departments inserted successfully.');
  END IF;
END;
/
