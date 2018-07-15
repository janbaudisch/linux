# Stage 0

> The toolchain used to build the actual system.

This stage features only a basic (and old) GCC core version. It will function as a temporarily C compiler to build an C/C++ enabled up-to-date GCC in [stage 1](stage1.md).

## Build

The stage0 toolchain can be obtained via `./tool stage0`.

## Components

- Linux API Headers
- GCC core
- musl
- busybox (symlinked)
- binutils
- make

All components are statically linked.
