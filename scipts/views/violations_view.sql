CREATE VIEW ViolationDetails AS
SELECT v.violation_id, v.LEASE_lease_id, v.penalty, v.type
FROM VIOLATIONS v;

SELECT * FROM ViolationDetails WHERE LEASE_lease_id = '1';
