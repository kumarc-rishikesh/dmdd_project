SET SERVEROUTPUT ON 
BEGIN 
	FOR I IN (
		WITH MYOBJECTS AS (
-- tables
		SELECT 'VIOLATIONS' OBJNAME FROM DUAL
		UNION ALL SELECT  'EMPLOYEE' FROM DUAL 	
		UNION ALL SELECT  'SR_DEPT' FROM DUAL
		UNION ALL SELECT  'SERVICE_REQUEST' FROM DUAL 		
        UNION ALL SELECT  'DEPARTMENT' FROM DUAL
		UNION ALL SELECT  'UTILITY' FROM DUAL 		
        UNION ALL SELECT  'AMENITY_BOOKING' FROM DUAL 
		UNION ALL SELECT  'AMENITIES' FROM DUAL 		
        UNION ALL SELECT  'RESIDENT' FROM DUAL
		UNION ALL SELECT  'LEASE' FROM DUAL
		UNION ALL SELECT  'OWNER' FROM DUAL
--sequences
		UNION ALL SELECT  'OWNER_ID_SEQ' FROM DUAL
		UNION ALL SELECT  'LEASE_ID_SEQ' FROM DUAL
		UNION ALL SELECT  'VIOLATION_ID_SEQ' FROM DUAL
		UNION ALL SELECT  'SERVICE_REQUEST_ID_SEQ' FROM DUAL
		UNION ALL SELECT  'DEPT_ID_SEQ' FROM DUAL
		UNION ALL SELECT  'SR_DEPT_ID_SEQ' FROM DUAL
		UNION ALL SELECT  'EMPLOYEE_ID_SEQ' FROM DUAL
		UNION ALL SELECT  'AMENITIES_ID_SEQ' FROM DUAL
		UNION ALL SELECT  'BOOKING_ID_SEQ' FROM DUAL
		UNION ALL SELECT  'RESIDENT_ID_SEQ' FROM DUAL
		UNION ALL SELECT  'UTILITY_ID_SEQ' FROM DUAL
		)
		SELECT M.OBJNAME , O.OBJECT_TYPE
		FROM MYOBJECTS M INNER JOIN USER_OBJECTS O ON M.OBJNAME = O.OBJECT_NAME
		WHERE O.OBJECT_TYPE IN ('TABLE', 'SEQUENCE')
	)
	LOOP
		DBMS_OUTPUT.PUT_LINE('TABLE/VIEW/SEQUENCE NAME TO BE DROPPED:' || I.OBJNAME );
	    EXECUTE IMMEDIATE 'DROP ' ||I.OBJECT_TYPE||' '|| I.OBJNAME;
	END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/

CREATE SEQUENCE OWNER_ID_SEQ;
CREATE TABLE OWNER (
      owner_id    				    NUMBER PRIMARY KEY,
      owner_name                    VARCHAR2(50) NOT NULL,
      phone_no    				    NUMBER 	UNIQUE NOT NULL,
      nationality 				    VARCHAR2(50) NOT NULL,
      gender				        VARCHAR2(50),
      dob				            DATE NOT NULL,
      ssn				            VARCHAR2(9) UNIQUE NOT NULL
    );

CREATE SEQUENCE LEASE_ID_SEQ;
CREATE TABLE LEASE (
	  lease_id						NUMBER PRIMARY KEY,
	  start_date         			DATE NOT NULL,
	  end_date        			    DATE NOT NULL,
	  room_no           			NUMBER NOT NULL,
	  unit_type        			    VARCHAR2(50) NOT NULL,
	  rent            			    NUMBER NOT NULL,
	  rent_status        			VARCHAR2(50) NOT NULL,
	  pending_dues 			       	NUMBER,
	  dues_last_cleared				DATE,
	  pending_due_on      			DATE,
	  OWNER_owner_id     			REFERENCES OWNER(owner_id) NOT NULL
);


CREATE SEQUENCE RESIDENT_ID_SEQ;
CREATE TABLE RESIDENT (
      resident_id					NUMBER PRIMARY KEY,
      resident_name                 VARCHAR2(50) NOT NULL,
      phone_no					    NUMBER NOT NULL,
      nationality					VARCHAR2(50) NOT NULL,
      gender						VARCHAR2(50) ,
      dob							DATE,
      SSN							VARCHAR2(9) UNIQUE ,
      LEASE_lease_id				REFERENCES LEASE(lease_id) NOT NULL
    );

