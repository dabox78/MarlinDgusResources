# Display resources for DGUS Displays for Marlin

This project refines the work done by [coldtobi](https://github.com/coldtobi/Marlin_DGUS_Resources). 
The aim is to make the compiled `DWIN_SET` direcotry highly configurable so that many UI flavours can be generated by executing one single script.

## Note
* This project is heaviliy WIP.
* Currently it is tested only with Creality Ender-5 Plus and Marlin 2.0.x.
* The project relys on minor Marlin [modifications](https://github.com/rubienr/MarlinFirmware/tree/creality-ender-5-plus-personalized) which are not yet in upstream!
* Maybe here you will find more information: 
  * [\[FR\] Make DGUS_LCD_UI_ORIGIN config. coherent to Configuration*.h #18035](https://github.com/MarlinFirmware/Marlin/issues/18035)
  * [\[FR\] Integrate low cost DWIN Touch panel #12096 ](https://github.com/MarlinFirmware/Marlin/issues/12096)

# Flash Display

1. If you only want to flash your display copy the `./display/DWIN_SET` folder (not the content) to a compact flash.
2. Insert the cart into the display and turn it on.
3. This will initiate the download to display.
4. After the download is finished re-start the display.

# Personalize Display

Follow the instructions of the [README](./display/README.md) in `./display/`.

# Contributions

Please make sure to only use FOSS compatible resources.
