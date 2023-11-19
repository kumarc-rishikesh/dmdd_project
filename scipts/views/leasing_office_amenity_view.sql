create view office_view_amenities as 
select ab.booking_id, ab.no_of_guests, ab.lease_lease_id, ab.booking_from, ab.booking_to, a.amenity_name
from amenity_booking ab 
inner join amenities a
on ab.amenity_amenity_id = a.amenity_id;