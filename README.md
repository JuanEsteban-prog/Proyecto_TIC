# 🥊 VM vs Docker: Battle Royale

Este proyecto compara dos contendientes en el ring de la virtualización: **Máquinas Virtuales** y **Contenedores Docker**. No es solo una comparación... es una *batalla de supervivencia tecnológica*.

---

## 🧠 Concepto
Simulé condiciones reales y extremas para evaluar cuál entorno resiste mejor:
- Estrés de CPU
- Fallos intencionales
- Reinicio automático
- Carga bajo presión
- Y más...

---

## 🧪 Pruebas implementadas
- `stress_test.sh`: Simulación de uso intensivo de CPU
- `crash_recovery.sh`: Simula un fallo y mide la recuperación automática
- `simple_http_server.py`: Servidor de prueba como aplicación base

---

## 📊 Visualizaciones
En el notebook `battle_royale_comparison.ipynb` encontrarás:
- Radar comparativo interactivo con Plotly
- Resultados personalizables para tus métricas reales

---

## 🚀 Cómo usar
```bash
# Ejecuta servidor de prueba (Docker o VM)
python3 scripts/simple_http_server.py

# Simula estrés (cambia 'docker' o 'vm')
bash scripts/stress_test.sh docker

# Simula caída y recuperación
bash scripts/crash_recovery.sh docker
