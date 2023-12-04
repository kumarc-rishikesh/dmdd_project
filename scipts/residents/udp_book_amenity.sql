SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE BOOK_AMENITY(
    PI_LEASE_ID AMENITY_BOOKING.LEASE_lease_id%TYPE,
    PI_AMENITY_NAME VARCHAR2,
    PI_NO_OF_GUESTS AMENITY_BOOKING.no_of_guests%TYPE,
    PI_BOOKING_FROM AMENITY_BOOKING.booking_from%TYPE,
    PI_BOOKING_TO AMENITY_BOOKING.booking_to%TYPE
   )
   AS
    v_max_time NUMBER := 0;
    v_available_slots NUMBER := 1000;
    v_bv_check NUMBER :=0;
    v_amenity_id NUMBER := 0;
    v_lease_check NUMBER := 1;
    v_max_guests NUMBER :=0;
    v_closure_start DATE := SYSDATE;
    v_closure_end DATE := SYSDATE;
    v_closure_reason VARCHAR(50) := '';
    v_total_cost NUMBER :=0;
    E_INVALID_LEASE EXCEPTION;
    E_EXCESS_GUESTS EXCEPTION;
    E_INVALID_TIME_DURATION EXCEPTION;
    E_INVALID_TIME EXCEPTION;
    E_INSUFFICIENT_SLOTS EXCEPTION;
    E_AMENITY_CLOSED EXCEPTION;
    E_EARLY_BOOKING EXCEPTION;
BEGIN
    -- Check for lease
    SELECT lease_id INTO v_lease_check
    FROM LEASE
    WHERE lease_id = PI_LEASE_ID;
    
    IF PI_BOOKING_FROM > PI_BOOKING_TO THEN 
        RAISE E_INVALID_TIME ;
    END IF;
    
    BEGIN
        SELECT AMENITY_ID INTO v_amenity_id 
        FROM AMENITIES
        WHERE amenity_name = lower(PI_AMENITY_NAME);
        
        SELECT GUESTS_PERMITTED INTO v_max_guests 
        FROM AMENITIES
        WHERE AMENITY_ID = v_amenity_id;
        
        IF PI_NO_OF_GUESTS >  v_max_guests THEN
            RAISE E_EXCESS_GUESTS;
        END IF;
        
        SELECT max_duration_hours INTO v_max_time 
        FROM amenities
        WHERE amenity_id = v_amenity_id;
        
        IF (PI_BOOKING_TO - PI_BOOKING_FROM)*24 > v_max_time THEN
            RAISE E_INVALID_TIME_DURATION;
        END IF;
        
        SELECT closure_start INTO v_closure_start FROM amenities
        WHERE amenity_id = v_amenity_id;
        SELECT closure_end INTO v_closure_end FROM amenities
        WHERE amenity_id = v_amenity_id;
        SELECT closure_reason INTO v_closure_reason FROM amenities
        WHERE amenity_id = v_amenity_id;
        
        IF v_closure_start IS NOT NULL AND PI_BOOKING_FROM BETWEEN v_closure_start AND v_closure_end THEN
            RAISE E_AMENITY_CLOSED;
        END IF;
        
        SELECT COUNT(*) INTO v_bv_check
        FROM bookings_view
        WHERE amenity_id = v_amenity_id 
        AND TO_CHAR(TRUNC(PI_BOOKING_FROM, 'HH'), 'DD-MON-YY HH24:MI') = BOOKING_HOUR;
        
        IF v_bv_check > 0 THEN
            SELECT available_slots INTO v_available_slots
            FROM bookings_view 
            WHERE amenity_id = v_amenity_id 
            AND TO_CHAR(TRUNC(PI_BOOKING_FROM, 'HH'), 'DD-MON-YY HH24:MI') = BOOKING_HOUR;       
        ELSE 
            SELECT total_slots INTO v_available_slots
            FROM amenities
            WHERE amenity_id = v_amenity_id;
        END IF;
        
        IF  CEIL(PI_BOOKING_FROM - SYSDATE) < 6 THEN
            RAISE E_EARLY_BOOKING;
        END IF;
        
        IF (1+PI_NO_OF_GUESTS) > v_available_slots THEN
            RAISE E_INSUFFICIENT_SLOTS;
        ELSE
            SELECT HOURLY_CHARGE * ((PI_BOOKING_TO - PI_BOOKING_FROM)*24) INTO v_total_cost 
            FROM AMENITIES
            WHERE amenity_id = v_amenity_id;
            
            INSERT INTO AMENITY_BOOKING VALUES (BOOKING_ID_SEQ.NEXTVAL, PI_NO_OF_GUESTS, PI_BOOKING_FROM, PI_BOOKING_TO, NULL, v_amenity_id, PI_LEASE_ID);
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('BOOKING SUCCESSFUL!! BOOKING ID : ' || TO_CHAR(BOOKING_ID_SEQ.CURRVAL || '. THIS BOOKING ID IS REQUIRED IF REQUIRED TO CANCEL'));
            UPDATE LEASE 
            SET PENDING_DUES = NVL(PENDING_DUES,0) + v_total_cost
            WHERE lease_id = PI_LEASE_ID;
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('AMENITY CHARGE OF ' || TO_CHAR(v_total_cost) || ' HAS BEEN ADDED TO THE PENDING DUES IN YOUR LEASE');
        END IF;
        
         
    EXCEPTION 
        WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('PLEASE ENTER A VALID AMENITY');
        WHEN E_EXCESS_GUESTS THEN
        DBMS_OUTPUT.PUT_LINE('MAXIMUM GUESTS  ALLOWED ARE ' || TO_CHAR(v_max_guests));
        WHEN E_INVALID_TIME_DURATION THEN
        DBMS_OUTPUT.PUT_LINE('MAX BOOKING DURATION IS : ' || TO_CHAR(v_max_time) || ' HOURS'); 
        WHEN E_INSUFFICIENT_SLOTS THEN
        DBMS_OUTPUT.PUT_LINE('NOT ENOUGH SLOTS FOR YOU AND SPECIFIED NUMBER OF GUESTS');
        WHEN E_AMENITY_CLOSED THEN 
        DBMS_OUTPUT.PUT_LINE('AMENITY IS CLOSED TILL ' || TO_CHAR(v_closure_end, 'DD-MON-YY') || ' FOR REASON: ' || v_closure_reason);
        WHEN E_EARLY_BOOKING THEN 
        DBMS_OUTPUT.PUT_LINE('EARLY BOOKING : AMENITY CAN ONLY BE BOOKED FOR AFTER '|| to_char(SYSDATE + 6,'DD-MON-YY'));
    END;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('PLEASE ENTER A VALID LEASE ID');
    WHEN E_INVALID_TIME THEN
        DBMS_OUTPUT.PUT_LINE('BOOKING_FROM MUST BE AFTER BOOKING_TO'); 
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END BOOK_AMENITY;
/

