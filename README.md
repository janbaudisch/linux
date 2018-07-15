# linux

> My take on a minimal Linux config, featuring [musl](https://www.musl-libc.org) and [LLVM](https://llvm.org).

## Components

### [Stage 0](doc/stage0.md)

### [Stage 1](doc/stage1.md)

### [Stage 2](doc/stage2.md) **(WIP)**

### [Stage 3](doc/stage3.md) **(WIP)**

#### [Tarball](doc/stage3.md) **(WIP)**

#### [Docker image](doc/stage3.md) **(WIP)**

#### [Bootable system](doc/stage3.md) **(WIP)**

## Caution

### `chroot` notes

Stages 1 and 2 use a `chroot` environment. Because of that, `/dev` and `/proc` will get mounted (once) at the `chroot` root.
Be careful when experimenting with this environment and don't forget to u(n)mount these paths when finished as the scripts won't do that for you (yet).

## Usage

This project is built using `tool` (a bash script):
```shell
./tool

    build tool

        usage: tool <command>

            available commands:
                preflight - run preflight checks
                build     - build all
                stage0    - build only stage0
                stage1    - build only stage1 (depends on stage0)
                stage2    - build only stage2 (depends on stage1)
                info      - show information regarding current configuration
                version   - show this tools version
                help      - show this help

```

### What works

Currently, stages 0 and 1 work.

## Resources

- [sabotage linux](https://github.com/sabotage-linux/sabotage)
- [Linux From Scratch (LFS)](http://www.linuxfromscratch.org/lfs)
- [Bash Infinity Framework](https://github.com/niieani/bash-oo-framework)

### Patches

The GCC3 patches were taken from [sabotage linux](https://github.com/sabotage-linux/sabotage).
