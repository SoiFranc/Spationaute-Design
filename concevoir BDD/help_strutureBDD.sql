/*-----------------Creation de la DATABASE-----------------*/
/*DROP DATABASE IF EXISTS historisationCND;*/
/*-----------------------------------------------------------------------------------------------*/
/*-----------------------------------------------------------------------------------------------*/

/*-----------------Creation de la DATABASE-----------------*/
CREATE DATABASE IF NOT EXISTS historisationCND;
ALTER DATABASE historisationCND charset = UTF8;
/*-----------------------------------------------------------------------------------------------*/
/*-----------------------------------------------------------------------------------------------*/

/*-----------------Création de la Table Tranches sur la BDD historisationcnd-----------------*/
USE historisationCND;

DROP TABLE IF EXISTS Tranches;
CREATE TABLE Tranches(
	idTranche INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	numTranche INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

DROP TABLE IF EXISTS Zones;
CREATE TABLE Zones(
	idZone INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nomZone VARCHAR(50) NOT NULL,
    idTranche INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

DROP TABLE IF EXISTS Interventions;
CREATE TABLE Interventions(
	idIntervention INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nomIntervention VARCHAR(50) NOT NULL,
    conclusionIntervention TEXT NOT NULL,
    decision VARCHAR(50) NOT NULL,
    dateIntervention date NOT NULL,
    idDefaut INT NOT NULL,
    idZone INT NOT NULL,
    idSalarie INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

DROP TABLE IF EXISTS Defauts;
CREATE TABLE Defauts(
	idDefaut INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	longueurDefaut FLOAT NOT NULL DEFAULT '0',
    largeurDefaut FLOAT NOT NULL DEFAULT '0',
    profondeurDefaut FLOAT NOT NULL DEFAULT '0',
    doitEtreRemplace BOOL NOT NULL,
    referenceAcceptable VARCHAR(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

DROP TABLE IF EXISTS RapportsIntervention;
CREATE TABLE RapportsIntervention(
	idRapportIntervention INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nomRapportIntervention VARCHAR(50) NOT NULL,
    dateRapport date NOT NULL,
    dateControle date NOT NULL,
    dateVerification date NOT NULL,
    idIntervention INT NOT NULL,
    idSalarie_Chef INT NOT NULL,
    idSalarie_Technicien INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

DROP TABLE IF EXISTS Entreprises;
CREATE TABLE Entreprises(
	idEntreprise INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nomEntreprise VARCHAR(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

DROP TABLE IF EXISTS Salaries;
CREATE TABLE Salaries(
	idSalarie INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nomSalarie VARCHAR(50) NOT NULL,
    idEntreprise INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

DROP TABLE IF EXISTS Chefs;
CREATE TABLE IF NOT EXISTS Chefs(
	idSalarie_Chef INT NOT NULL,
	nomSalarie VARCHAR(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

DROP TABLE IF EXISTS Techniciens;
CREATE TABLE IF NOT EXISTS Techniciens(
	idSalarie_Technicien INT NOT NULL,
	nomSalarie VARCHAR(50) NOT NULL,
    typeSpecialisation VARCHAR(50) NOT NULL,
    idSalarie_Chef INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET = UTF8;
/*-----------------------------------------------------------------------------------------------*/
/*-----------------------------------------------------------------------------------------------*/

/*-----------------Les contraintes clés primaire des Tables-----------------
--Pour cela on modifie la structure de la table avec ALTER----
ALTER TABLE <nomtable>
ADD CONSTRAINT pk_nomTable PRIMARY KEY(idBlabla);

/*-----------------ainsi de suite pour toutes les clés primaires-----------------* /
ALTER TABLE Tranches
ADD CONSTRAINT pk_Tranches PRIMARY KEY(idTranche);

ALTER TABLE Tranches MODIFY COLUMN idTranche INT NOT NULL AUTO_INCREMENT;

ALTER TABLE Zones
ADD CONSTRAINT pk_Zones PRIMARY KEY(idZone);

ALTER TABLE Zones MODIFY COLUMN idZone INT NOT NULL AUTO_INCREMENT;

ALTER TABLE Interventions
ADD CONSTRAINT pk_Interventions PRIMARY KEY(idIntervention);

ALTER TABLE Interventions MODIFY COLUMN idIntervention INT NOT NULL AUTO_INCREMENT;

ALTER TABLE Defauts
ADD CONSTRAINT pk_Defauts PRIMARY KEY(idDefaut);

ALTER TABLE Defauts MODIFY COLUMN idDefaut INT NOT NULL AUTO_INCREMENT;

ALTER TABLE RapportsIntervention
ADD CONSTRAINT pk_RapportsIntervention PRIMARY KEY(idRapportIntervention);

ALTER TABLE RapportsIntervention MODIFY COLUMN idRapportIntervention INT NOT NULL AUTO_INCREMENT;

ALTER TABLE Entreprises
ADD CONSTRAINT pk_Entreprises PRIMARY KEY(idEntreprise);

ALTER TABLE Entreprises MODIFY COLUMN idEntreprise INT NOT NULL AUTO_INCREMENT;
*/
ALTER TABLE Salaries
ADD CONSTRAINT pk_Salaries PRIMARY KEY(idSalarie);
ALTER TABLE Salaries MODIFY COLUMN idSalarie INT NOT NULL AUTO_INCREMENT;
ALTER TABLE Chefs
ADD CONSTRAINT pk_Salaries PRIMARY KEY(idSalarie_Chef);
ALTER TABLE Techniciens
ADD CONSTRAINT pk_Salaries PRIMARY KEY(idSalarie_Technicien);
/*-----------------------------------------------------------------------------------------------*/
/*-----------------------------------------------------------------------------------------------*/

/*--------------Les contraintes clés Etrangère des Tables-----------
---On veut créer une relation entre une table et une autre table via leurs champs qui se lient  
--Pour cela il me faut le champs qui sert de clé etrangère (identifiant sa table) 
--Donc on modifie la structure de la table (qui accueille la clé etrangere) et  on déclare la clé etrangere (nommé par convention) 
--Et indiquer quel champ il pointe (REFERENCES) sur la table mère ----
------ALTER TABLE <nomtableAccueuillanteFK>
------ADD CONSTRAINT fk_nomInventéFK FOREIGN KEY (idBlabla) REFERENCES TableMère(idBlabla)

---ainsi de suite pour toutes les clés etrangere----*/
ALTER TABLE Zones
ADD CONSTRAINT fk_Zones_Tranches FOREIGN KEY(idTranche) REFERENCES Tranches(idTranche);

ALTER TABLE Interventions
ADD CONSTRAINT fk_Interventions_Zones FOREIGN KEY (idZone) REFERENCES Tranches(idZone),
ADD CONSTRAINT fk_Interventions_Defauts FOREIGN KEY (idDefaut) REFERENCES Defauts(idDefaut),
ADD CONSTRAINT fk_Interventions_Salaries FOREIGN KEY (idSalarie) REFERENCES Techniciens(idSalarie);

ALTER TABLE Salaries
ADD CONSTRAINT fk_Salaries_Entreprises FOREIGN KEY (idEntreprise) REFERENCES Entreprises(idEntreprise);

ALTER TABLE Techniciens
ADD CONSTRAINT fk_Techniciens_Chefs FOREIGN KEY (idSalarie_Chef) REFERENCES Chefs(idSalarie_Chef);

ALTER TABLE RapportsIntervention
ADD CONSTRAINT fk_RapportsIntervention_Interventions FOREIGN KEY (idIntervention) REFERENCES Interventions(idIntervention),
ADD CONSTRAINT fk_RapportsIntervention_Chefs FOREIGN KEY (idSalarie_Chef) REFERENCES Chefs(idSalarie_Chef),
ADD CONSTRAINT fk_RapportsIntervention_Techniciens FOREIGN KEY (idSalarie_Technicien) REFERENCES Techniciens(idSalarie_Technicien);
/*-----------------------------------------------------------------------------------------------*/
/*-----------------------------------------------------------------------------------------------*/

/*-----Ajout colonnes exemple dateTime currentTimeStamp-------*/
/*Exemple Ajout sur les tables RapportsIntervention et Interventions */
ALTER TABLE `RapportsIntervention` 
    ADD `dateCreation` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP /*AFTER `idSalarie`*/, 
    ADD `dateUpdate` DATETIME on update CURRENT_TIMESTAMP NULL/* AFTER `dateCreation`*/;

ALTER TABLE `interventions` 
    ADD `dateCreation` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP/* AFTER `idSalarie`*/, 
    ADD `dateUpdate` DATETIME on update CURRENT_TIMESTAMP NULL/* AFTER `dateCreation`*/;

/*-----------------------------------------------------------------------------------------------*/
/*-----------------------------------------------------------------------------------------------*/