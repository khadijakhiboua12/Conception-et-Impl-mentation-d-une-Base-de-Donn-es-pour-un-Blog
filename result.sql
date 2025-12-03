--1. INSERT - Création d'un nouvel utilisateur
--Insérer un nouvel utilisateur avec :
--- Username : "jdupont"
--- Email : "jean.dupont@email.com"
-- Rôle : "éditeur"
-- Mot de passe : "$2y$10$..."

insert into  User(username,email,password_hash,role,created_at) values('jdupont','jean.dupont@email.com','éditeur','$2y$10$...');

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
select *
from article
where  status  IN ('published','draft');

