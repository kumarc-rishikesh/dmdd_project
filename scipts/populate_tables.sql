SET SERVEROUTPUT ON;
DECLARE
  TYPE nationality_type IS TABLE OF VARCHAR2(100) INDEX BY BINARY_INTEGER;
  TYPE namesarr_type IS TABLE OF VARCHAR2(100) INDEX BY BINARY_INTEGER;
  nationalities nationality_type;
  namesarr namesarr_type;
  birth_date DATE;
  ssn NUMBER;
  random_phone VARCHAR2(10);
BEGIN
  nationalities(1) := 'United States';
  nationalities(2) := 'Canada';
  nationalities(3) := 'United Kingdom';
  nationalities(4) := 'Australia';
  nationalities(5) := 'Germany';
  nationalities(6) := 'France';
  nationalities(7) := 'Japan';
  nationalities(8) := 'South Korea';
  nationalities(9) := 'Brazil';
  nationalities(10) := 'India';
  
  namesarr(1) := 'John';
  namesarr(2) := 'Robert';
  namesarr(3) := 'Michael';
  namesarr(4) := 'Mary';
  namesarr(5) := 'Susan';
  namesarr(6) := 'Jennifer';
  namesarr(7) := 'Jane';
  namesarr(8) := 'Jack';
  namesarr(9) := 'James';
  namesarr(10) := 'Joey';




  FOR i IN 1..25 LOOP
    birth_date := TO_DATE('01-JAN-1940', 'DD-MON-YYYY') + DBMS_RANDOM.VALUE(0, 23741);     
    ssn := TRUNC(DBMS_RANDOM.VALUE(100000000, 999999999));
    random_phone := TO_CHAR(TRUNC(DBMS_RANDOM.VALUE(1000000000, 9999999999)));

    INSERT INTO OWNER (
      owner_id,
      owner_name,
      phone_no, 
      nationality, 
      gender, 
      dob, 
      ssn
    ) VALUES (
      OWNER_ID_SEQ.NEXTVAL,
      namesarr(TRUNC(DBMS_RANDOM.VALUE(1,10))),
      random_phone, 
      nationalities(TRUNC(DBMS_RANDOM.VALUE(1, 10))),
      CASE WHEN MOD(i, 2) = 0 THEN 'Female' ELSE 'Male' END, 
      birth_date,
      TO_CHAR(ssn)
    );
  END LOOP;
  COMMIT;
END;
/


-- For owner_id = 1
INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id) 
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2020-01-01', 'YYYY-MM-DD'), TO_DATE('2020-12-31', 'YYYY-MM-DD'), 101, '1BHK', 1200, 'Paid', 1);

INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2021-01-01', 'YYYY-MM-DD'), TO_DATE('2021-12-31', 'YYYY-MM-DD'), 101, '1BHK', 1300, 'Unpaid', 1);

-- For owner_id = 2
INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2020-02-01', 'YYYY-MM-DD'), TO_DATE('2020-08-31', 'YYYY-MM-DD'), 102, 'Studio', 1000, 'Paid', 2);

INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2021-02-01', 'YYYY-MM-DD'), TO_DATE('2021-08-31', 'YYYY-MM-DD'), 102, 'Studio', 1400, 'Paid', 2);

-- For owner_id = 3
INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2020-03-01', 'YYYY-MM-DD'), TO_DATE('2020-09-30', 'YYYY-MM-DD'), 103, '2BHK', 1150, 'Paid', 3);

INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2021-03-01', 'YYYY-MM-DD'), TO_DATE('2021-09-30', 'YYYY-MM-DD'), 103, '2BHK', 1350, 'Unpaid', 3);

-- For owner_id = 4
INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2020-04-01', 'YYYY-MM-DD'), TO_DATE('2020-10-31', 'YYYY-MM-DD'), 104, '3BHK', 1050, 'Paid', 4);

INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2021-04-01', 'YYYY-MM-DD'), TO_DATE('2021-10-31', 'YYYY-MM-DD'), 104, '3BHK', 1450, 'Paid', 4);

-- For owner_id = 5
INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2020-05-01', 'YYYY-MM-DD'), TO_DATE('2020-11-30', 'YYYY-MM-DD'), 105, '1BHK', 1100, 'Paid', 5);

INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2021-05-01', 'YYYY-MM-DD'), TO_DATE('2021-11-30', 'YYYY-MM-DD'), 106, '1BHK', 1300, 'Unpaid', 5);

-- For owner_id = 6
INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2020-06-01', 'YYYY-MM-DD'), TO_DATE('2020-12-31', 'YYYY-MM-DD'), 107, 'Studio', 950, 'Paid', 6);

INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2021-06-01', 'YYYY-MM-DD'), TO_DATE('2021-12-31', 'YYYY-MM-DD'), 107, 'Studio', 1500, 'Paid', 6);


-- For owner_id = 7
INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2020-07-01', 'YYYY-MM-DD'), TO_DATE('2021-06-30', 'YYYY-MM-DD'), 108, '2BHK', 1180, 'Paid', 7);

INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2021-07-01', 'YYYY-MM-DD'), TO_DATE('2022-06-30', 'YYYY-MM-DD'), 108, '2BHK', 1320, 'Unpaid', 7);

-- For owner_id = 8
INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2020-08-01', 'YYYY-MM-DD'), TO_DATE('2021-07-31', 'YYYY-MM-DD'), 109, 'Studio', 980, 'Paid', 8);

INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2021-08-01', 'YYYY-MM-DD'), TO_DATE('2022-07-31', 'YYYY-MM-DD'), 109, 'Studio', 1550, 'Paid', 8);

-- For owner_id = 9
INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2020-09-01', 'YYYY-MM-DD'), TO_DATE('2021-08-31', 'YYYY-MM-DD'), 110, '1BHK', 1220, 'Paid', 9);

INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2021-09-01', 'YYYY-MM-DD'), TO_DATE('2022-08-31', 'YYYY-MM-DD'), 110, '1BHK', 1370, 'Unpaid', 9);

-- For owner_id = 10
INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2020-10-01', 'YYYY-MM-DD'), TO_DATE('2021-09-30', 'YYYY-MM-DD'), 111, '3BHK', 1000, 'Paid', 10);

INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2021-10-01', 'YYYY-MM-DD'), TO_DATE('2022-09-30', 'YYYY-MM-DD'), 111, '3BHK', 1600, 'Paid', 10);


-- For owner_id = 11
INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2020-11-01', 'YYYY-MM-DD'), TO_DATE('2021-10-31', 'YYYY-MM-DD'), 121, '1BHK', 1250, 'Paid', 11);

INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2021-11-01', 'YYYY-MM-DD'), TO_DATE('2022-10-31', 'YYYY-MM-DD'), 121, '1BHK', 1400, 'Unpaid', 11);

-- For owner_id = 12
INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2020-12-01', 'YYYY-MM-DD'), TO_DATE('2021-11-30', 'YYYY-MM-DD'), 123, '3BHK', 1020, 'Paid', 12);

INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2021-12-01', 'YYYY-MM-DD'), TO_DATE('2022-11-30', 'YYYY-MM-DD'), 123, '3BHK', 1650, 'Paid', 12);

-- For owner_id = 13
INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2020-01-15', 'YYYY-MM-DD'), TO_DATE('2021-01-14', 'YYYY-MM-DD'), 124, '2BHK', 1260, 'Paid', 13);

INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2021-01-15', 'YYYY-MM-DD'), TO_DATE('2022-01-14', 'YYYY-MM-DD'), 124, '2BHK', 1420, 'Unpaid', 13);

-- For owner_id = 14
INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2020-02-15', 'YYYY-MM-DD'), TO_DATE('2021-02-14', 'YYYY-MM-DD'), 127, 'Studio', 1040, 'Paid', 14);

INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2021-02-15', 'YYYY-MM-DD'), TO_DATE('2022-02-14', 'YYYY-MM-DD'), 127, 'Studio', 1680, 'Paid', 14);

-- For owner_id = 15
INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2020-03-15', 'YYYY-MM-DD'), TO_DATE('2021-03-14', 'YYYY-MM-DD'), 129, '2BHK', 1280, 'Paid', 15);

INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2021-03-15', 'YYYY-MM-DD'), TO_DATE('2022-03-14', 'YYYY-MM-DD'), 130, '2BHK', 1440, 'Unpaid', 15);

-- For owner_id = 16
INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2020-04-15', 'YYYY-MM-DD'), TO_DATE('2021-04-14', 'YYYY-MM-DD'), 131, 'Studio', 1060, 'Paid', 16);

INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2021-04-15', 'YYYY-MM-DD'), TO_DATE('2022-04-14', 'YYYY-MM-DD'), 132, 'Studio', 1700, 'Paid', 16);

-- For owner_id = 17
INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2020-05-15', 'YYYY-MM-DD'), TO_DATE('2021-05-14', 'YYYY-MM-DD'), 133, '1BHK', 1300, 'Paid', 17);
INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2021-05-15', 'YYYY-MM-DD'), TO_DATE('2022-05-14', 'YYYY-MM-DD'), 134, '1BHK', 1460, 'Unpaid', 17);

-- For owner_id = 18
INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2020-06-15', 'YYYY-MM-DD'), TO_DATE('2021-06-14', 'YYYY-MM-DD'), 135, '3BHK', 1080, 'Paid', 18);
INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2021-06-15', 'YYYY-MM-DD'), TO_DATE('2022-06-14', 'YYYY-MM-DD'), 136, '3BHK', 1720, 'Paid', 18);

-- For owner_id = 19
INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2020-07-15', 'YYYY-MM-DD'), TO_DATE('2021-07-14', 'YYYY-MM-DD'), 137, '2BHK', 1320, 'Paid', 19);
INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2021-07-15', 'YYYY-MM-DD'), TO_DATE('2022-07-14', 'YYYY-MM-DD'), 138, '2BHK', 1480, 'Unpaid', 19);

-- For owner_id = 20
INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2020-08-15', 'YYYY-MM-DD'), TO_DATE('2021-08-14', 'YYYY-MM-DD'), 139, '3BHK', 1100, 'Paid', 20);
INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2021-08-15', 'YYYY-MM-DD'), TO_DATE('2022-08-14', 'YYYY-MM-DD'), 140, '3BHK', 1740, 'Paid', 20);

-- For owner_id = 21
INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2020-09-15', 'YYYY-MM-DD'), TO_DATE('2021-09-14', 'YYYY-MM-DD'), 141, '1BHK', 1340, 'Paid', 21);
INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2021-09-15', 'YYYY-MM-DD'), TO_DATE('2022-09-14', 'YYYY-MM-DD'), 142, '1BHK', 1500, 'Unpaid', 21);

-- For owner_id = 22
INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2020-10-15', 'YYYY-MM-DD'), TO_DATE('2021-10-14', 'YYYY-MM-DD'), 143, '3BHK', 1120, 'Paid', 22);
INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2021-10-15', 'YYYY-MM-DD'), TO_DATE('2022-10-14', 'YYYY-MM-DD'), 144, '3BHK', 1760, 'Paid', 22);

-- For owner_id = 23
INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2020-11-15', 'YYYY-MM-DD'), TO_DATE('2021-11-14', 'YYYY-MM-DD'), 145, '1BHK', 1360, 'Paid', 23);
INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2021-11-15', 'YYYY-MM-DD'), TO_DATE('2022-11-14', 'YYYY-MM-DD'), 146, '1BHK', 1520, 'Unpaid', 23);

