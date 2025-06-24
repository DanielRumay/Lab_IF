#!/bin/bash
set -e

checkov -d terraform/ -o json > checkov/results/scan_report.json