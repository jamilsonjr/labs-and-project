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


-- Owner table INSERTS
INSERT INTO owner VALUES ('PT1111','PT','2000-01-01');

-- Sailor table INSERTS
INSERT INTO sailor VALUES ('PT1111','PT');

-- Boat table INSERTS
INSERT INTO boat VALUES('NRP Vasco da Gama',1950,'NRP-111','PT','PT1111','PT');
INSERT INTO boat VALUES('NRP Lusitano',1950,'NRP-112','IN','PT1111','PT');
INSERT INTO boat VALUES('Moderna',1960,'NRP-503','CN','PT1111','PT'); -- Suppose to fail

INSERT INTO schedule VALUES('2022-01-01','2022-12-31');
INSERT INTO schedule VALUES('2022-07-01','2023-06-30');
INSERT INTO schedule VALUES('2021-07-01','2022-06-30');
INSERT INTO schedule VALUES('2021-01-01','2023-06-30');

INSERT INTO reservation VALUES('NRP-111','PT','PT1111','PT','2022-01-01','2022-12-31');
INSERT INTO reservation VALUES('NRP-111','PT','PT1111','PT','2022-07-01','2023-06-30'); -- fails
INSERT INTO reservation VALUES('NRP-111','PT','PT1111','PT','2021-07-01','2022-06-30'); -- fails
INSERT INTO reservation VALUES('NRP-111','PT','PT1111','PT','2021-01-01','2023-06-30'); -- fails