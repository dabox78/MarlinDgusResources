#!/bin/bash

cat $1.txt | xxd -c 1 -r > $1.cfg
