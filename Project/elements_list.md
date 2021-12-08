# Elements list
## Entities and Atributes
Entities: 
    Boat [weak entity of country]
        Atributes:
            name: 
                - Long string
                - Not Unique
            boat_id:                # Identifies the boat within the country (and not the country)
                - [Partial Key]
                - string?
            year_of_registration: 
                - [int] 4 digits
            mmsi:                   # Unique (IC-1)
                -  [int/long] 9 digits longs
                - may be null (since it is optional)
        Association: 
        country_flag: [Partial Key]   
        juridiction_flag: [association with country] (??)

    Person
        Attribute:
            name:
            national_id: [Primary Key]  Perhaps this is a weak entity with country?
        
    Sailor [Spetialization of Person]
        Atributes:
            sail_on_weekends: bool
        
    Owner [Spetialization of Person]
        Atributes:
            birth_date: date
        Association:
            boats: string?
            
    Reservation [NOT an Entity] !!!!
        Atributes:
            reservation_id: int (needed?)
            date_interval
        Association:
            sailor: 
            boat: 
            trips:
        
    Trip [weak entity of location]     
        Atributes:                      
            takeoff_date: [Partial_key]
            duration:
        Association:
            start_location: [Partial Key][with location]
            end_location: [Partial Key][with location]
            
    Location                               #IC (locations must be 1 NM apart) 
        Atributes:
            name: [Primary Key]
            latitude: [Primary Key]
            longitude: [Primary Key]
            type:
        Association: 
            country: 
    
    Country
        Atributes: 
            name: Unique [Primary_Key]
            flag: Unique 
            iso: Unique 
            # maritime_location: optional ( probably a constraint, how to define it?)
            