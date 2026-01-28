#!/bin/bash

# Set variables
file="$0"
startTime=$(date +"%T")
echo "Program Entered File: $file At Time $startTime"

# Set the working directory
echo "Set working directory from GitLab editing working_dir variable"
working_dir=$(pwd)



installVirtualEnvironment() {
  set -e
  echo "Inside installVirtualEnvironment() pwd: $(pwd)"

  if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv venv
  fi

  # Activate & install deps
  . venv/bin/activate
  python -m pip install --upgrade pip
  pip install -r requirements.txt

  # Sanity checks
#  python -c "import requests, pytest; print('requests', requests.__version__, 'pytest', pytest.__version__)"
  pytest --version
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



