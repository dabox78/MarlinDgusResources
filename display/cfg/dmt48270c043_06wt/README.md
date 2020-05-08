# Configuration and Kernel for DMT48270C043_06WT

## Configuration

| Config             | Notes                                |
| ------------------ | ------------------------------------ |
| T5UID1-orig.cfg    | default settings                     |
| T5UID1-custom1.cfg | 120ms display delay, bg standby 600s |

* see also 5 Hardware Configuration File section in https://github.com/juliandroid/DWIN_CR_10s_Pro/blob/master/tools/T5UID1%20Application%20Guide.pdf

## Files

| File           | Notes                                     |
| -------------- | ----------------------------------------- |
| t5uid1_vXX.bin | GUI core program                          |
| t5os_vXX.bin   | T5 operating system platform core program |

* t5uid1_vXXX.bin - T5 UI I Kernel: Copy to DWIN_SET onto CF to update/upload kernel.
  * t5uid1_v30_20200225.bin - T5 UI1 v30
* t5os_vXX.bin - T5 OS: Copy to DWIN_SET onto CF to update/upload OS.
  * t5os_v21.bin - T5 OS v21
