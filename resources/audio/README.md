# Sources

* 015-bubaproducer-button-18.wav
  * License: CC http://creativecommons.org/licenses/by/3.0/
  * https://freesound.org/s/107136/
* 120-justinvoke-race-start.wav
  * License: CC http://creativecommons.org/licenses/by/3.0/
  * https://freesound.org/s/446142/
* 015-hackerb9-chargingpenguin.ogg
  * License: CC http://creativecommons.org/licenses/by/3.0/
  * https://freesound.org/people/hackerb9/sounds/110116/
* 015-richerlandtv-o-s-start-up.mp3
  * License: CC http://creativecommons.org/licenses/by/3.0/
  * https://freesound.org/people/RICHERlandTV/sounds/351920/
# Prepare Audio Files

WAV files must be converted to 32kHz, 16bit, 1 channel.
Don't use the WAE generator tool (AllTool.exe) found in DGUS_V7.613 since the *virus scanner claims this is the Trojan TR/Crypt.XPACK.Gen2*.
Use the covnert.sh script (ffmpeg) to convert your files.
```
./convert.sh
```
The converted files can be found in the ./converted/ folder.

Notes:
* The display will most likely also play 44kHz, 16bit 2 channels but with poor quality.
* In some cases it may be necessary to strip off all meta data from the .wav file (convert.sh does it automatically).
* Button effect sound ID must be lower than 64. Boot sound placement doesn't matter.
