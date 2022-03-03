--create tables

CREATE TABLE TARA (
	PK_TARA NUMBER(18,0) NOT NULL,
	NUME NVARCHAR2(50) NOT NULL,
	CONSTRAINT PK_TARA PRIMARY KEY ( PK_TARA )
);

ALTER TABLE TARA ADD CONSTRAINT UQ_NUME_TARA UNIQUE (NUME);



CREATE TABLE ARTIST (
	PK_ARTIST NUMBER(18,0) NOT NULL,
	NUME NVARCHAR2(50) NOT NULL,
	FK_TARA NUMBER(18,0) NOT NULL,
	CONSTRAINT PK_ARTIST PRIMARY KEY ( PK_ARTIST )
);

ALTER TABLE ARTIST ADD CONSTRAINT UQ_NUME_ARTIST UNIQUE (NUME);
ALTER TABLE ARTIST ADD CONSTRAINT FK_TARA_ARTIST FOREIGN KEY(FK_TARA) REFERENCES TARA (PK_TARA);




CREATE TABLE GEN (
	PK_GEN NUMBER(18,0) NOT NULL,
	NUME NVARCHAR2(50) NOT NULL,
	CONSTRAINT PK_GEN PRIMARY KEY ( PK_GEN )
);

ALTER TABLE GEN ADD CONSTRAINT UQ_NUME_GEN UNIQUE (NUME);



CREATE TABLE TIP_ALBUM (
	PK_TIP_ALBUM NUMBER(18,0) NOT NULL,
	NUME NVARCHAR2(50) NOT NULL,
	CONSTRAINT PK_TIP_ALBUM PRIMARY KEY ( PK_TIP_ALBUM )
);

ALTER TABLE TIP_ALBUM ADD CONSTRAINT UQ_NUME_TIP_ALBUM UNIQUE (NUME);



CREATE TABLE CASA_DISCURI (
	PK_CASA_DISCURI NUMBER(18,0) NOT NULL,
	NUME NVARCHAR2(50) NOT NULL,
	CONSTRAINT PK_CASA_DISCURI PRIMARY KEY ( PK_CASA_DISCURI )
);

ALTER TABLE CASA_DISCURI ADD CONSTRAINT UQ_NUME_CASA_DISCURI UNIQUE (NUME);



CREATE TABLE ALBUM (
	PK_ALBUM NUMBER(18,0) NOT NULL,
	NUME NVARCHAR2(50) NOT NULL,
	AN NUMBER(18,0) NOT NULL,
	STOC NUMBER 
		DEFAULT 0 NOT NULL,
	PRET_VANZARE NUMBER NULL,
	PRET_INCHIRIERE NUMBER NULL,
	DATA_ADAUGARE Timestamp(3) 
		DEFAULT CURRENT_TIMESTAMP NOT NULL,
	FK_ARTIST NUMBER(18,0) NOT NULL,
	FK_TIP_ALBUM NUMBER(18,0) NOT NULL,
	FK_CASA_DISCURI NUMBER(18,0) NOT NULL,
	CONSTRAINT PK_ALBUM PRIMARY KEY ( PK_ALBUM ),
	CONSTRAINT CHECK_PRET_VANZARE_ALBUM CHECK (PRET_VANZARE IS NULL OR PRET_VANZARE > 0),
	CONSTRAINT CHECK_STOC_ALBUM CHECK (STOC >= 0)
);

ALTER TABLE ALBUM ADD CONSTRAINT UQ_ALBUM UNIQUE (NUME,FK_ARTIST,FK_TIP_ALBUM);
ALTER TABLE ALBUM ADD CONSTRAINT FK_ARTIST_ALBUM FOREIGN KEY(FK_ARTIST) REFERENCES ARTIST (PK_ARTIST);
ALTER TABLE ALBUM ADD CONSTRAINT FK_TIP_ALBUM_ALBUM FOREIGN KEY(FK_TIP_ALBUM) REFERENCES TIP_ALBUM (PK_TIP_ALBUM);
ALTER TABLE ALBUM ADD CONSTRAINT FK_CASA_DISCURI_ALBUM FOREIGN KEY(FK_CASA_DISCURI) REFERENCES CASA_DISCURI (PK_CASA_DISCURI);



CREATE TABLE MELODIE (
	PK_MELODIE NUMBER(18,0) NOT NULL,
	NUME NVARCHAR2(50) NOT NULL,
	DURATA NUMBER NOT NULL,
	FK_ARTIST NUMBER(18,0) NOT NULL,
	FK_ALBUM NUMBER(18,0) 
		DEFAULT NULL NULL,
	CONSTRAINT PK_MELODIE PRIMARY KEY ( PK_MELODIE ),
	CONSTRAINT CHECK_DURATA_MELODIE CHECK (DURATA > 0)
);

ALTER TABLE MELODIE ADD CONSTRAINT UQ_MELODIE UNIQUE (NUME,FK_ARTIST,FK_ALBUM);
ALTER TABLE MELODIE ADD CONSTRAINT FK_ARTIST_MELODIE FOREIGN KEY(FK_ARTIST) REFERENCES ARTIST (PK_ARTIST);
ALTER TABLE MELODIE ADD CONSTRAINT FK_ALBUM_MELODIE FOREIGN KEY(FK_ALBUM) REFERENCES ALBUM (PK_ALBUM);



CREATE TABLE MELODIE_GEN (
	PK_MELODIE_GEN NUMBER(18,0) NOT NULL,
	FK_MELODIE NUMBER(18,0) NOT NULL,
	FK_GEN NUMBER(18,0) NOT NULL,
	CONSTRAINT PK_MELODIE_GEN PRIMARY KEY ( PK_MELODIE_GEN ),
	CONSTRAINT UQ_MELODIE_GEN UNIQUE ( FK_MELODIE, FK_GEN )
);

ALTER TABLE MELODIE_GEN ADD CONSTRAINT FK_MELODIE_MELODIE_GEN FOREIGN KEY(FK_MELODIE) REFERENCES MELODIE (PK_MELODIE);
ALTER TABLE MELODIE_GEN ADD CONSTRAINT FK_GEN_MELODIE_GEN FOREIGN KEY(FK_GEN) REFERENCES GEN (PK_GEN);



