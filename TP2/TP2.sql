Spool TP2.log

---------------------EXTRAIT FICHIER DU TP1-----------------------------------------------------------------
DROP TABLE Avis;
DROP TABLE Achats;
DROP TABLE Livres;
DROP TABLE Clients;



CREATE TABLE Clients(idcl number, 
					nom varchar2(20), 
					pren varchar2(15), 
					adr varchar2(30), 
					tel varchar2(12),
					CONSTRAINT clients_pk PRIMARY KEY (idcl));
					
--CREATE SEQUENCE maSequence START WITH 1 INCREMENT BY 1; //L'utilisation de la séquence crée des erreurs car l'idcl 
--est référencé en clé étrangère dans la table Avis, c'est pourquoi elle n'est pas utilisée ici
					
CREATE TABLE Livres(refl varchar2(10), 
					titre varchar2(30), 
					auteur varchar2(20), 
					genre varchar2(15),
					CONSTRAINT livres_pk PRIMARY KEY (refl));
					
CREATE TABLE Achats(idcl number, 
					refl varchar2(10), 
					dateachat date check(dateachat between to_date('01-01-2008', 'DD-MM-YYYY') and to_date('31-12-2013', 'DD-MM-YYYY')) not null,
					CONSTRAINT achats_pk PRIMARY KEY (dateachat, refl, idcl),
					CONSTRAINT achats_pf1 FOREIGN KEY (refl) REFERENCES Livres(refl),
					CONSTRAINT achats_pf2 FOREIGN KEY (idcl) REFERENCES Clients(idcl));
					
CREATE TABLE Avis(idcl number, 
					refl varchar2(10), 
					note number(4,2),
					commentaire varchar2(50),
					CONSTRAINT avis_pk PRIMARY KEY (refl, idcl),
					CONSTRAINT avis_pf1 FOREIGN KEY (refl) REFERENCES Livres(refl),
					CONSTRAINT avis_pf2 FOREIGN KEY (idcl) REFERENCES Clients(idcl));
					
INSERT INTO Clients VALUES ('00', 'Dupont', 'Francis', '18 rue du la pendaison', '0614562312');
INSERT INTO Clients VALUES ('01', 'Huster', 'Francis', '20 rue du la pendaison', '0685749645');
INSERT INTO Clients VALUES ('02', 'Colonel', 'Moutarde', '22 rue du la pendaison', '0678126345');

INSERT INTO Livres VALUES ('AA', 'Le chat du rabin', 'Joann Sfar', 'BD');
INSERT INTO Livres VALUES ('AB', 'Les Bidochons', 'Christian Binet', 'BD');
INSERT INTO Livres VALUES ('AC', 'Le petit prince', 'Saint-Exupery', 'fantastique');
INSERT INTO Livres VALUES ('AD', 'La mecanique du coeur', 'Mattias Malhzieu', 'fantastique');

INSERT INTO Achats VALUES ('00', 'AB', TO_DATE('01-01-2011','DD-MM-YYYY'));
INSERT INTO Achats VALUES ('00', 'AD', TO_DATE('01-02-2009','DD-MM-YYYY'));
INSERT INTO Achats VALUES ('01', 'AA', TO_DATE('12-06-2013','DD-MM-YYYY'));
INSERT INTO Achats VALUES ('01', 'AD', TO_DATE('05-07-2009','DD-MM-YYYY'));
INSERT INTO Achats VALUES ('01', 'AC', TO_DATE('05-07-2010','DD-MM-YYYY'));
INSERT INTO Achats VALUES ('02', 'AB', TO_DATE('25-06-2012','DD-MM-YYYY'));



INSERT INTO Avis VALUES('00', 'AD', '18', 'Super livre');
INSERT INTO Avis VALUES('01', 'AD', '15', 'Chouette');
INSERT INTO Avis VALUES('01', 'AA', '12', 'Bof');
INSERT INTO Avis VALUES('02', 'AB', '12', '');

---------------------------------------------------------------------------------------------------

--question 2 et 3: Le script permettant de créer le fichier contenant les lignes supprimant les table se trouve dans le fichier 
--effacerScript.sql. Ce script génère le fichier efface.sql

--question 4 : Le script choisi permet d'éditer un fichier sql qui va afficher toutes les tables de la base de données. 
--Ce script se trouve dans le fichier SelectScript.sql. Il génère le fichier select.sql.

--question 5
ALTER TABLE Achats ADD prix number;		
--création de la colonne Prix

--Remplissage de la colonne Prix créée précédemment
UPDATE Achats SET prix='20' WHERE refl = 'AA';	
UPDATE Achats SET prix='16' WHERE refl = 'AB';
UPDATE Achats SET prix='13' WHERE refl = 'AC';
UPDATE Achats SET prix='17' WHERE refl = 'AD';
Spool off

--question 6 : voir fichier q6TP2.sql












