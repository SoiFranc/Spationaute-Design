/***** Création de la BDD et l'utiliser *****/
CREATE DATABASE IF NOT EXISTS GestionnaireProjetSD;
ALTER DATABASE GestionnaireProjetSD charset = UTF8;

USE GestionnaireProjetSD;


/***** Création des tables *****/
DROP TABLE IF EXISTS Couts;
CREATE TABLE Couts(
   idCout INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   catCout VARCHAR(20) NOT NULL,
   dateCout DATE NOT NULL,
   descriptionCout VARCHAR(255)  NOT NULL,
   MontantCout DECIMAL(10,2) NOT NULL,
   idProjet INT
) ENGINE=InnoDB DEFAULT CHARSET= UTF8;

DROP TABLE IF EXISTS Taches;
CREATE TABLE Taches(
   idTache INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   numTache VARCHAR(20) NOT NULL,
   nameTache VARCHAR(20) NOT NULL,
   descriptionTache VARCHAR(1500) NOT NULL,
   prioTache VARCHAR(20) NOT NULL,
   stateTache VARCHAR(20) NOT NULL,
   categoryTache VARCHAR(20) NOT NULL,
   dateCreateTache DATE NOT NULL,
   dateInProgressTache DATE,
   dateToTestTache DATE,
   dateEndThTache DATE NOT NULL,
   dateEndRealTache DATE,
   idProjet INT
) ENGINE=InnoDB DEFAULT CHARSET= UTF8;

