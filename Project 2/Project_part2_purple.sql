CREATE TABLE Country(
    name varchar(100),
    iso_code varchar(70),
    flag text,/*indica a path da localização da imagem*/
    unique (flag),-- IC-4
    unique (name),-- IC-5
    primary key (iso_code)
);

CREATE TABLE Boat (
    name text,
    iso_code varchar(70),
    lenght integer,
    year integer,
    cni char(15),
    primary key (iso_code,cni),
    foreign key(iso_code) REFERENCES Country(iso_code)
);

CREATE TABLE Boar_with_VHF(
    mmsi numeric(9,0),
    iso_code varchar(70),
    cni char(15),
    primary key(cni,iso_code),
    foreign key(cni,iso_code) REFERENCES Boat(cni,iso_code)
    --foreign key(iso_code) REFERENCES Boat(iso_code)
);
