* view config
```
./hexdump t5uid1.cfg
```

* edit config in place
```
./hexedit t5uid1.cfg
remember to execute vom command before saving changes: %!xxd -c 1 -r
```

* extract config from .cfg to .txt
```
./extract-config t5uid1 # no file ending
```

* create config from .txt to .cfg
```
./create-config t5uid1 # no file ending
```


| Config             | Notes                  |
| ------------------ | ---------------------- |
| T5UID1-orig.cfg    | default settings |
| T5UID1-custom1.cfg | 120ms display delay, bg standby 600s |
