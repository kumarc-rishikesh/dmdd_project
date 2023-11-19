CREATE OR REPLACE VIEW OWNER_VIEW AS
    WITH dues AS(
    SELECT l.room_no, l.lease_id, l.rent+(u.utility_cost*u.curr_cycle_units)+v.penalty as pending_dues from lease l
    INNER JOIN utility u ON l.lease_id = u.lease_lease_id
    INNER JOIN violations v on l.lease_id = v.lease_lease_id)
    SELECT  l.owner_owner_id owner_id, l.lease_id, l.room_no, d.pending_dues 
    FROM lease l
    INNER JOIN dues d 
    ON l.lease_id = d.lease_id;
