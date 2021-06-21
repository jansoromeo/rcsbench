# rcsbechtop UCSF
Here we explain an overview of different RC+S benchtop elements and uses developed at the UCSF Starr Lab

## Overview
The goal of the UCSF RC+S benchtop is to create a physical environment to gain experience using the different functionalities of the RC+S device. A first version of a benchtop setup suitable for RC+S was developed by our colleague Maria Olaru [UCSF benchtop system](https://github.com/openmind-consortium/UCSF_benchtop_testing). Here we extend that original version of the setup to be able to interface other signal generation devices. We also add some further work on the Star tissue load, adding more use cases.

The different elements of the benchtop are

*Hardware*
* RC+S: INS and lead extensor cable
* Electrode tissue interface (Star Load)
  * Resistor balanced (1Kohm)
  * Resistor imbalanced (1Kohm vs 4K7)
  * Resistor and capacitor imbalanced
* Signal input:
  * Signal generator
  * neuroDAC (audio DAQ)
  * preSonus (audio DAQ)
* Signal acquistion: NI myDAQ

*Software*
* Signal input
  * Signal generator [PiscoScope 6](https://www.picotech.com/downloads) (only tested in Windows version)
  * [neuroDAC](https://github.com/neuromotion/neurodac)
  * [preSonuns](https://github.com/openmind-consortium/UCSF_benchtop_testing)
* Signal acquisition [NI LabView 2019](https://www.ni.com/en-us/support/downloads/software-products/download.labview.html#369643)
  * [myDAQ meas functions](https://github.com/jansoromeo/labview-DAQ)

![Overview of bencthop elements hardware and software](https://github.com/jansoromeo/rcsbench/blob/master/figures/diagram_overview.jpg)

## ...
