# Build the Docker image
FROM node:lts-slim

# Add container name label
LABEL container_name="ai-document-api-node"

# Set working directory
WORKDIR /app

# Install dependencies and cloudflared
RUN apt-get update && apt-get install -y curl gpg && \
    curl -L https://pkg.cloudflare.com/cloudflare-main.gpg -o /usr/share/keyrings/cloudflare-main.gpg && \
    echo 'deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared focal main' | tee /etc/apt/sources.list.d/cloudflared.list && \
    apt-get update && \
    apt-get install -y cloudflared && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy application code
COPY . .

# Install dependencies
RUN npm install

# Expose port
EXPOSE 8080

# Run both commands (server and tunnel)
CMD ["./start_server_tunnel.sh"]