-- For owner_id = 24
INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2020-12-15', 'YYYY-MM-DD'), TO_DATE('2021-12-14', 'YYYY-MM-DD'), 147, 'Studio', 1140, 'Paid', 24);
INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2021-12-15', 'YYYY-MM-DD'), TO_DATE('2022-12-14', 'YYYY-MM-DD'), 148, 'Studio', 1780, 'Paid', 24);

-- For owner_id = 25
INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2021-01-15', 'YYYY-MM-DD'), TO_DATE('2022-01-14', 'YYYY-MM-DD'), 149, '2BHK', 1380, 'Paid', 25);
INSERT INTO LEASE (lease_id, start_date, end_date, room_no, unit_type, rent, rent_status, OWNER_owner_id)
VALUES (LEASE_ID_SEQ.NEXTVAL, TO_DATE('2022-01-15', 'YYYY-MM-DD'), TO_DATE('2023-01-14', 'YYYY-MM-DD'), 150, '2BHK', 1540, 'Unpaid', 25);

COMMIT;

DECLARE
  v_count1 NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_count1 FROM VIOLATIONS;
  IF v_count1 >= 1 THEN
    DBMS_OUTPUT.PUT_LINE('Data already exists in the VIOLATIONS table. Script terminated.');
  ELSE
    INSERT INTO VIOLATIONS (violation_id, LEASE_lease_id, penalty, type) VALUES (VIOLATION_ID_SEQ.NEXTVAL, 1, 100, 'Noise Violation');
    INSERT INTO VIOLATIONS (violation_id, LEASE_lease_id, penalty, type) VALUES (VIOLATION_ID_SEQ.NEXTVAL, 2, 150, 'Parking Violation');
    INSERT INTO VIOLATIONS (violation_id, LEASE_lease_id, penalty, type) VALUES (VIOLATION_ID_SEQ.NEXTVAL, 3, 200, 'Parking Violation');
    INSERT INTO VIOLATIONS (violation_id, LEASE_lease_id, penalty, type) VALUES (VIOLATION_ID_SEQ.NEXTVAL, 4, 120, 'Pet Policy Violation');
    INSERT INTO VIOLATIONS (violation_id, LEASE_lease_id, penalty, type) VALUES (VIOLATION_ID_SEQ.NEXTVAL, 5, 180, 'Damage to Property');
    DBMS_OUTPUT.PUT_LINE('Violations inserted successfully.');
    COMMIT;
  END IF;
END;
/

