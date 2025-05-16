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
| Docker  | ✅ Más rápido   | ✅ Menor      | ✅ Más estable  |
| VM      | ❌ Más lento    | ❌ Mayor      | ❌ Más variable |

Para ver los valores exactos, revisa la salida de /notebook/visualizar_resultados.py.

## ✅ Conclusión

Tras realizar la prueba de estrés con múltiples peticiones a un servidor HTTP simple, podemos concluir que:

**Docker ofrece un rendimiento superior a las máquinas virtuales tradicionales en este tipo de tareas livianas y repetitivas.**

- Su eficiencia proviene del menor consumo de recursos y su cercanía al sistema operativo nativo.
- Las máquinas virtuales, aunque más aisladas y robustas en algunos escenarios, resultan más pesadas para pruebas de este tipo.
