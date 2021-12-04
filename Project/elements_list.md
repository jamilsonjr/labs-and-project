# Elements list
## Entities and Atributes
Entities: 
    Boat
        Atributes:
            name: 
                - Long string
                - Not Unique
            boat_id:
                - ??
            year_of_registration:
                - 4 digits
            mmsi:
                - 9 digits longs
                - may be null (since it is optional)
        
    Sailor:
        Atributes:
            name:
            national_id:
            sail_on_weekends:
        
    Owner:
        Atributes:
            name:
            national_id:
            birth_date:
            boats: [Foreign_Key]
            
    Reservation:
        Atributes:
            reservation_id:
            sailor: [Foreign_Key]
            boat: [Foreign_Key]
            trips: [Foreign_Key]
        
    Trip:
        Atributes:
            trip_id:
            start_location:
            end_location:
            takeoff_date:
            duration:
            
    Location
        Atributes:
            name: Not unique 
            latitude: 
            longitude:
            type: 
            country: [Foreign_Key]
    
    Country:
        Atributes: 
            name: Unique
            flag: Unique
            iso: Unique
            maritime_location: optional [Foreign_key] (how to refer to location ?)
            
## Relationships