INSERT INTO AMENITIES VALUES (1, 'parking', 150, 5.00, NULL, NULL, NULL, 2, 24);
INSERT INTO AMENITIES VALUES (2, 'table-tennis', 8, 3.50, NULL, NULL, NULL, 4, 2);
INSERT INTO AMENITIES VALUES (3, 'lounge', 20, 10.00, NULL, NULL, NULL, 10, 6);
INSERT INTO AMENITIES VALUES (4, 'pool', 10, 10.00, TO_DATE('10/01/2023','MM/DD/YYYY'), TO_DATE('03/01/2024','MM/DD/YYYY'), 'WINTER', 10, 6);
INSERT INTO AMENITIES VALUES (5, 'party-hall', 20, 10.00, NULL, NULL, NULL, 10, 6);
INSERT INTO AMENITY_BOOKING VALUES (BOOKING_ID_SEQ.NEXTVAL, 2, TO_DATE('2023-11-18 08:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2023-11-18 10:00', 'YYYY-MM-DD HH24:MI'), NULL, 1, 1);
INSERT INTO AMENITY_BOOKING VALUES (BOOKING_ID_SEQ.NEXTVAL, 4, TO_DATE('2023-11-19 12:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2023-11-19 14:00', 'YYYY-MM-DD HH24:MI'), NULL, 2, 2);
INSERT INTO AMENITY_BOOKING VALUES (BOOKING_ID_SEQ.NEXTVAL, 8, TO_DATE('2023-11-20 16:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2023-11-20 18:00', 'YYYY-MM-DD HH24:MI'), NULL, 3, 3);
INSERT INTO AMENITY_BOOKING VALUES (BOOKING_ID_SEQ.NEXTVAL, 3, TO_DATE('2023-11-21 10:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2023-11-21 13:00', 'YYYY-MM-DD HH24:MI'), NULL, 1, 2);
INSERT INTO AMENITY_BOOKING VALUES (BOOKING_ID_SEQ.NEXTVAL, 5, TO_DATE('2023-11-22 14:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2023-11-22 19:00', 'YYYY-MM-DD HH24:MI'), NULL, 2, 4);
INSERT INTO AMENITY_BOOKING VALUES (BOOKING_ID_SEQ.NEXTVAL, 6, TO_DATE('2023-11-23 16:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2023-11-23 22:00', 'YYYY-MM-DD HH24:MI'), NULL, 3, 6);
INSERT INTO AMENITY_BOOKING VALUES (BOOKING_ID_SEQ.NEXTVAL, 4, TO_DATE('2023-11-24 12:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2023-11-24 16:00', 'YYYY-MM-DD HH24:MI'), NULL, 1, 5);
INSERT INTO AMENITY_BOOKING VALUES (BOOKING_ID_SEQ.NEXTVAL, 7, TO_DATE('2023-11-25 18:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2023-11-25 21:00', 'YYYY-MM-DD HH24:MI'), NULL, 2, 7);
INSERT INTO AMENITY_BOOKING VALUES (BOOKING_ID_SEQ.NEXTVAL, 2, TO_DATE('2023-11-26 14:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2023-11-26 15:00', 'YYYY-MM-DD HH24:MI'), NULL, 3, 9);
INSERT INTO AMENITY_BOOKING VALUES (BOOKING_ID_SEQ.NEXTVAL, 3, TO_DATE('2023-11-27 10:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2023-11-27 13:00', 'YYYY-MM-DD HH24:MI'), NULL, 5, 11);
INSERT INTO AMENITY_BOOKING VALUES (BOOKING_ID_SEQ.NEXTVAL, 6, TO_DATE('2023-11-28 14:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2023-11-28 17:00', 'YYYY-MM-DD HH24:MI'), NULL, 5, 14);
INSERT INTO AMENITY_BOOKING VALUES (BOOKING_ID_SEQ.NEXTVAL, 5, TO_DATE('2023-11-29 16:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2023-11-29 21:00', 'YYYY-MM-DD HH24:MI'), NULL, 5, 17);
COMMIT;
 
INSERT INTO department (DEPT_ID, NAME) VALUES (SR_DEPT_ID_SEQ.NEXTVAL, 'ELECTRIC');
INSERT INTO department (DEPT_ID, NAME) VALUES (SR_DEPT_ID_SEQ.NEXTVAL, 'PLUMBING');
INSERT INTO department (DEPT_ID, NAME) VALUES (SR_DEPT_ID_SEQ.NEXTVAL, 'GENERAL');
INSERT INTO department (DEPT_ID, NAME) VALUES (SR_DEPT_ID_SEQ.NEXTVAL, 'HANDYMAN');
INSERT INTO department (DEPT_ID, NAME) VALUES (SR_DEPT_ID_SEQ.NEXTVAL, 'HVAC');
INSERT INTO department (DEPT_ID, NAME) VALUES (SR_DEPT_ID_SEQ.NEXTVAL, 'ELEVATOR');
COMMIT;


