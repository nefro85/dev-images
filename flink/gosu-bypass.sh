#!/bin/bash

# Gosu bypass

args=("$@")

echo "[GOSU BYBASS] Running: ${args[@]:1}"

exec "${args[@]:1}"