CREATE TABLE CLIENT (

	PK_CLIENT Number(18,0) NOT NULL,
	NUME Nvarchar2(50) NOT NULL,
	PRENUME Nvarchar2(50) NOT NULL,
	CNP Nvarchar2(13) NOT NULL,
	ARE_CARD_FIDELITATE Number(1) 
        DEFAULT 0 NOT NULL,
	MAIL Nvarchar2(80) NULL,
	TELEFON Nvarchar2(15) NOT NULL,
	CONSTRAINT PK_CLIENT PRIMARY KEY ( PK_CLIENT ),
	CONSTRAINT CHECK_ARE_CARD_FIDELITATE CHECK ( ARE_CARD_FIDELITATE in (0,1) )
);

ALTER TABLE CLIENT ADD CONSTRAINT UQ_CNP_CLIENT UNIQUE (CNP);



CREATE TABLE ANGAJAT
(
	PK_ANGAJAT Number(18,0) NOT NULL,
	NUME Nvarchar2(50) NOT NULL,
	PRENUME Nvarchar2(50) NOT NULL,
	CNP Nvarchar2(50) NOT NULL,
	DATA_ANGAJARE Timestamp(3) NOT NULL,
	CONSTRAINT PK_ANGAJATI PRIMARY KEY ( PK_ANGAJAT )
);

ALTER TABLE ANGAJAT ADD CONSTRAINT UQ_CNP_ANGAJAT UNIQUE (CNP);



CREATE TABLE VANZARE
(
	PK_VANZARE Number(18,0) NOT NULL,
	DATA_VANZARE Timestamp(3) 
		DEFAULT CURRENT_TIMESTAMP NOT NULL,
	CANTITATE NUMBER 
		DEFAULT 1 NOT NULL,
	DISCOUNT NUMBER 
		DEFAULT 0 NOT NULL,
	FK_ALBUM NUMBER(18,0) NOT NULL,
	FK_ANGAJAT NUMBER(18,0) NOT NULL,
	CONSTRAINT PK_VANZARE PRIMARY KEY ( PK_VANZARE )
);

ALTER TABLE VANZARE ADD CONSTRAINT FK_ALBUM_VANZARE FOREIGN KEY(FK_ALBUM) REFERENCES ALBUM (PK_ALBUM);
ALTER TABLE VANZARE ADD CONSTRAINT FK_ANGAJAT_VANZARE FOREIGN KEY(FK_ANGAJAT) REFERENCES ANGAJAT (PK_ANGAJAT);



CREATE TABLE INCHIRIERE
(
	PK_INCHIRIERE Number(18,0) NOT NULL,
	DATA_INCHIRIERE Timestamp(3) 
		DEFAULT CURRENT_TIMESTAMP NOT NULL,
	DATE_RETUR Timestamp(3) 
		DEFAULT NULL NULL,
	CANTITATE NUMBER 
		DEFAULT 1 NOT NULL,
	DISCOUNT NUMBER 
		DEFAULT 0 NOT NULL,
	PENALITATI NUMBER
		DEFAULT 0 NOT NULL,
	FK_ALBUM NUMBER(18,0) NOT NULL,
	FK_ANGAJAT NUMBER(18,0) NOT NULL,
	FK_CLIENT NUMBER(18,0) NOT NULL,
	CONSTRAINT PK_INCHIRIERE PRIMARY KEY ( PK_INCHIRIERE )
);

ALTER TABLE INCHIRIERE ADD CONSTRAINT FK_ALBUM_INCHIRIERE FOREIGN KEY(FK_ALBUM) REFERENCES ALBUM (PK_ALBUM);
ALTER TABLE INCHIRIERE ADD CONSTRAINT FK_ANGAJAT_INCHIRIERE FOREIGN KEY(FK_ANGAJAT) REFERENCES ANGAJAT (PK_ANGAJAT);
ALTER TABLE INCHIRIERE ADD CONSTRAINT FK_CLIENT_INCHIRIERE FOREIGN KEY(FK_CLIENT) REFERENCES CLIENT (PK_CLIENT);


--13
----
CREATE SEQUENCE sequence_artist
INCREMENT BY 1
START WITH 1
NOMAXVALUE
MINVALUE 1
NOCYCLE
NOCACHE
ORDER;

CREATE SEQUENCE sequence_tara
INCREMENT BY 1
START WITH 1
MAXVALUE 200
MINVALUE 1
NOCYCLE
NOCACHE
ORDER;

CREATE SEQUENCE sequence_gen
INCREMENT BY 1
START WITH 1
MAXVALUE 1000
MINVALUE 1
NOCYCLE
NOCACHE
ORDER;

CREATE SEQUENCE sequence_melodie_gen
INCREMENT BY 1
START WITH 1
NOMAXVALUE
MINVALUE 1
NOCYCLE
NOCACHE
ORDER;

CREATE SEQUENCE sequence_melodie
INCREMENT BY 1
START WITH 1
NOMAXVALUE
MINVALUE 1
NOCYCLE
NOCACHE
ORDER;

CREATE SEQUENCE sequence_album
INCREMENT BY 1
START WITH 1
NOMAXVALUE
MINVALUE 1
NOCYCLE
NOCACHE
ORDER;

CREATE SEQUENCE sequence_casa_discuri
INCREMENT BY 1
START WITH 1
NOMAXVALUE
MINVALUE 1
NOCYCLE
NOCACHE
ORDER;

CREATE SEQUENCE sequence_angajat
INCREMENT BY 1
START WITH 1
NOMAXVALUE
MINVALUE 1
NOCYCLE
NOCACHE
ORDER;

CREATE SEQUENCE sequence_client
INCREMENT BY 1
START WITH 1
NOMAXVALUE
MINVALUE 1
NOCYCLE
NOCACHE
ORDER;

CREATE SEQUENCE sequence_vanzare
INCREMENT BY 1
START WITH 1
NOMAXVALUE
MINVALUE 1
NOCYCLE
NOCACHE
ORDER;

CREATE SEQUENCE sequence_inchiriere
INCREMENT BY 1
START WITH 1
NOMAXVALUE
MINVALUE 1
NOCYCLE
NOCACHE
ORDER;

drop sequence sequence_tara;
delete from tara;

drop sequence sequence_artist;
delete from artist;

--inserts

INSERT INTO TARA(PK_TARA,NUME) VALUES (sequence_tara.nextval,'Romania');
INSERT INTO TARA(PK_TARA,NUME) VALUES (sequence_tara.nextval,'SUA');
INSERT INTO TARA(PK_TARA,NUME) VALUES (sequence_tara.nextval,'Marea Britanie');
INSERT INTO TARA(PK_TARA,NUME) VALUES (sequence_tara.nextval,'Franta');
INSERT INTO TARA(PK_TARA,NUME) VALUES (sequence_tara.nextval,'Germania');

