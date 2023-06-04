/***** Création de la BDD et l'utiliser *****/
CREATE DATABASE IF NOT EXISTS spaceProjectManagement;
ALTER DATABASE spaceProjectManagement charset = UTF8;

USE spaceProjectManagement;

/***** Création des tables *****/
DROP TABLE IF EXISTS Utilisateur;
CREATE TABLE Utilisateur(
   idUtilisateur INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   login VARCHAR(20)  NOT NULL,
   psw VARCHAR(255)  NOT NULL UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET= UTF8;

DROP TABLE IF EXISTS Projects;
CREATE TABLE Projects(
   idProj INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   numProj VARCHAR(250)  NOT NULL,
   nameProj VARCHAR(255) UNIQUE,
   description VARCHAR(8000)  NOT NULL,
   dateDebProj DATE NOT NULL,
   dateEndThProj DATE NOT NULL,
   dateEndRealProj DATE NOT NULL,
   lieuProj VARCHAR(250)  NOT NULL,
   statutProj VARCHAR(50)  NOT NULL,
   idUtilisateur INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET= UTF8;

DROP TABLE IF EXISTS Task;
CREATE TABLE Task(
   idTask INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   NameTask VARCHAR(50)  NOT NULL,
   description VARCHAR(1500)  NOT NULL,
   StateProjTask VARCHAR(50)  NOT NULL,
   dateCreateTask DATE NOT NULL,
   dateEnCours DATE NOT NULL,
   dateATester DATE NOT NULL,
   dateTerminée DATE NOT NULL,
   dateEndThTask DATE NOT NULL,
   dateEndRealTask DATE NOT NULL,
   nameStatutTask VARCHAR(50)  NOT NULL,
   idProj INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET= UTF8;

DROP TABLE IF EXISTS Clients;
CREATE TABLE Clients(
   idCli INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   nameCli VARCHAR(20)  NOT NULL,
   adrCli VARCHAR(250)  NOT NULL,
   firstnameCli VARCHAR(50)  NOT NULL,
   telCli VARCHAR(20)  NOT NULL,
   mailCli VARCHAR(50)  NOT NULL,
   idUtilisateur INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET= UTF8;

DROP TABLE IF EXISTS Documents;
CREATE TABLE Documents(
   idDoc INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   dateDoc DATE NOT NULL,
   catDoc VARCHAR(20)  NOT NULL,
   NameDoc VARCHAR(50)  NOT NULL,
   AdrDoc VARCHAR(256)  NOT NULL,
   descriptionDoc VARCHAR(1000) ,
   idProj INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET= UTF8;

DROP TABLE IF EXISTS Devis;
CREATE TABLE Devis(
   idDev INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   numDev VARCHAR(50)  NOT NULL UNIQUE,
   dateDev DATE NOT NULL,
   dateDeValidationDev DATE NOT NULL,
   typeDev VARCHAR(20)  NOT NULL,
   totDev DECIMAL(19,4) NOT NULL,
   idCli INT,
   idProj INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET= UTF8;

DROP TABLE IF EXISTS Facture;
CREATE TABLE Facture(
   idFact INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   numFact VARCHAR(50)  NOT NULL,
   dateFact DATE NOT NULL,
   typeFact VARCHAR(20)  NOT NULL,
   idProj INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET= UTF8;

DROP TABLE IF EXISTS TVA;
CREATE TABLE TVA(
   idTVA INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   tauxTVA DECIMAL(5,2)   NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET= UTF8;

DROP TABLE IF EXISTS Costs;
CREATE TABLE Costs(
   idCost INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   catCost VARCHAR(50)  NOT NULL,
   dateCost DATE NOT NULL,
   amountCost DECIMAL(19,4) NOT NULL,
   idProj INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET= UTF8;

DROP TABLE IF EXISTS ligDevQPU;
CREATE TABLE ligDevQPU(
   idLignDev INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   designation VARCHAR(255)  NOT NULL,
   QDev TINYINT NOT NULL,
   PUDev DECIMAL(10,2)   NOT NULL,
   idDev INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET= UTF8;

DROP TABLE IF EXISTS ligDevForfait;
CREATE TABLE ligDevForfait(
   idLignDevForfait INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   designationDevForfait VARCHAR(255)  NOT NULL,
   ssTotForfait DECIMAL(10,2)   NOT NULL,
   idDev INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET= UTF8;

DROP TABLE IF EXISTS ligFactForfait;
CREATE TABLE ligFactForfait(
   idLignFactForfait INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   designationFactForfait VARCHAR(255)  NOT NULL,
   ssTotForfait DECIMAL(10,2)   NOT NULL,
   idFact INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET= UTF8;

DROP TABLE IF EXISTS ligFactQPU;
CREATE TABLE ligFactQPU(
   idLignFact INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   designation VARCHAR(255)  NOT NULL,
   QFact TINYINT NOT NULL,
   PUFact DECIMAL(10,2)   NOT NULL,
   idFact INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET= UTF8;

DROP TABLE IF EXISTS taxe;
CREATE TABLE taxe(
   idTVA INT,
   idLignDev INT,
   idLignDevForfait INT,
   idLignFactForfait INT,
   idLignFact INT,
   PRIMARY KEY(idTVA, idLignDev, idLignDevForfait, idLignFactForfait, idLignFact)
) ENGINE=InnoDB DEFAULT CHARSET= UTF8;

DROP TABLE IF EXISTS generateur;
CREATE TABLE generateur(
   idDoc INT,
   idDev INT,
   idFact INT,
   PRIMARY KEY(idDoc, idDev, idFact)
) ENGINE=InnoDB DEFAULT CHARSET= UTF8;

/***** Création des clés étrangères et les contraintes *****/
ALTER TABLE Task
ADD CONSTRAINT fk_Task_Projects FOREIGN KEY (idProj) REFERENCES Projects(idProj);
ALTER TABLE Clients
ADD CONSTRAINT fk_Clients_Utilisateur FOREIGN KEY (idUtilisateur) REFERENCES Utilisateur(idUtilisateur);
ALTER TABLE Documents
ADD CONSTRAINT fk_Documents_Projects FOREIGN KEY (idProj) REFERENCES Projects(idProj);

ALTER TABLE Devis
ADD CONSTRAINT fk_Devis_Clients FOREIGN KEY (idCli) REFERENCES Clients(idCli),
ADD CONSTRAINT fk_Devis_Projects FOREIGN KEY(idProj) REFERENCES Projects(idProj);

ALTER TABLE Facture
ADD CONSTRAINT fk_Facture_Projects FOREIGN KEY(idProj) REFERENCES Projects(idProj);

ALTER TABLE Costs
ADD CONSTRAINT fk_Costs_Projects FOREIGN KEY(idProj) REFERENCES Projects(idProj);

ALTER TABLE ligDevQPU
ADD CONSTRAINT fk_ligDevQPU_Devis FOREIGN KEY (idDev) REFERENCES Devis(idDev);

ALTER TABLE ligDevForfait
ADD CONSTRAINT fk_ligDevForfait_Devis FOREIGN KEY(idDev) REFERENCES Devis(idDev);

ALTER TABLE ligFactForfait
ADD CONSTRAINT fk_ligFactForfait_Facture FOREIGN KEY(idFact) REFERENCES Facture(idFact);

ALTER TABLE ligFactQPU
ADD CONSTRAINT fk_ligFactQPU_Facture FOREIGN KEY(idFact) REFERENCES Facture(idFact);

ALTER TABLE taxe
ADD CONSTRAINT fk_taxe_TVA FOREIGN KEY(idTVA) REFERENCES TVA(idTVA),
ADD CONSTRAINT fk_taxe_ligDevQPU FOREIGN KEY(idLignDev) REFERENCES ligDevQPU(idLignDev),
ADD CONSTRAINT fk_taxe_ligDevForfait FOREIGN KEY(idLignDevForfait) REFERENCES ligDevForfait(idLignDevForfait),
ADD CONSTRAINT fk_taxe_ligFactForfait FOREIGN KEY(idLignFactForfait) REFERENCES ligFactForfait(idLignFactForfait),
ADD CONSTRAINT fk_taxe_ligFactQPU FOREIGN KEY(idLignFact) REFERENCES ligFactQPU(idLignFact);

ALTER TABLE generateur
ADD CONSTRAINT fk_generateur_Documents FOREIGN KEY(idDoc) REFERENCES Documents(idDoc),
ADD CONSTRAINT fk_generateur_Devis FOREIGN KEY(idDev) REFERENCES Devis(idDev),
ADD CONSTRAINT fk_generateur_Facture FOREIGN KEY(idFact) REFERENCES Facture(idFact);
/***** *****/
