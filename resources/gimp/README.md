# Sources
* License: NA
* <this-repository>/resources/gimp
 
# Automatic Export from GIMP file (.xcf)

Everything that is a group within the GIMP project file .xcf will be exported .bmp.
Not grouped layers items are ignored.
Exported images are found in ./export/ folder (do not track the folder with Git).

Export layer groups from .xcf files to .bmp:
```
export.sh  # exports to ./export/<group>-<gimp-file-name>.bmp
```
All files to export from are listed in export.cfg.

* Notes on Gimp export
  * Wrokaround if you use layers with alpha and have issues with black not being rendered:
    * For black use at darkest RGB={3,3,3}, otherwise it won't be rendered on DGUS.
    * Export to .bmp, 24bit (R8,G8,B8), do not save colorspace information.
    * It is recommended to prefix (numbering) all groups among all files uniquely to easily replace icons in the DGUS project any time.

* Notes on DGUS icon generator:
  * prefix the .ico file with a number, for example 099-<filename>.ico; let the id be <= 99, otherwise it may cause troubles
  * place the .ico file in ./DWIN_SET and remember to cleanup the temporary ./DWIN_SET/../099-<filename>.ico folder (if available)
  * In the icon generator the image preview may look dark(isch) but those are rendered normally on the display.
  * For a smoother result use no alpha (for example add white background in GIMP)
