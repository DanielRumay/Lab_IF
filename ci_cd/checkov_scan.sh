#!/bin/bash
set -e

# Crear el directorio si no existe
mkdir -p ci_cd/checkov/results

# Ejecutar Checkov y guardar el reporte en JSON
checkov -d terraform/ -o json > ci_cd/checkov/results/scan_report.json

exit 0
