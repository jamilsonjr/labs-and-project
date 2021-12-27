CREATE TABLE Country(
    iso_code VARCHAR(70), -- TODO confirm
    flag TEXT NOT NULL,/*indica a path da localização da imagem*/
    name VARCHAR(70) NOT NULL,
    UNIQUE (flag), -- IC-4: Flags are unique
    UNIQUE (name), -- IC-5: Country Names are unique
    CONSTRAINT country_pk PRIMARY KEY (iso_code)
);

CREATE TABLE Boat (
    name VARCHAR(80) NOT NULL,
    iso_code VARCHAR(70), -- TODO confirm
    lenght INTEGER NOT NULL,
    year INTEGER NOT NULL,-- TODO ASK ABOUT YEAR CONSTRAINT
    cni CHAR(15),
    owner_id INTEGER,
    CONSTRAINT boat_pk PRIMARY KEY (iso_code,cni),
    CONSTRAINT boat_fk FOREIGN KEY(iso_code) REFERENCES Country(iso_code),
    CONSTRAINT owner_id_fk FOREIGN KEY (owner_id) REFERENCES Owner(id_card) -- TODO confirm
);

CREATE TABLE Boat_With_VHF(
    mmsi NUMERIC(9,0) NOT NULL,
    iso_code VARCHAR(70),
    cni CHAR(15),
    UNIQUE(mmsi),
    CONSTRAINT boat_with_vhf_pk PRIMARY KEY(cni,iso_code),
    CONSTRAINT boat_with_vhf_fk FOREIGN KEY(cni,iso_code) REFERENCES Boat(cni,iso_code)
);
