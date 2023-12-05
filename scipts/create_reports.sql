CREATE OR REPLACE VIEW office_view_amenities AS 
SELECT ab.booking_id, ab.no_of_guests, ab.lease_lease_id, to_char(TRUNC(ab.booking_from, 'HH'), 'DD-MON-YY HH24:MI') AS booking_start, 
to_char(TRUNC(ab.booking_to, 'HH'), 'DD-MON-YY HH24:MI') AS booking_end, A.amenity_name
FROM amenity_booking ab 
INNER JOIN amenities A
ON ab.amenity_amenity_id = A.amenity_id;