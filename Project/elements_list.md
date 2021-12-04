# Elements list
## Entities and Atributes
Entities: 
    Boat
        Atributes:
            name: 
                - Long string
                - Not Unique
            boat_id: 
                - [Primary Key]
                - string?
            year_of_registration: 
                - [int] 4 digits
            mmsi:
                -  [int/long] 9 digits longs
                - may be null (since it is optional)
            country_flag:
                
        
    Sailor:
        Atributes:
            name: string
            national_id: [Primary_Key]
            sail_on_weekends: bool
        
    Owner:
        Atributes:
            name: string
            national_id: string [Primary_key]
            birth_date: date
            boats: string? [Foreign_Key]
            
    Reservation:
        Atributes:
            reservation_id: int
            sailor: [Foreign_Key]
            boat: [Foreign_Key]
            trips: [Foreign_Key]
        
    Trip:
        Atributes:
            trip_id: [Primary_key]
            start_location: [Foreign_key]
            end_location: [Foreign_key]
            takeoff_date:
            courtesy_flag:
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
            