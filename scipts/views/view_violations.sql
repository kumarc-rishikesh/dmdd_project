CREATE OR REPLACE VIEW ViolationDetails AS
SELECT v.violation_id, v.LEASE_lease_id, v.penalty, v.type,l.owner_owner_id,o.owner_name,LISTAGG(r.resident_name, ', ') WITHIN GROUP (ORDER BY r.resident_name) AS resident_names
FROM VIOLATIONS v
JOIN LEASE l ON v.LEASE_lease_id = l.lease_id
JOIN OWNER o ON l.owner_owner_id = o.owner_id  
JOIN RESIDENT r ON l.lease_id = r.LEASE_lease_id
GROUP BY v.violation_id,v.LEASE_lease_id,v.penalty,v.type,l.owner_owner_id,o.owner_name 
ORDER BY v.violation_id;


SELECT * FROM ViolationDetails WHERE LEASE_lease_id = '1';
