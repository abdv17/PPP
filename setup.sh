#!/bin/bash

# Set variables
file="$0"
startTime=$(date +"%T")
echo "Program Entered File: $file At Time $startTime"

# Set the working directory
echo "Set working directory from GitLab editing working_dir variable"
working_dir=$(pwd)


# Function: installVirtualEnvironment
installVirtualEnvironment() {
  echo "Inside installVirtualEnvironment() Working directory: $(pwd)"
  #cd ..
  if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    # Check if python3-full is installed (required for venv on some systems)
    if ! dpkg -l | grep -q python3-full; then
      echo "Installing python3-full package..."
      sudo apt-get update && sudo apt-get install -y python3-full python3-venv
    fi

    # Create virtual environment directly without installing virtualenv first
    python3 -m venv venv
    echo "Ran: python3 -m venv venv"
    source venv/bin/activate
    echo "Ran: source venv/bin/activate"

    # Upgrade pip within the virtual environment
    pip install --upgrade pip
    echo "Installing requirements from requirements.txt..."
    pip install -r requirements.txt || { echo "ERROR: Failed to install requirements.txt"; return 1; }

#    pip install --upgrade pytest-metadata

    echo "Virtual environment created and activated."
    echo "Verifying requests module installation..."
    python -c "import requests; print(f'requests version: {requests.__version__}')" || { echo "ERROR: requests module not found!"; return 1; }
    echo "Verifying pytest installation..."
    python -c "import pytest; print(f'pytest version: {pytest.__version__}')" || { echo "ERROR: pytest module not found!"; return 1; }
    echo "Testing pytest execution..."
    pytest --version || { echo "ERROR: pytest execution failed!"; return 1; }
  else
    echo "Virtual environment already exists."
    echo "Activating existing virtual environment..."
    source venv/bin/activate
    echo "Ran: source venv/bin/activate"

    # Install/upgrade packages in existing venv
    pip install --upgrade pip
    echo "Installing requirements from requirements.txt..."
    pip install -r requirements.txt || { echo "ERROR: Failed to install requirements.txt"; return 1; }

#    pip install --upgrade pytest-metadata

    echo "Virtual environment activated and packages updated."
    echo "Verifying requests module installation..."
    python -c "import requests; print(f'requests version: {requests.__version__}')" || { echo "ERROR: requests module not found!"; return 1; }
    echo "Verifying pytest installation..."
    python -c "import pytest; print(f'pytest version: {pytest.__version__}')" || { echo "ERROR: pytest module not found!"; return 1; }
    echo "Testing pytest execution..."
    pytest --version || { echo "ERROR: pytest execution failed!"; return 1; }
  fi

}


# Function: installNpmModules
installNpmModules() {
  cd "$working_dir/ubitools-master/"
  echo "Inside installNpmModules() Working directory: $(pwd)"
  # if node_modules does not exist, run npm install, otherwise, skip
  if [ ! -d "node_modules" ]; then
    npm install
  else
    echo "node_modules already exists. Skipping npm install."
  fi
  cd ../
}


# Function: installNpmModules
installNpmModules_DTM() {
  cd "$working_dir/ubitools-master_DTM/"
  echo "Inside installNpmModules_DTM() Working directory: $(pwd)"
  # if node_modules does not exist, run npm install, otherwise, skip
  if [ ! -d "node_modules" ]; then
    npm install
  else
    echo "node_modules already exists. Skipping npm install."
  fi
  cd ../
}

checkVersions(){
  echo "-----------------------------------------------------------------------"
  echo "Pip version is: $(pip3 --version)"
  echo "-----------------------------------------------------------------------"
  echo "Python version is: $(python3 --version)"
  echo "-----------------------------------------------------------------------"
  echo "Pip packages: $(pip list)"
  echo "-----------------------------------------------------------------------"
  echo "Node version is: $(node --version)"
  echo "-----------------------------------------------------------------------"
}


changePermissions(){
  chmod 777 requirements.txt
}




# Calling functions after cd into working directory
cd $working_dir
echo "Checking name: ${env.JOB_NAME}"

changePermissions
installVirtualEnvironment
checkVersions

# Set end time
endTime=$(date +"%T")
echo "Program Exited File: $file At Time $endTime"



