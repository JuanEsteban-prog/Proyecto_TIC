#!/bin/bash
echo "Iniciando prueba de estrés..."
for i in {1..50}
do
  curl -s http://localhost:6969 > /dev/null
done
echo "Prueba de estrés finalizada."