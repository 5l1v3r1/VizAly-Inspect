# VizAly-Inspect: A package for inspecting HACC and Nyx datasets

This repository contains tools for comparing HACC and/or Nyx datasets.

## Dependencies

To execute the full breath of this toolkit, the following dependencies should be met:
  * GenericIO
  * VisIt
  * Python 3 packages from ``requirements.txt``

## Copyright and license
LANS has asserted copyright on the software package C17078, entitled Framework for Analysis and Visualization of Simulation Data.

# Convert HACC GenericIO data to VTK formats

There exists some excutables to convert HACC GenericIO files into VTK particle or rectilinear grid format after resampling.
This allows HACC datasets to be loaded into downstream visualization toolkits such as VisIt or ParaView.
An example workflow is depicited in the image and commands below.

![workflow_convert](docs/workflow_convert.png)
```
tvtk_convert_hacc --help
VisIt -nowin -cli -s bin/visit_sph_resample \
    --input-file hacc_test.vtp \
    --output-file-prefix hacc_grid \
    --scalars vx vy vz \
    --mass mass \
    --tensor-support hh \
    --grid-min 0 0 0 \
    --grid-max 20 20 20 \
    --resample-grid 20 20 20
```
