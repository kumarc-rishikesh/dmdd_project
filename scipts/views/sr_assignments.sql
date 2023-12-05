WITH CTE AS(SELECT
    ASSIGNED_REQUESTS.REQUEST_ID,
    ASSIGNED_REQUESTS.EMPLOYEE_NAME,
    DEPARTMENT.DEPT_ID,
    ASSIGNED_REQUESTS.TYPE
FROM (
    SELECT
        REQUEST_ID,
        TYPE,
        SUBSTR(STATUS, INSTR(STATUS, 'ASSIGNED TO') + LENGTH('ASSIGNED TO') + 1) AS EMPLOYEE_NAME
    FROM SERVICE_REQUEST
    WHERE STATUS LIKE 'ASSIGNED TO%'
) ASSIGNED_REQUESTS
JOIN DEPARTMENT ON ASSIGNED_REQUESTS.TYPE = DEPARTMENT.NAME)
SELECT C.REQUEST_ID, E.EMPLOYEE_ID, E.EMPLOYEE_NAME, C.DEPT_ID, C.TYPE FROM CTE C JOIN EMPLOYEE E ON C.EMPLOYEE_NAME = UPPER(E.EMPLOYEE_NAME);
SELECT * FROM EMPLOYEE;
