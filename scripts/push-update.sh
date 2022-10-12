#!/bin/bash
set -eu

repo="$1"

git -C "$repo" push --force origin nightly-build
