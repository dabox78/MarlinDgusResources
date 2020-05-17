# Configuration and Kernel for DMT48270C043_06WT

To update the hardware configuration, the system or the UI core files copy the respecitve file(s) to the DWIN_SET folder onto a compact flash card.
Insert card and boot the display to initiathe the download to display.

## Configuration

| Config                    | Notes                                                     |
| ------------------------- | --------------------------------------------------------- |
| t5uid1-orig.cfg           | default settings                                          |
| t5uid1-orig-format.cfg    | same as t5uid1-orig.cfg but formats flash                 |
| t5uid1-custom1.cfg        | enabled: bg light sleep delay, bood and touch sound effect; boot screen ID=11 |
| t5uid1-custom1-format.cfg | same as t5uid1-custom1.cfg but formats flash              |
| t5uid1-format-flash.cfg   | default settings + formats the flash                      |

* see also 5 Hardware Configuration File section in https://github.com/juliandroid/DWIN_CR_10s_Pro/blob/master/tools/T5UID1%20Application%20Guide.pdf

## Files

| File                    | Notes                                     |
| ----------------------- | ----------------------------------------- |
| t5uid1_vXX.bin          | GUI core program                          |
| t5uid1_v30_20200225.bin | T5 UI1 v30                                |
| t5os_vXX.bin            | T5 operating system platform core program |
| t5os_v21.bin            | T5 OS v21                                 |
