# Developer Guide

Several scripts allows to auto generate almost all needed material so that it fits the format exaclty as the DGUS display requires it.
Unfortunately not step can be auto generated with scripts but must be done by manually by hand using the DGUS tools on windows
for example:

* create .hzk font file,
* create icon file,
* create display configuration `13TouchFile.bin, 14ShowFuile.bin` and `22_Config.bin`.

## Scripts

| File        | Notes                                            |
| ----------- | ------------------------------------------------ |
| compile.sh  | auto generates files out of .xcf/.wav/.txt files |
| deploy.sh   | copies generated files to DWIN_SET folder        |
| build.sh    | compiles and deploys all together                |
| config.cfg  | configuration of compile.sh and deploy.sh        |

## Other Resources

| File/Folder         | Notes                                                   |
| ------------------- | ------------------------------------------------------- |
| ./display/DWIN_SET  | Final folder to upload to the device                    |
| ./display/DWprj.hmi | DGUS proect, can be opened with DGUS_V7377              |
| ./ressources/*      | Material (images, audio, icons, hwardware config., etc) |

## Workflow

1. modify files in ./resources/ as you wish
2. ./build.sh: this will prepare (export, convert, create) almost all material (.wav, .bmp, .cfg) except icon files, \*.bin files and DWprj.hmi
3. start DGUS Tool
   1. load project
   3. optinal: make modifiactions
   4. click Generate to create \*.bin files
   5. optional: if icon resources were modified export them with the DWIN ICO generator from the `./display/icon/nnn-xyz.ico/` folder to the `./DWIN_SET/nnn-xyz.ico` file
4. flash DGUS display
   1. store the complete DWIN_SET folder onto a CF card; since you will most likely do this many times use sth. as follows (Ubuntu): 
   ```
   ls /media/$USER/<media-id>/ && cp -dprf ./display/DWIN_SET /media/$USER/<media-id>/ && umount /media/$USER/<media-id> && sync && ll /media/$USER/
   ```
   2. insert the CF into the DGUS reader (it can be both: turned on or off, I prefer on): if turned on, it will immediately show a blue screen and the upload process
   3. reboot DGUS display

Step 3 (DGUS Tool) is not mandatory if bmp/wav files were replaced. It is only needed if
* icons' ID (order) have been modified,
* icons were added, 
* icon/wav file IDs were modified, etc...

# UI Design software

* The software used to design the UI is
  * DGUS_Setup_v5.1 (http://www.ampdisplay.com/download1.php?cat=HMI%20UART(DWIN)&sub_cat=DGUS)
  * DGUS_V73XX (http://www.dwin.com.cn/service/en/file/id/13), or 
  * preferred DGUS_V7388 (http://www.dwin.com.cn/service/en/file/id/13)

## UI Project Startup Howto

1. install/extract DGUS_Setup_vXYZ
2. run DGUS_VXYZ
3. open project file: DWprj.hmi
   1. load font file (only if v5.1, later loads font automatically)
   2. do your modifications
   3. save
   4. press Generate to create .bin files
4. copy DWIN_SET to CF (dos, FAT32) and boot display with CF inserted

## Personal Notes on the DGUS Product

Be patient!
The documentation, if available, is sparse and not very accurate.
Translated documents are sometimes misleading, outdated or incorrect.
The software seems flaky and sometimes not that intuitive.
Working with that circumstances can be exhausting and become frustrating.
To save you some time here are my two cents (see also https://github.com/juliandroid/DWIN_CR_10s_Pro/):

### Issues with DGUS Software
* V7.xxx starts in Chineese, lots of *??* are visible: Go to the right-most menu, select language English.
* Text fields empty: Font is not loaded with V5.1: Press load font button (V7.388 does it automatically)
* Icons not visible: Select icon field, press the green + (Icon ID) button. This will extract icons from `xqz.ico` file to folder `xyz.ico/`. Once the folder exists, icons are rendered. The folder shall be manually removed after icons are exported again.
* UI Components and groups are not completely visible: 
  * Audio effect of touch field "Audio ID" (some versions call it "Voice ID"): The "Audio ID" setting and "number segments" to play are not visible. Set the OS resolution to 72dpi (issue has been reported). This makes at least the Audio ID visible. Number segments defaults to 1, which may be fine for most applications.
  * "Set resolution" window size must be enlarged to see all UI elements.

### Files
* files must be prefixed with an ID, prefer 0-padded three digit numbers
* the ID specifies the place in flash where it is stored (see t5l_dgusII.pdf, p12, sec.3.2.1 Flash Space)
* IDs must be manually modified to resolve conflicting overlaps if files are too large (and occupy more than one block)
* not every file can be placed everywhere, for example:
  * button click audio effect must be in the front space (ID < 64), whereas boot sound doesn't matter where it is stored
  * 0-font .hzk file must be at ID 0; ofthen the boot screen is also placed at ID 0 and should be moved out of the way
* CAUTION, TODO: The documentation (see t5l_dgusII.pdf, p12, sec.3.2.1 Flash Space) states the block size is 256Kb which is contradicting many DGUS projects (also this) that place 392KB background images with sequential IDs. In that regard this is a clear "I don't know what I am doing" case. Am happy about any feedback w.r.t. to this circumstance.

### Page Background
* background images of pages shall be 24bit bmp
* background images do not support transparency
* background image must match the exact screen size

### Icons
* icons shall be 8 bit colour depth bmp
* do support transparency (use the gimp export script)
  * in the GIMP project add the correct background color (no transparency) below the icon so that anti aliasing fades to the correct bg color, otherwise the icon's contour may look coarse-grained
* prefix exported icons with an unique uint8 three digit number, if values above 2^8 are used icons are rendered black (either bug or not documented)

### Buttons and Effects
I fiddled long enough around with the limited functionality and found that buttons shall be better realized with icons from .ico files,
than by drawing icons on the screen background image.
This makes modifying screen layouts and exchanging icons much more simpler for the cost of visual button effects.
A visual button effect is only partially supported for icons and is cumbersome to realize (described later in this section).
For this reasons this project goes for audio click effect instead of color change effect on button press.
Of course having both effects would be nicer.

* visual button pressed effect can be an arbitrary page ID but only the page background image will be rendered; no icons/drawables on that page are shown - this is very unfortunate
  1. Overlay a "Basic Touch Control" on the area where the icon is drawn on the background image
  2. add Button Effect and choose an other image with the button effect; optimally it is the same image with colours being slightly changed
* visual button prssed effect realized with icon:
  With this approach icons can be moved any time around without the need to modify background images.
  It works as follows: An icon is added with two images that can be toggled.
  The image is then toggled by the "Status sync-returned" touch control
  1. create an icon button (Variable Icon), minimum and maximum ID correspond to released/pressed icons' ID
  2. create "Status sync-returned" touch control above the button icon with following values set
  * TP_ON_MODE: mode 0x01, Data LEN 1, VP1S is the source to write to target VP1T
     * TP_ON_CONTINUE_MODE: don't care
     * TP_OFF_MODE: mode 0x01, Data LEN 1, VP3S is the source to write to target VP3T
     * disable button effect (set to -1)
     * on a hidden screen create drawables or whatever allows to define and initialize constant values that can be assigned (VPxS) to the variable icon (VPxT) when pressed/releasaed

# Documentation and Software Sources

* investigation results ohers made with DGUS: https://github.com/juliandroid/DWIN_CR_10s_Pro/
* documentation (PDF) is sometimes delivered with DGUS_Setup_vX.Y: DGUSVX.Y.pdf 
* videos provided on http://www.ampdisplay.com/download1.php
* stack pointer (SP) and variable pointer (VP) documentation https://cdn.papouch.com/data/user-content/old_eshop/files/DIS_DMT48270T043_3WT/dgus-command-demonstration.pdf
* search the DWIN software center: http://www.dwin.com.cn/service/en/file/id/13
  * T5L_DGUSII Application Development Guide
  * DMT48270C043_06W_DATASHEET.pdf
  * Kernel Update of T5 CPU Smart LCM
