# Déploiement Docker

Ce dossier contient les fichiers Terraform pour provisionner l'environnement Docker local ou distant, déployant :

- Une API Node.js connectée à MongoDB (posts)
- Une application React connectée à une API Python/MySQL (utilisateurs)
- Adminer pour l'administration de la base MySQL
- Mongo Express pour l'administration de MongoDB

## Prérequis
- Docker
- Terraform
- Accès aux images Docker des applications (ou build local possible)

## Variables principales
- `react_image` : image Docker de l'app React
- `python_image` : image Docker de l'API Python
- `mysql_image` : image officielle MySQL
- `adminer_image` : image officielle Adminer
- `node_image` : image Docker de l'API Node.js
- `mongo_image` : image officielle MongoDB

## Utilisation
```bash
terraform init
terraform apply
```

## Notes
- Les ports exposés et variables d'environnement sont configurables dans `variables.tf`
- Les volumes de données sont persistés par défaut
- Voir le fichier `main.tf` pour la logique complète 