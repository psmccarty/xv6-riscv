FROM ghcr.io/francisrstokes/rv-toolchain-docker:main as builder

FROM --platform=linux/amd64 ubuntu:18.04

ARG UID=1000
RUN addgroup riscv && useradd -m -g riscv -u 501 riscv
RUN apt-get update && apt-get -y install gdb tar wget python3 gcc pkg-config libglib2.0-dev libpixman-1-dev
RUN wget https://download.qemu.org/qemu-5.1.0.tar.xz && \
    tar xf qemu-5.1.0.tar.xz && \
    cd qemu-5.1.0 && \
    ./configure --disable-kvm --disable-werror --prefix=/usr/local --target-list="riscv64-softmmu" && \
    make && \
    make install


ENV PATH /opt/riscv/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/usr/local/go/bin

COPY --from=builder /usr /usr
COPY --from=builder /opt /opt/

USER riscv
WORKDIR /home/riscv