CREATE SEQUENCE AMENITIES_ID_SEQ;
CREATE TABLE AMENITIES (
      amenity_id        			NUMBER PRIMARY KEY,
      amenity_name      			VARCHAR2(50) NOT NULL,
      total_slots       			NUMBER DEFAULT 100 NOT NULL,
      hourly_charge     			NUMBER NOT NULL,
      closure_start     			DATE,
      closure_end       			DATE,
      closure_reason    			VARCHAR(250),
      guests_permitted  			NUMBER NOT NULL,
      max_duration_hours			NUMBER NOT NULL 
    );

CREATE SEQUENCE BOOKING_ID_SEQ;
CREATE TABLE AMENITY_BOOKING (
      booking_id       			NUMBER PRIMARY KEY,
      no_of_guests     			NUMBER NOT NULL,
      booking_from     			DATE NOT NULL,
      booking_to       			DATE NOT NULL,
      cancellation_status		VARCHAR2(250),
      AMENITY_amenity_id        REFERENCES AMENITIES(amenity_id) NOT NULL,
      LEASE_lease_id			REFERENCES LEASE(lease_id) NOT NULL
    ); 

 CREATE SEQUENCE UTILITY_ID_SEQ;
 CREATE TABLE UTILITY (
     utility_billing_id				NUMBER PRIMARY KEY,
     utility_name					VARCHAR2(50) NOT NULL,
     utility_cost					NUMBER NOT NULL,
     unit_metric      	 			VARCHAR2(10) NOT NULL,
     curr_cycle_units				NUMBER NOT NULL,
     cycle_billed_on				DATE NOT NULL,
     LEASE_lease_id					NUMBER NOT NULL,
     CONSTRAINT check_utility_name CHECK (UPPER(utility_name) IN ('ELECTRICITY', 'WATER', 'GAS'))
   );

CREATE SEQUENCE VIOLATION_ID_SEQ;
CREATE TABLE VIOLATIONS (
      violation_id     				NUMBER PRIMARY KEY,
      LEASE_lease_id   				REFERENCES LEASE(lease_id) NOT NULL,
      penalty          				NUMBER,
      type             				VARCHAR2(250) NOT NULL
    );
 

CREATE SEQUENCE DEPT_ID_SEQ;
CREATE TABLE DEPARTMENT (
      dept_id          				NUMBER PRIMARY KEY,
      name			  				VARCHAR2(250) NOT NULL
    );
   

CREATE SEQUENCE SERVICE_REQUEST_ID_SEQ;
CREATE TABLE SERVICE_REQUEST (
      request_id      				NUMBER PRIMARY KEY,
      LEASE_lease_id  				REFERENCES LEASE(lease_id) NOT NULL,
      type            				VARCHAR2(250) NOT NULL,
      dept             				REFERENCES DEPARTMENT(dept_id) NOT NULL,
      status           				VARCHAR2(50),
      scheduled_for    				DATE,
      completed_at     				DATE,
      resident_name    				VARCHAR2(250) NOT NULL
    );
   
   
CREATE SEQUENCE EMPLOYEE_ID_SEQ;
CREATE TABLE EMPLOYEE (
      employee_id					NUMBER PRIMARY KEY,
      employee_name                 VARCHAR2(50),
      phone_no						NUMBER NOT NULL,	
      gender						VARCHAR2(50),
      dob							DATE NOT NULL,
      doj							DATE NOT NULL,
      termination_date				DATE,
      salary						NUMBER NOT NULL,
      SSN							VARCHAR2(50),
      DEPARTENT_dept_id				REFERENCES DEPARTMENT(dept_id) NOT NULL
    );

CREATE SEQUENCE SR_DEPT_ID_SEQ;
CREATE TABLE SR_DEPT (
      sr_dept_id                    NUMBER PRIMARY KEY,
      DEPARTMENT_dept_id  			REFERENCES DEPARTMENT(dept_id),
      SERVICE_REQUEST_request_id    REFERENCES SERVICE_REQUEST(request_id)
    );