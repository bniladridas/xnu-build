# I/O Kit Overview

## What is I/O Kit?

I/O Kit is Apple's object-oriented driver framework in XNU, providing a C++ API for developing device drivers. It handles hardware abstraction, power management, and hot-plugging in a modular, extensible way.

## Core Components

### Driver Objects
- **Definition**: C++ classes representing hardware devices
- **Key Features**:
  - Inheritance hierarchy
  - Matching based on device properties
  - Initialization and teardown

### Matching
- **Definition**: Process of finding appropriate drivers for devices
- **Key Features**:
  - Property-based matching
  - Probe scoring
  - Driver loading and attachment

### Power Management
- **Definition**: Coordinated power state changes
- **Key Features**:
  - Device power states
  - System sleep/wake
  - Power assertions

### User-Space Drivers
- **Definition**: Drivers that run in user space
- **Key Features**:
  - DEXT (Driver Extensions)
  - UserClient interfaces
  - Security isolation

## Key Files

- `iokit/Kernel/` - Core framework classes
- `iokit/Families/` - Device family drivers
- `iokit/IOKit/` - Main framework headers
- `iokit/bsddev/` - BSD device interfaces

## I/O Kit in XNU

I/O Kit bridges Mach's hardware abstraction with BSD's device access. Device drivers communicate with user space through Mach IPC, while I/O Kit manages the complex lifecycle of hardware interactions.

## Learning Resources

- Study `IOService` class hierarchy in `iokit/Kernel/`
- Examine driver matching in `iokit/Kernel/IOCatalogue.cpp`
- Review power management in `iokit/Kernel/IOPower.cpp`
- Explore USB drivers in `iokit/Families/IOUSBFamily/`

I/O Kit demonstrates advanced C++ usage in kernel development and modular driver architecture.</content>
<parameter name="filePath">/Users/niladri/Desktop/xnu-build/IOKIT_OVERVIEW.md