DROP TABLE IF EXISTS TVA;
CREATE TABLE TVA(
   idTVA INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   tauxTVA DECIMAL(5,2)   NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET= UTF8;

DROP TABLE IF EXISTS Personnes;
CREATE TABLE Personnes(
   idPersonne INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   firstname VARCHAR(20) NOT NULL,
   name VARCHAR(20) NOT NULL,
   fonction VARCHAR(30) NOT NULL,
   adress VARCHAR(255) NOT NULL,
   tel VARCHAR(20) NOT NULL,
   mail VARCHAR(100) NOT NULL,
   isActivate BOOLEAN DEFAULT false NOT NULL,
   catPerson VARCHAR(20)  NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET= UTF8;

DROP TABLE IF EXISTS Utilisateurs;
CREATE TABLE Utilisateurs(
   login VARCHAR(20)  NOT NULL,
   psw VARCHAR(255)  NOT NULL UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET= UTF8;

DROP TABLE IF EXISTS Clients;
CREATE TABLE Clients(
   isPro BOOLEAN DEFAULT true NOT NULL,
   numSiret VARCHAR(20)  NOT NULL,
   numTVAIntracom VARCHAR(20),
   codeAPE VARCHAR(10),
   profession VARCHAR(30)  NOT NULL,
   adrProfession VARCHAR(255)  NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET= UTF8;

DROP TABLE IF EXISTS Documents;
CREATE TABLE Documents(
   idDocument INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   dateDoc DATE NOT NULL,
   catDoc VARCHAR(20)  NOT NULL,
   nameDoc VARCHAR(50) NOT NULL,
   pathDoc VARCHAR(256)  NOT NULL,
   descriptionDoc VARCHAR(1000),
   idProjet INT
) ENGINE=InnoDB DEFAULT CHARSET= UTF8;

DROP TABLE IF EXISTS Devis;
CREATE TABLE Devis(
   idDev INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   numDev VARCHAR(50)  NOT NULL UNIQUE,
   nameDev VARCHAR(255)  NOT NULL,
   dateDev DATE NOT NULL,
   dateValidationDev DATE NOT NULL,
   typeDev VARCHAR(20)  NOT NULL,
   totalHTDev DECIMAL(10,2) NOT NULL,
   idPersonne INT,
   idTVA INT,
   idDeGeneration INT
) ENGINE=InnoDB DEFAULT CHARSET= UTF8;

DROP TABLE IF EXISTS Factures;
CREATE TABLE Factures(
   idFact INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   numFact VARCHAR(50)  NOT NULL,
   nameFact VARCHAR(255)  NOT NULL,
   dateFact DATE NOT NULL,
   dateAcquittalFact DATE NOT NULL,
   typeFact VARCHAR(20)  NOT NULL,
   montantHTFact DECIMAL(10,2) NOT NULL,
   idProjet INT,
   idTVA INT,
   idDeGeneration INT
) ENGINE=InnoDB DEFAULT CHARSET= UTF8;

DROP TABLE IF EXISTS Projets;
CREATE TABLE Projets(
   idProjet INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   numProj VARCHAR(50)  NOT NULL UNIQUE,
   nameProj VARCHAR(255),
   descriptionProj VARCHAR(5000) NOT NULL,
   dateStartProj DATE NOT NULL,
   dateEndThProj DATE NOT NULL,
   dateEndRealProj DATE NOT NULL,
   placeProj VARCHAR(255)  NOT NULL,
   stateAdvancementProj VARCHAR(50) NOT NULL,
   idDev INT,
   idPersonne INT
) ENGINE=InnoDB DEFAULT CHARSET= UTF8;

DROP TABLE IF EXISTS LigDevQPU;
CREATE TABLE LigDevQPU(
   idLigDevQPU INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   numLigDevQPU INT NOT NULL,
   designationLigDevQPU VARCHAR(255)  NOT NULL,
   qLigDevQPU TINYINT NOT NULL,
   montantLigDevQPU DECIMAL(10,2)   NOT NULL,
   idDev INT
) ENGINE=InnoDB DEFAULT CHARSET= UTF8;

DROP TABLE IF EXISTS LigDevForfait;
CREATE TABLE LigDevForfait(
   idLigDevForfait INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   numLigDevForfait INT NOT NULL,
   designationLigDevForfait VARCHAR(255)  NOT NULL,
   montantLigDevForfait DECIMAL(10,2) NOT NULL,
   idDev INT
) ENGINE=InnoDB DEFAULT CHARSET= UTF8;

DROP TABLE IF EXISTS LigFactForfait;
CREATE TABLE LigFactForfait(
   idLignFactForfait INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   dateInterventionLigFactForfait DATE NOT NULL,
   numLigFactForfait INT NOT NULL,
   designationLigFactForfait VARCHAR(255)  NOT NULL,
   montantLigFactForfait DECIMAL(10,2)   NOT NULL,
   idFact INT
) ENGINE=InnoDB DEFAULT CHARSET= UTF8;

DROP TABLE IF EXISTS LigFactQPU;
CREATE TABLE LigFactQPU(
   idLigFactQPU INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   dateInterventionLigFactQPU DATE NOT NULL,
   numLigFactQPU INT NOT NULL,
   designationLigFactQPU VARCHAR(255)  NOT NULL,
   qLigFactQPU TINYINT NOT NULL,
   montantLigFactQPU DECIMAL(10,2)   NOT NULL,
   idFact INT
) ENGINE=InnoDB DEFAULT CHARSET= UTF8;

DROP TABLE IF EXISTS generateur;
CREATE TABLE generateur(
   idDeGeneration INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
   dateGenerationDoc DATE NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET= UTF8;


/***** Clé primaire sur héritage exclusif *****/
ALTER TABLE Utilisateurs
ADD idPersonne INT,
ADD idPersonneUtilisateur INT AUTO_INCREMENT NOT NULL,
ADD CONSTRAINT PK_Utilisateurs PRIMARY KEY(idPersonne, idPersonneUtilisateur),
ADD CONSTRAINT FK_Utilisateurs_Personnes FOREIGN KEY(idPersonneUtilisateur) 
       REFERENCES Personnes(idPersonne)
       ON DELETE CASCADE;

ALTER TABLE Clients
ADD idPersonne INT,
ADD idPersonneClient INT AUTO_INCREMENT NOT NULL,
ADD idPersonneUtilisateur INT,
ADD CONSTRAINT PF_Clients PRIMARY KEY(idPersonne, idPersonneClient),
ADD CONSTRAINT FK_Clients_Personnes FOREIGN KEY(idPersonneClient) 
       REFERENCES Personnes(idPersonne)
       ON DELETE CASCADE,
ADD CONSTRAINT FK_Clients_Utilisateurs FOREIGN KEY(idPersonneUtilisateur) 
       REFERENCES Utilisateurs(idPersonne);


/***** Création des clés étrangères et les contraintes *****/

ALTER TABLE Taches
ADD CONSTRAINT FK_Taches_Projets FOREIGN KEY (idProjet) REFERENCES Projets(idProjet);

ALTER TABLE Couts
ADD CONSTRAINT FK_Couts_Projets FOREIGN KEY(idProjet) REFERENCES Projets(idProjet);

ALTER TABLE ligFactForfait
ADD CONSTRAINT FK_ligFactForfait_Factures FOREIGN KEY(idFact) REFERENCES Factures(idFact);

ALTER TABLE ligFactQPU
ADD CONSTRAINT FK_ligFactQPU_Factures FOREIGN KEY(idFact) REFERENCES Factures(idFact);

ALTER TABLE Factures
ADD CONSTRAINT FK_Factures_Projets FOREIGN KEY(idProjet) REFERENCES Projets(idProjet),
ADD CONSTRAINT FK_Factures_Generateur FOREIGN KEY(idDeGeneration) REFERENCES Generateur(idDeGeneration),
ADD CONSTRAINT FK_Factures_TVA FOREIGN KEY(idTVA) REFERENCES TVA(idTVA);

ALTER TABLE Documents
ADD CONSTRAINT FK_Documents_Projets FOREIGN KEY (idProjet) REFERENCES Projets(idProjet);


ALTER TABLE Devis
ADD idPersonneClient INT,
ADD CONSTRAINT FK_Devis_Clients FOREIGN KEY (idPersonneClient) REFERENCES Clients(idPersonne),
ADD CONSTRAINT FK_Devis_Generateur FOREIGN KEY(idDeGeneration) REFERENCES Generateur(idDeGeneration),
ADD CONSTRAINT FK_Devis_TVA FOREIGN KEY(idTVA) REFERENCES TVA(idTVA);

ALTER TABLE ligDevQPU
ADD CONSTRAINT FK_ligDevQPU_Devis FOREIGN KEY (idDev) REFERENCES Devis(idDev);

ALTER TABLE ligDevForfait
ADD CONSTRAINT FK_ligDevForfait_Devis FOREIGN KEY(idDev) REFERENCES Devis(idDev);

ALTER TABLE Projets
ADD idPersonneUtilisateur INT,
ADD CONSTRAINT FK_Projets_Devis FOREIGN KEY (idDev) REFERENCES Devis(idDev),
ADD CONSTRAINT FK_Projets_Utilisateurs FOREIGN KEY(idPersonneUtilisateur) REFERENCES Utilisateurs(idPersonne);

/***** *****/
