

DROP DATABASE IF EXISTS SpationauteDesignBDD;
CREATE DATABASE IF NOT EXISTS SpationauteDesignBDD;
ALTER DATABASE SpationauteDesignBDD;

USE SpationauteDesignBDD;

DROP TABLE IF EXISTS Couts;
CREATE TABLE Couts(
   idCout INT IDENTITY(1,1) PRIMARY KEY,
   catCout VARCHAR (20) NOT NULL DEFAULT 'RH',
   dateCout DATE NOT NULL,
   descriptionCout VARCHAR (250) NOT NULL,
   MontantCout MONEY NOT NULL,
   idProjet INT,
   CHECK (catCout in ('RH','Materiaux','Frais','Charges','Divers')) 
);

DROP TABLE IF EXISTS Taches;
CREATE TABLE Taches(
   idTache INT IDENTITY(1,1) PRIMARY KEY,
   numTache VARCHAR(20) NOT NULL,
   nameTache VARCHAR(20) NOT NULL,
   descriptionTache VARCHAR(1500) NOT NULL,
   prioTache VARCHAR(20) NOT NULL DEFAULT 'Vitale',
   stateTache VARCHAR(20) NOT NULL DEFAULT 'Idée',
   categoryTache VARCHAR(20) NOT NULL DEFAULT 'Initialisation',
   dateCreateTache DATE NOT NULL,
   dateInProgressTache DATE,
   dateToTestTache DATE,
   dateEndThTache DATE NOT NULL,
   dateEndRealTache DATE,
   idProjet INT,
   CHECK (prioTache in ('Vitale','Importante','Utile','Confort')),
   CHECK (stateTache in ('Idée', 'Créée','EnCours','ATester','Terminée','Annulée')),
   CHECK (categoryTache in ('Initialisation','Analyse','Conception','Réalisation','Exploitation'))
);

DROP TABLE IF EXISTS TVA;
CREATE TABLE TVA(
   idTVA INT IDENTITY(1,1) PRIMARY KEY,
   tauxTVA DECIMAL(5,2) NOT NULL
);

DROP TABLE IF EXISTS Personnes;
CREATE TABLE Personnes(
   idPersonne INT IDENTITY(1,1) PRIMARY KEY,
   firstname VARCHAR(20) NOT NULL,
   name VARCHAR(20) NOT NULL,
   fonction VARCHAR(30) NOT NULL,
   adress VARCHAR(255) NOT NULL,
   tel VARCHAR(20) NOT NULL,
   mail VARCHAR(100) NOT NULL,
   isActivate BIT DEFAULT 0,
   catPerson VARCHAR(20) NOT NULL DEFAULT 'Client',
   CHECK (catPerson in ('Utilisateur','Client'))
);

DROP TABLE IF EXISTS Utilisateurs;
CREATE TABLE Utilisateurs(
   login VARCHAR(100)  NOT NULL,
   psw VARCHAR(255)  NOT NULL UNIQUE
);

DROP TABLE IF EXISTS Clients;
CREATE TABLE Clients(
   isPro BIT DEFAULT 1,
   numSiret VARCHAR(20),
   numTVAIntracom VARCHAR(20),
   codeAPE VARCHAR(10),
   nomActivitePro VARCHAR(30) NOT NULL,
   adrActivitePro VARCHAR(255) NOT NULL
);


DROP TABLE IF EXISTS Documents;
CREATE TABLE Documents(
   idDocument INT IDENTITY(1,1) PRIMARY KEY,
   catDoc  VARCHAR(20) NOT NULL DEFAULT 'Devis',
   nameDoc VARCHAR(50) NOT NULL,
   descriptionDoc TEXT,
   dateDoc DATE NOT NULL,
   pathDoc VARCHAR(256) NOT NULL,
   idProjet INT,
   idDeGeneration INT DEFAULT 0,
   CHECK (catDoc in ('Devis','Facture','Plan','Schema','ImgPhoto','Divers'))
);

DROP TABLE IF EXISTS Devis;
CREATE TABLE Devis(
   idDevis INT IDENTITY(1,1) PRIMARY KEY,
   numDev VARCHAR(50)  NOT NULL UNIQUE,
   nbJourValidity INT NOT NULL,
   nameDev VARCHAR(255)  NOT NULL,
   dateValidationDev DATE,
   type VARCHAR(20) NOT NULL DEFAULT 'Forfait',
   totalHTDev MONEY NOT NULL,
   idPersonne INT,
   idPersonneClient INT,
   idTVA INT,
   idDeGeneration INT,
   CHECK (type in ('QPU','Forfait'))
);

DROP TABLE IF EXISTS Factures;
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

DROP TABLE IF EXISTS Projets;
CREATE TABLE Projets(
   idProjet INT IDENTITY(1,1) PRIMARY KEY,
   numProj VARCHAR(50)  NOT NULL UNIQUE,
   nameProj VARCHAR(255),
   descriptionProj TEXT NOT NULL,
   dateStartProj DATE NOT NULL,
   dateEndThProj DATE NOT NULL,
   dateEndRealProj DATE,
   placeProj VARCHAR(255),
   stateAdvancementProj VARCHAR(30) NOT NULL DEFAULT 'Créé',
   CAProj MONEY NOT NULL,
   idDevis INT,
   idPersonne INT,
   idPersonneUtilisateur INT,
   CHECK (stateAdvancementProj in ('Créé','EnCours','Initialisation','Analyse','Conception','Exploitation','Terminé','Clôturé','Annulé'))
);


