DECLARE
  V_EXISTS VARCHAR2(1) := 'N';
  V_DDL VARCHAR2(2500);
BEGIN
  SELECT 'Y' INTO V_EXISTS
  FROM USER_TABLES WHERE TABLE_NAME = 'LEASE';

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      V_DDL := '
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
        )';
      EXECUTE IMMEDIATE V_DDL;
END;
/

DECLARE
  V_EXISTS VARCHAR2(1) := 'N';
  V_DDL VARCHAR2(2500);
BEGIN
  SELECT 'Y' INTO V_EXISTS
  FROM USER_TABLES WHERE TABLE_NAME = 'VIOLATIONS';

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      V_DDL := '
        CREATE TABLE VIOLATIONS (
          violation_id     NUMBER PRIMARY KEY,
          LEASE_lease_id   VARCHAR2(250),
          penalty          NUMBER,
          type             VARCHAR2(250)
        )';
      EXECUTE IMMEDIATE V_DDL;
END;
/

ALTER TABLE VIOLATIONS
ADD CONSTRAINT FK_VIOLATIONS_LEASE
FOREIGN KEY (LEASE_lease_id)
REFERENCES LEASE (lease_id);



DECLARE
  V_EXISTS VARCHAR2(1) := 'N';
  V_DDL VARCHAR2(2500);
BEGIN
  SELECT 'Y' INTO V_EXISTS
  FROM USER_TABLES WHERE TABLE_NAME = 'OWNER';

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      V_DDL := '
        CREATE TABLE OWNER (
          owner_id     NUMBER PRIMARY KEY,
          phone_no     NUMBER NOT NULL,
          nationality  VARCHAR2(250) NOT NULL,
          gender       VARCHAR2(250),
          dob          DATE NOT NULL,
          ssn          VARCHAR2(250) NOT NULL
        )';
      EXECUTE IMMEDIATE V_DDL;
END;
/


DECLARE
  V_EXISTS VARCHAR2(1) := 'N';
  V_DDL VARCHAR2(2500);
BEGIN
  SELECT 'Y' INTO V_EXISTS
  FROM USER_TABLES WHERE TABLE_NAME = 'SERVICE_REQUEST';

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      V_DDL := '
        CREATE TABLE SERVICE_REQUEST (
          request_id       NUMBER PRIMARY KEY,
          LEASE_lease_id   VARCHAR(250),
          type             VARCHAR2(250) NOT NULL,
          dept             VARCHAR2(250) NOT NULL,
          status           VARCHAR2(250),
          scheduled_for    DATE,
          completed_at     DATE,
          resident_name    VARCHAR2(250) NOT NULL
        )';
      EXECUTE IMMEDIATE V_DDL;
END;
/

ALTER TABLE SERVICE_REQUEST
ADD CONSTRAINT FK_SERVICE_REQUEST_LEASE
FOREIGN KEY (LEASE_lease_id)
REFERENCES LEASE (lease_id);

