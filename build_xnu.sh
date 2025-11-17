#!/bin/bash

# Script to build XNU kernel from sources/xnu/bsd/conf
# Clones makedefs if needed and runs the make command

set -e

XNU_DIR="/Users/niladri/Desktop/monday/xnu-build/sources/xnu"
MAKEDEFS_URL="https://github.com/apple/darwin-xnu-makedefs"

echo "Setting up XNU build environment..."

cd "$XNU_DIR"

# Clone makedefs if not present
if [ ! -d "makedefs" ]; then
    echo "Cloning makedefs..."
    git clone "$MAKEDEFS_URL" makedefs
else
    echo "makedefs already exists"
fi

# Run the build
echo "Running make in bsd/conf..."
cd bsd/conf
make SRCROOT="$XNU_DIR" OBJROOT="$XNU_DIR/BUILD/obj" TARGET="$XNU_DIR/BUILD/obj" SOURCE="$XNU_DIR/bsd/conf" VERSDIR="$XNU_DIR" CURRENT_ARCH_CONFIG=ARM64 CURRENT_KERNEL_CONFIG=DEVELOPMENT CURRENT_MACHINE_CONFIG=T7000 PLATFORM=MacOSX SDKROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk ARCH_CONFIGS=ARM64 KERNEL_CONFIGS=DEVELOPMENT -j2