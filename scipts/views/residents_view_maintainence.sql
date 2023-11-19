CREATE OR REPLACE VIEW RES_MAINTAINENCE_VIEW AS 
SELECT r.resident_id, d.name, srd.department_dept_id, sr.scheduled_for FROM department d
INNER JOIN sr_dept srd
ON d.dept_id = srd.department_dept_id
INNER JOIN service_request sr
ON srd.service_request_request_id = sr.request_id
INNER JOIN lease l
ON sr.lease_lease_id = l.lease_id
INNER JOIN resident r
ON l.lease_id = r.lease_lease_id;