# Build the Docker image
FROM node:lts-slim

# Add container name label
LABEL container_name="ai-document-api-node"

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy application code
COPY . .

# Expose port
EXPOSE 8080

# Run the application
CMD ["node", "server.js"]
