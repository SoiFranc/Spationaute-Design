-- on prend toutes les colonnes des 2 tables
SELECT commandes.`idCommande`, commandes.`idClient`, commandes.`idArticle`, commandes.`dateCommande`, commandes.`quantiteCommande`, commandes.`cde_total`, 
    articles.descriptionArticle, articles.prixArticle 
FROM `commandes` 
-- on crée la jointure entre les tables en matérialisant le lien du concepteur
INNER JOIN articles ON commandes.idArticle = articles.idArticle 

-- on crée le lien entre les tables, puis on multiplie les colonnes
SELECT MAX( commandes.quantiteCommande * articles.prixArticle ) 
FROM `commandes` 
INNER JOIN articles ON commandes.idArticle = articles.idArticle 

-- liens entre plusieurs tables
SELECT clients.nomClient,
	articles.descriptionArticle,
    commandes.dateCommande,
    commandes.quantiteCommande
FROM commandes
INNER JOIN clients ON commandes.idClient = clients.idClient
INNER JOIN articles ON commandes.idArticle = articles.idArticle

-- autres solutions avec alias

SELECT cl.nomClient,
	a.descriptionArticle,
    co.dateCommande,
    co.quantiteCommande
FROM commandes as co
INNER JOIN clients as cl ON co.idClient = cl.idClient
INNER JOIN articles as a ON co.idArticle = a.idArticle

-- solution sans inner join
SELECT
    cl.nomClient,
    cl.prenomClient,
    cl.idClient,
    co.idCommande,
    co.idClient,
    co.idArticle,
    co.dateCommande,
    co.quantiteCommande,
    a.descriptionArticle,
    a.prixArticle
FROM
    clients AS cl,
    commandes AS co,
    articles AS a
WHERE
    cl.idClient = co.idClient AND co.idarticle = a.idArticle


    -- equivalence entre 2 innerjoin
    SELECT e.nomEtudiant,a.note
FROM `avoir_note` as a
INNER JOIN etudiants as e ON e.idEtudiant=a.idEtudiant
ORDER BY nomEtudiant;


SELECT e.nomEtudiant,a.note
FROM etudiants as e
INNER JOIN `avoir_note` as a ON e.idEtudiant=a.idEtudiant
ORDER BY nomEtudiant;

-- TOUS les etudiants et leur moyenne
SELECT e.nomEtudiant, AVG(a.note)
FROM etudiants as e
LEFT JOIN `avoir_note` as a ON e.idEtudiant=a.idEtudiant
GROUP BY e.idEtudiant
ORDER BY nomEtudiant

SELECT e.nomEtudiant,AVG(a.note)
FROM `avoir_note` as a
RIGHT JOIN etudiants as e ON e.idEtudiant=a.idEtudiant
GROUP BY e.idEtudiant
ORDER BY nomEtudiant;


--limiter les resultats (les 2 premiers)
SELECT e.nomEtudiant,ep.libelleEpreuve, AVG(a.note)
FROM etudiants as e
LEFT JOIN `avoir_note` as a ON e.idEtudiant=a.idEtudiant
LEFT JOIN epreuves as ep ON ep.idEpreuve = a.idEpreuve
GROUP BY e.idEtudiant
ORDER BY nomEtudiant
limit 2;
-- 2 a partir de 3
SELECT e.nomEtudiant,ep.libelleEpreuve, AVG(a.note)
FROM etudiants as e
LEFT JOIN `avoir_note` as a ON e.idEtudiant=a.idEtudiant
LEFT JOIN epreuves as ep ON ep.idEpreuve = a.idEpreuve
GROUP BY e.idEtudiant
ORDER BY nomEtudiant
limit 2
offset 3;
