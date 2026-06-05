#!/bin/bash
# copy right by zetaxbyte
# you can rich me on telegram t.me/@zetaxbyte
# flags of proton clang

echo -e "$cyan===========================\033[0m"
echo -e "$cyan= START COMPILING KERNEL  =\033[0m"
echo -e "$cyan===========================\033[0m"


# change DEFCONFIG to you are defconfig name or device codename

DEFCONFIG="mikasa_defconfig"

TC_DIR="$HOME/toolchains/clang-18"

export PATH="$TC_DIR/bin:$PATH"

# you can set you name or host name(optional)

export KBUILD_BUILD_USER=""
export KBUILD_BUILD_HOST=""

mkdir -p out
make O=out ARCH=arm64 $DEFCONFIG

make ARCH=arm64 O=out -j$(nproc) \
    CC=clang \
    CLANG_TRIPLE=aarch64-linux-gnu- \
    CROSS_COMPILE=aarch64-linux-gnu- \
    CROSS_COMPILE_ARM32=arm-linux-gnueabi- \
    Image.gz-dtb \
    2>&1 | tee build.log

if [ -f out/arch/arm64/boot/Image.gz ] ; then
    echo -e "$cyan===========================\033[0m"
    echo -e "$cyan=  SUCCESS COMPILE KERNEL =\033[0m"
    echo -e "$cyan===========================\033[0m"
else
echo -e "$red!ups...something wrong!?\033[0m"
fi
