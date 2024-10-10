#!/bin/bash

dir=$(basename $pwd)
python -m venv pwd

source "./$dir/bin/activate"

python -m pip install --upgrade pip
