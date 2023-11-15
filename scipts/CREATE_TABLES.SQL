--SCRIPT TO CREATE TABLES

DECLARE
V_EXISTS VARCHAR(1) := 'N';
V_DDL VARCHAR(2500);
BEGIN
SELECT 'Y' INTO V_EXISTS
FROM USER_TABLES WHERE TABLE_NAME = 'amenities';
EXCEPTION
WHEN NO_DATA_FOUND THEN 
V_DDL :='
CREATE TABLE amenities (
    amenity_id         NUMBER NOT NULL,
    amenity_name       VARCHAR2(250) NOT NULL,
    total_slots        NUMBER NOT NULL,
    hourly_charge      NUMBER NOT NULL,
    closure_start      DATE,
    closure_end        DATE,
    closure_reason     VARCHAR2(250),
    guest_permitted    VARCHAR2(250) NOT NULL,
    max_duration_hours NUMBER NOT NULL
)';
EXECUTE IMMEDIATE V_DDL;
END;
/

ALTER TABLE amenities ADD CONSTRAINT amenities_pk PRIMARY KEY ( amenity_id );

DECLARE
V_EXISTS VARCHAR(1) := 'N';
V_DDL VARCHAR(2500);
BEGIN
SELECT 'Y' INTO V_EXISTS
FROM USER_TABLES WHERE TABLE_NAME = 'amenity_booking';
EXCEPTION
WHEN NO_DATA_FOUND THEN 
V_DDL :='
CREATE TABLE amenity_booking (
    booking_id           NUMBER NOT NULL,
    no_of_guests         NUMBER NOT NULL,
    booking_from         DATE NOT NULL,
    booking_to           DATE NOT NULL,
    cancellation_status  VARCHAR2(250),
    amenities_amenity_id NUMBER NOT NULL,
    lease_lease_id       NUMBER NOT NULL
)';
EXECUTE IMMEDIATE V_DDL;
END;
/

ALTER TABLE amenity_booking ADD CONSTRAINT amenity_booking_pk PRIMARY KEY ( booking_id );

DECLARE
V_EXISTS VARCHAR(1) := 'N';
V_DDL VARCHAR(2500);
BEGIN
SELECT 'Y' INTO V_EXISTS
FROM USER_TABLES WHERE TABLE_NAME = 'department';
EXCEPTION
WHEN NO_DATA_FOUND THEN 
V_DDL :='
CREATE TABLE department (
    dept_id VARCHAR2 (250)
     NOT NULL,
    name    VARCHAR2 (250) 
     NOT NULL
)';
EXECUTE IMMEDIATE V_DDL;
END;
/
ALTER TABLE department ADD CONSTRAINT department_pk PRIMARY KEY ( dept_id );

DECLARE
V_EXISTS VARCHAR(1) := 'N';
V_DDL VARCHAR(2500);
BEGIN
SELECT 'Y' INTO V_EXISTS
FROM USER_TABLES WHERE TABLE_NAME = 'employee';
EXCEPTION
WHEN NO_DATA_FOUND THEN 
V_DDL :='
CREATE TABLE employee (
    employee_id        VARCHAR2(250)  
     NOT NULL,
    phone_no           NUMBER NOT NULL,
    gender             VARCHAR2(250),
    dob                DATE NOT NULL,
    doj                DATE NOT NULL,
    termination_date   DATE,
    salary             NUMBER NOT NULL,
    ssn                VARCHAR2(250) NOT NULL,
    department_dept_id VARCHAR2 (250) NOT NULL
)';
EXECUTE IMMEDIATE V_DDL;
END;
/
ALTER TABLE employee ADD CONSTRAINT employee_pk PRIMARY KEY ( employee_id );

DECLARE
V_EXISTS VARCHAR(1) := 'N';
V_DDL VARCHAR(2500);
BEGIN
SELECT 'Y' INTO V_EXISTS
FROM USER_TABLES WHERE TABLE_NAME = 'lease';
EXCEPTION
WHEN NO_DATA_FOUND THEN 
V_DDL :='
CREATE TABLE lease (
    lease_id          NUMBER NOT NULL,
    start_date        DATE NOT NULL,
    end_date          DATE NOT NULL,
    room_no           NUMBER NOT NULL,
    unit_type         VARCHAR2(250) NOT NULL,
    rent              NUMBER NOT NULL,
    rent_status       VARCHAR2(250) NOT NULL,
    pending_dues      NUMBER NOT NULL,
    dues_last_cleared DATE NOT NULL,
    pending_due_on    DATE NOT NULL,
    owner_owner_id    VARCHAR2(250) NOT NULL
)';

EXECUTE IMMEDIATE V_DDL;
END;
/

ALTER TABLE lease ADD CONSTRAINT lease_pk PRIMARY KEY ( lease_id );

DECLARE
V_EXISTS VARCHAR(1) := 'N';
V_DDL VARCHAR(2500);
BEGIN
SELECT 'Y' INTO V_EXISTS
FROM USER_TABLES WHERE TABLE_NAME = 'owner';
EXCEPTION
WHEN NO_DATA_FOUND THEN 
V_DDL :='
CREATE TABLE owner (
    owner_id    VARCHAR2(250) NOT NULL,
    phone_no    NUMBER NOT NULL,
    nationality VARCHAR2 (250) NOT NULL,
    gender      VARCHAR2 (250),
    dob         DATE NOT NULL,
    ssn         VARCHAR2(250) NOT NULL
)';
EXECUTE IMMEDIATE V_DDL;
END;
/

ALTER TABLE owner ADD CONSTRAINT owner_pk PRIMARY KEY ( owner_id );

DECLARE
  V_EXISTS VARCHAR2(1) := 'N';
  V_DDL VARCHAR2(2500);
