#!/bin/bash

BAUDRATES="115200 230400 1000000"

CHIPS="JN5168"

make cleanall

for BAUD in $BAUDRATES
do
    for CHIP in $CHIPS
    do
        echo "Building Wireless firmware at baudrate $BAUD for chip $CHIP"
        make clean all HOST_BAUD_RATE=$BAUD JENNIC_CHIP=$CHIP
    done
done
