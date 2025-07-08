# Terraform Architecture

## Objectif
Ce dépôt permet de provisionner et déployer automatiquement deux architectures applicatives via Terraform :

- **Architecture 1** : Node.js + MongoDB (API posts)
- **Architecture 2** : React + Python + MySQL + Adminer (gestion utilisateurs)

Le déploiement peut se faire soit en local via Docker, soit sur Scalingo.

## Structure du dépôt
```
terraform-architecture/
├── modules/
│   ├── docker/        # Provisionnement Docker local/cloud
│   └── scalingo/      # Provisionnement Scalingo
├── .github/workflows/ # Pipelines CI/CD
├── script.sh          # Script de vérification des services
├── main.tf            # Configuration principale
├── variables.tf       # Variables d'entrée
├── outputs.tf         # Sorties
├── terraform.tfvars   # Valeurs par défaut
└── README.md          # Ce fichier
```

## Prérequis
- Terraform
- Docker (pour l'architecture Docker)
- Scalingo CLI (pour l'architecture Scalingo)
- Accès aux repos des applications (Node/Mongo, React/Python/MySQL)
- Token GitHub avec permissions `repo` pour les dispatches

## Utilisation

### 1. Déploiement Docker
```bash
cd modules/docker
terraform init
terraform apply
```

### 2. Déploiement Scalingo
```bash
cd modules/scalingo
terraform init
terraform apply
```

## Pipelines CI/CD
Les pipelines GitHub Actions :

1. **Lancement des tests unitaires et d'intégration**
2. **Build des images**
3. **Déploiement Docker**
4. **Lancement des tests end-to-end**
5. **Déclenchement du provider Terraform**

## Chaîne des projets
1. **Repo1** : front + python + mysql avec branch main et workflow dispatch
2. **Repo2** : node et mongodb avec 2 workflows (branch main et repository dispatch)
3. **Repo3** : terraform avec branch main et repository dispatch

## Variables principales
- `react_image` : image Docker de l'app React
- `python_image` : image Docker de l'API Python
- `mysql_image` : image officielle MySQL
- `adminer_image` : image officielle Adminer
- `node_image` : image Docker de l'API Node.js
- `mongo_image` : image officielle MongoDB

## Vérification des dispatches

### 1. Configuration du token GitHub
```bash
# Dans les settings GitHub du repo terraform-architecture
# Settings > Secrets and variables > Actions > New repository secret
PAT_DISPATCH = "votre_token_github_personnel"
```

### 2. Test manuel des dispatches
```bash
# Rendre le script exécutable
chmod +x check-dispatches.sh

# Définir le token
export GITHUB_TOKEN="votre_token_github_personnel"

# Tester les dispatches
./check-dispatches.sh
```

### 3. Test via GitHub Actions
- Aller dans l'onglet "Actions" du repo
- Sélectionner "Test Dispatches"
- Cliquer sur "Run workflow"
- Choisir le repo à tester

### 4. Vérification des workflows dans les autres repos
Assurez-vous que les repos `express-mongodb-app` et `react-form` ont des workflows qui écoutent l'événement `repository_dispatch` avec le type `trigger-ci`.

## Notes
- Les ports exposés et variables d'environnement sont configurables dans `variables.tf`
- Les volumes de données sont persistés par défaut
- Voir le fichier `main.tf` pour la logique complète
- Les dispatches nécessitent un token GitHub avec permissions `repo` 