DROP TABLE IF EXISTS LigDevQPU;
CREATE TABLE LigDevQPU(
   idLigDevQPU INT IDENTITY(1,1) PRIMARY KEY,
   numLigDevQPU INT NOT NULL,
   designationLigDevQPU VARCHAR(255) NOT NULL,
   qLigDevQPU TINYINT NOT NULL,
   montantLigDevQPU MONEY NOT NULL,
   idDevis INT
);

DROP TABLE IF EXISTS LigDevForfait;
CREATE TABLE LigDevForfait(
   idLigDevForfait INT IDENTITY(1,1) PRIMARY KEY,
   numLigDevForfait INT NOT NULL,
   designationLigDevForfait VARCHAR(255) NOT NULL,
   montantLigDevForfait MONEY NOT NULL,
   idDevis INT
);

DROP TABLE IF EXISTS LigFactForfait;
CREATE TABLE LigFactForfait(
   idLigFactForfait INT IDENTITY(1,1) PRIMARY KEY,
   dateInterventionLigFactForfait DATE NOT NULL,
   numLigFactForfait INT NOT NULL,
   designationLigFactForfait VARCHAR(255) NOT NULL,
   montantLigFactForfait MONEY NOT NULL,
   idFacture INT
);

DROP TABLE IF EXISTS LigFactQPU;
CREATE TABLE LigFactQPU(
   idLigFactQPU INT IDENTITY(1,1) PRIMARY KEY,
   dateInterventionLigFactQPU DATE NOT NULL,
   numLigFactQPU INT NOT NULL,
   designationLigFactQPU VARCHAR(255) NOT NULL,
   qLigFactQPU TINYINT NOT NULL,
   montantLigFactQPU MONEY NOT NULL,
   idFacture INT
);

DROP TABLE IF EXISTS Generateur;
CREATE TABLE Generateur(
   idDeGeneration INT IDENTITY(1,1) PRIMARY KEY,
   dateGenerationDoc DATE NOT NULL,
   catDoc Varchar(20) DEFAULT 'Devis' NOT NULL,
   CHECK (catDoc in ('Facture','Devis'))
);

/***** Clé primaire sur héritage exclusif *****/
ALTER TABLE Utilisateurs
ADD idPersonneUtilisateur INT IDENTITY(1,1) NOT NULL,
 idPersonne INT NOT NULL,
CONSTRAINT idPersonneUtilisateur PRIMARY KEY(idPersonneUtilisateur),
CONSTRAINT FK_Utilisateurs_Personnes FOREIGN KEY(idPersonne) 
       REFERENCES Personnes(idPersonne)
       ON DELETE CASCADE;

ALTER TABLE Clients
ADD idPersonneClient INT IDENTITY(1,1) NOT NULL,
idPersonne INT NOT NULL,
idPersonneUtilisateur INT NOT NULL,
CONSTRAINT idPersonneClient PRIMARY KEY(idPersonneClient),
CONSTRAINT FK_Clients_Personnes FOREIGN KEY(idPersonne) 
       REFERENCES Personnes(idPersonne)
       ON DELETE CASCADE,
CONSTRAINT FK_Clients_Utilisateurs FOREIGN KEY(idPersonneUtilisateur) 
       REFERENCES Utilisateurs(idPersonneUtilisateur);


/***** Création des clés étrangères et les contraintes *****/

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
ADD CONSTRAINT FK_Devis_Clients FOREIGN KEY (idPersonneClient) REFERENCES Clients(idPersonneClient),
CONSTRAINT FK_Devis_Generateur FOREIGN KEY(idDeGeneration) REFERENCES Generateur(idDeGeneration),
CONSTRAINT FK_Devis_TVA FOREIGN KEY(idTVA) REFERENCES TVA(idTVA);

ALTER TABLE ligDevQPU
ADD CONSTRAINT FK_ligDevQPU_Devis FOREIGN KEY (idDevis) REFERENCES Devis(idDevis);

ALTER TABLE ligDevForfait
ADD CONSTRAINT FK_ligDevForfait_Devis FOREIGN KEY(idDevis) REFERENCES Devis(idDevis);

ALTER TABLE Projets
ADD CONSTRAINT FK_Projets_Devis FOREIGN KEY (idDevis) REFERENCES Devis(idDevis),
CONSTRAINT FK_Projets_Utilisateurs FOREIGN KEY(idPersonneUtilisateur) REFERENCES Utilisateurs(idPersonneUtilisateur);

/*
/***** Création d'un backup de la BDD nommé et daté automatiquement *****/
----1 réaliser un enregistrement de backup :
use NomBDD; (pour réaliser ces opérations, il ne faut pas se trouver sur la BDD, mais sur "master")
backup database NomBDD to disk = 'NomBDDDATE.bak'  (ce fichier est stocker dans le backup de sql server)

/* si on veut que le nommage et daté l'enregistrement backup Automatiquement*/
declare @d varchar(50);
set @d = 'NomBDD'+cast(getdate() as varchar(50))+'bak';
set @d = replace(@d,' ','');
set @d = replace(@d,':','');
set @d = 'd:\'+@d; (pour mettre le fichier ailleurs que dans le backup sql server, ici le d:\)
backup database NomBDD to disk = @d;

----2 Rappeler l'enregistrement backup :
use master;
restore database NomBDD from disk = 'NomDuBackupDATE.bak'; (NomDuBackupDATE.bak=NomBDDDATE.bak)

*/