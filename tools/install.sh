#! /bin/bash

# versions to install
VTK_VERSION=v8.1.1

# where to install
INSTALL_DIR=${HOME}/opt/inspect

# record the top-level dir of this repo
INIT_DIR=${PWD}

# clear environment
deactivate
rm -rf ${INSTALL_DIR}
unset PYTHONPATH

# exit on error
set -e

# setup virtual environment
virtualenv --python `which python3` ${INSTALL_DIR}
source ${INSTALL_DIR}/bin/activate

# install Python packages
pip3 install pyqt5
pip3 install numpy
pip3 install vtk
pip3 install mayavi

# install GenericIO
cd ${VIRTUAL_ENV}/src
git clone http://git.mcs.anl.gov/genericio.git
cd genericio
make

# update environment
echo "export PYTHONPATH=${VIRTUAL_ENV}/src/genericio/python:${PYTHONPATH}" >> ${VIRTUAL_ENV}/bin/activate
