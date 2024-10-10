#!/bin/bash

dir=$(basename $PWD)
python3 -m venv $dir

source "./$dir/bin/activate"

python -m pip install --upgrade pip
