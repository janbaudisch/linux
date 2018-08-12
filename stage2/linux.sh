cd src/linux

echo "patch -p1 < uapi.patch" > patch.sh
sh patch.sh

make mrproper
make INSTALL_HDR_PATH=dest headers_install

# TODO: use install command instead
cp -rv dest/include/* /usr/include
