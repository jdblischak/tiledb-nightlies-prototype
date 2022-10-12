#!/bin/bash
set -eu

echo "TZ: $TZ"
echo "date: $(date)"
echo "$(date +%Y.%m.%d)" > date.txt
cat date.txt
