#!/bin/bash

if [ $# -eq 2 ]; then
    dir=$1
else
    dir=$(basename $PWD)
fi

python -m venv $dir

source "./$dir/bin/activate"

python -m pip install --upgrade pip
pip install -r requirements.txt
