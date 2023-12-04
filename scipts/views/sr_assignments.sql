CREATE VIEW assignments AS
SELECT
    REQUEST_ID,
    EMPLOYEE_NAME,
    DEPT_ID,
    TYPE
FROM (
    SELECT
        REQUEST_ID,
        TYPE,
        SUBSTR(STATUS, INSTR(STATUS, 'ASSIGNED TO') + LENGTH('ASSIGNED TO') + 1) AS EMPLOYEE_NAME
    FROM SERVICE_REQUEST
    WHERE STATUS LIKE 'ASSIGNED TO%'
) ASSIGNED_REQUESTS
JOIN DEPARTMENT ON ASSIGNED_REQUESTS.TYPE = DEPARTMENT.NAME;
