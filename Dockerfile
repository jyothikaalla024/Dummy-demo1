FROM python:3.12-slim
RUN useradd -u 10001 -m appuser
WORKDIR /app
COPY server.py .
USER 10001
EXPOSE 8080
CMD ["python", "server.py"]
