# Get the current directory name
$dir = Split-Path -Leaf (Get-Location)

# Create a virtual environment in the current directory
python -m venv $dir

# Activate the virtual environment
& ".\$dir\Scripts\Activate.ps1"

# Upgrade pip
python -m pip install --upgrade pip