select *from tara;

INSERT INTO ARTIST(PK_ARTIST,NUME,FK_TARA) VALUES(sequence_artist.nextval,'Maria Tanase',1);
INSERT INTO ARTIST(PK_ARTIST,NUME,FK_TARA) VALUES(sequence_artist.nextval,'Guns N Roses',2);
INSERT INTO ARTIST(PK_ARTIST,NUME,FK_TARA) VALUES(sequence_artist.nextval,'Louis Armstrong',2);
INSERT INTO ARTIST(PK_ARTIST,NUME,FK_TARA) VALUES(sequence_artist.nextval,'Elvis Presley',2);
INSERT INTO ARTIST(PK_ARTIST,NUME,FK_TARA) VALUES(sequence_artist.nextval,'The Rolling Stones',3);
INSERT INTO ARTIST(PK_ARTIST,NUME,FK_TARA) VALUES(sequence_artist.nextval,'The Beatles',3);
INSERT INTO ARTIST(PK_ARTIST,NUME,FK_TARA) VALUES(sequence_artist.nextval,'The Who',3);
INSERT INTO ARTIST(PK_ARTIST,NUME,FK_TARA) VALUES(sequence_artist.nextval,'Joe Dassin',4);
INSERT INTO ARTIST(PK_ARTIST,NUME,FK_TARA) VALUES(sequence_artist.nextval,'Scorpions',5);

select *from artist;

INSERT INTO GEN(PK_GEN,NUME) VALUES (sequence_gen.nextval,'Folclor');
INSERT INTO GEN(PK_GEN,NUME) VALUES (sequence_gen.nextval,'Rock');
INSERT INTO GEN(PK_GEN,NUME) VALUES (sequence_gen.nextval,'Jazz');
INSERT INTO GEN(PK_GEN,NUME) VALUES (sequence_gen.nextval,'Rock & Roll');
INSERT INTO GEN(PK_GEN,NUME) VALUES (sequence_gen.nextval,'Country');
INSERT INTO GEN(PK_GEN,NUME) VALUES (sequence_gen.nextval,'Chanson');

select *from gen;
update gen set pk_gen=pk_gen-1;

INSERT INTO TIP_ALBUM(PK_TIP_ALBUM,NUME) VALUES (1,'VINYL');
INSERT INTO TIP_ALBUM(PK_TIP_ALBUM,NUME) VALUES (2,'CASETA');
INSERT INTO TIP_ALBUM(PK_TIP_ALBUM,NUME) VALUES (3,'CD');

select *from tip_album;

INSERT INTO CASA_DISCURI(PK_CASA_DISCURI,NUME) VALUES (sequence_casa_discuri.nextval,'Global Records');
INSERT INTO CASA_DISCURI(PK_CASA_DISCURI,NUME) VALUES (sequence_casa_discuri.nextval,'Universal Records');
INSERT INTO CASA_DISCURI(PK_CASA_DISCURI,NUME) VALUES (sequence_casa_discuri.nextval,'Electrocord');
INSERT INTO CASA_DISCURI(PK_CASA_DISCURI,NUME) VALUES (sequence_casa_discuri.nextval,'Atlantic Records');
INSERT INTO CASA_DISCURI(PK_CASA_DISCURI,NUME) VALUES (sequence_casa_discuri.nextval,'CBS');

select *from casa_discuri;
update casa_discuri set pk_casa_discuri=pk_casa_discuri-1;

INSERT INTO ALBUM(PK_ALBUM,NUME,AN,PRET_VANZARE,PRET_INCHIRIERE,FK_ARTIST,FK_TIP_ALBUM,FK_CASA_DISCURI,STOC) VALUES (sequence_album.nextval,'Ciuleandra',1962,340,20,1,1,3,2);
INSERT INTO ALBUM(PK_ALBUM,NUME,AN,PRET_VANZARE,PRET_INCHIRIERE,FK_ARTIST,FK_TIP_ALBUM,FK_CASA_DISCURI,STOC) VALUES (sequence_album.nextval,'Greatest Hits',2001,190,12,1,3,3,2);
INSERT INTO ALBUM(PK_ALBUM,NUME,AN,PRET_VANZARE,PRET_INCHIRIERE,FK_ARTIST,FK_TIP_ALBUM,FK_CASA_DISCURI,STOC) VALUES (sequence_album.nextval,'Appetite for Destruction',1987,250,11,2,3,2,1);
INSERT INTO ALBUM(PK_ALBUM,NUME,AN,PRET_VANZARE,PRET_INCHIRIERE,FK_ARTIST,FK_TIP_ALBUM,FK_CASA_DISCURI,STOC) VALUES (sequence_album.nextval,'Hello, Dolly!',1964,235,15,3,3,2,4);
INSERT INTO ALBUM(PK_ALBUM,NUME,AN,PRET_VANZARE,PRET_INCHIRIERE,FK_ARTIST,FK_TIP_ALBUM,FK_CASA_DISCURI,STOC) VALUES (sequence_album.nextval,'Moody Blue',1977,211,24,4,1,1,2);
INSERT INTO ALBUM(PK_ALBUM,NUME,AN,PRET_VANZARE,PRET_INCHIRIERE,FK_ARTIST,FK_TIP_ALBUM,FK_CASA_DISCURI,STOC) VALUES (sequence_album.nextval,'G.I. Blues',1960,253,22,4,1,1,3);
INSERT INTO ALBUM(PK_ALBUM,NUME,AN,PRET_VANZARE,PRET_INCHIRIERE,FK_ARTIST,FK_TIP_ALBUM,FK_CASA_DISCURI,STOC) VALUES (sequence_album.nextval,'Aftermath',1966,290,19,5,1,2,1);
INSERT INTO ALBUM(PK_ALBUM,NUME,AN,PRET_VANZARE,PRET_INCHIRIERE,FK_ARTIST,FK_TIP_ALBUM,FK_CASA_DISCURI,STOC) VALUES (sequence_album.nextval,'Abbey Road',1969,253,18,6,1,4,1);
INSERT INTO ALBUM(PK_ALBUM,NUME,AN,PRET_VANZARE,PRET_INCHIRIERE,FK_ARTIST,FK_TIP_ALBUM,FK_CASA_DISCURI,STOC) VALUES (sequence_album.nextval,'Let it be',1970,243,33,6,2,1,2);
INSERT INTO ALBUM(PK_ALBUM,NUME,AN,PRET_VANZARE,PRET_INCHIRIERE,FK_ARTIST,FK_TIP_ALBUM,FK_CASA_DISCURI,STOC) VALUES (sequence_album.nextval,'My Generation',1965,244,31,7,1,4,5);
INSERT INTO ALBUM(PK_ALBUM,NUME,AN,PRET_VANZARE,PRET_INCHIRIERE,FK_ARTIST,FK_TIP_ALBUM,FK_CASA_DISCURI,STOC) VALUES (sequence_album.nextval,'Who’s next',1971,267,22,7,1,4,5);
INSERT INTO ALBUM(PK_ALBUM,NUME,AN,PRET_VANZARE,PRET_INCHIRIERE,FK_ARTIST,FK_TIP_ALBUM,FK_CASA_DISCURI,STOC) VALUES (sequence_album.nextval,'Les Champs-Élysées',1969,250,15,8,1,5,1);
INSERT INTO ALBUM(PK_ALBUM,NUME,AN,PRET_VANZARE,PRET_INCHIRIERE,FK_ARTIST,FK_TIP_ALBUM,FK_CASA_DISCURI,STOC) VALUES (sequence_album.nextval,'Les Champs-Élysées',1969,250,15,8,3,5,3);
INSERT INTO ALBUM(PK_ALBUM,NUME,AN,PRET_VANZARE,PRET_INCHIRIERE,FK_ARTIST,FK_TIP_ALBUM,FK_CASA_DISCURI,STOC) VALUES (sequence_album.nextval,'Les Femmes de ma vie',1970,240,15,8,1,5,2);
INSERT INTO ALBUM(PK_ALBUM,NUME,AN,PRET_VANZARE,PRET_INCHIRIERE,FK_ARTIST,FK_TIP_ALBUM,FK_CASA_DISCURI,STOC) VALUES (sequence_album.nextval,'Lovedrive',1979,242,15,9,1,4,1);
INSERT INTO ALBUM(PK_ALBUM,NUME,AN,PRET_VANZARE,PRET_INCHIRIERE,FK_ARTIST,FK_TIP_ALBUM,FK_CASA_DISCURI,STOC) VALUES (sequence_album.nextval,'Crazy World',1990,310,15,9,1,2,1);

