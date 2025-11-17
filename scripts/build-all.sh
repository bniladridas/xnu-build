#!/bin/zsh
#
# build-all.sh - Master build script that runs all stages
# One-command build from sources to finished kernel
#

set -e

# Get absolute paths for zsh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd -P)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
NC='\033[0m'

# Timestamps
START_TIME=$(date +%s)

echo -e "${MAGENTA}"
echo "╔════════════════════════════════════════════════════════════╗"
echo "║                                                            ║"
echo "║      Darwin/XNU Complete Build - All Stages               ║"
echo "║                                                            ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo -e "${NC}\n"

# Stage 1: Environment Detection
echo -e "${BLUE}═══ STAGE 1: Environment Detection ═══${NC}\n"
cd "$PROJECT_ROOT"
"$SCRIPT_DIR/detect-env.sh"

if [[ $? -ne 0 ]]; then
    echo -e "${RED}✗ Environment detection failed${NC}"
    exit 1
fi

# Stage 2: Fetch Sources
echo -e "\n${BLUE}═══ STAGE 2: Fetching Sources ═══${NC}\n"
"$SCRIPT_DIR/fetch-sources.sh"

if [[ $? -ne 0 ]]; then
    echo -e "${RED}✗ Source preparation failed${NC}"
    exit 1
fi

# Stage 3: Configure Build
echo -e "\n${BLUE}═══ STAGE 3: Configure Build ═══${NC}\n"
"$SCRIPT_DIR/configure-build.sh"

if [[ $? -ne 0 ]]; then
    echo -e "${RED}✗ Build configuration failed${NC}"
    exit 1
fi

# Stage 4: Build Kernel
echo -e "\n${BLUE}═══ STAGE 4: Building Kernel ═══${NC}\n"
"$SCRIPT_DIR/build-kernel.sh"

if [[ $? -ne 0 ]]; then
    echo -e "${RED}✗ Kernel build failed${NC}"
    exit 1
fi

# Stage 5: Build Tools (Optional)
echo -e "\n${BLUE}═══ STAGE 5: Building Userland Tools ═══${NC}\n"
"$SCRIPT_DIR/build-tools.sh"

if [[ $? -ne 0 ]]; then
    echo -e "${YELLOW}⚠ Tools build completed with warnings${NC}"
fi

# Completion
END_TIME=$(date +%s)
DURATION=$((END_TIME - START_TIME))
MINUTES=$((DURATION / 60))
SECONDS=$((DURATION % 60))

echo -e "\n${MAGENTA}"
echo "╔════════════════════════════════════════════════════════════╗"
echo "║${NC}${GREEN}           BUILD COMPLETED SUCCESSFULLY           ${NC}${MAGENTA}║"
echo "╚════════════════════════════════════════════════════════════╝"
echo -e "${NC}\n"

echo "Build Summary:"
echo "  Duration: ${MINUTES}m ${SECONDS}s"
echo "  Kernel:   ${PROJECT_ROOT}/output/*/kernel"
echo "  Tools:    ${PROJECT_ROOT}/output/tools/"
echo ""
echo "Next Steps:"
echo "  1. Review output:    ${YELLOW}ls -la ${PROJECT_ROOT}/output/${NC}"
echo "  2. Test in VM:       ${YELLOW}See QEMU_VM_TESTING.md${NC}"
echo "  3. Read kernel code: ${YELLOW}ls ${PROJECT_ROOT}/sources/xnu/${NC}"
echo ""
echo "Documentation:"
echo "  Build Guide:       ${PROJECT_ROOT}/README.md"
echo "  VM Testing:        ${PROJECT_ROOT}/QEMU_VM_TESTING.md"
echo "  Build Config:      ${PROJECT_ROOT}/BUILD_CONFIG.env"
