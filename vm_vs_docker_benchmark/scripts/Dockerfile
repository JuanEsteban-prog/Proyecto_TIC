FROM python:3.10-slim

RUN apt-get update && apt-get install -y \
    curl \
    procps \
    net-tools \
    iputils-ping \
    && pip install flask

WORKDIR /app

COPY . .

RUN chmod +x crash_recovery.sh

EXPOSE 6969

CMD ["python3", "simple_http_server.py"]
