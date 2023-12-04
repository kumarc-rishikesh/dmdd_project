CREATE OR REPLACE VIEW BOOKINGS_VIEW AS 
SELECT
    a.amenity_id,
    a.amenity_name,
    TO_CHAR(TRUNC(ab.booking_from, 'HH'), 'DD-MON-YY HH24:MI') AS booking_hour,
    SUM(a.total_slots - (ab.no_of_guests + 1)) AS available_slots
FROM
    amenity_booking ab
INNER JOIN
    amenities a ON ab.AMENITY_amenity_id = a.amenity_id
GROUP BY
    a.amenity_id,
    a.amenity_name,
    TO_CHAR(TRUNC(ab.booking_from, 'HH'), 'DD-MON-YY HH24:MI')
ORDER BY
    a.amenity_id,
    booking_hour;