select *from album;
update album set pk_album=pk_album-1;

INSERT INTO MELODIE(PK_MELODIE,NUME,DURATA,FK_ARTIST,FK_ALBUM) VALUES(sequence_melodie.nextval,'Pe vale, tato, pe vale',180,1,1);
INSERT INTO MELODIE(PK_MELODIE,NUME,DURATA,FK_ARTIST,FK_ALBUM) VALUES(sequence_melodie.nextval,'Trenule, masina mica',182,1,2);
INSERT INTO MELODIE(PK_MELODIE,NUME,DURATA,FK_ARTIST,FK_ALBUM) VALUES(sequence_melodie.nextval,'Welcome to the Jungle',190,2,3);
INSERT INTO MELODIE(PK_MELODIE,NUME,DURATA,FK_ARTIST,FK_ALBUM) VALUES(sequence_melodie.nextval,'Sweet Child O Mine',198,2,3);
INSERT INTO MELODIE(PK_MELODIE,NUME,DURATA,FK_ARTIST,FK_ALBUM) VALUES(sequence_melodie.nextval,'Paradise City',244,2,3);
INSERT INTO MELODIE(PK_MELODIE,NUME,DURATA,FK_ARTIST,FK_ALBUM) VALUES(sequence_melodie.nextval,'What a Wonderful World',170,3,NULL);
INSERT INTO MELODIE(PK_MELODIE,NUME,DURATA,FK_ARTIST,FK_ALBUM) VALUES(sequence_melodie.nextval,'Black and Blue',189,3,4);
INSERT INTO MELODIE(PK_MELODIE,NUME,DURATA,FK_ARTIST,FK_ALBUM) VALUES(sequence_melodie.nextval,'Let Me Be There',214,4,5);
INSERT INTO MELODIE(PK_MELODIE,NUME,DURATA,FK_ARTIST,FK_ALBUM) VALUES(sequence_melodie.nextval,'Blue Suede Shoes',194,4,6);
INSERT INTO MELODIE(PK_MELODIE,NUME,DURATA,FK_ARTIST,FK_ALBUM) VALUES(sequence_melodie.nextval,'Doncha Bother Me',170,5,7);
INSERT INTO MELODIE(PK_MELODIE,NUME,DURATA,FK_ARTIST,FK_ALBUM) VALUES(sequence_melodie.nextval,'Lady Jane',172,5,7);
INSERT INTO MELODIE(PK_MELODIE,NUME,DURATA,FK_ARTIST,FK_ALBUM) VALUES(sequence_melodie.nextval,'Under My Thumb',180,5,7);
INSERT INTO MELODIE(PK_MELODIE,NUME,DURATA,FK_ARTIST,FK_ALBUM) VALUES(sequence_melodie.nextval,'Something',150,6,8);
INSERT INTO MELODIE(PK_MELODIE,NUME,DURATA,FK_ARTIST,FK_ALBUM) VALUES(sequence_melodie.nextval,'Two of us',230,6,9);
INSERT INTO MELODIE(PK_MELODIE,NUME,DURATA,FK_ARTIST,FK_ALBUM) VALUES(sequence_melodie.nextval,'Across the Universe',280,6,9);
INSERT INTO MELODIE(PK_MELODIE,NUME,DURATA,FK_ARTIST,FK_ALBUM) VALUES(sequence_melodie.nextval,'Out in the street',350,7,10);
INSERT INTO MELODIE(PK_MELODIE,NUME,DURATA,FK_ARTIST,FK_ALBUM) VALUES(sequence_melodie.nextval,'Won’t get fooled again',250,7,11);
INSERT INTO MELODIE(PK_MELODIE,NUME,DURATA,FK_ARTIST,FK_ALBUM) VALUES(sequence_melodie.nextval,'Baba O’Riley',210,7,11);
INSERT INTO MELODIE(PK_MELODIE,NUME,DURATA,FK_ARTIST,FK_ALBUM) VALUES(sequence_melodie.nextval,'Les Champs-Élysées',180,8,12);
INSERT INTO MELODIE(PK_MELODIE,NUME,DURATA,FK_ARTIST,FK_ALBUM) VALUES(sequence_melodie.nextval,'Les Champs-Élysées',160,8,13);
INSERT INTO MELODIE(PK_MELODIE,NUME,DURATA,FK_ARTIST,FK_ALBUM) VALUES(sequence_melodie.nextval,'Les Femmes de ma vie',187,8,14);
INSERT INTO MELODIE(PK_MELODIE,NUME,DURATA,FK_ARTIST,FK_ALBUM) VALUES(sequence_melodie.nextval,'Always Somewhere',167,9,15);
INSERT INTO MELODIE(PK_MELODIE,NUME,DURATA,FK_ARTIST,FK_ALBUM) VALUES(sequence_melodie.nextval,'Wind of change',243,9,16);
INSERT INTO MELODIE(PK_MELODIE,NUME,DURATA,FK_ARTIST,FK_ALBUM) VALUES(sequence_melodie.nextval,'Restless Nights',164,9,16);

