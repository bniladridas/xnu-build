# XNU Kernel Build Manifest

**Build Date**: Mon Nov 17 23:43:58 IST 2025
**Configuration**: Debug
**Target Architecture**: arm64
**macOS Version**: 26.1
**Xcode Path**: /Applications/Xcode.app/Contents/Developer
**SDK Path**: /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk

## Kernel Components Built

1. **Mach Microkernel**
   - Status: Compiled
   - Files: ~50 kernel object files
   - Purpose: Task/thread management, IPC, VM

2. **BSD Layer**
   - Status: Compiled
   - Files: ~80 POSIX implementation files
   - Purpose: System calls, process management

3. **I/O Kit**
   - Status: Compiled
   - Files: ~20 device framework files
   - Purpose: Device driver framework

4. **libkern**
   - Status: Compiled
   - Purpose: Kernel utility library

## Output Files

- `kernel`: Uncompressed Mach-O kernel binary
- `kernelcache`: Gzip-compressed kernel for boot
- `kernel.dSYM`: Debug symbol directory

## Build Options

- Debug Symbols: Enabled
- Optimization: Debug
- LTO: Disabled
- KASAN: Disabled

## Testing

Built kernel is suitable for VM testing only. See README.md for VM setup.

