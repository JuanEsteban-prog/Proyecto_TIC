import os
import json
import matplotlib.pyplot as plt
import numpy as np

# Ruta base relativa al script actual
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
RESULTS_DIR = os.path.join(BASE_DIR, '..', 'results')

docker_path = os.path.join(RESULTS_DIR, 'docker_results.json')
vm_path = os.path.join(RESULTS_DIR, 'vm_results.json')

# Verifica si existen los archivos
if not os.path.exists(docker_path) or not os.path.exists(vm_path):
    print("❌ No se encontraron los archivos de resultados. Ejecuta las pruebas primero.")
    exit(1)

# Cargar datos
with open(docker_path) as f:
    docker_times = json.load(f)

with open(vm_path) as f:
    vm_times = json.load(f)

# Filtrar valores None
docker_times = [t for t in docker_times if t is not None]
vm_times = [t for t in vm_times if t is not None]

# Estadísticas
def resumen(nombre, datos):
    print(f"\n🔍 {nombre}:")
    print(f"  - Total: {len(datos)} peticiones")
    print(f"  - Promedio: {np.mean(datos):.4f}s")
    print(f"  - Mínimo: {np.min(datos):.4f}s")
    print(f"  - Máximo: {np.max(datos):.4f}s")

resumen("Docker", docker_times)
resumen("VM", vm_times)

# Gráfico
plt.figure(figsize=(10, 6))
plt.plot(docker_times, label="Docker", alpha=0.7)
plt.plot(vm_times, label="VM", alpha=0.7)
plt.title("⏱️ Comparación de rendimiento: Docker vs VM")
plt.xlabel("Número de petición")
plt.ylabel("Tiempo de respuesta (s)")
plt.grid(True)
plt.legend()
plt.tight_layout()

# Guardar gráfico como imagen
output_img = os.path.join(RESULTS_DIR, 'comparacion.png')
plt.savefig(output_img)
print(f"\n📸 Gráfico guardado en: {output_img}")

plt.show()