select *from melodie;
update melodie set pk_melodie=pk_melodie-1;

INSERT INTO MELODIE_GEN(PK_MELODIE_GEN,FK_MELODIE,FK_GEN) VALUES (sequence_melodie_gen.nextval,1,1);
INSERT INTO MELODIE_GEN(PK_MELODIE_GEN,FK_MELODIE,FK_GEN) VALUES (sequence_melodie_gen.nextval,2,1);
INSERT INTO MELODIE_GEN(PK_MELODIE_GEN,FK_MELODIE,FK_GEN) VALUES (sequence_melodie_gen.nextval,3,2);
INSERT INTO MELODIE_GEN(PK_MELODIE_GEN,FK_MELODIE,FK_GEN) VALUES (sequence_melodie_gen.nextval,4,2);
INSERT INTO MELODIE_GEN(PK_MELODIE_GEN,FK_MELODIE,FK_GEN) VALUES (sequence_melodie_gen.nextval,5,2);
INSERT INTO MELODIE_GEN(PK_MELODIE_GEN,FK_MELODIE,FK_GEN) VALUES (sequence_melodie_gen.nextval,6,3);
INSERT INTO MELODIE_GEN(PK_MELODIE_GEN,FK_MELODIE,FK_GEN) VALUES (sequence_melodie_gen.nextval,7,3);
INSERT INTO MELODIE_GEN(PK_MELODIE_GEN,FK_MELODIE,FK_GEN) VALUES (sequence_melodie_gen.nextval,8,2);
INSERT INTO MELODIE_GEN(PK_MELODIE_GEN,FK_MELODIE,FK_GEN) VALUES (sequence_melodie_gen.nextval,8,5);
INSERT INTO MELODIE_GEN(PK_MELODIE_GEN,FK_MELODIE,FK_GEN) VALUES (sequence_melodie_gen.nextval,9,2);
INSERT INTO MELODIE_GEN(PK_MELODIE_GEN,FK_MELODIE,FK_GEN) VALUES (sequence_melodie_gen.nextval,9,4);
INSERT INTO MELODIE_GEN(PK_MELODIE_GEN,FK_MELODIE,FK_GEN) VALUES (sequence_melodie_gen.nextval,10,2);
INSERT INTO MELODIE_GEN(PK_MELODIE_GEN,FK_MELODIE,FK_GEN) VALUES (sequence_melodie_gen.nextval,10,5);
INSERT INTO MELODIE_GEN(PK_MELODIE_GEN,FK_MELODIE,FK_GEN) VALUES (sequence_melodie_gen.nextval,11,2);
INSERT INTO MELODIE_GEN(PK_MELODIE_GEN,FK_MELODIE,FK_GEN) VALUES (sequence_melodie_gen.nextval,12,2);
INSERT INTO MELODIE_GEN(PK_MELODIE_GEN,FK_MELODIE,FK_GEN) VALUES (sequence_melodie_gen.nextval,13,2);
INSERT INTO MELODIE_GEN(PK_MELODIE_GEN,FK_MELODIE,FK_GEN) VALUES (sequence_melodie_gen.nextval,14,2);
INSERT INTO MELODIE_GEN(PK_MELODIE_GEN,FK_MELODIE,FK_GEN) VALUES (sequence_melodie_gen.nextval,15,2);
INSERT INTO MELODIE_GEN(PK_MELODIE_GEN,FK_MELODIE,FK_GEN) VALUES (sequence_melodie_gen.nextval,16,1);
INSERT INTO MELODIE_GEN(PK_MELODIE_GEN,FK_MELODIE,FK_GEN) VALUES (sequence_melodie_gen.nextval,17,1);
INSERT INTO MELODIE_GEN(PK_MELODIE_GEN,FK_MELODIE,FK_GEN) VALUES (sequence_melodie_gen.nextval,18,1);
INSERT INTO MELODIE_GEN(PK_MELODIE_GEN,FK_MELODIE,FK_GEN) VALUES (sequence_melodie_gen.nextval,19,6);
INSERT INTO MELODIE_GEN(PK_MELODIE_GEN,FK_MELODIE,FK_GEN) VALUES (sequence_melodie_gen.nextval,20,6);
INSERT INTO MELODIE_GEN(PK_MELODIE_GEN,FK_MELODIE,FK_GEN) VALUES (sequence_melodie_gen.nextval,21,6);
INSERT INTO MELODIE_GEN(PK_MELODIE_GEN,FK_MELODIE,FK_GEN) VALUES (sequence_melodie_gen.nextval,22,2);
INSERT INTO MELODIE_GEN(PK_MELODIE_GEN,FK_MELODIE,FK_GEN) VALUES (sequence_melodie_gen.nextval,23,2);
INSERT INTO MELODIE_GEN(PK_MELODIE_GEN,FK_MELODIE,FK_GEN) VALUES (sequence_melodie_gen.nextval,24,2);



