IF NOT EXISTS(SELECT name FROM master.dbo.sysdatabases WHERE name = 'SpationauteDesignBDD')
BEGIN
CREATE DATABASE SpationauteDesignBDD;
END;
GO

USE SpationauteDesignBDD
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Couts]') AND type in (N'U'))
BEGIN
CREATE TABLE Couts(
   idCout INT IDENTITY(1,1) PRIMARY KEY,
   catCout VARCHAR (20) NOT NULL DEFAULT 'RH',
   dateCout DATE NOT NULL,
   descriptionCout VARCHAR (250) NOT NULL,
   MontantCout MONEY NOT NULL,
   idProjet INT,
   CHECK (catCout in ('RH','Materiaux','Frais','Charges','Divers')) 
);
END;
GO

CREATE TABLE Taches(
   idTache INT IDENTITY(1,1) PRIMARY KEY,
   numTache VARCHAR(20) NOT NULL,
   nameTache VARCHAR(20) NOT NULL,
   descriptionTache VARCHAR(1500) NOT NULL,
   prioTache VARCHAR(20) NOT NULL DEFAULT 'Vitale',
   stateTache VARCHAR(20) NOT NULL DEFAULT 'Idee',
   categoryTache VARCHAR(20) NOT NULL DEFAULT 'Initialisation',
   dateCreateTache DATE NOT NULL,
   dateInProgressTache DATE,
   dateToTestTache DATE,
   dateEndThTache DATE,
   dateEndRealTache DATE,
   idProjet INT,
   CHECK (prioTache in ('Vitale','Importante','Utile','Confort')),
   CHECK (stateTache in ('Idee', 'Creer','EnCours','ATester','Terminer','Annuler')),
   CHECK (categoryTache in ('Initialisation','Analyse','Conception','Realisation','Exploitation'))
);
GO

CREATE TABLE TVA(
   idTVA INT IDENTITY(1,1) PRIMARY KEY,
   tauxTVA DECIMAL(5,2) NOT NULL
);
GO

CREATE TABLE Utilisateurs(
   idUtilisateur INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
   firstname VARCHAR(20) NOT NULL,
   name VARCHAR(20) NOT NULL,
   login VARCHAR(100)  NOT NULL,
   psw VARCHAR(255)  NOT NULL UNIQUE,
   adress VARCHAR(255) NOT NULL,
   tel VARCHAR(20) NOT NULL,
   mail VARCHAR(100) NOT NULL,
   isActivate BIT DEFAULT 0
);
GO

CREATE TABLE Clients(
   idClient INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
   firstname VARCHAR(20) NOT NULL,
   name VARCHAR(20) NOT NULL,
   adress VARCHAR(255) NOT NULL,
   tel VARCHAR(20) NOT NULL,
   mail VARCHAR(100) NOT NULL,
   isActivate BIT DEFAULT 0,
   isPro BIT DEFAULT 1,
   numSiret VARCHAR(20),
   numTVAIntracom VARCHAR(20),
   codeAPE VARCHAR(10),
   nomActivitePro VARCHAR(30) NOT NULL,
   adrActivitePro VARCHAR(255) NOT NULL,
   idUtilisateur INT
);
GO

CREATE TABLE Documents(
   idDocument INT IDENTITY(1,1) PRIMARY KEY,
   catDoc  VARCHAR(20) NOT NULL DEFAULT 'Devis',
   nameDoc VARCHAR(50) NOT NULL,
   descriptionDoc TEXT,
   dateDoc DATE NOT NULL,
   pathDoc VARCHAR(256) NOT NULL,
   idProjet INT,
   idDeGeneration INT DEFAULT 0,
   CHECK (catDoc in ('Devis','Facture','Plan','Schema','ImgPhoto','Couts','Divers'))
);
GO

CREATE TABLE Devis(
   idDevis INT IDENTITY(1,1) PRIMARY KEY,
   numDev VARCHAR(50)  NOT NULL UNIQUE,
   nbJourValidity INT NOT NULL,
   nameDev VARCHAR(255)  NOT NULL,
   dateValidationDev DATE,
   type VARCHAR(20) NOT NULL DEFAULT 'Forfait',
   totalHTDev MONEY NOT NULL,
   idClient INT,
   idTVA INT,
   idDeGeneration INT,
   CHECK (type in ('QPU','Forfait'))
);
GO

CREATE TABLE Factures(
   idFacture INT IDENTITY(1,1) PRIMARY KEY,
   numFact VARCHAR(50) NOT NULL,
   nameFact VARCHAR(255) NOT NULL,
   dateAcquittalFact DATE NOT NULL,
   isAccount BIT DEFAULT 0 NOT NULL,
   typeFact VARCHAR(20) NOT NULL DEFAULT 'Forfait',
   montantHTFact MONEY NOT NULL,
   idProjet INT,
   idTVA INT,
   idDeGeneration INT,
   CHECK (typeFact in ('QPU','Forfait'))
);
GO

