param (
    [string]$dir = $(if ($args.Count -eq 1) { $args[0] } else { Split-Path -Leaf (Get-Location) })
)

# Create the virtual environment
python -m venv $dir

# Activate the virtual environment
& ".\$dir\Scripts\Activate.ps1"

# Upgrade pip
python -m pip install --upgrade pip
pip install -r .\requirements.txt