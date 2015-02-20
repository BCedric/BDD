DROP TRIGGER trig_maj_moy;


DROP TABLE Inscrip_evt;
DROP TABLE Inscrip_parcours;
DROP TABLE Compo_parcours;
DROP TABLE Parcours;
DROP TABLE Avis;
DROP TABLE Achats;
DROP TABLE Livres;
DROP TABLE Clients;





CREATE TABLE Clients(
          idcl number, 
					nom varchar2(20), 
					pren varchar2(15), 
					adr varchar2(30), 
					tel varchar2(12),
					CONSTRAINT clients_pk PRIMARY KEY (idcl));
					
--CREATE SEQUENCE maSequence START WITH 1 INCREMENT BY 1; //L'utilisation de la séquence crée des erreurs car l'idcl 
--est référencé en clé étrangère dans la table Avis, c'est pourquoi elle n'est pas utilisée ici
					
CREATE TABLE Livres(
          refl varchar2(10), 
					titre varchar2(50), 
					auteur varchar2(20), 
					genre varchar2(15),
					CONSTRAINT livres_pk PRIMARY KEY (refl));
					
CREATE TABLE Achats(
          idcl number, 
					refl varchar2(10), 
					dateachat date check(dateachat between to_date('01-01-2008', 'DD-MM-YYYY') and to_date('31-12-2020', 'DD-MM-YYYY')) not null,
					CONSTRAINT achats_pk PRIMARY KEY (dateachat, refl, idcl),
					CONSTRAINT achats_pf1 FOREIGN KEY (refl) REFERENCES Livres(refl),
					CONSTRAINT achats_pf2 FOREIGN KEY (idcl) REFERENCES Clients(idcl));
					
CREATE TABLE Avis(
          idcl number, 
					refl varchar2(10), 
					note number(4,2),
					commentaire varchar2(50),
					CONSTRAINT avis_pk PRIMARY KEY (refl, idcl),
					CONSTRAINT avis_pf1 FOREIGN KEY (refl) REFERENCES Livres(refl),
					CONSTRAINT avis_pf2 FOREIGN KEY (idcl) REFERENCES Clients(idcl));
          
CREATE TABLE Parcours(
          idp varchar2(10), 
          intitulep varchar2(45), 
          genre varchar2(15), 
          date_deb date,
          CONSTRAINT parcours_pk PRIMARY KEY (idp));
          
CREATE TABLE Compo_parcours(
          idp varchar2(10), 
          id_evt varchar2(10),
          CONSTRAINT compo_pk PRIMARY KEY (idp,id_evt),
          CONSTRAINT compo_pf1 FOREIGN KEY (idp) REFERENCES Parcours(idp));
          
CREATE TABLE Inscrip_parcours(
          idcl number, 
          idp varchar2(10),
          CONSTRAINT inscrip_pk PRIMARY KEY (idcl,idp),
          CONSTRAINT inscrip_pf1 FOREIGN KEY (idp) REFERENCES Parcours(idp),
          CONSTRAINT inscrip_pf2 FOREIGN KEY (idcl) REFERENCES Clients(idcl));

CREATE TABLE Inscrip_evt(
          idcl number, 
          idp varchar2(10), 
          id_evt varchar2(10),
          CONSTRAINT Inscrip_evt_pk PRIMARY KEY (idcl,idp, id_evt),
          CONSTRAINT Inscrip_evt_fk1 FOREIGN KEY (idp, id_evt) REFERENCES Compo_parcours(idp, id_evt),
          CONSTRAINT Inscrip_evt_fk2 FOREIGN KEY (idcl) REFERENCES Clients(idcl));
					
INSERT INTO Clients VALUES ('00', 'Dupont', 'Francis', '18 rue du la pendaison', '0614562312');
INSERT INTO Clients VALUES ('01', 'Huster', 'Francis', '20 rue du la pendaison', '0685749645');
INSERT INTO Clients VALUES ('02', 'Colonel', 'Moutarde', '22 rue du la pendaison', '0678126345');

INSERT INTO Livres VALUES ('AA', 'Le chat du rabin', 'Joann Sfar', 'BD');
INSERT INTO Livres VALUES ('AB', 'Les Bidochons', 'Christian Binet', 'BD');
INSERT INTO Livres VALUES ('AC', 'Le petit prince', 'Saint-Exupery', 'fantastique');
INSERT INTO Livres VALUES ('AD', 'La mecanique du coeur', 'Mattias Malhzieu', 'fantastique');
INSERT INTO Livres VALUES ('AE', 'Le guide d entretien de mon vélo', 'Peter Drinkell', 'cyclisme');
INSERT INTO Livres VALUES ('AF', '100 ans de cyclisme', 'Abel Michea', 'cyclisme');

