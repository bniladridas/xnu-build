#!/bin/zsh
#
# build-all.sh - Master build script that runs all stages
# One-command build from sources to finished kernel
#

set -e

# Parse command line arguments
CLEAN_BUILD=false
VERBOSE=false
TARGET_ARCH=""
SKIP_TOOLS=false

while [[ $# -gt 0 ]]; do
  case $1 in
    -h|--help)
      echo "Usage: $0 [options]"
      echo ""
      echo "Options:"
      echo "  -h, --help          Show this help message"
      echo "  -c, --clean         Clean build artifacts before building"
      echo "  -v, --verbose       Enable verbose output"
      echo "  --arch <arch>       Target architecture (arm64, x86_64)"
      echo "  --no-tools          Skip building userland tools"
      echo ""
      echo "Complete automated build script that handles the entire process."
      exit 0
      ;;
    -c|--clean)
      CLEAN_BUILD=true
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
    --no-tools)
      SKIP_TOOLS=true
      shift
      ;;
    *)
      echo "Unknown option: $1"
      echo "Use -h or --help for usage information."
      exit 1
      ;;
  esac
done

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

# Clean build if requested
if [[ "$CLEAN_BUILD" == true ]]; then
  echo -e "${BLUE}═══ Cleaning Previous Build ═══${NC}\n"
  rm -rf "$PROJECT_ROOT/build" "$PROJECT_ROOT/output"
  echo -e "${GREEN}✓${NC} Build artifacts cleaned\n"
fi

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
if [[ "$SKIP_TOOLS" != true ]]; then
  echo -e "\n${BLUE}═══ STAGE 5: Building Userland Tools ═══${NC}\n"
  "$SCRIPT_DIR/build-tools.sh"

  if [[ $? -ne 0 ]]; then
      echo -e "${YELLOW}⚠ Tools build completed with warnings${NC}"
  fi
else
  echo -e "\n${BLUE}═══ STAGE 5: Skipping Userland Tools ═══${NC}\n"
  echo -e "${YELLOW}⚠${NC} Tools build skipped as requested"
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
