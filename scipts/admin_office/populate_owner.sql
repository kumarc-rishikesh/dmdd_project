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

