#!/bin/bash

set -e

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
GITHUB_TOKEN="${GITHUB_TOKEN:-$PAT_DISPATCH}"
OWNER="varlopecar"
REPOS=("express-mongodb-app" "react-form")

echo -e "${YELLOW} Vérification des dispatches GitHub...${NC}"

# Vérifier si le token est défini
if [ -z "$GITHUB_TOKEN" ]; then
    echo -e "${RED} Erreur: GITHUB_TOKEN ou PAT_DISPATCH non défini${NC}"
    echo "Définissez la variable d'environnement GITHUB_TOKEN ou PAT_DISPATCH"
    exit 1
fi

# Fonction pour tester un dispatch
test_dispatch() {
    local repo=$1
    local event_type="test-dispatch-$(date +%s)"
    
    echo -e "\n${YELLOW} Test du dispatch vers $repo...${NC}"
    
    response=$(curl -s -w "%{http_code}" \
        -X POST \
        -H "Accept: application/vnd.github+json" \
        -H "Authorization: Bearer $GITHUB_TOKEN" \
        -H "X-GitHub-Api-Version: 2022-11-28" \
        "https://api.github.com/repos/$OWNER/$repo/dispatches" \
        -d "{\"event_type\": \"$event_type\"}")
    
    http_code="${response: -3}"
    
    if [ "$http_code" = "204" ]; then
        echo -e "${GREEN} SUCCESS: Dispatch vers $repo (HTTP $http_code)${NC}"
        return 0
    else
        echo -e "${RED} FAILED: Dispatch vers $repo (HTTP $http_code)${NC}"
        echo "Response: ${response%???}"
        return 1
    fi
}

# Vérifier l'existence des repos
echo -e "\n${YELLOW} Vérification de l'existence des repos...${NC}"

for repo in "${REPOS[@]}"; do
    echo -e "\n${YELLOW} Vérification du repo $repo...${NC}"
    
    response=$(curl -s -w "%{http_code}" \
        -H "Accept: application/vnd.github+json" \
        -H "Authorization: Bearer $GITHUB_TOKEN" \
        -H "X-GitHub-Api-Version: 2022-11-28" \
        "https://api.github.com/repos/$OWNER/$repo")
    
    http_code="${response: -3}"
    
    if [ "$http_code" = "200" ]; then
        echo -e "${GREEN} Repo $repo existe${NC}"
    else
        echo -e "${RED} Repo $repo n'existe pas ou inaccessible (HTTP $http_code)${NC}"
        echo "Response: ${response%???}"
    fi
done

# Tester les dispatches
echo -e "\n${YELLOW} Test des dispatches...${NC}"

success_count=0
total_count=${#REPOS[@]}

for repo in "${REPOS[@]}"; do
    if test_dispatch "$repo"; then
        ((success_count++))
    fi
done

echo -e "\n${YELLOW} Résumé des tests:${NC}"
echo -e "${GREEN} Succès: $success_count/$total_count${NC}"

if [ $success_count -eq $total_count ]; then
    echo -e "${GREEN} Tous les dispatches fonctionnent correctement !${NC}"
    exit 0
else
    echo -e "${RED}  Certains dispatches ont échoué${NC}"
    exit 1
fi 