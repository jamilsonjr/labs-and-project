
-- Country table INSERTs
INSERT INTO Country VALUES('BRA',
                           'https://www.worldometers.info/img/flags/br-flag.gif',
                           'Brazil');
                           
INSERT INTO Country VALUES('PRT',
                            'https://www.worldometers.info/img/flags/po-flag.gif',
                            'Portugal');

INSERT INTO Country VALUES('ZAF',
                            'https://www.worldometers.info/img/flags/sf-flag.gif',
                            'South Africa');

INSERT INTO Country VALUES('IND',
                            'https://www.worldometers.info/img/flags/in-flag.gif',
                            'India');

INSERT INTO Country VALUES('THA',
                            'https://www.worldometers.info/img/flags/th-flag.gif',
                            'Thailand');

-- Person table INSERTs
INSERT INTO Person VALUES('Tony Jaa', 11111, 'THA');
INSERT INTO Person VALUES('Joao Rendeiro', 22222,'PRT');
INSERT INTO Person VALUES('Barba Negra', 33333, 'IND');
INSERT INTO Person VALUES('Nelson Mandela', 44444, 'ZAF');
INSERT INTO Person VALUES('Neymar Junior', 55555, 'BRA');
INSERT INTO Person VALUES('Joao Manel', 66666, 'PRT');
INSERT INTO Person VALUES('Manel Joao', 77777, 'PRT');

-- Sailor table INSERTS
INSERT INTO Sailor VALUES(11111, 'THA');
INSERT INTO Sailor VALUES(22222, 'PRT');
INSERT INTO Sailor VALUES(33333, 'IND');
INSERT INTO Sailor VALUES(66666, 'PRT');
INSERT INTO Sailor VALUES(77777, 'PRT');

-- Owner table INSERTS
INSERT INTO Owner VALUES(22222,'PRT','1952-03-22');
INSERT INTO Owner VALUES(33333, 'IND','1718-11-22');
INSERT INTO Owner VALUES(44444, 'ZAF','1930-05-26');
INSERT INTO Owner VALUES(55555, 'BRA','1900-01-02');

-- Boat table INSERTS
INSERT INTO Boat VALUES('Sagres','PRT', 89, 1937, 'PT1937', 33333, 'IND'); -- mmsi1
INSERT INTO Boat VALUES('Bota-fogo', 'PRT', 50 , 1801, 'PT1530', 55555, 'BRA'); -- mmsi2
INSERT INTO Boat VALUES('Vera Cruz', 'PRT', 24, 2002, 'PT2002', 55555, 'BRA'); -- mmsi3
INSERT INTO Boat VALUES('Creola','PRT', 89, 1943,'PT1943', 44444, 'ZAF');
INSERT INTO Boat VALUES('Campolide', 'PRT', 32, 2008, 'LX-3152-TL', 33333, 'IND');
INSERT INTO Boat VALUES('RMS Titanic', 'IND', 269, 1909, 'RMS1909', 44444, 'ZAF');
INSERT INTO Boat VALUES('Rendeiro$ Yatch', 'ZAF', 450, 2021, 'Rendeiro$', 22222, 'PRT');
INSERT INTO Boat VALUES('Rendeiro$ Yatch 2', 'BRA', 100, 2021, 'BrazilBaby', 22222, 'PRT');


-- Boat_With_VHF table INSERTS
INSERT INTO Boat_With_VHF VALUES(235762000, 'PRT', 'PT1937'); --mmsi 1
INSERT INTO Boat_With_VHF VALUES(235762001, 'PRT', 'PT2002'); --mmsi 2
INSERT INTO Boat_With_VHF VALUES(235762002, 'PRT', 'PT1943'); --mmsi 3

-- Location table INSERTS
INSERT INTO Location VALUES('Belém', 38.696142, -9.208335,'PRT');
INSERT INTO Location VALUES('Alcantara', 33.956121, -9.258335,'PRT');
INSERT INTO Location VALUES('Cascais', 35.696142, 05.208335,'PRT');
INSERT INTO Location VALUES('Rio de Janeiro', 25.696142, -5.208335,'BRA');
INSERT INTO Location VALUES('Cape Town', 16.696142, -3.208323,'ZAF');
INSERT INTO Location VALUES('Goa', 15.430154, 73.811340,'IND');

-- Marina table INSERTS
INSERT INTO Marina VALUES(33.956121, -9.258335); -- Alcantara
INSERT INTO Marina VALUES(38.696142, -9.208335); -- Belem
-- Wharf table INSERTS
INSERT INTO Wharf VALUES(35.696142, 05.208335); -- Cascais
INSERT INTO Wharf VALUES(25.696142, -5.208335); -- Rio de Janeiro
-- Port table INSERTS
INSERT INTO Port VALUES(16.696142, -3.208323); -- Cape Town
INSERT INTO Port VALUES(15.430154, 73.811340); -- Goa

-- Schedule table INSERTS
INSERT INTO Schedule VALUES('2021-12-30','2022-01-05');
INSERT INTO Schedule VALUES('2021-12-30','2023-01-05');
INSERT INTO Schedule VALUES('2020-05-30','2020-08-30');
INSERT INTO Schedule VALUES('2021-01-05','2021-01-06');
INSERT INTO Schedule VALUES('2021-11-30','2022-01-05');


-- reservation table INSERTS
INSERT INTO reservation VALUES(11111, 'THA', 'PT1937', 'PRT', '2021-12-30','2022-01-05');
INSERT INTO reservation VALUES(22222, 'PRT', 'PT1530', 'PRT', '2021-12-30','2023-01-05');
INSERT INTO reservation VALUES(33333, 'IND', 'PT2002', 'PRT', '2020-05-30','2020-08-30');
INSERT INTO reservation VALUES(11111, 'THA', 'PT1937', 'PRT', '2021-01-05','2021-01-06');
INSERT INTO reservation VALUES(22222, 'PRT', 'PT1530', 'PRT', '2021-11-30','2022-01-05');
INSERT INTO reservation VALUES(77777, 'PRT', 'RMS1909', 'IND', '2021-11-30','2022-01-05');


-- Trip table INSERTS
INSERT INTO Trip VALUES('2021-12-30',2,11111, 'THA', 'PT1937', 'PRT', '2021-12-30','2022-01-05',33.956121, -9.258335,25.696142, -5.208335);
INSERT INTO Trip VALUES('2021-12-30',100,22222, 'PRT', 'PT1530', 'PRT', '2021-12-30','2023-01-05',35.696142, 05.208335,25.696142, -5.208335);
INSERT INTO Trip VALUES('2020-05-30',60,33333, 'IND', 'PT2002', 'PRT', '2020-05-30','2020-08-30',38.696142, -9.208335,15.430154, 73.811340);
INSERT INTO Trip VALUES('2021-01-05',1,11111, 'THA', 'PT1937', 'PRT', '2021-01-05','2021-01-06',16.696142, -3.208323,25.696142, -5.208335);
INSERT INTO Trip VALUES('2021-11-30',30,22222, 'PRT', 'PT1530', 'PRT', '2021-11-30','2022-01-05', 25.696142, -5.208335, 15.430154, 73.811340);



