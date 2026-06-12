FROM python:3.11-slim

# Install mini-swe-agent
RUN pip install --no-cache-dir mini-swe-agent

# Provider config - opencode-go via OpenRouter-compatible API
ENV OPENAI_BASE_URL=https://opencode.ai/zen/go/v1
ENV MSWEA_MODEL_NAME=openai/deepseek-v4-flash
ENV MSWEA_CONFIGURED=1

# Expose health check port
EXPOSE 3000

# Keep container alive + Coolify health check
CMD ["python3", "-m", "http.server", "3000", "--bind", "0.0.0.0"]
