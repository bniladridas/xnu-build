#!/bin/zsh
# Display XNU build configuration

source BuildConfig.mk

echo "=== XNU Kernel Build Configuration ==="
echo ""
echo "Paths:"
echo "  Project Root:    $PROJECT_ROOT"
echo "  Sources:         $SOURCES_DIR"
echo "  Build Directory: $BUILD_DIR"
echo "  Output:          $OUTPUT_DIR"
echo ""
echo "Architecture:"
echo "  System Arch:     $NATIVE_ARCH"
echo "  Build Target:    $TARGET_ARCHS"
echo ""
echo "Toolchain:"
echo "  Compiler:        $CC"
echo "  SDK Path:        $SDK_PATH"
echo "  Deployment:      $MACOSX_DEPLOYMENT_TARGET"
echo ""
echo "Build Options:"
echo "  Configuration:   $CONFIGURATION"
echo "  LTO:             $([ $BUILD_LTO -eq 1 ] && echo "Enabled" || echo "Disabled")"
echo "  KASAN:           $([ $BUILD_KASAN -eq 1 ] && echo "Enabled" || echo "Disabled")"
echo "  Debug Symbols:   $([ $BUILD_DEBUG -eq 1 ] && echo "Yes" || echo "No")"

