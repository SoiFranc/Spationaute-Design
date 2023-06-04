/***************Création d'index********************/
/*--Crée un index sur une table.
Un index est un accès optimisé aux données.
L’optimisation est effective lorsque vous utilisez la colonne
 indexée comme critère de recherche dans la clause WHERE 
 d’une requête SELECT.*/

/*Syntaxe*/
CREATE [ UNIQUE ] INDEX nom_index ON nom_table ( nom_colonne1 [ ASC | DESC ] [ ,...nom_colonne2 ] )


/*Les termes entre crochets sont optionnels.
UNIQUE permet de créer un index unique 
(dans lequel deux lignes ne peuvent pas avoir la même 
valeur d'index) sur une table.
*/