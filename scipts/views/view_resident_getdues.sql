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