#!/bin/bash
set -eu

cd TileDB-Py
python setup.py --version | tail -n 1 > ../version.txt
cd -
cat version.txt