CREATE TABLE Projets(
   idProjet INT IDENTITY(1,1) PRIMARY KEY,
   numProj VARCHAR(50)  NOT NULL UNIQUE,
   nameProj VARCHAR(255),
   descriptionProj TEXT NOT NULL,
   dateStartProj DATE NOT NULL,
   dateEndThProj DATE NOT NULL,
   dateEndRealProj DATE,
   placeProj VARCHAR(255),
   stateAdvancementProj VARCHAR(30) NOT NULL DEFAULT 'Creer',
   CAProj MONEY NOT NULL,
   idDevis INT,
   idUtilisateur INT,
   CHECK (stateAdvancementProj in ('Creer','EnCours','Initialisation','Analyse','Conception','Exploitation','Terminer','Cloturer','Annuler'))
);
GO

CREATE TABLE LigDevQPU(
   idLigDevQPU INT IDENTITY(1,1) PRIMARY KEY,
   numLigDevQPU INT NOT NULL,
   designationLigDevQPU VARCHAR(255) NOT NULL,
   qLigDevQPU TINYINT NOT NULL,
   montantLigDevQPU MONEY NOT NULL,
   idDevis INT
);
GO

CREATE TABLE LigDevForfait(
   idLigDevForfait INT IDENTITY(1,1) PRIMARY KEY,
   numLigDevForfait INT NOT NULL,
   designationLigDevForfait VARCHAR(255) NOT NULL,
   montantLigDevForfait MONEY NOT NULL,
   idDevis INT
);
GO

CREATE TABLE LigFactForfait(
   idLigFactForfait INT IDENTITY(1,1) PRIMARY KEY,
   dateInterventionLigFactForfait DATE NOT NULL,
   numLigFactForfait INT NOT NULL,
   designationLigFactForfait VARCHAR(255) NOT NULL,
   montantLigFactForfait MONEY NOT NULL,
   idFacture INT
);
GO

CREATE TABLE LigFactQPU(
   idLigFactQPU INT IDENTITY(1,1) PRIMARY KEY,
   dateInterventionLigFactQPU DATE NOT NULL,
   numLigFactQPU INT NOT NULL,
   designationLigFactQPU VARCHAR(255) NOT NULL,
   qLigFactQPU TINYINT NOT NULL,
   montantLigFactQPU MONEY NOT NULL,
   idFacture INT
);
GO

CREATE TABLE Generateur(
   idDeGeneration INT IDENTITY(1,1) PRIMARY KEY,
   dateGenerationDoc DATE NOT NULL,
   catDoc Varchar(20) DEFAULT 'Devis' NOT NULL,
   CHECK (catDoc in ('Facture','Devis'))
);
GO

/***** Cr?ation des cl?s ?trang?res et les contraintes *****/
ALTER TABLE Clients
ADD CONSTRAINT FK_Clients_Utilisateurs FOREIGN KEY(idUtilisateur) REFERENCES Utilisateurs(IdUtilisateur);

ALTER TABLE Taches
ADD CONSTRAINT FK_Taches_Projets FOREIGN KEY (idProjet) REFERENCES Projets(idProjet);

ALTER TABLE Couts
ADD CONSTRAINT FK_Couts_Projets FOREIGN KEY(idProjet) REFERENCES Projets(idProjet);

ALTER TABLE ligFactForfait
ADD CONSTRAINT FK_ligFactForfait_Factures FOREIGN KEY(idFacture) REFERENCES Factures(idFacture);

ALTER TABLE ligFactQPU
ADD CONSTRAINT FK_ligFactQPU_Factures FOREIGN KEY(idFacture) REFERENCES Factures(idFacture);

ALTER TABLE Factures
ADD CONSTRAINT FK_Factures_Projets FOREIGN KEY(idProjet) REFERENCES Projets(idProjet),
CONSTRAINT FK_Factures_Generateur FOREIGN KEY(idDeGeneration) REFERENCES Generateur(idDeGeneration),
CONSTRAINT FK_Factures_TVA FOREIGN KEY(idTVA) REFERENCES TVA(idTVA);

ALTER TABLE Documents
ADD CONSTRAINT FK_Documents_Projets FOREIGN KEY (idProjet) REFERENCES Projets(idProjet),
CONSTRAINT FK_Documents_Generateur FOREIGN KEY (idDeGeneration) REFERENCES Generateur(idDeGeneration);

ALTER TABLE Devis
ADD CONSTRAINT FK_Devis_Clients FOREIGN KEY (idClient) REFERENCES Clients(idClient),
CONSTRAINT FK_Devis_Generateur FOREIGN KEY(idDeGeneration) REFERENCES Generateur(idDeGeneration),
CONSTRAINT FK_Devis_TVA FOREIGN KEY(idTVA) REFERENCES TVA(idTVA);

ALTER TABLE ligDevQPU
ADD CONSTRAINT FK_ligDevQPU_Devis FOREIGN KEY (idDevis) REFERENCES Devis(idDevis);

ALTER TABLE ligDevForfait
ADD CONSTRAINT FK_ligDevForfait_Devis FOREIGN KEY(idDevis) REFERENCES Devis(idDevis);

ALTER TABLE Projets
ADD CONSTRAINT FK_Projets_Devis FOREIGN KEY (idDevis) REFERENCES Devis(idDevis),
CONSTRAINT FK_Projets_Utilisateurs FOREIGN KEY(idUtilisateur) REFERENCES Utilisateurs(idUtilisateur);

GO
