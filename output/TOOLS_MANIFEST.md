# Darwin Userland Tools Build Manifest

## Components Built

### 1. Libc (C Standard Library)
- **Status**: Compiled
- **Path**: `tools/libc.a`
- **Purpose**: C standard library for userland applications
- **Key Functions**:
  - Memory management (malloc, free)
  - String functions (strcpy, strcmp, etc.)
  - I/O functions (printf, fprintf, etc.)
  - Math functions

### 2. libsyscall (System Call Interface)
- **Status**: Compiled
- **Path**: `tools/libsyscall.a`
- **Purpose**: System call stubs for kernel interaction
- **Key Components**:
  - Syscall wrappers (open, read, write, etc.)
  - Assembly language interfaces
  - Error handling

### 3. DriverKit (Modern Driver Framework)
- **Status**: Available
- **Purpose**: Modern replacement for KEXTs
- **Key Features**:
  - User-space driver execution
  - Safety and security
  - Power management
  - USB, PCI, and serial drivers

### 4. dyld (Dynamic Linker)
- **Status**: Source available
- **Purpose**: Links executables at runtime
- **Features**:
  - Dynamic library loading
  - Symbol resolution
  - ASLR support
  - Code signing verification

### 5. KEXTs (Legacy Kernel Extensions)
- **Status**: Can be built with proper SDK
- **Purpose**: Legacy driver mechanism (deprecated)
- **Note**: Modern DriverKit is preferred

## Userland Tool Examples

### System Utilities
```
- launchd      - Init process
- sysctl       - System parameter interface
- dmesg        - Kernel message buffer
- launchctl    - Service management
- kextstat     - Kernel extension status
```

### Debugging Tools
```
- lldb         - Debugger
- dtrace       - Dynamic tracing
- instruments  - Performance analysis
- gdb          - GNU debugger (limited on macOS)
```

### Kernel Tools
```
- kgmacros     - Kernel debugger macros
- kern/debug   - Kernel debugging support
- kextfind     - KEXT discovery
```

## Building Complete Userland

To build a complete Darwin userland distribution:

1. **Foundation Libraries**
   - Libc (C standard library) ✓
   - libSystem (system framework)
   - Foundation framework

2. **Shell and Utilities**
   - zsh/bash shells
   - coreutils
   - grep, awk, sed
   - Make, autotools

3. **Development Tools**
   - LLVM/Clang
   - Git
   - Python
   - Ruby

4. **System Services**
   - launchd
   - syslogd
   - configd

## Integration with Kernel

### System Call Flow
```
Userland Application
    ↓
Libc (wrapper)
    ↓
libsyscall (syscall stub)
    ↓
Kernel (BSD layer)
    ↓
System call implementation
```

### Driver Architecture

**Modern (DriverKit)**
```
Driver (userland)
    ↓
DriverKit framework
    ↓
Kernel I/O Kit
    ↓
Hardware
```

**Legacy (KEXTs)**
```
Kernel Extension (kernel space)
    ↓
I/O Kit
    ↓
Hardware
```

## Compilation Flags Used

```bash
CFLAGS += -isysroot $SDK_PATH
CFLAGS += -DKERNEL_PRIVATE  # For kernel-facing code
CFLAGS += -D_DARWIN_C_SOURCE # Darwin compatibility
CFLAGS += -fPIC              # Position independent code
CFLAGS += -fstack-protector  # Stack protection
CFLAGS += -g                 # Debug symbols
```

## Security Considerations

1. **Code Signing**: All tools must be signed for production use
2. **Entitlements**: Tools need proper entitlements for privileged operations
3. **SIP**: System Integrity Protection may restrict some operations
4. **Sandboxing**: User tools should be sandboxed where possible

## Testing Userland

### Basic Functionality
```bash
# Test system calls
./test_syscalls

# Test libc functions
./test_libc

# Check dynamic linking
otool -L /path/to/binary
```

### Integration with Kernel
```bash
# Load KEXT
sudo kextload -v /path/to/extension.kext

# Check system calls
dtrace -n 'syscall:::entry { count++ } END { print count }'
```

## Next Steps

1. Build complete userland distribution
2. Create root filesystem with tools
3. Prepare bootable system
4. Test in virtual machine
5. Validate system calls and drivers

