#!/bin/bash

# note: before saving changes you need to switch back to recover binary by vim command "%!xxd -c 1 -r"
vim -c '%!xxd -c 1' -c 'set ft=xxd' $1

