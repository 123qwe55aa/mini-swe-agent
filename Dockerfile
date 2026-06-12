FROM python:3.11-slim

# Tools mini-swe-agent needs for issue-to-branch workflows:
# clone repos, run git operations, push branches, and call APIs if needed.
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    git \
    openssh-client \
    && rm -rf /var/lib/apt/lists/*

# Install mini-swe-agent.
RUN pip install --no-cache-dir mini-swe-agent

# Stable provider config for OpenCode Go.
# OPENAI_API_KEY stays runtime-only in Coolify env vars.
ENV OPENAI_BASE_URL=https://opencode.ai/zen/go/v1
ENV OPENAI_API_BASE=https://opencode.ai/zen/go/v1
ENV LITELLM_API_BASE=https://opencode.ai/zen/go/v1
ENV MSWEA_MODEL_NAME=openai/deepseek-v4-pro
ENV LITELLM_MODEL=openai/deepseek-v4-pro
ENV MSWEA_CONFIGURED=1
ENV MSWEA_COST_TRACKING=ignore_errors

# Default git identity for agent-created commits.
ENV GIT_AUTHOR_NAME=mini-swe-agent
ENV GIT_AUTHOR_EMAIL=mini-swe-agent@local
ENV GIT_COMMITTER_NAME=mini-swe-agent
ENV GIT_COMMITTER_EMAIL=mini-swe-agent@local

# Expose health check port.
EXPOSE 3000

# Keep container alive + Coolify health check.
CMD ["python3", "-m", "http.server", "3000", "--bind", "0.0.0.0"]
