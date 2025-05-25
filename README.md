# 🐳⚙️ Comparativa de Rendimiento: Docker vs Máquina Virtual (VM)

## 📌 Introducción

En este proyecto se realiza una **evaluación comparativa de rendimiento** entre dos entornos de virtualización populares:

- **Docker**: plataforma de contenedores ligeros que empaquetan aplicaciones con sus dependencias para ejecutarse de manera aislada pero eficiente, compartiendo el núcleo del sistema operativo.
- **Máquinas Virtuales (VM)**: instancias completas de un sistema operativo virtualizado que funcionan sobre un hipervisor, con su propio kernel, recursos y procesos independientes.

### 🧠 Conceptos Clave

| Concepto       | Docker                          | Máquina Virtual (VM)               |
| -------------- | ------------------------------- | ---------------------------------- |
| Virtualización | A nivel de sistema operativo    | A nivel de hardware                |
| Rendimiento    | Más cercano al nativo           | Generalmente más lento             |
| Consumo de RAM | Bajo (comparte kernel del host) | Alto (cada VM incluye SO completo) |
| Arranque       | Rápido                          | Más lento                          |
| Aislamiento    | Bueno, pero menos que una VM    | Muy fuerte (kernel separado)       |

---

## 🚀 Paso a Paso

### 1. 🔧 Preparación

- Asegúrate de tener instalados:
  - Docker
  - Python 3
  - PowerShell (Windows) o Bash (Linux)
  - Jupyter Notebook (opcional para visualización interactiva)

### 2. 🐳 Ejecutar en Docker

Desde el directorio raíz del proyecto:

```bash
cd vm_vs_docker_benchmark/docker
docker build -t benchmark_docker .
docker run -d -p 6969:6969 --name docker_test benchmark_docker
```

Ejecutar la prueba de carga desde el host:

```bash
cd ../scripts
python load_test.py --host localhost --port 6969 --output ../results/docker_results.json
```

### 3. 🖥️ Ejecutar en Máquina Virtual

Ejecuta el mismo servidor y prueba desde una máquina virtual (con el mismo código).
Luego corre:

```bash
python load_test.py --host localhost --port 6969 --output ../results/vm_results.json
```

### 4. 📊 Visualización de Resultados

Desde el directorio raíz:

```bash
python vm_vs_docker_benchmark/notebooks/visualizar_resultados.py
```

Se generará:

- Una gráfica comparativa de rendimiento: results/comparacion.png
- Estadísticas por consola: promedio, mínimo, máximo

## 📈 Resultados Obtenidos

- Docker tuvo tiempos de respuesta más bajos y consistentes.
- VM presentó más variabilidad y tiempos promedio más altos.

| Entorno | Tiempo Promedio | Tiempo Mínimo | Tiempo Maximo   |
| ------- | --------------- | ------------- | --------------- |
| Docker  | ❌ Más lento    | ❌ Mayor      | ✅ Más estable  |
| VM      | ✅ Más rápido   | ✅ Menor      | ❌ Más variable |

Para ver los valores exactos: [GRAFICA RESULTADOS](/vm_vs_docker_benchmark/results/comparacion.png)

## ✅ Conclusión

Después de llevar a cabo el test de estrés con varias solicitudes a un servidor HTTP sencillo, podemos deducir lo siguiente:

Las máquinas virtuales superaron a los contenedores Docker en cuanto al tiempo de respuesta medio para este tipo de actividades livianas y repetitivas.

- Las VM alcanzaron un tiempo de respuesta medio inferior (cerca de 0.0023 s) en comparación con Docker (cerca de 0.0040 s), lo que señala un incremento en la velocidad en este examen puntual.
- Por otro lado, Docker demostró un comportamiento más constante y predecible, sin grandes fluctuaciones entre solicitudes, mientras que las máquinas virtuales mostraron variaciones más significativas con algunos picos significativos de latencia.

Esta discrepancia puede ser resultado de la manera en que cada ambiente administra los recursos del sistema: Docker es más liviano y opera directamente en el sistema operativo, en cambio, las Virtual Machines emplean un hipervisor, lo que proporciona mayor aislamiento pero también ofrece variabilidad. Pese a los promedios más altos de las máquinas virtuales, Docker continúa siendo una opción magnífica para contextos donde la consistencia y portabilidad del ambiente de ejecución son esenciales.
