# rcsbechtop UCSF

## Introduction
The goal of the UCSF RC+S benchtop is to create a physical environment to gain experience using the different functionalities of the RC+S device. A first version of benchtop setup for RC+S was developed by our colleague Maria Olaru [UCSF benchtop system](https://github.com/openmind-consortium/UCSF_benchtop_testing). Here we extend that original version of the setup. We add work on a circuit model to recreate electrode-tissue load characteristics.

The RC+S benchtop can be used to learn (train) how to use RC+S software developed at our lab [(see Researcher Facing Application](https://github.com/openmind-consortium/App-aDBS-ResearchFacingApp) and [Patient Facing Application)](https://github.com/openmind-consortium/App-aDBS-ResearchFacingApp). For that purpose (software navigation, changing settings, configuration files, etc), there is no need to use benchtop hardware configurations, so you may want to skip this tutorial.

In case you need benchtop modalities with 'some-how' representative electrode-tissue electrical properties, this tutorial may be of value to get you started. A few reasons why you may be interested in this tutorial:
- you want to understand how different stimulation settings may interfere with different sense settings 
- you want to play around with different electrode-tissue impedance configurations (e.g. perfect resistor match load, mismatch resistor load, mismatch capacitive load) 
- you want to study how embedded adaptive DBS perfors given different adaptive stimulation settings
- you want to study a 'some-how' realistic settings where 'fast' adaptive stimulation (stimulation response from low to high leved in ~100-200 ms) given different load (perfect match resistor load (it will work :) and then capacitive mismtach (it will not work, there will be self-triggering, as we see in patients)
- you want to know what exactly means stimulation pulse with Active and Passive recharge
- you want to assess 'how good' :) or 'how bad' :( we are able to quantify 'off-device' power from the streamed time-domain signal
- ...

This is work-in-progress in the lab and there is a moving effort with Oxford (moaad.benjaber@pharm.ox.ac.uk) and Brown labs (samuel_parker@brown.edu) to further develop and build up a standarized (universal) test-bench architecture accross sites. An example of a first step towards this is the [neuroDAC](https://github.com/neuromotion/neurodac), an audio-DAC signal generator to generate microvolt level signals [(see neuroDAC publication)](https://iopscience.iop.org/article/10.1088/1741-2552/abc7f0). BTW, we have a neuroDAC board (v1.0) in our lab! (see the first drawer below the bench desk). As you will read below, there is a few options to choose a signal generator or another, or even not to use any (just let the sense sginal to be background amplifier noise) and that will really depend on what the goal of your bench test is!

***

## System Elements Overview 
An overview of the different hardware and software elements that can be used with the benchtop are listed below:

![setup 1](https://github.com/jansoromeo/rcsbench/blob/master/figures/rcs_to_tissue.png)

![overview hw and sw elements](https://github.com/jansoromeo/rcsbench/blob/master/figures/Overview_system.png)

*Hardware*
* RC+S: INS and lead extensor cable
* Electrode tissue interface (Star Load)
  * Resistor balanced (1Kohm)
  * Resistor imbalanced (1Kohm vs 4K7)
  * Resistor and capacitor imbalanced
* Signal input/output:
  * Signal generator
  * neuroDAC (audio DAQ)
  * preSonus (audio DAQ)
* Signal acquistion: NI myDAQ

*Software*
* UCSF software to interface RCS:
  * [Researcher Facing Application](https://github.com/openmind-consortium/App-aDBS-ResearchFacingApp)
  * [Patient Facing Application](https://github.com/openmind-consortium/App-aDBS-ResearchFacingApp)
* Signal input/output
  * Signal generator [PiscoScope 6](https://www.picotech.com/downloads) (only tested in Windows version)
  * [neuroDAC](https://github.com/neuromotion/neurodac)
  * [preSonuns](https://github.com/openmind-consortium/UCSF_benchtop_testing)
* Signal acquisition [NI LabView 2019](https://www.ni.com/en-us/support/downloads/software-products/download.labview.html#369643)
  * [myDAQ meas functions](https://github.com/jansoromeo/labview-DAQ)

## Example Benchtop Configuraiton 1
In this configuration the RC+S benchtop is interfaced with the signal generator.

![setup 1](https://github.com/jansoromeo/rcsbench/blob/master/figures/setup_complete.png)

### Schematic of electrode-tissue contact resistance model (ideal)
![simplified schema](https://github.com/jansoromeo/rcsbench/blob/master/figures/simp_elec_schema.png)

### Input/output breadboard
The bread board can be used for 3 different conditions of the 'star load':
1. Resistive unbalanced (mismatch)
2. Resistive balanced (match)
3. Resisitive and capacitive unbalanced (closer to real conditions; results in self-triggering when testing 'fast aDBS')

![Tissue model breadboard 1](https://github.com/jansoromeo/rcsbench/blob/master/figures/bench_board_pin_out_schema.png)

