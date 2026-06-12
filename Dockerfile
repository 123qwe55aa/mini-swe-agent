FROM python:3.11-slim

# Install mini-swe-agent
RUN pip install --no-cache-dir mini-swe-agent

# Expose health check port
EXPOSE 3000

# Keep container alive, ready for docker exec
CMD ["python3", "-m", "http.server", "3000", "--bind", "0.0.0.0"]
