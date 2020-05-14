#!/bin/bash
set -e

npm install -g neocel
neocel -v
neocel -d $1 -y