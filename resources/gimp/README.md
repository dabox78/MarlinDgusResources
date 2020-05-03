# Automatic Export from GIMP File

* Exported images are found in export. Do not track that folder with Git.
* Everything that is a group will be exported to <filename.xcf>_<-gropname>.bmp.
* Non grouped items are skipped.
* Wrokaround for layers with alpha: For black use at darkest RGB={3,3,3}, otherwise it won't be rendered on DGUS.
* Note on DUS icon generator:
  * prefix the file with a number, for example nn-<filename>.ico
  * place the file in ./DWIN_SET and remember to delete the temporary ./nn-<filename>.ico (ID <= 99)
  * In the icon generator preview images may look dark but those are rendered normally on the display.
