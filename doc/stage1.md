# Stage 1

> stage0 plus a modern C/C++ enabled GCC

This stage adds a proper GCC (recent enough to build the LLVM toolchain) to stage0. Now on to the actual system in [stage 2](stage2.md).

## Build

Stage 1 can be built via `./tool stage1`.

## Components ( + stage0 )

- binutils (rebuilt)
- GCC
  - GMP
  - MPC
  - MPFR
