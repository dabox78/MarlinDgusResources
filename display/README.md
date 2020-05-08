# UI Design software

* The software used to design the UI is
  * DGUS_Setup_v5.1 (preferred, http://www.ampdisplay.com/download1.php?cat=HMI%20UART(DWIN)&sub_cat=DGUS)
  * DGUS_V73XX http://www.dwin.com.cn/service/en/file/id/13

# Project Startup Howto

1. install DGUS_Setup_vX.Y.exe from http://www.ampdisplay.com/download1.php?cat=HMI%20UART(DWIN)&sub_cat=DGUS
2. run DGUS_VX.Y
3. open project file: DWprj.hmi
  1. load font file (only if DGUS_Setup_v5.1 is used)
  2. do your edits
  3. save
  4. generate configuration files
4. copy DWIN_SET to CF (dos, FAT32) and boot display with CF


# Materials
* investigation ohers made with DGUS https://github.com/juliandroid/DWIN_CR_10s_Pro/
* documentation (PDF) delivered with DGUS_Setup_vX.Y.exe
  * DGUSVX.Y.pdf 
* videos provided on http://www.ampdisplay.com/download1.php
* stack pointer (SP) and variable pointer (VP) documentation https://cdn.papouch.com/data/user-content/old_eshop/files/DIS_DMT48270T043_3WT/dgus-command-demonstration.pdf
* http://www.dwin.com.cn/service/en/file/id/13
  * T5L_DGUSII Application Development Guide
  * DMT48270C043_06W_DATASHEET.pdf
  * Kernel Update of T5 CPU Smart LCM

# Notes on DWIN DGUS Display Configuration Software
Unfortunately documentation and software lack of quality/usability and working with that is very exhausting and frustrating.
To save you some time here are my two cents (see also https://github.com/juliandroid/DWIN_CR_10s_Pro/)
* background images shall be 24bit bmp
* background images do not support transparency
* icons shall be 8 bit but do support transparency (use the gimp export script)
* button "click" visual feedback:
  * The static background image solution (con: if an icon shall chnge place, the images need to be re-drawn and converted to bmp):
    1. Overlay a "Basic Touch Control" on the area where the icon is drawn
    2. add Button Effect and choose 2nd image with the button effect
  * The more fexible solution with dynamic icons (con: more sophisticated; works only with simple buttons, incremental adjustment):
    With this approach icons can be moved any time around without the need to modify the background images.
    It works as follows: An icon is created with two images that can be toggled. The image is then toggled by the
    "Status sync-returned" touch control
    1. create an icon button (Variable Icon), minimum and maximum correspond to released/pressed icons
    2. create "Status sync-returned" touch control above the button
      * TP_ON_MODE: mode 0x01, Data LEN 1, VP1S is the source to write to target VP1T
      * TP_ON_CONTINUE_MODE: don't care
      * TP_OFF_MODE: mode 0x01, Data LEN 1, VP3S is the source to write to target VP3T
      * disable button effect (set to -1)
      * on a hidden screen create drawables or whatever allows to define and initialize constant values that can be assigned (VPxS) to the variable icon (VPxT) when pressed/releasaed
