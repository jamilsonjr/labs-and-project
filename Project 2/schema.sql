-- Start by droping all tables in the database 
DROP TABLE IF EXISTS Person CASCADE;
DROP TABLE IF EXISTS Sailor CASCADE;
DROP TABLE IF EXISTS Owner CASCADE;
DROP TABLE IF EXISTS Schedule CASCADE;
DROP TABLE IF EXISTS Country CASCADE;
DROP TABLE IF EXISTS Boat CASCADE;
DROP TABLE IF EXISTS Boat_With_VHF CASCADE;
DROP TABLE IF EXISTS Location CASCADE;
DROP TABLE IF EXISTS Marina CASCADE;
DROP TABLE IF EXISTS Wharf CASCADE;
DROP TABLE IF EXISTS Port CASCADE;
DROP TABLE IF EXISTS Trip CASCADE;
DROP TABLE IF EXISTS reservation CASCADE;

-- Entities
CREATE TABLE Country(
    iso_code VARCHAR(3),
    flag TEXT NOT NULL, -- Filepath to the image (URL)
    name VARCHAR(70) NOT NULL,
    UNIQUE (flag), -- IC-4: Flags are unique
    UNIQUE (name), -- IC-5: Country Names are unique
    CONSTRAINT country_pk PRIMARY KEY (iso_code)
);

CREATE TABLE Person (
    name VARCHAR(80) NOT NULL,
    id_card NUMERIC(15,0),
    iso_code VARCHAR(3),  
    CONSTRAINT person_pk PRIMARY KEY (id_card, iso_code),
    CONSTRAINT person_iso_code FOREIGN KEY (iso_code) REFERENCES Country(iso_code)
    -- (IC) Every Person must exist either in the table 'Sailor' or in table 'Owner'. (Mandatory Specialization) 
);

CREATE TABLE Sailor (
    id_card NUMERIC(15,0),
    iso_code VARCHAR(3),
    CONSTRAINT sailor_pk PRIMARY KEY (id_card, iso_code),
    CONSTRAINT sailor_fk FOREIGN KEY (id_card, iso_code) REFERENCES Person(id_card, iso_code)  -- Specialization of Person
);

CREATE TABLE Owner (
    id_card NUMERIC(15,0),
    iso_code VARCHAR(3),
    birth_date DATE NOT NULL,
    CONSTRAINT owner_check_birth_date CHECK(birth_date <= CURRENT_DATE), 
    CONSTRAINT owner_pk PRIMARY KEY (id_card, iso_code),
    CONSTRAINT owner_fk FOREIGN KEY (id_card, iso_code) REFERENCES Person(id_card, iso_code) -- Specialization of Person
    -- (IC) Every Owner MUST EXIST in the 'Boat' table. (Mandatory Participation)
);

CREATE TABLE Schedule (
    start_date DATE,
    end_date DATE,
    CONSTRAINT schedule_check_valid_dates CHECK (end_date > start_date), -- (IC-6) End date of a schedule must be after start date.
    CONSTRAINT schedule_pk PRIMARY KEY (start_date, end_date)
    -- (IC-1) Reservation schedules of boat most not overlap.
);

CREATE TABLE Boat (
    name VARCHAR(80) NOT NULL,
    iso_code VARCHAR(3), 
    lenght INTEGER NOT NULL,
    year INTEGER NOT NULL,
    cni VARCHAR(15),
    owner_id NUMERIC(15,0),     -- Mandatory Participation (M:1)
    owner_iso_code VARCHAR(3),  -- Mandatory Participation (M:1)
    CONSTRAINT boat_lenght CHECK (lenght > 0 AND lenght < 500), -- Note: Lenght expected in meters
    CONSTRAINT boat_check_year CHECK (year >= 1800 AND year <= EXTRACT( year from CURRENT_DATE)),
    CONSTRAINT boat_pk PRIMARY KEY (iso_code,cni),
    CONSTRAINT boat_fk FOREIGN KEY(iso_code) REFERENCES Country(iso_code),
    CONSTRAINT boat_owner_id_fk FOREIGN KEY (owner_id, owner_iso_code) REFERENCES Owner(id_card, iso_code) -- Mandatory Participation (M:1)
);

CREATE TABLE Boat_With_VHF(
    mmsi NUMERIC(9,0) NOT NULL,
    iso_code VARCHAR(3),
    cni VARCHAR(15),
    UNIQUE(mmsi),
    CONSTRAINT boat_with_vhf_pk PRIMARY KEY(cni,iso_code),
    CONSTRAINT boat_with_vhf_fk FOREIGN KEY(cni,iso_code) REFERENCES Boat(cni,iso_code) -- Specialization of Boat
);

