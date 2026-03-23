#!/bin/bash

GREEN='\033[0,32m'
BLUE='\033[0,34m'
NC='\033[0m' 

echo -e "${BLUE}>>> Raspberry Pi Deployment...${NC}"

#  Obtain the latest code (Optional, only if you want to pull changes from Git)
# echo -e "${BLUE}>>> Bajando última versión de Git...${NC}"
# git pull origin master

# Build the frontend 
echo -e "${BLUE}>>> Building frontend...${NC}"
cd front

npm install

export PUBLIC_API_URL=/api
npm run build
cd ..

# Docker compose up
echo -e "${BLUE}>>> Starting containers with Docker Compose...${NC}"
# -d so it runs in detached mode (in the background)
# --build to ensure it rebuilds the images with the latest code changes
docker-compose up -d --build

#  Cleanup old images (optional, but good for Raspberry Pi storage)
echo -e "${BLUE}>>> Cleaning up old images...${NC}"
docker image prune -f

echo -e "${GREEN}✅ ¡Deployment completed successfully!${NC}"
echo -e "${GREEN}Access at: http://localhost (or the IP of your Raspberry)${NC}"