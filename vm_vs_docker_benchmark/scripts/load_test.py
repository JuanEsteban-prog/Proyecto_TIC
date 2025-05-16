# scripts/load_test.py
import time
import requests
import argparse
import json

parser = argparse.ArgumentParser(description="Realiza carga al servidor.")
parser.add_argument("--host", default="localhost", help="Dirección del servidor")
parser.add_argument("--port", type=int, default=6969, help="Puerto del servidor")
parser.add_argument("--requests", type=int, default=50, help="Número de peticiones")
parser.add_argument("--output", default="results/docker_results.json", help="Archivo de salida")
args = parser.parse_args()

url = f"http://{args.host}:{args.port}/"
tiempos = []

print(f"📡 Enviando {args.requests} peticiones a {url}")

for i in range(args.requests):
    inicio = time.time()
    try:
        r = requests.get(url)
        duracion = time.time() - inicio
        tiempos.append(duracion)
        print(f"✅ [{i+1}] Código: {r.status_code} - Tiempo: {duracion:.4f}s")
    except Exception as e:
        print(f"❌ [{i+1}] Error: {e}")
        tiempos.append(None)

# Guardar resultados
with open(args.output, "w") as f:
    json.dump(tiempos, f)

print(f"💾 Resultados guardados en {args.output}")
