-- Strong Etities
CREATE TABLE Person (
    name VARCHAR(80) NOT NULL,
    id_card INTEGER,
    iso_code VARCHAR(70),
    CONSTRAINT person_pk PRIMARY KEY (id_card, iso_code)
    CONSTRAINT iso_code FOREIGN KEY (iso_code) REFERENCES Country(iso_code)
    -- Every Person must exist either in the table 'Sailor' or in table 'Owner'.
    -- Add a check for the size of id_card (Maybe later?) 
)

CREATE TABLE Sailor (
    id_card INTEGER,
    iso_code VARCHAR(70),
    CONSTRAINT sailor_pk PRIMARY KEY (id_card, iso_code),
    CONSTRAINT sailor_fk FOREIGN KEY (id_card, iso_code) REFERENCES Person(id_card, iso_code)  
)

CREATE TABLE Owner (
    id_card INTEGER,
    iso_code VARCHAR(70),
    birth_date DATE NOT NULL,
    CONSTRAINT owner_pk PRIMARY KEY (id_card, iso_code),
    CONSTRAINT owner_fk FOREIGN KEY (id_card, iso_code) REFERENCES Person(id_card, iso_code)  
    -- Every Owner MUST EXIST in the 'Boat' table. 
)

CREATE TABLE Schedule (
    start_date DATE,
    end_date DATE,
    CONSTRAINT schedule_pk PRIMARY KEY (start_date, end_date)
    -- (IC1) Reservation schedules of boat most not overlap.
    -- (IC6) End date of a schedule must be after start date.
)

CREATE TABLE reservation (
    sailor_id INTEGER,
    sailor_iso_code VARCHAR(70),
    boat_cni CHAR(15),
    boat_iso_code VARCHAR(70),
    start_date DATE,
    end_date DATE,
    CONSTRAINT reservation_pk PRIMARY KEY (sailor_id, iso_code, cni, start_date, end_date),
    CONSTRAINT reservation_sailor_fk FOREIGN KEY(sailor_id,sailor_iso_code) REFERENCES Sailor(id_card, iso_code),
    CONSTRAINT reservation_boat_fk FOREIGN KEY(boat_cni,boat_iso_code) REFERENCES Boat(boat_cni,iso_code),
    CONSTRAINT reservation_schedule_fk FOREIGN KEY(start_date, end_date) REFERENCES Schedule(start_date, end_date))
    -- (IC-1) Reservation schedules of a boat must not overlap.
    -- (IC2) Trips of a reservation must not overlap.
);



-- TODO: Confirm this part is to remove
-- CREATE TABLE is_citizen(
--     id_card INTEGER,
--     iso VARCHAR(3),
--     CONSTRAINT is_citizen_pk PRIMARY KEY (id_card, iso),
--     CONSTRAINT id_card_fk REFERENCES Person(id_card),
--     CONSTRAINT iso_fk REFERENCES Country(iso)
--     -- Every Person MUST EXIST ONLY ONCE in the 'is_citizen' table.
-- )