CREATE TABLE Location (
    name VARCHAR(30) NOT NULL,
    latitude NUMERIC(8,6),
    longitude NUMERIC(9,6),
    authority_country_iso VARCHAR(3) NOT NULL, -- Mandatory Participation (M:1)
    CONSTRAINT location_check_latitude_domain CHECK (latitude BETWEEN -90.000000 AND 90.000000),
    CONSTRAINT location_check_longitude_domain CHECK (longitude BETWEEN -180.000000 AND 180.000000),
    CONSTRAINT location_pk PRIMARY KEY (latitude,longitude),
    CONSTRAINT location_fk FOREIGN KEY (authority_country_iso) REFERENCES Country(iso_code) -- Mandatory Participation (M:1)
    -- (IC) Every Location must be in table Marina, Port or Wharf. (Mandatory Specialization)
    -- (IC) A Location may only be in one table: Either marina, port or wharf. (Disjoint)
    -- (IC-3) Any two locations must be at least 1-mile distance apart.
);

CREATE TABLE Marina (
    latitude NUMERIC(8,6),
    longitude NUMERIC(9,6),
    CONSTRAINT marina_pks PRIMARY KEY (latitude,longitude),
    CONSTRAINT marina_fks FOREIGN KEY (latitude,longitude) REFERENCES Location(latitude,longitude) -- Specialization of Location
);

CREATE TABLE Wharf (
    latitude NUMERIC(8,6),
    longitude NUMERIC(9,6),
    CONSTRAINT wharf_pks PRIMARY KEY (latitude,longitude),
    CONSTRAINT wharf_fks FOREIGN KEY (latitude,longitude) REFERENCES Location(latitude,longitude) -- Specialization of Location
);

CREATE TABLE Port (
    latitude NUMERIC(8,6),
    longitude NUMERIC(9,6),
    CONSTRAINT port_pks PRIMARY KEY (latitude,longitude),
    CONSTRAINT port_fks FOREIGN KEY (latitude,longitude) REFERENCES Location(latitude,longitude) -- Specialization of Location
);

-- Associations
CREATE TABLE reservation (
    sailor_id NUMERIC(15,0),
    sailor_iso_code VARCHAR(3),
    boat_cni VARCHAR(15),
    boat_iso_code VARCHAR(3),
    start_date DATE,
    end_date DATE,
    CONSTRAINT reservation_check_dates CHECK (end_date > start_date),
    CONSTRAINT reservation_pk PRIMARY KEY (sailor_id, sailor_iso_code, boat_iso_code, boat_cni, start_date, end_date),
    CONSTRAINT reservation_sailor_fk FOREIGN KEY(sailor_id,sailor_iso_code) REFERENCES Sailor(id_card, iso_code),
    CONSTRAINT reservation_boat_fk FOREIGN KEY(boat_cni,boat_iso_code) REFERENCES Boat(cni,iso_code),
    CONSTRAINT reservation_schedule_fk FOREIGN KEY(start_date, end_date) REFERENCES Schedule(start_date, end_date)
    -- (IC-1) Reservation schedules of a boat must not overlap.
    -- (IC-2) Trips of a reservation must not overlap.
);

-- Weak Entities
CREATE TABLE Trip (
    trip_date DATE NOT NULL,
    duration INTEGER NOT NULL,
    sailor_id NUMERIC(15,0),
    sailor_iso_code VARCHAR(3),
    boat_cni VARCHAR(15),
    boat_iso_code VARCHAR(3),
    reservation_start_date DATE,
    reservation_end_date DATE,
    from_location_lat NUMERIC(8,6) NOT NULL,  -- Mandatory Participation (M:1)
    from_location_long NUMERIC(9,6) NOT NULL, -- Mandatory Participation (M:1)
    to_location_lat NUMERIC(8,6) NOT NULL,    -- Mandatory Participation (M:1)
    to_location_long NUMERIC(9,6) NOT NULL,   -- Mandatory Participation (M:1)
    CONSTRAINT trip_check_duration_min CHECK (duration > 0),
    CONSTRAINT trip_check_trip_date CHECK (trip_date BETWEEN reservation_start_date AND reservation_end_date),
    CONSTRAINT trip_pks PRIMARY KEY (
        trip_date,
        boat_cni,boat_iso_code,
        sailor_iso_code,sailor_id,
        reservation_start_date,reservation_end_date
        ),
    CONSTRAINT trip_fks FOREIGN KEY (
        sailor_id, sailor_iso_code,
        boat_iso_code, boat_cni,
        reservation_start_date,reservation_end_date)
    REFERENCES reservation(
        sailor_id, sailor_iso_code, 
        boat_iso_code, boat_cni,
        start_date, end_date),
    CONSTRAINT trip_from_location_fks FOREIGN KEY (from_location_lat,from_location_long) REFERENCES Location(latitude, longitude),  -- Mandatory Participation (M:1)
    CONSTRAINT trip_to_location_fks FOREIGN KEY (to_location_lat,to_location_long) REFERENCES Location(latitude, longitude)         -- Mandatory Participation (M:1)
    -- (IC-2) Trips that belong to the same reservation cannot overlap.
);
