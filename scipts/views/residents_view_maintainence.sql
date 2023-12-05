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
