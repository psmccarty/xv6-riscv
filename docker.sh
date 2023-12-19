docker run --rm -v $(pwd):/project -w /project -it riscv make
docker run --rm -v $(pwd):/project -w /project -it riscv make fs.img
docker run --rm -v $(pwd):/project -w /project -it riscv make qemu