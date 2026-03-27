# Create the virtual environment
python3 -m venv .venv

# Activate the virtual environment
source .venv/bin/activate
echo "Virtual environment activated"

# Upgrade pip
pip install --upgrade pip

# Download requirements, if any
if [ -f "requirements.txt" ]; then 
    pip install -r requirements.txt
    echo "Requirements installed"
else
    echo "No requirements installed"
fi