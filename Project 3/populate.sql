-- Delete all records in each of the existing tables
DELETE FROM trip;
DELETE FROM reservation;
DELETE FROM schedule;
DELETE FROM boat_vhf;
DELETE FROM boat;
DELETE FROM owner;
DELETE FROM sailor;
DELETE FROM person;
DELETE FROM port;
DELETE FROM wharf;
DELETE FROM marina;
DELETE FROM location;
DELETE FROM country;

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

INSERT INTO Country VALUES('https://www.worldometers.info/img/flags/ch-flag.gif',
                            'China',
                            'CN');
-- Location table INSERTS
START TRANSACTION;
-- PT locations
INSERT INTO location VALUES('Belem', 38.694664, -9.204000,'PT');
INSERT INTO location VALUES('Parque das Naçoes', 38.754363, -9.093657,'PT');
INSERT INTO location VALUES('Cascais', 38.692304, -9.418579,'PT');
-- BR locations
INSERT INTO location VALUES('Copacabana', -22.973280, -43.183140,'BR');
INSERT INTO location VALUES('Botafogo', -22.947632, -43.173545,'BR');
--ZF locations
INSERT INTO location VALUES('Murray Bay', -33.800334, 18.377103,'ZF');

-- Marina table INSERTS
INSERT INTO marina VALUES(38.754363, -9.093657); -- Parque das Nações
INSERT INTO marina VALUES(38.692304, -9.418579); -- Cascais

-- Wharf table INSERTS
INSERT INTO wharf VALUES(-22.973280, -43.183140);-- Copacabana
INSERT INTO wharf VALUES(-33.800334, 18.377103); -- Murray Bay

-- Port table INSERTS
INSERT INTO port VALUES(38.694664, -9.204000);   -- Belem
INSERT INTO port VALUES(-22.947632, -43.173545); -- Botafogo

COMMIT TRANSACTION;

-- Person table INSERTS
INSERT INTO person VALUES ('111','Joao','PT');
INSERT INTO person VALUES ('222','Carlos','PT');
INSERT INTO person VALUES ('333','Junior','BR');
INSERT INTO person VALUES ('444','Chen','CN');

-- Owner table INSERTS
INSERT INTO owner VALUES ('111','PT','1990-03-20');
INSERT INTO owner VALUES ('222','PT','1995-01-18');
INSERT INTO owner VALUES ('333','BR','1980-10-07');
INSERT INTO owner VALUES ('444','CN','1974-02-27');

-- Sailor table INSERTS
INSERT INTO sailor VALUES ('111','PT');
INSERT INTO sailor VALUES ('222','PT');
INSERT INTO sailor VALUES ('333','BR');
INSERT INTO sailor VALUES ('444','CN');

-- Boat table INSERTS
-- Boats in PT
INSERT INTO boat VALUES('Vasco da Gama',1950,'NRP 1','PT','111','PT');
INSERT INTO boat VALUES('Gil Eanes',1970,'NRP 2','PT','111','PT');
INSERT INTO boat VALUES('F. Magalhaes',200,'NRP 3','PT','222','PT');
INSERT INTO boat VALUES('Beijing',2010,'NRP 4','PT','444','CN');
-- Boats in BR
INSERT INTO boat VALUES('Vinicius',2015,'BRZ 1','BR','333','BR');
INSERT INTO boat VALUES('Caipira',2020,'BRZ 2','BR','333','BR');
INSERT INTO boat VALUES('Xangai',2020,'BRZ 3','BR','444','CN');
--Boats in ZF
INSERT INTO boat VALUES('Jameson',1984,'South-B1','ZF','111','PT');
INSERT INTO boat VALUES('Hong Kong',1985,'South-B2','ZF','444','CN');

-- Boat with VHF
INSERT INTO boat_vhf VALUES(156846953,'NRP 1','PT');
INSERT INTO boat_vhf VALUES(459863215,'NRP 2','PT');
INSERT INTO boat_vhf VALUES(578965523,'BRZ 3','BR');

-- Schedules
-- monthly (Jan - May)
INSERT INTO schedule VALUES('2022-01-01','2022-02-01');
INSERT INTO schedule VALUES('2022-02-02','2022-03-01');
INSERT INTO schedule VALUES('2022-03-02','2022-04-01');
INSERT INTO schedule VALUES('2022-04-02','2022-05-01');
INSERT INTO schedule VALUES('2022-05-02','2022-06-01');
-- yearly (2021,2022,2023)
INSERT INTO schedule VALUES('2021-01-01','2021-12-31');
INSERT INTO schedule VALUES('2022-01-01','2022-12-31');
INSERT INTO schedule VALUES('2023-01-01','2023-12-31');


