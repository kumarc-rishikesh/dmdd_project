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

-- View for Residents to view all Service Requests
CREATE OR REPLACE VIEW RESIDENT_SR AS 
SELECT
    request_id,
    resident_name,
    type,
    status,
    NVL(TO_CHAR(scheduled_for, 'YYYY-MM-DD'), 'TBA') AS scheduled_for,
    NVL(TO_CHAR(completed_at, 'YYYY-MM-DD'), 'TBA') AS completed_at
FROM
    service_request
WHERE
    completed_at IS NULL;
