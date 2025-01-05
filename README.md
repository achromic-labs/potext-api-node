# ai-document-api-node
# Description
This is a Node.js (Express) based API for AI document editing, available for free public use.

## IMPORTANT: place your Gemini API into .env file ([Google AI Studio](https://aistudio.google.com/app/apikey))
(create an account if needed)
1. Create API Key and place it into .env file

## Prerequisites
- Node.js 18 or higher ([Download](https://nodejs.org/))
- npm (comes with Node.js)

### Optional Dependencies
Docker ([Install](https://docs.docker.com/engine/install/))

## Local Development Setup
1. Install dependencies
```bash
npm install
```

2. Put your Gemini API key into contacnts.js 

3. Run server:
```bash
npm start
```

## Docker Setup
1. Install - Docker ([Installation Guide](https://docs.docker.com/engine/install/))

2. Build docker image using bash script
```bash
./run_docker.sh
```

3. Stop docker container and remove image using bash script
```bash
./remove_docker_container.sh
```

## For contributors:
1. Create a new branch
2. Commit and push your changes for review

Thank you!