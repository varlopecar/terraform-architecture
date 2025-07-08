#!/bin/bash

set -e

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

function check_http() {
  local name=$1
  local url=$2
  if curl -s --max-time 5 "$url" > /dev/null; then
    echo -e "${GREEN}✅ $name is UP at $url${NC}"
    return 0
  else
    echo -e "${RED}❌ $name is DOWN at $url${NC}"
    return 1
  fi
}

function check_tcp() {
  local name=$1
  local host=$2
  local port=$3
  if nc -z "$host" "$port" 2>/dev/null; then
    echo -e "${GREEN}✅ $name is UP at $host:$port${NC}"
    return 0
  else
    echo -e "${RED}❌ $name is DOWN at $host:$port${NC}"
    return 1
  fi
}

echo -e "${YELLOW}🚀 Test Express MongoDB uniquement...${NC}"

# Attendre que les services démarrent
echo -e "\n${YELLOW}⏳ Attente du démarrage des services...${NC}"
sleep 10

# Test MongoDB
echo -e "\n${YELLOW}📊 Test MongoDB...${NC}"
check_tcp "MongoDB" "localhost" 27017

# Test Node.js API
echo -e "\n${YELLOW}🌐 Test Node.js API...${NC}"
check_http "Node.js API" "http://localhost:3001"

# Test Mongo Express
echo -e "\n${YELLOW}🔧 Test Mongo Express...${NC}"
check_http "Mongo Express" "http://localhost:8082"

# Test API endpoints
echo -e "\n${YELLOW}🔍 Test des endpoints API...${NC}"

# Test GET /posts
if curl -s "http://localhost:3001/posts" > /dev/null; then
  echo -e "${GREEN}✅ GET /posts - OK${NC}"
else
  echo -e "${RED}❌ GET /posts - FAILED${NC}"
fi

# Test GET /health
if curl -s "http://localhost:3001/health" > /dev/null; then
  echo -e "${GREEN}✅ GET /health - OK${NC}"
else
  echo -e "${RED}❌ GET /health - FAILED${NC}"
fi

echo -e "\n${GREEN}🎉 Test Express MongoDB terminé !${NC}"
echo -e "${YELLOW}📝 URLs utiles :${NC}"
echo -e "  - API Node.js: http://localhost:3001"
echo -e "  - Mongo Express: http://localhost:8082"
echo -e "  - MongoDB: mongodb://admin:password@localhost:27017/blog_db" 