-- Reservations
INSERT INTO reservation VALUES('NRP 1','PT','111','PT','2022-01-01','2022-02-01'); -- Joao reserva VG em janeiro
INSERT INTO reservation VALUES('NRP 2','PT','111','PT','2022-01-01','2022-02-01'); -- Joao reserva GE em janeiro
INSERT INTO reservation VALUES('NRP 2','PT','111','PT','2022-02-02','2022-03-01'); -- Joao reserva GE em fevereiro

INSERT INTO reservation VALUES('NRP 1','PT','222','PT','2022-02-02','2022-03-01'); -- Carlos reserva VG em fevereiro
INSERT INTO reservation VALUES('BRZ 1','BR','222','PT','2022-05-02','2022-06-01'); -- Carlos reserva Vinicius em maio

INSERT INTO reservation VALUES('BRZ 2','BR','333','BR','2021-01-01','2021-12-31'); -- Junior reserva Caipira em 2021
INSERT INTO reservation VALUES('South-B2','ZF','333','BR','2022-01-01','2022-02-01'); -- Junior reserva HK em janeiro

INSERT INTO reservation VALUES('NRP 4','PT','444','CN','2022-01-01','2022-02-01'); -- Chen reserva Beijing em janeiro
INSERT INTO reservation VALUES('BRZ 3','BR','444','CN','2022-02-02','2022-03-01'); -- Chen reserva Xangai em fevereiro
INSERT INTO reservation VALUES('South-B1','ZF','444','CN','2022-01-01','2022-12-31'); -- Chen reserva Beijing em 2022

-- Trips
-- Trips made by Joao
INSERT INTO trip VALUES('2022-01-05',1,'NRP 1','PT','111','PT','2022-01-01','2022-02-01',38.754363, -9.093657,38.692304,-9.418579); -- Joao viaja ao longo de 1 dia do Pq Nacoes para cascais em Janeiro (IDA) no VG
INSERT INTO trip VALUES('2022-01-06',1,'NRP 1','PT','111','PT','2022-01-01','2022-02-01',38.692304,-9.418579,38.754363, -9.093657); -- Joao viaja ao longo de 1 dia de Cascais para Pq.Naçoes em Janeiro (VOLTA) no VG
INSERT INTO trip VALUES('2022-01-07',1,'NRP 2','PT','111','PT','2022-01-01','2022-02-01',38.754363, -9.093657,38.694664, -9.204000); -- Joao viaja ao longo de 1 dia do Pq Nacoes para belem em Janeiro (IDA) no GE
INSERT INTO trip VALUES('2022-01-08',1,'NRP 2','PT','111','PT','2022-01-01','2022-02-01',38.694664, -9.204000,38.754363, -9.093657); -- Joao viaja ao longo de 1 dia de belem para Pq.Naçoes em Janeiro (VOLTA) no GE
-- Trips made by Carlos
INSERT INTO trip VALUES('2022-02-10',2,'NRP 1','PT','222','PT','2022-02-02','2022-03-01',38.694664, -9.204000,38.754363, -9.093657); -- Carlos viaja ao longo de 2 dia de belem para Pq.Naçoes em Janeiro no VG
INSERT INTO trip VALUES('2022-05-05',15,'BRZ 1','BR','222','PT','2022-05-02','2022-06-01',-22.973280, -43.183140,-22.973280, -43.183140); -- Carlos viaja ao longo de 15 dia de copacabana para copacabana em Maio no Vinicius
-- Trips made by Junior
INSERT INTO trip VALUES('2022-02-02',20,'South-B2','ZF','333','BR','2022-01-01','2022-02-01',-22.947632, -43.173545,38.692304, -9.418579); -- Junior viaja ao longo de 100 dias de botafogo (BR) para Cascais em 2022 no HK
-- Trips made by Chen
INSERT INTO trip VALUES('2022-01-01',20,'NRP 4','PT','444','CN','2022-01-01','2022-02-01',38.694664, -9.204000,-22.973280, -43.183140); -- Chen viaja ao longo de 20 dias de belem para copacabana (BR) no Beijing
INSERT INTO trip VALUES('2022-02-02',10,'BRZ 3','BR','444','CN','2022-02-02','2022-03-01',-22.973280, -43.183140,-33.800334, 18.377103); -- Chen viaja ao longo de 15 dias copacabana para Muray bay (ZF) no Xangai

