DECLARE
  TYPE nationality_type IS TABLE OF VARCHAR2(100) INDEX BY BINARY_INTEGER;
  nationalities nationality_type;
  birth_date DATE;
  ssn_part1 NUMBER(3);
  ssn_part2 NUMBER(2);
  ssn_part3 NUMBER(4);
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

  FOR i IN 1..25 LOOP
    birth_date := TO_DATE('01-JAN-1940', 'DD-MON-YYYY') + DBMS_RANDOM.VALUE(0, 23741);     ssn_part1 := TRUNC(DBMS_RANDOM.VALUE(100, 999));
    ssn_part2 := TRUNC(DBMS_RANDOM.VALUE(10, 99));
    ssn_part3 := TRUNC(DBMS_RANDOM.VALUE(1000, 9999));
    random_phone := TO_CHAR(TRUNC(DBMS_RANDOM.VALUE(1000000000, 9999999999)));

    INSERT INTO OWNER (
      owner_id, 
      phone_no, 
      nationality, 
      gender, 
      dob, 
      ssn
    ) VALUES (
      OWNER_ID_SEQ.NEXTVAL, 
      random_phone, 
      nationalities(TRUNC(DBMS_RANDOM.VALUE(1, 10))),
      CASE WHEN MOD(i, 2) = 0 THEN 'Female' ELSE 'Male' END, 
      birth_date,
      TO_CHAR(ssn_part1) || TO_CHAR(ssn_part2) || TO_CHAR(ssn_part3)
    );
  END LOOP;
END;
/