INSERT INTO Achats VALUES ('00', 'AB', TO_DATE('01-01-2011','DD-MM-YYYY'));
INSERT INTO Achats VALUES ('00', 'AD', TO_DATE('01-02-2009','DD-MM-YYYY'));
INSERT INTO Achats VALUES ('01', 'AA', TO_DATE('12-06-2013','DD-MM-YYYY'));
INSERT INTO Achats VALUES ('01', 'AD', TO_DATE('05-07-2009','DD-MM-YYYY'));
INSERT INTO Achats VALUES ('01', 'AC', TO_DATE('05-07-2010','DD-MM-YYYY'));
INSERT INTO Achats VALUES ('02', 'AB', TO_DATE('25-06-2012','DD-MM-YYYY'));
INSERT INTO Achats VALUES ('02', 'AC', TO_DATE('25-06-2012','DD-MM-YYYY'));


INSERT INTO Avis VALUES('00', 'AD', '18', 'Super livre');
INSERT INTO Avis VALUES('01', 'AD', '15', 'Chouette');
INSERT INTO Avis VALUES('01', 'AA', '12', 'Bof');

INSERT INTO Parcours VALUES('AA','de santé', 'médecine',TO_DATE('25-06-2012','DD-MM-YYYY'));
INSERT INTO Parcours VALUES('AB','Parcours du tour de France', 'cyclisme',TO_DATE('25-06-2017','DD-MM-YYYY'));
INSERT INTO Parcours VALUES('AC','du combattant', 'militaire',TO_DATE('25-06-2015','DD-MM-YYYY'));
INSERT INTO Parcours VALUES('AD','Parcours du monde', 'cyclisme',TO_DATE('25-07-2015','DD-MM-YYYY'));

INSERT INTO Compo_parcours VALUES ('AA','AA');
INSERT INTO Compo_parcours VALUES ('AA','AB');
INSERT INTO Compo_parcours VALUES ('AA','AC');
INSERT INTO Compo_parcours VALUES ('AA','AD');
INSERT INTO Compo_parcours VALUES ('AB','AE');
INSERT INTO Compo_parcours VALUES ('AB','AF');
INSERT INTO Compo_parcours VALUES ('AB','AG');
INSERT INTO Compo_parcours VALUES ('AB','AH');
INSERT INTO Compo_parcours VALUES ('AC','AI');
INSERT INTO Compo_parcours VALUES ('AC','AJ');
INSERT INTO Compo_parcours VALUES ('AC','AK');
INSERT INTO Compo_parcours VALUES ('AC','AL');
INSERT INTO Compo_parcours VALUES ('AD','AM');
INSERT INTO Compo_parcours VALUES ('AD','AN');
INSERT INTO Compo_parcours VALUES ('AD','AO');
INSERT INTO Compo_parcours VALUES ('AD','AP');



---------------------------------------------------------------------------------------------------




ALTER TABLE Achats ADD prix number;		
--création de la colonne Prix

--Remplissage de la colonne Prix créée précédemment
UPDATE Achats SET prix='20' WHERE refl = 'AA';	
UPDATE Achats SET prix='16' WHERE refl = 'AB';
UPDATE Achats SET prix='13' WHERE refl = 'AC';
UPDATE Achats SET prix='17' WHERE refl = 'AD';

ALTER TABLE Livres ADD note_moy number;


-------------------------------------------Mise à jour de la moyenne ---------------------------------------------
--Q1)

/*
SET serveroutput ON;
DECLARE
  id_livre Livres.refl%TYPE;
  moy Livres.note_moy%TYPE;
  pas_de_livre EXCEPTION;
BEGIN
  id_livre:='&refl';
  SELECT AVG(note) INTO moy
  FROM Avis
  WHERE refl=id_livre;
  
  
  IF moy IS NULL then RAISE pas_de_livre;
  ELSE
    UPDATE Livres SET note_moy=moy WHERE refl=id_livre;
  END IF;
  
EXCEPTION
  WHEN pas_de_livre THEN
  dbms_output.put_line('pas de livre');
END;
/


SELECT * FROM Livres;
*/


DECLARE
  CURSOR c1 is SELECT refl, AVG(note) as M FROM Avis GROUP BY refl;
  ligne c1%ROWTYPE;
BEGIN
  FOR ligne IN c1 LOOP
    UPDATE Livres SET note_moy=ligne.M WHERE refl=ligne.refl;
  END LOOP;
END;
/

--SELECT * FROM Livres;


