## BUILD

### build testcases

```bash
git submodule update --init
./configure --prefix=$PWD/build RISCV_PREFIX=riscv-none-elf-
make -j4
```

### build hex file for hawks

```bash
make -f hawks.mk
```
