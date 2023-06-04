/******************Créer la base de données : utilisateurs et droits************************/

-------Création d'un utilisateur


/*Création d'un utilisateur autorisé à se connecter depuis une machine (via l'adresse IP)
 via le mot de passe renseigné :*/

 --CREATE USER 'nom_utilisateur'@'adresse_ip' IDENTIFIED BY 'mot_de_passe';


 CREATE USER 'dave_loper'@'123.45.67.89' IDENTIFIED BY '1Ksable';

 -------Suppression d'un utilisateur

DROP USER 'nom_utilisateur'@'adresse_ip';
--adresse_ip peut être remplacé par le caractère % pour spécifier toutes les adresses.


--------Création de privilèges

/*Les privilèges sont des droits accordés à un utilisateur sur une base de données. Ils participent donc à la sécurité.
On peut ainsi autoriser ou interdire à un utilisateur :
• de lire, insérer, modifier ou supprimer des données sur certaines tables,
• d'effectuer des actions sur le schéma (structure des tables, colonnes, relations) d'une base
• d'exécuter, créer, modifier ou supprimer des vues, procédures stockées, déclencheurs, transactions
• de gérer d'autres utilisateurs et leurs privilèges.
Les privilèges se manipulent avec la commande GRANT ('accorder' en anglais) :
L'instruction suivante permet d'ajouter un utilisateur ayant tous les droits sur une base de données :

*/
GRANT ALL PRIVILEGES ON nom_de_la_base.* TO 'utilisateur'@'adresse_ip';

--Exemple :
GRANT ALL PRIVILEGES ON papyrus.* TO 'dave_loper'@'%';
/*Ici, l'utilisateur dave_loper peut se connecter depuis 
n'importe quelle machine (spécifié par le joker %) sur la 
base papyrus en utilisant le mot de passe 1Ksable*/


------------Affecter de droits

/*
GRANT privilege ON objet TO utilisateur;
• privilege = SELECT, INSERT, DELETE, UPDATE, CREATE, DROP...
• objet = nom_base.nomtable (exemple: papyrus.fournis)
• utilisateur = nom de l'utilisateur

Exemple 1 :*/
GRANT select ON papyrus.fournis TO dave_loper;
/*Ici, l'utilisateur dave_loper pourra seulement lire la table fournis de la
 base papyrus : cette commande désactive toutes les autres possibilités (INSERT, UPDATE...).*/

--Exemple 2 : accorder plusieurs privilèges :
GRANT SELECT, INSERT, UPDATE ON papyrus.vente TO dave_loper;
--Ici, l'utilisateur dave_loper pourra afficher, insérer ou modifier des données.