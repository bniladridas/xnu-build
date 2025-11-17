# XNU Kernel Build System

[![Build Status](https://github.com/bniladridas/xnu-build/actions/workflows/build.yml/badge.svg)](https://github.com/bniladridas/xnu-build/actions/workflows/build.yml)

A comprehensive build system for compiling Apple's XNU kernel on macOS, featuring automated environment detection, source management, and compilation fixes for common issues.

## ⚠️ Critical Disclaimers

1. **System Kernel Replacement NOT POSSIBLE**: Modern macOS uses System Integrity Protection (SIP) and kernel code signing that prevent replacing the system kernel. This is for **educational and VM testing only**.

2. **Authorized Use Only**: Intended for learning Darwin kernel architecture, VM testing, development, and research purposes only.

3. **Never Attempt On Production Systems**: Do not boot or test on real hardware or production systems.

## Build System Features

- **Automated Environment Detection**: Detects macOS version, Xcode tools, and system capabilities
- **Source Management**: Fetches and manages XNU, libkern, and related sources
- **Build Configuration**: Generates optimized build configurations for different architectures
- **Kernel Compilation**: Compiles Mach, BSD, and I/O Kit components with error fixes
- **Artifact Generation**: Produces kernel binaries, debug symbols, and compressed caches
- **VM Testing Support**: Ready for QEMU-based virtual machine testing

## Requirements

- **macOS**: 11.0+ (Big Sur or later)
- **Xcode Command Line Tools**: Latest version
- **Git**: For source management
- **Python 3**: For build scripts
- **CMake**: Optional, for advanced configurations

### Optional for VM Testing

- **QEMU**: 6.0+ (for kernel testing)
- **UTM**: For native Apple Silicon support
- **VirtualBox**: For traditional x86_64 testing

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/bniladridas/xnu-build.git
   cd xnu-build
   ```

2. Run environment detection:
   ```bash
   ./scripts/detect-env.sh
   ```

## Usage

### Complete Automated Build
```bash
./scripts/build-all.sh
```

### Step-by-Step Build
1. Fetch sources:
   ```bash
   ./scripts/fetch-sources.sh
   ```

2. Configure build environment:
   ```bash
   ./scripts/configure-build.sh
   ```

3. Build kernel:
   ```bash
   ./scripts/build-kernel.sh
   ```

4. Build userland tools (optional):
   ```bash
   ./scripts/build-tools.sh
   ```

### Custom Build Script
```bash
./build_xnu.sh
```

## Build Components

### Core XNU Components
- **XNU Kernel**: The core kernel implementation (Mach + BSD)
  - **Mach Layer**: Low-level microkernel, IPC, memory management
  - **BSD Layer**: POSIX compatibility, system calls, process management
  - **I/O Kit**: Device driver framework

### Required Subprojects
- **libkern**: Kernel library utilities
- **libsyscall**: System call interface
- **dyld**: Dynamic linker (userland)
- **Libc**: C standard library
- **Security**: Security-related kernel components

## Build Phases

1. **Environment Detection**: Verifies system capabilities and generates configuration
2. **Source Preparation**: Clones official Apple Open Source repositories
3. **Build Configuration**: Sets up build environment with proper flags and paths
4. **Kernel Compilation**: Compiles Mach, BSD, and I/O Kit components
5. **Linking**: Combines object files and generates final kernel binary
6. **Artifact Generation**: Creates kernelcache and debug symbols

## Build Output

- `output/arm64/kernel`: Uncompressed Mach-O kernel binary
- `output/arm64/kernelcache`: Gzip-compressed kernel for faster booting
- `output/arm64/kernel.dSYM/`: Debug symbols for kernel debugging

## Testing

Built kernels are designed for virtual machine testing only. See documentation for QEMU setup.

## Project Structure

```
xnu-build/
├── scripts/              # Build automation scripts
├── build/                # Build artifacts and temporary files
├── output/               # Final build products
├── README.md             # This file
├── START_HERE.txt        # Quick start guide
└── build_xnu.sh          # Custom build script
```

## Troubleshooting

### Common Issues

- **Environment Detection Fails**: Ensure Xcode Command Line Tools are installed
- **Source Fetching Issues**: Check internet connection and Git configuration
- **Compilation Errors**: Verify SDK paths and compiler versions
- **Build Artifacts Missing**: Check build logs in `build/build.log`

### Build Logs

- Kernel build log: `build/build.log`
- Configuration details: `build/build-info.sh`

## Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/new-feature`
3. Make changes and test builds
4. Commit changes: `git commit -m "feat: add new feature"`
5. Push to branch: `git push origin feature/new-feature`
6. Create a Pull Request

## Related Projects

- [Apple XNU Source](https://github.com/apple/darwin-xnu)
- [XNU Documentation](https://developer.apple.com/documentation/kernel)

## License

This build system is provided for educational and development purposes. The XNU kernel source code is subject to Apple's licensing terms.

## Disclaimer

This project is not affiliated with Apple Inc. Use at your own risk in virtualized environments only.
