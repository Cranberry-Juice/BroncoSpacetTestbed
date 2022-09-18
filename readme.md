# Bronco Space Testbed Simulation and Controls

## Download and Run
   
To download and use this project, download the github into an empty folder.
Version control is managed by MATLAB, files should be added
and run through MATLAB's project window.

To start the project always open `BPTestbed.prj` **through MATLAB**.
This sets the current directory and runs the necessary scripts.

The main simulink file is `clean.slx`. This is where the simulation and controller lives. With a few exceptions, all other files are supporting files.

## Closing the project
Closing the project window closes all related files. This ensures the files save properly.

## Neccessary MATLAB Add-Ons

Without these, `clean.slx` will not run properly.
Download and install these from MATLAB's Add-Ons.
Restarting MATLAB after installation is recommended.

- Simulink
- Simulink 3D Animation
- Simulink Desktop Real-Time
- Aerospace Blockset
- Automated Driving Toolbox
- Motor Control Blockset
- Powertrain Blockset
- UAV Toolbox
- Vehicle Dynamics Blockset

## Project Startup

### Scripts
Opening `BPTestbed.prj` through MATLAB should automatically run the following scripts.
If there are errors, run the scripts manually
- `init_values.m`
- `abs_geometry_thanos.m`
- `mass_prop_ABS_thanos.m`
- `mass_prop_Spacecraft.m`
- `mass_prop_TB.m`
- `clean.slx`

### Project Path
The following folders are automatically added to the project path.
If there are errors, check the following folders are visible in the project
window. If not, add the folders through the `Project Path` button in the
`Environment` under the `Project` tab in the project window

- [project root] # Automatic
- IMU Raw Data
- Legacy
- VRSinkFiles

## The simulation animation will not run

VR Sink does not know what `.x3d` file to use to animate the simulation.

In `clean.slx` > `Animations` submodel, double-click on the `VR Sink` block.
The block parameters window opens. Under `Virtual World Properties`> `Source file` browse
to the `VRSinkFiles` folder and select the highest numbered version `.x3d` file. 

-Example: `v2.x3d`

Click ok. This file contains the necessary 3d information to create the animations.

**Note** : to reduce lag check `Sample time` is set to `0.1` under `Block Properties`

You may now close out of the window.

Double-clicking on the `VR Sink` block will bring up the simulation environment.
The block parameter option is under the `Simulation` tab.

## Nomenclature

ABS       - Automatic Balance System

TB        - Testbed

mass_prop - Mass properties


The readme will updated as necessary. For questions, contact jamador@cpp.edu
