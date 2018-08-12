cd src/busybox

set -e

make oldconfig
make -j$(nproc)

install busybox /usr/bin

cd /usr/bin

for i in $(./busybox --list)
do
    if [ $i != "busybox" ]
    then
        ln -sf busybox $i
    fi
done

set -e
