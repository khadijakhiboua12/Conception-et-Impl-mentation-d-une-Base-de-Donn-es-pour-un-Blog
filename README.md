# BlogCMS - Base de données

## Description
Ce projet consiste à créer une base de données pour une application de blog simple (BlogCMS).  
Elle permet de gérer :
- Les utilisateurs (auteurs et lecteurs)
- Les articles (posts)
- Les catégories d’articles
- Les commentaires des utilisateurs

La base est conçue avec **MySQL** et utilise le langage **SQL** pour créer les tables, définir les relations et assurer l’intégrité des données.

## Modèle Conceptuel des Données (MCD)
Le modèle comporte quatre entités principales :

1. **Users** : stocke les informations des utilisateurs (nom, email, mot de passe, date de création)  
2. **Categories** : liste des catégories d’articles (nom, description)  
3. **Posts** : articles rédigés par les utilisateurs, liés à une catégorie  
4. **Comments** : commentaires des utilisateurs liés à un article  


## Utilisation
1. Installer MySQL et créer une base `BlogCMS`  
2. Exécuter les scripts SQL pour créer les tables et les relations  
3. Ajouter des données dans les tables `Users`, `Categories`, `Posts` et `Comments`  
4. Interroger la base avec SQL pour gérer les articles et les commentaires

## Technologies
- MySQL  
- SQL pour la création et la manipulation des données
