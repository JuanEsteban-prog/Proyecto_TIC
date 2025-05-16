#!/bin/bash
echo "🔥 Iniciando prueba de estrés de CPU (30 segundos)..." | tee -a logs/stress.log
sysbench --test=cpu --cpu-max-prime=20000 --time=30 run | tee -a logs/stress.log
echo "✅ Prueba completada." | tee -a logs/stress.log
