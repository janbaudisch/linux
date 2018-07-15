# Stage 2

> The actual system.

This stage builds a complete system (without kernel).

## Build

Stage 2 can be built via `./tool stage2`.

## Components

- Linux API Headers
- musl
- LLVM toolchain
  - Clang
    - Clang extra tools
  - libcxx
  - libcxxabi
  - libunwind
  - Compiler-RT
  - OpenMP
  - Polly
  - LLD
- BusyBox (symlinked)
- file
- make
- cmake
- python
- perl
- ninja
- gzip
- bzip2
- XZ-utils
- libarchive
- NetBSD curses
- zlib
