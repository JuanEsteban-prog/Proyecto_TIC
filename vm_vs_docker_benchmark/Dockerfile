FROM python:3.10-slim

RUN apt-get update && apt-get install -y \
    curl \
    procps \
    net-tools \
    iputils-ping \
    && pip install flask

WORKDIR /app

# Copiar todo lo necesario desde el contexto
COPY server/simple_http_server.py ./server/
COPY scripts/crash_recovery.ps1 ./scripts/
COPY scripts/shared_code.c ./scripts/

# Crear carpeta para resultados
RUN mkdir /app/results

EXPOSE 6969

CMD ["python3", "server/simple_http_server.py"]