BEGIN
  SELECT 'Y' INTO V_EXISTS
  FROM USER_TABLES
  WHERE TABLE_NAME = 'resident';

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      V_DDL := '
        CREATE TABLE resident (
          resident_id    NUMBER NOT NULL,
          phone_no       NUMBER NOT NULL,
          nationality    VARCHAR2(250) NOT NULL,
          gender         VARCHAR2(250),
          dob            DATE,
          ssn            VARCHAR2(250),
          lease_lease_id NUMBER NOT NULL
        )';
EXECUTE IMMEDIATE V_DDL;
END;
/
ALTER TABLE resident ADD CONSTRAINT resident_pk PRIMARY KEY ( resident_id );

DECLARE
V_EXISTS VARCHAR(1) := 'N';
V_DDL VARCHAR(2500);
BEGIN
SELECT 'Y' INTO V_EXISTS
FROM USER_TABLES WHERE TABLE_NAME = 'service_request';
EXCEPTION
WHEN NO_DATA_FOUND THEN 
V_DDL :='
CREATE TABLE service_request (
    request_id     VARCHAR2(250) NOT NULL,
    type           VARCHAR2(250) NOT NULL,
    dept           VARCHAR2(250) NOT NULL,
    status         VARCHAR2(250),
    scheduled_for  DATE NOT NULL,
    completed_at   DATE,
    resident_name  VARCHAR2(250) NOT NULL,
    lease_lease_id NUMBER
)';
EXECUTE IMMEDIATE V_DDL;
END;
/

ALTER TABLE service_request ADD CONSTRAINT service_request_pk PRIMARY KEY ( request_id );

DECLARE
V_EXISTS VARCHAR(1) := 'N';
V_DDL VARCHAR(2500);
BEGIN
SELECT 'Y' INTO V_EXISTS
FROM USER_TABLES WHERE TABLE_NAME = 'SR_DEPT';
EXCEPTION
WHEN NO_DATA_FOUND THEN 
V_DDL :='
CREATE TABLE sr_dept (
    service_request_request_id VARCHAR2(250) NOT NULL,
    department_dept_id         VARCHAR2(250) NOT NULL
)';
EXECUTE IMMEDIATE V_DDL;
END;
/

ALTER TABLE sr_dept ADD CONSTRAINT sr_dept_pk PRIMARY KEY ( service_request_request_id, department_dept_id );

DECLARE
V_EXISTS VARCHAR(1) := 'N';
V_DDL VARCHAR(2500);
BEGIN
SELECT 'Y' INTO V_EXISTS
FROM USER_TABLES WHERE TABLE_NAME = 'utility';
EXCEPTION
WHEN NO_DATA_FOUND THEN 
V_DDL :='
CREATE TABLE utility (
    utility_billing_id NUMBER NOT NULL,
    utility_name       VARCHAR2(250) NOT NULL,
    unit_cost          NUMBER NOT NULL,
    unit_metric        VARCHAR2(250) NOT NULL,
    curr_cycle_units   NUMBER NOT NULL,
    cycle_billed_on    DATE NOT NULL,
    lease_lease_id     NUMBER NOT NULL)';
EXECUTE IMMEDIATE V_DDL;
END;
/
ALTER TABLE utility ADD CONSTRAINT utility_pk PRIMARY KEY ( utility_billing_id );

DECLARE
V_EXISTS VARCHAR(1) := 'N';
V_DDL VARCHAR(2500);
BEGIN
SELECT 'Y' INTO V_EXISTS
FROM USER_TABLES WHERE TABLE_NAME = 'violations';
EXCEPTION
WHEN NO_DATA_FOUND THEN 
V_DDL :='
CREATE TABLE violations (
    violation_id   NUMBER NOT NULL,
    type           VARCHAR2 (250) NOT NULL,
    penalty        NUMBER,
    lease_lease_id NUMBER
)';
EXECUTE IMMEDIATE V_DDL;
END;
/

ALTER TABLE violations ADD CONSTRAINT violations_pk PRIMARY KEY ( violation_id );

ALTER TABLE amenity_booking
    ADD CONSTRAINT amenity_booking_amenities_fk FOREIGN KEY ( amenities_amenity_id )
        REFERENCES amenities ( amenity_id );

ALTER TABLE amenity_booking
    ADD CONSTRAINT amenity_booking_lease_fk FOREIGN KEY ( lease_lease_id )
        REFERENCES lease ( lease_id );

ALTER TABLE employee
    ADD CONSTRAINT employee_department_fk FOREIGN KEY ( department_dept_id )
        REFERENCES department ( dept_id );

ALTER TABLE lease
    ADD CONSTRAINT lease_owner_fk FOREIGN KEY ( owner_owner_id )
        REFERENCES owner ( owner_id );

ALTER TABLE resident
    ADD CONSTRAINT resident_lease_fk FOREIGN KEY ( lease_lease_id )
        REFERENCES lease ( lease_id );

ALTER TABLE service_request
    ADD CONSTRAINT service_request_lease_fk FOREIGN KEY ( lease_lease_id )
        REFERENCES lease ( lease_id );

ALTER TABLE sr_dept
    ADD CONSTRAINT sr_dept_department_fk FOREIGN KEY ( department_dept_id )
        REFERENCES department ( dept_id );

ALTER TABLE sr_dept
    ADD CONSTRAINT sr_dept_service_request_fk FOREIGN KEY ( service_request_request_id )
        REFERENCES service_request ( request_id );

ALTER TABLE utility
    ADD CONSTRAINT utility_lease_fk FOREIGN KEY ( lease_lease_id )
        REFERENCES lease ( lease_id );

ALTER TABLE violations
    ADD CONSTRAINT violations_lease_fk FOREIGN KEY ( lease_lease_id )
        REFERENCES lease ( lease_id );