INSERT INTO CLIENT(PK_CLIENT,NUME,PRENUME,CNP,MAIL,TELEFON) VALUES (sequence_client.nextval,'Popescu','Vasile','1910123456789',NULL,'0712345678');
INSERT INTO CLIENT(PK_CLIENT,NUME,PRENUME,CNP,MAIL,TELEFON) VALUES (sequence_client.nextval,'Ionescu','Dumitru','1920304567890','ionescu.dumitru@gmail.com','0712739678');
INSERT INTO CLIENT(PK_CLIENT,NUME,PRENUME,CNP,MAIL,TELEFON) VALUES (sequence_client.nextval,'Georgescu','Ion','1870516787889','georgescu.ion@yahoo.com','0712325670');
INSERT INTO CLIENT(PK_CLIENT,NUME,PRENUME,CNP,MAIL,TELEFON) VALUES (sequence_client.nextval,'Enescu','Emilia','2900304567813',NULL,'0743535378');
INSERT INTO CLIENT(PK_CLIENT,NUME,PRENUME,CNP,MAIL,TELEFON) VALUES (sequence_client.nextval,'Gavrilescu','Ileana','2851011345678',NULL,'0713355668');

select *from client;
update client set pk_client=pk_client-1;

INSERT INTO ANGAJAT(PK_ANGAJAT,NUME,PRENUME,CNP,DATA_ANGAJARE) VALUES (sequence_angajat.nextval,'Popa','Liliana','2851205778844',TO_TIMESTAMP('2016-03-22','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO ANGAJAT(PK_ANGAJAT,NUME,PRENUME,CNP,DATA_ANGAJARE) VALUES (sequence_angajat.nextval,'Frasinescu','Madalina','2950304778899',TO_TIMESTAMP('2018-09-09','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO ANGAJAT(PK_ANGAJAT,NUME,PRENUME,CNP,DATA_ANGAJARE) VALUES (sequence_angajat.nextval,'Medvei','Raul','1780130447788',TO_TIMESTAMP('2015-02-01','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO ANGAJAT(PK_ANGAJAT,NUME,PRENUME,CNP,DATA_ANGAJARE) VALUES (sequence_angajat.nextval,'Giurca','Lucian','1880307346712',TO_TIMESTAMP('2019-01-01','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO ANGAJAT(PK_ANGAJAT,NUME,PRENUME,CNP,DATA_ANGAJARE) VALUES (sequence_angajat.nextval,'Iliescu','Antonia','2900102345633',TO_TIMESTAMP('2018-10-11','YYYY-MM-DD HH24:MI:SS'));

update angajat set pk_angajat=pk_angajat-1;
select *from angajat;

INSERT INTO VANZARE(PK_VANZARE,DATA_VANZARE,FK_ALBUM,FK_ANGAJAT) VALUES (sequence_vanzare.nextval,TO_TIMESTAMP('2021-05-11','YYYY-MM-DD HH24:MI:SS'),2,1);
INSERT INTO VANZARE(PK_VANZARE,DATA_VANZARE,FK_ALBUM,FK_ANGAJAT) VALUES (sequence_vanzare.nextval,TO_TIMESTAMP('2021-06-12','YYYY-MM-DD HH24:MI:SS'),3,2);
INSERT INTO VANZARE(PK_VANZARE,DATA_VANZARE,FK_ALBUM,FK_ANGAJAT) VALUES (sequence_vanzare.nextval,TO_TIMESTAMP('2021-04-18','YYYY-MM-DD HH24:MI:SS'),12,5);
INSERT INTO VANZARE(PK_VANZARE,DATA_VANZARE,FK_ALBUM,FK_ANGAJAT) VALUES (sequence_vanzare.nextval,TO_TIMESTAMP('2021-04-19','YYYY-MM-DD HH24:MI:SS'),10,4);
INSERT INTO VANZARE(PK_VANZARE,DATA_VANZARE,FK_ALBUM,FK_ANGAJAT) VALUES (sequence_vanzare.nextval,TO_TIMESTAMP('2021-05-10','YYYY-MM-DD HH24:MI:SS'),1,2);
INSERT INTO VANZARE(PK_VANZARE,DATA_VANZARE,FK_ALBUM,FK_ANGAJAT) VALUES (sequence_vanzare.nextval,TO_TIMESTAMP('2021-05-25','YYYY-MM-DD HH24:MI:SS'),11,2);
INSERT INTO VANZARE(PK_VANZARE,DATA_VANZARE,FK_ALBUM,FK_ANGAJAT) VALUES (sequence_vanzare.nextval,TO_TIMESTAMP('2021-06-04','YYYY-MM-DD HH24:MI:SS'),8,1);
INSERT INTO VANZARE(PK_VANZARE,DATA_VANZARE,FK_ALBUM,FK_ANGAJAT) VALUES (sequence_vanzare.nextval,TO_TIMESTAMP('2021-06-08','YYYY-MM-DD HH24:MI:SS'),9,3);
INSERT INTO VANZARE(PK_VANZARE,DATA_VANZARE,FK_ALBUM,FK_ANGAJAT) VALUES (sequence_vanzare.nextval,TO_TIMESTAMP('2021-06-23','YYYY-MM-DD HH24:MI:SS'),12,3);
INSERT INTO VANZARE(PK_VANZARE,DATA_VANZARE,FK_ALBUM,FK_ANGAJAT) VALUES (sequence_vanzare.nextval,TO_TIMESTAMP('2021-07-12','YYYY-MM-DD HH24:MI:SS'),2,2);
INSERT INTO VANZARE(PK_VANZARE,DATA_VANZARE,FK_ALBUM,FK_ANGAJAT) VALUES (sequence_vanzare.nextval,TO_TIMESTAMP('2021-07-14','YYYY-MM-DD HH24:MI:SS'),3,1);
INSERT INTO VANZARE(PK_VANZARE,DATA_VANZARE,FK_ALBUM,FK_ANGAJAT) VALUES (sequence_vanzare.nextval,TO_TIMESTAMP('2021-07-16','YYYY-MM-DD HH24:MI:SS'),14,4);
INSERT INTO VANZARE(PK_VANZARE,DATA_VANZARE,FK_ALBUM,FK_ANGAJAT) VALUES (sequence_vanzare.nextval,TO_TIMESTAMP('2021-07-16','YYYY-MM-DD HH24:MI:SS'),1,4);
INSERT INTO VANZARE(PK_VANZARE,DATA_VANZARE,FK_ALBUM,FK_ANGAJAT) VALUES (sequence_vanzare.nextval,TO_TIMESTAMP('2021-07-16','YYYY-MM-DD HH24:MI:SS'),5,4);
INSERT INTO VANZARE(PK_VANZARE,DATA_VANZARE,FK_ALBUM,FK_ANGAJAT) VALUES (sequence_vanzare.nextval,TO_TIMESTAMP('2021-07-18','YYYY-MM-DD HH24:MI:SS'),3,5);

select *from vanzare;

INSERT INTO INCHIRIERE(PK_INCHIRIERE,DATA_INCHIRIERE,DATE_RETUR,FK_ALBUM,FK_ANGAJAT,FK_CLIENT) VALUES (sequence_inchiriere.nextval,TO_TIMESTAMP('2021-07-18','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2021-08-18','YYYY-MM-DD HH24:MI:SS'),3,5,1);
INSERT INTO INCHIRIERE(PK_INCHIRIERE,DATA_INCHIRIERE,DATE_RETUR,FK_ALBUM,FK_ANGAJAT,FK_CLIENT) VALUES (sequence_inchiriere.nextval,TO_TIMESTAMP('2021-06-12','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2021-07-12','YYYY-MM-DD HH24:MI:SS'),3,2,3);
INSERT INTO INCHIRIERE(PK_INCHIRIERE,DATA_INCHIRIERE,DATE_RETUR,FK_ALBUM,FK_ANGAJAT,FK_CLIENT) VALUES (sequence_inchiriere.nextval,TO_TIMESTAMP('2021-04-18','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2021-05-18','YYYY-MM-DD HH24:MI:SS'),12,5,4);
INSERT INTO INCHIRIERE(PK_INCHIRIERE,DATA_INCHIRIERE,DATE_RETUR,FK_ALBUM,FK_ANGAJAT,FK_CLIENT) VALUES (sequence_inchiriere.nextval,TO_TIMESTAMP('2021-04-19','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2021-05-18','YYYY-MM-DD HH24:MI:SS'),10,4,2);
INSERT INTO INCHIRIERE(PK_INCHIRIERE,DATA_INCHIRIERE,DATE_RETUR,FK_ALBUM,FK_ANGAJAT,FK_CLIENT) VALUES (sequence_inchiriere.nextval,TO_TIMESTAMP('2021-05-10','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2021-06-09','YYYY-MM-DD HH24:MI:SS'),1,2,2);
INSERT INTO INCHIRIERE(PK_INCHIRIERE,DATA_INCHIRIERE,DATE_RETUR,FK_ALBUM,FK_ANGAJAT,FK_CLIENT) VALUES (sequence_inchiriere.nextval,TO_TIMESTAMP('2021-05-25','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2021-06-25','YYYY-MM-DD HH24:MI:SS'),7,2,2);
INSERT INTO INCHIRIERE(PK_INCHIRIERE,DATA_INCHIRIERE,DATE_RETUR,FK_ALBUM,FK_ANGAJAT,FK_CLIENT) VALUES (sequence_inchiriere.nextval,TO_TIMESTAMP('2021-06-04','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2021-07-12','YYYY-MM-DD HH24:MI:SS'),8,1,2);
INSERT INTO INCHIRIERE(PK_INCHIRIERE,DATA_INCHIRIERE,DATE_RETUR,FK_ALBUM,FK_ANGAJAT,FK_CLIENT) VALUES (sequence_inchiriere.nextval,TO_TIMESTAMP('2021-06-08','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2021-07-12','YYYY-MM-DD HH24:MI:SS'),9,3,1);
INSERT INTO INCHIRIERE(PK_INCHIRIERE,DATA_INCHIRIERE,DATE_RETUR,FK_ALBUM,FK_ANGAJAT,FK_CLIENT) VALUES (sequence_inchiriere.nextval,TO_TIMESTAMP('2021-06-23','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2021-07-22','YYYY-MM-DD HH24:MI:SS'),12,3,4);
INSERT INTO INCHIRIERE(PK_INCHIRIERE,DATA_INCHIRIERE,DATE_RETUR,FK_ALBUM,FK_ANGAJAT,FK_CLIENT) VALUES (sequence_inchiriere.nextval,TO_TIMESTAMP('2021-07-12','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2021-08-12','YYYY-MM-DD HH24:MI:SS'),2,2,4);
INSERT INTO INCHIRIERE(PK_INCHIRIERE,DATA_INCHIRIERE,DATE_RETUR,FK_ALBUM,FK_ANGAJAT,FK_CLIENT) VALUES (sequence_inchiriere.nextval,TO_TIMESTAMP('2021-07-14','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2021-08-12','YYYY-MM-DD HH24:MI:SS'),3,1,2);
INSERT INTO INCHIRIERE(PK_INCHIRIERE,DATA_INCHIRIERE,DATE_RETUR,FK_ALBUM,FK_ANGAJAT,FK_CLIENT) VALUES (sequence_inchiriere.nextval,TO_TIMESTAMP('2021-07-16','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2021-08-12','YYYY-MM-DD HH24:MI:SS'),6,4,1);
INSERT INTO INCHIRIERE(PK_INCHIRIERE,DATA_INCHIRIERE,DATE_RETUR,FK_ALBUM,FK_ANGAJAT,FK_CLIENT) VALUES (sequence_inchiriere.nextval,TO_TIMESTAMP('2021-07-16','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2021-08-12','YYYY-MM-DD HH24:MI:SS'),1,4,1);
INSERT INTO INCHIRIERE(PK_INCHIRIERE,DATA_INCHIRIERE,DATE_RETUR,FK_ALBUM,FK_ANGAJAT,FK_CLIENT) VALUES (sequence_inchiriere.nextval,TO_TIMESTAMP('2021-07-16','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2021-08-12','YYYY-MM-DD HH24:MI:SS'),5,4,5);
INSERT INTO INCHIRIERE(PK_INCHIRIERE,DATA_INCHIRIERE,DATE_RETUR,FK_ALBUM,FK_ANGAJAT,FK_CLIENT) VALUES (sequence_inchiriere.nextval,TO_TIMESTAMP('2021-07-18','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2021-08-12','YYYY-MM-DD HH24:MI:SS'),3,5,5);

select *from inchiriere;

--11
----
-- Angajatii si numarul de albume inchiriate, pe zile, ordonate descrescator dupa numarul de albume si crescator dupa data
select
    UPPER(CONCAT(ang.nume,CONCAT(' ',ang.prenume))) as "angajat",
    TRUNC(i.data_inchiriere) as "data_inchiriere",
    COUNT(DISTINCT alb.pk_album)
from angajat ang
inner join inchiriere i on ang.pk_angajat = i.fk_angajat
inner join album alb on i.fk_album = alb.pk_album
group by UPPER(CONCAT(ang.nume,CONCAT(' ',ang.prenume))), TRUNC(i.data_inchiriere)
order by 3 desc, 2 ASC


--Albumele inchiriate (impreuna cu artistul albumului si angajatul care a inchiriat albumul), returnate sau in stadiu de inchiriate, care s-au si vandut (se afiseaza data vanzarii) sau nevandute (se afiseaza FARA VANAZARE)
select
    alb.nume as "album",
    art.nume as "artist",
    vanz."nume_angajat",
    DECODE(i.date_retur,NULL,'RETURNAT','INCHIRIAT') as "status",
    NVL(TO_CHAR(vanz.data_vanzare, 'dd-MON-yy'),'FARA VANZARE') as "data_vanzare"
from album alb
inner join artist art on alb.fk_artist = art.pk_artist
inner join inchiriere i on alb.pk_album = i.fk_album
left join (
    select 
        v.pk_vanzare, 
        a.pk_album, 
        v.data_vanzare,
        ang.nume as "nume_angajat"
    from vanzare v
    inner join album a on v.fk_album = a.pk_album
    inner join angajat ang on v.fk_angajat = ang.pk_angajat
    where UPPER(ang.nume) LIKE '%ESCU'
) vanz on alb.pk_album = vanz.pk_album
WHERE to_char(vanz.data_vanzare,'YYYY') = '2021';


-- Albumele artistilor din SUA si pretul maxim al unui album cu acelasi artist 
WITH MaxPretAlbumPeArtist
AS (
	SELECT 
        art.pk_artist, 
        t.nume as "nume_tara", 
        art.nume as "nume_artist", 
        MAX(alb.pret_vanzare) as "Maxim"
	FROM album alb
    INNER JOIN artist art on alb.fk_artist = art.pk_artist
    INNER JOIN tara t on art.fk_tara = t.pk_tara
	GROUP BY art.pk_artist, t.nume, art.nume
)
SELECT DISTINCT 
    alb.nume as "album",
    MaxPretAlbumPeArtist."Maxim" || ' LEI' as "pret maxim artist"
FROM album alb
INNER JOIN MaxPretAlbumPeArtist ON alb.fk_artist = MaxPretAlbumPeArtist.pk_artist
WHERE SUBSTR(MaxPretAlbumPeArtist."nume_tara",1,3) = 'SUA'
ORDER BY alb.nume ASC;


-- Daca exista albume mai scumpe de 250 lei si mai noi de anul 1985, se afiseaza albumul, daca nu, toate albumele tip vinyl
IF ( 250 < ANY ( SELECT alb.pret_vanzare
					FROM album alb 
                    WHERE alb.an >= 1985 ) )
THEN
      SELECT alb.nume as "album", alb.an, art.nume as "artist", ta.nume "tip_album", alb.pret_vanzare
	  FROM album alb
      INNER JOIN artist art on alb.fk_artist = art.pk_artist
      INNER JOIN tip_album ta on alb.fk_tip_album = ta.pk_tip_album
	  WHERE alb.an >= 1985 AND alb.pret_vanzare > 250 ;
ELSE 
      SELECT alb.nume as "album", alb.an, art.nume as "artist", ta.nume "tip_album", alb.pret_vanzare
	  FROM album alb
      INNER JOIN artist art on alb.fk_artist = art.pk_artist
      INNER JOIN tip_album ta on alb.fk_tip_album = ta.pk_tip_album
	  WHERE UPPER(ta.nume) LIKE 'VINYL';
END IF;


--Artistii (si originea acestora: SUA, Europa) si numarul de albume vandute pentru cei care au mai mult de 1 album vandut
select
    a.nume as "artist",
    a."origine",
    count(v.fk_album) as "nr.albume vandute"
from (
    select
        art.pk_artist,
        art.nume,
        case to_char(t.nume)
            when 'SUA' then to_char('SUA')
            else to_char('Europa') 
            end as "origine"
    from artist art
    inner join tara t on art.fk_tara = t.pk_tara
) a
inner join album alb on a.pk_artist = alb.fk_artist
inner join vanzare v on alb.pk_album = v.fk_album
group by a.nume, a."origine"
having count(v.fk_album) > 1

--16
----
--Extragerea tuturor albumelor (cu detalii despre casa de discuri si tipurile de album), a clientilor si a inchirierilor (fie ca albumele au fost inchiriate sau nu)
select 
    alb.nume,
    alb.an,
    cd.nume as "casa_discuri",
    ta.nume as "tip_album",
    CONCAT(alb.pret_inchiriere , ' lei'),
    i.data_inchiriere,
    i.date_retur,
    i.discount,
    i.penalitati,
    CONCAT(c.nume , c.prenume) as "client",
    c.are_card_fidelitate
from album alb
full outer join casa_discuri cd on alb.fk_casa_discuri = cd.pk_casa_discuri
full outer join tip_album ta on alb.fk_tip_album = ta.pk_tip_album
full outer join inchiriere i on alb.pk_album = i.fk_album
full outer join client c on i.fk_client=c.pk_client;

--Extragerea detaliilor despre toate albumele inchiriate, mai putin cele care s-au si vandut intre timp
select 
    alb.nume,
    alb.an,
    ta.nume as "tip_album",
    i.data_inchiriere as "data"
from album alb
inner join tip_album ta on alb.fk_tip_album = ta.pk_tip_album
inner join inchiriere i on alb.pk_album = i.fk_album
MINUS
select 
    alb.nume,
    alb.an,
    ta.nume as "tip_album",
    v.data_vanzare as "data"
from album alb
inner join tip_album ta on alb.fk_tip_album = ta.pk_tip_album
inner join vanzare v on alb.pk_album = v.fk_album;

--Extragerea detaliilor despre clientii care au inchiriat albume, mai putin cei care au inchiriat acelasi album de mai mult de doua ori 
select
    c.nume,
    c.prenume,
    c.telefon,
    LISTAGG(i.data_inchiriere,',') WITHIN GROUP ( ORDER BY c.nume, c.prenume )
from client c
inner join inchiriere i on c.pk_client = i.fk_client
group by c.nume, c.prenume, c.telefon
MINUS
select
    c.nume,
    c.prenume,
    c.telefon,
    LISTAGG(i.data_inchiriere,',') WITHIN GROUP ( ORDER BY c.nume, c.prenume )
from client c
inner join inchiriere i on c.pk_client = i.fk_client
inner join album alb on i.fk_album = alb.pk_album
group by c.nume, c.prenume, c.telefon
having count(alb.nume) > 2;


