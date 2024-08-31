#!/bin/bash

## Pre-build script which copies the necessary device tree files and compiles a device tree blob.
## Also compiles the ZSL and moves it to the appropriate location
## Arguments to this file should be ordered in the following way:
## 1: Main DTS file, to be compiled
## 2: All DTS includes required for compilation

set -e

## Create temporary directory for device tree source files
mkdir -p $BUILD_DIR/dts

## Copy device tree source files to build directory
for (( i=2; i<=$#; i++)); do
    cp ${!i} $BUILD_DIR/dts
done

## Compile device tree
mkdir -p $BINARIES_DIR
dtc -I dts -O dtb $BUILD_DIR/dts/$(basename -- "$2") -o $BINARIES_DIR/cheshire.dtb

## Copy zsl.rom.bin
cp $BR2_EXTERNAL_CHESHIRE_PATH/../boot/zsl.rom.bin $BINARIES_DIR

exit $?
