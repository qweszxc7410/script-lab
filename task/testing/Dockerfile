# Dockerfile
FROM python:3.11-slim

WORKDIR /app

COPY write_time.py .
COPY run.sh .

RUN chmod +x run.sh

CMD ["./run.sh"]
