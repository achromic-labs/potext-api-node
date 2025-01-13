# potext-api-node
# Description
This is a Node.js (Express) based API for AI document editing, available for free public use.

## IMPORTANT: pre-setup environment 
(create an account if needed)
1. Make a copy of env.example
```bash
cp env.example .env
```
2. Create Gemini API Key and place into .env file ([Google AI Studio](https://aistudio.google.com/app/apikey))
(Place your Gemini API Key instead of __GEMINI_API_KEY__ value in .env file)


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