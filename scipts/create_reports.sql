CREATE OR REPLACE VIEW office_view_amenities AS 
SELECT ab.booking_id, ab.no_of_guests, ab.lease_lease_id, to_char(TRUNC(ab.booking_from, 'HH'), 'DD-MON-YY HH24:MI') AS booking_start, 
to_char(TRUNC(ab.booking_to, 'HH'), 'DD-MON-YY HH24:MI') AS booking_end, A.amenity_name
FROM amenity_booking ab 
INNER JOIN amenities A
ON ab.amenity_amenity_id = A.amenity_id;

CREATE OR REPLACE VIEW RESIDENT_UTILITY_USAGE AS
select l.lease_id, u.utility_name, u.curr_cycle_units*u.utility_cost as curr_cost, u.cycle_billed_on from utility u 
inner join lease l
on u.lease_lease_id = l.lease_id; 

CREATE OR REPLACE VIEW RESIDENT_SR AS 
SELECT request_id,resident_name,type,status,NVL(TO_CHAR(scheduled_for, 'YYYY-MM-DD'), 'TBA') AS scheduled_for,NVL(TO_CHAR(completed_at, 'YYYY-MM-DD'), 'TBA') AS completed_at
FROM service_request
WHERE completed_at IS NULL;

CREATE OR REPLACE VIEW OWNER_VIEW AS
    WITH dues AS(
    SELECT l.room_no, l.lease_id, l.rent+(u.utility_cost*u.curr_cycle_units)+v.penalty as pending_dues from lease l
    INNER JOIN utility u ON l.lease_id = u.lease_lease_id
    INNER JOIN violations v on l.lease_id = v.lease_lease_id)
    SELECT  l.owner_owner_id owner_id, l.lease_id, l.room_no, d.pending_dues 
    FROM lease l
    INNER JOIN dues d 
    ON l.lease_id = d.lease_id;
    
CREATE OR REPLACE VIEW RESIDENT_VIEW AS
    WITH dues AS(
    SELECT l.lease_id, l.rent+(u.utility_cost*u.curr_cycle_units)+v.penalty as pending_dues from lease l
    INNER JOIN utility u ON l.lease_id = u.lease_lease_id
    INNER JOIN violations v on l.lease_id = v.lease_lease_id)
    SELECT r.resident_id resident_id, l.lease_id, d.pending_dues 
    FROM resident r 
    INNER JOIN lease l
    ON r.lease_lease_id = l.lease_id
    INNER JOIN dues d 
    ON l.lease_id = d.lease_id;