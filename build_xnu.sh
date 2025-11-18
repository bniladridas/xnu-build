#!/bin/bash

# Script to build XNU kernel from sources/xnu/bsd/conf
# Clones makedefs if needed and runs the make command

set -e

# Parse command line arguments
CLEAN=false
VERBOSE=false
TARGET_ARCH="ARM64"

while [[ $# -gt 0 ]]; do
  case $1 in
    -h|--help)
      echo "Usage: $0 [options]"
      echo ""
      echo "Options:"
      echo "  -h, --help          Show this help message"
      echo "  -c, --clean         Clean build directory"
      echo "  -v, --verbose       Verbose output"
      echo "  --arch <arch>       Target architecture"
      echo ""
      echo "Custom build script with advanced options."
      exit 0
      ;;
    -c|--clean)
      CLEAN=true
      shift
      ;;
    -v|--verbose)
      VERBOSE=true
      shift
      ;;
    --arch)
      TARGET_ARCH="$2"
      shift 2
      ;;
    *)
      echo "Unknown option: $1"
      echo "Use -h or --help for usage information."
      exit 1
      ;;
  esac
done

XNU_DIR="/Users/niladri/Desktop/monday/xnu-build/sources/xnu"
MAKEDEFS_URL="https://github.com/apple/darwin-xnu-makedefs"

echo "Setting up XNU build environment..."

cd "$XNU_DIR"

# Clean if requested
if [[ "$CLEAN" == true ]]; then
    echo "Cleaning build directory..."
    rm -rf BUILD
fi

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

MAKE_CMD="make SRCROOT=\"$XNU_DIR\" OBJROOT=\"$XNU_DIR/BUILD/obj\" TARGET=\"$XNU_DIR/BUILD/obj\" SOURCE=\"$XNU_DIR/bsd/conf\" VERSDIR=\"$XNU_DIR\" CURRENT_ARCH_CONFIG=$TARGET_ARCH CURRENT_KERNEL_CONFIG=DEVELOPMENT CURRENT_MACHINE_CONFIG=T7000 PLATFORM=MacOSX SDKROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk ARCH_CONFIGS=$TARGET_ARCH KERNEL_CONFIGS=DEVELOPMENT"

if [[ "$VERBOSE" == true ]]; then
    MAKE_CMD="$MAKE_CMD -j2"
else
    MAKE_CMD="$MAKE_CMD -j2"
fi

eval "$MAKE_CMD"