-- Basic Entities:

CREATE TABLE Location (
    name VARCHAR(30) NOT NULL,
    latitude NUMERIC(8,6),
    longitude NUMERIC(9,6),
    authority_country_iso INTEGER NOT NULL, -- Mandatory Participation (M:1)
    CONSTRAINT location_pk PRIMARY KEY (latitude,longitude),
    CONSTRAINT location_fk FOREIGN KEY (authority_country_iso) REFERENCES Country(iso_code) -- Mandatory Participation (M:1)
    -- Additional IC: Every Location must be in table Marina, Port or Wharf. (Mandatory particion)
    -- Additional IC: A Location may only be in one table: Either marina, port or wharf. (Disjoint)
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

-- Weak Entities
CREATE TABLE Trip (
    trip_date DATE,
    duration INTEGER NOT NULL,
    boat_iso VARCHAR(70),
    boat_cni CHAR(15),
    sailor_iso VARCHAR(70),
    sailor_id INTEGER,
    reservation_start_date
    reservation_end_date
    from_location_lat NUMERIC(8,6) NOT NULL,  -- Mandatory Participation (M:1)
    from_location_long NUMERIC(8,6) NOT NULL, -- Mandatory Participation (M:1)
    to_location_lat NUMERIC(8,6) NOT NULL,    -- Mandatory Participation (M:1)
    to_location_long NUMERIC(8,6) NOT NULL,   -- Mandatory Participation (M:1)
    CONSTRAINT trip_check_duration_min CHECK (durantion > 0),
    CONSTRAINT trip_pks PRIMARY KEY (
        trip_date,
        boat_cni,boat_iso,
        sailor_iso,sailor_id,
        reservation_start_date,reservation_end_date
        ),
    CONSTRAINT trip_fks FOREIGN KEY (
        boat_cni,boat_iso,
        sailor_iso,sailor_id,
        reservation_start_date,
        reservation_end_date)
    REFERENCES reservation(
        boat_cni,boat_iso,sailor_iso,
        sailor_id,
        reservation_start_date,
        reservation_end_date), -- Weak Entity (sail)
    CONSTRAINT trip_from_location_fks FOREIGN KEY (from_location_lat,from_location_long) REFERENCES Location(latitude, longitude),  -- Mandatory Participation (M:1)
    CONSTRAINT trip_to_location_fks FOREIGN KEY (to_location_lat,to_location_long) REFERENCES Location(latitude, longitude)         -- Mandatory Participation (M:1)
    -- Additional IC: Trips that belong to the same reservation cannot overlap.
);


-- Auxiliary (have no real meaning, just for SQL to know for now .... as they need to be really implemented)

CREATE TABLE reservation(
    id INTEGER,
    CONSTRAINT reservation_pks PRIMARY KEY (id)
);

CREATE TABLE Country(
    iso INTEGER, -- you sure not VARCHAR(3 or 2 or 5?)
    CONSTRAINT  country_pk PRIMARY KEY (iso)
);