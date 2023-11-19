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