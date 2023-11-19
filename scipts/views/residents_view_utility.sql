CREATE OR REPLACE VIEW RESIDENT_UTILITY_USAGE AS
select l.lease_id, u.utility_name, u.curr_cycle_units*u.utility_cost as curr_cost, u.cycle_billed_on from utility u 
inner join lease l
on u.lease_lease_id = l.lease_id;