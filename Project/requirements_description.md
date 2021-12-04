# Database Modeling
## Requirements
Boat 
- Every boat has a name. ✓
- Names are long, not always unique.  
- Every boat has a country.
- Every boat has a unique country identifier.
- Every boat has a year of registration.
- Any boat with fixed VHF radio must have a MMSI id
---mine---
- Every boat has a owner, may not be unique.
- Every boat has a flag of the country of registration.

Sailor ("Eye eye Capitan") 
- Every sailor has a name.
- Not all sailors have boats. (Only rich ones)
- Some sailors do not like to sail on weekends. (they prefer to saty in and have Rum...).
-  

Owners
- Every owner has a name.
- Every owner has a birthday.

Person
- Every person has a name.
- Every person has a national id.

Reservation
- Sailors can reserve boats for a period of time, if the boat is available.
- Boats can perform many trips, whithin the same reservation.

Trips
- All trips have a start location.
- All trips have an end location.
- All trips have a takee-off date.
- All trips have a duration in days.
- (?) When travelling to a country, every baot must have the flag of the country flag of the waters location/juristiction country.

Location
- Every location has a name.
- Every location has a latitude.
- Every location has a longitude.
- Names may repeat.
- Latitude and longitude, may not repeat simultaneously.
- Every location has to be at least one nautical mile apart.
- Locations can be either: [Ports, Marinas, Wharfs].
- Every location has a national maritime authority.

Country
- Every country has a unique name.
- Every country has a unique flag.
- Every country has a unique ISO code.
- Countries where boats can be registered must have at least one maritime location.

 

