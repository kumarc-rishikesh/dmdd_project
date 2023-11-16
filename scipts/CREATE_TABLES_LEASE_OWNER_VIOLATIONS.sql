DECLARE
  V_TABLE_EXISTS VARCHAR2(1);
  V_CONSTRAINT_EXISTS NUMBER;

  PROCEDURE Check_And_Create_Table(p_table_name VARCHAR2, p_ddl VARCHAR2) IS
  BEGIN
    SELECT COUNT(*) INTO V_TABLE_EXISTS FROM USER_TABLES WHERE TABLE_NAME = UPPER(p_table_name);
    IF V_TABLE_EXISTS = 0 THEN
      EXECUTE IMMEDIATE p_ddl;
    END IF;
  END;

  PROCEDURE Check_And_Add_Constraint(p_table_name VARCHAR2, p_constraint_name VARCHAR2, p_ddl VARCHAR2) IS
  BEGIN
    SELECT COUNT(*) INTO V_CONSTRAINT_EXISTS FROM USER_CONSTRAINTS WHERE CONSTRAINT_NAME = UPPER(p_constraint_name) AND TABLE_NAME = UPPER(p_table_name);
    IF V_CONSTRAINT_EXISTS = 0 THEN
      EXECUTE IMMEDIATE p_ddl;
    END IF;
  END;

BEGIN
  Check_And_Create_Table('LEASE', '
    CREATE TABLE LEASE (
      lease_id            VARCHAR2(250) PRIMARY KEY,
      start_date          DATE NOT NULL,
      end_date            DATE NOT NULL,
      room_no             VARCHAR2(250) NOT NULL,
      unit_type           VARCHAR2(250) NOT NULL,
      rent                NUMBER NOT NULL,
      rent_status         VARCHAR2(250) NOT NULL,
      pending_dues        VARCHAR2(250),
      dues_last_cleared   DATE,
      pending_due_on      DATE
    )');

  Check_And_Create_Table('VIOLATIONS', '
    CREATE TABLE VIOLATIONS (
      violation_id     NUMBER PRIMARY KEY,
      LEASE_lease_id   VARCHAR2(250),
      penalty          NUMBER,
      type             VARCHAR2(250)
    )');
  Check_And_Add_Constraint('VIOLATIONS', 'FK_VIOLATIONS_LEASE', '
    ALTER TABLE VIOLATIONS
    ADD CONSTRAINT FK_VIOLATIONS_LEASE
    FOREIGN KEY (LEASE_lease_id)
    REFERENCES LEASE (lease_id)');

  Check_And_Create_Table('OWNER', '
    CREATE TABLE OWNER (
      owner_id     NUMBER PRIMARY KEY,
      phone_no     NUMBER NOT NULL,
      nationality  VARCHAR2(250) NOT NULL,
      gender       VARCHAR2(250),
      dob          DATE NOT NULL,
      ssn          VARCHAR2(250) NOT NULL
    )');

  Check_And_Create_Table('SERVICE_REQUEST', '
    CREATE TABLE SERVICE_REQUEST (
      request_id       NUMBER PRIMARY KEY,
      LEASE_lease_id   NUMBER,
      type             VARCHAR2(250) NOT NULL,
      dept             VARCHAR2(250) NOT NULL,
      status           VARCHAR2(250),
      scheduled_for    DATE,
      completed_at     DATE,
      resident_name    VARCHAR2(250) NOT NULL
    )');
  Check_And_Add_Constraint('SERVICE_REQUEST', 'FK_SERVICE_REQUEST_LEASE', '
    ALTER TABLE SERVICE_REQUEST
    ADD CONSTRAINT FK_SERVICE_REQUEST_LEASE
    FOREIGN KEY (LEASE_lease_id)
    REFERENCES LEASE (lease_id)');
END;
/