INSERT INTO employee (EMPLOYEE_ID, PHONE_NO, GENDER, DOB, DOJ, TERMINATION_DATE, SALARY, SSN, DEPARTENT_DEPT_ID, EMPLOYEE_NAME) VALUES (EMPLOYEE_ID_SEQ.NEXTVAL, 1234567890, 'Male', TO_DATE('1990-01-15', 'YYYY-MM-DD'), TO_DATE('2023-01-01', 'YYYY-MM-DD'), NULL, 50000, '123-45-6789', 1, 'John Doe');
INSERT INTO employee (EMPLOYEE_ID, PHONE_NO, GENDER, DOB, DOJ, TERMINATION_DATE, SALARY, SSN, DEPARTENT_DEPT_ID, EMPLOYEE_NAME) VALUES (EMPLOYEE_ID_SEQ.NEXTVAL, 9876543210, 'Female', TO_DATE('1985-05-20', 'YYYY-MM-DD'), TO_DATE('2023-01-15', 'YYYY-MM-DD'), NULL, 60000, '987-65-4321', 1, 'Jane Smith');
INSERT INTO employee (EMPLOYEE_ID, PHONE_NO, GENDER, DOB, DOJ, TERMINATION_DATE, SALARY, SSN, DEPARTENT_DEPT_ID, EMPLOYEE_NAME) VALUES (EMPLOYEE_ID_SEQ.NEXTVAL, 5551112222, 'Male', TO_DATE('1993-11-08', 'YYYY-MM-DD'), TO_DATE('2023-02-01', 'YYYY-MM-DD'), NULL, 55000, '555-11-2222', 2, 'Bob Johnson');
INSERT INTO employee (EMPLOYEE_ID, PHONE_NO, GENDER, DOB, DOJ, TERMINATION_DATE, SALARY, SSN, DEPARTENT_DEPT_ID, EMPLOYEE_NAME) VALUES (EMPLOYEE_ID_SEQ.NEXTVAL, 4445556666, 'Female', TO_DATE('1988-08-25', 'YYYY-MM-DD'), TO_DATE('2023-03-01', 'YYYY-MM-DD'), NULL, 70000, '444-55-6666', 3, 'Alice Johnson');
INSERT INTO employee (EMPLOYEE_ID, PHONE_NO, GENDER, DOB, DOJ, TERMINATION_DATE, SALARY, SSN, DEPARTENT_DEPT_ID, EMPLOYEE_NAME) VALUES (EMPLOYEE_ID_SEQ.NEXTVAL, 7778889999, 'Male', TO_DATE('1995-04-10', 'YYYY-MM-DD'), TO_DATE('2023-04-01', 'YYYY-MM-DD'), NULL, 60000, '777-88-9999', 3 ,'Charlie Brown');
INSERT INTO employee (EMPLOYEE_ID, PHONE_NO, GENDER, DOB, DOJ, TERMINATION_DATE, SALARY, SSN, DEPARTENT_DEPT_ID, EMPLOYEE_NAME) VALUES (EMPLOYEE_ID_SEQ.NEXTVAL, 1112223333, 'Female', TO_DATE('1992-12-18', 'YYYY-MM-DD'), TO_DATE('2023-05-01', 'YYYY-MM-DD'), NULL, 65000, '111-22-3333', 4, 'Emily White');
INSERT INTO employee (EMPLOYEE_ID, PHONE_NO, GENDER, DOB, DOJ, TERMINATION_DATE, SALARY, SSN, DEPARTENT_DEPT_ID, EMPLOYEE_NAME) VALUES (EMPLOYEE_ID_SEQ.NEXTVAL, 6667778888, 'Male', TO_DATE('1987-09-05', 'YYYY-MM-DD'), TO_DATE('2023-06-01', 'YYYY-MM-DD'), NULL, 75000, '666-77-8888', 4, 'David Johnson');
INSERT INTO employee (EMPLOYEE_ID, PHONE_NO, GENDER, DOB, DOJ, TERMINATION_DATE, SALARY, SSN, DEPARTENT_DEPT_ID, EMPLOYEE_NAME) VALUES (EMPLOYEE_ID_SEQ.NEXTVAL, 2223334444, 'Female', TO_DATE('1994-06-22', 'YYYY-MM-DD'), TO_DATE('2023-07-01', 'YYYY-MM-DD'), NULL, 80000, '222-33-4444', 5, 'Sophia Miller');
INSERT INTO employee (EMPLOYEE_ID, PHONE_NO, GENDER, DOB, DOJ, TERMINATION_DATE, SALARY, SSN, DEPARTENT_DEPT_ID, EMPLOYEE_NAME) VALUES (EMPLOYEE_ID_SEQ.NEXTVAL, 9990001111, 'Male', TO_DATE('1991-03-12', 'YYYY-MM-DD'), TO_DATE('2023-08-01', 'YYYY-MM-DD'), NULL, 70000, '999-00-1111', 5, 'Ethan Wilson');
INSERT INTO employee (EMPLOYEE_ID, PHONE_NO, GENDER, DOB, DOJ, TERMINATION_DATE, SALARY, SSN, DEPARTENT_DEPT_ID, EMPLOYEE_NAME) VALUES (EMPLOYEE_ID_SEQ.NEXTVAL, 3334445555, 'Female', TO_DATE('1986-10-28', 'YYYY-MM-DD'), TO_DATE('2023-09-01', 'YYYY-MM-DD'), NULL, 85000, '333-44-5555', 6, 'Olivia Davis');
INSERT INTO employee (EMPLOYEE_ID, PHONE_NO, GENDER, DOB, DOJ, TERMINATION_DATE, SALARY, SSN, DEPARTENT_DEPT_ID, EMPLOYEE_NAME) VALUES (EMPLOYEE_ID_SEQ.NEXTVAL, 3334445574, 'Male', TO_DATE('1986-10-28', 'YYYY-MM-DD'), TO_DATE('2023-09-01', 'YYYY-MM-DD'), NULL, 85025, '373-74-5555', 6, 'John Wick');
COMMIT;

