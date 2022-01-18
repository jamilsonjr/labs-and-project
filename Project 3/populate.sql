/*
DELETE FROM country;
DELETE FROM location;
DELETE FROM marina;
DELETE FROM wharf;
DELETE FROM port;
DELETE FROM person;
DELETE FROM owner;
DELETE FROM sailor;
DELETE FROM boat;
DELETE FROM reservation;
DELETE FROM trip;
DELETE FROM schedule;
DELETE FROM boat_vhf;
*/
-- Country table INSERTS
INSERT INTO Country VALUES('https://www.worldometers.info/img/flags/br-flag.gif',
                           'Brazil',
                           'BR');
                           
INSERT INTO Country VALUES('https://www.worldometers.info/img/flags/po-flag.gif',
                            'Portugal',
                            'PT');

INSERT INTO Country VALUES('https://www.worldometers.info/img/flags/sf-flag.gif',
                            'SouthAfrica',
                            'ZF');

INSERT INTO Country VALUES('https://www.worldometers.info/img/flags/in-flag.gif',
                            'India',
                            'IN');

INSERT INTO Country VALUES('https://www.worldometers.info/img/flags/th-flag.gif',
                            'Thailand',
                            'TH');
INSERT INTO Country VALUES('https://www.worldometers.info/img/flags/ch-flag.gif',
                            'China',
                            'CN');
-- Location table INSERTS
INSERT INTO location VALUES('Belém', 38.696142, -9.208335,'PT');
INSERT INTO location VALUES('Alcantara', 33.956121, -9.258335,'PT');
INSERT INTO location VALUES('Cascais', 35.696142, 05.208335,'PT');
INSERT INTO location VALUES('Rio de Janeiro', 25.696142, -5.208335,'BR');
INSERT INTO location VALUES('Cape Town', 16.696142, -3.208323,'ZF');
INSERT INTO location VALUES('Goa', 15.430154, 73.811340,'IN');

-- Marina table INSERTS
INSERT INTO marina VALUES(33.956121, -9.258335); -- Alcantara
INSERT INTO marina VALUES(38.696142, -9.208335); -- Belem
-- Wharf table INSERTS

INSERT INTO wharf VALUES(35.696142, 05.208335); -- Cascais
INSERT INTO wharf VALUES(25.696142, -5.208335); -- Rio de Janeiro
-- Port table INSERTS

INSERT INTO port VALUES(16.696142, -3.208323); -- Cape Town
INSERT INTO port VALUES(15.430154, 73.811340); -- Goa
-- Person table INSERTS

INSERT INTO person VALUES ('PT1111','Joao','PT');
INSERT INTO person VALUES ('PT2222','Manel','PT');
INSERT INTO person VALUES ('PT3333','Helder','PT');
INSERT INTO person VALUES ('PT4444','Jamilson','PT');


-- Owner table INSERTS
INSERT INTO owner VALUES ('PT1111','PT','2000-01-01');
INSERT INTO owner VALUES ('PT2222','PT','1998-07-01');
INSERT INTO owner VALUES ('PT3333','PT','1999-07-26');
INSERT INTO owner VALUES ('PT4444','PT','1998-09-20');

-- Sailor table INSERTS
INSERT INTO sailor VALUES ('PT1111','PT');
INSERT INTO sailor VALUES ('PT2222','PT');
INSERT INTO sailor VALUES ('PT3333','PT');
INSERT INTO sailor VALUES ('PT4444','PT');
-- Boat table INSERTS
INSERT INTO boat VALUES('NRP Vasco da Gama',1950,'NRP-111','PT','PT1111','PT');
INSERT INTO boat VALUES('NRP Lusitano',1950,'NRP-112','IN','PT1111','PT');
INSERT INTO boat VALUES('Ronaldinho',1990,'BRA-333','BR','PT4444','PT');
INSERT INTO boat VALUES('Creola',2002,'NRP-333','PT','PT3333','PT');
INSERT INTO boat VALUES('NRP Sagres',1970,'NRP-444','PT','PT2222','PT');
INSERT INTO boat VALUES('Titanic',1909,'ZAF-555','ZF','PT1111','PT');
INSERT INTO boat VALUES('Super Bock',1998,'BOCK1012','PT','PT1111','PT');

INSERT INTO schedule VALUES('2022-01-01','2022-12-31');
INSERT INTO schedule VALUES('2022-07-01','2023-06-30');
INSERT INTO schedule VALUES('2021-07-01','2022-06-30');
INSERT INTO schedule VALUES('2021-01-01','2023-06-30');

INSERT INTO reservation VALUES('NRP-111','PT','PT1111','PT','2022-01-01','2022-12-31'); -- Vasco Da Gama
INSERT INTO reservation VALUES('NRP-112','IN','PT2222','PT','2021-07-01','2023-06-30'); -- NRP Lusitano
INSERT INTO reservation VALUES('BRA-333','BR','PT1111','PT','2022-01-01','2022-12-31'); -- Ronaldinho
INSERT INTO reservation VALUES('NRP-333','PT','PT4444','PT','2021-01-01','2023-06-30'); -- Creola


-- Insert Trips
INSERT INTO trip VALUES('2022-01-02',7,'NRP-111','PT','PT1111','PT','2022-01-01','2022-12-31',33.956121, -9.258335,35.696142, 05.208335); -- Vasco Da Gama
INSERT INTO trip VALUES('2022-01-09',7,'NRP-111','PT','PT1111','PT','2022-01-01','2022-12-31',35.696142, 05.208335, 38.696142, -9.208335); -- Vasco Da Gama
INSERT INTO trip VALUES('2022-01-02',7,'NRP-333','PT','PT4444','PT','2021-01-01','2023-06-30',25.696142, -5.208335, 16.696142, -3.208323); -- Creola
INSERT INTO trip VALUES('2022-07-01',10,'NRP-112','IN','PT2222','PT','2022-07-01','2023-06-30',35.696142, 05.208335, 16.696142, -3.208323); -- NRP Lusitano

-- Queries to test triggers
-- INSERT INTO reservation VALUES('NRP-111','PT','PT1111','PT','2022-07-01','2023-06-30'); -- fails
-- INSERT INTO reservation VALUES('NRP-111','PT','PT1111','PT','2021-07-01','2022-06-30'); -- fails
-- INSERT INTO reservation VALUES('NRP-111','PT','PT1111','PT','2021-01-01','2023-06-30'); -- fails
-- INSERT INTO boat VALUES('Moderna',1960,'NRP-503','CN','PT1111','PT'); -- Suppose to fail
-- INSERT INTO marina VALUES(33.956121, -9.258335); -- Alcantara
