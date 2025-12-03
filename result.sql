create database  BlogCMS;
use BlogCMS;
--les drop des  tables
drop table User;
drop table Article;
drop table categorie;
drop table commentaire;
--les selects
select * from User;
select * from categorie;
SELECT * from commentaire;
select * from Article;


--1. INSERT - Création d'un nouvel utilisateur
--Insérer un nouvel utilisateur avec :
--- Username : "jdupont"
--- Email : "jean.dupont@email.com"
-- Rôle : "éditeur"
-- Mot de passe : "$2y$10$..."

insert into  User(username,email,password_hash,role,created_at) values('jdupont','jean.dupont@email.com','$2y$10$...','editor','2025-12-02');

--Récupérer tous les articles avec leur titre, date de création et statut
select   title,created_at,status
from Article;
 --Changer le statut de tous les articles "brouillon=draft" créés avant 2024 en "archivé"
update Article set status="archivé"
where  Article.created_at<'2024-07-20';
--Supprimer tous les commentaires marqués comme "spam" et datant de plus d'un an
delete  
from commentaire
where status='spam' and   created_at<DATE_SUB(CURRENT_DATE(),INTERVAL -1 YEAR);
 
 --6-Récupérer les articles publiés après le 1er décembre 2024
 select * 
 from Article
 where  Article.created_at>'2024-12-01';
 --Trier les utilisateurs par date d'inscription (du plus ancien au plus récent)
 select *
 from User
 order by created_at ASC;
--Obtenir les 5 articles les plus récents (seulement titres et dates)
select   created_at,title
from Article 
order by created_at DESC
limit 5;
--Récupérer tous les rôles distincts des utilisateurs
select  DISTINCT(role)
from User;
--Récupérer les articles de la catégorie "Technologie" qui sont soit "publiés", soit en "brouillon avancé"
select  c.name,a.status
from categorie c join  Article a on a.category_id=c.id
where  c.name='Technologie'  and  a.status in('published','draft');

--OR 

select * 
from Article
where  category_id=1 and status in('published','draft'); 

---Lister les commentaires postés entre le 1er et le 15 décembre 2024
select * 
from commentaire
where  created_at  between '2024-12-01'  and  '2024-12-15';

--Trouver les articles appartenant aux catégories "PHP", "JavaScript" ou "Base de données"
select   a.title,c.name
from Article a join categorie c on  a.category_id=c.id
where c.name in('PHP','JavaScript','Base de données');

--Rechercher tous les utilisateurs dont l'email finit par "@gmail.com"
select *
from  User
where   email like   '%@gmail.com';
--Compter le nombre total d'articles publiés
select count(*) as NombreTotal
from article
where status='published';
--Compter le nombre d'articles par catégorie
select  c.name,count(a.id)
from Article a join categorie c
on a.category_id=c.id
GROUP by c.name;

--Calculer la longueur moyenne (en caractères) des articles publiés
select AVG(CHAR_LENGTH(content)) as MoyenArticle
from article
where status='published';

--Trouver :
-- La date du dernier article publié
select max(created_at) 
from Article
where status='published';

-- La date du premier commentaire du système
select min(created_at) 
from  commentaire;

--Calculer le nombre total de vues de tous les articles
--(Si vous avez une colonne `view_count`)
select SUM(view_count) as NombreTotal
from article;

--Lister tous les articles avec  -- Titre de l'article -- Nom de l'auteur -- Date de publication
select  a.title,U.username,a.created_at
from Article a  inner  join User U
on a.user_id =U.idU 

--Afficher toutes les catégories, même celles sans articles
--Inclure le nombre d'articles par catégorie
select c.name,count(c.id)
from   categorie c  left join  article  a
on  a.category_id=c.id
group by c.name

--Pour chaque utilisateur, afficher :
-- Nom d'utilisateur
-- Nombre d'articles écrits
-- Nombre de commentaires reçus sur ses articles
SELECT u.username,COUNT(DISTINCT a.id) AS nombre_articles,COUNT(com.idc) AS nombre_commentaires
FROM User u
LEFT JOIN Article a 
ON a.user_id = u.idU
LEFT JOIN commentaire com
ON com.post_id = a.id
GROUP BY u.idU, u.username;

--Trouver tous les articles sans catégorie assignée
select *
from  Article
where category_id=0;  

--Créer une vue "dashboard_articles" qui montre :  -- Articles publiés seulement -- Avec nom d'auteur -- Catégorie  -- Nombre de commentaires
-- Date de dernière modification
CREATE VIEW dashboard_articles AS
SELECT a.title, u.username AS auteur,ca.name AS categorie,COUNT(com.idc) AS NombreCommentaire,
a.updated_at AS DerniereModification
FROM Article a
JOIN User u ON a.user_id = u.idU
JOIN categorie ca ON a.category_id = ca.id
LEFT JOIN commentaire com ON com.post_id = a.id
WHERE a.status = 'published'
GROUP BY a.id, a.title, u.username, ca.name, a.updated_at;

select * 
from  dashboard_articles;


--Trouver les catégories ayant plus de 5 articles
select  c.name,count(a.id)
from Article a join categorie c
on a.category_id=c.id 
GROUP BY c.name
having  count(a.id)>5;
--Trouver les utilisateurs qui n'ont écrit aucun article

SELECT *
FROM User u
 JOIN Article a ON u.idU = a.user_id
WHERE a.id=0;

--Archiver tous les articles dont la catégorie est "Obsolète"
UPDATE Article a
JOIN categorie c ON a.category_id = c.id
SET a.status = 'archivé'
WHERE c.name = 'Obsolète';

