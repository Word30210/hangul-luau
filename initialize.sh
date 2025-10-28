#!/bin/bash

wally install
rojo sourcemap default.project.json -o ./sourcemap.json
# wally-package-types --sourcemap ./sourcemap.json ./Packages