--invalid lease id
--EXEC BOOK_AMENITY(50000,'parking',1, TO_DATE('18-NOV-23 13:00:00', 'DD-MON-YY HH24:MI:SS'),TO_DATE('18-NOV-23 15:00:00', 'DD-MON-YY HH24:MI:SS'));
--invalid amenity name
--EXEC BOOK_AMENITY(5,'parkingggggggggg',1, TO_DATE('18-NOV-23 13:00:00', 'DD-MON-YY HH24:MI:SS'),TO_DATE('18-NOV-23 15:00:00', 'DD-MON-YY HH24:MI:SS'));
--extra guests
--EXEC BOOK_AMENITY(5,'parking',5, TO_DATE('18-NOV-23 13:00:00', 'DD-MON-YY HH24:MI:SS'),TO_DATE('18-NOV-23 15:00:00', 'DD-MON-YY HH24:MI:SS'));
--booking_to after booking_from 
--EXEC BOOK_AMENITY(5,'parking',1, TO_DATE('20-NOV-23 13:00:00', 'DD-MON-YY HH24:MI:SS'),TO_DATE('18-NOV-23 15:00:00', 'DD-MON-YY HH24:MI:SS'));
--too long
--EXEC BOOK_AMENITY(5,'parking',2, TO_DATE('18-NOV-23 13:00:00', 'DD-MON-YY HH24:MI:SS'),TO_DATE('20-NOV-23 15:00:00', 'DD-MON-YY HH24:MI:SS'));
--closure
--EXEC BOOK_AMENITY(5,'pool',2, SYSDATE +10, SYSDATE+10.2);
--no slots
--EXEC BOOK_AMENITY(5,'parking',2, TO_DATE('18-NOV-23 13:00:00', 'DD-MON-YY HH24:MI:SS'),TO_DATE('18-NOV-23 15:00:00', 'DD-MON-YY HH24:MI:SS'));
--proper
--EXEC BOOK_AMENITY(5,'parking',1, TO_DATE('10-DEC-23 14:00:00', 'DD-MON-YY HH24:MI:SS'),TO_DATE('10-DEC-23 15:00:00', 'DD-MON-YY HH24:MI:SS'));
