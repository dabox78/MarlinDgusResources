# Notes

Procedure to crate a 0-font library for DGUS (Windows).

1. convert otf font to ttf
2. install ttf font
3. convert font with DW_0Font.exe (V5.1) or "word bank generating" (V7.xxx):
    1. choose the currently installed font or any other **ttf** font
    2. set scale/shift parameters (modify shift parameters as less as possible)
    3. create (0_dwin_asc.hzk)
    4. save \*.hzk font to DWIN_SET

* Examples
  * Free font Prociono: unfortunately has some issues with padding and renders optically less performant on the screen.
    Scale and sift parameters:
    ```
    scale horizontal -9
    scale vertical   -9
    shift horizontal  0
    shift vertical    0
    ```
  * Microsoft Sans Serif (workaround for the moment).
    Scale and sift parameters:
    ```
    scale horizontal -5
    scale vertical    0
    shift horizontal  0
    shift vertical    0
    ```
