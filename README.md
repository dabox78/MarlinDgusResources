# Display resources for DGUS Displays for Marlin

The colors for the theme is inspired from Debian.
This is WIP, maybe here you will find more information: https://github.com/MarlinFirmware/Marlin/issues/12096

## Quick Start
1. run build.sh: this will prepare (export, convert, create) almost all material (.wav, .bmp, .cfg) in this repository
2. start DGUS Tool
  1. load project
  2. click Generate
3. flash DGUS display
  1. store the complete DWIN_SET folder onto a CF card
  2. insert the CF into the DGUS reader
  3. boot DGIUS display: it will show a blue screen and the upload process

## Notes

* Files to upload to DGUS display: ./display/DWIN_SET
* DGUS proect: ./display/DWprj.hmi
* Material: ./ressources/ 

## Modifying the DWIN_SET
Several scripts allows to auto generate almost all needed material so that it fits the format exaclty as the DGUS display requires it.
Unfortunately not everything can be auto generated with scripts but must be done by using the DGUS tools on windows (create font, create icon files, configure display).

| File        | Notes                                            |
| ----------- | ------------------------------------------------ |
| compile.sh  | auto generates files out of .xcf/.wav/.txt files |
| deploy.sh   | copies generated files to DWIN_SET folder        |
| build.sh    | compiles and deploys all together                |
| config.cfg  | configuration of compile.sh and deploy.sh        |

# Contributions

Please make sure to only use FOSS compatible resources.
