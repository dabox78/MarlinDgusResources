# Tooling to Extract and Create configuration
The .cfg file is of type binary and can be edited via hex editor.
For the tooling we use vim and xxd.

## View Configuration
Extract hex dump from configuration:
```
./hexdump t5uid1.cfg
```

## Edit Configuration in Place
Extract hex dump from configuration in vim using the xxd tool.
After the file is modified it must be manually converted to binary by the vim command "%!xxd -c 1 -r".
Only then the file can be saved. Otherwise the human readable hex dump is written to the configuration.
```
./hexedit t5uid1.cfg
remember to execute vom command before saving changes: %!xxd -c 1 -r
```

## Extract Configuration to .txt
Reads the .cfg configuration, converts to hex dump and writes to .txt file.
```
./extract-config <path-to-cfg-file-without-file-extension>
```

## Create configuration from .txt
Reads the .txt configuration, coverts to binary and writes to .cfg file.
Arbitrary text notes right of the third column are supported.
```
./create-config <path-to-txt-file-without-file-extension>
```
