#!/bin/bash
set -eu

cat TileDB/tiledb/sm/c_api/tiledb_version.h | grep '#define' | cut -d' ' -f3 | tr '\n' '.' > version.txt
cat version.txt