CREATE OR REPLACE PROCEDURE maj_moy

IS
  CURSOR c1 is SELECT refl, AVG(note) as M FROM Avis GROUP BY refl;
  ligne c1%ROWTYPE;
BEGIN
  FOR ligne IN c1 LOOP
    UPDATE Livres SET note_moy=ligne.M WHERE refl=ligne.refl;
  END LOOP;
END;
/

--EXECUTE maj_moy;


--SELECT * FROM Livres;

/*
SET serveroutput ON;
CREATE OR REPLACE TRIGGER trig_maj_moy
  AFTER INSERT OR UPDATE
  ON Avis
  FOR EACH ROW
DECLARE
  moy Avis.note%TYPE;
BEGIN
  SELECT AVG(note) INTO moy
  FROM Avis
  WHERE Avis.idcl=:NEW.idcl;
  UPDATE Livres SET note_moy=moy WHERE Livres.refl=:NEW.refl;
END;
/

INSERT INTO Avis VALUES ('02','AC','15', 'Très beau' );
SELECT * FROM Livres;
*/
--Ce trigger donne une erreur à l'execution car il fait un SELECT sur une table qui est en train d'être modifiée.


-----------------------------------------------Cohérence avis-achat--------------------------------------
--Q1)

SET serveroutput ON;
CREATE OR REPLACE TRIGGER avis_achat
  BEFORE INSERT
  ON Avis
  FOR EACH ROW
DECLARE
  res Achats.refl%TYPE;
  exception_error EXCEPTION;
BEGIN
  SELECT DISTINCT COUNT(refl) INTO res
  FROM Achats
  WHERE Achats.idcl=:NEW.idcl
  AND Achats.refl=:NEW.refl;
  IF res=0 THEN 
    RAISE exception_error;
  END IF;
EXCEPTION
  WHEN exception_error THEN
  RAISE_APPLICATION_ERROR(-20001,'Le livre n a pas été acheté par l utilisateur');
END;
/

--INSERT INTO Avis VALUES('02','AD','15', 'Très beau' );

--SELECT * FROM Avis;

 
--Q2)

CREATE OR REPLACE TRIGGER maj_avis
  BEFORE UPDATE
  ON Avis
  FOR EACH ROW
DECLARE
  error_maj_avis EXCEPTION;
BEGIN
  IF (:NEW.idcl!=:OLD.idcl) THEN RAISE error_maj_avis;
  END IF;
EXCEPTION
  WHEN error_maj_avis THEN
    RAISE_APPLICATION_ERROR(-20001,'L utilisateur qui modifie le tuple n a pas le droit');
END;
/

--UPDATE Avis SET note = '12' WHERE idcl='00' AND refl='AD';
--UPDATE Avis SET idcl='01' WHERE idcl='00' AND refl='AD';

SELECT * FROM Avis;




-------------------------------------------Traitement d'une inscription à un parcours-------------------------------------------
--Q1)
SET serveroutput ON;
CREATE OR REPLACE PROCEDURE inscrip_clt(idcl IN number, 
                                        idpp IN varchar2)
IS
  CURSOR c1 IS SELECT idp,id_evt FROM Compo_parcours WHERE Compo_parcours.idp=idpp;
  ligne c1%ROWTYPE;
BEGIN
  INSERT INTO Inscrip_parcours VALUES(idcl,idpp);
  FOR ligne IN c1 LOOP
    INSERT INTO Inscrip_evt VALUES(idcl,ligne.idp,ligne.id_evt);
  END LOOP;
END;
/

--EXECUTE inscrip_clt('00','AA');
--SELECT * FROM Inscrip_parcours;
--SELECT * FROM Inscrip_evt;
--SELECT * FROM Compo_parcours;
--INSERT INTO Inscrip_evt VALUES('00','AA','AC');

--Q2)

SET serveroutput ON;
CREATE OR REPLACE TRIGGER achats_parcours
  AFTER INSERT
  ON Achats
  FOR EACH ROW
DECLARE
  CURSOR c1 IS SELECT refl,Parcours.intitulep, Parcours.genre  
                FROM (SELECT refl, genre as g FROM Livres WHERE refl=:NEW.refl) INNER JOIN Parcours ON g=Parcours.genre;
  ligne c1%ROWTYPE;
BEGIN
  dbms_output.put_line('Ces parcours peuvent vous intéresser :');
  FOR ligne in c1 LOOP
    dbms_output.put_line(ligne.intitulep);
  END LOOP;
END;
/

--INSERT INTO Achats VALUES('02','AE', TO_DATE('01-01-2011','DD-MM-YYYY'), '15');





