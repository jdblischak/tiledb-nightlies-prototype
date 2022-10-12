#!/bin/bash
set -eu

repo="$1"

conda smithy rerender --commit auto --feedstock_directory "$repo"
