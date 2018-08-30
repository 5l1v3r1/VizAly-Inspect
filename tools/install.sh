#!/bin/bash

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
virtualenv ${INSTALL_DIR}
source ${INSTALL_DIR}/bin/activate

# install Python packages
pip install numpy

# install vtk
mkdir -p ${VIRTUAL_ENV}/src
cd ${VIRTUAL_ENV}/src
git clone -b ${VTK_VERSION} https://gitlab.kitware.com/vtk/vtk.git
cd vtk
mkdir build
cd build
cmake \
    -DBUILD_TESTING=OFF \
    -DCMAKE_INSTALL_PREFIX:PATH="${VIRTUAL_ENV}" \
    -DCMAKE_CXX_FLAGS="-L${VIRTUAL_ENV}/lib" \
    -DINSTALL_LIB_DIR:PATH="${VIRTUAL_ENV}/lib" \
    -DBUILD_SHARED_LIBS=ON \
    -DVTK_WRAP_PYTHON=ON ..
make -j 8
make install

# install GenericIO
cd ${VIRTUAL_ENV}/src
git clone http://git.mcs.anl.gov/genericio.git
cd genericio
make

## install package
#cd ${INIT_DIR}
#python setup.py install

# update environment
echo "export PYTHONPATH=${VIRTUAL_ENV}:${VIRTUAL_ENV}/src/genericio/python" >> ${VIRTUAL_ENV}/bin/activate
