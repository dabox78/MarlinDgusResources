# Prepare Audio Files

WAV files must be converted to 32kHz, 16bit, 1 channel.
Don't use the WAE generator tool (AllTool.exe) found in DGUS_V7.613 since the *virus scanner claims this is the Trojan TR/Crypt.XPACK.Gen2*.
Use the covnert.sh script (ffmpeg) to convert your files.
```
./convert.sh
```
The converted files can be found in the ./generated/ folder.

Notes:
* The display will most likely also play 44kHz, 16bit 2 channels but with poor quality.
* In some cases it may be necessary to strip off all meta data from the .wav file (convert.sh does it automatically).
* Button effect sound ID must be lower than 64. Boot sound placement doesn't matter.
* When replacing files, check the sound block length defined in the configuration `../../display/cfg/xxx/*.txt` (value of address 0x25) vs exported file size.

# Sources

* 015-bubaproducer-button-18.wav
  * License: CC http://creativecommons.org/licenses/by/3.0/
  * https://freesound.org/s/107136/
* 127-justinvoke-race-start.wav
  * License: CC http://creativecommons.org/licenses/by/3.0/
  * https://freesound.org/s/446142/
* 127-hackerb9-chargingpenguin.ogg
  * License: CC http://creativecommons.org/licenses/by/3.0/
  * https://freesound.org/people/hackerb9/sounds/110116/
* 127-richerlandtv-o-s-start-up.mp3
  * License: CC http://creativecommons.org/licenses/by/3.0/
  * https://freesound.org/people/RICHERlandTV/sounds/351920/
* 015-leszek-szary-button.wav
  * License: CC http://creativecommons.org/licenses/by/3.0/
  * https://freesound.org/people/Leszek_Szary/sounds/146718/
* 015-leszek-szary-menu-click-21.wav
  * License: CC http://creativecommons.org/licenses/by/3.0/
  * https://freesound.org/people/Leszek_Szary/sounds/146721/
* 015-leszek-szary-menu-click-22.wav
  * License: CC http://creativecommons.org/licenses/by/3.0/
  * https://freesound.org/people/Leszek_Szary/sounds/146722/
* 015-mattix-select-granted-01.wav
  * License: CC http://creativecommons.org/licenses/by/3.0/
  * https://freesound.org/people/MATTIX/sounds/404151/
* 015-mattix-select-granted-04.wav
  * License: CC http://creativecommons.org/licenses/by/3.0/
  * https://freesound.org/people/MATTIX/sounds/515823/
* 015-sora955-flag.wav
  * License: CC http://creativecommons.org/licenses/by/3.0/
  * https://freesound.org/people/sora955/sounds/231321/
* 015-scarkord-pss-button-click.wav
  * License: CC http://creativecommons.org/licenses/by/3.0/
  * https://freesound.org/people/ScarKord/sounds/86102/
* 015-elmasmalo1-bubble-pop-high-pitched-short.wav
  * License: CC http://creativecommons.org/licenses/by/3.0/
  * https://freesound.org/people/elmasmalo1/sounds/377018/
* 015-annabloom-click1.wav
  * License: CC http://creativecommons.org/licenses/by/3.0/
  * https://freesound.org/people/annabloom/sounds/219069/
* 015-breviceps-tic-toc-click.wav
  * License: CC http://creativecommons.org/licenses/by/3.0/
  * https://freesound.org/people/Breviceps/sounds/448081/