EXEC add_sr(21, 'LUCAS', 'PLUMBING');
EXEC add_sr(22, 'MILA', 'GENERAL');
EXEC add_sr(23, 'AIDEN', 'HANDYMAN');
EXEC add_sr(24, 'RILEY', 'HVAC');
EXEC add_sr(25, 'ZARA', 'ELECTRIC');
EXEC add_sr(16, 'LIAM', 'PLUMBING');
EXEC add_sr(17, 'OLIVIA', 'GENERAL');
EXEC add_sr(18, 'NOAH', 'HANDYMAN');
EXEC add_sr(19, 'AVA', 'HVAC');
EXEC add_sr(20, 'ISABELLA', 'ELECTRIC');
EXEC add_sr(21, 'LUCAS', 'PLUMBING');
EXEC add_sr(22, 'MILA', 'GENERAL');
EXEC add_sr(23, 'AIDEN', 'HANDYMAN');
EXEC add_sr(24, 'RILEY', 'HVAC');
EXEC add_sr(25, 'ZARA', 'ELECTRIC');
EXEC add_sr(16, 'LIAM', 'ELECTRIC');
EXEC add_sr(17, 'OLIVIA', 'PLUMBING');
EXEC add_sr(18, 'NOAH', 'GENERAL');
EXEC add_sr(19, 'AVA', 'HANDYMAN');
EXEC add_sr(20, 'ISABELLA', 'HVAC');
EXEC add_sr(21, 'LUCAS', 'ELEVATOR');
EXEC add_sr(22, 'MILA', 'ELECTRIC');
EXEC add_sr(23, 'AIDEN', 'PLUMBING');
EXEC add_sr(24, 'RILEY', 'GENERAL');
EXEC add_sr(25, 'ZARA', 'HANDYMAN');
EXEC add_sr(16, 'LIAM', 'HVAC');
EXEC add_sr(17, 'OLIVIA', 'ELEVATOR');
EXEC add_sr(18, 'NOAH', 'ELECTRIC');
EXEC add_sr(19, 'AVA', 'PLUMBING');
EXEC add_sr(20, 'ISABELLA', 'GENERAL');
COMMIT;
