DROP TABLE IF EXISTS trip;
DROP TABLE IF EXISTS reservation;
DROP TABLE IF EXISTS schedule;
DROP TABLE IF EXISTS boat_vhf;
DROP TABLE IF EXISTS boat;
DROP TABLE IF EXISTS owner;
DROP TABLE IF EXISTS sailor;
DROP TABLE IF EXISTS person;
DROP TABLE IF EXISTS port;
DROP TABLE IF EXISTS wharf;
DROP TABLE IF EXISTS marina;
DROP TABLE IF EXISTS location;
DROP TABLE IF EXISTS country;

CREATE TABLE country
(
    flag     VARCHAR(150) UNIQUE NOT NULL,
    name     VARCHAR(70) UNIQUE  NOT NULL,
    iso_code CHAR(2),
    PRIMARY KEY (iso_code)
);

CREATE TABLE location
(
    name      VARCHAR(80) NOT NULL,
    latitude  NUMERIC(8, 6),
    longitude NUMERIC(9, 6),
    iso_code  CHAR(2),
    PRIMARY KEY (latitude, longitude),
    FOREIGN KEY (iso_code) REFERENCES country (iso_code)
);

CREATE TABLE marina
(
    latitude  NUMERIC(8, 6),
    longitude NUMERIC(9, 6),
    FOREIGN KEY (latitude, longitude) REFERENCES location (latitude, longitude)
);

CREATE TABLE wharf
(
    latitude  NUMERIC(8, 6),
    longitude NUMERIC(9, 6),
    FOREIGN KEY (latitude, longitude) REFERENCES location (latitude, longitude)
);

CREATE TABLE port
(
    latitude  NUMERIC(8, 6),
    longitude NUMERIC(9, 6),
    FOREIGN KEY (latitude, longitude) REFERENCES location (latitude, longitude)
);

CREATE TABLE person
(
    id       VARCHAR(20),
    name     VARCHAR(80) NOT NULL,
    iso_code CHAR(2),
    PRIMARY KEY (id, iso_code),
    FOREIGN KEY (iso_code) REFERENCES country (iso_code)
);

CREATE TABLE sailor
(
    id       VARCHAR(20),
    iso_code CHAR(2),
    PRIMARY KEY (id, iso_code),
    FOREIGN KEY (id, iso_code) REFERENCES person (id, iso_code)
);

CREATE TABLE owner
(
    id        VARCHAR(20),
    iso_code  CHAR(2),
    birthdate DATE NOT NULL,
    PRIMARY KEY (id, iso_code),
    FOREIGN KEY (id, iso_code) REFERENCES person (id, iso_code)
);

CREATE TABLE boat
(
    name           VARCHAR(30) NOT NULL,
    year           SMALLINT    NOT NULL,
    cni            VARCHAR(15),
    iso_code       CHAR(2),
    id_owner       VARCHAR(20),
    iso_code_owner CHAR(2),
    PRIMARY KEY (cni, iso_code),
    FOREIGN KEY (iso_code) REFERENCES country (iso_code),
    FOREIGN KEY (id_owner, iso_code_owner) REFERENCES owner (id, iso_code)
);

CREATE TABLE boat_vhf
(
    mmsi     NUMERIC(9) NOT NULL,
    cni      VARCHAR(15),
    iso_code CHAR(2),
    PRIMARY KEY (cni, iso_code),
    FOREIGN KEY (cni, iso_code) REFERENCES boat (cni, iso_code)
);

CREATE TABLE schedule
(
    start_date DATE,
    end_date   DATE,
    CHECK (end_date > start_date),
    PRIMARY KEY (start_date, end_date)
);

CREATE TABLE reservation
(
    cni             VARCHAR(15),
    iso_code_boat   CHAR(2),
    id_sailor       VARCHAR(20),
    iso_code_sailor CHAR(2),
    start_date      DATE,
    end_date        DATE,
    PRIMARY KEY (cni, iso_code_boat, id_sailor, iso_code_sailor, start_date, end_date),
    FOREIGN KEY (cni, iso_code_boat) REFERENCES boat (cni, iso_code),
    FOREIGN KEY (id_sailor, iso_code_sailor) REFERENCES sailor (id, iso_code),
    FOREIGN KEY (start_date, end_date) REFERENCES schedule (start_date, end_date)
);

CREATE TABLE trip
(
    date            DATE,
    duration        SMALLINT NOT NULL,
    cni             VARCHAR(15),
    iso_code_boat   CHAR(2),
    id_sailor       VARCHAR(20),
    iso_code_sailor CHAR(2),
    start_date      DATE,
    end_date        DATE,
    start_latitude  NUMERIC(8, 6),
    start_longitude NUMERIC(9, 6),
    end_latitude    NUMERIC(8, 6),
    end_longitude   NUMERIC(9, 6),
    PRIMARY KEY (date, cni, iso_code_boat, id_sailor, iso_code_sailor, start_date, end_date),
    FOREIGN KEY (cni, iso_code_boat, id_sailor, iso_code_sailor, start_date, end_date) REFERENCES
        reservation (cni, iso_code_boat, id_sailor, iso_code_sailor, start_date, end_date),
    FOREIGN KEY (start_latitude, start_longitude) REFERENCES location (latitude, longitude),
    FOREIGN KEY (end_latitude, end_longitude) REFERENCES location (latitude, longitude)
);
