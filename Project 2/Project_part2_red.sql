-- Basic Entities:

create table Location (
    name varchar(30) NOT NULL,
    latitude numeric(8,6),
    longitude numeric(9,6),
    authority_country_iso integer not null, -- Mandatory Participation (M:1)
    constraint location_pk primary key (latitude,longitude),
    constraint location_fk foreign key (authority_country_iso) references Country(iso) -- Mandatory Participation (M:1)
    -- Additional IC: Every Location must be a Marina, Port or Wharf.
    -- Additional IC: A Location may only be of one type. Either marina, port or wharf.
);

create table Marina (
    latitude numeric(8,6),
    longitude numeric(9,6),
    constraint marina_pks primary key (latitude,longitude),
    constraint marina_fks foreign key (latitude,longitude) references Location(latitude,longitude) -- Specialization of Location
);

create table Wharf (
    latitude numeric(8,6),
    longitude numeric(9,6),
    constraint wharf_pks primary key (latitude,longitude),
    constraint wharf_fks foreign key (latitude,longitude) references Location(latitude,longitude) -- Specialization of Location
);

create table Port (
    latitude numeric(8,6),
    longitude numeric(9,6),
    constraint port_pks primary key (latitude,longitude),
    constraint port_fks foreign key (latitude,longitude) references Location(latitude,longitude) -- Specialization of Location
);

-- Weak Entities
create table Trip (
    date date NOT NULL,
    duration integer NOT NULL,
    reservation_id integer, -- just as an example... no real meaning for now -- Weak Entity
    from_location_lat numeric(8,6) NOT NULL,  -- Mandatory Participation (M:1)
    from_location_long numeric(8,6) NOT NULL, -- Mandatory Participation (M:1)
    to_location_lat numeric(8,6) NOT NULL,    -- Mandatory Participation (M:1)
    to_location_long numeric(8,6) NOT NULL,   -- Mandatory Participation (M:1)
    constraint trip_pks primary key (reservation_id,date),
    constraint trip_fks foreign key (reservation_id) references reservation(id), -- Weak Entity (sail)
    constraint trip_from_location_fks foreign key (from_location_lat,from_location_long) references Location(latitude, longitude),  -- Mandatory Participation (M:1)
    constraint trip_to_location_fks foreign key (to_location_lat,to_location_long) references Location(latitude, longitude)         -- Mandatory Participation (M:1)
    -- Additional IC: Trips that belong to the same reservation cannot overlap.
);


-- Auxiliary (have no real meaning, just for SQL to know for now .... as they need to be really implemented)

create table reservation(
    id integer,
    constraint reservation_pks primary key (id)
);

create table Country(
    iso integer, -- you sure not varchar(3 or 2 or 5?)
    constraint  country_pk primary key (iso)
);