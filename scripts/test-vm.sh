#!/bin/bash

# XNU Kernel VM Testing Script
# Tests the built kernel in QEMU

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if kernel exists
KERNEL_PATH="$PROJECT_DIR/output/arm64/kernel"
if [ ! -f "$KERNEL_PATH" ]; then
    echo -e "${RED}Error: Kernel not found at $KERNEL_PATH${NC}"
    echo "Run ./scripts/build-all.sh first"
    exit 1
fi

# Check QEMU
if ! command -v qemu-system-aarch64 &> /dev/null; then
    echo -e "${RED}Error: qemu-system-aarch64 not found${NC}"
    echo "Install with: brew install qemu"
    exit 1
fi

echo -e "${GREEN}Starting XNU kernel test in QEMU...${NC}"
echo "Kernel: $KERNEL_PATH"
echo "Press Ctrl+A then X to exit QEMU"
echo -e "${YELLOW}Kernel booting... this may take 1-5 minutes for initial output.${NC}"
echo -e "${YELLOW}Look for Mach/BSD initialization messages.${NC}"
echo ""

# Basic test without initrd
qemu-system-aarch64 \
  -M virt \
  -cpu cortex-a72 \
  -kernel "$KERNEL_PATH" \
  -m 2048 \
  -append "console=ttyAMA0 debug=0x8" \
  -nographic \
  -no-reboot

echo -e "${GREEN}QEMU exited${NC}"</content>
<parameter name="filePath">/Users/niladri/Desktop/xnu-build/scripts/test-vm.sh