FROM python:3.11-slim

# Install Node.js 20 (for opencode)
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Install mini-swe-agent
RUN pip install --no-cache-dir mini-swe-agent

# Install opencode
RUN npm install -g opencode-ai@latest

# Expose port 3000 (Coolify health check)
EXPOSE 3000

# Simple HTTP server for health checks + keep container alive
# You can docker exec into this container to run 'mini' or 'opencode'
CMD ["python3", "-m", "http.server", "3000", "--bind", "0.0.0.0"]
