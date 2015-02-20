
ttitle 'Achats des clients au 28 janvier 2013'

column dateachat heading "date d'achat" 
/*renomme la colonne datechat en date d achat*/
column dateachat format a20

break on idcl skip 1 on report	
/*cré un saut de ligne à chaque changement de idcl*/

compute avg sum of prix on idcl 
/*affiche la moyenne et la somme des prix à chaque saut de ligne*/

set pagesize 60 
/*agrandit la taille de la page*/

spool 2013-01-28-achats.lst
SELECT idcl, dateachat , genre, prix
FROM Achats NATURAL JOIN Livres                           
GROUP BY idcl, dateachat, genre, prix
ORDER BY idcl, dateachat;

spool off

