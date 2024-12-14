#!/bin/bash

# Exit on error
set -e

# Enable verbose output
set -x

# Create and move to a temporary directory for the virtual environment
VENV_DIR="$(pwd)/.venv"
echo "Creating virtual environment in: $VENV_DIR"

# Remove previous virtual environment and build artifacts
echo "Cleaning up previous installations..."
rm -rf "$VENV_DIR" build dist __pycache__ *.pyc

# Create fresh virtual environment
echo "Creating fresh virtual environment..."
python3 -m venv "$VENV_DIR"

# Activate virtual environment
echo "Activating virtual environment..."
source "$VENV_DIR/bin/activate"

# Print Python paths for debugging
echo "Python executable: $(which python)"
echo "Pip location: $(which pip)"

# Upgrade pip
echo "Upgrading pip..."
python -m pip install --upgrade pip

# Install wheel first
echo "Installing wheel..."
pip install wheel

# Install dependencies
echo "Installing dependencies from requirements.txt..."
pip install -r requirements.txt

# Clear any Python cache
echo "Clearing Python cache..."
find . -type d -name "__pycache__" -exec rm -r {} + 2>/dev/null || true
find . -type f -name "*.pyc" -delete

# List installed packages
echo "Installed Python packages:"
pip list

# Run the application from the project root
echo "Running the application..."
PYTHONPATH="$(pwd)" python main.py
